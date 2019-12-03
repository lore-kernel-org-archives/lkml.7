Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B35C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F04420803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL3l8d7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLCT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:28:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37354 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:28:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so2336763pfm.4;
        Tue, 03 Dec 2019 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJq3MIlFIxndCzG2Lk9OG6V9CuSPRveNiR+XL++sJL0=;
        b=eL3l8d7UFFccDK2P5hAQLMqUHlWuQSKulpVpOeFAbxvrD0hB3H/16sJ6RPDoCNL8oH
         SpLa2Ug0DsdgCxFc0fOarZ2rmd0vcsQn752nwtH0Ub/AoYl53InUtXvlGJKGMe+XLf0B
         wbMfmgnbdhxvuCOZ5zk466kOZsySCw9AHALJgpgD9UPhvewUnhFbs1P6+3FbipUfU+pr
         iy/8euP1X7MX6pd4nhXZf735Trs9li9rMoeYxsQz1QD3g/P4KIGGo6h3BvE6KMv5l4nw
         d3wQEgEGLZB/grUyD5UWjC2JWcj3oCffX+aZouWSRDO9rZ4JHn/u/NQa0X5r9cQQUEyE
         Cweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJq3MIlFIxndCzG2Lk9OG6V9CuSPRveNiR+XL++sJL0=;
        b=edAH6ffaq7HSYOcjJ1VU7/ZEORQGi8nv5m8pEd+hoX6zJjnimkgtJHppTXfGS9+1rB
         oomLX8Im/Ke7I7YoaHPaQ8YBWJkHja5fwitspYLP3881h9cYufnmWcekcGCocOw6AecG
         EBXtTSJNdJncZde0dNV2x01IkRY14Au3aOmuRU12OXgDjoincvDC1E7sW8z+1XB12z0t
         G+0CYSd3aFV0t/DrreK2dfmqLe24nhPJE2LoZZ6WhXxHd/ryx69KA1ctOpatsdzG/Vl3
         kDUCKYnXmwI3wbYy2v5b66CcMg4LbYGyd0oVqwsiLTO7NWJj8GSBLlP+N/I0Lg6nLowS
         2U9Q==
X-Gm-Message-State: APjAAAXyiePtbSzSYLoMAiGUMC+xwHAupxnYT3207iWKNjP52mGZpA3d
        WNkSpG647PK1P/S5nh8O0w8=
X-Google-Smtp-Source: APXvYqxIylxexFio6QgXxM9MD9JuND+1T4axIgc4OsxahttrGUP7woBYUWRXM57Gzx67V5zqUvDONA==
X-Received: by 2002:a63:d351:: with SMTP id u17mr6990433pgi.84.1575401338357;
        Tue, 03 Dec 2019 11:28:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18sm2125096pfi.80.2019.12.03.11.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 11:28:57 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:28:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH 1/3] hwmon: adm1177: Add ADM1177 Hot Swap Controller and
 Digital Power Monitor driver
Message-ID: <20191203192856.GA18668@roeck-us.net>
References: <20191203135711.13972-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203135711.13972-1-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:57:09PM +0200, Beniamin Bia wrote:
> ADM1177 is a Hot Swap Controller and Digital Power Monitor with
> Soft Start Pin.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> 

High level question:

The chip supports setting the current limit, and it reports
the overcurrent status. Any reason for not providing the respective
sysfs entries ?

> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  drivers/hwmon/Kconfig   |  10 ++
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/adm1177.c | 274 ++++++++++++++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/adm1177.rst.

>  3 files changed, 285 insertions(+)
>  create mode 100644 drivers/hwmon/adm1177.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5308c59d7001..3db8f5752675 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -164,6 +164,16 @@ config SENSORS_ADM1031
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adm1031.
>  
> +config SENSORS_ADM1177
> +	tristate "Analog Devices ADM1177 and compatibles"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Analog Devices ADM1177
> +	  sensor chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called adm1177.
> +
>  config SENSORS_ADM9240
>  	tristate "Analog Devices ADM9240 and compatibles"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 40c036ea45e6..27d04eab1be4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
>  obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
>  obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
> +obj-$(CONFIG_SENSORS_ADM1177)	+= adm1177.o
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
> diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
> new file mode 100644
> index 000000000000..08950cecc9f9
> --- /dev/null
> +++ b/drivers/hwmon/adm1177.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
> + *
> + * Copyright 2015-2019 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/regulator/consumer.h>

