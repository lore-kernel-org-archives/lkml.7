Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59286217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C71ZXJkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfIBQGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:06:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIBQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:06:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so7634227pgv.13;
        Mon, 02 Sep 2019 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=my2EgEbyt52sG2pLO27e4O9fDD3ES9f7FwLnVs+YkBk=;
        b=C71ZXJkpfaJWMB43cR4Wka7W9yuBHgT/MAQv2S8rwvPuhpM28HL3yPR8+YrT9Y1X8i
         6Dh1Xz0FiSd0xMotX8x22cdeG+rPT9cm9TQQ7YDRUbhtPJQNyDIXZA67DiJrf6pbkXuf
         evbWQocMFulf/WINYKX0GgF2ci8e9HYfFPQoNK9HXYphHurnC4f2tSkGpFW/omfHJaj1
         z7HWbVGAhYGDv/PXlp9Cpvit4ybJ6Wf3oQ0f/ji1Vixo0KANzWqP8uTe8nqH5R3Lst8m
         2QsJNu/WN+MFQ0OgDsFV2WMW2nxsdDDH7SSpSsfhazFnHKHenb7wJ28q2OOJ9ajyKEKz
         XLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=my2EgEbyt52sG2pLO27e4O9fDD3ES9f7FwLnVs+YkBk=;
        b=frgM7gC5fXZScPDHHEfiySVu+eiA++OkyAshXHGldX5lqwJ6UXlPQgX3W3YUQTiXiL
         SOYBttQxdjF/gTegZFlinEjeINzVCDSxgMfTH5v6aFDc8TjCZ73ZSTtQ6CmRofgqjZL+
         88VW8ZZDzliNgPSdphpFMIAQDz9PV3ZbTS4P9IsTGEKEhKCWShtcILT1OjA7GdtOr/o2
         SmFi4aPFeM8t8g8vohBcw/npqtCpO/qMcY8ldL4ohsrXPLwYeLtYYZt6Hb7+HVeDpFZL
         DPj/q+c2EaPALcND8KpR9cPXCFGaAqpNMr3mdEIULvlO7zaXpKJ2e9FBj4tJQHSvb9T5
         6Fzg==
X-Gm-Message-State: APjAAAXD26OLiEaVJWkdQK7aUdtptYvj6xF3IXeavJgnEHQK0HvoWM6y
        IOp/yfCo7RgAyHXb12327WPkuDG0
X-Google-Smtp-Source: APXvYqyxkgHhK7zwhzr0Z2FefBBd9I+F/MalqmxOuUeh/+2EE8eH2aofYV+I2hZWHRgzwWGPIwQZFw==
X-Received: by 2002:a62:80cb:: with SMTP id j194mr36109153pfd.183.1567440373765;
        Mon, 02 Sep 2019 09:06:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z12sm16508924pfg.21.2019.09.02.09.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 09:06:12 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:06:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Message-ID: <20190902160611.GA16228@roeck-us.net>
References: <20190827113214.13773d45@xhacker.debian>
 <20190827113259.4fb64a17@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827113259.4fb64a17@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:44:15AM +0000, Jisheng Zhang wrote:
> Add a new driver for Synaptics AS370 PVT sensors. Currently, only
> temperature is supported.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig       |  10 +++
>  drivers/hwmon/Makefile      |   1 +
>  drivers/hwmon/as370-hwmon.c | 147 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/hwmon/as370-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 650dd71f9724..d31610933faa 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -246,6 +246,16 @@ config SENSORS_ADT7475
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adt7475.
>  
> +config SENSORS_AS370
> +	tristate "Synaptics AS370 SoC hardware monitoring driver"
> +	help
> +	  If you say yes here you get support for the PVT sensors of
> +	  the Synaptics AS370 SoC
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called as370-hwmon.
> +
> +
>  config SENSORS_ASC7621
>  	tristate "Andigilog aSC7621"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8db472ea04f0..252e8a4c9781 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
>  obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
>  obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
>  obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
> +obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
>  obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
>  obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
> diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
> new file mode 100644
> index 000000000000..554f03b91bfe
> --- /dev/null
> +++ b/drivers/hwmon/as370-hwmon.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synaptics AS370 SoC Hardware Monitoring Driver
> + *
> + * Copyright (C) 2018 Synaptics Incorporated
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#define CTRL		0x0
> +#define  PD		BIT(0)
> +#define  EN		BIT(1)
> +#define  T_SEL		BIT(2)
> +#define  V_SEL		BIT(3)
> +#define  NMOS_SEL	BIT(8)
> +#define  PMOS_SEL	BIT(9)
> +#define STS		0x4
> +#define  BN_MASK	GENMASK(11, 0)
> +#define  EOC		BIT(12)
> +
> +struct as370_hwmon {
> +	void __iomem *base;
> +};
> +
> +static void init_pvt(struct as370_hwmon *hwmon)
> +{
> +	u32 val;
> +	void __iomem *addr = hwmon->base + CTRL;
> +
> +	val = PD;
> +	writel_relaxed(val, addr);
> +	val |= T_SEL;
> +	writel_relaxed(val, addr);
> +	val |= EN;
> +	writel_relaxed(val, addr);
> +	val &= ~PD;
> +	writel_relaxed(val, addr);
> +}
> +
> +static int as370_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *temp)
> +{
> +	int val;
> +	struct as370_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		val = readl_relaxed(hwmon->base + STS) & BN_MASK;
> +		*temp = DIV_ROUND_CLOSEST(val * 251802, 4096) - 85525;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t
> +as370_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +		       u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const u32 as370_hwmon_temp_config[] = {
> +	HWMON_T_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info as370_hwmon_temp = {
> +	.type = hwmon_temp,
> +	.config = as370_hwmon_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *as370_hwmon_info[] = {
> +	&as370_hwmon_temp,
> +	NULL
> +};
> +
> +static const struct hwmon_ops as370_hwmon_ops = {
> +	.is_visible = as370_hwmon_is_visible,
> +	.read = as370_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info as370_chip_info = {
> +	.ops = &as370_hwmon_ops,
> +	.info = as370_hwmon_info,
> +};
> +
> +static int as370_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct device *hwmon_dev;
> +	struct as370_hwmon *hwmon;
> +	struct device *dev = &pdev->dev;
> +
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	hwmon->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(hwmon->base))
> +		return PTR_ERR(hwmon->base);
> +
> +	init_pvt(hwmon);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 "as370",
> +							 hwmon,
> +							 &as370_chip_info,
> +							 NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id as370_hwmon_match[] = {
> +	{ .compatible = "syna,as370-hwmon" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, as370_hwmon_match);
> +
> +static struct platform_driver as370_hwmon_driver = {
> +	.probe = as370_hwmon_probe,
> +	.driver = {
> +		.name = "as370-hwmon",
> +		.of_match_table = as370_hwmon_match,
> +	},
> +};
> +module_platform_driver(as370_hwmon_driver);
> +
> +MODULE_AUTHOR("Jisheng Zhang<jszhang@kernel.org>");
> +MODULE_DESCRIPTION("Synaptics AS370 SoC hardware monitor");
> +MODULE_LICENSE("GPL v2");
