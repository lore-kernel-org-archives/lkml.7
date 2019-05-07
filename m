Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53BF20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557240268;
	bh=0W1yM9geat5kuAiGw18h2JraRwtDSgajf7xSTsud+e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=epsbzc8YIMC/RgzNX8SZyLChGuv5qU2JFzE5OBW2pQrBmqh3O/x5MrFa3YGB+cvL/
	 N7ZgyxJWqz+TumBkOuboesqXK2soE/Z6rT4tREwRryP+fJXFF2vsLy1KRKRM3eRD4M
	 anenrmYw2NdGROWASd3P/t5Tgw0/Z1uO7+ADBrGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEGOo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGOo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:44:26 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6078820825;
        Tue,  7 May 2019 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557240265;
        bh=0W1yM9geat5kuAiGw18h2JraRwtDSgajf7xSTsud+e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGof6q/r3n4HFbGQzUI71l/eroQFMiyJk8yQYMEx0gq6Q2J3/D6yT+goXIzMxm33S
         Shbjr5Jyeps3k8UGTBMi2MGWQODsdD9pkbzOz3KrHxY3/ZGbiFHSwk7BKoQtirJp1m
         l8jCLNOs+tyi1pDp0/pkLUXsYSB11dn8adYk0nPs=
Date:   Tue, 7 May 2019 20:14:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 7/8] soundwire: fix master properties
Message-ID: <20190507144411.GQ16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504002926.28815-8-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
> The master-count is only defined for a controller or a Slave in the
> MIPI DisCo for SoundWire document.

... so remove it

> rename all fields with 'freq' as 'clk_freq' to follow the MIPI
> specification and avoid confusion between bus clock and audio clocks.

That sounds good to me.

> fix support for clock_stop_mode0 and 1. The existing code uses a
> bitmask between enums, one of which being zero. Or'ing with zero is
> not very useful in general...Fix by or-ing with a BIT dependent on the
> enum value.
> 
> Fix additional comments to align with MIPI spec

Ideally these should be different patches...


> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c        |  4 ++--
>  drivers/soundwire/intel.c      | 11 ++++++-----
>  drivers/soundwire/mipi_disco.c | 27 ++++++++++++++-------------
>  drivers/soundwire/stream.c     |  2 +-
>  include/linux/soundwire/sdw.h  | 20 +++++++++-----------
>  5 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index aac35fc3cf22..96e42df8f458 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -87,7 +87,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  
>  	/*
>  	 * Initialize clock values based on Master properties. The max
> -	 * frequency is read from max_freq property. Current assumption
> +	 * frequency is read from max_clk_freq property. Current assumption
>  	 * is that the bus will start at highest clock frequency when
>  	 * powered on.
>  	 *
> @@ -95,7 +95,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  	 * to start with bank 0 (Table 40 of Spec)
>  	 */
>  	prop = &bus->prop;
> -	bus->params.max_dr_freq = prop->max_freq * SDW_DOUBLE_RATE_FACTOR;
> +	bus->params.max_dr_freq = prop->max_clk_freq * SDW_DOUBLE_RATE_FACTOR;
>  	bus->params.curr_dr_freq = bus->params.max_dr_freq;
>  	bus->params.curr_bank = SDW_BANK0;
>  	bus->params.next_bank = SDW_BANK1;
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 31336b0271b0..4ac141730b13 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -796,13 +796,14 @@ static int intel_prop_read(struct sdw_bus *bus)
>  	sdw_master_read_prop(bus);
>  
>  	/* BIOS is not giving some values correctly. So, lets override them */
> -	bus->prop.num_freq = 1;
> -	bus->prop.freq = devm_kcalloc(bus->dev, bus->prop.num_freq,
> -				      sizeof(*bus->prop.freq), GFP_KERNEL);
> -	if (!bus->prop.freq)
> +	bus->prop.num_clk_freq = 1;
> +	bus->prop.clk_freq = devm_kcalloc(bus->dev, bus->prop.num_clk_freq,
> +					  sizeof(*bus->prop.clk_freq),
> +					  GFP_KERNEL);
> +	if (!bus->prop.clk_freq)
>  		return -ENOMEM;
>  
> -	bus->prop.freq[0] = bus->prop.max_freq;
> +	bus->prop.clk_freq[0] = bus->prop.max_clk_freq;
>  	bus->prop.err_threshold = 5;
>  
>  	return 0;
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index f6b1be920a19..7db816691393 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -50,39 +50,40 @@ int sdw_master_read_prop(struct sdw_bus *bus)
>  
>  	if (fwnode_property_read_bool(link,
>  				      "mipi-sdw-clock-stop-mode0-supported"))
> -		prop->clk_stop_mode = SDW_CLK_STOP_MODE0;
> +		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE0);
>  
>  	if (fwnode_property_read_bool(link,
>  				      "mipi-sdw-clock-stop-mode1-supported"))
> -		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
> +		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE1);
>  
>  	fwnode_property_read_u32(link,
>  				 "mipi-sdw-max-clock-frequency",
> -				 &prop->max_freq);
> +				 &prop->max_clk_freq);
>  
>  	nval = fwnode_property_read_u32_array(link,
>  			"mipi-sdw-clock-frequencies-supported", NULL, 0);
>  	if (nval > 0) {
> -		prop->num_freq = nval;
> -		prop->freq = devm_kcalloc(bus->dev, prop->num_freq,
> -					  sizeof(*prop->freq), GFP_KERNEL);
> -		if (!prop->freq)
> +		prop->num_clk_freq = nval;
> +		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
> +					      sizeof(*prop->clk_freq),
> +					      GFP_KERNEL);
> +		if (!prop->clk_freq)
>  			return -ENOMEM;
>  
>  		fwnode_property_read_u32_array(link,
>  				"mipi-sdw-clock-frequencies-supported",
> -				prop->freq, prop->num_freq);
> +				prop->clk_freq, prop->num_clk_freq);
>  	}
>  
>  	/*
>  	 * Check the frequencies supported. If FW doesn't provide max
>  	 * freq, then populate here by checking values.
>  	 */
> -	if (!prop->max_freq && prop->freq) {
> -		prop->max_freq = prop->freq[0];
> -		for (i = 1; i < prop->num_freq; i++) {
> -			if (prop->freq[i] > prop->max_freq)
> -				prop->max_freq = prop->freq[i];
> +	if (!prop->max_clk_freq && prop->clk_freq) {
> +		prop->max_clk_freq = prop->clk_freq[0];
> +		for (i = 1; i < prop->num_clk_freq; i++) {
> +			if (prop->clk_freq[i] > prop->max_clk_freq)
> +				prop->max_clk_freq = prop->clk_freq[i];
>  		}
>  	}
>  
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index d01060dbee96..89edc897b8eb 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1474,7 +1474,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  		memcpy(&params, &bus->params, sizeof(params));
>  
>  		/* TODO: Support Asynchronous mode */
> -		if ((prop->max_freq % stream->params.rate) != 0) {
> +		if ((prop->max_clk_freq % stream->params.rate) != 0) {
>  			dev_err(bus->dev, "Async mode not supported\n");
>  			return -EINVAL;
>  		}
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 80584e9d5970..89c51838b7ec 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -364,29 +364,27 @@ struct sdw_slave_prop {
>  /**
>   * struct sdw_master_prop - Master properties
>   * @revision: MIPI spec version of the implementation
> - * @master_count: Number of masters
> - * @clk_stop_mode: Bitmap for Clock Stop modes supported
> - * @max_freq: Maximum Bus clock frequency, in Hz
> + * @clk_stop_modes: Bitmap, bit N set when clock-stop-modeN supported
> + * @max_clk_freq: Maximum Bus clock frequency, in Hz
>   * @num_clk_gears: Number of clock gears supported
>   * @clk_gears: Clock gears supported
> - * @num_freq: Number of clock frequencies supported, in Hz
> - * @freq: Clock frequencies supported, in Hz
> + * @num_clk_freq: Number of clock frequencies supported, in Hz
> + * @clk_freq: Clock frequencies supported, in Hz
>   * @default_frame_rate: Controller default Frame rate, in Hz
>   * @default_row: Number of rows
>   * @default_col: Number of columns
> - * @dynamic_frame: Dynamic frame supported
> + * @dynamic_frame: Dynamic frame shape supported
>   * @err_threshold: Number of times that software may retry sending a single
>   * command
>   */
>  struct sdw_master_prop {
>  	u32 revision;
> -	u32 master_count;
> -	enum sdw_clk_stop_mode clk_stop_mode;
> -	u32 max_freq;
> +	u32 clk_stop_modes;
> +	u32 max_clk_freq;
>  	u32 num_clk_gears;
>  	u32 *clk_gears;
> -	u32 num_freq;
> -	u32 *freq;
> +	u32 num_clk_freq;
> +	u32 *clk_freq;
>  	u32 default_frame_rate;
>  	u32 default_row;
>  	u32 default_col;
> -- 
> 2.17.1

-- 
~Vinod
