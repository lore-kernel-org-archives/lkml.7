Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C47C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B212077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfGQGIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:08:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:1203 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQGIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:08:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 23:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="170154892"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2019 23:08:20 -0700
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <66eb3053-ca2d-e2f0-edf0-9227f75a5693@intel.com>
Date:   Wed, 17 Jul 2019 09:07:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/19 5:28 AM, Baolin Wang wrote:
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, which will cause Spreadtrum host controller work abnormally after
> resuming.
> 
> Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all. To fix this
> issue, adding a specific reset operation that adds one condition to validate
> the power mode to decide if we can do software reset for all or just reset
> command and data lines.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changess from v3:
>  - Use ios.power_mode to validate if the card is power down or not.
> 
> Changes from v2:
>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> 
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..94f9726 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	return 1 << 31;
>  }
>  
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	/*
> +	 * When try to reset controller after runtime suspend, we should not
> +	 * reset for all if the SD/eMMC card is not power down, just reset
> +	 * command and data lines instead. Otherwise will meet some strange
> +	 * behaviors for Spreadtrum host controller.
> +	 */
> +	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> +	    mmc->ios.power_mode == MMC_POWER_ON)
> +		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +
> +	sdhci_reset(host, mask);
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>  	.read_l = sdhci_sprd_readl,
>  	.write_l = sdhci_sprd_writel,
> @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	.get_max_clock = sdhci_sprd_get_max_clock,
>  	.get_min_clock = sdhci_sprd_get_min_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_sprd_reset,
>  	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>  	.hw_reset = sdhci_sprd_hw_reset,
>  	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> 

