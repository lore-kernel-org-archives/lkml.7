Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73956C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40492243C6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhutMmwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfE3BAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:00:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44078 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:00:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so2764823pfo.11;
        Wed, 29 May 2019 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vw6ROn6nwvHNofKrf/iVLUbmXE65pyhQ9L1aja1o048=;
        b=UhutMmwVItArx2/GzYypUcXt4iDc6LPvIFfXTMcS2OqrYkyVyeNbY7fFH97L81JqKD
         AdwGy2Kb1U+cnXt7el14YyV4uSE0oMVH3sgGYK03H8bzaQAH+gZjXrZNigu7tfbRqhkR
         XprvNjb8F5S1jMWzYhNQq/HfoQPzDcxCbky5YvN2gaSBy92j9YR+gPw6LWaXXTjfC7nW
         Vm4fzeTlI33Pc9J5IMIVjtKD2E6Pi5DFzaGIAkLHplikaPBfNdNZ7BS/qIjNM+JJa/l0
         jwKXRoZEib7GpYmjrDkm6MutcAoIeZKgQl3jENFLWfbJ6V07ZgnoIyB8gRsS6itjcDpb
         7Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vw6ROn6nwvHNofKrf/iVLUbmXE65pyhQ9L1aja1o048=;
        b=KFlSnmGm7rkOhQvV45TKgB9bFJ6zWL370g+SBf4HXQiLBEVBQp4/twIodW7fNKxffi
         5rNzuXqp4XV9l5mP97g96B0Pt/UTr+Eyp5PCgi399bVBKG3xv8woJP1wSqhq57mtSAd/
         Lrs/0SbPWKzVn+QRhcUwbJXczPL3aqm5wmROkuIKbu/c4bMwtcCK93Im1r7F4LdoFvsh
         gooNnJZ6PBnnyW0qmmRokodUlzVineqgNNdmdwnlcF4vpppOYwAJiph7qodUpgG+B2o2
         md3HBA0xHKHlIqa1k+AhaxBNw9Rp4Pc0tQHz4esK+XjQZj3vWvgDThasw9KXytLmVpQu
         TPlQ==
X-Gm-Message-State: APjAAAWvwyMIT0piw0BH55UJtztf/1EY0Q1S3vDFzAhgKPjQJc56hv42
        pD8fEXIDmRMaR0L8VUsu5ARelHtq
X-Google-Smtp-Source: APXvYqwfAEpkoaWJ+x7E3jJg0ppuKnN9XJnSt86gxW+B4emkQ2pXb2LYUqUiEGdYvZY2UxSFtg5MqA==
X-Received: by 2002:aa7:8d43:: with SMTP id s3mr671248pfe.5.1559178033031;
        Wed, 29 May 2019 18:00:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8sm511268pgq.33.2019.05.29.18.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 18:00:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joel@jms.id.au, linux-aspeed@lists.ozlabs.org, sdasari@fb.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e72ae680-e8b7-455a-fdde-af79d429dd8c@roeck-us.net>
Date:   Wed, 29 May 2019 18:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529223511.4059120-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 3:35 PM, Vijay Khemka wrote:
> Added pmbus driver for the new device Infineon pxe1610
> voltage regulator. It also supports similar family device
> PXE1110 and PXM1310.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>   drivers/hwmon/pmbus/Kconfig   |   9 +++
>   drivers/hwmon/pmbus/Makefile  |   1 +
>   drivers/hwmon/pmbus/pxe1610.c | 119 ++++++++++++++++++++++++++++++++++
>   3 files changed, 129 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/pxe1610.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 30751eb9550a..338ef9b5a395 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -154,6 +154,15 @@ config SENSORS_MAX8688
>   	  This driver can also be built as a module. If so, the module will
>   	  be called max8688.
>   
> +config SENSORS_PXE1610
> +	tristate "Infineon PXE1610"
> +	help
> +	  If you say yes here you get hardware monitoring support for Infineon
> +	  PXE1610.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pxe1610.
> +
>   config SENSORS_TPS40422
>   	tristate "TI TPS40422"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 2219b9300316..b0fbd017a91a 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
>   obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>   obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>   obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
> +obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>   obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>   obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>   obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
> diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
> new file mode 100644
> index 000000000000..01e267944df5
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pxe1610.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon PXE1610
> + *
> + * Copyright (c) 2019 Facebook Inc
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +/*
> + * Identify chip parameters.
> + */
> +static int pxe1610_identify(struct i2c_client *client,
> +			  struct pmbus_driver_info *info)