Alphabetic include file order, please.

> +
> +/*  Command Byte Operations */
> +#define ADM1177_CMD_V_CONT	BIT(0)
> +#define ADM1177_CMD_V_ONCE	BIT(1)
> +#define ADM1177_CMD_I_CONT	BIT(2)
> +#define ADM1177_CMD_I_ONCE	BIT(3)
> +#define ADM1177_CMD_VRANGE	BIT(4)
> +#define ADM1177_CMD_STATUS_RD	BIT(6)
> +

Requires #include <linux/bits.h>. ADM1177_CMD_STATUS_RD is not used.

> +/* Extended Register */
> +#define ADM1177_REG_ALERT_EN	1

ADM1177_REG_ALERT_EN is not used.

> +#define ADM1177_REG_ALERT_TH	2
> +#define ADM1177_REG_CONTROL	3

ADM1177_REG_CONTROL is not used.

> +
> +/* ADM1177_REG_ALERT_EN */
> +#define ADM1177_EN_ADC_OC1	BIT(0)
> +#define ADM1177_EN_ADC_OC4	BIT(1)
> +#define ADM1177_EN_HS_ALERT	BIT(2)
> +#define ADM1177_EN_OFF_ALERT	BIT(3)
> +#define ADM1177_CLEAR		BIT(4)
> +
> +/* ADM1177_REG_CONTROL */
> +#define ADM1177_SWOFF		BIT(0)
> +
> +#define ADM1177_BITS		12

The above defines are not used.

