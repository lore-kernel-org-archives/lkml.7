Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC6C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F782067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jU5Rkt5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfJLGxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJLGxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so14052098wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fQ6eXPgRmlE7QGLNLnLPlmdGjpBQkjzBBl5+6F7Plow=;
        b=jU5Rkt5CwB2Du/Izd0rvUMrNTYl9HEaywmBiUBUFvNDZQsYZ/Cndo7r4wzeHZeIDLD
         oqwHjIA5jt/MArvAd9DQ4RRs8BQoswRY8SZdq/LloTX46frlz4BHmM2fXhqhkgQ+Py87
         gqQ1ZwJjNg0igFl/2fYpefAMB+v/1rG6x9gSxSlRjVOmqzKQ6grihz/vAgqApwBjkZJE
         a4l9E5EMIPdnZDOch1UDcDA42xBfHYQiBdhEdY/YYncYhRTfzRq3/KXlmyRr5wJ17hBV
         HrPfjfBOt8X3dFvItCzme5S2m+rJ6gCGkLG+iPTvsCqJe31onu/m4L++r/AG98qiPToc
         Fv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fQ6eXPgRmlE7QGLNLnLPlmdGjpBQkjzBBl5+6F7Plow=;
        b=kq66XDMS1osCow6WMsLSJW19srN6RZOk2ooepcriZ+hi5kL+0jx2t2sQmeAiGP/HT5
         aBOcc8ZteMyQysGwRUU0Dmobs6Lc0SaU6jR7oeW2uNhGmpwr5W5X6jnrGMtiFgmWYe14
         na5zJW5ADzonUOV0OfcCvtJsvmi+nADm8alwFsN9si0ZKSQE6nq3+qms6rYN6tlrRH5j
         4KMeczpOXdiEfxh/sDbb/U7YBNNutOJe0xIP+47pSwxewI5HcggMBDahPxSAg5fDoCSr
         5q6TQ/Dx7RZcHYWvzPYBJQiUr0zDyymVyFf9Qc2SZpGFYEiZcPMY8xZG9IyARejHv73O
         aLOw==
X-Gm-Message-State: APjAAAU+QZeTMgrajBjBdiPHXw6SKQphvLoof8rBf7rYkmZZeo8w9/3P
        1NpEi+o8Ok3ttZFySvxLvpeM2A==
X-Google-Smtp-Source: APXvYqzaOIyDjy7+Z2K/tCHPciYbgcwG4Xp1G7o1F4bQvEUm/3grxzCzaQ02XbFr4tCjAXNBddAOiQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr16898131wrw.182.1570863182430;
        Fri, 11 Oct 2019 23:53:02 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 01/11] thermal: Move default governor config option to the internal header
Date:   Sat, 12 Oct 2019 08:52:45 +0200
Message-Id: <20191012065255.23249-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default governor set at compilation time is a thermal internal
business, no need to export to the global thermal header.

Move the config options to the internal header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 11 +++++++++++
 include/linux/thermal.h        | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 207b0cda70da..f1206d67047f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -12,6 +12,17 @@
 #include <linux/device.h>
 #include <linux/thermal.h>
 
+/* Default Thermal Governor */
+#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
+#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
+#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
+#define DEFAULT_THERMAL_GOVERNOR       "user_space"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
+#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
+#endif
+
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c75920..a389d4621814 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -43,17 +43,6 @@
 #define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
 #define MILLICELSIUS_TO_DECI_KELVIN(t) MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, 2732)
 
-/* Default Thermal Governor */
-#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
-#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
-#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
-#define DEFAULT_THERMAL_GOVERNOR       "user_space"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
-#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
-#endif
-
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
-- 
2.17.1

