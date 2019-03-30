Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC64C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C19A218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971433;
	bh=uf+FLjcaY4nmKfUlvOPdRaWPVe4q2gCDMm2j+kj9EE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uKZFlYKzJPO561nprf3sqxTHQCm8eRa82DyEEQWkte7XsP8wN6KK1XyhjbUNtSkei
	 Mrizc+i4X1IwHemzg6sMHmbs2DgLsF6DgFpueFH2+heFJjN56uLMB9fdNWJRMhhm6c
	 lFsNz7zFLM7euXtMZBSm+w4FaGJc9tPVkOMdDxwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfC3Snw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfC3Snw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:43:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA1A2184C;
        Sat, 30 Mar 2019 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971430;
        bh=uf+FLjcaY4nmKfUlvOPdRaWPVe4q2gCDMm2j+kj9EE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k3zFvb2NKTZSg7wEpz/kpxeWxgzRjXSxKLRWgyqxFGpmXLS5wvXOuA/0T48d85Hzj
         5f8inLZ6pm/Mxleqo9qVTH6jlgbx+gsRKTAxxFoZ+0cvecMCcWKM9DKIOMmAqroMiR
         J0Vrzk2UBg4v38oSuN1fNIkji7bIh2LTHeURv8l8=
Date:   Sat, 30 Mar 2019 18:43:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shinji Kanematsu <kanematsu.shinji@socionext.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 2/2] iio: counter: Add support for Milbeaut Updown
 Counter
Message-ID: <20190330184344.7c98aa58@archlinux>
In-Reply-To: <1553582012-13563-1-git-send-email-kanematsu.shinji@socionext.com>
References: <1553582012-13563-1-git-send-email-kanematsu.shinji@socionext.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 15:33:32 +0900
Shinji Kanematsu <kanematsu.shinji@socionext.com> wrote:

> Add support for Milbeaut Updown Counter, that can be used as counter
> or quadrature encoder.
> 
> Signed-off-by: Shinji Kanematsu <kanematsu.shinji@socionext.com>
A few minor comments inline.  The counter subsystem will provide a cleaner
way of describing this. Please look to that for v2.

Hopefully William will give some feedback as well.

