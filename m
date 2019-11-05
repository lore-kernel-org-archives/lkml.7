Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E7C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224A2204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCrvyXep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfKEW11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:27:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33294 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfKEW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:27:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so3376381plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nadAzCy5ifgvsr0hZFSAvACEhGU40Tduvym+rSwgG0k=;
        b=nCrvyXept/lQcUpcwhk9zgGkHZD960+cbHTd7ux635tNe477KpzRINH0UOKdk6r6jM
         EwqkTAHn886ThHrbMmSud0VmRqN+SlFGTOU/xSPLu7Ar7OsRzwA+h1gLu7h/uo7oMyzq
         6VDxHsCU33/L4AhIXFV7s4DiZyaerFIN7/ExQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nadAzCy5ifgvsr0hZFSAvACEhGU40Tduvym+rSwgG0k=;
        b=BrkhooihpKO0UXYqIW7zjU7/TtnegIkYSVOHYfX0zgA74qElTOxz7IsLk8O9msRpKU
         PJZ07FRK0Nxqbs18rA7POrl8D9oS6Vf31xjX4osVj/RZ97zMnUmNqn3lKS3prpJqCqJf
         lXVKNzOVgGegGQZPlfAvX7m4b1u/sazyT+ZDmhNl77+w+m6QVifYaCU7SAZ2b5A8mliR
         RylG5khI/hXmiBS1r1Nnt6Ko/3wLNuKDKZ+MUcbun8+k+Ib47aTBLg5wsUOqxSILDmTI
         6GJMuye7hvAusifI2bBGx+R5gaTamHHddWg5qhKfRm+/swp/3GLcXCvpw2JyaKt1Gv5N
         waXg==
X-Gm-Message-State: APjAAAWc+0+vxmGZKpmN0sorhbaDGIscTwap8JY0xk3CHYRKfgGVCqdG
        qrxhZixuDLBJA9RZ7ZQKVkS1iQ==
X-Google-Smtp-Source: APXvYqwoFx7sjzdJtgssRJDH1Z9S5/uCanG64VLivEYp+c0X25cKQaXYDuvTCxH2HBHOBcvKbfAH9A==
X-Received: by 2002:a17:902:ff07:: with SMTP id f7mr34611276plj.216.1572992843911;
        Tue, 05 Nov 2019 14:27:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 22sm20708311pfo.131.2019.11.05.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 16/17] iio: cros_ec: Report hwfifo_watermark_max
Date:   Tue,  5 Nov 2019 14:26:51 -0800
Message-Id: <20191105222652.70226-17-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
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
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Remove double lines, add line before return for visibility.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 33 +++++++++++++++++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 62dc1e4aa7a8..4169c6c055d8 100644
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
@@ -150,8 +163,21 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
 		       cros_ec_sensor_get_report_latency,
 		       cros_ec_sensor_set_report_latency, 0);
 
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
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
@@ -287,12 +313,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
 
 		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 5b0acc14c891..bc26ae2e3272 100644
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
2.24.0.rc1.363.gb1bccd3e3d-goog

