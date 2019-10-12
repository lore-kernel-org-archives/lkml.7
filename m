Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADAC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB62067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfsX1wPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfJLGxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfJLGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so10776125wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e5zHV1yxkD6dbvO/5O4DOC0P97SiQKMYMWVdcBqIV28=;
        b=MfsX1wPMA6F6IS8Pcpw3SsuC+GiBazsQyIjCf6hugUalSLbHrI9BMSj60fA6l3sjka
         9XWTPWpQa0K5GHkYDjp84oOK4Gq8ToUHdePTHvmbaWIjJ4W8X6J+PJy8BXe1S1GSSXUF
         yZsxdZtVX51rWN8TiOLneS419TGoDPs5GQOQhqBzT6GqMIkKw6L78czFfUa7EQ7ujJlB
         SsHIdobSBEUQq+813GlXAd5SXsPcfbJGzAegHV5LHWV1gTneSqWImasUwKzVr72AmLoR
         uYHzLyZXA5j2+edcMmT3xVvN1fGxjhaHDOyDKPntpz4omwSIeEbSypJOvGojZWuJkHZL
         rTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e5zHV1yxkD6dbvO/5O4DOC0P97SiQKMYMWVdcBqIV28=;
        b=SV4cX/pFnVQY04mTvbvAq/Tngyvrfk6DQ2KRXfr+Uy/n8VOWpyiGKSG8bgZVpn5HMh
         mFtS6DcW1kjsGnbhUALJFa73Kdhhve+JSvDPLEqZz6I9vaoL3RBq2tCLr69oQR5rVuMj
         y0ge1r8x3b8Xjc3oNHUSsLogziJLJHswSeK9Wes8VNzFAdE9vpgchhyIdUHcLxMrgeQH
         T3dY//1EHjr6sbQxYBHnqFQOHblx7xaRrtUyzewyoO65moSHge64K99vUjPyBiEPOslB
         HgkCRVD3DevKxuChe45tKob9UFRNSM31+jXWtLDMLdaVftDXE5JXbo/6i+/qfkeCg2+h
         YFhA==
X-Gm-Message-State: APjAAAU/CmBdwnrmFP9PoadDet0YqU/YVOxalrYEnO6hqclvpzVZdUzR
        uuGMs1rbEWiW9IZ03dtFvOpXbQ==
X-Google-Smtp-Source: APXvYqwAmVof87d4Ec0oSQ3TUSiJj0A02O5HMzExy/fyCkfLvVFl+kwHvFJ7Zf7D0va6frBuKVmwOw==
X-Received: by 2002:a7b:c7c1:: with SMTP id z1mr5690097wmk.61.1570863186531;
        Fri, 11 Oct 2019 23:53:06 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 04/11] thermal: Move trip point structure definition to private header
Date:   Sat, 12 Oct 2019 08:52:48 +0200
Message-Id: <20191012065255.23249-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct thermal_trip is only used by the thermal internals, it is
pointless to export the definition in the global header.

Move the structure to the thermal_core.h internal header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 13 +++++++++++++
 include/linux/thermal.h        | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5953bb527ec2..6f6e0dcba4f2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -58,6 +58,19 @@ int power_actor_get_min_power(struct thermal_cooling_device *cdev,
 			      struct thermal_zone_device *tz, u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *ti, u32 power);
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @np: pointer to struct device_node that this trip point was created from
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	struct device_node *np;
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
 
 /*
  * This structure is used to describe the behavior of
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fae9ff2b079a..88e1faa3d72c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -343,21 +343,6 @@ struct thermal_zone_of_device_ops {
 	int (*set_trip_temp)(void *, int, int);
 };
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-
-struct thermal_trip {
-	struct device_node *np;
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *
-- 
2.17.1

