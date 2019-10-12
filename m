Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C0AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB2C21929
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rru5RL0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfJLGxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfJLGxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so12064724wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oJUJQi9oxDEyvIdLCMbq2uvVsNGsqyuKnnHa3VxGyMs=;
        b=rru5RL0fM2DXupCKMZjiKQnH7iBHl3J3DsZqG5oDOaFs798N28j7GMQLZw/EmiBao/
         gt1F3O6LsGkIY+olovxz6Pssclf7fzyN9yGBi+Uvo7x2C4lw6TK82JQRoa6oRK/Elge6
         b5sd+3y47Ae4NokPD2QFHEWJ3ttBXxgJLcuFiqyXpPkfXtr+PNuQoYRoEQYDkO1VJWG1
         axj15r/FNybiPwx/ombb4umc0lERtlTh9etngpSc7VbvHmcPey6c7VpQp09fSS/V6D7Y
         VoGmOS3xJjXiDJleeW6dsowLv09ME5fyLgh9/tX9GNXTb59vP9/e9jfcIOrIGEAbn8Uu
         9ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oJUJQi9oxDEyvIdLCMbq2uvVsNGsqyuKnnHa3VxGyMs=;
        b=DCP7dIwp5ReOjNpfyi0Vgk04CL3GZ6TAireNesl/a4g2KaQA/a4XHmVg8LFyf6pF/w
         v0waxVDEVx9i4tTqIJfQW42sdxKi7OD6lyTBei/Tole/RxP34kc9w9G/MVb3Sufg8ocv
         USwA7j0U1t22plBh6RYJrGFxX7zoDZz9YNZGSTIdppbe84z845RkoHTvnxPzcr0HvWwJ
         QMaQv8uZODWDQfCQmQgyCHU5CXhFck0+sin9mdrs8PD7C34TAmzq2Xf36UocZOon6VhS
         oitTSQZ7wSTWu+ssn8eQ2QxZVV2DpGfuIjbveEYQZ6w9927ipfYS836FqC9nzyiqXR47
         c61g==
X-Gm-Message-State: APjAAAXgHSk8GWQEVk5ItuQ6zHoVkIsODscuxsqzR/3o6hE2pCeIMCvc
        YUJ4Y52mPd67T+uuRmK3NwYDGPf9C2U=
X-Google-Smtp-Source: APXvYqyq2W7Se2F+acWXTOOiNGux52eSB4Y7gp5fOWSI5VTdXtXUmnuCVRgrbmZGcwVwdf0sHflEgA==
X-Received: by 2002:a1c:444:: with SMTP id 65mr6430067wme.84.1570863190047;
        Fri, 11 Oct 2019 23:53:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 06/11] thermal: Move get_tz_trend to the internal header
Date:   Sat, 12 Oct 2019 08:52:50 +0200
Message-Id: <20191012065255.23249-6-daniel.lezcano@linaro.org>
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

Take the opportunity to add the parameter names to make checkpatch
happy and remove the pointless stubs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 2 ++
 include/linux/thermal.h        | 4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 301f5603def1..c03a07164ca7 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -74,6 +74,8 @@ struct thermal_trip {
 
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
+int get_tz_trend(struct thermal_zone_device *tz, int trip);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 761d77571533..a87f551d114d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -415,7 +415,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
@@ -474,8 +473,7 @@ static inline int thermal_zone_get_slope(
 static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
-static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
-{ return -ENODEV; }
+
 static inline struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
 	struct thermal_cooling_device *cdev, int trip)
-- 
2.17.1

