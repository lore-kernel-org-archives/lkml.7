Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA6C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA34121873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGZPzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:55:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:59152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfGZPzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:55:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="172261960"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.35.244])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2019 08:55:21 -0700
Date:   Fri, 26 Jul 2019 17:55:20 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 36/40] soundwire: intel: disable
 interrupts on suspend
Message-ID: <20190726155520.GL16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:28PM -0500, Pierre-Louis Bossart wrote:
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 42 +++++++++++++++++-------------
>  drivers/soundwire/cadence_master.h |  2 +-
>  drivers/soundwire/intel.c          |  6 +++--
>  3 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index f486fe15fb46..fa7230b0f200 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -814,33 +814,39 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
>   * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
>   * @cdns: Cadence instance
>   */
> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>  {
>  	u32 mask;
>  
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
> -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
> -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
> +	if (state) {
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
> +			    CDNS_MCP_SLAVE_INTMASK0_MASK);
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
> +			    CDNS_MCP_SLAVE_INTMASK1_MASK);
>  
> -	/* enable detection of slave state changes */
> -	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
> +		/* enable detection of slave state changes */
> +		mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
> +			CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>  
> -	/* enable detection of bus issues */
> -	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> -		CDNS_MCP_INT_PARITY;
> +		/* enable detection of bus issues */
> +		mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> +			CDNS_MCP_INT_PARITY;
>  
> -	/* no detection of port interrupts for now */
> +		/* no detection of port interrupts for now */
>  
> -	/* enable detection of RX fifo level */
> -	mask |= CDNS_MCP_INT_RX_WL;
> +		/* enable detection of RX fifo level */
> +		mask |= CDNS_MCP_INT_RX_WL;
>  
> -	/* now enable all of the above */
> -	mask |= CDNS_MCP_INT_IRQ;
> +		/* now enable all of the above */
> +		mask |= CDNS_MCP_INT_IRQ;
>  
> -	if (interrupt_mask) /* parameter override */
> -		mask = interrupt_mask;
> +		if (interrupt_mask) /* parameter override */
> +			mask = interrupt_mask;
> +	} else {
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, 0);
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, 0);
> +		mask = 0;
> +	}

Looks like this should be two functions? Especially since "state" is always a constant
when it is called. If there is still a lot of common code below, maybe make it a helper
function.

Thanks
Guennadi

>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index 2b551f9226f3..1a0ba36dd78f 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
>  int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
>  
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>  
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 9ebe38e4d979..1192d5775484 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1110,7 +1110,7 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
>  
>  	ret = sdw_cdns_exit_reset(&sdw->cdns);
>  
> @@ -1169,6 +1169,8 @@ static int intel_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	sdw_cdns_enable_interrupt(&sdw->cdns, false);
> +
>  	ret = intel_link_power_down(sdw);
>  	if (ret) {
>  		dev_err(dev, "Link power down failed: %d", ret);
> @@ -1199,7 +1201,7 @@ static int intel_resume(struct device *dev)
>  		return ret;
>  	}
>  
> -	sdw_cdns_enable_interrupt(&sdw->cdns);
> +	sdw_cdns_enable_interrupt(&sdw->cdns, true);
>  
>  	ret = sdw_cdns_exit_reset(&sdw->cdns);
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
