Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676762087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbfC0LQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:16:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:38070 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfC0LQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:16:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 04:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="286297089"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2019 04:16:42 -0700
Subject: Re: [PATCH v4 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     ulf.hansson@linaro.org, kishon@ti.com
References: <20190326110057.7055-1-faiz_abbas@ti.com>
 <20190326110057.7055-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <508e9423-c1f9-f2cc-4aa9-2cc5b1cf40a8@intel.com>
Date:   Wed, 27 Mar 2019 13:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326110057.7055-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/19 1:00 PM, Faiz Abbas wrote:
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
> 
> Fix this by adding a platform specific callback for sdhci_irq. Mark the
> mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed477c9b1..9da2ff9ede8b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,42 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
> +		      SDHCI_INT_TIMEOUT)
> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
> +
> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
> +
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

Would it be possible to set SDHCI_INT_RESPONSE instead of calling
sdhci_finish_command() directly?

> +
> +		/*
> +		 * Sometimes command error interrupts and command complete
> +		 * interrupt will arrive together. Clear all command related
> +		 * interrupts here.
> +		 */
> +		sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
> +		intmask &= ~CMD_MASK;
> +	}
> +
> +	return intmask;
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>  	.set_clock = sdhci_omap_set_clock,
>  	.set_power = sdhci_omap_set_power,
> @@ -807,6 +843,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>  	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
>  	.reset = sdhci_omap_reset,
>  	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
> +	.irq = sdhci_omap_irq,
>  };
>  
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> 

