Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7267B20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438418AbfFLMzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:55:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:25121 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbfFLMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:55:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 05:55:14 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2019 05:55:12 -0700
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20190610185354.35310-1-rrangel@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <883dab7b-57fc-22dd-e111-72506544d0e8@intel.com>
Date:   Wed, 12 Jun 2019 15:53:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/19 9:53 PM, Raul E Rangel wrote:
> sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> Without this patch the block size would be set incorrectly when the
> bus_width == 8 which results in tuning failing.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b29bf4e7dcb48..dd21315922c87 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	 */
>  	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>  		current_bus_width = mmc->ios.bus_width;
> +		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
>  		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
>  	}
>  
> @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	sdhci_end_tuning(host);
>  
> -	if (current_bus_width == MMC_BUS_WIDTH_8)
> +	if (current_bus_width == MMC_BUS_WIDTH_8) {
> +		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>  		sdhci_set_bus_width(host, current_bus_width);
> +	}
>  
>  	host->flags &= ~SDHCI_HS400_TUNING;
>  	return 0;
> 

