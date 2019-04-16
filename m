Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB42BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E138206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlUPYrp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfDPH6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:58:45 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40827 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbfDPH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:58:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id p64so6982980ywg.7;
        Tue, 16 Apr 2019 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8K0KG6lkZjgZisSI5RrvC1dS+AwQyGjdL6WsbdaK2Dw=;
        b=MlUPYrp67TabPXwc/Us9fg8/J+8+51X5r7LceYjoUL+jYJUF4DW7J4Kg3ZMy5QcmKz
         19kSKJqXLtNZhUYh1UpdC9mna7Rck8QQM8Cnz4TlrKo/1Uhu47MvzYnpfgljKtj9WQiR
         bq78q5LqsJJsy86XqJY4YHwmZmwP+vX+V2AvACGHpeCS8k3vQaD5CcKi22P5StwinwtP
         WGZh4nrmMR5J4qocqu8vWR5FKy3p6ETHh5un2TVZpaVHH56DTl8deWzvBWDv+cVWrmBg
         ykSgNN5Q0aQsj8dHePwtSGOWpxr7AWtQ7SNQOH2hfJtN0Ab5jREtnZYpf6MqZPF3neeL
         eypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8K0KG6lkZjgZisSI5RrvC1dS+AwQyGjdL6WsbdaK2Dw=;
        b=c0nBAX6TxAFeIQ9/RCLfemeIiZEOBAzaHFseG6Mf3EJtQIxl65U1T1zTnyrqVp12VC
         uc56NXMKaw/eDC1RM73Ubp3cQeZujkha/NQKzUmtdsFpYJbINlHryub5bYFH/yRa4JNZ
         OA27VRORTdu6an4eEy5pyJMpSzRODHqFWh2iZ/0o+oZkXBA5EJwzgd34vC9GVAKEj5ZL
         DGN+mKfFq2jGJJS2ifKLLTG7nH4JZJG7ENJGSsVf+qryAzsK8p8T7Qf8NDi6ZvPdynCY
         F2ucVnE8VStWvet1QNsabknEkp+/+aoJwMxvTEaNnHmzjnwrwsL8rPx4p8PZ5Ug44BTB
         8qWg==
X-Gm-Message-State: APjAAAVffAsRdECXPAk72KPgu9CwJGtxVKtqfxxGfXsCoASE/R3i779i
        pryHueWv+KyzcytdaCQla3tEWGech6vU6tz8gNc=
X-Google-Smtp-Source: APXvYqw49YIhtjmT5PSR5pRYRZ0HFAfqbnL9NKh3dW0jk+wfMQLApGHMM+HrQsfEKwSc5jGNJjjw5PWcsw/dAhw5Jrw=
X-Received: by 2002:a81:5f88:: with SMTP id t130mr65268704ywb.453.1555401524353;
 Tue, 16 Apr 2019 00:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555354268.git.vitor.soares@synopsys.com>
 <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
 <20190416082539.2f12b38f@collabora.com>
In-Reply-To: <20190416082539.2f12b38f@collabora.com>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Tue, 16 Apr 2019 09:58:33 +0200
Message-ID: <CAA2SeNJ1cTxAp6+5Q4Z5L4VFBfA3U4e11_Obpk8muD1Vh3v52A@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>, bbrezillon@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Mon, 15 Apr 2019 21:19:41 +0200
> Vitor Soares <vitor.soares@synopsys.com> wrote:
>
> > For today the st_lsm6dsx driver support lsm6dso sensor only in
> > spi and i2c mode.
> >
> > The lsm6dso is also i3c capable so lets give i3c support to it.
> >
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
> >  3 files changed, 75 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > index 094fd00..1ab9bbf 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > @@ -1,11 +1,12 @@
> >
> >  config IIO_ST_LSM6DSX
> >       tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> > -     depends on (I2C || SPI)
> > +     depends on (I2C || SPI || I3C)
> >       select IIO_BUFFER
> >       select IIO_KFIFO_BUF
> >       select IIO_ST_LSM6DSX_I2C if (I2C)
> >       select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> > +     select IIO_ST_LSM6DSX_I3C if (I3C)
> >       help
> >         Say yes here to build support for STMicroelectronics LSM6DSx imu
> >         sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> > @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
> >       tristate
> >       depends on IIO_ST_LSM6DSX
> >       select REGMAP_SPI
> > +
> > +config IIO_ST_LSM6DSX_I3C
> > +     tristate
> > +     depends on IIO_ST_LSM6DSX
> > +     select REGMAP_I3C
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
> > index e5f733c..c676965 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> > +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> > @@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
> >  obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
> >  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
> >  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
> > +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > new file mode 100644
> > index 0000000..2df5e70
> > --- /dev/null
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > + *
> > + * Author: Vitor Soares <vitor.soares@synopsys.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/i3c/master.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "st_lsm6dsx.h"
> > +
> > +#define NAME_SIZE    32
> > +
> > +struct st_lsm6dsx_i3c_data {
> > +     char name[NAME_SIZE];
>
>         const char *name;
>
> > +     enum st_lsm6dsx_hw_id id;
> > +};
> > +
> > +static const struct st_lsm6dsx_i3c_data hw_data[] = {
>
> No need to make it an array, and it should probably be named
> st_lsm6dso_data not hw_data.

I guess it will be used even for future devices so I would prefer to
make it an array with a 'general' name

Regards,
Lorenzo

>
> > +     { ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> > +};
> > +
> > +static const struct regmap_config st_lsm6dsx_i3c_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +};
> > +
> > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > +{
> > +     const struct i3c_device_id *id = i3c_get_device_id(i3cdev);
>
>                                          i3c_device_match_id(i3cdev,
>                                                              st_lsm6dsx_i3c_ids);
>
> > +     const struct st_lsm6dsx_i3c_data *hw_data = id->data;
> > +     struct regmap *regmap;
> > +
> > +     regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> > +                     (int)PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_data->id,
> > +                             hw_data->name, regmap);
> > +}
> > +
> > +
> > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
> > +     I3C_DEVICE(0x0104, 0x006C, &hw_data[0]),
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> > +
> > +static struct i3c_driver st_lsm6dsx_driver = {
> > +     .driver.name = "st_lsm6dsx_i3c",
> > +     .probe = st_lsm6dsx_i3c_probe,
> > +     .id_table = st_lsm6dsx_i3c_ids,
>
> You should probably set the pm_ops here (st_lsm6dsx_pm_ops).
>
> > +};
> > +module_i3c_driver(st_lsm6dsx_driver);
> > +
> > +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> > +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> > +MODULE_LICENSE("GPL v2");
> > +
>
> You can remove this blank line.
>


-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
