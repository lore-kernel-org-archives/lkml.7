Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD439C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD19218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2m/LdPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfC2Rko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:40:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37575 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfC2Rkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:40:43 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so5178224itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFSTyjS/3oevqI9CRju/6L+hsXJ1FHpTCXZamm/FTdA=;
        b=X2m/LdPIC8HPfRJqU9YzxYks5H2sAPZrTW72dqfeMOGXEeBXoVaGrvBW+VPikkUvFg
         iE818DyasCYe/vB3P3iLBiTVIx1WyHkW2OgAvX4pAbVgkevC1RbkRUpf7Ra4EX5XR2s1
         dWbvqtV8w+8EWmhAgPbbPiGqXgmMQJwTGHCYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFSTyjS/3oevqI9CRju/6L+hsXJ1FHpTCXZamm/FTdA=;
        b=EKF5xsLl92q9vN2z5PLzBEe4l5T/NEMwuc6Ir5PpdJ9PhLug6IhmRf7/HIUqcQJ3IB
         geIglFIuYJ53hQVRZ1wl6EpYVLAOpow58tFlJK5XANrlvt8DgCmdEAlCpQ+tguiyh9EX
         kzQmChVfmGjQ/wEKxYV901nf/eeP13LUzFA/tvaGlXt251CSx7RM/2cjLgKSgJpPQx0f
         Bqa/uCcwBliMMgQ5UJP7kHJNP9H6G0tyMW+Z4u93vwpmKwQF73ftALh+SBatFPsM+LZ5
         SWHNhNsefHQ8y4+/Cg8R4Rdqjp76UQ8AV9kn54rUcuF1a6slIHgHeOUD97w35Yidgo01
         GmAQ==
X-Gm-Message-State: APjAAAXiJESVvjQqrdU4emaocHsIaMBj0/o0g3of5S7KKFvuwOKU3cmn
        RS9/LZbp+uNBY636/Foia4/A+bXeRgHZFYr6V15+2w==
X-Google-Smtp-Source: APXvYqzDruEw+xxMjG9zmqnO6p2EYBuMcP3TP9dUqG0Cy9hH0LOMFBSm7/8VET9sk2F+bLuW1xxUu/5sfj+EpM9PqXE=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr16701312jaa.52.1553881242452;
 Fri, 29 Mar 2019 10:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190311082405.GB4731@dell> <CAPUE2usOdzbHN7NN=Vg8FWE1kR2ayPYxV8qy05eB+bZgG6wD3w@mail.gmail.com>
 <CABXOdTf6kv=utOU92WbMcOAeXVKDZQ8RnNC7+t2C=7KgeNedeA@mail.gmail.com>