Please align continuation lines with '('.

> +{
> +	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
> +		int vout_mode;
> +
> +		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);

pmbus_read_byte_data() can return an error. Calling pmbus_check_byte_register()
doesn't really add any value here, since the second call can still fail,
which needs to be checked.

> +		switch (vout_mode & 0x1f) {
> +		case 1:
> +			info->vrm_version = vr12;
> +		break;

Alignment is off.

> +		case 2:
> +			info->vrm_version = vr13;
> +		break;

Same here.

> +		default:
> +			return -ENODEV;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int pxe1610_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pmbus_driver_info *info;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				| I2C_FUNC_SMBUS_READ_WORD_DATA
> +				| I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	/* By default this device doesn't boot to page 0, so set page 0
> +	 * to access all pmbus registers.
> +	 */

Please use standard multi-line comments.

> +	i2c_smbus_write_byte_data(client, 0, 0);
> +

Please use the PMBUS_PAGE command definition.

I wonder if it would make sense to initialize currpage in the core to an unreasonable
number for multi-page chips, but I guess that is a different question.

> +	/* Read Manufacturer id */
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> +		return ret;
> +	}
> +	if (ret != 2 || strncmp(buf, "XP", strlen("XP"))) {

The strlen() is really unnecessary here. Just use 2 (and a define
for it if you like).

> +		dev_err(&client->dev, "MFR_ID unrecognised\n");

unrecognized. Oh well, turns out unrecognised is the British spelling and
just as valid, so feel free to keep it if you like.

> +		return -ENODEV;
> +	}
> +
> +	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->format[PSC_VOLTAGE_IN] = linear;
> +	info->format[PSC_VOLTAGE_OUT] = vid;
> +	info->format[PSC_CURRENT_IN] = linear;
> +	info->format[PSC_CURRENT_OUT] = linear;
> +	info->format[PSC_POWER] = linear;
> +	info->format[PSC_TEMPERATURE] = linear;
> +
> +	info->func[0] = PMBUS_HAVE_VIN
> +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
> +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
> +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
> +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
> +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP;
> +	info->func[1] = info->func[0];
> +	info->func[2] = info->func[0];
> +
> +	info->pages = id->driver_data;
> +	info->identify = pxe1610_identify;
> +

It doesn't really add value to initialize all these parameters manually.
I would suggest to use the approach from tps53679.c, ie have a static
structure and use devm_kmemdup() to pass a copy to pmbus_do_probe().

> +	return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct i2c_device_id pxe1610_id[] = {
> +	{"pxe1610", 3},
> +	{"pxe1110", 3},
> +	{"pxm1310", 3},

Unless there are chips with different page counts in the queue, using
driver_data to pass the number of pages does not add any value. Just
set num_pages to 3.

If you like, feel free to use a define instead of a constant.

> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pxe1610_id);
> +
> +/* This is the driver that will be inserted */

This comment does not add any value.

> +static struct i2c_driver pxe1610_driver = {
> +	.driver = {
> +		   .name = "pxe1610",
> +		   },
> +	.probe = pxe1610_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = pxe1610_id,
> +};
> +
> +module_i2c_driver(pxe1610_driver);
> +
> +MODULE_AUTHOR("Vijay Khemka <vijaykhemka@fb.com>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon PXE1610, PXE1110 and PXM1310");
> +MODULE_LICENSE("GPL");
> 

