Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605DF2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556371280;
	bh=44fk4JQq3HbLQUOyNsFIPOnB+edHKYxzMTQ/+eUMBYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YnbERQ1gaYMM9qw1VSBwjpG4x3dBzKbP9mBuf5qHiEpplYJV6pnBt0sHf6RHUD05Z
	 DfVrjCIxlquX4CGDHNY0RA+egECV/tW02TT80zk58IPACS9x8W74ymWmpUD1hg46Pp
	 nsn4wozP5EZmHyRk0V6vH4cyR/UaBu8ySUziUsSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD0NVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0NVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:21:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F432087F;
        Sat, 27 Apr 2019 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556371277;
        bh=44fk4JQq3HbLQUOyNsFIPOnB+edHKYxzMTQ/+eUMBYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=om7QvuuMmi2g9hGHzW0tMGQkoW044SaRkkZ12etdM8s0pRJuAEBhPO7NxoejR5m6d
         SOP3k289U1QSqmTfcALBeSjxjywXr5iOIsRshHT5+/FLPHb279R0nYeEL94a2taI2d
         Kb/Ze7dZYK3r0T3do+YTbQREWZ1GCYt7mwom83co=
Date:   Sat, 27 Apr 2019 14:21:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] iio: cros_ec: Add lid angle driver
Message-ID: <20190427142112.5630e664@archlinux>
In-Reply-To: <20190425002932.126740-1-gwendal@chromium.org>
References: <20190425002932.126740-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 17:29:32 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a IIO driver that reports the angle between the lid and the base for
> ChromeOS convertible device.
> 
> Tested on eve with ToT EC firmware.
> Check driver is loaded and lid angle is correct.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
I am a little curious... In what way is this a counter driver (comments
at the top of the main file)?

Anyhow, that's no reason not to apply it.  However, it has just missed
the coming merge window unless Linus makes 'it is delayed noises' tomorrow.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v6:
> - Fix lock held in an error path error.
> 
> Changes in v5:
> - Remove unnecessary define.
> - v4 was the wrong patch file
> 
> Changes in v3:
> - Use static channel array, simplify code because index is always 0.
> 
> Changes in v2:
> - Fix license, remove driver_module field.
> 
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
>  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     |  13 +-
>  4 files changed, 159 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index 135f6825903f..aacc2ab9c34f 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
>  	  Accelerometers, Gyroscope and Magnetometer that are
>  	  presented by the ChromeOS EC Sensor hub.
>  	  Creates an IIO device for each functions.
> +
> +config IIO_CROS_EC_SENSORS_LID_ANGLE
> +	tristate "ChromeOS EC Sensor for lid angle"
> +	depends on IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to report the angle between lid and base for some
> +	  convertible devices.
> +	  This module is loaded when the EC can calculate the angle between the base
> +	  and the lid.
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> index ec716ff2a775..a35ee232ac07 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> new file mode 100644
> index 000000000000..876dfd176b0e
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> + *
> + * Copyright 2018 Google, Inc
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome OS
> + * EC about counter sensors. Counters are presented through
> + * iio sysfs.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME "cros-ec-lid-angle"
> +
> +/*
> + * One channel for the lid angle, the other for timestamp.
> + */
> +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
> +	{
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type.realbits = CROS_EC_SENSOR_BITS,
> +		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
> +		.scan_type.sign = 'u',
> +		.type = IIO_ANGL
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_lid_angle_state {
> +	/* Shared by all sensors */
> +	struct cros_ec_sensors_core_state core;
> +};
> +
> +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> +					  unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> +	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> +	if (ret) {
> +		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> +		return ret;
> +	}
> +
> +	*data = st->resp->lid_angle.value;
> +	return 0;
> +}
> +
> +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    int *val, int *val2, long mask)
> +{
> +	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> +	s16 data;
> +	int ret;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> +	if (ret == 0) {
> +		*val = data;
> +		ret = IIO_VAL_INT;
> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static const struct iio_info cros_ec_lid_angle_info = {
> +	.read_raw = &cros_ec_lid_angle_read,
> +};
> +
> +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_lid_angle_state *state;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &cros_ec_lid_angle_info;
> +	state = iio_priv(indio_dev);
> +	indio_dev->channels = cros_ec_lid_angle_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> +
> +	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +			cros_ec_sensors_capture, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> +	{
> +		.name = DRV_NAME,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> +
> +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> +	.driver = {
> +		.name	= DRV_NAME,
> +		.pm	= &cros_ec_sensors_pm_ops,
> +	},
> +	.probe		= cros_ec_lid_angle_probe,
> +	.id_table	= cros_ec_lid_angle_ids,
> +};
> +module_platform_driver(cros_ec_lid_angle_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a3b319913097..c410aa804698 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  
>  	resp = (struct ec_response_motion_sense *)msg->data;
>  	sensor_num = resp->dump.sensor_count;
> -	/* Allocate 1 extra sensors in FIFO are needed */
> -	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> +	/*
> +	 * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> +	 */
> +	sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
>  			       GFP_KERNEL);
>  	if (sensor_cells == NULL)
>  		goto error;
>  
> -	sensor_platforms = kcalloc(sensor_num + 1,
> +	sensor_platforms = kcalloc(sensor_num,
>  				   sizeof(struct cros_ec_sensor_platform),
>  				   GFP_KERNEL);
>  	if (sensor_platforms == NULL)
> @@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  		sensor_cells[id].name = "cros-ec-ring";
>  		id++;
>  	}
> +	if (cros_ec_check_features(ec,
> +				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> +		sensor_cells[id].name = "cros-ec-lid-angle";
> +		id++;
> +	}
>  
>  	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
>  			      NULL, 0, NULL);

