Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B632DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B51F22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403907AbfHWInu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:43:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43191 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbfHWInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:43:49 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i15Ae-00034N-6Z; Fri, 23 Aug 2019 10:43:44 +0200
Message-ID: <1566549822.3023.2.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dilip Kota <eswara.kota@linux.intel.com>, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Date:   Fri, 23 Aug 2019 10:43:42 +0200
In-Reply-To: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
References: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
         <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dilip,

On Fri, 2019-08-23 at 13:28 +0800, Dilip Kota wrote:
> Add driver for the reset controller present on Intel
> Lightening Mountain (LGM) SoC for performing reset
> management of the devices present on the SoC. Driver also
> registers a reset handler to peform the entire device reset.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>

thank you for the patch, I have a few questions/suggestions below:

> ---
> Changes on v2:
> 	No changes
> 
>  drivers/reset/Kconfig              |  10 ++
>  drivers/reset/Makefile             |   1 +
>  drivers/reset/reset-intel-syscon.c | 215 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 drivers/reset/reset-intel-syscon.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 6d5d76db55b0..e0fd14cb4cf5 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -64,6 +64,16 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
>  
> +config RESET_INTEL_SYSCON
> +	bool "Intel SYSCON Reset Driver"
> +	depends on HAS_IOMEM
> +	select MFD_SYSCON
> +	help
> +	  This enables the reset driver support for Intel SoC devices with
> +	  memory-mapped reset registers as part of a syscon device node. If
> +	  you wish to use the reset framework for such memory-mapped devices,
> +	  say Y here. Otherwise, say N.

Is this driver really as generic as this description makes it sound,
or is it limited to LGM?

Do you expect this to be reused by other platforms? The timeouts,
status register offsets, and readback mechanism might be platform
specific.

