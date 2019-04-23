Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D79D2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="hhqg/aVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfDWLdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:33:16 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:41734 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWLdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:33:15 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 3ED52E0382; Tue, 23 Apr 2019 13:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1556019193; bh=UeWOIq3AxhrAzOgQRK9PS0/pAtsncKtq2HQDblty1D8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hhqg/aVZ3CfD9D+EGpHStcEzYfBb8DMtmhOG8Co0gMdZTM6NENZsRdahW3+3lZ+1q
         PXGJSLtlI6zAEABW37K1LeisQmbr9+wyPAsoe2SaRzVeymSru/H2I0zfzSsrvj3Hak
         TSKEnz/aogX0bwSiR9AxxaxmDm6HjjXEPQgGuHK0=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 31558E0306;
        Tue, 23 Apr 2019 13:33:13 +0200 (CEST)
Date:   Tue, 23 Apr 2019 13:33:13 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Alexandre Mergnat <amergnat@baylibre.com>
cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io
Subject: Re: [PATCH v2 3/3] iio: Add PAT9125 optical tracker sensor
In-Reply-To: <1556016046-31231-4-git-send-email-amergnat@baylibre.com>
Message-ID: <alpine.DEB.2.21.1904231302210.24175@vps.pmeerw.net>
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com> <1556016046-31231-4-git-send-email-amergnat@baylibre.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="324302256-1706452390-1556017922=:24175"
Content-ID: <alpine.DEB.2.21.1904231312310.24175@vps.pmeerw.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324302256-1706452390-1556017922=:24175
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1904231312311.24175@vps.pmeerw.net>


some comments below...
a link to the datasheet would be nice

> This adds support for PixArt Imaging¢s miniature low power
> optical navigation chip using LASER light source
> enabling digital surface tracking.
> 
> This IIO driver allow to read delta position on 2 axis (X and Y).

allows

> The values can be taken through ponctual "read_raw" which will issue

punctual

> a read in the device registers to return the delta between last read/buffering
> or subscribe to the data buffer feed automaticaly by a new value using an

automatica_l_ly

> IIO trigger. The buffer payload is: |32 bits delta X|32 bits delta Y|timestamp|.
> It also provide an IIO trigger which fire when a motion is detected.

provides
fires

> This trigger should be reset after each fire by a simple "read_raw" if you aren't
> in buffer mode.
> 
> The possible I2C adresses are 0x73, 0x75 and 0x79.
> 
> X and Y axis resolution can be setup independently through module parameter.

really? can't this be done using _SCALE?

> 
> The "ot" directory is added to coutain Optical Tracker drivers.

contain


how is this thing different from a mouse device?


> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/iio/Kconfig      |   1 +
>  drivers/iio/Makefile     |   1 +
>  drivers/iio/ot/Kconfig   |  16 ++
>  drivers/iio/ot/Makefile  |   6 +
>  drivers/iio/ot/pat9125.c | 487 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 511 insertions(+)
>  create mode 100644 drivers/iio/ot/Kconfig
>  create mode 100644 drivers/iio/ot/Makefile
>  create mode 100644 drivers/iio/ot/pat9125.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d08aeb41cd07..bdf1bd061168 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -86,6 +86,7 @@ source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
>  source "drivers/iio/multiplexer/Kconfig"
>  source "drivers/iio/orientation/Kconfig"
> +source "drivers/iio/ot/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index cb5993251381..fdda2e185005 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -32,6 +32,7 @@ obj-y += light/
>  obj-y += magnetometer/
>  obj-y += multiplexer/
>  obj-y += orientation/
> +obj-y += ot/
>  obj-y += potentiometer/
>  obj-y += potentiostat/
>  obj-y += pressure/
> diff --git a/drivers/iio/ot/Kconfig b/drivers/iio/ot/Kconfig
> new file mode 100644
> index 000000000000..3d17fdaa06ed
> --- /dev/null
> +++ b/drivers/iio/ot/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# Optical tracker sensors
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Optical tracker sensors"
> +
> +config PAT9125
> +	tristate "Optical tracker PAT9125 I2C driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for PAT9125 optical tracker
> +	  sensors.
> +
> +endmenu
> diff --git a/drivers/iio/ot/Makefile b/drivers/iio/ot/Makefile
> new file mode 100644
> index 000000000000..cf294917ae2c
> --- /dev/null
> +++ b/drivers/iio/ot/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O Optical tracker sensor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_PAT9125) += pat9125.o
> diff --git a/drivers/iio/ot/pat9125.c b/drivers/iio/ot/pat9125.c
> new file mode 100644
> index 000000000000..48c1651b4e6a
> --- /dev/null
> +++ b/drivers/iio/ot/pat9125.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Copyright (C) 2019 BayLibre, SAS
> + * Author: Alexandre Mergnat <amergnat@baylibre.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/* I2C Address function to ID pin*/
> +#define PAT9125_I2C_ADDR_HI		0x73
> +#define PAT9125_I2C_ADDR_LO		0x75
> +#define PAT9125_I2C_ADDR_NC		0x79
> +
> +/* Registers */
> +#define PAT9125_PRD_ID1_REG		0x00
> +#define PAT9125_PRD_ID2_REG		0x01
> +#define PAT9125_MOTION_STATUS_REG	0x02
> +#define PAT9125_DELTA_X_LO_REG		0x03
> +#define PAT9125_DELTA_Y_LO_REG		0x04
> +#define PAT9125_OP_MODE_REG		0x05
> +#define PAT9125_CONFIG_REG		0x06
> +#define PAT9125_WRITE_PROTEC_REG	0x09
> +#define PAT9125_SLEEP1_REG		0x0A
> +#define PAT9125_SLEEP2_REG		0x0B
> +#define PAT9125_RES_X_REG		0x0D
> +#define PAT9125_RES_Y_REG		0x0E
> +#define PAT9125_DELTA_XY_HI_REG		0x12
> +#define PAT9125_SHUTER_REG		0x14
> +#define PAT9125_FRAME_AVG_REG		0x17
> +#define PAT9125_ORIENTATION_REG		0x19
> +
> +/* Bits */
> +#define PAT9125_VALID_MOTION_DATA_BIT	0x80
> +#define PAT9125_RESET_BIT		0x80

could use BIT()

> +
> +/* Registers' values */
> +#define PAT9125_SENSOR_ID_VAL			0x31
> +#define PAT9125_DISABLE_WRITE_PROTECT_VAL	0x5A
> +#define PAT9125_ENABLE_WRITE_PROTECT_VAL	0x00
> +#define PAT9125_CPI_RESOLUTION_X_VAL		0x65
> +#define PAT9125_CPI_RESOLUTION_Y_VAL		0xFF
> +
> +/* Default Value of sampled value size */
> +#define PAT9125_SAMPLED_VAL_BIT_SIZE		12
> +
> +struct pat9125_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *indio_trig;	/* Motion detection */
> +	s64 ts;				/* Timestamp */
> +	s32 delta_x;
> +	s32 delta_y;
> +	s32 motion_detected;
> +	bool buffer_mode;
> +};
> +
> +static u8 x_resolution = 0x14;
> +module_param(x_resolution, byte, 0644);
> +MODULE_PARM_DESC(x_resolution, "CPI resolution setting for X axis.");
> +
> +static u8 y_resolution = 0x14;
> +module_param(y_resolution, byte, 0644);
> +MODULE_PARM_DESC(y_resolution, "CPI resolution setting for Y axis.");

I think these should be exposed as IIO _SCALE

> +
> +static const struct iio_event_spec pat9125_event = {
> +	.type = IIO_EV_TYPE_THRESH,
> +	.dir = IIO_EV_DIR_RISING,
> +	.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +};
> +
> +static const struct iio_chan_spec pat9125_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',			\
> +			.realbits = 32,			\
> +			.storagebits = 32,		\
> +			.shift = 0,			\

no need to specify shift = 0

