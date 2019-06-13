Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD89B2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfFMPdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:33:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:40396 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfFMKhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:37:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 03:37:44 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2019 03:37:41 -0700
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Manish Narani <manish.narani@xilinx.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        nava.manne@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <45b805fa-ce1d-98af-a53e-ebbb028bbe02@intel.com>
Date:   Thu, 13 Jun 2019 13:36:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 12:56 PM, Manish Narani wrote:
> Apart from taps set by auto tuning, ZynqMP platform has feature to set
> the tap values manually. Add support to read tap delay values from
> DT and set the same in HW via ZynqMP SoC framework. Reading Tap
> Delays from DT is optional, if the property is not available in DT the
> driver will use the pre-defined Tap Delay Values.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

OK for SDHCI:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 173 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 172 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b12abf9..7af6cec 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -22,6 +22,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
>  
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -32,6 +33,10 @@
>  
>  #define PHY_CLK_TOO_SLOW_HZ		400000
>  
> +/* Default settings for ZynqMP Tap Delays */
> +#define ZYNQMP_ITAP_DELAYS {0, 0x15, 0x15, 0, 0x15, 0, 0, 0x3D, 0x12, 0, 0}
> +#define ZYNQMP_OTAP_DELAYS {0, 0x5, 0x6, 0, 0x5, 0x3, 0x3, 0x4, 0x6, 0x3, 0}
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -81,6 +86,7 @@ struct sdhci_arasan_soc_ctl_map {
>   * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
> + * @of_data:		Platform specific runtime data storage pointer
>   */
>  struct sdhci_arasan_data {
>  	struct sdhci_host *host;
> @@ -101,6 +107,15 @@ struct sdhci_arasan_data {
>  /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
>   * internal clock even when the clock isn't stable */
>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
> +
> +	void *of_data;
> +};
> +
> +struct sdhci_arasan_zynqmp_data {
> +	void (*set_tap_delay)(struct sdhci_host *host);
> +	const struct zynqmp_eemi_ops *eemi_ops;
> +	u8 tapdly[MMC_TIMING_MMC_HS400 + 1][2]; /* [0] for input delay, */
> +						/* [1] for output delay */
>  };
>  
>  struct sdhci_arasan_of_data {
> @@ -209,6 +224,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  		sdhci_arasan->is_phy_on = false;
>  	}
>  
> +	/* Set the Input and Output Tap Delays */
> +	if (host->version >= SDHCI_SPEC_300 &&
> +	    host->timing != MMC_TIMING_LEGACY &&
> +	    host->timing != MMC_TIMING_UHS_SDR12) {
> +		struct sdhci_arasan_zynqmp_data *zynqmp_data =
> +			sdhci_arasan->of_data;
> +		if (zynqmp_data && zynqmp_data->set_tap_delay)
> +			zynqmp_data->set_tap_delay(host);
> +	}
> +
>  	sdhci_set_clock(host, clock);
>  
>  	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
> @@ -487,6 +512,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "arasan,sdhci-4.9a",
>  		.data = &sdhci_arasan_data,
>  	},
> +	{
> +		.compatible = "xlnx,zynqmp-8.9a",
> +		.data = &sdhci_arasan_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> @@ -517,6 +546,37 @@ static const struct clk_ops arasan_sdcardclk_ops = {
>  };
>  
>  /**
> + * sdhci_zynqmp_sdcardclk_set_phase - Set the SD Clock Tap Delays
> + *
> + * Set the SD Clock Tap Delays for Input and Output paths
> + *
> + * @hw:			Pointer to the hardware clock structure.
> + * @degrees		The clock phase shift between 0 - 359.
> + * Return: 0 on success and error value on error
> + */
> +static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
> +
> +{
> +	struct sdhci_arasan_data *sdhci_arasan =
> +		container_of(hw, struct sdhci_arasan_data, sdcardclk_hw);
> +	struct sdhci_arasan_zynqmp_data *zynqmp_data = sdhci_arasan->of_data;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_data->eemi_ops;
> +	const char *clk_name = clk_hw_get_name(hw);
> +	u32 device_id = !strcmp(clk_name, "clk_sd0") ? 0 : 1;
> +
> +	if (!eemi_ops->sdio_setphase)
> +		return -ENODEV;
> +
> +	/* Set the Clock Phase */
> +	return eemi_ops->sdio_setphase(device_id, degrees);
> +}
> +
> +static const struct clk_ops zynqmp_sdcardclk_ops = {
> +	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
> +	.set_phase = sdhci_zynqmp_sdcardclk_set_phase,
> +};
> +
> +/**
>   * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
>   *
>   * The corecfg_clockmultiplier is supposed to contain clock multiplier
> @@ -638,7 +698,10 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>  	sdcardclk_init.parent_names = &parent_clk_name;
>  	sdcardclk_init.num_parents = 1;
>  	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
> -	sdcardclk_init.ops = &arasan_sdcardclk_ops;
> +	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
> +		sdcardclk_init.ops = &zynqmp_sdcardclk_ops;
> +	else
> +		sdcardclk_init.ops = &arasan_sdcardclk_ops;
>  
>  	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
>  	sdhci_arasan->sdcardclk =
> @@ -714,6 +777,108 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>  	return ret;
>  }
>  
> +static void sdhci_arasan_zynqmp_set_tap_delay(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_arasan_zynqmp_data *zynqmp_data = sdhci_arasan->of_data;
> +
> +	clk_set_phase(sdhci_arasan->sdcardclk,
> +		      (int)zynqmp_data->tapdly[host->timing][0]);
> +	clk_set_phase(sdhci_arasan->sdcardclk,
> +		      (int)zynqmp_data->tapdly[host->timing][1] +
> +		      INPUT_TAP_BOUNDARY);
> +}
> +
> +static void arasan_dt_read_tap_delay(struct device *dev, u8 *tapdly,
> +				     const char *prop, u8 itap_def, u8 otap_def)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	tapdly[0] = itap_def;
> +	tapdly[1] = otap_def;
> +
> +	/*
> +	 * Read Tap Delay values from DT, if the DT does not contain the
> +	 * Tap Values then use the pre-defined values.
> +	 */
> +	if (of_property_read_variable_u8_array(np, prop, &tapdly[0], 2, 0)) {
> +		dev_dbg(dev, "Using predefined tapdly for %s = %d %d\n",
> +			prop, tapdly[0], tapdly[1]);
> +	}
> +}
> +
> +/**
> + * arasan_dt_parse_tap_delays - Read Tap Delay values from DT
> + *
> + * Called at initialization to parse the values of Tap Delays.
> + *
> + * @dev:		Pointer to our struct device.
> + */
> +static int arasan_dt_parse_tap_delays(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_arasan_zynqmp_data zynqmp_data;
> +	const struct zynqmp_eemi_ops *eemi_ops;
> +	u8 *itapdly, *otapdly;
> +	u32 mio_bank = 0;
> +
> +	eemi_ops = zynqmp_pm_get_eemi_ops();
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
> +
> +	itapdly = (u8 [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_ITAP_DELAYS;
> +	otapdly = (u8 [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_OTAP_DELAYS;
> +
> +	of_property_read_u32(pdev->dev.of_node, "xlnx,mio-bank", &mio_bank);
> +	if (mio_bank == 2) {
> +		otapdly[MMC_TIMING_UHS_SDR104] = 0x2;
> +		otapdly[MMC_TIMING_MMC_HS200] = 0x2;
> +	}
> +
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_MMC_HS],
> +				 "xlnx,tap-delay-mmc-hsd",
> +				 itapdly[MMC_TIMING_MMC_HS],
> +				 otapdly[MMC_TIMING_MMC_HS]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_SD_HS],
> +				 "xlnx,tap-delay-sd-hsd",
> +				 itapdly[MMC_TIMING_SD_HS],
> +				 otapdly[MMC_TIMING_SD_HS]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_UHS_SDR25],
> +				 "xlnx,tap-delay-sdr25",
> +				 itapdly[MMC_TIMING_UHS_SDR25],
> +				 otapdly[MMC_TIMING_UHS_SDR25]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_UHS_SDR50],
> +				 "xlnx,tap-delay-sdr50",
> +				 itapdly[MMC_TIMING_UHS_SDR50],
> +				 otapdly[MMC_TIMING_UHS_SDR50]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_UHS_SDR104],
> +				 "xlnx,tap-delay-sdr104",
> +				 itapdly[MMC_TIMING_UHS_SDR104],
> +				 otapdly[MMC_TIMING_UHS_SDR104]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_UHS_DDR50],
> +				 "xlnx,tap-delay-sd-ddr50",
> +				 itapdly[MMC_TIMING_UHS_DDR50],
> +				 otapdly[MMC_TIMING_UHS_DDR50]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_MMC_DDR52],
> +				 "xlnx,tap-delay-mmc-ddr52",
> +				 itapdly[MMC_TIMING_MMC_DDR52],
> +				 otapdly[MMC_TIMING_MMC_DDR52]);
> +	arasan_dt_read_tap_delay(dev, zynqmp_data.tapdly[MMC_TIMING_MMC_HS200],
> +				 "xlnx,tap-delay-mmc-hs200",
> +				 itapdly[MMC_TIMING_MMC_HS200],
> +				 otapdly[MMC_TIMING_MMC_HS200]);
> +
> +	zynqmp_data.set_tap_delay = sdhci_arasan_zynqmp_set_tap_delay;
> +	zynqmp_data.eemi_ops = eemi_ops;
> +	sdhci_arasan->of_data = &zynqmp_data;
> +
> +	return 0;
> +}
> +
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -806,6 +971,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto unreg_clk;
>  	}
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
> +		ret = arasan_dt_parse_tap_delays(&pdev->dev);
> +		if (ret)
> +			goto unreg_clk;
> +	}
> +
>  	sdhci_arasan->phy = ERR_PTR(-ENODEV);
>  	if (of_device_is_compatible(pdev->dev.of_node,
>  				    "arasan,sdhci-5.1")) {
> 

