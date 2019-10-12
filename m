Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C6ECE58C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166B2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="middy/KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJLGxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfJLGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so10776174wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MOqGp6N62GYRWc7Fsvh/EkbvR/AOeQrVY/a8V3x3WKI=;
        b=middy/KXn66SPa/ZVSSjJQb1uEc7zwjKuunyzcH+4pvfWYkDB+7mFIqXayXvFj6QEr
         g9zzy4B7MvvEmifCJM1Zk8vMVy9jj2ML2RZnHMcW49IBikJCbilxBWJMUFh3mIMKLtFI
         GGrhK1qHWMjrjHxAVOJFguHBgGtbobrmMPgQQz45U9lZ/Jb3Jk35kwMkb3LKMhA9J+/U
         nJa5UMAOcWs/9U1v8iFWosAkk5eKmWd1UHwl+oGtaSwwVtbKTmpqsB4ua9DiBHEdiq5X
         tiTSCoa8oiUMQPTqQ0KB2BUIeLK3ceuI9vh6agO+v7Al2FxLZQ9p7SmTfvYVn6XQGMxM
         4x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MOqGp6N62GYRWc7Fsvh/EkbvR/AOeQrVY/a8V3x3WKI=;
        b=HIJsFU12IUlmNqQc7047UgPoHJ97ySfvN6QQEnHb5cqR0qReoW4fPTZ4YPQsSv+B7U
         lCrO2Gx2do/JWKk/r5p7nZ+i4EVGBWYcvuMbS4lBu+pFoobwQQVpauTcLwE64ddpTAxB
         /2auqWszKowg4YLQ3v5NZzF3IWxexJsxnUIw2is8gGz/tDMV+AiQMWxIkD18Udh2RZ23
         CZASdYqeL8kVIJFiV4Rw55CC3Rx/SBKVRAdERiSWdieGF4ylkGcBA/2DeMPwyjAZKUMp
         BnfGpqaZ3hLezajxQ0+ujYy7J0ew2mNjmF7SualzqexW8yY+CNg0KL6ggW9LFz+X7hzr
         96UQ==
X-Gm-Message-State: APjAAAXfMP9GWcMNp1jdP7wJwPLcuAF1XqxEwe9KNOLam5fI3zCCCMwA
        jiKDsJzbw7Ra+mqjzK7/HiTNRA==
X-Google-Smtp-Source: APXvYqx6jtdvvFGmYfIrdErsFC0VLmpAU1ALugDQxnVp+LABDSDGC1SLJ68sxolh+TBJr2bQEoBEuQ==
X-Received: by 2002:a1c:a697:: with SMTP id p145mr5714929wme.24.1570863188994;
        Fri, 11 Oct 2019 23:53:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 05/11] thermal: Move set_trips function to the internal header
Date:   Sat, 12 Oct 2019 08:52:49 +0200
Message-Id: <20191012065255.23249-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is not used in other place than the thermal directory. It
does not make sense to export its definition in the global header as
there is no use of it.

Move its the definition in the internal header and allow better
self-encapsulation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 2 ++
 include/linux/thermal.h        | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 6f6e0dcba4f2..301f5603def1 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -72,6 +72,8 @@ struct thermal_trip {
 	enum thermal_trip_type type;
 };
 
+void thermal_zone_set_trips(struct thermal_zone_device *tz);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 88e1faa3d72c..761d77571533 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -398,7 +398,6 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
-void thermal_zone_set_trips(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
@@ -444,8 +443,6 @@ static inline int thermal_zone_unbind_cooling_device(
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
-static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
-{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
2.17.1

