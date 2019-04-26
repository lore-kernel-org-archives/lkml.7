Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64FAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A31A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfDZGB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:01:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:42595 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDZGB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:01:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 23:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; 
   d="scan'208";a="319116026"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2019 23:01:56 -0700
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
Date:   Fri, 26 Apr 2019 09:00:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425155727.20010-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/19 6:57 PM, Faiz Abbas wrote:
> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
> fields are exchanged. Fix this.

Could you also comment on whether this has any known effect on the driver.

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 866a9082705f..613b151a73c5 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -205,8 +205,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
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

