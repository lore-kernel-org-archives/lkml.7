Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03910C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3334217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEJF6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:58:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:1401 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfEJF6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:58:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 22:58:41 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2019 22:58:39 -0700
Subject: Re: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190510034228.32211-1-faiz_abbas@ti.com>
 <20190510034228.32211-4-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
Date:   Fri, 10 May 2019 08:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510034228.32211-4-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/19 6:42 AM, Faiz Abbas wrote:
> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
> fields are exchanged. Fix this. This didn't have any affect on the
> driver because this was a NOP and it was taking the correct value from
> the bootloader.
> 
> Cc: stable <stable@vger.kernel.org>

Except that it doesn't apply to stable because of patch 1.  Maybe make this
the first patch.

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 3ff949925127..d0b20780dd0f 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -227,8 +227,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>  		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>  
> -	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
> -			   SLOTTYPE_MASK);
> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
> +			   ctl_cfg_2);
>  
>  	return sdhci_add_host(host);
>  }
> 

