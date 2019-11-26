Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7476C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5832071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfKZM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:28:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:34730 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfKZM2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:28:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 04:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217152823"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 04:28:01 -0800
Subject: Re: [PATCH v4 2/3] mmc: sdhci-of-at91: rework clocks management to
 support SAM9x60 device
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     ulf.hansson@linaro.org, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, claudiu.beznea@microchip.com,
        Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com
References: <1351fc1a-3d07-4a56-2622-07ea92727c4f@intel.com>
 <20191125102415.11341-1-ludovic.desroches@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8d462d2d-353e-3466-1a90-fd0b97234a1f@intel.com>
Date:   Tue, 26 Nov 2019 14:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125102415.11341-1-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/19 12:24 PM, Ludovic Desroches wrote:
> In the SAM9x60 SoC, there are only two clocks instead of three for the
> SDHCI device. The base clk is no longer provided, it is generated
> internally from the mult clk.
> 
> The values of the base clk and mul in the capabilities registers may not
> reflect the reality as the mult clk is a programmable clock which can take
> several rates. As we can't trust those values, take them from the clock
> tree and update the capabilities according to.
> 
> As we can have the same pitfall, in some cases, with the SAMA5D2 Soc,
> stop relying on capabilities too.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Thanks Adrian for pointing out the typo. It's fixed and re-tested.
> 
> Let me know if you want to me to resend the full serie or if it's ok.

