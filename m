Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16272CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF92121479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdDJWSub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfJ2Mm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:42:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfJ2Mm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:42:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id c184so9521024pfb.0;
        Tue, 29 Oct 2019 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fOrbkU46JgKCpUazmCZLUeWttzqgH1e4jswzSy8IXQk=;
        b=FdDJWSubMcfZ5eXxXY7SdUcs4KiO6gI9qejKGYJlBVUSNvOkMpqmJjwI8IS48SkPWb
         XR4rWodABPRw8gkfkd0G34EXrmCaXmiH09jVLPnK22896Qj1PrY5d55cTCeIulINr3d1
         vE6Ubx/AmZ7iHYvO6iIHNBGhRBFHZohdSsCxiLl+M3urCV15FT1pziONA7JH1I+frR3s
         UfF2lp6Dp3vV0eo3HHVh7VQ+xPq5Uc5XoJx3tdub58VsWxBmVkre8+lq4CxTxFMmDRIi
         Tqbq2FNdv7D6zRGDkdcl4FSW2j81kcuQF6MZFZH6OCA3KzgPkV8GkjF3GBqEAjME/wxZ
         usOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fOrbkU46JgKCpUazmCZLUeWttzqgH1e4jswzSy8IXQk=;
        b=Tv8kCoPReaBiH7JnxUuMzl+C013pRsXU1fDJQJGnoHombfX2knT4zyx8GBFmQmMwc9
         MYrFYbTUxNg2yZ3/fDKbbNMmhERDfmCCrQF/704YxRhfTBy7WjNhd8C26Q9MeUcQNVGD
         ypUha5lwFgs4Qaqb0w3HBGMk+fC/Tiew5JZFZpP71/R9SYga0XHBJ7P3EzELpACT1mhR
         +MfgVmeBf1TdD396s/8hrhn86dh86wMdvZa8Zt3071QKUodfxomDg1/rpMIKktLcqtGV
         wbR5qZjXvBhwSa8UHJw5ayWLIMrvqxvfTj5XNmavzu+R22H8syEMhqvGIgb45UU9w5Fa
         z4aQ==
X-Gm-Message-State: APjAAAVrBFTWVNikIMnKes89ZlUwkyYyWEbROTjEyWWEwgL6B3uQXogY
        HsO9DnvHJr8RukPPw0EFK36MKrLR
X-Google-Smtp-Source: APXvYqxdKrpJbgiqxQmwUMlhqcA77zarOIKgxEysN+oYiECsIpHChZdRZkg3/AocXszl3438nmc+jw==
X-Received: by 2002:aa7:83c2:: with SMTP id j2mr27670525pfn.225.1572352976762;
        Tue, 29 Oct 2019 05:42:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13sm3879740pjq.0.2019.10.29.05.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:42:56 -0700 (PDT)
Date:   Tue, 29 Oct 2019 05:42:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH 1/3] hwmon: (pmbus) add BEL PFE1100 power supply driver
Message-ID: <20191029124255.GA23349@roeck-us.net>
References: <20191028234904.12441-1-rentao.bupt@gmail.com>
 <20191028234904.12441-2-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028234904.12441-2-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:49:02PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add the driver to support BEL PFE1100 which is 1100 Wat AC to DC power
> supply. The chip has only 1 page.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Please combine with the next patch.

> ---
>  drivers/hwmon/pmbus/Kconfig   |  9 +++++
>  drivers/hwmon/pmbus/Makefile  |  1 +
>  drivers/hwmon/pmbus/bel-pfe.c | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/bel-pfe.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index d62d69bb7e49..59859979571d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -36,6 +36,15 @@ config SENSORS_ADM1275
>  	  This driver can also be built as a module. If so, the module will
>  	  be called adm1275.
>  
> +config SENSORS_BEL_PFE
> +	tristate "Bel PFE Compatible Power Supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for BEL
> +	  PFE1100 and PFE3000 Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called bel-pfe.
> +
>  config SENSORS_IBM_CFFPS
>  	tristate "IBM Common Form Factor Power Supply"
>  	depends on LEDS_CLASS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 03bacfcfd660..3f8c1014938b 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
> +obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> new file mode 100644
> index 000000000000..117f9af21bf3
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/bel-pfe.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for BEL PFE family power supplies.
> + *
> + * Copyright (c) 2019 Facebook Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>

Alphabetic include file order, please.

> +#include "pmbus.h"
> +
> +enum chips {pfe1100};
> +
> +static struct pmbus_driver_info pfe_driver_info[] = {
> +	[pfe1100] = {
> +		.pages = 1,
> +		.format[PSC_VOLTAGE_IN] = linear,
> +		.format[PSC_VOLTAGE_OUT] = linear,
> +		.format[PSC_CURRENT_IN] = linear,
> +		.format[PSC_CURRENT_OUT] = linear,
> +		.format[PSC_POWER] = linear,
> +		.format[PSC_TEMPERATURE] = linear,
> +		.format[PSC_FAN] = linear,
> +
> +		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +			   PMBUS_HAVE_POUT |
> +			   PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> +			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> +			   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +			   PMBUS_HAVE_STATUS_TEMP |
> +			   PMBUS_HAVE_FAN12,
> +	},
> +};
> +
> +static int pfe_pmbus_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	int model;
> +
> +	model = (int)id->driver_data;
> +	return pmbus_do_probe(client, id, &pfe_driver_info[model]);
> +}
> +
> +static const struct i2c_device_id pfe_device_id[] = {
> +	{"pfe1100", pfe1100},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pfe_device_id);
> +
> +static struct i2c_driver pfe_pmbus_driver = {
> +	.driver = {
> +		   .name = "bel-pfe",
> +	},
> +	.probe = pfe_pmbus_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = pfe_device_id,
> +};
> +
> +module_i2c_driver(pfe_pmbus_driver);
> +
> +MODULE_AUTHOR("Tao Ren <rentao.bupt@gmail.com>");
> +MODULE_DESCRIPTION("PMBus driver for BEL PFE Family Power Supplies");
> +MODULE_LICENSE("GPL");
