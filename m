Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864FF206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDZFv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:51:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:14107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDZFv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:51:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 22:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; 
   d="scan'208";a="319114012"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2019 22:51:52 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Fix minor phy configurations
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-2-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8317e8a0-1b1f-4b0d-8a9b-2a6fdd0ab4e5@intel.com>
Date:   Fri, 26 Apr 2019 08:50:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425155727.20010-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/19 6:57 PM, Faiz Abbas wrote:
> Fix the following minor things:
> 
> 1. Line wrapping with the regmap_*() functions is way more conservative
> than required by the 80 character rule. Expand the function calls out to
> use less number of lines.
> 
> 2. Add an error message if the DLL fails to lock.

Please make the white space changes a separate patch.

Also I would prefer not to use "fix" in the subject unless the patch fixes
driver behaviour.

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index eea183e90f1b..866a9082705f 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -88,8 +88,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  	int ret;
>  
>  	if (sdhci_am654->dll_on) {
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> -				   ENDLL_MASK, 0);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
>  
>  		sdhci_am654->dll_on = false;
>  	}
> @@ -101,8 +100,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>  		val = (1 << OTAPDLYENA_SHIFT) |
>  		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
> -				   mask, val);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>  		switch (clock) {
>  		case 200000000:
>  			sel50 = 0;
> @@ -120,8 +118,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  		/* Configure PHY DLL frequency */
>  		mask = SEL50_MASK | SEL100_MASK;
>  		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
> -				   mask, val);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
>  		/* Configure DLL TRIM */
>  		mask = DLL_TRIM_ICP_MASK;
>  		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
> @@ -129,19 +126,21 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  		/* Configure DLL driver strength */
>  		mask |= DR_TY_MASK;
>  		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> -				   mask, val);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
>  		/* Enable DLL */
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> -				   ENDLL_MASK, 0x1 << ENDLL_SHIFT);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
> +				   0x1 << ENDLL_SHIFT);
>  		/*
>  		 * Poll for DLL ready. Use a one second timeout.
>  		 * Works in all experiments done so far
>  		 */
> -		ret = regmap_read_poll_timeout(sdhci_am654->base,
> -					 PHY_STAT1, val,
> -					 val & DLLRDY_MASK,
> -					 1000, 1000000);
> +		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
> +					       val, val & DLLRDY_MASK, 1000,
> +					       1000000);
> +		if (ret) {
> +			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
> +			return;
> +		}
>  
>  		sdhci_am654->dll_on = true;
>  	}
> @@ -186,8 +185,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  
>  	/* Reset OTAP to default value */
>  	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
> -				   mask, 0x0);
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, 0x0);
>  
>  	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
>  	if (~val & CALDONE_MASK) {
> @@ -201,15 +199,14 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	}
>  
>  	/* Enable pins by setting IO mux to 0 */
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> -			   IOMUX_ENABLE_MASK, 0);
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, IOMUX_ENABLE_MASK, 0);
>  
>  	/* Set slot type based on SD or eMMC */
>  	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>  		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>  
> -	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
> -			   ctl_cfg_2, SLOTTYPE_MASK);
> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
> +			   SLOTTYPE_MASK);
>  
>  	return sdhci_add_host(host);
>  }
> 

