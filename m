Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B36CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D6E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437552AbfJYIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:01:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:61901 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbfJYIBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:01:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="282192148"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2019 01:01:30 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuXJ-0001o3-IS; Fri, 25 Oct 2019 11:01:29 +0300
Date:   Fri, 25 Oct 2019 11:01:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove
 regulator
Message-ID: <20191025080129.GE32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> Add regulator driver for Intel Cherry Trail Whiskey Cove PMIC, which
> supplies various voltage rails.
> 
> This initial version supports only vsdio, which is required to source
> vqmmc for sd card interface.

This patch has some style issues. I will wait for Adrian and Hans to comment on
the approach as a whole and then we will see how to improve the rest.

> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> ---
>  drivers/regulator/Kconfig                     |  10 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/intel-cht-wc-regulator.c    | 433 ++++++++++++++++++
>  .../linux/regulator/intel-cht-wc-regulator.h  |  64 +++
>  4 files changed, 508 insertions(+)
>  create mode 100644 drivers/regulator/intel-cht-wc-regulator.c
>  create mode 100644 include/linux/regulator/intel-cht-wc-regulator.h
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 3ee63531f6d5..ae3d57f572df 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1077,6 +1077,16 @@ config REGULATOR_VEXPRESS
>  	  This driver provides support for voltage regulators available
>  	  on the ARM Ltd's Versatile Express platform.
>  
> +config REGULATOR_WHISKEY_COVE
> +	tristate "PMIC Whiskey Cove voltage regulator"
> +	depends on INTEL_SOC_PMIC_CHTWC
> +	help
> +	  This driver provides support for the voltage regulators of the
> +	  Intel Whiskey Cove PMIC. It is provided as an mfd cell of the
> +	  Intel Cherry Trail PMIC driver.
> +	  Only select this regulator driver if the MFD part is selected
> +	  in the Kernel configuration, it is meant to be operable as a cell.
> +
>  config REGULATOR_WM831X
>  	tristate "Wolfson Microelectronics WM831x PMIC regulators"
>  	depends on MFD_WM831X
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 2210ba56f9bd..380d536126c6 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -132,6 +132,7 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
>  obj-$(CONFIG_REGULATOR_UNIPHIER) += uniphier-regulator.o
>  obj-$(CONFIG_REGULATOR_VCTRL) += vctrl-regulator.o
>  obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
> +obj-$(CONFIG_REGULATOR_WHISKEY_COVE) += intel-cht-wc-regulator.o
>  obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
>  obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
>  obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
> diff --git a/drivers/regulator/intel-cht-wc-regulator.c b/drivers/regulator/intel-cht-wc-regulator.c
> new file mode 100644
> index 000000000000..5a66a6b37dc6
> --- /dev/null
> +++ b/drivers/regulator/intel-cht-wc-regulator.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * intel-cht-wc-regulator.c - CherryTrail regulator driver
> + *
> + * Copyright (c) 2019, Leica Geosystems AG
> + *
> + * Base on the non-upstreamed version from Intel,
> + * which was introduced for Intel Aero board.
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/regulator/intel-cht-wc-regulator.h>
> +
> +
> +/*
> + * Voltage Control regulator offsets
> + */
> +
> +/* buck boost regulators */
> +#define CHT_WC_V3P3A_CTRL	0x6e5e
> +/* buck regulators */
> +#define CHT_WC_V1P8A_CTRL	0x6e56
> +#define CHT_WC_V1P05A_CTRL	0x6e3b
> +#define CHT_WC_V1P15_CTRL	0x6e3c
> +#define CHT_WC_VDDQ_CTRL	0x6e58
> +/* boot regulators */
> +/* ldo regulators */
> +#define CHT_WC_VPROG1A_CTRL	0x6e90
> +#define CHT_WC_VPROG1B_CTRL	0x6e91
> +#define CHT_WC_VPROG1F_CTRL	0x6e95
> +#define CHT_WC_V1P8SX_CTRL	0x6e57
> +#define CHT_WC_V1P2A_CTRL	0x6e59
> +#define CHT_WC_V1P2SX_CTRL	0x6e5a
> +#define CHT_WC_VSDIO_CTRL	0x6e67
> +#define CHT_WC_V2P8SX_CTRL	0x6e5d
> +#define CHT_WC_V3P3SD_CTRL	0x6e5f
> +#define CHT_WC_VPROG2D_CTRL	0x6e99
> +#define CHT_WC_VPROG3A_CTRL	0x6e9a
> +#define CHT_WC_VPROG3B_CTRL	0x6e9b
> +#define CHT_WC_VPROG4A_CTRL	0x6e9c
> +#define CHT_WC_VPROG4B_CTRL	0x6e9d
> +#define CHT_WC_VPROG4C_CTRL	0x6e9e
> +#define CHT_WC_VPROG4D_CTRL	0x6e9f
> +#define CHT_WC_VPROG5A_CTRL	0x6ea0
> +#define CHT_WC_VPROG5B_CTRL	0x6ea1
> +#define CHT_WC_VPROG6A_CTRL	0x6ea2
> +#define CHT_WC_VPROG6B_CTRL	0x6ea3
> +
> +
> +/*
> + * Voltage Selector regulator offsets
> + */
> +
> +/* buck boost regulators */
> +#define CHT_WC_V3P3A_VSEL	0x6e68
> +/* buck regulators */
> +#define CHT_WC_V1P8A_VSEL	0x6e5b
> +#define CHT_WC_V1P05A_VSEL	0x6e3d
> +#define CHT_WC_V1P15_VSEL	0x6e3e
> +#define CHT_WC_VDDQ_VSEL		0x6e5c
> +/* boot regulators */
> +/* ldo regulators */
> +#define CHT_WC_VPROG1A_VSEL	0x6ec0
> +#define CHT_WC_VPROG1B_VSEL	0x6ec1
> +#define CHT_WC_V1P8SX_VSEL	0x6ec2
> +#define CHT_WC_V1P2SX_VSEL	0x6ec3
> +#define CHT_WC_V1P2A_VSEL	0x6ec4
> +#define CHT_WC_VPROG1F_VSEL	0x6ec5
> +#define CHT_WC_VSDIO_VSEL	0x6ec6
> +#define CHT_WC_V2P8SX_VSEL	0x6ec7
> +#define CHT_WC_V3P3SD_VSEL	0x6ec8
> +#define CHT_WC_VPROG2D_VSEL	0x6ec9
> +#define CHT_WC_VPROG3A_VSEL	0x6eca
> +#define CHT_WC_VPROG3B_VSEL	0x6ecb
> +#define CHT_WC_VPROG4A_VSEL	0x6ecc
> +#define CHT_WC_VPROG4B_VSEL	0x6ecd
> +#define CHT_WC_VPROG4C_VSEL	0x6ece
> +#define CHT_WC_VPROG4D_VSEL	0x6ecf
> +#define CHT_WC_VPROG5A_VSEL	0x6ed0
> +#define CHT_WC_VPROG5B_VSEL	0x6ed1
> +#define CHT_WC_VPROG6A_VSEL	0x6ed2
> +#define CHT_WC_VPROG6B_VSEL	0x6ed3
> +
> +
> +/* number of voltage variations exposed */
> +
> +/* buck boost regulators */
> +#define CHT_WC_V3P3A_VRANGE	8
> +/* buck regulators */
> +#define CHT_WC_V1P8A_VRANGE	256
> +#define CHT_WC_V1P05A_VRANGE	256
> +#define CHT_WC_VDDQ_VRANGE	120
> +/* boot regulators */
> +/* ldo regulators */
> +#define CHT_WC_VPROG1A_VRANGE	53
> +#define CHT_WC_VPROG1B_VRANGE	53
> +#define CHT_WC_VPROG1F_VRANGE	53
> +#define CHT_WC_V1P8SX_VRANGE	53
> +#define CHT_WC_V1P2SX_VRANGE	53
> +#define CHT_WC_V1P2A_VRANGE	53
> +#define CHT_WC_VSDIO_VRANGE	53
> +#define CHT_WC_V2P8SX_VRANGE	53
> +#define CHT_WC_V3P3SD_VRANGE	53
> +#define CHT_WC_VPROG2D_VRANGE	53
> +#define CHT_WC_VPROG3A_VRANGE	53
> +#define CHT_WC_VPROG3B_VRANGE	53
> +#define CHT_WC_VPROG4A_VRANGE	53
> +#define CHT_WC_VPROG4B_VRANGE	53
> +#define CHT_WC_VPROG4C_VRANGE	53
> +#define CHT_WC_VPROG4D_VRANGE	53
> +#define CHT_WC_VPROG5A_VRANGE	53
> +#define CHT_WC_VPROG5B_VRANGE	53
> +#define CHT_WC_VPROG6A_VRANGE	53
> +#define CHT_WC_VPROG6B_VRANGE	53
> +
> +
> +/* voltage tables */
> +static unsigned int CHT_WC_V3P3A_VSEL_TABLE[CHT_WC_V3P3A_VRANGE],
> +		    CHT_WC_V1P8A_VSEL_TABLE[CHT_WC_V1P8A_VRANGE],
> +		    CHT_WC_V1P05A_VSEL_TABLE[CHT_WC_V1P05A_VRANGE],
> +		    CHT_WC_VDDQ_VSEL_TABLE[CHT_WC_VDDQ_VRANGE],
> +		    CHT_WC_V1P8SX_VSEL_TABLE[CHT_WC_V1P8SX_VRANGE],
> +		    CHT_WC_V1P2SX_VSEL_TABLE[CHT_WC_V1P2SX_VRANGE],
> +		    CHT_WC_V1P2A_VSEL_TABLE[CHT_WC_V1P2A_VRANGE],
> +		    CHT_WC_V2P8SX_VSEL_TABLE[CHT_WC_V2P8SX_VRANGE],
> +		    CHT_WC_V3P3SD_VSEL_TABLE[CHT_WC_V3P3SD_VRANGE],
> +		    CHT_WC_VPROG1A_VSEL_TABLE[CHT_WC_VPROG1A_VRANGE],
> +		    CHT_WC_VPROG1B_VSEL_TABLE[CHT_WC_VPROG1B_VRANGE],
> +		    CHT_WC_VPROG1F_VSEL_TABLE[CHT_WC_VPROG1F_VRANGE],
> +		    CHT_WC_VPROG2D_VSEL_TABLE[CHT_WC_VPROG2D_VRANGE],
> +		    CHT_WC_VPROG3A_VSEL_TABLE[CHT_WC_VPROG3A_VRANGE],
> +		    CHT_WC_VPROG3B_VSEL_TABLE[CHT_WC_VPROG3B_VRANGE],
> +		    CHT_WC_VPROG4A_VSEL_TABLE[CHT_WC_VPROG4A_VRANGE],
> +		    CHT_WC_VPROG4B_VSEL_TABLE[CHT_WC_VPROG4B_VRANGE],
> +		    CHT_WC_VPROG4C_VSEL_TABLE[CHT_WC_VPROG4C_VRANGE],
> +		    CHT_WC_VPROG4D_VSEL_TABLE[CHT_WC_VPROG4D_VRANGE],
> +		    CHT_WC_VPROG5A_VSEL_TABLE[CHT_WC_VPROG5A_VRANGE],
> +		    CHT_WC_VPROG5B_VSEL_TABLE[CHT_WC_VPROG5B_VRANGE],
> +		    CHT_WC_VPROG6A_VSEL_TABLE[CHT_WC_VPROG6A_VRANGE],
> +		    CHT_WC_VPROG6B_VSEL_TABLE[CHT_WC_VPROG6B_VRANGE];
> +
> +/*
> + * VSDIO regulator description, voltage tables, consumers and constraints
> + */
> +/*
> + * The VSDIO regulator should only support 1.8V and 3.3V. All other
> + * voltages are invalid for sd card, so disable them here.
> + */
> +static unsigned int CHT_WC_VSDIO_VSEL_TABLE[CHT_WC_VSDIO_VRANGE] = {
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 1800000, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 3300000, 0, 0
> +};
> +
> +/* List the SD card interface as a consumer of vqmmc voltage source from VSDIO
> + * regulator. This is the only interface that requires this source on Cherry
> + * Trail to operate with UHS-I cards.
> + */
> +static struct regulator_consumer_supply cht_wc_vqmmc_supply_consumer[] = {
> +	REGULATOR_SUPPLY("vqmmc", "80860F14:02"),
> +};
> +
> +static struct regulator_init_data vqmmc_init_data = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 3300000,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE |
> +					REGULATOR_CHANGE_STATUS,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
> +		.settling_time		= 20000,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(cht_wc_vqmmc_supply_consumer),
> +	.consumer_supplies	= cht_wc_vqmmc_supply_consumer,
> +};
> +
> +static int cht_wc_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +
> +	int ret = regmap_update_bits(rdev->regmap, pmic_info->vctl_reg,
> +			pmic_info->vctl_mask, pmic_info->reg_enbl_mask);
> +	if (ret < 0)
> +		dev_err(&rdev->dev, "Failed to enable regulator %s: %d\n",
> +			pmic_info->desc.name, ret);
> +
> +	return ret;
> +}
> +
> +static int cht_wc_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +
> +	int ret = regmap_update_bits(rdev->regmap, pmic_info->vctl_reg,
> +			pmic_info->vctl_mask, pmic_info->reg_dsbl_mask);
> +	if (ret < 0)
> +		dev_err(&rdev->dev, "Failed to disable regulator %s: %d\n",
> +			pmic_info->desc.name, ret);
> +
> +	return ret;
> +}
> +
> +static int cht_wc_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +	int rval;
> +
> +	int ret = regmap_read(rdev->regmap, pmic_info->vctl_reg, &rval);
> +
> +	if (ret < 0) {
> +		dev_err(&rdev->dev, "Register 0x%04x read failed: %d\n",
> +			pmic_info->vsel_reg, ret);
> +		return ret;
> +	}
> +
> +	rval &= pmic_info->vctl_mask;
> +
> +	return rval & pmic_info->reg_enbl_mask;
> +}
> +
> +static int cht_wc_regulator_read_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +	int rval;
> +
> +	int ret = regmap_read(rdev->regmap, pmic_info->vsel_reg, &rval);
> +
> +	if (ret < 0) {
> +		dev_err(&rdev->dev, "Register 0x%04x read failed: %d\n",
> +			pmic_info->vsel_reg, ret);
> +		return ret;
> +	}
> +
> +	return (rval & pmic_info->vsel_mask) - pmic_info->start;
> +}
> +
> +static int cht_wc_regulator_set_voltage_sel(struct regulator_dev *rdev,
> +		unsigned int selector)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +
> +	int ret = regmap_update_bits(rdev->regmap, pmic_info->vsel_reg,
> +			pmic_info->vsel_mask, selector + pmic_info->start);
> +	if (ret < 0)
> +		dev_err(&rdev->dev, "Failed to set voltage for regulator %s: %d\n",
> +			pmic_info->desc.name, ret);
> +
> +	return ret;
> +}
> +
> +/* regulator ops */
> +static struct regulator_ops wcove_regulator_ops = {
> +	.enable			= cht_wc_regulator_enable,
> +	.disable		= cht_wc_regulator_disable,
> +	.is_enabled		= cht_wc_regulator_is_enabled,
> +	.get_voltage_sel	= cht_wc_regulator_read_voltage_sel,
> +	.set_voltage_sel	= cht_wc_regulator_set_voltage_sel,
> +	.list_voltage		= regulator_list_voltage_table,
> +};
> +
> +#define CHT_WC_REGULATOR(_id, minv, maxv, strt, vselmsk, vscale, \
> +				vctlmsk, enbl, dsbl, rt_flag, _init_data) \
> +{\
> +	.desc = {\
> +		.name		= ""#_id,\
> +		.ops		= &wcove_regulator_ops,\
> +		.type		= REGULATOR_VOLTAGE,\
> +		.id		= CHT_WC_REGULATOR_##_id,\
> +		.owner		= THIS_MODULE,\
> +	},\
> +	.rdev		= NULL, \
> +	.init_data	= (_init_data), \
> +	.vctl_reg	= CHT_WC_##_id##_CTRL,\
> +	.vsel_reg	= CHT_WC_##_id##_VSEL,\
> +	.min_mV		= (minv),\
> +	.max_mV		= (maxv),\
> +	.start		= (strt),\
> +	.vsel_mask	= (vselmsk),\
> +	.scale		= (vscale),\
> +	.nvolts		= CHT_WC_##_id##_VRANGE,\
> +	.vctl_mask	= (vctlmsk),\
> +	.reg_enbl_mask	= (enbl),\
> +	.reg_dsbl_mask	= (dsbl),\
> +	.vtable		= CHT_WC_##_id##_VSEL_TABLE,\
> +	.runtime_table	= (rt_flag),\
> +}
> +
> +/* Regulator descriptions */
> +static struct ch_wc_regulator_info regulators_info[] = {
> +	CHT_WC_REGULATOR(V3P3A,    3000, 3350, 0x00, 0x07, 50, 0x01, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V1P8A,    250,  2100, 0x00, 0xff, 10, 0x01, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V1P05A,   250,  2100, 0x00, 0xff, 10, 0x01, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VDDQ,     250,  1440, 0x00, 0x7f, 10, 0x01, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V1P8SX,   800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V1P2A,    800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V1P2SX,   800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(V2P8SX,   800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VSDIO,    800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, false, &vqmmc_init_data),
> +	CHT_WC_REGULATOR(V3P3SD,   800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG1A,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG1B,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG1F,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG2D,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG3A,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG3B,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG4A,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG4B,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG4C,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG4D,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG5A,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG5B,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG6A,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +	CHT_WC_REGULATOR(VPROG6B,  800,  3400, 0x0b, 0x3f, 50, 0x07, 0x01, 0x0, true,  NULL),
> +};
> +
> +static inline struct ch_wc_regulator_info *cht_wc_find_regulator_info(int id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(regulators_info); i++) {
> +		if (regulators_info[i].desc.id == id)
> +			return &regulators_info[i];
> +	}
> +	return NULL;
> +}
> +
> +static void initialize_vtable(struct ch_wc_regulator_info *reg_info)
> +{
> +	unsigned int i, volt;
> +
> +	if (reg_info->runtime_table == true) {
> +		for (i = 0; i < reg_info->nvolts; i++) {
> +			volt = reg_info->min_mV + (i * reg_info->scale);
> +			if (volt < reg_info->min_mV)
> +				volt = reg_info->min_mV;
> +			if (volt > reg_info->max_mV)
> +				volt = reg_info->max_mV;
> +			/* set value in uV */
> +			reg_info->vtable[i] = volt*1000;
> +		}
> +	}
> +	reg_info->desc.volt_table = reg_info->vtable;
> +	reg_info->desc.n_voltages = reg_info->nvolts;
> +}
> +
> +static int cht_wc_regulator_probe(struct platform_device *pdev)
> +{
> +	struct ch_wc_regulator_info *regulator;
> +	struct regulator_config config = { };
> +
> +	struct ch_wc_regulator_info *reg_info =
> +		cht_wc_find_regulator_info(pdev->id);
> +
> +	if (reg_info == NULL)
> +		return -EINVAL;
> +
> +	regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
> +	if (!regulator)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, regulator);
> +
> +	initialize_vtable(reg_info);
> +
> +	config.dev = &pdev->dev;
> +	config.driver_data = reg_info;
> +	config.init_data = reg_info->init_data;
> +
> +	regulator->rdev = regulator_register(&reg_info->desc, &config);
> +
> +	if (IS_ERR(regulator->rdev)) {
> +		dev_err(&pdev->dev, "failed to register regulator as %s\n",
> +				reg_info->desc.name);
> +		return PTR_ERR(regulator->rdev);
> +	}
> +
> +	dev_dbg(&pdev->dev, "registered Whiskey Cove regulator as %s\n",
> +			dev_name(&regulator->rdev->dev));
> +
> +	return 0;
> +}
> +
> +static int cht_wc_regulator_remove(struct platform_device *pdev)
> +{
> +	regulator_unregister(platform_get_drvdata(pdev));
> +	return 0;
> +}
> +
> +static const struct platform_device_id cht_wc_regulator_id_table[] = {
> +	{
> +		.name = "cht_wcove_regulator"
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, wcove_regulator_id_table);
> +
> +static struct platform_driver cht_wc_regulator_driver = {
> +	.driver = {
> +		.name = "cht_wcove_regulator",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe    = cht_wc_regulator_probe,
> +	.remove   = cht_wc_regulator_remove,
> +	.id_table = cht_wc_regulator_id_table,
> +};
> +
> +static int __init cht_wc_regulator_init(void)
> +{
> +	return platform_driver_register(&cht_wc_regulator_driver);
> +}
> +subsys_initcall_sync(cht_wc_regulator_init);
> +
> +static void __exit cht_wc_regulator_exit(void)
> +{
> +	platform_driver_unregister(&cht_wc_regulator_driver);
> +}
> +module_exit(cht_wc_regulator_exit);
> +
> +MODULE_ALIAS("platform:cht-wc-regulator");
> +MODULE_DESCRIPTION("Intel Cherry Trail Whiskey Cove Regulator driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com");
> +MODULE_AUTHOR("Nitheesh K L <nitheesh.k.l@intel.com");
> diff --git a/include/linux/regulator/intel-cht-wc-regulator.h b/include/linux/regulator/intel-cht-wc-regulator.h
> new file mode 100644
> index 000000000000..0f6b3be11fea
> --- /dev/null
> +++ b/include/linux/regulator/intel-cht-wc-regulator.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * intel-cht-wc-regulator.h - Cherry Trail Whiskey Cove PMIC regulator
> + *
> + * Copyright (c) 2019, Leica Geosystems AG
> + *
> + * Base on the non-upstreamed version from Intel, which was
> + * introduced for Intel Aero board.
> + * Copyright (c) 2014, Intel Corporation.
> + */
> +
> +#ifndef __LINUX_REGULATOR_INTEL_CHT_WC_H_
> +#define __LINUX_REGULATOR_INTEL_CHT_WC_H_
> +
> +#include <linux/regulator/driver.h>
> +
> +enum {
> +	CHT_WC_REGULATOR_V1P8A = 1,
> +	CHT_WC_REGULATOR_V1P05A,
> +	CHT_WC_REGULATOR_V1P15,
> +	CHT_WC_REGULATOR_VDDQ,
> +	CHT_WC_REGULATOR_V3P3A,
> +	CHT_WC_REGULATOR_VPROG1A,
> +	CHT_WC_REGULATOR_VPROG1B,
> +	CHT_WC_REGULATOR_VPROG1F,
> +	CHT_WC_REGULATOR_V1P8SX,
> +	CHT_WC_REGULATOR_V1P2SX,
> +	CHT_WC_REGULATOR_V1P2A,
> +	CHT_WC_REGULATOR_VSDIO,
> +	CHT_WC_REGULATOR_V2P8SX,
> +	CHT_WC_REGULATOR_V3P3SD,
> +	CHT_WC_REGULATOR_VPROG2D,
> +	CHT_WC_REGULATOR_VPROG3A,
> +	CHT_WC_REGULATOR_VPROG3B,
> +	CHT_WC_REGULATOR_VPROG4A,
> +	CHT_WC_REGULATOR_VPROG4B,
> +	CHT_WC_REGULATOR_VPROG4C,
> +	CHT_WC_REGULATOR_VPROG4D,
> +	CHT_WC_REGULATOR_VPROG5A,
> +	CHT_WC_REGULATOR_VPROG5B,
> +	CHT_WC_REGULATOR_VPROG6A,
> +	CHT_WC_REGULATOR_VPROG6B,
> +};
> +
> +struct ch_wc_regulator_info {
> +	struct regulator_desc desc;
> +	struct regulator_dev *rdev;
> +	struct regulator_init_data *init_data;
> +	unsigned int vctl_reg;
> +	unsigned int vsel_reg;
> +	unsigned int min_mV;
> +	unsigned int max_mV;
> +	unsigned int start;
> +	unsigned int vsel_mask;
> +	unsigned int scale;
> +	unsigned int nvolts;
> +	unsigned int vctl_mask;
> +	unsigned int reg_enbl_mask;
> +	unsigned int reg_dsbl_mask;
> +	unsigned int *vtable;
> +	bool runtime_table;
> +};
> +
> +#endif /* __LINUX_REGULATOR_INTEL_CHT_WC_H_ */
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


