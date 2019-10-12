Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EAC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F892067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QparcBdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfJLGxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40180 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJLGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so14106721wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xHcBgOBhQx/DWwTnVmG8K83D5aGb+y1z51DF9NhXCic=;
        b=QparcBdvemceLiXGxQgjeJMqaa9Oth/jqWHcOmQII4NvA2oggRO+4FzltfmSn79PEv
         LdWXtzXkGj5Ub8z7VsT4oNBDVxez0jBNBjbNgUmGE8Vf1kv+wHJzcFHiTkr6EZDHajO1
         Y3EU/VFmWfDEepS/72qNQcTgdlp5ke/dTEzctNo+WK1Ts4qZxr2IJXKlwrg6RQnXm46o
         HBkU2qFhN7eBhUzyYTKF9mN9UmPMbYVSldB1+21jNh3JRnlPrnJ8y3ZNZQpjJsEp4QHV
         HbdDQP/0vuSY8uyDKFn2tMV2A29yQHMsd5aQRUrtoLbU7q2MQjOw2I/VCUlaLg4bag+b
         GSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xHcBgOBhQx/DWwTnVmG8K83D5aGb+y1z51DF9NhXCic=;
        b=gwfFYRCRbDBbwdeg1DeEgIkz87Jd6+nQJ/tZserZ25cIQGBo7yP8bEN2dOfwLo6P2J
         2BSgrKz4SJHZx910ksenT/YRIvo+5YyDmWjAIVdK/ydZyQ6JMiVIDPQSo0kCoBy6WI6q
         W65bdswZo1XZZCYJv1of9z0ibxdpuSATme7D8RsoUVHUG8r2n9uHPz0lg6jUMTkYdtwM
         A+zXFqsoFzjBvqvZVEFHNY5UUSw4E231YM5uQ0GVes8S/ouBRjhFqlQcJn/yMN5FWzy4
         cjBMPcREaeODyMdmyIsz/3QQ7g3pT9bfc4BkZczpEvbJgAtYV4L7ZkmVXMI1zPi/OMLh
         +hcA==
X-Gm-Message-State: APjAAAU86CZJiW70VAIvkbHcLvvQ/Wx5Zc6SBJs26vpKEyx2gMAwusEL
        DvtB9RDm/gCdiq8sc08Zr1iQFuAm+zk=
X-Google-Smtp-Source: APXvYqzIx0kMsYuOP3QGZ0qmALEryVFoWQLyy7Zbzre+VUhxvmq4/xKfRAumtVXE4B5G8nOOa2zi/A==
X-Received: by 2002:a5d:614c:: with SMTP id y12mr17350876wrt.235.1570863184509;
        Fri, 11 Oct 2019 23:53:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 03/11] thermal: Move internal IPA functions
Date:   Sat, 12 Oct 2019 08:52:47 +0200
Message-Id: <20191012065255.23249-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exported IPA functions are used by the IPA. It is pointless to
declare the functions in the thermal.h file.

For better self-encapsulation and less impact for the compilation if a
change is made on it. Move the code in the thermal core internal
header file.

As the users depends on THERMAL then it is pointless to have the stub,
remove them.

Take also the opportunity to fix checkpatch warnings/errors when
moving the code around.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 13 +++++++++++++
 include/linux/thermal.h        | 24 ------------------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0e964240524d..5953bb527ec2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -46,6 +46,19 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
+{
+	return cdev->ops->get_requested_power && cdev->ops->state2power &&
+		cdev->ops->power2state;
+}
+
+int power_actor_get_max_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *max_power);
+int power_actor_get_min_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *min_power);
+int power_actor_set_power(struct thermal_cooling_device *cdev,
+			  struct thermal_instance *ti, u32 power);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 603766a4068c..fae9ff2b079a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -400,18 +400,6 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 #endif
 
 #if IS_ENABLED(CONFIG_THERMAL)
-static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
-{
-	return cdev->ops->get_requested_power && cdev->ops->state2power &&
-		cdev->ops->power2state;
-}
-
-int power_actor_get_max_power(struct thermal_cooling_device *,
-			      struct thermal_zone_device *tz, u32 *max_power);
-int power_actor_get_min_power(struct thermal_cooling_device *,
-			      struct thermal_zone_device *tz, u32 *min_power);
-int power_actor_set_power(struct thermal_cooling_device *,
-			  struct thermal_instance *, u32);
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		struct thermal_zone_params *, int, int);
@@ -449,18 +437,6 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
-static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
-{ return false; }
-static inline int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *max_power)
-{ return 0; }
-static inline int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-					    struct thermal_zone_device *tz,
-					    u32 *min_power)
-{ return -ENODEV; }
-static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
-			  struct thermal_instance *tz, u32 power)
-{ return 0; }
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-- 
2.17.1

