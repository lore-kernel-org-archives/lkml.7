Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4E222D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553429229;
	bh=nJvhJO8XmWTr2woASuWjUYoCvLGR2M/NKIGUXNMuFB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KhrqXc4zH7jFyHcQk5XGyNlzlme0xNHyVNvWHjN3hDp/xhYTaYTixqTrze1saxPHw
	 eFz4D/2MI49qraCrf0d2yBNi7rSbuXML4PvQnaQrFtrpDegPr/eHacNTMpJm+Ha43l
	 MLXMZ1xPCZ4Wq/B4gzYunMn3hzqUQ8JshHYWzsz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfCXMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:07:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9AB7222D1;
        Sun, 24 Mar 2019 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553429226;
        bh=nJvhJO8XmWTr2woASuWjUYoCvLGR2M/NKIGUXNMuFB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSUv5SI1U4Jk4Yw/ib1IY1jCjQbFGOJRk+kFiJc7CaBi8QYPx0NkgA9I80LO5jKao
         H4U2ESQ69Ed5RTav7htSLCuGcoFXocpmvWbui8zQ1+aBpEh10j4xMOeNLz8pdJNM5b
         Wcskgqg/Peh0I9LYtL8LWmgBRcvczSIPw4ziY0nI=
Date:   Sun, 24 Mar 2019 12:06:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: Re: [PATCH v3 3/4] mb1232.c: add distance iio sensor with i2c
Message-ID: <20190324120658.0507b3bc@archlinux>
In-Reply-To: <20190317203801.uz2rhpyevsulh5c5@arbad>
References: <20190317203801.uz2rhpyevsulh5c5@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 21:38:03 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add I2CXL-MaxSonar ultrasonic distance sensors of types mb1202, mb1212,
> mb1222, mb1232, mb1242, mb7040, mb7137 using an i2c interface
> 
> Implemented functionality:
> - reading the distance via in_distance_raw
> - buffered mode with trigger
> - make use of interrupt to announce completion of ranging
> 
> Add mb1232 driver to Kconfig and Makefile
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
A few really minor tweaks inline.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/Kconfig  |  12 ++
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/mb1232.c | 274 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/iio/proximity/mb1232.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index b99367a89f81..12a3d3d40a91 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -45,6 +45,18 @@ config LIDAR_LITE_V2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pulsedlight-lite-v2
>  
> +config MB1232
> +	tristate "MaxSonar I2CXL family ultrasonic sensors"
> +	depends on I2C
> +	help
> +	  Say Y to build a driver for the ultrasonic sensors I2CXL of
> +	  MaxBotix which have an i2c interface. It can be used to measure
> +	  the distance of objects. Supported types are mb1202, mb1212,
> +	  mb1222, mb1232, mb1242, mb7040, mb7137
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mb1232.
> +
>  config RFD77402
>  	tristate "RFD77402 ToF sensor"
>  	depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 6d031f903c4c..0bb5f9de13d6 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
> +obj-$(CONFIG_MB1232)		+= mb1232.o
>  obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> new file mode 100644
> index 000000000000..d061cb16da93
> --- /dev/null
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mb1232.c - Support for MaxBotix I2CXL-MaxSonar-EZ series ultrasonic
> + *   ranger with i2c interface
> + * actually tested with mb1232 type
> + *
> + * Copyright (c) 2019 Andreas Klinger <ak@it-klinger.de>
> + *
> + * For details about the device see:
> + * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> + *
Nitpick of the day.  This line adds nothing ;)

> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/of_irq.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +/* registers of MaxSonar device */
> +#define MB1232_RANGE_COMMAND	0x51	/* Command for reading range */
> +#define MB1232_ADDR_UNLOCK_1	0xAA	/* Command 1 for changing address */
> +#define MB1232_ADDR_UNLOCK_2	0xA5	/* Command 2 for changing address */
> +
> +struct mb1232_data {
> +	struct i2c_client	*client;
> +
> +	struct mutex		lock;
> +
> +	/*
> +	 * optionally a gpio can be used to announce when ranging has
> +	 * finished
> +	 * since we are just using the falling trigger of it we request
> +	 * only the interrupt for announcing when data is ready to be read
> +	 */
> +	struct completion	ranging;
> +	int			irqnr;
> +};
> +
> +static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct mb1232_data *data = iio_priv(indio_dev);
> +
> +	complete(&data->ranging);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static s16 mb1232_read_distance(struct mb1232_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	s16 distance;
> +	__be16 buf;
> +
> +	mutex_lock(&data->lock);
> +
> +	reinit_completion(&data->ranging);
> +
> +	ret = i2c_smbus_write_byte(client, MB1232_RANGE_COMMAND);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write command - err: %d\n", ret);
> +		goto error_unlock;
> +	}
> +
> +	if (data->irqnr >= 0) {
> +		/* it cannot take more than 100 ms */
> +		ret = wait_for_completion_killable_timeout(&data->ranging,
> +									HZ/10);
> +		if (ret < 0)
> +			goto error_unlock;
> +		else if (ret == 0) {
> +			ret = -ETIMEDOUT;
> +			goto error_unlock;
> +		}
> +	} else {
> +		/* use simple sleep if announce irq is not connected */
> +		msleep(15);
> +	}
> +
> +	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c_master_recv: ret=%d\n", ret);
> +		goto error_unlock;
> +	}
> +
> +	distance = __be16_to_cpu(buf);
> +	/* check for not returning misleading error codes */
> +	if (distance < 0) {
> +		dev_err(&client->dev, "distance=%d\n", distance);
> +		ret = -EINVAL;
> +		goto error_unlock;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return distance;
> +
> +error_unlock:
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t mb1232_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mb1232_data *data = iio_priv(indio_dev);
> +	/*
> +	 * triggered buffer
> +	 * 16-bit channel + 48-bit padding + 64-bit timestamp
> +	 */
> +	s16 buffer[8];

I'm going to tweak this ever so slightly to force it being set to 0.
Otherwise we have a kernel data leak. = {0,}; should do the job.


> +
> +	buffer[0] = mb1232_read_distance(data);
> +	if (buffer[0] < 0)
> +		goto err;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mb1232_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mb1232_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (channel->type != IIO_DISTANCE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = mb1232_read_distance(data);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 1 LSB is 1 cm */
> +		*val = 0;
> +		*val2 = 10000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec mb1232_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate =
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE),

Plenty of room to not have this on as many lines..

> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static const struct iio_info mb1232_info = {
> +	.read_raw = mb1232_read_raw,
> +};
> +
> +static int mb1232_probe(struct i2c_client *client,
> +					 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mb1232_data *data;
> +	int ret;
> +	struct device *dev = &client->dev;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_READ_BYTE |
> +					I2C_FUNC_SMBUS_WRITE_BYTE))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->info = &mb1232_info;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mb1232_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mb1232_channels);
> +
> +	mutex_init(&data->lock);
> +
> +	init_completion(&data->ranging);
> +
> +	data->irqnr = irq_of_parse_and_map(dev->of_node, 0);
> +	if (data->irqnr <= 0) {
> +		/* usage of interrupt is optional */
> +		data->irqnr = -1;
> +	} else {
> +		ret = devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
> +				IRQF_TRIGGER_FALLING, id->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +			iio_pollfunc_store_time, mb1232_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "setup of iio triggered buffer failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id of_mb1232_match[] = {
> +	{ .compatible = "maxbotix,mb1202", },
> +	{ .compatible = "maxbotix,mb1212", },
> +	{ .compatible = "maxbotix,mb1222", },
> +	{ .compatible = "maxbotix,mb1232", },
> +	{ .compatible = "maxbotix,mb1242", },
> +	{ .compatible = "maxbotix,mb7040", },
> +	{ .compatible = "maxbotix,mb7137", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_mb1232_match);
> +
> +static const struct i2c_device_id mb1232_id[] = {
> +	{ "maxbotix-mb1202", },
> +	{ "maxbotix-mb1212", },
> +	{ "maxbotix-mb1222", },
> +	{ "maxbotix-mb1232", },
> +	{ "maxbotix-mb1242", },
> +	{ "maxbotix-mb7040", },
> +	{ "maxbotix-mb7137", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mb1232_id);
> +
> +static struct i2c_driver mb1232_driver = {
> +	.driver = {
> +		.name	= "maxbotix-mb1232",
> +		.of_match_table	= of_mb1232_match,
> +	},
> +	.probe = mb1232_probe,
> +	.id_table = mb1232_id,
> +};
> +module_i2c_driver(mb1232_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("Maxbotix I2CXL-MaxSonar i2c ultrasonic ranger driver");
> +MODULE_LICENSE("GPL");

