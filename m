Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9935C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAE521873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGZHWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:22:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:19721 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfGZHWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:22:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 00:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; 
   d="scan'208";a="369451492"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.35.244])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 00:22:35 -0700
Date:   Fri, 26 Jul 2019 09:22:34 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 16/40] soundwire: cadence_master:
 improve startup sequence with link hw_reset
Message-ID: <20190726072234.GD16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-17-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-17-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:08PM -0500, Pierre-Louis Bossart wrote:
> Enable interrupts first, then engage hardware bus reset with maximum
> duration to make sure the Slave(s) correctly detect the reset pattern
> and to ensure electrical conflicts can be resolved.
> 
> Without these changes the initialization is randomly corrupted by bus
> clashes, parity errors and Slave attachment does not generate any
> interrupt, despite the status showing them being attached.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 35 +++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 25d5c7267c15..442f78c00f09 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -778,6 +778,31 @@ EXPORT_SYMBOL(sdw_cdns_thread);
>   * init routines
>   */
>  
> +static int do_reset(struct sdw_cdns *cdns)
> +{
> +	int ret;
> +
> +	/* program maximum length reset to be safe */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
> +		     CDNS_MCP_CONTROL_RST_DELAY,
> +		     CDNS_MCP_CONTROL_RST_DELAY);
> +
> +	/* use hardware generated reset */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
> +		     CDNS_MCP_CONTROL_HW_RST,
> +		     CDNS_MCP_CONTROL_HW_RST);
> +
> +	/* enable bus operations with clock and data */
> +	cdns_updatel(cdns, CDNS_MCP_CONFIG,
> +		     CDNS_MCP_CONFIG_OP,
> +		     CDNS_MCP_CONFIG_OP_NORMAL);
> +
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;

+	return cdns_update_config(cdns);

and remove the "ret" variable.

Thanks
Guennadi

> +}
> +
>  /**
>   * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
>   * @cdns: Cadence instance
> @@ -809,7 +834,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> -	return 0;
> +	return do_reset(cdns);
>  }
>  EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>  
> @@ -958,6 +983,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
>  
> +	/* flush command FIFOs */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_RST,
> +		     CDNS_MCP_CONTROL_CMD_RST);
> +
>  	/* Set cmd accept mode */
>  	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
>  		     CDNS_MCP_CONTROL_CMD_ACCEPT);
> @@ -980,10 +1009,6 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	/* Set cmd mode for Tx and Rx cmds */
>  	val &= ~CDNS_MCP_CONFIG_CMD;
>  
> -	/* Set operation to normal */
> -	val &= ~CDNS_MCP_CONFIG_OP;
> -	val |= CDNS_MCP_CONFIG_OP_NORMAL;
> -
>  	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>  
>  	/* commit changes */
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
