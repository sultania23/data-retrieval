
class PagesController < ApplicationController


  def show
  	#call wikipedia api 
  	@value = Wikipedia.find('cows')
  	@message = @value.raw_data

    #call youtube api and retrieve data in json
  	client = Google::APIClient.new(
  		  :authorization => nil,
  		  :key => "it is secret",
  		  :application_name => "chatapp",
          :application_version => '0.0.1'
  		)
  	youtube = client.discovered_api('youtube', 'v3')


  	 opts = Trollop::options do
    opt :q, 'Search term', :type => String, :default => 'Google'
    opt :max_results, 'Max results', :type => :int, :default => 25
  end




  	@result = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => opts[:q],
        :maxResults => opts[:max_results]
      }
    )
  	@result = JSON.parse(@result.data.to_json)
  end
end