Jonathan
> ---
>  drivers/iio/counter/Kconfig               |  12 +
>  drivers/iio/counter/Makefile              |   1 +
>  drivers/iio/counter/milbeaut-updown.h     |  38 +++
>  drivers/iio/counter/milbeaut-updown_cnt.c | 385 ++++++++++++++++++++++++++++++
>  4 files changed, 436 insertions(+)
>  create mode 100644 drivers/iio/counter/milbeaut-updown.h
>  create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c
> 
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index bf1e559..a665f61 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -31,4 +31,16 @@ config STM32_LPTIMER_CNT
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
> +
> +config MILBEAUT_UPDOWN_CNT
> +	tristate "Milbeaut Updown Counter driver"
> +	depends on OF
> +	depends on ARCH_MILBEAUT || COMPILE_TEST
> +	help
> +	  Select this option to enable Milbeaut Updown Counter quadrature encoder
> +	  and counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called milbeaut-updown-cnt.
> +
>  endmenu
> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
> index 1b9a896..0cb708b 100644
> --- a/drivers/iio/counter/Makefile
> +++ b/drivers/iio/counter/Makefile
> @@ -6,3 +6,4 @@
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> +obj-$(CONFIG_MILBEAUT_UPDOWN_CNT)	+= milbeaut-updown_cnt.o
> diff --git a/drivers/iio/counter/milbeaut-updown.h b/drivers/iio/counter/milbeaut-updown.h
> new file mode 100644
> index 0000000..9a038ad
> --- /dev/null
> +++ b/drivers/iio/counter/milbeaut-updown.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Milbeaut Updown parent driver
> + * Copyright (C) 2019 Socionext Inc.
> + */
> +
> +#ifndef _LINUX_MILBEAUT_UPDOWN_H_
> +#define _LINUX_MILBEAUT_UPDOWN_H_
> +
> +#define MLB_UPDOWN_UDCR		0x0		/* Updown Count Reg		*/
> +#define MLB_UPDOWN_RCR		0x4		/* Reload Compare Reg	*/
> +#define MLB_UPDOWN_CSR		0xC		/* Counter Status Reg	*/
> +#define MLB_UPDOWN_CCR		0x14	/* Counter Control Reg	*/
> +
> +/* MLB_UPDOWN_CSR - bit fields */
> +#define MLB_UPDOWN_CSTR		BIT(7)
> +#define MLB_UPDOWN_UDIE		BIT(5)
> +#define MLB_UPDOWN_CMPF		BIT(4)
> +#define MLB_UPDOWN_OVFF		BIT(3)
> +#define MLB_UPDOWN_UDFF		BIT(2)
> +
> +/* MLB_UPDOWN_CCR - bit fields */
> +#define MLB_UPDOWN_FIXED	BIT(15)
> +#define MLB_UPDOWN_CMS		GENMASK(11, 10)
> +#define MLB_UPDOWN_CES		GENMASK(9, 8)
> +#define MLB_UPDOWN_CTUT		BIT(6)
> +#define MLB_UPDOWN_RLDE		BIT(4)
> +
> +/* MLB_UPDOWN max count value */
> +#define MLB_UPDOWN_MAX_COUNT	0xFFFF
> +
> +/* MLB_UPDOWN rising edge detection */
> +#define MLB_UPDOWN_RISING_EDGE		BIT(9)
> +
> +/* MLB_UPDOWN mode */
> +#define MLB_UPDOWN_MODE		1
> +
> +#endif
> diff --git a/drivers/iio/counter/milbeaut-updown_cnt.c b/drivers/iio/counter/milbeaut-updown_cnt.c
> new file mode 100644
> index 0000000..a58709a
> --- /dev/null
> +++ b/drivers/iio/counter/milbeaut-updown_cnt.c
> @@ -0,0 +1,385 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Milbeaut Updown counter driver
> + *
> + * Copyright (C) 2019 Socionext Inc.
I'm fussy about pointless lines.  The one below doesn't add anything ;)
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "milbeaut-updown.h"
> +
> +#define MILBEAUT_UPDOWN_IRQ_NAME		"milbeaut_updown_event"
> +#define MILBEAUT_UPDOWN_MAX_REGISTER	0x1f
> +
> +static const struct regmap_config milbeaut_updown_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = MILBEAUT_UPDOWN_MAX_REGISTER,
> +};
> +struct milbeaut_updown_cnt {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	u32 preset;
> +	u32 polarity;
> +	u32 quadrature_mode;
> +};
> +
> +static int milbeaut_updown_is_enabled(struct milbeaut_updown_cnt *priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, MLB_UPDOWN_CSR, &val);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(MLB_UPDOWN_CSTR, val);
> +}
> +
> +static int milbeaut_updown_setup(struct milbeaut_updown_cnt *priv,
> +									int val)
> +{
> +	int ret;
> +
> +	if (val) {
> +		ret = regmap_update_bits(priv->regmap, MLB_UPDOWN_CCR,
> +				MLB_UPDOWN_CMS | MLB_UPDOWN_RLDE,
> +				FIELD_PREP(MLB_UPDOWN_CMS, priv->quadrature_mode) |
> +				MLB_UPDOWN_RLDE);
> +		if (ret)
> +			return ret;
> +
> +		if (priv->quadrature_mode == MLB_UPDOWN_MODE) {
> +			ret = regmap_update_bits(priv->regmap, MLB_UPDOWN_CCR,
> +					MLB_UPDOWN_CES, MLB_UPDOWN_RISING_EDGE);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_write(priv->regmap, MLB_UPDOWN_RCR, priv->preset);
> +		if (ret)
> +			return ret;
> +
> +		/* interrupt */
> +		ret = regmap_update_bits(priv->regmap, MLB_UPDOWN_CSR,
> +						MLB_UPDOWN_UDIE, MLB_UPDOWN_UDIE);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(priv->regmap, MLB_UPDOWN_CCR,
> +			MLB_UPDOWN_CTUT | MLB_UPDOWN_FIXED,
> +			MLB_UPDOWN_CTUT | MLB_UPDOWN_FIXED);
> +		if (ret)
> +			return ret;
> +
> +		val = MLB_UPDOWN_CSTR;
> +	}
> +
> +	return regmap_update_bits(priv->regmap, MLB_UPDOWN_CSR,
> +								MLB_UPDOWN_CSTR, val);
> +}
> +
> +static int milbeaut_updown_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (val < 0 || val > 1)
> +			return -EINVAL;
> +
> +		ret = milbeaut_updown_is_enabled(priv);
> +		if (val && ret)
> +			return -EBUSY;
> +
> +		ret = milbeaut_updown_setup(priv, val);
> +
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int milbeaut_updown_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +	u32 dat;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(priv->regmap, MLB_UPDOWN_UDCR, &dat);
> +		if (ret)
> +			return ret;
> +		*val = dat;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = milbeaut_updown_is_enabled(priv);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info milbeaut_updown_cnt_iio_info = {
> +	.read_raw = milbeaut_updown_read_raw,
> +	.write_raw = milbeaut_updown_write_raw,
> +};
> +
> +static const char *const milbeaut_updown_quadrature_modes[] = {
> +	"non-quadrature",
> +	"quadrature",
> +};
> +
> +static int milbeaut_updown_get_quadrature_mode(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +
> +	return priv->quadrature_mode;
> +}
> +
> +static int milbeaut_updown_set_quadrature_mode(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   unsigned int type)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +
> +	if (milbeaut_updown_is_enabled(priv))
> +		return -EBUSY;
> +
> +	priv->quadrature_mode = type;
> +
> +	return 0;
> +}
> +
> +static const struct iio_enum milbeaut_updown_quadrature_mode_en = {
> +	.items = milbeaut_updown_quadrature_modes,
> +	.num_items = ARRAY_SIZE(milbeaut_updown_quadrature_modes),
> +	.get = milbeaut_updown_get_quadrature_mode,
> +	.set = milbeaut_updown_set_quadrature_mode,
> +};
> +
> +static const char * const milbeaut_updown_cnt_polarity[] = {
> +	"rising-edge", "falling-edge", "both-edges",
> +};
> +
> +static int milbeaut_updown_cnt_get_polarity(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +
> +	return priv->polarity;
> +}
> +
> +static int milbeaut_updown_cnt_set_polarity(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					unsigned int type)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +
> +	if (milbeaut_updown_is_enabled(priv))
> +		return -EBUSY;
> +
> +	priv->polarity = type;
> +
> +	return 0;
> +}
> +
> +static const struct iio_enum milbeaut_updown_cnt_polarity_en = {
> +	.items = milbeaut_updown_cnt_polarity,
> +	.num_items = ARRAY_SIZE(milbeaut_updown_cnt_polarity),
> +	.get = milbeaut_updown_cnt_get_polarity,
> +	.set = milbeaut_updown_cnt_set_polarity,
> +};
> +
> +static ssize_t milbeaut_updown_cnt_get_preset(struct iio_dev *indio_dev,
> +					  uintptr_t private,
> +					  const struct iio_chan_spec *chan,
> +					  char *buf)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset);
> +}
> +
> +static ssize_t milbeaut_updown_cnt_set_preset(struct iio_dev *indio_dev,
> +					  uintptr_t private,
> +					  const struct iio_chan_spec *chan,
> +					  const char *buf, size_t len)
> +{
> +	struct milbeaut_updown_cnt *priv = iio_priv(indio_dev);
> +	u32 check_preset;
> +	int ret;
> +
> +	if (milbeaut_updown_is_enabled(priv))
> +		return -EBUSY;
> +
> +	ret = kstrtouint(buf, 0, &check_preset);
> +	if (ret)
> +		return ret;
> +
> +	if (check_preset > MLB_UPDOWN_MAX_COUNT)
> +		return -EINVAL;
> +
> +	ret = kstrtouint(buf, 0, &priv->preset);
This structure is a little unusual.
priv->preset = check_preset and that can't result
in an error.

> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info milbeaut_updown_cnt_ext_info[] = {
> +	{
> +		.name = "preset",
> +		.shared = IIO_SEPARATE,
> +		.read = milbeaut_updown_cnt_get_preset,
> +		.write = milbeaut_updown_cnt_set_preset,
> +	},
> +	IIO_ENUM("polarity", IIO_SEPARATE, &milbeaut_updown_cnt_polarity_en),
> +	IIO_ENUM_AVAILABLE("polarity", &milbeaut_updown_cnt_polarity_en),
> +	{}
> +};
> +
> +static const struct iio_event_spec milbeaut_updown_cnt_event = {
> +	.type = IIO_EV_TYPE_ROC,
> +	.dir = IIO_EV_DIR_RISING,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +};
> +
> +static const struct iio_chan_spec milbeaut_updown_cnt_channels = {
> +	.type = IIO_COUNT,
> +	.channel = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_ENABLE) |
> +			      BIT(IIO_CHAN_INFO_SCALE),
> +	.ext_info = milbeaut_updown_cnt_ext_info,
> +	.indexed = 1,
> +	.event_spec = &milbeaut_updown_cnt_event,
> +	.num_event_specs = 1,
> +};
> +
> +static irqreturn_t milbeaut_updown_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct milbeaut_updown_cnt *priv;
> +	int ret;
> +
> +	priv = iio_priv(indio_dev);
> +
> +	ret = regmap_update_bits(priv->regmap, MLB_UPDOWN_CSR,
> +			MLB_UPDOWN_CMPF | MLB_UPDOWN_OVFF | MLB_UPDOWN_UDFF,
> +			0);
> +	WARN_ON_ONCE(ret < 0);
> +
> +	iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_INCLI, 0, 1,
> +						  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int milbeaut_updown_cnt_probe(struct platform_device *pdev)
> +{
> +	struct milbeaut_updown_cnt *priv;
> +	struct iio_dev *indio_dev;
> +	struct resource *res;
> +	void __iomem *mmio;
> +	int ret;
> +	int irq;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mmio = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mmio))
> +		return PTR_ERR(mmio);
> +
> +	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "mux", mmio,
> +							  &milbeaut_updown_regmap_cfg);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->preset = MLB_UPDOWN_MAX_COUNT;
> +	ret = of_property_read_u32(priv->dev->of_node,
> +				"cms_type", &priv->quadrature_mode);
> +	if (ret)
> +		return -ENODEV;
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
Why set this. I don't think anything uses it?

