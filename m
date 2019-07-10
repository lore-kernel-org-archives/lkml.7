Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6634AC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723721019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqyQFu/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGJXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:04:16 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43997 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfGJXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:04:15 -0400
Received: by mail-pg1-f201.google.com with SMTP id f18so2352375pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZtSCYRHrfuqeQFIWIan5FMIhgUsXnRQXRzmzNcRVTvA=;
        b=JqyQFu/936dQlgKHtsm7+vkRRQ2FEGjcK3zyQ9FtJTEogsQurFNSrSQfqiihOFvzgu
         Rtc9EflergHRlqVhiQVuq4nVY6xEROwEZtJS2dBlrVKGjSCsqJmnesNfSlGsIw1jEyJ+
         5UQ6ljtGbHhdwtwJzNUMXzuKU9OQpDDcfuvGpOQmTm429CJovYJNlxYoWAlDZqKWBBoX
         MYYrRFAtRJu1HRDuUNOSq5MO5o+EFmKQKJG5XDs2iM/kKNvBrIWDyE62CzhcMZBqp2CK
         pwjyNgBO8PHHICfiCD5KEfHRr7Is0xnKFyALCSFmVBjzMr9Iqkam5xNclyDDqCyTK8/k
         kvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZtSCYRHrfuqeQFIWIan5FMIhgUsXnRQXRzmzNcRVTvA=;
        b=FRgDRMHYWLgVwwtOco2t1J4pSxXgBB+bIc0+rk/omxhoBZ+I23tKsQIqWR17lmcyQ5
         fhMg+YxQZM+P3cAyaQwSeXttQq9MWYjaIqHFUvenW6uWlc1iftnIfOXlgqhud7u5bFrz
         baspN+8D/WBIqX8kLQyOYWhQ8hAbyTyzVdbIVhii35u43NqWCcAJVl3Qhm9L/mMCpz58
         lJPZNY+YDYPZBh6ghJb1rKz4BBmE4wI2Z9Th+7Iyt4uB97TI89tdbUBfSq7NHtrQUrzW
         pIPt/9Mti2oxSz45HVQ0kDKiU7Kis6C6GwlQezKbsaIgjBIuLuqr+tIflRihe/gy6HOD
         njMQ==
X-Gm-Message-State: APjAAAUBdC2adqmvmunJqGRD3Gf8So+/wCXWf94pQov9TzMNFWSegX2s
        noeyLnnnpsoreRBxbJy+uzPu4ArNlFG/tsQ=
X-Google-Smtp-Source: APXvYqz9nxqbgKTcnIyVtM9Cf2IExoluezUtYMDtu1yz90v1LYMQi3QOULdrycwXTXmb6qiPPCYRQd+1ZiwieEk=
X-Received: by 2002:a63:d748:: with SMTP id w8mr764999pgi.157.1562799854045;
 Wed, 10 Jul 2019 16:04:14 -0700 (PDT)
Date:   Wed, 10 Jul 2019 16:04:10 -0700
Message-Id: <20190710230410.9386-1-atifniyaz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] input: API for Setting a Timestamp from a Driver
From:   Atif Niyaz <atifniyaz@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Atif Niyaz <atifniyaz11@gmail.com>,
        Siarhei Vishniakou <svv@google.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atif Niyaz <atifniyaz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, evdev stamps time with timestamps acquired in
evdev_events. However, this timestamping may not be accurate in terms of
measuring when the actual event happened. This API allows any 3rd party
driver to be able to call input_set_timestamp, and provide a timestamp
that can be utilized in order to provide a more accurate sense of time
for the event

Signed-off-by: Atif Niyaz <atifniyaz@google.com>
---
 drivers/input/evdev.c | 42 ++++++++++++++++--------------------------
 drivers/input/input.c | 17 +++++++++++++++++
 include/linux/input.h | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 867c2cfd0038..a331efa0a3f6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -25,13 +25,6 @@
 #include <linux/cdev.h>
 #include "input-compat.h"
 
