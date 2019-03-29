Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FDB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hQ9OZ42n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfC2Ilp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:41:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33416 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfC2Ilp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:41:45 -0400
Received: by mail-io1-f65.google.com with SMTP id b6so1128406iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=33/iwvmusHwTcv8hJGDuna/lJR/QTV2FqkWq92RB02c=;
        b=hQ9OZ42nT/oB8RIkiB6hZG/T5pQii9xW0J7sXIgC8e2p2aXTQH0CH7JsvSuqJKlLTX
         vMENqfrQqYah7YIrgYlPd3J3QsxwPoytQNXmvvmW8b8Bff4UtgUGlLRcbi+hxGHXcgpg
         VJhvh59agRfoS7FXF8hv31EofivR+FMjPHBY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=33/iwvmusHwTcv8hJGDuna/lJR/QTV2FqkWq92RB02c=;
        b=okz2Vmpw9+oNdgILJUWl8BEbluiWuoRko4qwqV80dclqNyWznztrsJu8ZxOJc3aGHo
         GSQCU7iHJQRXY+h1m90e63g5Jg/VuIYM9uY8dKB20X42n9ayK3eLxCfiik/IjJjmZHmk
         q4HovhCuT6HbJkL9CvnHfTHm3F9YlG10KDLRr4NOFVHymr8nyPCbh/t3L5bRZPynfcH3
         Ufe7Kkho02YBuJ8zSDlF+VmVF+olY1AXPFrf716UByyIlJfAwYI6w+OcxIfa1TQTLKhN
         RR4A8JzRW+OFWD73vO7bvmlA3W+XccTpC3wWsYL/QtKN/jqeHahb4XM4qwoomjp9tw2i
         d0VQ==
X-Gm-Message-State: APjAAAVnWEUKGRAWTm1rx7BWIdc8JrTOtDhUJlN3X86I0RAlo9CnGOox
        nAyYfI9LOErKkj++QPLzprr67KCzv2WquL3pokHPiA==
X-Google-Smtp-Source: APXvYqzLHzpGnkrt/QSM06yw01zzT8MeDgw2MiP78wV3G/9f83HYGx/gy66sLSskgQLQE7iP/zJ4EjLdSlmxXKuOXnM=
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr24234376iot.192.1553848903962;
 Fri, 29 Mar 2019 01:41:43 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Mar 2019 01:41:43 -0700
From:   Gwendal Grignou <gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190311082405.GB4731@dell>
References: <20190311082405.GB4731@dell>
MIME-Version: 1.0
Date:   Fri, 29 Mar 2019 01:41:43 -0700
Message-ID: <CAPUE2usOdzbHN7NN=Vg8FWE1kR2ayPYxV8qy05eB+bZgG6wD3w@mail.gmail.com>
Subject: [PATCH v4 2/2] iio: cros_ec: Add lid angle driver
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a IIO driver that reports the angle between the lid and the base for
ChromeOS convertible device.

Tested on eve with ToT EC firmware.
Check driver is loaded and lid angle is correct.

Change-Id: I3506be4a1405f108eebe6c1d3a3dbe975ca00519
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 138 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |  15 +-
 4 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig
b/drivers/iio/common/cros_ec_sensors/Kconfig
index 135f6825903f..aacc2ab9c34f 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
 	  Accelerometers, Gyroscope and Magnetometer that are
 	  presented by the ChromeOS EC Sensor hub.
 	  Creates an IIO device for each functions.
+
+config IIO_CROS_EC_SENSORS_LID_ANGLE
+	tristate "ChromeOS EC Sensor for lid angle"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to report the angle between lid and base for some
+	  convertible devices.
+	  This module is loaded when the EC can calculate the angle between the base
+	  and the lid.
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile
b/drivers/iio/common/cros_ec_sensors/Makefile
index ec716ff2a775..a35ee232ac07 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -4,3 +4,4 @@

 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
new file mode 100644
index 000000000000..92be07d7fa36
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
+ *
+ * Copyright 2018 Google, Inc
+ *
+ * This driver uses the cros-ec interface to communicate with the Chrome OS
+ * EC about counter sensors. Counters are presented through
+ * iio sysfs.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME "cros-ec-lid-angle"
+
+/*
+ * One channel for the lid angle, the other for timestamp.
+ */
+static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
+	{
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type.realbits = CROS_EC_SENSOR_BITS,
+		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
+		.scan_type.sign = 'u',
+		.type = IIO_ANGL
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1)
+};
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_lid_angle_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+};
+
+static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
+					  unsigned long scan_mask, s16 *data)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
+	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
+	if (ret) {
+		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
+		return ret;
+	}
+
+	*data = st->resp->lid_angle.value;
+	return 0;
+}
+
+static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
+	s16 data;
+	int ret;
+
+	mutex_lock(&st->core.cmd_lock);
+	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
+	if (ret)
+		return ret;
+	*val = data;
+	mutex_unlock(&st->core.cmd_lock);
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info cros_ec_lid_angle_info = {
+	.read_raw = &cros_ec_lid_angle_read,
+};
+
+static int cros_ec_lid_angle_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct cros_ec_lid_angle_state *state;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_lid_angle_info;
+	state = iio_priv(indio_dev);
+	indio_dev->channels = cros_ec_lid_angle_channels;
+	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
+
+	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_lid_angle_ids[] = {
+	{
+		.name = DRV_NAME,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
+
+static struct platform_driver cros_ec_lid_angle_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.pm	= &cros_ec_sensors_pm_ops,
+	},
+	.probe		= cros_ec_lid_angle_probe,
+	.id_table	= cros_ec_lid_angle_ids,
+};
+module_platform_driver(cros_ec_lid_angle_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb12..11b5b2fd1f33 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -297,13 +297,17 @@ static void cros_ec_sensors_register(struct
cros_ec_dev *ec)

 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 1 extra sensors in FIFO are needed */
-	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
+	/*
+	 * Allocate extra sensors if lid angle sensor or FIFO are needed.
+	 */
+#define NUM_EXTRA_SENSORS 2
+	sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,
+			       sizeof(struct mfd_cell),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
 		goto error;

-	sensor_platforms = kcalloc(sensor_num + 1,
+	sensor_platforms = kcalloc(sensor_num,
 				   sizeof(struct cros_ec_sensor_platform),
 				   GFP_KERNEL);
 	if (sensor_platforms == NULL)
@@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct
cros_ec_dev *ec)
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
 	}
+	if (cros_ec_check_features(ec,
+				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		sensor_cells[id].name = "cros-ec-lid-angle";
+		id++;
+	}

 	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
 			      NULL, 0, NULL);
-- 
2.21.0.360.g471c308f928-goog
