Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA0BC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A983620449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCHNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:49456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfCHNBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:01:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 05:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="129925472"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2019 05:01:19 -0800
Subject: Re: [PATCH V1 10/11] mmc: tegra: fix CQE resume sequence
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-10-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <67b3bc6f-0cd9-04ef-af7d-ec59462ec2d2@intel.com>
Date:   Fri, 8 Mar 2019 14:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1551504025-3541-10-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> Tegra CQHCI/SDHCI design prevents write access to SDHCI block size
> register when CQE is enabled and unhalted.
> 
> CQHCI driver enabled CQE prior to invoking sdhci_cqe_enable which
> violates this Tegra specific host requirement.
> 
> This patch fixes this by configuring sdhci block registers prior
> to CQE unhalt.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 71 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 2b63626dc2fa..7063cfcdc590 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1126,23 +1126,75 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  		tegra_host->pad_calib_required = true;
>  }
>  
> +static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
> +{
> +	struct mmc_host *mmc = cq_host->mmc;
> +	u8 ctrl;
> +	ktime_t timeout;
> +	bool timed_out;
> +
> +	/*
> +	 * During CQE resume/unhalt, CQHCI driver unhalts CQE prior to
> +	 * cqhci_host_ops enable where SDHCI DMA and BLOCK_SIZE registers need
> +	 * to be re-configured.
> +	 * Tegra CQHCI/SDHCI prevents write access to block size register when
> +	 * CQE is unhalted. So handling CQE resume sequence here to configure
> +	 * SDHCI block registers prior to exiting CQE halt state.
> +	 */
> +	if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
> +	    cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +		sdhci_cqe_enable(mmc);
> +		writel(val, cq_host->mmio + reg);
> +		timeout = ktime_add_us(ktime_get(), 50);
> +		while (1) {
> +			timed_out = ktime_compare(ktime_get(), timeout) > 0;
> +			ctrl = cqhci_readl(cq_host, CQHCI_CTL);
> +			if (!(ctrl & CQHCI_HALT) || timed_out)
> +				break;
> +		}
> +		/*
> +		 * CQE usually resumes very quick, but incase if Tegra CQE
> +		 * doesn't resume retry unhalt.
> +		 */
> +		if (timed_out)
> +			writel(val, cq_host->mmio + reg);
> +	} else {
> +		writel(val, cq_host->mmio + reg);
> +	}
> +}
> +
>  static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> -	u32 cqcfg = 0;
> +	u32 val;
>  
>  	/*
> -	 * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
> -	 * registers when CQE is enabled.
> +	 * Tegra CQHCI/SDMMC design prevents write access to sdhci block size
> +	 * register when CQE is enabled and unhalted.
> +	 * CQHCI driver enables CQE prior to activation, so disable CQE before
> +	 * programming block size in sdhci controller and enable it back.
>  	 */
> -	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> -	if (cqcfg & CQHCI_ENABLE)
> -		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
> +	if (!cq_host->activated) {
> +		val = cqhci_readl(cq_host, CQHCI_CFG);
> +		if (val & CQHCI_ENABLE)
> +			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
> +				     CQHCI_CFG);
> +		sdhci_cqe_enable(mmc);
> +		if (val & CQHCI_ENABLE)
> +			cqhci_writel(cq_host, val, CQHCI_CFG);
> +	}
>  
> -	sdhci_cqe_enable(mmc);
> +	/*
> +	 * CMD CRC errors are seen sometimes with some eMMC devices when status
> +	 * command is sent during transfer of last data block which is the
> +	 * default case as send status command block counter (CBC) is 1.
> +	 * So changing send status command block counter (CBC) to 0 to allow
> +	 * send status command only when the data lines are idle.
> +	 */
> +	val = cqhci_readl(cq_host, CQHCI_SSC1);
> +	val &= ~CQHCI_SSC1_CBC_MASK;
> +	cqhci_writel(cq_host, val, CQHCI_SSC1);
>  
> -	if (cqcfg & CQHCI_ENABLE)
> -		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  }
>  
>  static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
> @@ -1167,6 +1219,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  	.enable	= sdhci_tegra_cqe_enable,
>  	.disable = sdhci_cqe_disable,
>  	.dumpregs = sdhci_tegra_dumpregs,
> +	.write_l    = tegra_cqhci_writel,
>  };
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> 

