Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF03C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD02206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4VhaHcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfIVRvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:51:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38580 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbfIVRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:51:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so6558133pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWCBk9jNItZZ2mKv5RsCismjjjv69yXETRZBPaLXUUk=;
        b=b4VhaHczNu6cKCSElkarC5pgutT8rO/bTlcuwlrdpVxYs6M+crjlcwY639LtBp+I+g
         AN4bfBcT6LjGJ8dCudOZLXW31f+cYZaU8ny9WodQDq/rONjn1pnuJfMBbQuE5WucyTIU
         EyPAJV2Iw1a0X2nJJERFiK/pWZGZfkiaic1Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWCBk9jNItZZ2mKv5RsCismjjjv69yXETRZBPaLXUUk=;
        b=tEqOTJYWzeQaReCadLQbD0K7LZHE1q8bmp1wtEZ+vurY15jLfk3JPWtzPa7sWfislB
         TJLs9GnuUCiRX9+/D/q6p+1nJBfU286tE2qYr0SZgQ5wceYxHkUEHBYahyGd8hP/4zVv
         VUnzE441aapBx9hio8HQA46c0gJueBVUuRpCLMSGj/JrHybCDJif+hwscjk+UwGapKaK
         8PB40QkwlvvtZa3Df8z+SLFFLOhyxaREYLS4hiCDQaV5gL80eouijtT3+PFr8WSftfAN
         ZYDw3J2o2UBi6G2v4Y3NTU007DcgiHUVkqSzr3+6703Tw9o+CXuV0Pe1RQAtAbFWioJs
         9Dkg==
X-Gm-Message-State: APjAAAVUjjPVnTw3ZaOe2c7w8Jez5xtwsUxGHk/wuatOAheuWvlURLuv
        Hw6pgziXotM/SRXhvjdEoSnUnw==
X-Google-Smtp-Source: APXvYqxlyy5IFP5XFJGqXbbPWIEkr3wz93Ix2nAtuUYUA+o7cXhY39iyRi4SUciK6TvqOILqvnq6XQ==
X-Received: by 2002:a63:2254:: with SMTP id t20mr26040688pgm.173.1569174678654;
        Sun, 22 Sep 2019 10:51:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id k5sm7273684pgo.45.2019.09.22.10.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:18 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 12/13] iio: cros_ec: Report hwfifo_watermark_max
Date:   Sun, 22 Sep 2019 10:50:20 -0700
Message-Id: <20190922175021.53449-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report the maximum amount of sample the EC can hold.
This is not tunable, but can be useful for application to find out the
maximum amount of time it can sleep when hwfifo_timeout is set to a
large number.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 35 +++++++++++++++++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  4 ++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a31a761e3a81..a32260c9bc09 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -23,6 +23,12 @@
 #include <linux/platform_data/cros_ec_sensorhub.h>
 #include <linux/platform_device.h>
 
+/*
+ * Hard coded to the first device to support sensor fifo.  The EC has a 2048
+ * byte fifo and will trigger an interrupt when fifo is 2/3 full.
+ */
+#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
+
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
@@ -56,8 +62,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 
 static void get_default_min_max_freq(enum motionsensor_type type,
 				     u32 *min_freq,
-				     u32 *max_freq)
+				     u32 *max_freq,
+				     u32 *max_fifo_events)
 {
+	/*
+	 * We don't know fifo size, set to size previously used by older
+	 * hardware.
+	 */
+	*max_fifo_events = CROS_EC_FIFO_SIZE;
+
 	switch (type) {
 	case MOTIONSENSE_TYPE_ACCEL:
 	case MOTIONSENSE_TYPE_GYRO:
@@ -122,6 +135,7 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 	return len;
 }
 
+
 static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -149,8 +163,22 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
 		       cros_ec_sensor_get_report_latency,
 		       cros_ec_sensor_set_report_latency, 0);
 
+static ssize_t hwfifo_watermark_max_show(
+		struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_max_event_count);
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+
 static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
 };
 
@@ -251,12 +279,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		if (state->msg->version < 3) {
 			get_default_min_max_freq(state->resp->info.type,
 						 &state->frequencies[1],
-						 &state->frequencies[2]);
+						 &state->frequencies[2],
+						 &state->fifo_max_event_count);
 		} else {
 			state->frequencies[1] =
 			    state->resp->info_3.min_frequency;
 			state->frequencies[2] =
 			    state->resp->info_3.max_frequency;
+			state->fifo_max_event_count =
+			    state->resp->info_3.fifo_max_event_count;
 		}
 
 		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 60f78f0e4884..2c6acbde0d02 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -54,7 +54,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				the timestamp. The timestamp is always last and
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
- * @cuur_sampl_freq:		current sampling period
+ * @curr_sampl_freq:		current sampling period
+ * @fifo_max_event_count:	Size of the EC sensor FIFO
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -78,6 +79,7 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	int curr_sampl_freq;
+	u32 fifo_max_event_count;
 
 	/* Table of known available frequencies : 0, Min and Max in mHz */
 	int frequencies[3];
-- 
2.23.0.351.gc4317032e6-goog