> +
>  config RESET_LANTIQ
>  	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>  	default SOC_TYPE_XWAY
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 61456b8f659c..6d68c50c7e89 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> +obj-$(CONFIG_RESET_INTEL_SYSCON) += reset-intel-syscon.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
> diff --git a/drivers/reset/reset-intel-syscon.c b/drivers/reset/reset-intel-syscon.c
> new file mode 100644
> index 000000000000..6377a0cac1e7
> --- /dev/null
> +++ b/drivers/reset/reset-intel-syscon.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Intel Corporation.
> + * Lei Chuanhua <Chuanhua.lei@intel.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +struct intel_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct notifier_block restart_nb;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 reboot_id;
> +};
> +
> +/* reset platform data */
> +#define to_reset_data(x)	container_of(x, struct intel_reset_data, rcdev)
> +
> +/*
> + * Reset status register offset relative to
> + * the reset control register(X) is X + 4
> + */
> +static inline u32 id_to_reg_bit_and_offset(unsigned long id,
> +					   u32 *regbit, u32 *regoff)
> +{
> +	*regoff = id >> 8;
> +	*regbit = id & 0x1f;
> +	return *regoff + 0x4;
> +}
> +
> +static int intel_set_clr_bits(struct intel_reset_data *data,
> +			      unsigned long id, bool set, u64 timeout)
> +{
> +	u32 regoff, regbit;
> +	u32 stat_off;
> +	u32 val;
> +	int ret;
> +
> +	stat_off = id_to_reg_bit_and_offset(id, &regbit, &regoff);
> +
> +	val = set ? BIT(regbit) : 0;
> +	ret = regmap_update_bits(data->regmap, regoff,  BIT(regbit), val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(data->regmap, stat_off, val,
> +					set == !!(val & BIT(regbit)),
> +					20, timeout);
> +}
> +
> +static int intel_assert_device(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct intel_reset_data *data = to_reset_data(rcdev);
> +	int ret;
> +
> +	ret = intel_set_clr_bits(data, id, 1, 200);

Since set is of type bool, I'd use true instead of 1.

> +	if (ret)
> +		dev_err(data->dev, "Failed to set reset assert bit %d\n", ret);
> +	return ret;
> +}
> +
[...]
> +
> +static int intel_reset_device(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct intel_reset_data *data = to_reset_data(rcdev);
> +	int ret;
> +
> +	ret = intel_set_clr_bits(data, id, 1, 20000);
> +	if (ret)
> +		dev_err(data->dev, "Failed to reset device %d\n", ret);
> +	return ret;
> +}

This doesn't seem right. _assert and _reset are doing exactly the same
thing, except for allowing a different timeout. Depending on whether any
individual reset control bit is a (possibly self-clearing) trigger or
directly controls the reset signal, either one or the other doesn't do
the expected thing.

Do you have self-clearing and direct-control reset bits mixed in the
same register space? If so, _reset should either return -EOPNOTSUPP for
the direct-control bits or implement an assert-delay-deassert sequence.
_assert and _deassert should return -EOPNOTSUPP for self-clearing reset
bits.

> +
> +static int intel_reset_status(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct intel_reset_data *data = to_reset_data(rcdev);
> +	u32 regoff, regbit;
> +	u32 stat_off;
> +	u32 val;
> +	int ret;
> +
> +	stat_off = id_to_reg_bit_and_offset(id, &regbit, &regoff);
> +	ret = regmap_read(data->regmap, stat_off, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(val & BIT(regbit));
> +}
> +
> +static const struct reset_control_ops intel_reset_ops = {
> +	.reset		= intel_reset_device,
> +	.assert		= intel_assert_device,
> +	.deassert	= intel_deassert_device,
> +	.status		= intel_reset_status,
> +};
> +
> +static int intel_reset_xlate(struct reset_controller_dev *rcdev,
> +			     const struct of_phandle_args *spec)
> +{
> +	u32 offset, bit;
> +
> +	offset = spec->args[0];
> +	bit = spec->args[1];
> +
> +	return (offset << 8) | (bit & 0x1f);

Instead of wrapping around for invalid bit offsets, better return
-EINVAL if (offset >= rcdev->nr_resets || bit > 31).

> +}
> +
> +static int intel_reset_restart_handler(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct intel_reset_data *reset_data =
> +		container_of(nb, struct intel_reset_data, restart_nb);
> +
> +	intel_assert_device(&reset_data->rcdev, reset_data->reboot_id);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int intel_reset_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct intel_reset_data *data;
> +	struct regmap *regmap;
> +	u32 rb_id[2];
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to get reset controller regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = device_property_read_u32_array(dev, "intel,global-reset",
> +					     rb_id, ARRAY_SIZE(rb_id));
> +	if (ret) {
> +		dev_err(dev, "Failed to get global reset offset!\n");
> +		return ret;
> +	}
> +
> +	data->dev		= dev;
> +	data->reboot_id		= (rb_id[0] << 8) | rb_id[1];
> +	data->regmap		= regmap;
> +	data->rcdev.of_node	= np;
> +	data->rcdev.owner	= dev->driver->owner;
> +	data->rcdev.ops		= &intel_reset_ops;
> +	data->rcdev.of_xlate	= intel_reset_xlate;
> +	data->rcdev.of_reset_n_cells = 2;
> +
> +	ret = devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +	if (ret)
> +		return ret;
> +
> +	data->restart_nb.notifier_call	= intel_reset_restart_handler;
> +	data->restart_nb.priority	= 128;
> +
> +	register_restart_handler(&data->restart_nb);
> +
> +	return ret;

Could be "return 0;".

> +}
> +
> +static const struct of_device_id intel_reset_match[] = {
> +	{ .compatible = "intel,rcu-lgm" },
> +	{}
> +};
> +
> +static struct platform_driver intel_reset_driver = {
> +	.probe = intel_reset_probe,
> +	.driver = {
> +		.name = "intel-reset-syscon",
> +		.of_match_table = intel_reset_match,
> +	},
> +};
> +
> +static int __init intel_reset_init(void)
> +{
> +	return platform_driver_register(&intel_reset_driver);
> +}
> +
> +/*
> + * RCU is system core entity which is in Always On Domain whose clocks
> + * or resource initialization happens in system core initialization.
> + * Also, it is required for most of the platform or architecture
> + * specific devices to perform reset operation as part of initialization.
> + * So perform RCU as post core initialization.
> + */
> +postcore_initcall(intel_reset_init);

regards
Philipp
