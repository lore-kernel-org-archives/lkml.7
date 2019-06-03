Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C3825FCC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfFCMke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:40:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:64773 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCMkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:40:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 05:40:33 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2019 05:40:27 -0700
Subject: Re: [PATCH 5/9] mmc: sdhci-sprd: Add HS400 enhanced strobe mode
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <20349e8ebd4c1ec64fb5f8cdd9e094d0c1732855.1558346019.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1d527144-b047-1d81-171d-706e1c67e19b@intel.com>
Date:   Mon, 3 Jun 2019 15:39:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20349e8ebd4c1ec64fb5f8cdd9e094d0c1732855.1558346019.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> Add HS400 enhanced strobe mode support for Spreadtrum SD host controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index d91281d..edec197 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -41,6 +41,7 @@
>  /* SDHCI_HOST_CONTROL2 */
>  #define  SDHCI_SPRD_CTRL_HS200		0x0005
>  #define  SDHCI_SPRD_CTRL_HS400		0x0006
> +#define  SDHCI_SPRD_CTRL_HS400ES	0x0007
>  
>  /*
>   * According to the standard specification, BIT(3) of SDHCI_SOFTWARE_RESET is
> @@ -132,6 +133,15 @@ static inline void sdhci_sprd_sd_clk_off(struct sdhci_host *host)
>  	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
>  }
>  
> +static inline void sdhci_sprd_sd_clk_on(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ctrl |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +}
> +
>  static inline void
>  sdhci_sprd_set_dll_invert(struct sdhci_host *host, u32 mask, bool en)
>  {
> @@ -325,6 +335,26 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> +static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					     struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 ctrl_2;
> +
> +	if (!ios->enhanced_strobe)
> +		return;
> +
> +	sdhci_sprd_sd_clk_off(host);
> +
> +	/* Set HS400 enhanced strobe mode */
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	ctrl_2 |= SDHCI_SPRD_CTRL_HS400ES;
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +	sdhci_sprd_sd_clk_on(host);
> +}
> +
>  static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
>  	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>  	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
> @@ -346,6 +376,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	host->dma_mask = DMA_BIT_MASK(64);
>  	pdev->dev.dma_mask = &host->dma_mask;
>  	host->mmc_host_ops.request = sdhci_sprd_request;
> +	host->mmc_host_ops.hs400_enhanced_strobe =
> +		sdhci_sprd_hs400_enhanced_strobe;
>  
>  	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
>  		MMC_CAP_ERASE | MMC_CAP_CMD23;
> 

