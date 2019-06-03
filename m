Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459E7280FA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfFCMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:42:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:61293 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfFCMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:42:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 05:42:13 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2019 05:42:09 -0700
Subject: Re: [PATCH 6/9] mmc: sdhci-sprd: Enable PHY DLL to make clock stable
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <270e86bf6b1ce138e40830fb63c9bcf150440426.1558346019.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8a792a0c-ed53-56ca-ede8-4a2657158b81@intel.com>
Date:   Mon, 3 Jun 2019 15:40:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <270e86bf6b1ce138e40830fb63c9bcf150440426.1558346019.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> For the Spreadtrum SD host controller, when we changed the clock to be
> more than 52M, we should enable the PHY DLL which is used to track the
> clock frequency to make the clock work more stable. Otherwise deviation
> may occur of the higher clock.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   44 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index edec197..e6eda13 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -22,6 +22,13 @@
>  /* SDHCI_ARGUMENT2 register high 16bit */
>  #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
>  
> +#define SDHCI_SPRD_REG_32_DLL_CFG	0x200
> +#define  SDHCI_SPRD_DLL_ALL_CPST_EN	(BIT(18) | BIT(24) | BIT(25) | BIT(26) | BIT(27))
> +#define  SDHCI_SPRD_DLL_EN		BIT(21)
> +#define  SDHCI_SPRD_DLL_SEARCH_MODE	BIT(16)
> +#define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
> +#define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
> +
>  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
>  #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
>  #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
> @@ -56,6 +63,7 @@
>  #define SDHCI_SPRD_CLK_MAX_DIV		1023
>  
>  #define SDHCI_SPRD_CLK_DEF_RATE		26000000
> +#define SDHCI_SPRD_PHY_DLL_CLK		52000000
>  
>  struct sdhci_sprd_host {
>  	u32 version;
> @@ -200,9 +208,33 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
> +{
> +	u32 tmp;
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp |= SDHCI_SPRD_DLL_ALL_CPST_EN | SDHCI_SPRD_DLL_SEARCH_MODE |
> +		SDHCI_SPRD_DLL_INIT_COUNT | SDHCI_SPRD_DLL_PHASE_INTERNAL;
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp |= SDHCI_SPRD_DLL_EN;
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +}
> +
>  static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
> -	bool en = false;
> +	bool en = false, clk_changed = false;
>  
>  	if (clock == 0) {
>  		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> @@ -214,9 +246,19 @@ static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
>  			en = true;
>  		sdhci_sprd_set_dll_invert(host, SDHCI_SPRD_BIT_CMD_DLY_INV |
>  					  SDHCI_SPRD_BIT_POSRD_DLY_INV, en);
> +		clk_changed = true;
>  	} else {
>  		_sdhci_sprd_set_clock(host, clock);
>  	}
> +
> +	/*
> +	 * According to the Spreadtrum SD host specification, when we changed
> +	 * the clock to be more than 52M, we should enable the PHY DLL which
> +	 * is used to track the clock frequency to make the clock work more
> +	 * stable. Otherwise deviation may occur of the higher clock.
> +	 */
> +	if (clk_changed && clock > SDHCI_SPRD_PHY_DLL_CLK)
> +		sdhci_sprd_enable_phy_dll(host);
>  }
>  
>  static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
> 

