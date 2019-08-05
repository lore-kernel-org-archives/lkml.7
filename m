Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68131C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B23217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfHEJ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:59:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:54172 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEJ7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:59:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 02:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="164608070"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 02:59:15 -0700
Date:   Mon, 5 Aug 2019 15:31:07 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults
 for frame shape
Message-ID: <20190805100107.GE22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:16PM -0500, Pierre-Louis Bossart wrote:
> Remove hard-coding and use BIOS values. If they are wrong use default
> 48x2 frame shape.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 442f78c00f09..d84344e29f71 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -175,7 +175,6 @@
>  /* Driver defaults */
>  
>  #define CDNS_DEFAULT_CLK_DIVIDER		0
> -#define CDNS_DEFAULT_FRAME_SHAPE		0x30
>  #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>  #define CDNS_TX_TIMEOUT				2000
>  
> @@ -954,6 +953,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  }
>  EXPORT_SYMBOL(sdw_cdns_pdi_init);
>  
> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
> +{
> +	u32 val;
> +	int c;
> +	int r;
> +
> +	r = sdw_find_row_index(n_rows);
> +	c = sdw_find_col_index(n_cols);
> +

Now i get why you need above functions to be exported, please ignore my
previous comment.

> +	val = (r << 3) | c;
> +
> +	return val;
> +}
> +
>  /**
>   * sdw_cdns_init() - Cadence initialization
>   * @cdns: Cadence instance
> @@ -977,7 +990,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>  
>  	/* Set the default frame shape */
> -	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, CDNS_DEFAULT_FRAME_SHAPE);
> +	val = cdns_set_default_frame_shape(prop->default_row,
> +					   prop->default_col);
> +	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
>  
>  	/* Set SSP interval to default value */
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
> -- 
> 2.20.1
> 

-- 
