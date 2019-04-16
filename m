Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC714218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfDPGZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:25:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48270 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:25:45 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0B048260C42;
        Tue, 16 Apr 2019 07:25:43 +0100 (BST)
Date:   Tue, 16 Apr 2019 08:25:39 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
Message-ID: <20190416082539.2f12b38f@collabora.com>
In-Reply-To: <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
        <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 21:19:41 +0200
Vitor Soares <vitor.soares@synopsys.com> wrote:

> For today the st_lsm6dsx driver support lsm6dso sensor only in
> spi and i2c mode.
> 
> The lsm6dso is also i3c capable so lets give i3c support to it.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
>  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 094fd00..1ab9bbf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -1,11 +1,12 @@
>  
>  config IIO_ST_LSM6DSX
>  	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> -	depends on (I2C || SPI)
> +	depends on (I2C || SPI || I3C)
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	select IIO_ST_LSM6DSX_I2C if (I2C)
>  	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> +	select IIO_ST_LSM6DSX_I3C if (I3C)
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
>  	tristate
>  	depends on IIO_ST_LSM6DSX
>  	select REGMAP_SPI
> +
> +config IIO_ST_LSM6DSX_I3C
> +	tristate
> +	depends on IIO_ST_LSM6DSX
> +	select REGMAP_I3C
> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
> index e5f733c..c676965 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> @@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
>  obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
> +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> new file mode 100644
> index 0000000..2df5e70
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> + *
> + * Author: Vitor Soares <vitor.soares@synopsys.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "st_lsm6dsx.h"
> +
> +#define NAME_SIZE	32
> +
> +struct st_lsm6dsx_i3c_data {
> +	char name[NAME_SIZE];

	const char *name;

> +	enum st_lsm6dsx_hw_id id;
> +};
> +
> +static const struct st_lsm6dsx_i3c_data hw_data[] = {

No need to make it an array, and it should probably be named
st_lsm6dso_data not hw_data.

> +	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> +};
> +
> +static const struct regmap_config st_lsm6dsx_i3c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct i3c_device_id *id = i3c_get_device_id(i3cdev);

					 i3c_device_match_id(i3cdev,
					 		     st_lsm6dsx_i3c_ids);

> +	const struct st_lsm6dsx_i3c_data *hw_data = id->data;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_data->id,
> +				hw_data->name, regmap);
> +}
> +
> +
> +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
> +	I3C_DEVICE(0x0104, 0x006C, &hw_data[0]),
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> +
> +static struct i3c_driver st_lsm6dsx_driver = {
> +	.driver.name = "st_lsm6dsx_i3c",
> +	.probe = st_lsm6dsx_i3c_probe,
> +	.id_table = st_lsm6dsx_i3c_ids,

You should probably set the pm_ops here (st_lsm6dsx_pm_ops).

> +};
> +module_i3c_driver(st_lsm6dsx_driver);
> +
> +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> +MODULE_LICENSE("GPL v2");
> +

You can remove this blank line.