This is fine for me, although one more very minor comment below.
If you fix that you can add my ack:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Regards
> 
> Ludovic
> 
>  drivers/mmc/host/sdhci-of-at91.c | 105 +++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 5959e394b416..b95ac4b27f22 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -33,7 +33,14 @@
>  
>  #define SDHCI_AT91_PRESET_COMMON_CONF	0x400 /* drv type B, programmable clock mode */
>  
> +struct sdhci_at91_soc_data {
> +	const struct sdhci_pltfm_data *pdata;
> +	bool baseclk_is_generated_internally;
> +	unsigned int divider_for_baseclk;
> +};
> +
>  struct sdhci_at91_priv {
> +	const struct sdhci_at91_soc_data *soc_data;
>  	struct clk *hclock;
>  	struct clk *gck;
>  	struct clk *mainck;
> @@ -141,12 +148,24 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>  	.set_power		= sdhci_at91_set_power,
>  };
>  
> -static const struct sdhci_pltfm_data soc_data_sama5d2 = {
> +static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
>  	.ops = &sdhci_at91_sama5d2_ops,
>  };
>  
> +static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
> +	.pdata = &sdhci_sama5d2_pdata,
> +	.baseclk_is_generated_internally = false,
> +};
> +
> +static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
> +	.pdata = &sdhci_sama5d2_pdata,
> +	.baseclk_is_generated_internally = true,
> +	.divider_for_baseclk = 2,
> +};
> +
>  static const struct of_device_id sdhci_at91_dt_match[] = {
>  	{ .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
> +	{ .compatible = "microchip,sam9x60-sdhci", .data = &soc_data_sam9x60 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
> @@ -156,50 +175,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	int ret;
>  	unsigned int			caps0, caps1;
>  	unsigned int			clk_base, clk_mul;
> -	unsigned int			gck_rate, real_gck_rate;
> +	unsigned int			gck_rate, clk_base_rate;
>  	unsigned int			preset_div;
>  
> -	/*
> -	 * The mult clock is provided by as a generated clock by the PMC
> -	 * controller. In order to set the rate of gck, we have to get the
> -	 * base clock rate and the clock mult from capabilities.
> -	 */
>  	clk_prepare_enable(priv->hclock);
>  	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>  	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> -	clk_base = (caps0 & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
> -	clk_mul = (caps1 & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;
> -	gck_rate = clk_base * 1000000 * (clk_mul + 1);
> -	ret = clk_set_rate(priv->gck, gck_rate);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to set gck");
> -		clk_disable_unprepare(priv->hclock);
> -		return ret;
> -	}
> -	/*
> -	 * We need to check if we have the requested rate for gck because in
> -	 * some cases this rate could be not supported. If it happens, the rate
> -	 * is the closest one gck can provide. We have to update the value
> -	 * of clk mul.
> -	 */
> -	real_gck_rate = clk_get_rate(priv->gck);
> -	if (real_gck_rate != gck_rate) {
> -		clk_mul = real_gck_rate / (clk_base * 1000000) - 1;
> -		caps1 &= (~SDHCI_CLOCK_MUL_MASK);
> -		caps1 |= ((clk_mul << SDHCI_CLOCK_MUL_SHIFT) &
> -			  SDHCI_CLOCK_MUL_MASK);
> -		/* Set capabilities in r/w mode. */
> -		writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN,
> -		       host->ioaddr + SDMMC_CACR);
> -		writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
> -		/* Set capabilities in ro mode. */
> -		writel(0, host->ioaddr + SDMMC_CACR);
> -		dev_info(dev, "update clk mul to %u as gck rate is %u Hz\n",
> -			 clk_mul, real_gck_rate);
> -	}
> +
> +	gck_rate = clk_get_rate(priv->gck);
> +	if (priv->soc_data->baseclk_is_generated_internally)
> +		clk_base_rate = gck_rate / priv->soc_data->divider_for_baseclk;
> +	else
> +		clk_base_rate = clk_get_rate(priv->mainck);
> +
> +	clk_base = clk_base_rate / 1000000;
> +	clk_mul = gck_rate / clk_base_rate - 1;
> +
> +	caps0 &= (~SDHCI_CLOCK_V3_BASE_MASK);
> +	caps0 |= ((clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK);
> +	caps1 &= (~SDHCI_CLOCK_MUL_MASK);
> +	caps1 |= ((clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK);

The 4 assignments above do not need extra parentheses i.e.

	caps0 &= ~SDHCI_CLOCK_V3_BASE_MASK;
	caps0 |= (clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK;
	caps1 &= ~SDHCI_CLOCK_MUL_MASK;
	caps1 |= (clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK;

> +	/* Set capabilities in r/w mode. */
> +	writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
> +	writel(caps0, host->ioaddr + SDHCI_CAPABILITIES);
> +	writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
> +	/* Set capabilities in ro mode. */
> +	writel(0, host->ioaddr + SDMMC_CACR);
> +
> +	dev_info(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> +		 clk_mul, gck_rate, clk_base_rate);
>  
>  	/*
>  	 * We have to set preset values because it depends on the clk_mul
> @@ -207,19 +213,19 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	 * maximum sd clock value is 120 MHz instead of 208 MHz. For that
>  	 * reason, we need to use presets to support SDR104.
>  	 */
> -	preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
> +	preset_div = DIV_ROUND_UP(gck_rate, 24000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_SDR12);
> -	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +	preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_SDR25);
> -	preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
> +	preset_div = DIV_ROUND_UP(gck_rate, 100000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_SDR50);
> -	preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
> +	preset_div = DIV_ROUND_UP(gck_rate, 120000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_SDR104);
> -	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +	preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>  
> @@ -314,7 +320,7 @@ static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
>  static int sdhci_at91_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id	*match;
> -	const struct sdhci_pltfm_data	*soc_data;
> +	const struct sdhci_at91_soc_data	*soc_data;
>  	struct sdhci_host		*host;
>  	struct sdhci_pltfm_host		*pltfm_host;
>  	struct sdhci_at91_priv		*priv;
> @@ -325,17 +331,22 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	soc_data = match->data;
>  
> -	host = sdhci_pltfm_init(pdev, soc_data, sizeof(*priv));
> +	host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->soc_data = soc_data;
>  
>  	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
>  	if (IS_ERR(priv->mainck)) {
> -		dev_err(&pdev->dev, "failed to get baseclk\n");
> -		return PTR_ERR(priv->mainck);
> +		if (soc_data->baseclk_is_generated_internally) {
> +			priv->mainck = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "failed to get baseclk\n");
> +			return PTR_ERR(priv->mainck);
> +		}
>  	}
>  
>  	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
> 

