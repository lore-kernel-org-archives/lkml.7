Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F0FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D24C217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564767151;
	bh=42TcOR8lS2f4rqcNgv/niQ1OOyQQzpjCyw97d3CbBJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gPDLU2CzL6XcaGyIxQjPyjpRx0T3bpDN/QcyXrZu+NWsb9d9g8gGVOnlGDJdwut1n
	 3Zt2C/hf/2dNb9FW49f0MdnXuW7rLcwPEbJR21x3lGWGceqieZ3+TnitrBUbjA+ksB
	 oeLy9SYc50mv1LIk5ZkrAU/Zv/4IyXVGQiop6t94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405392AbfHBRca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404697AbfHBRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:32:29 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4422173E;
        Fri,  2 Aug 2019 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564767148;
        bh=42TcOR8lS2f4rqcNgv/niQ1OOyQQzpjCyw97d3CbBJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9BL9G2Kw4NQEbSxHNPZXSuhGOfSHgkh5qHdHBCyS5Wrf9VHcLOe8Oip+FTcTP51k
         3hLx2392faQcsX/oBnPZhQpxEzxA2877L+sTjU+0s0VgOs1GURmEPOexe/kD3/XTnc
         feAP8fSlqIrgQlrD20IyLpzECruU05jWXzabEXfg=
Date:   Fri, 2 Aug 2019 23:01:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 35/40] soundwire: intel: export helper to exit reset
Message-ID: <20190802173115.GE12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

Here as well

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 9 +++++++--
>  drivers/soundwire/cadence_master.h | 1 +
>  drivers/soundwire/intel.c          | 4 ++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 4a189e487830..f486fe15fb46 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -780,7 +780,11 @@ EXPORT_SYMBOL(sdw_cdns_thread);
>   * init routines
>   */
>  
> -static int do_reset(struct sdw_cdns *cdns)
> +/**
> + * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
> + * @cdns: Cadence instance
> + */
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
>  {
>  	int ret;
>  
> @@ -804,6 +808,7 @@ static int do_reset(struct sdw_cdns *cdns)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(sdw_cdns_exit_reset);
>  
>  /**
>   * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
> @@ -839,7 +844,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> -	return do_reset(cdns);
> +	return 0;
>  }
>  EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index de97bc22acb7..2b551f9226f3 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
>  int sdw_cdns_init(struct sdw_cdns *cdns);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>  
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index a976480d6f36..9ebe38e4d979 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1112,6 +1112,8 @@ static int intel_probe(struct platform_device *pdev)
>  
>  	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>  
> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
> +
>  	/* Register DAIs */
>  	ret = intel_register_dai(sdw);
>  	if (ret) {
> @@ -1199,6 +1201,8 @@ static int intel_resume(struct device *dev)
>  
>  	sdw_cdns_enable_interrupt(&sdw->cdns);
>  
> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
> +
>  	return ret;
>  }
>  
> -- 
> 2.20.1

-- 
~Vinod
