Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46CDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA75920659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfGPIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:24:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:60895 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfGPIYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:24:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 01:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,497,1557212400"; 
   d="scan'208";a="342640169"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2019 01:24:06 -0700
Subject: Re: [PATCH v2] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b9cba2452c0166ef2fa69514d6ac8fbe7ee02883.1563259454.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <987d226b-5906-f403-d641-3c54430f1c9b@intel.com>
Date:   Tue, 16 Jul 2019 11:22:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b9cba2452c0166ef2fa69514d6ac8fbe7ee02883.1563259454.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/19 10:31 AM, Baolin Wang wrote:
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, which will cause Spreadtrum host controller work abnormally after
> resuming.
> 
> Thus for Spreadtrum platform that do not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all. To fix this
> issue, adding a specific reset operation that add one condition to validate
> the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
> just reset command and data lines.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-sprd.c |   38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..174b566 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -373,6 +373,42 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	return 1 << 31;
>  }
>  
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	ktime_t timeout;
> +
> +	/*
> +	 * When try to reset controller after runtime suspend, we should not
> +	 * reset for all if the SD/eMMC card is not power down, just reset
> +	 * command and data lines instead. Otherwise will meet some strange
> +	 * behaviors for Spreadtrum host controller.
> +	 */
> +	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> +	    !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))
> +		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +

Here you could just call sdhci_reset(host, mask) instead of below.

> +	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +
> +	/* Wait max 100 ms */
> +	timeout = ktime_add_ms(ktime_get(), 100);
> +
> +	/* hw clears the bit when it's done */
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Reset 0x%x never completed.\n",
> +				mmc_hostname(host->mmc), (int)mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>  	.read_l = sdhci_sprd_readl,
>  	.write_l = sdhci_sprd_writel,
> @@ -381,7 +417,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	.get_max_clock = sdhci_sprd_get_max_clock,
>  	.get_min_clock = sdhci_sprd_get_min_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_sprd_reset,
>  	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>  	.hw_reset = sdhci_sprd_hw_reset,
>  	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> 

