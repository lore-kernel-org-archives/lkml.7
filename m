Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A577C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274C921775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfK1Le3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:34:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:33397 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Le2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:34:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 03:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="207167586"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2019 03:34:25 -0800
Subject: Re: [PATCH] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, alcooperx@gmail.com
References: <20191128110422.25917-1-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3f3cd789-55a7-dee8-593c-6eb208877dd6@intel.com>
Date:   Thu, 28 Nov 2019 13:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128110422.25917-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/19 1:04 PM, Faiz Abbas wrote:
> This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.
> 
> This commit aims to treat SD High speed and SDR25 as the same while
> setting UHS Timings in HOST_CONTROL2 which leads to failures with some
> SD cards in AM65x. Revert this commit.
> 
> The issue this commit was trying to fix can be implemented in a platform
> specific callback instead of common sdhci code.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2e5dba..296d955ede59 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1882,9 +1882,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>  	else if (timing == MMC_TIMING_UHS_SDR12)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -	else if (timing == MMC_TIMING_SD_HS ||
> -		 timing == MMC_TIMING_MMC_HS ||
> -		 timing == MMC_TIMING_UHS_SDR25)
> +	else if (timing == MMC_TIMING_UHS_SDR25)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>  	else if (timing == MMC_TIMING_UHS_SDR50)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> 

