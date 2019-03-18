Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9385C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812882133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="AB5z4ki5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCRUjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:39:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:25813 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfCRUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552941575;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=c4tuE4gteQoT1p3n8nW5XW4/vRQj2bFZ1ppqRtio/NY=;
        b=AB5z4ki5T3GoIZ3j4c18CHDHv8AEdY0uV+aKq979rM2uYyR8lJFScqhf1daEg9eo4I
        J7VZ4LkdXhSPXP1OcrPSuAG9UAqHE7EwiqMbnpjU5ByjvphYkk6ksy5gMuN50z+FCLvX
        M0sPIPeiFL3j6EUcHHi5CH1u5FdftZiaLQ4z2oZmSCp8t434rkfwr27gYUbMyyH9j0H6
        tFfmfCNdU+YuDHo1iZQMymvcWTyEj/NwLhGN6wrqelXnb+/XwQSuPF0Cp5HfJRs9WtZh
        gGqT1XFZdgnak2+P0sZhGTEEhJi93rzpzYXs5cl/k6njm/LgXPSWYfV9nbUGW1XpMes0
        h2Yg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IKdYFyj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 21:39:34 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 1/4] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input
Date:   Mon, 18 Mar 2019 21:39:31 +0100
Message-Id: <88389d5de8925a0c6ee31bbe8d1ce0ea4b6a6035.1552941573.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552941573.git.hns@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some user spaces (e.g. some Android devices) use /dev/input/event* for handling
the 3D position of the device with respect to the center of gravity (earth).
This can be used for gaming input, auto-rotation of screens etc.

This interface should be the standard because it is an abstraction of how
orientation data is acquired from sensor chips. Sensor chips may be connected
through different interfaces and in different positions. They may also have different
parameters. And, if a chip is replaced by a different one, the values reported
by the device position interface should remain the same, provided the device
tree reflects the changed chip.

But nowadays, new accelerometer chips mostly get iio drivers and rarely input drivers.
Therefore we need something like a protocol stack: input device vs. raw data.
It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or keyboard
input events vs. raw gpio or raw USB access.

This patch bridges the gap between raw iio data and the input device abstraction
so that accelerometer measurements can also be presented as X/Y/Z accelerometer
channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.

There are no special requirements or changes needed for an iio driver.

This driver simply collects the first 3 accelerometer channels as X, Y and Z.
If only 1 or 2 channels are available, they are used for X and Y only. Additional
channels are ignored.

Scaling is done automatically so that 1g is represented by value 256 and
range is assumed to be -511 .. +511.

If a mount-matrix is provided by the iio driver, it is also taken into account
so that the input event automatically gets the correct orientation with respect
to the device.

If this extension is not configured into the kernel it takes no resources (except
source code).

If it is configured, but there is no accelerometer, there is only a tiny penalty
for scanning for accelerometer channels once during probe of each iio device.

If it runs, the driver polls the device(s) once every 100 ms. A mode where the
iio device defines the update rate is not implemented and for further study.

The driver is capable of supporting up to 5 iio accelerometers and they are
presented by unique /dev/input/event* files. The iio chip name is used to define
the input device name so that it can be identified (e.g. by udev rules or evtest).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/industrialio-inputbridge.c | 420 +++++++++++++++++++++++++
 drivers/iio/industrialio-inputbridge.h |  28 ++
 2 files changed, 448 insertions(+)
 create mode 100644 drivers/iio/industrialio-inputbridge.c
 create mode 100644 drivers/iio/industrialio-inputbridge.h

