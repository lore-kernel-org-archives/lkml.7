Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD86C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B9921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/hDRRn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFNVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:54:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38030 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:54:36 -0400
Received: by mail-io1-f65.google.com with SMTP id d12so997920iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVo7qOfByxolpRzlackMaw+aDiZHCV8QGz8sKLf/flw=;
        b=k/hDRRn5zN14Qi6bplmQTk+1/jMRHvLgXEJw8wHxF6+ZklIpn5/O4pDShVSvMnAVPk
         nMf0cFh9yQNl0F/7/PXeG1KfQQkmHxPMxtXDc22bhZDn2VevS3IA2OgTSnoxqknP57RW
         bXChua3A3AfCMSeJTjx/DhTUPIXST/tMmGP9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVo7qOfByxolpRzlackMaw+aDiZHCV8QGz8sKLf/flw=;
        b=fOQkAsHVMJfaLGs2jAXezUsMyQvuFnC+fCcymK2pjF9d6pMufvfz08/6nLzw/WB6gh
         n8Gq48XAmgQ1Z5YP3cIU3FJFTWDGp6ScbT1RdT63uqOq4CjZ+Z3bObMW1ZWh5lwZ6RIG
         BGQccotzBKQTe/+umvGMCwtvy4F6OefybIaorR+EuTjl2AyGIZRJxTD/trT+CA5dgyUi
         cLfxDzzHNEnYatzRTBYOa5PfadQJWrZ4LHiY7tjPamhRgIWC9Ins4NEcWJxo6sEK9Au7
         KXBqYe6sXisTWHlR5ZGPcY/pZj6v0hoITA8bmdZ7dHa3r6Bxrs8X3e/Jh6MT9fwt1BRX
         PBUQ==
X-Gm-Message-State: APjAAAXyRfEd6iM21o9N84PcoqjvSdgESyqqcWgGt2pq9+YXsVUQlcUh
        KtAHHOS6bOwIc0oPJxmUG+sUlDT3R6zpDmA4KQkT5w==
X-Google-Smtp-Source: APXvYqy44NTXHYrq/j6lNqoMowy4Le4esgME9xfGRvwSBvIzWT4MFQ4BrYNZR9F7x4IQhO7ZlrdwTlbdNI/AtmJE+zc=
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr34140466ioo.95.1560549275060;
 Fri, 14 Jun 2019 14:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190517233856.155793-1-gwendal@chromium.org> <20190517233856.155793-3-gwendal@chromium.org>
 <20190518105350.1a863bfd@archlinux>
In-Reply-To: <20190518105350.1a863bfd@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 14 Jun 2019 14:54:24 -0700
Message-ID: <CAPUE2uvONxJN7MdUKU-tCx59kd+x+pbYqPH8fLKbSp4_cvSzJg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: cros_ec: Add lid angle driver
To:     Jonathan Cameron <jic23@kernel.org>
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

On Sat, May 18, 2019 at 2:53 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 17 May 2019 16:38:56 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
> >
> > Tested on eve with ToT EC firmware.
> > Check driver is loaded and lid angle is correct.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Hi Gwendal.
>
> Please do list dependencies in patches.  I think this one is still
> dependent on the larger set of MFD changes.
>
> For my reference
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Please do poke if this seems to have gotten lost once the precursors
> are upstream.
The large set of MFD changes for update cros_ec_commands.h has landed
in a immutable branch:
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git branch
ib-mfd-cros-5.3.

Thanks,
Gwendal.


>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes in v7:
> > - Split patch in two: This is the IIO section.
> >
> > Changes in v6:
> > - Fix lock held in an error path error.
> >
> > Changes in v5:
> > - Remove unnecessary define.
> > - v4 was the wrong patch file
> >
> > Changes in v3:
> > - Use static channel array, simplify code because index is always 0.
> >
> > Changes in v2:
> > - Fix license, remove driver_module field.
> >
> >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
> >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
> >  3 files changed, 149 insertions(+)
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> > index 135f6825903f..aacc2ab9c34f 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> > +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> > @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
> >         Accelerometers, Gyroscope and Magnetometer that are
> >         presented by the ChromeOS EC Sensor hub.
> >         Creates an IIO device for each functions.
> > +
> > +config IIO_CROS_EC_SENSORS_LID_ANGLE
> > +     tristate "ChromeOS EC Sensor for lid angle"
> > +     depends on IIO_CROS_EC_SENSORS_CORE
> > +     help
> > +       Module to report the angle between lid and base for some
> > +       convertible devices.
> > +       This module is loaded when the EC can calculate the angle between the base
> > +       and the lid.
> > diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> > index ec716ff2a775..a35ee232ac07 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Makefile
> > +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> > @@ -4,3 +4,4 @@
> >
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> > +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > new file mode 100644
> > index 000000000000..876dfd176b0e
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -0,0 +1,139 @@
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
> > +     {
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +             .scan_type.realbits = CROS_EC_SENSOR_BITS,
> > +             .scan_type.storagebits = CROS_EC_SENSOR_BITS,
> > +             .scan_type.sign = 'u',
> > +             .type = IIO_ANGL
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(1)
> > +};
> > +
> > +/* State data for ec_sensors iio driver. */
> > +struct cros_ec_lid_angle_state {
> > +     /* Shared by all sensors */
> > +     struct cros_ec_sensors_core_state core;
> > +};
> > +
> > +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> > +                                       unsigned long scan_mask, s16 *data)
> > +{
> > +     struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> > +     ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> > +     if (ret) {
> > +             dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> > +             return ret;
> > +     }
> > +
> > +     *data = st->resp->lid_angle.value;
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 int *val, int *val2, long mask)
> > +{
> > +     struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> > +     s16 data;
> > +     int ret;
> > +
> > +     mutex_lock(&st->core.cmd_lock);
> > +     ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> > +     if (ret == 0) {
> > +             *val = data;
> > +             ret = IIO_VAL_INT;
> > +     }
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
> > +}
> > +
> > +static const struct iio_info cros_ec_lid_angle_info = {
> > +     .read_raw = &cros_ec_lid_angle_read,
> > +};
> > +
> > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct iio_dev *indio_dev;
> > +     struct cros_ec_lid_angle_state *state;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     indio_dev->info = &cros_ec_lid_angle_info;
> > +     state = iio_priv(indio_dev);
> > +     indio_dev->channels = cros_ec_lid_angle_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> > +
> > +     state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> > +
> > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                     cros_ec_sensors_capture, NULL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > +     {
> > +             .name = DRV_NAME,
> > +     },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> > +
> > +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> > +     .driver = {
> > +             .name   = DRV_NAME,
> > +             .pm     = &cros_ec_sensors_pm_ops,
> > +     },
> > +     .probe          = cros_ec_lid_angle_probe,
> > +     .id_table       = cros_ec_lid_angle_ids,
> > +};
> > +module_platform_driver(cros_ec_lid_angle_platform_driver);
> > +
> > +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> > +MODULE_LICENSE("GPL v2");
>
