Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B44C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494120881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHemmLnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfD0V2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 17:28:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38242 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfD0V2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 17:28:02 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so5831183ior.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7R3us7MAjDIHqFc3bJGXwO9MlcZG0SiBL28P8TJB3UE=;
        b=SHemmLnYGo6fqVvXU8gzEC0jIPTX5Lk6vqT38KccquJyP3lKI5DoEdaWUR/UdcuEaf
         VzRy3BL7miMEViAB1/QX1VqOht9lR1abuhdtgB+c7pbNAQ7Bx/cS2iiyrZte2khqitcq
         t70mHo9zDMQYtcp4pPPJ8HWhLnoOlg4o03oSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7R3us7MAjDIHqFc3bJGXwO9MlcZG0SiBL28P8TJB3UE=;
        b=qAxBBoQ14SHCdHs8wm8L3kcmEoy0EZZUrionPZeBEDW8+BpqefsB4l5P7vmV4oZGtK
         y0qm1nP5KPYeVyKiS3EXSOhAEVj1Zq4PReuyMgBGD8f5e7lUFSVi7CbBuyGNGkmraQRS
         HEBLxbvMrgH0zVSBD5KNhR107WRZe7tM7xHHAjvJG9Ub+aw6IyRH2QAt7LgCSYJDCZ5B
         8k4+3+bRk4F6HDSR5FYd3pmo6+rtNevozUWtR2PPwBHB6Q0KpbANrvMpLCpvPZg0LE5r
         L1pkjrDSH211IMfYJX2JqLIw16sICPXJDlFvNzJ5AiciU0ZQXsOtBcd2jrFf5FOzAGhw
         /oTg==
X-Gm-Message-State: APjAAAXEbqurUIqE2VuoPxCVLc9rcaARTXUDDtkPOtPNmD5HTs7hvYZj
        LaxYFh5dmRYKgINh3P3gQ1nvpKQAKEl417VtBiGsgg==
X-Google-Smtp-Source: APXvYqzW2dNX6MjNBrvfAQfFGlPNazOk2JU2K+lpzOgDY1Lnjn4NHS1M5VAOfc89K6D5N4+xe6a3zDxoaEo2iZoXfto=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr26046685ioz.118.1556400480831;
 Sat, 27 Apr 2019 14:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190425002932.126740-1-gwendal@chromium.org> <20190427142112.5630e664@archlinux>
 <20190427142421.6bd27cac@archlinux>
In-Reply-To: <20190427142421.6bd27cac@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 27 Apr 2019 14:27:49 -0700
Message-ID: <CAPUE2usoyd+5kmi+1qavN-A671MxHcsDEeBBDtzqW3xqj-FN=A@mail.gmail.com>
Subject: Re: [PATCH v6] iio: cros_ec: Add lid angle driver
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 6:24 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sat, 27 Apr 2019 14:21:12 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Wed, 24 Apr 2019 17:29:32 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > > Add a IIO driver that reports the angle between the lid and the base for
> > > ChromeOS convertible device.
> > >
> > Tested on eve with ToT EC firmware.
> > > Check driver is loaded and lid angle is correct.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > I am a little curious... In what way is this a counter driver (comments
> > at the top of the main file)?
It is a mistake, I used another driver .c file as a starting point. I
will fix it.
> >
> > Anyhow, that's no reason not to apply it.  However, it has just missed
> > the coming merge window unless Linus makes 'it is delayed noises' tomorrow.
> >
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> Ah. Should have waited for my local build test to finish.
>
> I'm guessing this has a dependency I don't know about?
> MOTIONSENSE_CMD_LID_ANGLE isn't defined.
Yes, that constant is part of the cros_ec_commands.h update, in patch
"[PATCH 15/30] mfd: cros_ec: Complete MEMS sensor API"