> +			.endianness = IIO_LE,		\
> +		},
> +		.event_spec = &pat9125_event,
> +		.num_event_specs = 1,
> +	},
> +	{
> +		.type = IIO_DISTANCE,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',			\
> +			.realbits = 32,			\
> +			.storagebits = 32,		\
> +			.shift = 0,			\
> +			.endianness = IIO_LE,		\

endianness should be IIO_CPU, no _LE
data is handled by _read_delta() and happily used in arithmetic; maybe 
there is endianness conversion missing in the regmap setup

> +		},
> +		.event_spec = &pat9125_event,
> +		.num_event_specs = 1,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static int pat9125_read_delta(struct pat9125_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int status = 0;
> +	int val_x = 0;
> +	int val_y = 0;
> +	int val_high_nibbles = 0;
> +	int old_motion_status;
> +	int ret;
> +
> +	old_motion_status = data->motion_detected;
> +	data->motion_detected = 0;
> +	ret = regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> +	if (ret < 0) {
> +		data->motion_detected = old_motion_status;
> +		return ret;
> +	}
> +
> +	/* Check if motion is detected */
> +	if (status & PAT9125_VALID_MOTION_DATA_BIT) {
> +		ret = regmap_read(regmap, PAT9125_DELTA_X_LO_REG, &val_x);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_read(regmap, PAT9125_DELTA_Y_LO_REG, &val_y);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_read(regmap, PAT9125_DELTA_XY_HI_REG, &val_high_nibbles);
> +		if (ret < 0)
> +			return ret;
> +
> +		val_x |= (val_high_nibbles << 4) & 0xF00;
> +		val_y |= (val_high_nibbles << 8) & 0xF00;
> +
> +		val_x = sign_extend32(val_x,
> +			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
> +
> +		val_y = sign_extend32(val_y,
> +			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
> +
> +
> +		data->delta_x += val_x;
> +		data->delta_y += val_y;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pat9125_read_raw() - Sample and return the value(s)
> + * function to the associated channel info enum.
> + **/
> +static int pat9125_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pat9125_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pat9125_read_delta(data);
> +		if (ret)
> +			return ret;
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			*val = data->delta_x;
> +			data->delta_x = 0;
> +			break;
> +		case IIO_MOD_Y:
> +			*val = data->delta_y;
> +			data->delta_y = 0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT;

I'd move the
return IIO_VAL_INT up, instead of the break;

> +	default:
> +		return -EINVAL;
> +	}
> +	return -EINVAL;

no need, dead code

> +}
> +
> +static irqreturn_t pat9125_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct pat9125_data *data = iio_priv(indio_dev);
> +	u8 buf[16]; /* Payload: Delta_X (4) | Delta_Y (4) | Timestamp (8) */
> +	int ret;
> +
> +	ret = pat9125_read_delta(data);
> +	if (ret) {
> +		iio_trigger_notify_done(indio_dev->trig);
> +		return IRQ_NONE;
> +	}
> +	data->ts = iio_get_time_ns(indio_dev);
> +	memcpy(&buf[0], &data->delta_x, 4);
> +	memcpy(&buf[4], &data->delta_y, 4);

why memcpy?
4 == sizeof(s32)

> +	data->delta_x = 0;
> +	data->delta_y = 0;
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, data->ts);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * pat9125_event_handler() - handling ring and non ring events
> + * @irq: The irq being handled.
> + * @private: struct iio_device pointer for the device.
> + */
> +static irqreturn_t pat9125_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct pat9125_data *data = iio_priv(indio_dev);
> +
> +	iio_trigger_poll(data->indio_trig);
> +	data->motion_detected = 1;
> +	return IRQ_HANDLED;
> +}
> +
> +static int pat9125_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct pat9125_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +	data->buffer_mode = true;
> +	/* Release IRQ on the chip */
> +	return pat9125_read_delta(data);
> +}
> +
> +static int pat9125_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct pat9125_data *data = iio_priv(indio_dev);
> +
> +	data->buffer_mode = false;
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops pat9125_buffer_ops = {
> +	.preenable = NULL,
> +	.postenable = pat9125_buffer_postenable,
> +	.predisable = pat9125_buffer_predisable,
> +	.postdisable = NULL,
> +};
> +
> +
> +static const struct regmap_config pat9125_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct iio_info pat9125_info = {
> +	.read_raw = pat9125_read_raw,
> +};
> +
> +/*
> + * To avoid infinite loop in "iio_trigger_notify_done",
> + * try_reenable must return 0 when it isn't in buffer mode.
> + * This implementation avoid corner case.
> + */
> +static int pat9125_trig_try_reen(struct iio_trigger *trig)

maybe spell out try_reenable to match comment above

> +{
> +	struct pat9125_data *data = iio_trigger_get_drvdata(trig);
> +
> +	if (data->buffer_mode)
> +		return data->motion_detected;
> +	else
> +		return 0;
> +}
> +
> +static const struct iio_trigger_ops pat9125_trigger_ops = {
> +	.try_reenable = pat9125_trig_try_reen,
> +};
> +
> +static int pat9125_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pat9125_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, sensor_pid;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "IIO device allocation failed");

