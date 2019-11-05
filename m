Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06080C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972162053B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mN4poGPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfKEW1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:27:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33265 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfKEW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:27:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so3375853plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxmSYM2PIWDV7z9ZW8bFbnzgcJsGgOBc0wQEg/5DnDE=;
        b=mN4poGPvyVr/QMWegLRuBf/2TIykMmVHID8xSx4gXb45Ec6vqYWSrysOUBB1iNHQ+s
         EJabjqMTTb39ErJinwTq9MSERRQQ5jWbeBVAPmAUUOqbCdyXdM1Nk3yBQSp8HhmxqBJn
         Fvehj0DrwWvTcYOEKfcZCr/vCH/INqOv6vFzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxmSYM2PIWDV7z9ZW8bFbnzgcJsGgOBc0wQEg/5DnDE=;
        b=c1X7hyCQ2tQ7QukZkLAPbDzoC8I+YHqPaKo/hsh99QUCDnzAtqjgH3UEvqvylXaVEu
         WotXee2yN6jP+jzD9XJMRwH4P7ovp/X6OfB7Cien89BhPwtgEFKJdf81dSmRKMOYm/E+
         EsAQIewWxslgYoC6suC9j/n8XAmsxySeZYRY3qD/QnHEMt1nVjlRcJLKOg9ETQIgluoM
         aAQMns5vTIup+lIBZVxCk2lZhIkj0ELlY9+DUidiuDvWU079UVGJzT1S+kqT4sZljGRq
         FU463qAu4PS7GVuFU66solQrDGZyG50435Jv+mNFTkqDqlzVMox2MCiowXlmU1EPdWx/
         qfGw==
X-Gm-Message-State: APjAAAV+RS8qzoIztMDRTmakcTBJifukuJyCS/GmykEmYb37TFMwHMDd
        BQ3ctdmdHTLxawbUEtpUg3/ROw==
X-Google-Smtp-Source: APXvYqypDU9XlYR6lh3p1zhIbkXSjyaXA0s5ZS21XbS6aZCnfa9QJL0yHdMaDWVbSQA22aHCmuYkvQ==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8mr35546366plb.86.1572992824821;
        Tue, 05 Nov 2019 14:27:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f13sm18600402pgs.83.2019.11.05.14.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:04 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 04/17] platform: chrome: cros-ec: record event timestamp in the hard irq
Date:   Tue,  5 Nov 2019 14:26:39 -0800
Message-Id: <20191105222652.70226-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve sensor timestamp precision, given EC and AP are in
different time domains, the AP needs to try to record the exact
moment an event was signalled to the AP by the EC as soon as
possible after it happens.

First thing in the hard irq is the best place for this.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
  Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
  Make cros_ec_get_time_ns inline.
  Using ktime_t instead of s64 when dealing with time.
  Added code in ishtp to gather timestamp.

 drivers/platform/chrome/cros_ec.c           | 17 ++++++++++++++---
 drivers/platform/chrome/cros_ec_ishtp.c     | 17 +++++++++++++++--
 drivers/platform/chrome/cros_ec_lpc.c       |  2 ++
 include/linux/platform_data/cros_ec_proto.h | 16 ++++++++++++++++
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e17..925f84dbf621 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -31,6 +31,15 @@ static struct cros_ec_platform pd_p = {
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
 };
 
+static irqreturn_t ec_irq_handler(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+
+	ec_dev->last_event_time = cros_ec_get_time_ns();
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
@@ -141,9 +150,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	}
 
 	if (ec_dev->irq) {
-		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
-				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-				"chromeos-ec", ec_dev);
+		err = devm_request_threaded_irq(dev, ec_dev->irq,
+						ec_irq_handler,
+						ec_irq_thread,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"chromeos-ec", ec_dev);
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 25ca2c894b4d..5c848f22b44b 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -200,13 +200,14 @@ static int ish_send(struct ishtp_cl_data *client_data,
  * process_recv() - Received and parse incoming packet
  * @cros_ish_cl: Client instance to get stats
  * @rb_in_proc: Host interface message buffer
+ * @timestamp: Timestamp of when parent callback started
  *
  * Parse the incoming packet. If it is a response packet then it will
  * update per instance flags and wake up the caller waiting to for the
  * response. If it is an event packet then it will schedule event work.
  */
 static void process_recv(struct ishtp_cl *cros_ish_cl,
-			 struct ishtp_cl_rb *rb_in_proc)
+			 struct ishtp_cl_rb *rb_in_proc, ktime_t timestamp)
 {
 	size_t data_len = rb_in_proc->buf_idx;
 	struct ishtp_cl_data *client_data =
@@ -295,6 +296,11 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 		break;
 
 	case CROS_MKBP_EVENT:
+		/*
+		 * Set timestamp from beginning of function since we actually
+		 * got an incoming MKBP event
+		 */
+		client_data->ec_dev->last_event_time = timestamp;
 		/* The event system doesn't send any data in buffer */
 		schedule_work(&client_data->work_ec_evt);
 
@@ -322,10 +328,17 @@ static void ish_event_cb(struct ishtp_cl_device *cl_device)
 {
 	struct ishtp_cl_rb *rb_in_proc;
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+	ktime_t timestamp;
+
+	/*
+	 * Take timestamp as close to hardware interrupt as possible for sensor
+	 * timestamps.
+	 */
+	timestamp = cros_ec_get_time_ns();
 
 	while ((rb_in_proc = ishtp_cl_rx_get_rb(cros_ish_cl)) != NULL) {
 		/* Decide what to do with received data */
-		process_recv(cros_ish_cl, rb_in_proc);
+		process_recv(cros_ish_cl, rb_in_proc, timestamp);
 	}
 }
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7d10d909435f..3c77496e164d 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -313,6 +313,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 
+	ec_dev->last_event_time = cros_ec_get_time_ns();
+
 	if (ec_dev->mkbp_event_supported &&
 	    cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 691f9e953a96..b183024fef1f 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -122,6 +122,8 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @last_event_time: exact time from the hard irq when we got notified of
+ *     a new event.
  * @ec: The platform_device used by the mfd driver to interface with the
  *      main EC.
  * @pd: The platform_device used by the mfd driver to interface with the
@@ -162,6 +164,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	ktime_t last_event_time;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
@@ -210,4 +213,17 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
+/**
+ * cros_ec_get_time_ns - Return time in ns.
+ *
+ * This is the function used to record the time for last_event_time in struct
+ * cros_ec_device during the hard irq.
+ *
+ * Return: ktime_t format since boot.
+ */
+static inline ktime_t cros_ec_get_time_ns(void)
+{
+	return ktime_get_boottime_ns();
+}
+
 #endif /* __LINUX_CROS_EC_PROTO_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

