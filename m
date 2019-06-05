Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26712C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA7B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5zJZ28h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFEUrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:47:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35024 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFEUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:47:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so3936pgl.2;
        Wed, 05 Jun 2019 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pf7vPUzXpmgu5ei4EbOnej2WlhVpMVJ8oO94zCYVA9Y=;
        b=c5zJZ28hntFAhYITAkzJjEVb/JbeG1+VN1xcgeFdtlNZwxPdicl0NzqXYqwEu4SFD7
         mjC/oROFVvkT/sIgcvkF2QtDjy5JwHcsFuJrsIz3p/Hz6lrelpQLrI2Rn3iwFbIVDYYv
         lOeX63ILGjtYPu4janob7FQyJjcm7RVyOPfAd2pWrCHRlzZS7GWUinrWpFL+vF1BBZ2O
         4imux6ak5VkGp6p8WMBi65H3ty1UqOnC8ffScgg3JyXs07DfesS0XXxTkKDFILNB/2/A
         rX71Tx/howsUFlshYoKl9xWRUHoC4iizLDaOu46A9ymWXfpHKbf1+OdiU4rvZlowg7fz
         cK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pf7vPUzXpmgu5ei4EbOnej2WlhVpMVJ8oO94zCYVA9Y=;
        b=cLSuCa8FczvaXxVLUxRmYDwZf8ml8swQ9+E9wGQ9U2NBC3Xt/N+QsNox0ePPV4XSMg
         eO8UBaWrRDfVu1H3JS8aHfFOOg/8DYdmsj0hBUIqdi5JCgG2nLqnPONPTmB7/oY31K+m
         GIusvi4oKA7ggOnu8zVICHMzSrAKY6OmEAvHYhNDTA69nAqvX+z3YAiXIBotmrym1+YE
         gnRJS45FFvh51Bxo3E0F+wI+l2cMvpkecQafTptqqorjdC7+ccsk6shszqdbvuufgXEj
         B+lJsK4yS/jECKdw54GGHsW3J2AmCP6YKfqPTj5TGNNp7SIorA+vgTtDGkrz48JevoC7
         WMfA==
X-Gm-Message-State: APjAAAUB92HjZimR4NlsxmMnsmz3Sq3yKx+SEpfKjePXc5LdnSR7HVx6
        69tOLo8PygOe0eqDoRBbF8o=
X-Google-Smtp-Source: APXvYqwKpoprMbfDbxnxKrHvF6PC2uoXfdniniHVdUn8GZPManC7NmfAiGrJRFJD+7K3w3fw2afeDg==
X-Received: by 2002:a65:5684:: with SMTP id v4mr934114pgs.160.1559767621254;
        Wed, 05 Jun 2019 13:47:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1sm22150021pgv.15.2019.06.05.13.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:47:00 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:46:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, sdasari@fb.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
Message-ID: <20190605204659.GA32329@roeck-us.net>
References: <20190530231159.222188-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530231159.222188-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:11:56PM -0700, Vijay Khemka wrote:
> Added pmbus driver for the new device Infineon pxe1610
> voltage regulator. It also supports similar family device
> PXE1110 and PXM1310.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> incorporated all the feedback from Guenter Roeck <linux@roeck-us.net>
> 
>  drivers/hwmon/pmbus/Kconfig   |   9 +++
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/pxe1610.c | 139 ++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/pxe1610.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 30751eb9550a..338ef9b5a395 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -154,6 +154,15 @@ config SENSORS_MAX8688
>  	  This driver can also be built as a module. If so, the module will
>  	  be called max8688.
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
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 2219b9300316..b0fbd017a91a 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
>  obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>  obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
> +obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
> diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
> new file mode 100644
> index 000000000000..ebe3f023f840
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pxe1610.c
> @@ -0,0 +1,139 @@
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
> +#define PXE1610_NUM_PAGES 3
> +
> +/* Identify chip parameters. */
> +static int pxe1610_identify(struct i2c_client *client,
> +			     struct pmbus_driver_info *info)
> +{
> +	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
> +		u8 vout_mode;
> +		int ret;
> +
> +		/* Read the register with VOUT scaling value.*/
> +		ret = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
> +		if (ret < 0)
> +			return ret;
> +
> +		vout_mode = ret & GENMASK(4, 0);
> +
> +		switch (vout_mode) {
> +		case 1:
> +			info->vrm_version = vr12;
> +			break;
> +		case 2:
> +			info->vrm_version = vr13;
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pmbus_driver_info pxe1610_info = {
> +	.pages = PXE1610_NUM_PAGES,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = vid,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_POWER] = linear,
> +	.func[0] = PMBUS_HAVE_VIN
> +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
> +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
> +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
> +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
> +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +	.func[1] = PMBUS_HAVE_VIN
> +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
> +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
> +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
> +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
> +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +	.func[2] = PMBUS_HAVE_VIN
> +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
> +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
> +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
> +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
> +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +	.identify = pxe1610_identify,
> +};
> +
> +static int pxe1610_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct pmbus_driver_info *info;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +	int ret;
> +
> +	if (!i2c_check_functionality(
> +			client->adapter,
> +			I2C_FUNC_SMBUS_READ_BYTE_DATA
> +			| I2C_FUNC_SMBUS_READ_WORD_DATA
> +			| I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	/*
> +	 * By default this device doesn't boot to page 0, so set page 0
> +	 * to access all pmbus registers.
> +	 */
> +	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
> +
> +	/* Read Manufacturer id */
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> +		return ret;
> +	}
> +	if (ret != 2 || strncmp(buf, "XP", 2)) {
> +		dev_err(&client->dev, "MFR_ID unrecognized\n");
> +		return -ENODEV;
> +	}
> +
> +	info = devm_kmemdup(&client->dev, &pxe1610_info,
> +			    sizeof(struct pmbus_driver_info),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct i2c_device_id pxe1610_id[] = {
> +	{"pxe1610", 0},
> +	{"pxe1110", 0},
> +	{"pxm1310", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pxe1610_id);
> +
> +static struct i2c_driver pxe1610_driver = {
> +	.driver = {
> +			.name = "pxe1610",
> +			},
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