-enum evdev_clock_type {
-	EV_CLK_REAL = 0,
-	EV_CLK_MONO,
-	EV_CLK_BOOT,
-	EV_CLK_MAX
-};
-
 struct evdev {
 	int open;
 	struct input_handle handle;
@@ -53,7 +46,7 @@ struct evdev_client {
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
-	unsigned int clk_type;
+	input_clk_t clk_type;
 	bool revoked;
 	unsigned long *evmasks[EV_CNT];
 	unsigned int bufsize;
@@ -150,16 +143,18 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
-	ktime_t time;
 	struct timespec64 ts;
+	ktime_t *time = input_get_timestamp(client->evdev->handle.dev);
 
-	time = client->clk_type == EV_CLK_REAL ?
-			ktime_get_real() :
-			client->clk_type == EV_CLK_MONO ?
-				ktime_get() :
-				ktime_get_boottime();
+	switch (client->clk_type) {
+	case INPUT_CLK_REAL:
+	case INPUT_CLK_MONO:
+		ts = ktime_to_timespec64(time[client->clk_type]);
+		break;
+	default:
+		ts = ktime_to_timespec64(time[INPUT_CLK_BOOT]);
+	}
 
-	ts = ktime_to_timespec64(time);
 	ev.input_event_sec = ts.tv_sec;
 	ev.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
@@ -185,21 +180,21 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
 	spin_unlock_irqrestore(&client->buffer_lock, flags);
 }
 
-static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
+static int evdev_set_clk_type(struct evdev_client *client, clockid_t clkid)
 {
 	unsigned long flags;
-	unsigned int clk_type;
+	input_clk_t clk_type;
 
 	switch (clkid) {
 
 	case CLOCK_REALTIME:
-		clk_type = EV_CLK_REAL;
+		clk_type = INPUT_CLK_REAL;
 		break;
 	case CLOCK_MONOTONIC:
-		clk_type = EV_CLK_MONO;
+		clk_type = INPUT_CLK_MONO;
 		break;
 	case CLOCK_BOOTTIME:
-		clk_type = EV_CLK_BOOT;
+		clk_type = INPUT_CLK_BOOT;
 		break;
 	default:
 		return -EINVAL;
@@ -307,12 +302,7 @@ static void evdev_events(struct input_handle *handle,
 {
 	struct evdev *evdev = handle->private;
 	struct evdev_client *client;
-	ktime_t ev_time[EV_CLK_MAX];
-
-	ev_time[EV_CLK_MONO] = ktime_get();
-	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
+	ktime_t *ev_time = input_get_timestamp(handle->dev);
 
 	rcu_read_lock();
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 7f3c5fcb9ed6..ae8b0ee58120 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1894,6 +1894,23 @@ void input_free_device(struct input_dev *dev)
 }
 EXPORT_SYMBOL(input_free_device);
 
+/**
+ * input_get_timestamp - get timestamp for input events
+ * @dev: input device to get timestamp from
+ *
+ * A valid timestamp is a timestamp of non-zero value.
+ */
+ktime_t *input_get_timestamp(struct input_dev *dev)
+{
+	const ktime_t invalid_timestamp = ktime_set(0, 0);
+
+	if (!ktime_compare(dev->timestamp[INPUT_CLK_MONO], ktime_zero)) {
+		input_set_timestamp(dev, ktime_get());
+	}
+	return dev->timestamp;
+}
+EXPORT_SYMBOL(input_get_timestamp);
+
 /**
  * input_set_capability - mark device as capable of a certain event
  * @dev: device that is capable of emitting or accepting event
diff --git a/include/linux/input.h b/include/linux/input.h
index 510e78558c10..3929b62ccbe5 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -33,6 +33,14 @@ struct input_value {
 	__s32 value;
 };
 
+enum input_clock_type {
+	INPUT_CLK_REAL = 0,
+	INPUT_CLK_MONO,
+	INPUT_CLK_BOOT,
+	INPUT_CLK_MAX
+};
+typedef enum input_clock_type input_clk_t;
+
 /**
  * struct input_dev - represents an input device
  * @name: name of the device
@@ -114,6 +122,8 @@ struct input_value {
  * @vals: array of values queued in the current frame
  * @devres_managed: indicates that devices is managed with devres framework
  *	and needs not be explicitly unregistered or freed.
+ * @timestamp: storage for a timestamp set by input_set_timestamp called
+ *  by a driver
  */
 struct input_dev {
 	const char *name;
@@ -184,6 +194,8 @@ struct input_dev {
 	struct input_value *vals;
 
 	bool devres_managed;
+
+	ktime_t timestamp[INPUT_CLK_MAX];
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
@@ -382,6 +394,32 @@ void input_close_device(struct input_handle *);
 
 int input_flush_device(struct input_handle *handle, struct file *file);
 
+/**
+ * input_set_timestamp - set timestamp for input events
+ * @dev: input device to set timestamp for
+ * @timestamp: the time at which the event has occurred
+ *   in CLOCK_MONOTONIC
+ *
+ * This function is intended to provide to the input system a more
+ * accurate time of when an event actually occurred. The driver should
+ * call this function as soon as a timestamp is acquired ensuring
+ * clock conversions in input_set_timestamp are done correctly.
+ *
+ * The system entering a suspend between timestamp acquisition and
+ * calling input_set_timestamp can result in inaccurate conversions.
+ *
+ */
+static inline void input_set_timestamp(struct input_dev *dev,
+	ktime_t timestamp)
+{
+	dev->timestamp[INPUT_CLK_MONO] = timestamp;
+	dev->timestamp[INPUT_CLK_REAL] = ktime_mono_to_real(timestamp);
+	dev->timestamp[INPUT_CLK_BOOT] = ktime_mono_to_any(
+		timestamp, TK_OFFS_BOOT);
+}
+
+ktime_t *input_get_timestamp(struct input_dev *dev);
+
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 void input_inject_event(struct input_handle *handle, unsigned int type, unsigned int code, int value);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

