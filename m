Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC0DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF07B2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlmB/6S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfENRdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:33:17 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41969 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:33:16 -0400
Received: by mail-qt1-f201.google.com with SMTP id l37so8753371qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=BqvKyNI72vvS2gqJPoI8R/UL+5htusVnGEndKiYEuoY=;
        b=XlmB/6S5tyl3kACOqI4RGi/AYAGBbATRdM/YoHuRUjzjL+KYSHDYtIQ/jaLlJWnrcO
         kKFuLImD55wowWDHZK6Z+K7qCdb9oCnoRZofnbeT01aUlnPaQHRbv7Q5pFDCrhlJMZDC
         d4rWVYIRVQQbvD2AYgyRg79TQ3ve4gSVzSDqG95sRbSs0/gjbTE0civ7xkXZUi54yVgn
         qs+xruAdlj+DIojHH3pkdQwU/dtoryxtACifn8x8oI9V6ij4Vy9wLLGd80wSbdvObWhQ
         mIbSq54jOvoKnkGStZrdrLOwft/OmmGVoOQ+QpxeMZNakr9QjkbbjZCXVHb7BB5CvMZR
         69Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=BqvKyNI72vvS2gqJPoI8R/UL+5htusVnGEndKiYEuoY=;
        b=XobMI/SApvTxXYkOY7p99sOju/bxr8OvQiYUVscxfCzp3FYra08FL6RhxY1K2uOyvd
         9yNVtOo4EdfTecl7KLuCpxNgHBjBNjU9V0JvUH26689xi2zeAD+/pdoKrbKe1MEpERkd
         Uvsguz3yO0hEb3yh9y3cJbNIqV5l3ATXt71xO6Kari3eHEvqp6NOv19aMbaYkno/zipn
         zQ8qOOD1D5kkYpKOTx0V4l0O3z5X+H6A7QTj/87Lw4mAJ+k1vW0ja6pZw7QLo38DaHNf
         VgIZvnIW9kYtPUkeUMSuONzvrLYjyD178MhuOouUP1wqzGlJDlCiSFVw6bYMmasjE9g2
         /Vjg==
X-Gm-Message-State: APjAAAW9QzLFUDBv1/WNdZAPzJsBzhai94iuVkkS3bb4hLC8JNs3LhuA
        dlkU04BITRpYvqoR1yaWDXqPPEI=
X-Google-Smtp-Source: APXvYqzjdFzVH61R1ab0XzAVIAq2a6gann2WfIrLxzjrOU/9McW0tnQBAzZtO6M72haqhK0xoNa5U44=
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr29037867qkj.34.1557855195127;
 Tue, 14 May 2019 10:33:15 -0700 (PDT)
Date:   Tue, 14 May 2019 10:33:03 -0700
Message-Id: <20190514173304.213692-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] thermal: make thermal_cooling_device_register accepts const string
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the argument similarly to thermal_zone_device_register. This will
help register names get from of_property_read_string during probe.

Signed-off-by: Wei Wang <wvw@google.com>
---
 Documentation/thermal/sysfs-api.txt |  7 ++++---
 drivers/thermal/thermal_core.c      |  6 +++---
 include/linux/thermal.h             | 12 ++++++------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index c3fa500df92c..0c26c05197ad 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -31,7 +31,7 @@ temperature) and throttle appropriate devices.
 1. thermal sysfs driver interface functions
 
 1.1 thermal zone device interface
-1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *type,
+1.1.1 struct thermal_zone_device *thermal_zone_device_register(const char *type,
 		int trips, int mask, void *devdata,
 		struct thermal_zone_device_ops *ops,
 		const struct thermal_zone_params *tzp,
@@ -160,8 +160,9 @@ temperature) and throttle appropriate devices.
 	drivers for temperature calculations.
 
 1.2 thermal cooling device interface
-1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
-		void *devdata, struct thermal_cooling_device_ops *)
+1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(
+		const char *name, void *devdata,
+		struct thermal_cooling_device_ops *ops)
 
     This interface function adds a new thermal cooling device (fan/processor/...)
     to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..b708b66fef94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -941,7 +941,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
  */
 static struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
-				  char *type, void *devdata,
+				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1015,7 +1015,7 @@ __thermal_cooling_device_register(struct device_node *np,
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(NULL, type, devdata, ops);
@@ -1039,7 +1039,7 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
  */
 struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
-				   char *type, void *devdata,
+				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(np, type, devdata, ops);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..0f58fffee9a8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -442,10 +442,10 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 void thermal_zone_set_trips(struct thermal_zone_device *);
 
-struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
-		const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *thermal_cooling_device_register(const char *,
+		void *, const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, char *, void *,
+thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -496,12 +496,12 @@ static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+thermal_of_cooling_device_register(struct device_node *np, const char *type,
+	void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
-- 
2.21.0.1020.gf2820cf01a-goog

