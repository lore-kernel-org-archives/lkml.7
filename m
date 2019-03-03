Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12565C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7F120866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="UkK5CBtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfCCRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:49:40 -0500
Received: from ns.pmeerw.net ([84.19.176.117]:48420 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfCCRtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:49:40 -0500
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 497AAE02CB; Sun,  3 Mar 2019 18:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1551635378; bh=chbnfze41O/2X5TjNQ0QWgNPPlcGJvRPNDcLCCJb3Ok=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UkK5CBtPQi2IBrAa+31T9r8B87O1lO55xY0ViaT3IaSYcLSSHz5/Kf+RKQQgzMEsW
         WH/HKt2YW+7qXPVFvdNG8QpaqwdCe91UcPBQwPlhc1HEKn6+/DWPCjMkse7wWL8XIH
         Tdm6ecOCa1jEGeehYdEYeAww50w4TGOM9gqk5kIo=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2D309E0205;
        Sun,  3 Mar 2019 18:49:38 +0100 (CET)
Date:   Sun, 3 Mar 2019 18:49:38 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Andreas Klinger <ak@it-klinger.de>
cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-kernel@vger.kernel.org, techsupport@maxbotix.com
Subject: Re: [PATCH v2 3/4] mb12x2.c: add distance iio sensor with i2c
In-Reply-To: <20190301134255.tsixtoqlxnoa2kig@arbad>
Message-ID: <alpine.DEB.2.21.1903031848260.28276@vps.pmeerw.net>
References: <20190301134255.tsixtoqlxnoa2kig@arbad>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019, Andreas Klinger wrote:

> Add I2CXL-MaxSonar ultrasonic distance sensors of type family mb12x2 using
> an i2c interface

small comment below
 
> Implemented functionality:
> - reading the distance via in_distance_raw
> - buffered mode with trigger
> - make use of status gpio to announce completion of ranging
> 
> Add mb12x2 driver to Kconfig and Makefile
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/proximity/Kconfig  |  11 ++
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/mb12x2.c | 283 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 295 insertions(+)
>  create mode 100644 drivers/iio/proximity/mb12x2.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index b99367a89f81..a420f2cb314b 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -45,6 +45,17 @@ config LIDAR_LITE_V2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pulsedlight-lite-v2
>  
> +config MB12X2
> +	tristate "MaxSonar MB12X2 family ultrasonic sensors"
> +	depends on I2C
> +	help
> +	  Say Y to build a driver for the ultrasonic sensors I2CXL of
> +	  MaxBotix which have an i2c interface. It can be used to measure
> +	  the distance of objects.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mb12x2.
> +
>  config RFD77402
>  	tristate "RFD77402 ToF sensor"
>  	depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 6d031f903c4c..be9a14db77e7 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
> +obj-$(CONFIG_MB12X2)		+= mb12x2.o
>  obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
> diff --git a/drivers/iio/proximity/mb12x2.c b/drivers/iio/proximity/mb12x2.c
> new file mode 100644
> index 000000000000..8b1ac901c253
> --- /dev/null
> +++ b/drivers/iio/proximity/mb12x2.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mb12x2.c - Support for MaxBotix I2CXL-MaxSonar-EZ series ultrasonic
> + *   ranger with i2c interface
> + * actually supported are mb12x2 types
> + *
> + * Copyright (c) 2019 Andreas Klinger <ak@it-klinger.de>
> + *
> + * For details about the device see:
> + * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio/consumer.h>
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
> +#define MB12X2_RANGE_COMMAND	0x51	/* Command for reading range */
> +#define MB12X2_ADDR_UNLOCK_1	0xAA	/* Command 1 for changing address */
> +#define MB12X2_ADDR_UNLOCK_2	0xA5	/* Command 2 for changing address */
> +
> +struct mb12x2_data {
> +	struct i2c_client	*client;
> +
> +	struct mutex		lock;
> +
> +	/*
> +	 * optionally a gpio can be used to announce when ranging has
> +	 * finished
> +	 */
> +	struct completion	ranging;
> +	struct gpio_desc	*gpiod_status;
> +	int			irqnr;
> +
> +	/*
> +	 * triggered buffer
> +	 * 1x16-bit channel + 3x16 padding + 4x16 timestamp
> +	 */
> +	s16			buffer[8];
> +};
> +
> +static irqreturn_t mb12x2_handle_irq(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct mb12x2_data *data = iio_priv(indio_dev);
> +
> +	/* double check to make sure data is now available */
> +	if (!gpiod_get_value(data->gpiod_status))
> +		complete(&data->ranging);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static s16 mb12x2_read_distance(struct mb12x2_data *data)
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
> +	ret = i2c_smbus_write_byte(client, MB12X2_RANGE_COMMAND);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write command - err: %d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	if (data->gpiod_status) {
> +		/* it cannot take more than 100 ms */
> +		ret = wait_for_completion_killable_timeout(&data->ranging,
> +									HZ/10);
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		} else if (ret == 0) {
> +			mutex_unlock(&data->lock);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		/*
> +		 * use simple sleep if gpio announce pin is not connected
> +		 */
> +		msleep(15);
> +	}
> +
> +	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c_master_recv: ret=%d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	distance = __be16_to_cpu(buf);
> +	/* check for not returning misleading error codes */
> +	if (distance < 0) {
> +		dev_err(&client->dev, "distance=%d\n", distance);

mutex_unlock() missing, the unlock could be done right after 
i2c_master_recv()

> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return distance;
> +}
> +
> +static irqreturn_t mb12x2_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mb12x2_data *data = iio_priv(indio_dev);
> +	s16 sensor_data;
> +
> +	sensor_data = mb12x2_read_distance(data);
> +	if (sensor_data < 0)
> +		goto err;
> +
> +	mutex_lock(&data->lock);
> +
> +	data->buffer[0] = sensor_data;
> +	iio_push_to_buffers_with_timestamp(indio_dev,
> +						data->buffer, pf->timestamp);
> +
> +	mutex_unlock(&data->lock);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mb12x2_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mb12x2_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (channel->type != IIO_DISTANCE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = mb12x2_read_distance(data);
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
> +static const struct iio_chan_spec mb12x2_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate =
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE),
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
> +static const struct iio_info mb12x2_info = {
> +	.read_raw = mb12x2_read_raw,
> +};
> +
> +static int mb12x2_probe(struct i2c_client *client,
> +					 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mb12x2_data *data;
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
> +	indio_dev->info = &mb12x2_info;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mb12x2_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mb12x2_channels);
> +
> +	mutex_init(&data->lock);
> +
> +	init_completion(&data->ranging);
> +
> +	data->gpiod_status = devm_gpiod_get(dev, "status", GPIOD_IN);
> +	if (IS_ERR(data->gpiod_status)) {
> +		if (PTR_ERR(data->gpiod_status) == -ENOENT) {
> +			dev_warn(dev, "no status gpio --> use sleep instead\n");
> +			data->gpiod_status = NULL;
> +		} else {
> +			dev_err(dev, "cannot setup gpio; err=%ld\n",
> +					PTR_ERR(data->gpiod_status));
> +			return PTR_ERR(data->gpiod_status);
> +		}
> +	}
> +
> +	if (data->gpiod_status) {
> +		data->irqnr = gpiod_to_irq(data->gpiod_status);
> +		if (data->irqnr < 0) {
> +			dev_err(dev, "gpiod_to_irq: %d\n", data->irqnr);
> +			return data->irqnr;
> +		}
> +
> +		ret = devm_request_irq(dev, data->irqnr, mb12x2_handle_irq,
> +				IRQF_TRIGGER_FALLING, id->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +			iio_pollfunc_store_time, mb12x2_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "setup of iio triggered buffer failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id of_mb12x2_match[] = {
> +	{ .compatible = "maxbotix,i2cxl", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_mb12x2_match);
> +
> +static const struct i2c_device_id mb12x2_id[] = {
> +	{ "maxbotix-i2cxl", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mb12x2_id);
> +
> +static struct i2c_driver mb12x2_driver = {
> +	.driver = {
> +		.name	= "maxbotix-i2cxl",
> +		.of_match_table	= of_mb12x2_match,
> +	},
> +	.probe = mb12x2_probe,
> +	.id_table = mb12x2_id,
> +};
> +module_i2c_driver(mb12x2_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("Maxbotix I2CXL-MaxSonar i2c ultrasonic ranger driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
