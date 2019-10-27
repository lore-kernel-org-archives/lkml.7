Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F692CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FAB20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNVSpy7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfJ0XK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:10:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46261 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfJ0XKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:10:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id f19so5353817pgn.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBkZv5T87/6qsGMWiQqASxcIOOXirewPBkGsTYS+sGo=;
        b=YNVSpy7uZPK9B0TkvWaxRuHgHdmPep21fLIGntvqEIh4jj5FcDfBkiFFt4NtGtjc9U
         2giTuJNd8q326EXt6wvv/To8lLTh98UN/Ujgw/Eoz0+bbZ/kh0y3DXcBwuvqLLDY8gai
         9jYHXM5hWxlBcp5rLIbbys1GbUdY86LCCqU9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBkZv5T87/6qsGMWiQqASxcIOOXirewPBkGsTYS+sGo=;
        b=F58JLKZt2UudMWrEMkWD8D7nhjmvyWYFH3bJRgZwrELl4RDLvScTYQwU2cuts/5Xi3
         5pgd36xrS8BuDbeYgyaOV/VYqbSDAxtIU69fiwxogSuQnfFkWC5X7/UHvH1xe1c4OsHF
         nP9CEmgU7CxGEYLKDTA2Dut0upCPIN4vBjQBhlzRFMTJVSHgAKnKsjt6xcawLEjItBnj
         WABLHpjH63qmtmGn+gber1np8wL/mGI8q0fkKxwVCK3cJS+TCb/2n5qwWzq8/KEw0kE+
         IdwBhka1uIdQ3hhM55mDfUxS19o7uJ6eqONHi+3TklIYoHqFMYSD+v20wB3yulcA4dEY
         nwJg==
X-Gm-Message-State: APjAAAUE+K5Mqwh0nPs+hum64Ih7MF99qjv2exA2tnUN51GQzqQGWMW0
        BDK0O9TSCNW23odFISMiWcZBCQ==
X-Google-Smtp-Source: APXvYqzuVoUzDR+kvliLsubwOzyTreO6YSrTy6g0PjiUPewNtXmRNbghRJDWWJpnU00x/R8WHBT6zw==
X-Received: by 2002:a63:cd47:: with SMTP id a7mr16827359pgj.29.1572217813592;
        Sun, 27 Oct 2019 16:10:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f25sm12791753pfk.10.2019.10.27.16.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 17/18] iio: cros_ec: Report hwfifo_watermark_max
Date:   Sun, 27 Oct 2019 16:09:20 -0700
Message-Id: <20191027230921.205251-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
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
No changes in v3.
Changes in v2:
- Remove double lines, add line before return for visibility.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 34 +++++++++++++++++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 506b481420036..fc40bfa4a21fd 100644
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
@@ -150,8 +163,22 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
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
 const struct attribute *cros_ec_sensor_fifo_attributes[] = {
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
@@ -287,12 +314,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
 
 		ret = devm_iio_triggered_buffer_setup(
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ded8381b1299c..2f3668dfc826b 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -50,6 +50,7 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				the timestamp. The timestamp is always last and
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
+ * @fifo_max_event_count:	Size of the EC sensor FIFO
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -72,6 +73,8 @@ struct cros_ec_sensors_core_state {
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);
 
+	u32 fifo_max_event_count;
+
 	/* Table of known available frequencies : 0, Min and Max in mHz */
 	int frequencies[3];
 };
-- 
2.23.0.866.gb869b98d4c-goog

