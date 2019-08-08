Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC8AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37C22171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfHHNBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:01:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:21475 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbfHHNBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:01:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="182586432"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 06:01:30 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
To:     Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com,
        ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6f08715f-b0e5-715c-006a-d80c0ecf2cd7@intel.com>
Date:   Thu, 8 Aug 2019 16:00:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/08/19 11:35 AM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> HS200 is not implemented in the driver, but the controller claims it
> through caps.
> Remove it via quirk.
> Without this quirk, the mmc core will try to enable hs200, which will fail,
> and the eMMC initialization will fail.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 57fe3b2..3a8c6d8 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
> +	/* HS200 is broken at this moment */
> +	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto pm_runtime_disable;
> 

