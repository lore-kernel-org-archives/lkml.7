Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1FB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEGGdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:33:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:2483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfEGGdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:33:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 23:33:07 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2019 23:33:05 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix
 HS50 data hold time problem
To:     Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
 <20190506170115.10840-2-scott.branden@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <195374db-9a9a-2807-d8be-50ec4e8fedcb@intel.com>
Date:   Tue, 7 May 2019 09:32:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506170115.10840-2-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/05/19 8:01 PM, Scott Branden wrote:
> From: Trac Hoang <trac.hoang@broadcom.com>
> 
> The iproc host eMMC/SD controller hold time does not meet the
> specification in the HS50 mode. This problem can be mitigated
> by disabling the HISPD bit; thus forcing the controller output
> data to be driven on the falling clock edges rather than the
> rising clock edges.
> 
> This change applies only to the Cygnus platform.
> 
> Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte register accesses")
> Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-iproc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 9d12c06c7fd6..9d4071c41c94 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -196,7 +196,8 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_NO_HISPD_BIT,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>  	.ops = &sdhci_iproc_32only_ops,
>  };
> 

