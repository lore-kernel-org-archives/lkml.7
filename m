Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B472C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CC121850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQgl+K6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJLGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfJLGxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so12065119wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rteKuts6TNa3FcVuHWLA6WnDYTAfCMs6+nc1PCbFmJQ=;
        b=SQgl+K6sNR2uq9Qca5Iss6ihuLcJTBrMZ1pAbWVUadX7jFw+xcyB0QURWWUWVz8y2R
         d99mU5a8wP26+xSf5dAuLaIfgAGbyEWKlpkFdDvL9AnTQXBPsgXqTZuwQ7yB7TAvzpF4
         PAFnjYconaxdhsxvJvcj7V5kj+A2WzqaQCeefz+SrhM24rnCfY7OtsTLYuwegJDbbpp+
         Zgfcf+3+qiHn9pqT+Vf047SH0nn7Z5wvxH+WSaTexklqKncnCF60c7Fay1GwGpsMM2dC
         2jeFi4yUYLf1axQGOLXljZILelt4MWu1EFqtg0Qi++1uYucz/8TGhK9I6YTSxPwfPCSa
         M2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rteKuts6TNa3FcVuHWLA6WnDYTAfCMs6+nc1PCbFmJQ=;
        b=F0oC2INftrxQTK6ceJw+KZAE8+u1ay0sejNIBM5dvXdCLQNWSIp6rd8J/8xi+uvk6s
         EC3f8iYcNezJtHA98ZVqDCphcnR96Gjl/76wuc1f729yJ3fjj9kE5iVfU0ESB7Oq4oU2
         k+aQBMcmmZqSzz7uPqEopS1rKhqAOpnbvkE3YZ4O2p57sIdr1LeTW6igbA8UX75ZbHUp
         KodTHd46K2umQn40TVHVZqVsvqQydBo1nZeb71wU6fPc9ZrorjKHJHUghm3Qjb9brpIS
         BYufwYP7BNClixlhxDQDd2GwkbwUWNbxfzB0U/ZMGXKdTTBF/ezwMhwZprmnHMxNYwGk
         Ywtw==
X-Gm-Message-State: APjAAAWhmHg0aK1eOBqao+JhU5jOQtfOnmJG5SdeVocjqMn+IxCSakpb
        BCNfrksSWnPgtIEgo3wmMA3xYQ==
X-Google-Smtp-Source: APXvYqz6H1BO1YpWsenMxjKC4aURJk8ZH0MHXxOpWMBnGfL5Wm3zMrGzi5T1mv6BUGtzelW11wzF0g==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr6384737wme.101.1570863195695;
        Fri, 11 Oct 2019 23:53:15 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 11/11] thermal: Move thermal governor structure to internal header
Date:   Sat, 12 Oct 2019 08:52:55 +0200
Message-Id: <20191012065255.23249-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal governor structure is a big structure where no
user should change value inside except via helper functions.

Move the structure to the internal header thus preventing external
code to be tempted by hacking the structure's variables.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 20 ++++++++++++++++++++
 include/linux/thermal.h        | 21 +--------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c75309d858ce..e54150fa4c5b 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -46,6 +46,26 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+/**
+ * struct thermal_governor - structure that holds thermal governor information
+ * @name:	name of the governor
+ * @bind_to_tz: callback called when binding to a thermal zone.  If it
+ *		returns 0, the governor is bound to the thermal zone,
+ *		otherwise it fails.
+ * @unbind_from_tz:	callback called when a governor is unbound from a
+ *			thermal zone.
+ * @throttle:	callback called for every trip point even if temperature is
+ *		below the trip point temperature
+ * @governor_list:	node in thermal_governor_list (in thermal_core.c)
+ */
+struct thermal_governor {
+	char name[THERMAL_NAME_LENGTH];
+	int (*bind_to_tz)(struct thermal_zone_device *tz);
+	void (*unbind_from_tz)(struct thermal_zone_device *tz);
+	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	struct list_head	governor_list;
+};
+
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {
 	return cdev->ops->get_requested_power && cdev->ops->state2power &&
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8daa179918a1..04264e8a2bce 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -45,6 +45,7 @@
 
 struct thermal_zone_device;
 struct thermal_cooling_device;
+struct thermal_governor;
 struct thermal_instance;
 struct thermal_attr;
 
@@ -206,26 +207,6 @@ struct thermal_zone_device {
 	enum thermal_notify_event notify_event;
 };
 
-/**
- * struct thermal_governor - structure that holds thermal governor information
- * @name:	name of the governor
- * @bind_to_tz: callback called when binding to a thermal zone.  If it
- *		returns 0, the governor is bound to the thermal zone,
- *		otherwise it fails.
- * @unbind_from_tz:	callback called when a governor is unbound from a
- *			thermal zone.
- * @throttle:	callback called for every trip point even if temperature is
- *		below the trip point temperature
- * @governor_list:	node in thermal_governor_list (in thermal_core.c)
- */
-struct thermal_governor {
-	char name[THERMAL_NAME_LENGTH];
-	int (*bind_to_tz)(struct thermal_zone_device *tz);
-	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz, int trip);
-	struct list_head	governor_list;
-};
-
 /* Structure that holds binding parameters for a zone */
 struct thermal_bind_params {
 	struct thermal_cooling_device *cdev;
-- 
2.17.1

