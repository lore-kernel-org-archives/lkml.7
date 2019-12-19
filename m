Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DABC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8EB2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBYavYa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLSWWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:22:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35920 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLSWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:22:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so7291160wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+EdJlshrU/x9lwXaiDsMcX871Y/B3IPP2mzwerHvxc0=;
        b=OBYavYa3Os4P3wLJqYc7ViOZC9UtFFSArzXrXdPXO3u/P6Fp+c/tZWkJ+54mrV5+Ql
         PPVp8YdxWqA59qeUMnStPysx3l+AICJR1TLM3NIVcUzMV+FaC6ciUwqpvmNt6AfUCwxW
         aqGQKQiwTUKWxaSGkfsLgiFxZfgmx5LMAd+Lz9dha6Z8sHPIQ5P8wg6ByWQid7SW+lWd
         romJPspM/EhgfAVanxijAsqNdPmyOlb15lVhMRxRIVi84XVf52/y7lS7RHyxN+Il3xsh
         9c3EqCphIVONRXpK69tJ316L7xSYrE2gXEMpR3WCKHlHVu6sWl0oQzvjwRH7mq1atxw0
         rJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+EdJlshrU/x9lwXaiDsMcX871Y/B3IPP2mzwerHvxc0=;
        b=DaSm8b/XWXl9Ko/8Kdk86MzQCUjGb9TLtlqrW/WRyn8kYVPkTAaX8iXLWzkVJQzMLC
         lZ2z55osaoT9KnqQf7KImo5N6eKjSNe349th5PrdZIP5iGEO3nT0wsY2EpRzACalieLn
         Lr0DrWFHPpRNoo/qa/2XMnbuQ8+rb7UvEOtTGbYYGGApjVIJyNXVJOLw/PY37UybGcFx
         uaJQxVTV7+IAc6cU/RzqJRVYwPkfgk6jDoH9/RGnv7Vtvhc2LYPVB5Mi99+xqOy2a+hA
         Lw+pNQlI7bWWWcobwoqvEkohXCw4a5WZK7/+08Yw2+13iCf3z1e2SAGmvyon8NL8sSOd
         llbQ==
X-Gm-Message-State: APjAAAWVK7d88xEV+WP7IXQtRJ3ry+qYrTVlSd+lcwHPtaWzLfYSagBa
        LdjTTyAz3qTawJr6wYx5vC160w==
X-Google-Smtp-Source: APXvYqxIwrQqO/WUQCmlhV0J4pjiUCYJdYEful8OM0YCNQMEt1xhhWrR6SBU+q4pjINCvhcrEuKT2w==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr12429961wmi.152.1576794126696;
        Thu, 19 Dec 2019 14:22:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id q68sm8942295wme.14.2019.12.19.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:22:06 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/drivers/of-thermal: Make of_thermal_destroy_zones static
Date:   Thu, 19 Dec 2019 23:21:52 +0100
Message-Id: <20191219222154.16100-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_thermal_destroy_zones() is only used internally by the
of_parse_thermal_zones() for rollbacking in case of error.

Make it static and tag it as an __init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/of-thermal.c   | 64 +++++++++++++++++-----------------
 drivers/thermal/thermal_core.h |  2 --
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093be553e..4333cd5f1073 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -998,6 +998,38 @@ static inline void of_thermal_free_zone(struct __thermal_zone *tz)
 	kfree(tz);
 }
 
+/**
+ * of_thermal_destroy_zones - remove all zones parsed and allocated resources
+ *
+ * Finds all zones parsed and added to the thermal framework and remove them
+ * from the system, together with their resources.
+ *
+ */
+static __init void of_thermal_destroy_zones(void)
+{
+	struct device_node *np, *child;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np) {
+		pr_debug("unable to find thermal zones\n");
+		return;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		struct thermal_zone_device *zone;
+
+		zone = thermal_zone_get_zone_by_name(child->name);
+		if (IS_ERR(zone))
+			continue;
+
+		thermal_zone_device_unregister(zone);
+		kfree(zone->tzp);
+		kfree(zone->ops);
+		of_thermal_free_zone(zone->devdata);
+	}
+	of_node_put(np);
+}
+
 /**
  * of_parse_thermal_zones - parse device tree thermal data
  *
@@ -1087,35 +1119,3 @@ int __init of_parse_thermal_zones(void)
 
 	return -ENOMEM;
 }
-
-/**
- * of_thermal_destroy_zones - remove all zones parsed and allocated resources
- *
- * Finds all zones parsed and added to the thermal framework and remove them
- * from the system, together with their resources.
- *
- */
-void of_thermal_destroy_zones(void)
-{
-	struct device_node *np, *child;
-
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np) {
-		pr_debug("unable to find thermal zones\n");
-		return;
-	}
-
-	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
-
-		zone = thermal_zone_get_zone_by_name(child->name);
-		if (IS_ERR(zone))
-			continue;
-
-		thermal_zone_device_unregister(zone);
-		kfree(zone->tzp);
-		kfree(zone->ops);
-		of_thermal_free_zone(zone->devdata);
-	}
-	of_node_put(np);
-}
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 207b0cda70da..a9bf00e91d64 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -92,14 +92,12 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
-void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
-static inline void of_thermal_destroy_zones(void) { }
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
 	return 0;
-- 
2.17.1

