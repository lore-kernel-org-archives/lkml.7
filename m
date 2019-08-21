Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28BC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313DB22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld4Yk4lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHUB1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:27:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfHUB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:27:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so292034pfd.2;
        Tue, 20 Aug 2019 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8peS1wx9mCHCsJ/G8o4t9CHWs55Os1v5lM45cTTAng=;
        b=ld4Yk4lYwM9/nXxo4T/5z1mn5aM6W9cMBOR1v5yMU5YYhA+Rc9wyGLI6RI72xmblqP
         2dHSK/fi02Cbf3xZ2uGAXclT37ToBjlBL5/frHZQI5I11C7F7lkd6nZqQv1W4kOwtQPf
         Sx4c9bNDHKdTXQ5WBxi0/KbHTQdESd2AvuMIJ4SpiMBXqoefvv8i3GBigrQcYZiGzRBU
         2wrIyVHRlhj6SSZIJ84+R9nvkN7rEMrkATz7/k+44mOCaoH4vVEOiLbi/rXtbMDynbhB
         jpvP6+Q1d1zQlPMYshA96cwVrigjNQQ9jXOSgwRyeD/CowtdMqnHpF133XQKDAdVYpsO
         QEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8peS1wx9mCHCsJ/G8o4t9CHWs55Os1v5lM45cTTAng=;
        b=MTPWAtuhCzlWcK/2uKge50vZfaZJaZuhP6wQ00Xvw2ZJ8/X/iiBGJ+YF7gQGuGTS9l
         oqO+pExnFLNZrm1cP5kTyR6hcTTO1SJL3mPkjAt0OGd2kDyz1GWRjQj7rZmQ+eDEK2i+
         EmLQgTJtv0n5k5YiWpsWf6nw0kyZujarCmfy6DEpmdQs0mApGrOnzEJ+J+/4SoWNroKl
         UTfBrGaCjiI/upvonfa+h7gO3U15VswTDFuTYOWtpnf1qq7ZG4NvtX5Q3aL9X6bUbz9j
         tJNQCZvgYmvyJsyCFi488s2Cfq9VIcJj6Xb3b0m9re0NFN1hkIq2vfBiJEYCsfexiIhC
         FAGQ==
X-Gm-Message-State: APjAAAUGz5cb+q/Nal2YPP5ld+xgs2usTHrTyUZlirFoTS6G2ALekKu+
        ea0sg+A5oC6uGoy06WaoBOy5gg61Pvg=
X-Google-Smtp-Source: APXvYqyokD0hX30U9tlyHtxvkojZvGqx/A8KgEeAKhvNv5FxjA63dhbrOFtVQmtr3qxGquX5XZJyUg==
X-Received: by 2002:a17:90a:ec07:: with SMTP id l7mr2807427pjy.39.1566350819742;
        Tue, 20 Aug 2019 18:26:59 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:59 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 11/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Tue, 20 Aug 2019 18:26:11 -0700
Message-Id: <20190821012612.7823-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
 drivers/thermal/thermal_hwmon.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b24..4e79524182e1 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	kfree(hwmon);
 }
 EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
+
+static void devm_thermal_hwmon_release(struct device *dev, void *res)
+{
+	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
+}
+
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = thermal_add_hwmon_sysfs(tz);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = tz;
+	devres_add(&tz->device, ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index a160b9d62dd0..1a9d65f6a6a8 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_THERMAL_HWMON
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
 static inline int
@@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return 0;
 }
 
+static inline int
+devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
 static inline void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
-- 
2.21.0