Gwendal.
>
> Jonathan
>
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > > Changes in v6:
> > > - Fix lock held in an error path error.
> > >
> > > Changes in v5:
> > > - Remove unnecessary define.
> > > - v4 was the wrong patch file
> > >
> > > Changes in v3:
> > > - Use static channel array, simplify code because index is always 0.
> > >
> > > Changes in v2:
> > > - Fix license, remove driver_module field.
> > >
> > >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
> > >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> > >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
> > >  drivers/mfd/cros_ec_dev.c                     |  13 +-
> > >  4 files changed, 159 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > >
> > > diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> > > index 135f6825903f..aacc2ab9c34f 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> > > +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> > > @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
> > >       Accelerometers, Gyroscope and Magnetometer that are
> > >       presented by the ChromeOS EC Sensor hub.
> > >       Creates an IIO device for each functions.
> > > +
> > > +config IIO_CROS_EC_SENSORS_LID_ANGLE
> > > +   tristate "ChromeOS EC Sensor for lid angle"
> > > +   depends on IIO_CROS_EC_SENSORS_CORE
> > > +   help
> > > +     Module to report the angle between lid and base for some
> > > +     convertible devices.
> > > +     This module is loaded when the EC can calculate the angle between the base
> > > +     and the lid.
> > > diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> > > index ec716ff2a775..a35ee232ac07 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/Makefile
> > > +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> > > @@ -4,3 +4,4 @@
> > >
> > >  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> > >  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> > > +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > new file mode 100644
> > > index 000000000000..876dfd176b0e
> > > --- /dev/null
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > @@ -0,0 +1,139 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> > > + *
> > > + * Copyright 2018 Google, Inc
> > > + *
> > > + * This driver uses the cros-ec interface to communicate with the Chrome OS
> > > + * EC about counter sensors. Counters are presented through
> > > + * iio sysfs.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/common/cros_ec_sensors_core.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/kfifo_buf.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/cros_ec.h>
> > > +#include <linux/mfd/cros_ec_commands.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define DRV_NAME "cros-ec-lid-angle"
> > > +
> > > +/*
> > > + * One channel for the lid angle, the other for timestamp.
> > > + */
> > > +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
> > > +   {
> > > +           .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +           .scan_type.realbits = CROS_EC_SENSOR_BITS,
> > > +           .scan_type.storagebits = CROS_EC_SENSOR_BITS,
> > > +           .scan_type.sign = 'u',
> > > +           .type = IIO_ANGL
> > > +   },
> > > +   IIO_CHAN_SOFT_TIMESTAMP(1)
> > > +};
> > > +
> > > +/* State data for ec_sensors iio driver. */
> > > +struct cros_ec_lid_angle_state {
> > > +   /* Shared by all sensors */
> > > +   struct cros_ec_sensors_core_state core;
> > > +};
> > > +
> > > +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> > > +                                     unsigned long scan_mask, s16 *data)
> > > +{
> > > +   struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > > +   int ret;
> > > +
> > > +   st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> > > +   ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> > > +   if (ret) {
> > > +           dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> > > +           return ret;
> > > +   }
> > > +
> > > +   *data = st->resp->lid_angle.value;
> > > +   return 0;
> > > +}
> > > +
> > > +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> > > +                               struct iio_chan_spec const *chan,
> > > +                               int *val, int *val2, long mask)
> > > +{
> > > +   struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> > > +   s16 data;
> > > +   int ret;
> > > +
> > > +   mutex_lock(&st->core.cmd_lock);
> > > +   ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> > > +   if (ret == 0) {
> > > +           *val = data;
> > > +           ret = IIO_VAL_INT;
> > > +   }
> > > +   mutex_unlock(&st->core.cmd_lock);
> > > +   return ret;
> > > +}
> > > +
> > > +static const struct iio_info cros_ec_lid_angle_info = {
> > > +   .read_raw = &cros_ec_lid_angle_read,
> > > +};
> > > +
> > > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > > +{
> > > +   struct device *dev = &pdev->dev;
> > > +   struct iio_dev *indio_dev;
> > > +   struct cros_ec_lid_angle_state *state;
> > > +   int ret;
> > > +
> > > +   indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > > +   if (!indio_dev)
> > > +           return -ENOMEM;
> > > +
> > > +   ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   indio_dev->info = &cros_ec_lid_angle_info;
> > > +   state = iio_priv(indio_dev);
> > > +   indio_dev->channels = cros_ec_lid_angle_channels;
> > > +   indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> > > +
> > > +   state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> > > +
> > > +   ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +                   cros_ec_sensors_capture, NULL);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return devm_iio_device_register(dev, indio_dev);
> > > +}
> > > +
> > > +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > > +   {
> > > +           .name = DRV_NAME,
> > > +   },
> > > +   { /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> > > +
> > > +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> > > +   .driver = {
> > > +           .name   = DRV_NAME,
> > > +           .pm     = &cros_ec_sensors_pm_ops,
> > > +   },
> > > +   .probe          = cros_ec_lid_angle_probe,
> > > +   .id_table       = cros_ec_lid_angle_ids,
> > > +};
> > > +module_platform_driver(cros_ec_lid_angle_platform_driver);
> > > +
> > > +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > index a3b319913097..c410aa804698 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > >
> > >     resp = (struct ec_response_motion_sense *)msg->data;
> > >     sensor_num = resp->dump.sensor_count;
> > > -   /* Allocate 1 extra sensors in FIFO are needed */
> > > -   sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > > +   /*
> > > +    * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> > > +    */
> > > +   sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
> > >                            GFP_KERNEL);
> > >     if (sensor_cells == NULL)
> > >             goto error;
> > >
> > > -   sensor_platforms = kcalloc(sensor_num + 1,
> > > +   sensor_platforms = kcalloc(sensor_num,
> > >                                sizeof(struct cros_ec_sensor_platform),
> > >                                GFP_KERNEL);
> > >     if (sensor_platforms == NULL)
> > > @@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > >             sensor_cells[id].name = "cros-ec-ring";
> > >             id++;
> > >     }
> > > +   if (cros_ec_check_features(ec,
> > > +                           EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > > +           sensor_cells[id].name = "cros-ec-lid-angle";
> > > +           id++;
> > > +   }
> > >
> > >     ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> > >                           NULL, 0, NULL);
> >
>
