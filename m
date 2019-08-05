Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A5C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196820679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfHEKi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:38:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:13865 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEKi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:38:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 03:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="181642793"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2019 03:38:55 -0700
Date:   Mon, 5 Aug 2019 16:10:47 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [RFC PATCH 26/40] soundwire: cadence_master: fix divider setting
 in clock register
Message-ID: <20190805104047.GG22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:18PM -0500, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
> 
> The existing code uses an OR operation which would mix the original
> divider setting with the new one, resulting in an invalid
> configuration that can make codecs hang.
> 
> Add the mask definition and use cdns_updatel to update divider
> 
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 10ebcef2e84e..18c6ac026e85 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -57,6 +57,7 @@
>  #define CDNS_MCP_SSP_CTRL1			0x28
>  #define CDNS_MCP_CLK_CTRL0			0x30
>  #define CDNS_MCP_CLK_CTRL1			0x38
> +#define CDNS_MCP_CLK_MCLKD_MASK		GENMASK(7, 0)
>  
>  #define CDNS_MCP_STAT				0x40
>  
> @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	/* Set clock divider */
>  	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>  	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);

reg read of CLK_CTRL0 can be removed.

> -	val |= divider;
> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
> +
> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>  
>  	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>  	       prop->mclk_freq,
> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>  		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>  
>  	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);

same as above.

> -	mcp_clkctrl |= divider;
> -	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
> +	cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, divider);
>  
>  	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>  	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
> -- 
> 2.20.1
> 

-- 
