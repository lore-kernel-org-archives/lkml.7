Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C7C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB8A21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X2LEmNBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfDEJfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:35:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37972 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDEJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:34:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so6415368wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/XEN4HjpNO9QIHIkRzJb1qhaaY1QJxkt53v7Xyozjo=;
        b=X2LEmNBAUS8qwtICqnhq44nmtbqUO/nggtW+Pl7vJWpgHKhAV3yhv4ieD93/06LmaS
         iHfEVD7XmbwxhHODYDgQK912IACVBaUvYcHILNBNTBEkMzM7718pzZwlu3qEb0TjlOKf
         8ep87y0adqzfUCWLMyC4/E9QgCixprNFBxdLcSItMOm3OGZYi/PFeWEOF2oLs2oPlBR8
         Q56DurfsCP7gQX/RqUrSlL7aKona3aoB9vNZOz6ow7dxu8J0D0yUb/7bQd0csjaTb4r6
         WUa40jDG+sjCHzyt8i5dLzJAeusYjGjPCxsLT7gOYKSBi3AvmFj1GevVG8KNrcXrBaSb
         fp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/XEN4HjpNO9QIHIkRzJb1qhaaY1QJxkt53v7Xyozjo=;
        b=B5LiuzRr826y9VLmV7UJsjOQoqO3ga/HlZIpej0gWRHwjkRFod0DMiLYiiI3m4uP5C
         vLygeZKrUBhpcHfpMYs36vVjhDLLfyKN8f711d7wVufnBdwnnPCSdg9F9IzDljvyVAFT
         bbo+6/XXRvzsYLNsemkhleTZ2mpjX0ZsAqEt9zZYhwH4ooz8NJzggs2PUfoiEa38AfVs
         zm0ClBB9YaTwTprwiJK7ozM67nqDsLbLmh7z7vfSJuMqoYvwnUmSBsr9j518QzycZvcx
         mTPg0++5LSpH8qrMqIzmNZwUCukQHRx1Pr5FPe8/ibdDGdGxTrPV5Fem5KHT2ntm8rb4
         kb8Q==
X-Gm-Message-State: APjAAAXO4O4hEMRF2D7PmFahst8cUWf7K9qByTm53/3dp+xPHVm3kv5e
        +zhFz8hBAcFzRcJcMWyZaKXENA==
X-Google-Smtp-Source: APXvYqzVt3dTLkz/cYzY3RIpLRG3t+jirfMZ9DvADFeZsrFgS+an2DepkjSi3UPGjSPIsjVrWnQoOg==
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr7455712wmd.61.1554456896876;
        Fri, 05 Apr 2019 02:34:56 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t15sm1954128wmt.2.2019.04.05.02.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 02:34:56 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 3/3] iio: Add PAT9125 optical tracker sensor
Date:   Fri,  5 Apr 2019 09:34:30 +0000
Message-Id: <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for PixArt Imaging’s miniature low power
optical navigation chip using LASER light source
enabling digital surface tracking.

This IIO driver allow to read delta position on 2 axis (X and Y).
The values can be taken through ponctual "read_raw" which will issue
a read in the device registers to return the deltas or subscribe
to the data buffer feed automaticaly by a new value using a
trigger gpio. The buffer payload is: |16 bits delta X|16 bits delta Y|timestamp|.
The possible I2C adresses are 0x73, 0x75 and 0x79.

Unfortunately, the device configuration must be hardcoded in the initialization
function and can't be changed "on-the-fly" in user space due to the lack of
configuration interface.

The "ot" directory is added to coutain Optical Tracker drivers.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iio/Kconfig      |   1 +
 drivers/iio/Makefile     |   1 +
 drivers/iio/ot/Kconfig   |  16 ++
 drivers/iio/ot/Makefile  |   6 +
 drivers/iio/ot/pat9125.c | 407 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 drivers/iio/ot/Kconfig
 create mode 100644 drivers/iio/ot/Makefile
 create mode 100644 drivers/iio/ot/pat9125.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb4..bdf1bd0 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -86,6 +86,7 @@ source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
