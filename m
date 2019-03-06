Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB67DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F71C204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfCFMKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:10:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:43310 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbfCFMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:10:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 04:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="scan'208";a="325916144"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2019 04:10:34 -0800
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     ulf.hansson@linaro.org, kishon@ti.com
References: <20190301083824.23918-1-faiz_abbas@ti.com>
 <20190301083824.23918-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0283e92e-9e01-227d-0987-7801dd88cf78@intel.com>
Date:   Wed, 6 Mar 2019 14:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301083824.23918-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/03/19 10:38 AM, Faiz Abbas wrote:
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
> 
> Fix this by adding a platform specific callback for command errors. Mark
> the mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
> 
> Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index b1a66ca3821a..67b361a403bc 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,29 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +void sdhci_omap_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (omap_host->is_tuning) {
> +		/*
> +		 * Since we are not resetting data lines during tuning
> +		 * operation, data error or data complete interrupts
> +		 * might still arrive. Mark this request as a failure
> +		 * but still wait for the data interrupt
> +		 */
> +		if (intmask & SDHCI_INT_TIMEOUT)
> +			host->cmd->error = -ETIMEDOUT;
> +		else
> +			host->cmd->error = -EILSEQ;
> +
> +		sdhci_finish_command(host);
> +	} else {
> +		sdhci_cmd_err(host, intmask, intmask_p);
> +	}
> +}

Could this be done by the existing ->irq() callback? i.e. mask the error
bits in intmask (have to write them back to SDHCI_INT_STATUS also) but set
cmd->error.