I'd rather remove the error message, it probably will never happen :)
dev_err() wants \n at the end of the message (here and elsewhere)

> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = pat9125_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(pat9125_channels);
> +	indio_dev->info = &pat9125_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	data->motion_detected = 0;
> +	data->buffer_mode = false;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL, pat9125_trigger_handler,
> +					 &pat9125_buffer_ops);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	data->indio_trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +		indio_dev->name, indio_dev->id);
> +	if (!data->indio_trig) {
> +		return -ENOMEM;
> +	}
> +	data->indio_trig->dev.parent = &client->dev;
> +	data->indio_trig->ops = &pat9125_trigger_ops;
> +	iio_trigger_set_drvdata(data->indio_trig, data);
> +	ret = iio_trigger_register(data->indio_trig);
> +	if (ret) {
> +		iio_trigger_unregister(data->indio_trig);

no need to unregister trigger if trigger_register() failed?

> +		return ret;
> +	}
> +
> +	data->regmap = devm_regmap_init_i2c(client, &pat9125_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap init failed %ld",
> +			PTR_ERR(data->regmap));
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/* Check device ID */
> +	ret = regmap_read(data->regmap, PAT9125_PRD_ID1_REG, &sensor_pid);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_PRD_ID1_REG, ret);
> +		return ret;
> +	}
> +	if (sensor_pid != PAT9125_SENSOR_ID_VAL)
> +		return -ENODEV;
> +
> +	/* 
> +	 * Software reset
> +	 */

single line comment?

> +	ret = regmap_write_bits(data->regmap,
> +			      PAT9125_CONFIG_REG,
> +			      PAT9125_RESET_BIT,
> +			      1);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_CONFIG_REG, ret);
> +		return ret;
> +	}
> +
> +	msleep(20);
> +
> +	ret = regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_DISABLE_WRITE_PROTECT_VAL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_WRITE_PROTEC_REG, ret);
> +		return ret;
> +	}
> +	ret = regmap_write(data->regmap,
> +			 PAT9125_RES_X_REG,
> +			 x_resolution);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_RES_X_REG, ret);
> +		return ret;
> +	}
> +	ret = regmap_write(data->regmap,
> +			 PAT9125_RES_Y_REG,
> +			 y_resolution);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_RES_Y_REG, ret);
> +		return ret;
> +	}
> +	/* Enable write protection */
> +	ret = regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_ENABLE_WRITE_PROTECT_VAL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d",
> +			PAT9125_WRITE_PROTEC_REG, ret);
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "IIO device register failed");
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	dev_info(&client->dev, "%s: sensor '%s'\n",
> +		 dev_name(&indio_dev->dev),
> +		 client->name);

please avoid log output, it just clutters the log

> +
> +	/* Make read to reset motion bit status */
> +	ret = pat9125_read_delta(data);
> +	if (ret) {
> +		dev_err(&client->dev, "Read register failed");
> +		return ret;
> +	}
> +
> +	/* Init GPIO IRQ */
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev,
> +					      client->irq,
> +					      pat9125_event_handler,
> +					      NULL,
> +					      IRQF_TRIGGER_FALLING,
> +					      "pat9125",
> +					      indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "GPIO IRQ init failed");
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int pat9125_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = devm_iio_device_alloc(&client->dev, sizeof(struct pat9125_data));
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	dev_info(&client->dev, "PAT9125 removed\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pat9125_id[] = {
> +	{ "pat9125", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pat9125_id);
> +
> +static const unsigned short normal_i2c[] = {
> +	PAT9125_I2C_ADDR_HI,
> +	PAT9125_I2C_ADDR_LO,
> +	PAT9125_I2C_ADDR_NC,
> +	I2C_CLIENT_END
> +};
> +
> +static struct i2c_driver pat9125_driver = {
> +	.driver = {
> +		.name = "pat9125",
> +	},
> +	.probe = pat9125_probe,
> +	.remove = pat9125_remove,
> +	.address_list = normal_i2c,
> +	.id_table = pat9125_id,
> +};
> +
> +module_i2c_driver(pat9125_driver);
> +
> +MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
> +MODULE_DESCRIPTION("Optical Tracking sensor");
> +MODULE_LICENSE("GPL");
> \ No newline at end of file
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
--324302256-1706452390-1556017922=:24175--
