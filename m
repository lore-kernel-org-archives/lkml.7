Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B920C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB83D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IfUfiSxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfDOTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:20:35 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:57388 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfDOTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:20:32 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D7EFD10C128D;
        Mon, 15 Apr 2019 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555356031; bh=8qBx60iIv6iNiOzwKuaHb7f4i/8Ls8vAfFBAU+CsOTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IfUfiSxYIUmtyXozKHRJx3kyCxpdzJKNxkn1p2Vj7YZIX0sWsDMC5ev44J3L6XkoS
         fEIpQasNzMaraP3tmXPAfEUaZ5+875uklAnsU6pjUw4O+Gs0ER+qwz1+Vb105FLWBm
         NEYO1eE/IDkXEFlrNy1a4syfhtbT9ZvTFEMVON86HA7YNZ4bGY/2fLgyd+rBjQrL3a
         qeao9DaLyXo5mpOCtOMJkdWUYfP+IfhwaCtphkKiVHPjStTdYjO5wAlgj3dP1ptXpi
         Vxeid36W/B9Clkc31SUnAOPTCFk6HyYTalFrmRQFHy7o5rmXaioax1eL37qGFndg8Y
         1+LQ27VggQLug==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 17C115536;
        Mon, 15 Apr 2019 12:19:58 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
Date:   Mon, 15 Apr 2019 21:19:41 +0200
Message-Id: <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For today the st_lsm6dsx driver support lsm6dso sensor only in
spi and i2c mode.

The lsm6dso is also i3c capable so lets give i3c support to it.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 094fd00..1ab9bbf 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -1,11 +1,12 @@
 
 config IIO_ST_LSM6DSX
 	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
-	depends on (I2C || SPI)
+	depends on (I2C || SPI || I3C)
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select IIO_ST_LSM6DSX_I2C if (I2C)
 	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
+	select IIO_ST_LSM6DSX_I3C if (I3C)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
@@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
 	tristate
 	depends on IIO_ST_LSM6DSX
 	select REGMAP_SPI
+
+config IIO_ST_LSM6DSX_I3C
+	tristate
+	depends on IIO_ST_LSM6DSX
+	select REGMAP_I3C
diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
index e5f733c..c676965 100644
--- a/drivers/iio/imu/st_lsm6dsx/Makefile
+++ b/drivers/iio/imu/st_lsm6dsx/Makefile
@@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
 obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
+obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
new file mode 100644
index 0000000..2df5e70
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "st_lsm6dsx.h"
+
+#define NAME_SIZE	32
+
+struct st_lsm6dsx_i3c_data {
+	char name[NAME_SIZE];
+	enum st_lsm6dsx_hw_id id;
+};
+
+static const struct st_lsm6dsx_i3c_data hw_data[] = {
+	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
+};
+
+static const struct regmap_config st_lsm6dsx_i3c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
+{
+	const struct i3c_device_id *id = i3c_get_device_id(i3cdev);
+	const struct st_lsm6dsx_i3c_data *hw_data = id->data;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_data->id,
+				hw_data->name, regmap);
+}
+
+
+static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
+	I3C_DEVICE(0x0104, 0x006C, &hw_data[0]),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
+
+static struct i3c_driver st_lsm6dsx_driver = {
+	.driver.name = "st_lsm6dsx_i3c",
+	.probe = st_lsm6dsx_i3c_probe,
+	.id_table = st_lsm6dsx_i3c_ids,
+};
+module_i3c_driver(st_lsm6dsx_driver);
+
+MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
+MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.7.4