> +	indio_dev->info = &milbeaut_updown_cnt_iio_info;
> +	indio_dev->channels = &milbeaut_updown_cnt_channels;
> +	indio_dev->num_channels = 1;
> +
> +	/* setting request irq */
The comment doesn't add anything not apparent directly from the code.
> +	irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_threaded_irq(&pdev->dev, irq,
> +			NULL, milbeaut_updown_event_handler,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			MILBEAUT_UPDOWN_IRQ_NAME, indio_dev);
> +	if (ret < 0) {
> +		pr_err("%s request irq failed\n", __func__);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
Why? I'm not seeing calls to platform_get_drvdata.
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id milbeaut_updown_cnt_of_match[] = {
> +	{ .compatible = "socionext,milbeaut-updown-counter", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, milbeaut_updown_cnt_of_match);
> +
> +static struct platform_driver milbeaut_updown_cnt_driver = {
> +	.probe = milbeaut_updown_cnt_probe,
> +	.driver = {
> +		.name = "milbeaut-updown-counter",
> +		.of_match_table = milbeaut_updown_cnt_of_match,
> +	},
> +};
> +module_platform_driver(milbeaut_updown_cnt_driver);
> +
> +MODULE_AUTHOR("Shinji Kanematsu <kanematsu.shinji@socionext.com>");
> +MODULE_DESCRIPTION("Milbeaut Updown counter");
> +MODULE_ALIAS("platform:milbeaut_updown_counter");
> +MODULE_LICENSE("GPL v2");