> +
> +/**
> + * struct adm1177_state - driver instance specific data
> + * @client		pointer to i2c client
> + * @reg			regulator info for the the power supply of the device
> + * @command		internal control register
> + * @r_sense_uohm	current sense resistor value
> + * @alert_threshold_ua	current limit for shutdown
> + * @vrange_high		internal voltage divider
> + */
> +struct adm1177_state {
> +	struct i2c_client	*client;
> +	struct regulator	*reg;
> +	u8			command;
> +	u32			r_sense_uohm;
> +	u32			alert_threshold_ua;
> +	bool			vrange_high;
> +};
> +
> +static int adm1177_read_raw(struct adm1177_state *st, u8 num, u8 *data)
> +{
> +	struct i2c_client *client = st->client;
> +

That variable seems unncessary. Just use st->client directly, like below.

> +	return i2c_master_recv(client, data, num);
> +}
> +
> +static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
> +{
> +	st->command = cmd;

This is an odd way to record and check if vrange is high or low,
especially since there is already a flag indicating that/if it is high.

Why not just use "if (st->vrange_high) instead of "if (st->command &
ADM1177_CMD_VRANGE") ?

> +	return i2c_smbus_write_byte(st->client, cmd);
> +}
> +
> +static int adm1177_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct adm1177_state *st = dev_get_drvdata(dev);
> +	u8 data[3];
> +	long dummy;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		ret = adm1177_read_raw(st, 3, data);
> +		if (ret < 0)
> +			return ret;
> +		dummy = (data[1] << 4) | (data[2] & 0xF);
> +		/*
> +		 * convert in milliamperes

convert to

> +		 * ((105.84mV / 4096) x raw) / senseResistor(ohm)
> +		 */
> +		*val = div_u64((105840000ull * dummy), 4096 * st->r_sense_uohm);
> +		return 0;
> +	case hwmon_in:
> +		ret = adm1177_read_raw(st, 3, data);
> +		if (ret < 0)
> +			return ret;
> +		dummy = (data[0] << 4) | (data[2] >> 4);
> +		/*
> +		 * convert in millivolts based on resistor devision
> +		 * (V_fullscale / 4096) * raw
> +		 */
> +		if (st->command & ADM1177_CMD_VRANGE)
> +			*val = 6650;
> +		else
> +			*val = 26350;
> +
Dereferencing val several times isn't really very efficient.
How about the following ?

		if (st->vrange_high)
			dummy *= 26350;
		else
			dummy *= 6650;
		*val = DIV_ROUND_CLOSEST(dummy, 4096);

> +		*val = ((*val * dummy) / 4096);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t adm1177_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct adm1177_state *st = data;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			if (st->r_sense_uohm)
> +				return 0444;
> +			return 0;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const u32 adm1177_curr_config[] = {
> +	HWMON_C_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info adm1177_curr = {
> +	.type = hwmon_curr,
> +	.config = adm1177_curr_config,
> +};
> +
> +static const u32 adm1177_in_config[] = {
> +	HWMON_I_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info adm1177_in = {
> +	.type = hwmon_in,
> +	.config = adm1177_in_config,
> +};
> +
> +static const struct hwmon_channel_info *adm1177_info[] = {
> +	&adm1177_curr,
> +	&adm1177_in,
> +	NULL
> +};

Please use the HWMON_CHANNEL_INFO  macro to declare the above.

> +
> +static const struct hwmon_ops adm1177_hwmon_ops = {
> +	.is_visible = adm1177_is_visible,
> +	.read = adm1177_read,
> +};
> +
> +static const struct hwmon_chip_info adm1177_chip_info = {
> +	.ops = &adm1177_hwmon_ops,
> +	.info = adm1177_info,
> +};
> +
> +static void adm1177_remove(void *data)
> +{
> +	struct adm1177_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
> +static int adm1177_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct adm1177_state *st;
> +	int ret;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->client = client;
> +
> +	st->reg = devm_regulator_get_optional(&client->dev, "vref");
> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		st->reg = NULL;
> +	} else {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
> +					       st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (device_property_read_u32(dev, "adi,r-sense-micro-ohms",
> +				     &st->r_sense_uohm))
> +		st->r_sense_uohm = 1;

Does the default make sense ? A default of 1 mOhm seems to make more sense.

I assume that you explicitly want to be able to disable current sensing
by setting r_sense_uohm to 0. If so, that needs to be documented in the
devicetree file. Also, as written, the property is optional. I think this
also needs to be documented.

> +	if (device_property_read_u32(dev, "adi,shutdown-threshold-microamp",
> +				     &st->alert_threshold_ua))
> +		st->alert_threshold_ua = 0;
> +	st->vrange_high = device_property_read_bool(dev,
> +						    "adi,vrange-high-enable");
> +	if (st->alert_threshold_ua) {
> +		u64 val;
> +
> +		val = (0xFFUL * st->alert_threshold_ua * st->r_sense_uohm);

Unnecessary ( )

The above sets val to 0 if st->r_sense_uohm is 0. That means the register
value is set to 0. Does that mean "disable" for the chip ?

> +		val = div_u64(val, 105840000U);
> +		if (val > 0xFF) {
> +			dev_warn(&client->dev,
> +				 "Requested shutdown current %d uA above limit\n",
> +				 st->alert_threshold_ua);
> +
> +			val = 0xFF;
> +		}
> +		i2c_smbus_write_byte_data(st->client, ADM1177_REG_ALERT_TH,
> +					  val);
> +	}

Does the chip have a default value ?

> +
> +	ret = adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
> +				    ADM1177_CMD_I_CONT |
> +				    (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev =
> +		devm_hwmon_device_register_with_info(dev, client->name, st,
> +						     &adm1177_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id adm1177_id[] = {
> +	{"adm1177", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1177_id);
> +
> +static const struct of_device_id adm1177_dt_ids[] = {
> +	{ .compatible = "adi,adm1177" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
> +
> +static struct i2c_driver adm1177_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "adm1177",
> +		.of_match_table = adm1177_dt_ids,
> +	},
> +	.probe = adm1177_probe,
> +	.id_table = adm1177_id,
> +};
> +module_i2c_driver(adm1177_driver);
> +
> +MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
