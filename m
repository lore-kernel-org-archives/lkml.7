Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F312147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfHEQzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:55:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:43767 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfHEQzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:55:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 09:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="175635793"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2019 09:55:35 -0700
Date:   Mon, 5 Aug 2019 22:27:29 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 28/40] soundwire: intel: handle disabled links
Message-ID: <20190805165729.GC24889@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-29-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-29-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:20PM -0500, Pierre-Louis Bossart wrote:
> On most hardware platforms, SoundWire interfaces are pin-muxed with
> other interfaces (typically DMIC or I2S) and the status of each link
> needs to be checked at boot time.
> 
> For Intel platforms, the BIOS provides a menu to enable/disable the
> links separately, and the information is provided to the OS with an
> Intel-specific _DSD property. The same capability will be added to
> revisions of the MIPI DisCo specification.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c     | 26 ++++++++++++++++++++++----
>  include/linux/soundwire/sdw.h |  2 ++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 796ac2bc8cea..5947fa8e840b 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -90,6 +90,8 @@
>  #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
>  #define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
>  
> +#define SDW_INTEL_QUIRK_MASK_BUS_DISABLE	BIT(1)
> +
>  enum intel_pdi_type {
>  	INTEL_PDI_IN = 0,
>  	INTEL_PDI_OUT = 1,
> @@ -922,7 +924,7 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  	struct sdw_master_prop *prop = &bus->prop;
>  	struct fwnode_handle *link;
>  	char name[32];
> -	int nval, i;
> +	u32 quirk_mask;
>  
>  	/* Find master handle */
>  	snprintf(name, sizeof(name),
> @@ -937,6 +939,14 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  	fwnode_property_read_u32(link,
>  				 "intel-sdw-ip-clock",
>  				 &prop->mclk_freq);
> +
> +	fwnode_property_read_u32(link,
> +				 "intel-quirk-mask",
> +				 &quirk_mask);
> +
> +	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
> +		prop->hw_disabled = true;
> +
>  	return 0;
>  }
>  
> @@ -997,6 +1007,12 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_master_reg;
>  	}
>  
> +	if (sdw->cdns.bus.prop.hw_disabled) {
> +		dev_info(&pdev->dev, "SoundWire master %d is disabled, ignoring\n",
> +			 sdw->cdns.bus.link_id);
> +		return 0;
> +	}
> +
>  	/* Initialize shim and controller */
>  	intel_link_power_up(sdw);
>  	intel_shim_init(sdw);
> @@ -1050,9 +1066,11 @@ static int intel_remove(struct platform_device *pdev)
>  
>  	sdw = platform_get_drvdata(pdev);
>  
> -	intel_debugfs_exit(sdw);
> -	free_irq(sdw->res->irq, sdw);
> -	snd_soc_unregister_component(sdw->cdns.dev);
> +	if (!sdw->cdns.bus.prop.hw_disabled) {
> +		intel_debugfs_exit(sdw);
> +		free_irq(sdw->res->irq, sdw);
> +		snd_soc_unregister_component(sdw->cdns.dev);
> +	}
>  	sdw_delete_bus_master(&sdw->cdns.bus);
>  
>  	return 0;
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index c7dfc824be80..f78b076a8782 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -380,6 +380,7 @@ struct sdw_slave_prop {
>   * @err_threshold: Number of times that software may retry sending a single
>   * command
>   * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
> + * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
>   */
>  struct sdw_master_prop {
>  	u32 revision;
> @@ -395,6 +396,7 @@ struct sdw_master_prop {
>  	bool dynamic_frame;
>  	u32 err_threshold;
>  	u32 mclk_freq;
> +	bool hw_disabled;

Do we have such cases where some of SoundWire links are disabled and
some enabled?

>  };
>  
>  int sdw_master_read_prop(struct sdw_bus *bus);
> -- 
> 2.20.1
> 

-- 
