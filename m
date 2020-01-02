Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BAC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C1215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgABLnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:43:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41941 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgABLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:43:15 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1imysj-00019a-0J; Thu, 02 Jan 2020 12:43:13 +0100
Message-ID: <fe55d2c00eda2d1b94e69fe2df05114ba88b5128.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/2] reset: intel: Add system reset controller driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, martin.blumenstingl@googlemail.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Date:   Thu, 02 Jan 2020 12:43:11 +0100
In-Reply-To: <decb025c9bd0ddc1da96801e57242bc8f5ce35d0.1576202050.git.eswara.kota@linux.intel.com>
References: <a58894158cba812e6d35df165252772b07c8a0b6.1576202050.git.eswara.kota@linux.intel.com>
         <decb025c9bd0ddc1da96801e57242bc8f5ce35d0.1576202050.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 14:55 +0800, Dilip Kota wrote:
> Add driver for the reset controller present on Intel
> Gateway SoCs for performing reset management of the
> devices present on the SoC. Driver also registers a
> reset handler to peform the entire device reset.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v5:
> 	Rebase patches on v5.5-rc1 kernel
> 
> Changes on v4:
> 	No Change
> 
> Changes on v3:
> 	Address review comments:
> 		Remove intel_reset_device() as not supported
> 	reset-intel-syscon.c renamed to reset-intel-gw.c
> 	Remove syscon and add regmap logic
> 	Add support to legacy xrx200 SoC
> 	Use bitfield helper functions for bit operations.
> 	Change config RESET_INTEL_SYSCON-> RESET_INTEL_GW
>  drivers/reset/Kconfig          |   9 ++
>  drivers/reset/Makefile         |   1 +
>  drivers/reset/reset-intel-gw.c | 262 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/reset/reset-intel-gw.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3ad7817ce1f0..218571cda38d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -64,6 +64,15 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
>  
> +config RESET_INTEL_GW
> +	bool "Intel Reset Controller Driver"
> +	depends on OF
> +	select REGMAP_MMIO
> +	help
> +	  This enables the reset controller driver for Intel Gateway SoCs.
> +	  Say Y to control the reset signals provided by reset controller.
> +	  Otherwise, say N.
> +
>  config RESET_LANTIQ
>  	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>  	default SOC_TYPE_XWAY
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index cf60ce526064..a196d545b4b8 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> +obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
> diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
> new file mode 100644
> index 000000000000..da285833cd22
> --- /dev/null
> +++ b/drivers/reset/reset-intel-gw.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Intel Corporation.
> + * Lei Chuanhua <Chuanhua.lei@intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#define RCU_RST_STAT	0x0024
> +#define RCU_RST_REQ	0x0048
> +
> +#define REG_OFFSET	GENMASK(31, 16)
> +#define BIT_OFFSET	GENMASK(15, 8)
> +#define STAT_BIT_OFFSET	GENMASK(7, 0)
> +
> +#define to_reset_data(x)	container_of(x, struct intel_reset_data, rcdev)
> +
> +struct intel_reset_soc {
> +	bool legacy;
> +	u32 reset_cell_count;
> +};
> +
> +struct intel_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct notifier_block restart_nb;
> +	const struct intel_reset_soc *soc_data;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	u32 reboot_id;
> +};
> +
> +static const struct regmap_config intel_rcu_regmap_config = {
> +	.name =		"intel-reset",
> +	.reg_bits =	32,
> +	.reg_stride =	4,
> +	.val_bits =	32,
> +	.fast_io =	true,
> +};
> +
> +/*
> + * Reset status register offset relative to
> + * the reset control register(X) is X + 4
> + */
> +static u32 id_to_reg_and_bit_offsets(struct intel_reset_data *data,
> +				     unsigned long id, u32 *rst_req,
> +				     u32 *req_bit, u32 *stat_bit)
> +{
> +	*rst_req = FIELD_GET(REG_OFFSET, id);
> +	*req_bit = FIELD_GET(BIT_OFFSET, id);
> +
> +	if (data->soc_data->legacy)
> +		*stat_bit = FIELD_GET(STAT_BIT_OFFSET, id);
> +	else
> +		*stat_bit = *req_bit;
> +
> +	if (data->soc_data->legacy && *rst_req == RCU_RST_REQ)
> +		return RCU_RST_STAT;
> +	else
> +		return *rst_req + 0x4;
> +}
> +
> +static int intel_set_clr_bits(struct intel_reset_data *data,
> +			      unsigned long id, bool set, u64 timeout)
> +{
> +	u32 rst_req, req_bit, rst_stat, stat_bit, val;
> +	int ret;
> +
> +	rst_stat = id_to_reg_and_bit_offsets(data, id, &rst_req,
> +					     &req_bit, &stat_bit);
> +
> +	val = set ? BIT(req_bit) : 0;
> +	ret = regmap_update_bits(data->regmap, rst_req,  BIT(req_bit), val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(data->regmap, rst_stat, val,
> +					set == !!(val & BIT(stat_bit)),
> +					20, timeout);
> +}
> +
> +static int intel_assert_device(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct intel_reset_data *data = to_reset_data(rcdev);
> +	int ret;
> +
> +	ret = intel_set_clr_bits(data, id, true, 200);

timeout doesn't have to be a parameter to intel_set_clr_bits.

[...]
> +struct intel_reset_soc xrx200_data = {
> +	.legacy =		true,
> +	.reset_cell_count =	3,
> +};
> +
> +struct intel_reset_soc lgm_data = {
> +	.legacy =		false,
> +	.reset_cell_count =	2,
> +};

Please make these two static const, otherwise this looks fine to me.

regards
Philipp