diff --git a/drivers/iio/industrialio-inputbridge.c b/drivers/iio/industrialio-inputbridge.c
new file mode 100644
index 000000000000..0288ba2ef69f
--- /dev/null
+++ b/drivers/iio/industrialio-inputbridge.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Industrial I/O core, bridge to input devices
+ *
+ * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "industrialio-inputbridge.h"
+
+/* currently, only polling is implemented */
+#define POLLING_MSEC	100
+
+/* handle up to this number of input devices */
+#define MAX_INPUT_DEVICES	5
+
+#define FIXED_POINT_UNIT	1000
+
+static struct iio_input_map {
+	struct iio_dev *indio_dev;	/* the iio device */
+	struct input_dev *input;	/* the input device */
+	struct iio_channel channels[3];	/* x, y, z channels */
+	int values[3];		/* values while processing */
+	struct matrix {
+		int mxx, myx, mzx;	/* translated and scaled mount-matrix */
+		int mxy, myy, mzy;
+		int mxz, myz, mzz;
+	} matrix;
+} devices[MAX_INPUT_DEVICES];
+
+static inline struct iio_input_map *to_iio_input_map(
+		struct iio_channel *channel)
+{
+	return (struct iio_input_map *) channel->data;
+}
+
+/* we must protect against races in channel allocation */
+
+static DEFINE_MUTEX(inputbridge_device_mutex);
+
+static struct delayed_work input_work;
+
+/* we can start/stop the worker by open("/dev/input/event") */
+static int open_count;
+
+/* we must protect the open counter */
+static DEFINE_MUTEX(inputbridge_open_mutex);
+
+/* minimum and maximum range we want to report */
+#define ABSMAX_ACC_VAL		(512 - 1)
+#define ABSMIN_ACC_VAL		-(ABSMAX_ACC_VAL)
+
+/* scale processed iio values so that 1g maps to ABSMAX_ACC_VAL / 2 */
+#define SCALE			((100 * ABSMAX_ACC_VAL) / (2 * 981))
+
+/*
+ * convert float string to scaled fixed point format, e.g.
+ *   1.23	-> 1230
+ *   0.1234	->  123
+ *   .01234	->   12
+ */
+
+static int32_t atofix(const char *str)
+{
+	int32_t mant = 0;
+	bool sign = false;
+	bool decimal = false;
+	int32_t divisor = 1;
+
+	if (*str == '-')
+		sign = true, str++;
+	while (*str && divisor < FIXED_POINT_UNIT) {
+		if (*str >= '0' && *str <= '9') {
+			mant = 10 * mant + (*str - '0');
+			if (decimal)
+				divisor *= 10;
+		} else if (*str == '.')
+			decimal = true;
+		else
+			return 0;	/* error */
+		str++;
+	}
+
+	mant = (FIXED_POINT_UNIT * mant) / divisor;
+	if (sign)
+		mant = -mant;
+
+	return mant;
+}
+
+static void iio_apply_matrix(struct matrix *m, int *in, int *out)
+{
+	/* apply mount matrix */
+	out[0] = (m->mxx * in[0] + m->myx * in[1] + m->mzx * in[2])
+			/ FIXED_POINT_UNIT;
+	out[1] = (m->mxy * in[0] + m->myy * in[1] + m->mzy * in[2])
+			/ FIXED_POINT_UNIT;
+	out[2] = (m->mxz * in[0] + m->myz * in[1] + m->mzz * in[2])
+			/ FIXED_POINT_UNIT;
+}
+
+static void iio_accel_report_channels(void)
+{
+	int dindex;
+
+	for (dindex = 0; dindex < ARRAY_SIZE(devices); dindex++) {
+		struct iio_input_map *map = &devices[dindex];
+
+		/* device might become closed while we are still processing */
+		mutex_lock(&inputbridge_device_mutex);
+
+		if (map->input) {
+			int aligned_values[3];
+			int cindex = 0;
+
+			while (cindex < ARRAY_SIZE(map->channels)) {
+				struct iio_channel *channel =
+					&map->channels[cindex];
+				int val;
+				int ret;
+
+				if (!channel->indio_dev)
+					continue;
+
+				ret = iio_read_channel_raw(channel, &val);
+
+				if (ret < 0) {
+					pr_err("%s(): channel read error %d\n",
+						__func__, cindex);
+					return;
+				}
+
+				ret = iio_convert_raw_to_processed(channel, val,
+						 &map->values[cindex], SCALE);
+
+				if (ret < 0) {
+					pr_err("%s(): channel processing error\n",
+						__func__);
+					return;
+				}
+
+				cindex++;
+			}
+
+			iio_apply_matrix(&map->matrix, map->values,
+					 aligned_values);
+
+			input_report_abs(map->input, ABS_X, aligned_values[0]);
+			input_report_abs(map->input, ABS_Y, aligned_values[1]);
+			input_report_abs(map->input, ABS_Z, aligned_values[2]);
+			input_sync(map->input);
+		}
+
+		mutex_unlock(&inputbridge_device_mutex);
+	}
+}
+
+static void iio_inputbridge_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+
+	delayed_work = to_delayed_work(work);
+
+	mutex_lock(&inputbridge_open_mutex);
+
+	iio_accel_report_channels();
+
+	schedule_delayed_work(delayed_work,
+		msecs_to_jiffies(POLLING_MSEC));
+
+	mutex_unlock(&inputbridge_open_mutex);
+}
+
+static int iio_accel_open(struct input_dev *input)
+{
+	struct iio_dev *iiodev = input_get_drvdata(input);
+
+	mutex_lock(&inputbridge_open_mutex);
+
+	/* start on first open */
+	if (open_count++ == 0)
+		schedule_delayed_work(&input_work,
+			msecs_to_jiffies(0));
+
+	mutex_unlock(&inputbridge_open_mutex);
+
+	return 0;
+}
+
+static void iio_accel_close(struct input_dev *input)
+{
+	struct iio_dev *iiodev = input_get_drvdata(input);
+
+	mutex_lock(&inputbridge_open_mutex);
+
+	/* stop after last close */
+	if (--open_count == 0)
+		cancel_delayed_work(&input_work);
+
+	mutex_unlock(&inputbridge_open_mutex);
+}
+
+static int iio_input_register_accel_channel(struct iio_dev *indio_dev,
+		 const struct iio_chan_spec *chan)
+{ /* we found some accelerometer channel */
+	int ret;
+
+	int dindex, cindex;
+	struct iio_input_map *map;
+
+	mutex_lock(&inputbridge_device_mutex);
+
+	/* look for existing input device for this iio device */
+
+	for (dindex = 0; dindex < ARRAY_SIZE(devices); dindex++) {
+		if (devices[dindex].indio_dev == indio_dev)
+			break;
+	}
+
+	if (dindex == ARRAY_SIZE(devices)) {
+		struct input_dev *input;
+		const struct iio_chan_spec_ext_info *ext_info;
+
+		/* not found, look for a free slot for a new input device */
+
+		for (dindex = 0; dindex < ARRAY_SIZE(devices); dindex++) {
+			if (!devices[dindex].input)
+				break;
+		}
+
+		if (dindex == ARRAY_SIZE(devices)) {
+			mutex_unlock(&inputbridge_device_mutex);
+			return -ENOMEM;
+		}
+
+		input = input_allocate_device();
+
+		if (!input) {
+			mutex_unlock(&inputbridge_device_mutex);
+			return -ENOMEM;
+		}
+
+		input->name = kasprintf(GFP_KERNEL, "iio-bridge: %s",
+						    indio_dev->name);
+		input->phys = kasprintf(GFP_KERNEL, "accel/input%d",
+						    dindex);
+
+//		input->id.bustype = BUS_I2C;
+//		input->dev.parent = &indio_dev->client->dev;
+
+		set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
+
+		input->evbit[0] = BIT_MASK(EV_ABS);
+		input->open = iio_accel_open;
+		input->close = iio_accel_close;
+
+// FIXME: what happens if we unregister the first device?
+// and then register another one?
+
+		if (dindex == 0) // first input
+			INIT_DELAYED_WORK(&input_work, iio_inputbridge_work);
+
+		input_set_drvdata(input, indio_dev);
+
+		input_alloc_absinfo(input);
+		ret = input_register_device(input);
+
+		if (ret < 0) {
+			kfree(input->name);
+			kfree(input->phys);
+			input_free_device(input);
+			mutex_unlock(&inputbridge_device_mutex);
+			return ret;
+		}
+
+		map = &devices[dindex];
+
+		map->input = input;
+		map->indio_dev = indio_dev;
+
+		/* assume all channels of a device share the same matrix */
+
+		ext_info = chan->ext_info;
+		for (; ext_info && ext_info->name; ext_info++) {
+			if (strcmp(ext_info->name, "mount_matrix") == 0)
+				break;
+		}
+
+		if (ext_info && ext_info->name) {
+			/* matrix found */
+			uintptr_t priv = ext_info->private;
+			const struct iio_mount_matrix *mtx;
+
+			mtx = ((iio_get_mount_matrix_t *) priv)(indio_dev,
+								chan);
+
+			map->matrix.mxx = atofix(mtx->rotation[0]);
+			map->matrix.myx = atofix(mtx->rotation[1]);
+			map->matrix.mzx = atofix(mtx->rotation[2]);
+			map->matrix.mxy = atofix(mtx->rotation[3]);
+			map->matrix.myy = atofix(mtx->rotation[4]);
+			map->matrix.mzy = atofix(mtx->rotation[5]);
+			map->matrix.mxz = atofix(mtx->rotation[6]);
+			map->matrix.myz = atofix(mtx->rotation[7]);
+			map->matrix.mzz = atofix(mtx->rotation[8]);
+		} else {
+			map->matrix.mxx = FIXED_POINT_UNIT;
+			map->matrix.myx = 0;
+			map->matrix.mzx = 0;
+			map->matrix.mxy = 0;
+			map->matrix.myy = FIXED_POINT_UNIT;
+			map->matrix.mzy = 0;
+			map->matrix.mxz = 0;
+			map->matrix.myz = 0;
+			map->matrix.mzz = FIXED_POINT_UNIT;
+		}
+	}
+
+	/* find free channel within this device block */
+	map = &devices[dindex];
+
+	for (cindex = 0; cindex < ARRAY_SIZE(map->channels); cindex++) {
+		if (!map->channels[cindex].indio_dev)
+			break;
+	}
+
+	/* check if we already have collected enough channels */
+	if (cindex == ARRAY_SIZE(map->channels)) {
+		mutex_unlock(&inputbridge_device_mutex);
+		return 0;	/* silently ignore */
+	}
+
+	map->channels[cindex].indio_dev = indio_dev;
+	map->channels[cindex].channel = chan;
+	map->channels[cindex].data = (void *) &devices[dindex];
+
+	switch (cindex) {
+	case 0:
+		input_set_abs_params(map->input, ABS_X, ABSMIN_ACC_VAL,
+					ABSMAX_ACC_VAL, 0, 0);
+		break;
+	case 1:
+		input_set_abs_params(map->input, ABS_Y, ABSMIN_ACC_VAL,
+					ABSMAX_ACC_VAL, 0, 0);
+		break;
+	case 2:
+		input_set_abs_params(map->input, ABS_Z, ABSMIN_ACC_VAL,
+					ABSMAX_ACC_VAL, 0, 0);
+		break;
+	}
+	mutex_unlock(&inputbridge_device_mutex);
+
+	return 0;
+}
+
+int iio_device_register_inputbridge(struct iio_dev *indio_dev)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		const struct iio_chan_spec *chan =
+				&indio_dev->channels[i];
+
+		if (chan->type == IIO_ACCEL) {
+			int r = iio_input_register_accel_channel(indio_dev,
+								 chan);
+
+			if (r < 0)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
+{
+	struct input_dev *input = NULL;
+
+	int dindex = 0;
+
+	mutex_lock(&inputbridge_device_mutex);
+
+	for (; dindex < ARRAY_SIZE(devices); dindex++) {
+		int cindex = 0;
+
+		while (cindex < ARRAY_SIZE(devices[dindex].channels)) {
+			struct iio_channel *channel =
+				&devices[dindex].channels[cindex];
+
+			/* mark slot as empty */
+			if (channel->indio_dev == indio_dev)
+				channel->indio_dev = NULL;
+			cindex++;
+		}
+		input_unregister_device(input);
+		kfree(input->name);
+		kfree(input->phys);
+		input_free_device(input);
+
+		devices[dindex].indio_dev = NULL;
+		devices[dindex].input = NULL;
+	}
+
+	mutex_unlock(&inputbridge_device_mutex);
+}
+
+MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
+MODULE_DESCRIPTION("Bridge to present Industrial I/O accelerometers as properly oriented Input devices");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/industrialio-inputbridge.h b/drivers/iio/industrialio-inputbridge.h
new file mode 100644
index 000000000000..1363b10ab3f7
--- /dev/null
+++ b/drivers/iio/industrialio-inputbridge.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Industrial I/O core, bridge to input devices
+ *
+ * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#if defined(CONFIG_IIO_INPUT_BRIDGE)
+
+extern int iio_device_register_inputbridge(struct iio_dev *indio_dev);
+extern void iio_device_unregister_inputbridge(struct iio_dev *indio_dev);
+
+#else
+
+static inline int iio_device_register_inputbridge(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
+{
+}
+
+#endif
-- 
2.19.1

