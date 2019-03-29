Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7412C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569FF20657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dO8sO8qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfC2URs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:17:48 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34072 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbfC2URs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:17:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id x129so1141626ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWPqL8uetVZR7k+ms2TfuXqlJ8oTUCmNOxynZEMvMwM=;
        b=dO8sO8qbuszBiLxLjWvJSO6iyWMeDnTxtE6le/A2fY3JivJ4lcv/dqKRzVS8/zFUJG
         xzvI08H5ES0g4/49KSldIv8x07boo+W8IgFMaQAS1Ux1Gr2RDbt5/c5h3Oj1A+MQduCG
         A92asOHiF9+dsd7AruaYqvxzbUowxj12KgrQt8qqWsBzBWrisJFNpKYJ7MKvWKcXXHrt
         t39BrCBaOPr1rku3uRAFK0KIjpyW+u/3bfAwKjnqqsqHyBaLGs7UhhIbahUIvItfrHdZ
         4OgEwuVQvn/sv6oF31QY+9vHft+Y10kWAwi2Y8jKVcUgYmCisUuxqsvhM0Z8GhDkNNbq
         rUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWPqL8uetVZR7k+ms2TfuXqlJ8oTUCmNOxynZEMvMwM=;
        b=NnVAkWxeQy2Imn9GOfHWk2+5QMMRoYn12FRMGKqobNG2NOvEBzNZKbeW1K4eaF/3mC
         UZS3VzRq51ZSpJQomqNug6DuCHCMrJDoi8LNNucSVbL51szBIEMZnKkqPLrnWnVWXkZg
         zJiCM42ZxxhVJB7ftNDtU99JwVZ72AZku3szsJqKYBc3YSL1T2VYtUxHQXPSOaun5C0N
         Uj30lFC20Hfs6eby6kAWbSFsXxKDfWWVA98CpH1FuY9jfVzbFK3nbx8hwyId6rR+PF+K
         pPliUcZ2FAmdE71TjmnO6AIFBH/GQimHf71y1y7z6A0FzjAi8XbsTJjYT5SzA23r2Pt6
         K4GA==
X-Gm-Message-State: APjAAAV7vStB8kPjc/9i/QFTr0FYwxOuN5S5iMTUima75h9FQ+VhA17o
        Z0Ln75/DBp4Z3oUGRiQxrwMaHmT8pxQYv5hjsW7jLA==
X-Google-Smtp-Source: APXvYqwzhdoPgYwIC4tV9o2V8UR+zQvH9vYcPFgVOfpEytkHs6onvk7lBZmYTI1EoDjhkAff3WCXXnsxQ7/zLiyqGRQ=
X-Received: by 2002:a0d:e2d4:: with SMTP id l203mr40129748ywe.444.1553890666810;
 Fri, 29 Mar 2019 13:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2uskDvefZbt5Ydz8Eu3+Aavu+AzPY5WuAYj0ziYP373oRA@mail.gmail.com>
 <CAPUE2uu5SyVevcWbxc7B6Tf1jTOCmYBgfWsgZJBDLC4xf=rQ_A@mail.gmail.com>
In-Reply-To: <CAPUE2uu5SyVevcWbxc7B6Tf1jTOCmYBgfWsgZJBDLC4xf=rQ_A@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 Mar 2019 13:17:35 -0700
Message-ID: <CABXOdTfZNKEEC6a5-L9-cajvavXSk9jSMPU1-YdSYDgFYSjyiw@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros_ec: Add lid angle driver
To:     Gwendal Grignou <gwendal@chromium.org>
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

