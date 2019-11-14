Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B2206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKNNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:02:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:54517 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNNCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:02:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 05:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="235659969"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2019 05:02:46 -0800
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
To:     Eugen.Hristev@microchip.com, Ludovic.Desroches@microchip.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <48f8d20a-66ad-4c6d-b387-bdcc76fda0c0@intel.com>
Date:   Thu, 14 Nov 2019 15:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/19 2:59 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
> HS200 is set in the driver.
> The driver needs to enable just this flag, not rewrite the whole quirk set.
> 
> Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 496844a..5fe6684 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
>  	/* HS200 is broken at this moment */
> -	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +	host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  
>  	ret = sdhci_add_host(host);
>  	if (ret)
> 

