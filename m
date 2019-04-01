Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D891C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2587A20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDAIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:52:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:2482 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbfDAIwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:52:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 01:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,295,1549958400"; 
   d="scan'208";a="127570968"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2019 01:52:20 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
Date:   Mon, 1 Apr 2019 11:51:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329142202.15000-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/19 4:22 PM, Faiz Abbas wrote:
> Some controllers on TI devices requires the HISPD bit to be cleared
> even in some high speed modes. Add a quirk that facilitates this
> requirement.

Could you use sdhci I/O accessors for this?

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8141ff9be03..ed4ed6054ddf 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
>  	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
> -		if (ios->timing == MMC_TIMING_SD_HS ||
> -		     ios->timing == MMC_TIMING_MMC_HS ||
> -		     ios->timing == MMC_TIMING_MMC_HS400 ||
> -		     ios->timing == MMC_TIMING_MMC_HS200 ||
> -		     ios->timing == MMC_TIMING_MMC_DDR52 ||
> -		     ios->timing == MMC_TIMING_UHS_SDR50 ||
> -		     ios->timing == MMC_TIMING_UHS_SDR104 ||
> -		     ios->timing == MMC_TIMING_UHS_DDR50 ||
> -		     ios->timing == MMC_TIMING_UHS_SDR25)
> -			ctrl |= SDHCI_CTRL_HISPD;
> -		else
> -			ctrl &= ~SDHCI_CTRL_HISPD;
> +		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
> +			if (ios->timing == MMC_TIMING_MMC_HS400 ||
> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
> +			    ios->timing == MMC_TIMING_UHS_DDR50)
> +				ctrl |= SDHCI_CTRL_HISPD;
> +			else
> +				ctrl &= ~SDHCI_CTRL_HISPD;
> +		} else {
> +			if (ios->timing == MMC_TIMING_SD_HS ||
> +			    ios->timing == MMC_TIMING_MMC_HS ||
> +			    ios->timing == MMC_TIMING_MMC_HS400 ||
> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
> +			    ios->timing == MMC_TIMING_UHS_DDR50 ||
> +			    ios->timing == MMC_TIMING_UHS_SDR25)
> +				ctrl |= SDHCI_CTRL_HISPD;
> +			else
> +				ctrl &= ~SDHCI_CTRL_HISPD;
> +		}
>  	}
>  
>  	if (host->version >= SDHCI_SPEC_300) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 01002cba1359..aac026c5e184 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -485,6 +485,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Some TI devices need the high speed bit disabled even in high speed modes */
> +#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