On Fri, Mar 29, 2019 at 1:08 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Add a IIO driver that reports the angle between the lid and the base for
> ChromeOS convertible device.
>
> Tested on eve with ToT EC firmware.
> Check driver is loaded and lid angle is correct.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
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
>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 138 ++++++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     |  13 +-
>  4 files changed, 158 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
>
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig
> b/drivers/iio/common/cros_ec_sensors/Kconfig
> index 135f6825903f..aacc2ab9c34f 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
>           Accelerometers, Gyroscope and Magnetometer that are
>           presented by the ChromeOS EC Sensor hub.
>           Creates an IIO device for each functions.
> +
> +config IIO_CROS_EC_SENSORS_LID_ANGLE
> +       tristate "ChromeOS EC Sensor for lid angle"
> +       depends on IIO_CROS_EC_SENSORS_CORE
> +       help
> +         Module to report the angle between lid and base for some
> +         convertible devices.
> +         This module is loaded when the EC can calculate the angle between the base
> +         and the lid.
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile
> b/drivers/iio/common/cros_ec_sensors/Makefile
> index ec716ff2a775..a35ee232ac07 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -4,3 +4,4 @@
>
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> new file mode 100644
> index 000000000000..92be07d7fa36
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -0,0 +1,138 @@
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
> +       {
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .scan_type.realbits = CROS_EC_SENSOR_BITS,
> +               .scan_type.storagebits = CROS_EC_SENSOR_BITS,
> +               .scan_type.sign = 'u',
> +               .type = IIO_ANGL
> +       },
> +       IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_lid_angle_state {
> +       /* Shared by all sensors */
> +       struct cros_ec_sensors_core_state core;
> +};
> +
> +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> +                                         unsigned long scan_mask, s16 *data)
> +{
> +       struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +       int ret;
> +
> +       st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> +       ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> +       if (ret) {
> +               dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> +               return ret;
> +       }
> +
> +       *data = st->resp->lid_angle.value;
> +       return 0;
> +}
> +
> +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> +                                   struct iio_chan_spec const *chan,
> +                                   int *val, int *val2, long mask)
> +{
> +       struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> +       s16 data;
> +       int ret;
> +
> +       mutex_lock(&st->core.cmd_lock);
> +       ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> +       if (ret)
> +               return ret;
> +       *val = data;
> +       mutex_unlock(&st->core.cmd_lock);
> +       return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info cros_ec_lid_angle_info = {
> +       .read_raw = &cros_ec_lid_angle_read,
> +};
> +
> +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct iio_dev *indio_dev;
> +       struct cros_ec_lid_angle_state *state;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->info = &cros_ec_lid_angle_info;
> +       state = iio_priv(indio_dev);
> +       indio_dev->channels = cros_ec_lid_angle_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> +
> +       state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> +
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +                       cros_ec_sensors_capture, NULL);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> +       {
> +               .name = DRV_NAME,
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> +
> +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> +       .driver = {
> +               .name   = DRV_NAME,
> +               .pm     = &cros_ec_sensors_pm_ops,
> +       },
> +       .probe          = cros_ec_lid_angle_probe,
> +       .id_table       = cros_ec_lid_angle_ids,
> +};
> +module_platform_driver(cros_ec_lid_angle_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d275deaecb12..52ea2f1c87a1 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct
> cros_ec_dev *ec)
>
>         resp = (struct ec_response_motion_sense *)msg->data;
>         sensor_num = resp->dump.sensor_count;
> -       /* Allocate 1 extra sensors in FIFO are needed */
> -       sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> +       /*
> +        * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> +        */
> +       sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
>                                GFP_KERNEL);
>         if (sensor_cells == NULL)
>                 goto error;
>
> -       sensor_platforms = kcalloc(sensor_num + 1,
> +       sensor_platforms = kcalloc(sensor_num,

I still don't understand why the "+ 1" is no longer needed. It seems
to me that it would have to change to "+ 2".

Guenter

>                                    sizeof(struct cros_ec_sensor_platform),
>                                    GFP_KERNEL);
>         if (sensor_platforms == NULL)
> @@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct
> cros_ec_dev *ec)
>                 sensor_cells[id].name = "cros-ec-ring";
>                 id++;
>         }
> +       if (cros_ec_check_features(ec,
> +                               EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> +               sensor_cells[id].name = "cros-ec-lid-angle";
> +               id++;
> +       }
>
>         ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
>                               NULL, 0, NULL);
> --
> 2.21.0.360.g471c308f928-goog
