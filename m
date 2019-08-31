Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480C9217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBV/R3b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfHaPKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:10:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45327 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:10:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so4680790plr.12;
        Sat, 31 Aug 2019 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrrcay/siJkwT2Q9IwpuW0OnrkFjdPWqKgjiUos68rk=;
        b=NBV/R3b6IDOs+VVnFzVBxdjdKOIwExV02mchMG3XeuNsCgvozpgBDYar5+w9RjlZGs
         K+yLUNmr+1/vrva2lZQatJ6zGvFM7jbCjNX4j0RRMa68Va7zDk4VXIuf2JgU4E/bvq9o
         ljUtH02hz6yeB1LiIY6PH0iujEeoR9+bVUlL/t3JGMmim78kUjMuDQlxATBDnsQO4Ner
         U7Zpkrz0W8TH9is9elFDhKa69CVAdC2f2Qw2oKlhEf7Z8h/1u/qgPEz088V6zg9tJ6Vn
         F/Ao0leEX16aMAtY/HlfiZ2gpcYDyjIOdmk/JIhOvy13kWQZQas2TLaVB+SZBE99JZZD
         hNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrrcay/siJkwT2Q9IwpuW0OnrkFjdPWqKgjiUos68rk=;
        b=g9W4/cJP+m1rgkZpcIEjRNBft4ytIioZJ1xwuDeBvXQRJr9bywef7jNYxWCdUyJeY7
         p8YQcZ8o22wcaBRWrvTXMvnocoFzICR/aEYFIUJXZ7EtIKRlmpDs5btpUHG9UJBa1+IZ
         C04/qb8oHAErMmEplCVDT65GP4ScQgkhHBJmAWufOVw4baQjvjyoqCQdxb9kqXjFHMQ8
         C7mr+XaLArJ2hVJXVFNoOlPGASwGi4MjIaUhBJgt6gePH6L+6AHmGbgBYl1BvzaiTzW2
         X9orLpdhWd5RhHZww2emCx3U8jOMON13IuDdVPkjOMIN5qVdWLTIyDtM80S0LmTeOR5j
         cIVQ==
X-Gm-Message-State: APjAAAXPzduiyaK3fbRP1KfBc2tE6uZYvJ3f60Wu2NDA6DChGbL8HJJ9
        +9bBJm+8wBR5yGyCD985e9E=
X-Google-Smtp-Source: APXvYqwt0+PApBBGZ1P6OCD9C6fW1TadGTohAKbzRRWFHFA5xtCkK1oiG7QBf+avCL0/3K0wm2RVvQ==
X-Received: by 2002:a17:902:4545:: with SMTP id m63mr20191295pld.45.1567264205974;
        Sat, 31 Aug 2019 08:10:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11sm7908874pju.2.2019.08.31.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:10:05 -0700 (PDT)
Date:   Sat, 31 Aug 2019 08:10:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Message-ID: <20190831151004.GA8682@roeck-us.net>
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

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

(pending dt maintainer dreview for the bindings)

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