+source "drivers/iio/ot/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb59932..fdda2e1 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -32,6 +32,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += ot/
 obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
diff --git a/drivers/iio/ot/Kconfig b/drivers/iio/ot/Kconfig
new file mode 100644
index 0000000..3d17fda
--- /dev/null
+++ b/drivers/iio/ot/Kconfig
@@ -0,0 +1,16 @@
+#
+# Optical tracker sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Optical tracker sensors"
+
+config PAT9125
+	tristate "Optical tracker PAT9125 I2C driver"
+	depends on I2C
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for PAT9125 optical tracker
+	  sensors.
+
+endmenu
diff --git a/drivers/iio/ot/Makefile b/drivers/iio/ot/Makefile
new file mode 100644
index 0000000..cf29491
--- /dev/null
+++ b/drivers/iio/ot/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Optical tracker sensor drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_PAT9125) += pat9125.o
diff --git a/drivers/iio/ot/pat9125.c b/drivers/iio/ot/pat9125.c
new file mode 100644
index 0000000..f416bfa
--- /dev/null
+++ b/drivers/iio/ot/pat9125.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ * Author: Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
+/* I2C Address function to ID pin*/
+#define PAT9125_I2C_ADDR_HI		0x73
+#define PAT9125_I2C_ADDR_LO		0x75
+#define PAT9125_I2C_ADDR_NC		0x79
+
+/* Registers */
+#define PAT9125_PRD_ID1_REG		0x00
+#define PAT9125_PRD_ID2_REG		0x01
+#define PAT9125_MOTION_STATUS_REG	0x02
+#define PAT9125_DELTA_X_LO_REG		0x03
+#define PAT9125_DELTA_Y_LO_REG		0x04
+#define PAT9125_OP_MODE_REG		0x05
+#define PAT9125_CONFIG_REG		0x06
+#define PAT9125_WRITE_PROTEC_REG	0x09
+#define PAT9125_SLEEP1_REG		0x0A
+#define PAT9125_SLEEP2_REG		0x0B
+#define PAT9125_RES_X_REG		0x0D
+#define PAT9125_RES_Y_REG		0x0E
+#define PAT9125_DELTA_XY_HI_REG		0x12
+#define PAT9125_SHUTER_REG		0x14
+#define PAT9125_FRAME_AVG_REG		0x17
+#define PAT9125_ORIENTATION_REG		0x19
+
+/* Masks */
+#define PAT9125_VALID_MOTION_DATA_MASK	0x80
+#define PAT9125_RESET_MASK		0x80
+
+/* Registers' values */
+#define PAT9125_SENSOR_ID_VAL			0x31
+#define PAT9125_DISABLE_WRITE_PROTECT_VAL	0x5A
+#define PAT9125_ENABLE_WRITE_PROTECT_VAL	0x00
+#define PAT9125_CPI_RESOLUTION_X_VAL		0x65
+#define PAT9125_CPI_RESOLUTION_Y_VAL		0xFF
+
+/* Default Value of sampled value size */
+#define PAT9125_SAMPLED_VAL_BIT_SIZE		12
+#define PAT9125_SAMPLED_VAL_BYTE_SIZE		2	/* 12 bits by default */
+#define PAT9125_TIMESTAMP_BYTE_SIZE		8	/* 64 bits */
+#define PAT9125_PAYLOAD_BYTE_SIZE \
+	(2 * PAT9125_SAMPLED_VAL_BYTE_SIZE + PAT9125_TIMESTAMP_BYTE_SIZE)
+#define PAT9125_REALBITS_XY_VAL \
+	(2 * PAT9125_SAMPLED_VAL_BIT_SIZE)
+#define PAT9125_STORAGEBITS_XY_VAL \
+	(2 * PAT9125_SAMPLED_VAL_BYTE_SIZE)
+
+struct pat9125_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	s16 delta_x;
+	s16 delta_y;
+};
+
+static const struct iio_event_spec pat9125_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE),
+};
+
+static const struct iio_chan_spec pat9125_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.address = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',			\
+			.realbits = 24,			\
+			.storagebits = 32,		\
+			.shift = 8,			\
+			.endianness = IIO_BE,		\
+		},
+		.event_spec = &pat9125_event,
+		.num_event_specs = 1,
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int pat9125_read_delta(struct pat9125_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	int status = 0;
+	int val_x = 0;
+	int val_y = 0;
+	int val_xy = 0;
+	int r;
+
+	r = regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
+	if (r < 0)
+		return r;
+
+	/* Check motion bit in bit7 */
+	if (status & PAT9125_VALID_MOTION_DATA_MASK) {
+		r = regmap_read(regmap, PAT9125_DELTA_X_LO_REG, &val_x);
+		if (r < 0)
+			return r;
+
+		r = regmap_read(regmap, PAT9125_DELTA_Y_LO_REG, &val_y);
+		if (r < 0)
+			return r;
+
+		r = regmap_read(regmap, PAT9125_DELTA_XY_HI_REG, &val_xy);
+		if (r < 0)
+			return r;
+
+		data->delta_x = val_x | ((val_xy << 4) & 0xF00);
+		data->delta_y = val_y | ((val_xy << 8) & 0xF00);
+
+		if (data->delta_x & 0x800)
+			data->delta_x |= 0xF000;
+
+		if (data->delta_y & 0x800)
+			data->delta_y |= 0xF000;
+	}
+
+	return 0;
+}
+
+/**
+ * pat9125_read_raw() - Sample and return the value(s)
+ * function to the associated channel info enum.
+ **/
+static int pat9125_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pat9125_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = pat9125_read_delta(data);
+		if (ret)
+			return ret;
+
+		*val = data->delta_x;
+		*val2 = data->delta_y;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * pat9125_read_event_value() - return last sampled value.
+ **/
+static int pat9125_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val,
+				    int *val2)
+{
+	struct pat9125_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		val[0] = data->delta_x;
+		val[1] = data->delta_y;
+		*val2 = 2;
+		return IIO_VAL_INT_MULTIPLE;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * pat9125_event_handler() - handling ring and non ring events
+ * @irq: The irq being handled.
+ * @private: struct iio_device pointer for the device.
+ *
+ */
+static irqreturn_t pat9125_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct pat9125_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	u8 *payload;
+	s64 last_timestamp = iio_get_time_ns(indio_dev);
+
+	payload = kmalloc(sizeof(s64) + 2 *
+		  PAT9125_SAMPLED_VAL_BYTE_SIZE, GFP_KERNEL);
+
+	ret = pat9125_read_delta(data);
+	if (ret)
+		return ret;
+	memcpy(&payload[0], &data->delta_x, 2);
+	memcpy(&payload[2], &data->delta_y, 2);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, payload, last_timestamp);
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_DISTANCE,
+					  0,
+					  IIO_MOD_X_AND_Y,
+					  IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_RISING),
+		       last_timestamp);
+
+	return IRQ_HANDLED;
+}
+
+static int pat9125_configure_ring(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	struct pat9125_data *data = iio_priv(indio_dev);
+
+	buffer = devm_iio_kfifo_allocate(&data->client->dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+
+	return 0;
+}
+
+static const struct regmap_config pat9125_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct iio_info pat9125_info = {
+	.read_raw = pat9125_read_raw,
+	.read_event_value = &pat9125_read_event_value,
+};
+
+static int pat9125_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct pat9125_data *data;
+	struct iio_dev *indio_dev;
+	int r, sensor_pid;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&client->dev, "IIO device allocation failed");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->channels = pat9125_channels;
+	indio_dev->num_channels = ARRAY_SIZE(pat9125_channels);
+	indio_dev->info = &pat9125_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	r = pat9125_configure_ring(indio_dev);
+	if (r < 0) {
+		dev_err(&client->dev, "FIFO buffer allocation failed");
+		return r;
+	}
+
+	data->regmap = devm_regmap_init_i2c(client, &pat9125_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev,
+			"regmap init failed %ld",
+			PTR_ERR(data->regmap));
+		return PTR_ERR(data->regmap);
+	}
+
+	/* Check device ID */
+	r = regmap_read(data->regmap, PAT9125_PRD_ID1_REG, &sensor_pid);
+	if (r < 0)
+		goto reg_access_fail;
+	if (sensor_pid != PAT9125_SENSOR_ID_VAL)
+		return -ENODEV;
+
+	/* Software reset (i.e. set bit7 to 1).
+	 * It will reset to 0 automatically
+	 */
+	r = regmap_write_bits(data->regmap,
+			      PAT9125_CONFIG_REG,
+			      PAT9125_RESET_MASK,
+			      1);
+	if (r < 0)
+		goto reg_access_fail;
+
+	/* Delay 20ms */
+	msleep(20);
+
+	/* Disable write protect */
+	r = regmap_write(data->regmap,
+			 PAT9125_WRITE_PROTEC_REG,
+			 PAT9125_DISABLE_WRITE_PROTECT_VAL);
+	if (r < 0)
+		goto reg_access_fail;
+
+	/* Set X-axis resolution (depends on application) */
+	r = regmap_write(data->regmap,
+			 PAT9125_RES_X_REG,
+			 0x0A);
+	if (r < 0)
+		goto reg_access_fail;
+
+	/* Set Y-axis resolution (depends on application) */
+	r = regmap_write(data->regmap,
+			 PAT9125_RES_Y_REG,
+			 0x0A);
+	if (r < 0)
+		goto reg_access_fail;
+
+	/* Enable write protection */
+	r = regmap_write(data->regmap,
+			 PAT9125_WRITE_PROTEC_REG,
+			 PAT9125_ENABLE_WRITE_PROTECT_VAL);
+	if (r < 0)
+		goto reg_access_fail;
+
+	r = devm_iio_device_register(&client->dev, indio_dev);
+	if (r) {
+		dev_err(&client->dev, "IIO device register failed");
+		return r;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		 dev_name(&indio_dev->dev),
+		 client->name);
+
+	/* Make read to reset motion bit status */
+	r = pat9125_read_delta(data);
+	if (r)
+		goto reg_access_fail;
+
+	/* Init GPIO IRQ */
+	if (client->irq) {
+		r = devm_request_threaded_irq(&client->dev,
+					      client->irq,
+					      NULL,
+					      pat9125_event_handler,
+					      IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					      "pat9125",
+					      indio_dev);
+		if (r)
+			return r;
+	}
+	return 0;
+
+reg_access_fail:
+	dev_err(&client->dev, "register access failed %d", r);
+	return r;
+}
+
+static int pat9125_remove(struct i2c_client *client)
+{
+	dev_info(&client->dev, "PAT9125 removed\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id pat9125_id[] = {
+	{ "pat9125", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pat9125_id);
+
+static const unsigned short normal_i2c[] = {
+	PAT9125_I2C_ADDR_HI,
+	PAT9125_I2C_ADDR_LO,
+	PAT9125_I2C_ADDR_NC,
+	I2C_CLIENT_END
+};
+
+static struct i2c_driver pat9125_driver = {
+	.driver = {
+		.name = "pat9125",
+	},
+	.probe = pat9125_probe,
+	.remove = pat9125_remove,
+	.address_list = normal_i2c,
+	.id_table = pat9125_id,
+};
+
+module_i2c_driver(pat9125_driver);
+
+MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
+MODULE_DESCRIPTION("Optical Tracking sensor");
+MODULE_LICENSE("GPL");
+
-- 
2.7.4