In-Reply-To: <CABXOdTf6kv=utOU92WbMcOAeXVKDZQ8RnNC7+t2C=7KgeNedeA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 29 Mar 2019 10:40:31 -0700
Message-ID: <CAPUE2uskDvefZbt5Ydz8Eu3+Aavu+AzPY5WuAYj0ziYP373oRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: cros_ec: Add lid angle driver
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 6:44 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 1:41 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
> >
> > Tested on eve with ToT EC firmware.
> > Check driver is loaded and lid angle is correct.
> >
> > Change-Id: I3506be4a1405f108eebe6c1d3a3dbe975ca00519
>
> drop. checkpatch.pl should report that.
>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
> >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 138 ++++++++++++++++++
> >  drivers/mfd/cros_ec_dev.c                     |  15 +-
> >  4 files changed, 160 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig
> > b/drivers/iio/common/cros_ec_sensors/Kconfig
> > index 135f6825903f..aacc2ab9c34f 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> > +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> > @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
> >           Accelerometers, Gyroscope and Magnetometer that are
> >           presented by the ChromeOS EC Sensor hub.
> >           Creates an IIO device for each functions.
> > +
> > +config IIO_CROS_EC_SENSORS_LID_ANGLE
> > +       tristate "ChromeOS EC Sensor for lid angle"
> > +       depends on IIO_CROS_EC_SENSORS_CORE
> > +       help
> > +         Module to report the angle between lid and base for some
> > +         convertible devices.
> > +         This module is loaded when the EC can calculate the angle between the base
> > +         and the lid.
> > diff --git a/drivers/iio/common/cros_ec_sensors/Makefile
> > b/drivers/iio/common/cros_ec_sensors/Makefile
> > index ec716ff2a775..a35ee232ac07 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Makefile
> > +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> > @@ -4,3 +4,4 @@
> >
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> > +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > new file mode 100644
> > index 000000000000..92be07d7fa36
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> > + *
> > + * Copyright 2018 Google, Inc
> > + *
> > + * This driver uses the cros-ec interface to communicate with the Chrome OS
> > + * EC about counter sensors. Counters are presented through
> > + * iio sysfs.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/mfd/cros_ec_commands.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define DRV_NAME "cros-ec-lid-angle"
> > +
> > +/*
> > + * One channel for the lid angle, the other for timestamp.
> > + */
> > +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
> > +       {
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +               .scan_type.realbits = CROS_EC_SENSOR_BITS,
> > +               .scan_type.storagebits = CROS_EC_SENSOR_BITS,
> > +               .scan_type.sign = 'u',
> > +               .type = IIO_ANGL
> > +       },
> > +       IIO_CHAN_SOFT_TIMESTAMP(1)
> > +};
> > +
> > +/* State data for ec_sensors iio driver. */
> > +struct cros_ec_lid_angle_state {
> > +       /* Shared by all sensors */
> > +       struct cros_ec_sensors_core_state core;
> > +};
> > +
> > +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> > +                                         unsigned long scan_mask, s16 *data)
> > +{
> > +       struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> > +       ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> > +       if (ret) {
> > +               dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> > +               return ret;
> > +       }
> > +
> > +       *data = st->resp->lid_angle.value;
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> > +                                   struct iio_chan_spec const *chan,
> > +                                   int *val, int *val2, long mask)
> > +{
> > +       struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> > +       s16 data;
> > +       int ret;
> > +
> > +       mutex_lock(&st->core.cmd_lock);
> > +       ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> > +       if (ret)
> > +               return ret;
> > +       *val = data;
> > +       mutex_unlock(&st->core.cmd_lock);
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info cros_ec_lid_angle_info = {
> > +       .read_raw = &cros_ec_lid_angle_read,
> > +};
> > +
> > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct iio_dev *indio_dev;
> > +       struct cros_ec_lid_angle_state *state;
> > +       int ret;
> > +
> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> > +       if (ret)
> > +               return ret;
> > +
> > +       indio_dev->info = &cros_ec_lid_angle_info;
> > +       state = iio_priv(indio_dev);
> > +       indio_dev->channels = cros_ec_lid_angle_channels;
> > +       indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> > +
> > +       state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> > +
> > +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                       cros_ec_sensors_capture, NULL);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > +       {
> > +               .name = DRV_NAME,
> > +       },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> > +
> > +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> > +       .driver = {
> > +               .name   = DRV_NAME,
> > +               .pm     = &cros_ec_sensors_pm_ops,
> > +       },
> > +       .probe          = cros_ec_lid_angle_probe,
> > +       .id_table       = cros_ec_lid_angle_ids,
> > +};
> > +module_platform_driver(cros_ec_lid_angle_platform_driver);
> > +
> > +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index d275deaecb12..11b5b2fd1f33 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -297,13 +297,17 @@ static void cros_ec_sensors_register(struct
> > cros_ec_dev *ec)
> >
> >         resp = (struct ec_response_motion_sense *)msg->data;
> >         sensor_num = resp->dump.sensor_count;
> > -       /* Allocate 1 extra sensors in FIFO are needed */
> > -       sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > +       /*
> > +        * Allocate extra sensors if lid angle sensor or FIFO are needed.
> > +        */
> > +#define NUM_EXTRA_SENSORS 2
> > +       sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,
> > +                              sizeof(struct mfd_cell),
> >                                GFP_KERNEL);
> >         if (sensor_cells == NULL)
> >                 goto error;
> >
> > -       sensor_platforms = kcalloc(sensor_num + 1,
> > +       sensor_platforms = kcalloc(sensor_num,
>
> Are you sure about this, or did "+ NUM_EXTRA_SENSORS" get lost ?
You're right, that's not the patch I intended to send. Resending.
>
> >                                    sizeof(struct cros_ec_sensor_platform),
> >                                    GFP_KERNEL);
> >         if (sensor_platforms == NULL)
> > @@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct
> > cros_ec_dev *ec)
> >                 sensor_cells[id].name = "cros-ec-ring";
> >                 id++;
> >         }
> > +       if (cros_ec_check_features(ec,
> > +                               EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > +               sensor_cells[id].name = "cros-ec-lid-angle";
> > +               id++;
> > +       }
> >
> >         ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> >                               NULL, 0, NULL);
> > --
> > 2.21.0.360.g471c308f928-goog
