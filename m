Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18F0217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loIXLOGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfHZNoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:44:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35470 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfHZNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so10060386plb.2;
        Mon, 26 Aug 2019 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f4J8zbxFlsOeeFNMYOIQRLtE9UOHqm8l4NtvLF0e4RA=;
        b=loIXLOGuFFgi+yXni20QDIwYD1K1TqxeDEDHWIgW8RtVdYenVUzaq8U3eYF459ynDj
         C+EwFwoKXeAbW++I0TulNcGJy45Brb7WLtfu6RYt3suflHKuf53phxe5qWOynD/HnMpy
         tvsUfk+wR3UYyZx0vLvGPHMjCU+7VwmwGRqqIGsPc7pxTd+vKs7XAn6DDWF+7KNp+OOB
         wTaWR4O4tngVQ1Njpg57qumH4/skkaZxDfqB2tj5LBkLWuHVFIOaTHmc8Wne7Ii3tdJX
         8ufieym9gWcvCYQzLWAr3RV3QKywd2ASL6eN3kSq5QHz0tra5AShogmKyq6S5aQ31GY/
         /yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f4J8zbxFlsOeeFNMYOIQRLtE9UOHqm8l4NtvLF0e4RA=;
        b=OqhhDjlQEKwH0EIgMADcD/jy49y9asqtEimcKTSzjD1aiWv7gVs2K6S8qpnB/id4pS
         u0E3wljANNPkpdbJ12QR6OH2slp99XtwQEE/dtJbFUA6baEa+F0vuNWYQTqrikX2PH1i
         5wQv/G3XlmpzHi3o6y/uoHeBNUDByUwqMH8nVzCIawkb0wcRuBTgEJH1zL5jwgyt25Yw
         agaD/dV7FNXO3By+I3qg10fB6jFCXbrva7ytV3UEJflXFq/4H9E1IOxPh/2uJX+F3Mdg
         ADnzHEXsLpEMxqQJ3hYJmTTe3CwuneKzEIKSrZrkqz/ZGz4xVJZlmuWaLBVgU7jcD+2H
         9MxQ==
X-Gm-Message-State: APjAAAW8IjdgPeKqwZH53KW2b3MTcfA1n1uov5hUZ+M5zg7vdvhBVjX9
        06khdXbmC1kZjqUZ6UZ8EV2TJ2sl
X-Google-Smtp-Source: APXvYqxgOcvuEghwHiQetBW5SYVdaZKjdD7BVoVYt9x5/AzSimo8ZPlesuoGxgVNF830I3/puYwD1A==
X-Received: by 2002:a17:902:b106:: with SMTP id q6mr6899499plr.333.1566827077018;
        Mon, 26 Aug 2019 06:44:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h20sm13004841pfq.156.2019.08.26.06.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:44:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190826174942.2b28ff05@xhacker.debian>
 <20190826175029.433632f6@xhacker.debian>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <35b05950-4a72-9e00-50ab-ecd0a7e759a4@roeck-us.net>
Date:   Mon, 26 Aug 2019 06:44:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826175029.433632f6@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/19 3:01 AM, Jisheng Zhang wrote:
> Add a new driver for Synaptics AS370 PVT sensors. Currently, only
> temperature is supported.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   drivers/hwmon/Kconfig       |  10 +++
>   drivers/hwmon/Makefile      |   1 +
>   drivers/hwmon/as370-hwmon.c | 158 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 169 insertions(+)
>   create mode 100644 drivers/hwmon/as370-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 650dd71f9724..d31610933faa 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -246,6 +246,16 @@ config SENSORS_ADT7475
>   	  This driver can also be built as a module. If so, the module
>   	  will be called adt7475.
>   
> +config SENSORS_AS370
> +	tristate "Synaptics AS370 SoC hardware monitoring driver"

I think this needs "depends on HAS_IOMEM".

> +	help
> +	  If you say yes here you get support for the PVT sensors of
> +	  the Synaptics AS370 SoC
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called as370-hwmon.
> +
> +
>   config SENSORS_ASC7621
>   	tristate "Andigilog aSC7621"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8db472ea04f0..252e8a4c9781 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
>   obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
>   obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
>   obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
> +obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
>   obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
>   obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
>   obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
> diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
> new file mode 100644
> index 000000000000..98dfba45e1b0
> --- /dev/null
> +++ b/drivers/hwmon/as370-hwmon.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synaptics AS370 SoC Hardware Monitoring Driver
> + *
> + * Copyright (C) 2018 Synaptics Incorporated
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>

Unnecessary include file.

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
> +#define  BN_MASK	(0xfff << 0)

How about using GENMASK() ?

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
> +	val &= ~V_SEL;
> +	val &= ~NMOS_SEL;
> +	val &= ~PMOS_SEL;

What is the point of this ? We know that val == PD here.

> +	writel_relaxed(val, addr);
> +	val |= EN;
> +	writel_relaxed(val, addr);
> +	val &= ~PD;
> +	writel_relaxed(val, addr);
> +}
> +
> +static int read_pvt(struct as370_hwmon *hwmon)
> +{
> +	return readl_relaxed(hwmon->base + STS) & BN_MASK;
> +}

Please fold into the calling code.

> +
> +static int as370_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *temp)
> +{
> +	int val;
> +	struct as370_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		val = read_pvt(hwmon);
> +		if (val < 0)
> +			return val;

read_pvt() doesn't return a negative error code. This check is unnecessary.

> +		*temp = val * 251802 / 4096 - 85525;

This results in rounding down the reported temperature. It is ok if it is
what you want; otherwise, I would suggest to use DIV_ROUND_CLOSEST().

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
> +							 "as370_hwmon",

The "_hwmon" seems unnecessary. It will show up in "sensors" as part
of the sensor name. Is this really what you want ?

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
> 

