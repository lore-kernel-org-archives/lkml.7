Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D43C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A447720665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfGANch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:32:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:38071 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfGANcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 06:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="361834699"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2019 06:32:33 -0700
Subject: Re: [PATCH 3/3] mmc: sdhci-sprd: Add pin control support for voltage
 switch
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1561094029.git.baolin.wang@linaro.org>
 <db6d2b2d6170fd2409916c5c41b857f4bc587a15.1561094029.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bc6ae189-ca6b-5447-907e-41ec05b2926c@intel.com>
Date:   Mon, 1 Jul 2019 16:31:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <db6d2b2d6170fd2409916c5c41b857f4bc587a15.1561094029.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 9:12 AM, Baolin Wang wrote:
> For Spreadtrum SD card voltage switching, besides regulator setting,
> it also need switch related pin's state to output corresponding voltage.
> 
> This patch adds pin control operation to support voltage switch.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 8b23c88..6ee340a 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> @@ -72,6 +73,9 @@ struct sdhci_sprd_host {
>  	struct clk *clk_sdio;
>  	struct clk *clk_enable;
>  	struct clk *clk_2x_enable;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_uhs;
> +	struct pinctrl_state *pins_default;
>  	u32 base_rate;
>  	int flags; /* backup of host attribute */
>  	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> @@ -405,6 +409,8 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
>  	int ret;
>  
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
> @@ -416,6 +422,37 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  	}
>  
> +	if (IS_ERR(sprd_host->pinctrl))
> +		return 0;
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		ret = pinctrl_select_state(sprd_host->pinctrl,
> +					   sprd_host->pins_uhs);
> +		if (ret) {
> +			pr_err("%s: failed to select uhs pin state\n",
> +			       mmc_hostname(mmc));
> +			return ret;
> +		}
> +		break;
> +
> +	default:
> +		/* fall-through */
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		ret = pinctrl_select_state(sprd_host->pinctrl,
> +					   sprd_host->pins_default);
> +		if (ret) {
> +			pr_err("%s: failed to select default pin state\n",
> +			       mmc_hostname(mmc));
> +			return ret;
> +		}
> +		break;
> +	}
> +
> +	/* Wait for 300 ~ 500 us for pin state stable */
> +	usleep_range(300, 500);
> +	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
>  	return 0;
>  }
>  
> @@ -504,6 +541,23 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	sprd_host = TO_SPRD_HOST(host);
>  	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
>  
> +	sprd_host->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR(sprd_host->pinctrl)) {
> +		sprd_host->pins_uhs =
> +			pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
> +		if (IS_ERR(sprd_host->pins_uhs)) {
> +			ret = PTR_ERR(sprd_host->pins_uhs);
> +			goto pltfm_free;
> +		}
> +
> +		sprd_host->pins_default =
> +			pinctrl_lookup_state(sprd_host->pinctrl, "default");
> +		if (IS_ERR(sprd_host->pins_default)) {
> +			ret = PTR_ERR(sprd_host->pins_default);
> +			goto pltfm_free;
> +		}
> +	}
> +
>  	clk = devm_clk_get(&pdev->dev, "sdio");
>  	if (IS_ERR(clk)) {
>  		ret = PTR_ERR(clk);
> 

