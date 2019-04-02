Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68911C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D02E206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGKBpiXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfDBQNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:13:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43919 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbfDBQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:13:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so17377370wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rC/ruLPUV5UEP+tXqVjLuNudKLQamQwxbTKse0K/0qM=;
        b=fGKBpiXECn3PUfZEtCWv6t7IAoERdhQ3rv1YWI3q+hPmQrrwyoIBI9E2KDkyLKLb20
         mN6v0Ct3jlI1NzMEoqSzyto8FKxHzBzZFRgWekYwwoEOoxFxMY37xRD0grOLirPz2G84
         nK8XVGY+Bm7pvlwYoWQ7CP1c+qPnf3YhnlzscmUL4ToMBhqjp2OU0r4z4VteL8zcisNL
         qTI25MO5r3adMTI4ecvXeNdL+YRC1KTZ5d8AIFb0jy1SQktIzrYLbCsCxZkq6d8RLfVK
         CRyQr0VthPwHO0oh/ktXNLCTRRHh4yW9EVijYPa/KHTt9yMl5bf0aVh2CsVAAy0/FUh9
         NrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rC/ruLPUV5UEP+tXqVjLuNudKLQamQwxbTKse0K/0qM=;
        b=rJblJbqGiy9NNoVYIPrDOR1Pq0ikh4obs+APl+kJFDgl6TDCAX7AKGVnRh3WDDU9eQ
         NcJhC7lzL3euUESJgopaVRsJPUW+DSHvbHUWZJgaW/3IhDc4T0RvgLGe0ABH0Jb6JYlR
         gFZVFiP1Bvceyv7Er93QaVcMTsaSSo9tg4c4hZFDjV4hnnbNK1ZMjOqDVoi/zKk39T/9
         spZpwJvjTxW8FWf37I2G3tgkJUEq1l1QfcfZW1gj2EHINLOK6p9uvogLnfk7ArVlTBMD
         wmrS0rmxGAN5MEttOdrVNLPaQ8ybDLf+tMXS+JtTTxhxS6DN6M/c0rAkUNPbLVy4WQQ7
         AOYA==
X-Gm-Message-State: APjAAAUy13GN7DXHJE7JtBXSSKRo/CQwDH/7LzAtkbxxwUB/nLIK/262
        b/yjivD3BspuZ7lQy6OAWmRvj9ZODfhzQw==
X-Google-Smtp-Source: APXvYqxosNL2IXziQlPxrkWgyCS8FSPHGBhAvNCX2KSHWxAXSBwlcQzJESXzSm3Z50U03dQI5F0UeA==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr34299806wrs.250.1554221622685;
        Tue, 02 Apr 2019 09:13:42 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:13:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] thermal/drivers/core: Use governor table to initialize
Date:   Tue,  2 Apr 2019 18:12:47 +0200
Message-Id: <20190402161256.11044-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the governor table is in place and the macro allows to browse the
table, declare the governor so the entry is added in the governor table
in the init section.

The [un]register_thermal_governors function does no longer need to use the
exported [un]register thermal governor's specific function which in turn
call the [un]register_thermal_governor. The governors are fully
self-encapsulated.

The cyclic dependency is no longer needed, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/fair_share.c      | 12 +-------
 drivers/thermal/gov_bang_bang.c   | 11 +------
 drivers/thermal/power_allocator.c | 11 +------
 drivers/thermal/step_wise.c       | 11 +------
 drivers/thermal/thermal_core.c    | 51 +++++++++++++++++--------------
 drivers/thermal/thermal_core.h    | 40 ------------------------
 drivers/thermal/user_space.c      | 12 +-------
 7 files changed, 33 insertions(+), 115 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index d3469fbc5207..bda2afc63471 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -129,14 +129,4 @@ static struct thermal_governor thermal_gov_fair_share = {
 	.name		= "fair_share",
 	.throttle	= fair_share_throttle,
 };
-
-int thermal_gov_fair_share_register(void)
-{
-	return thermal_register_governor(&thermal_gov_fair_share);
-}
-
-void thermal_gov_fair_share_unregister(void)
-{
-	thermal_unregister_governor(&thermal_gov_fair_share);
-}
-
+THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index fc5e5057f0de..c5e19c7d63da 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -126,13 +126,4 @@ static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
 	.throttle	= bang_bang_control,
 };
-
-int thermal_gov_bang_bang_register(void)
-{
-	return thermal_register_governor(&thermal_gov_bang_bang);
-}
-
-void thermal_gov_bang_bang_unregister(void)
-{
-	thermal_unregister_governor(&thermal_gov_bang_bang);
-}
+THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3055f9a12a17..44636475b2a3 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -651,13 +651,4 @@ static struct thermal_governor thermal_gov_power_allocator = {
 	.unbind_from_tz	= power_allocator_unbind,
 	.throttle	= power_allocator_throttle,
 };
-
-int thermal_gov_power_allocator_register(void)
-{
-	return thermal_register_governor(&thermal_gov_power_allocator);
-}
-
-void thermal_gov_power_allocator_unregister(void)
-{
-	thermal_unregister_governor(&thermal_gov_power_allocator);
-}
+THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ee047ca43084..6cd251ab56fc 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -218,13 +218,4 @@ static struct thermal_governor thermal_gov_step_wise = {
 	.name		= "step_wise",
 	.throttle	= step_wise_throttle,
 };
-
-int thermal_gov_step_wise_register(void)
-{
-	return thermal_register_governor(&thermal_gov_step_wise);
-}
-
-void thermal_gov_step_wise_unregister(void)
-{
-	thermal_unregister_governor(&thermal_gov_step_wise);
-}
+THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 28f7ece0e8fe..50c88682a848 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -243,36 +243,41 @@ int thermal_build_list_of_policies(char *buf)
 	return count;
 }
 
-static int __init thermal_register_governors(void)
+static void __init thermal_unregister_governors(void)
 {
-	int result;
+	struct thermal_governor **governor;
 
-	result = thermal_gov_step_wise_register();
-	if (result)
-		return result;
+	for_each_governor_table(governor)
+		thermal_unregister_governor(*governor);
+}
 
-	result = thermal_gov_fair_share_register();
-	if (result)
-		return result;
+static int __init thermal_register_governors(void)
+{
+	int ret = 0;
+	struct thermal_governor **governor;
 
-	result = thermal_gov_bang_bang_register();
-	if (result)
-		return result;
+	for_each_governor_table(governor) {
+		ret = thermal_register_governor(*governor);
+		if (ret) {
+			pr_err("Failed to register governor: '%s'",
+			       (*governor)->name);
+			break;
+		}
 
-	result = thermal_gov_user_space_register();
-	if (result)
-		return result;
+		pr_info("Registered thermal governor '%s'",
+			(*governor)->name);
+	}
 
-	return thermal_gov_power_allocator_register();
-}
+	if (ret) {
+		struct thermal_governor **gov;
+		for_each_governor_table(gov) {
+			if (gov == governor)
+				break;
+			thermal_unregister_governor(*gov);
+		}
+	}
 
-static void __init thermal_unregister_governors(void)
-{
-	thermal_gov_step_wise_unregister();
-	thermal_gov_fair_share_unregister();
-	thermal_gov_bang_bang_unregister();
-	thermal_gov_user_space_unregister();
-	thermal_gov_power_allocator_unregister();
+	return ret;
 }
 
 /*
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 28d18083e969..a3c555b48eb3 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -90,46 +90,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 				    unsigned long new_state) {}
 #endif /* CONFIG_THERMAL_STATISTICS */
 
-#ifdef CONFIG_THERMAL_GOV_STEP_WISE
-int thermal_gov_step_wise_register(void);
-void thermal_gov_step_wise_unregister(void);
-#else
-static inline int thermal_gov_step_wise_register(void) { return 0; }
-static inline void thermal_gov_step_wise_unregister(void) {}
-#endif /* CONFIG_THERMAL_GOV_STEP_WISE */
-
-#ifdef CONFIG_THERMAL_GOV_FAIR_SHARE
-int thermal_gov_fair_share_register(void);
-void thermal_gov_fair_share_unregister(void);
-#else
-static inline int thermal_gov_fair_share_register(void) { return 0; }
-static inline void thermal_gov_fair_share_unregister(void) {}
-#endif /* CONFIG_THERMAL_GOV_FAIR_SHARE */
-
-#ifdef CONFIG_THERMAL_GOV_BANG_BANG
-int thermal_gov_bang_bang_register(void);
-void thermal_gov_bang_bang_unregister(void);
-#else
-static inline int thermal_gov_bang_bang_register(void) { return 0; }
-static inline void thermal_gov_bang_bang_unregister(void) {}
-#endif /* CONFIG_THERMAL_GOV_BANG_BANG */
-
-#ifdef CONFIG_THERMAL_GOV_USER_SPACE
-int thermal_gov_user_space_register(void);
-void thermal_gov_user_space_unregister(void);
-#else
-static inline int thermal_gov_user_space_register(void) { return 0; }
-static inline void thermal_gov_user_space_unregister(void) {}
-#endif /* CONFIG_THERMAL_GOV_USER_SPACE */
-
-#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
-int thermal_gov_power_allocator_register(void);
-void thermal_gov_power_allocator_unregister(void);
-#else
-static inline int thermal_gov_power_allocator_register(void) { return 0; }
-static inline void thermal_gov_power_allocator_unregister(void) {}
-#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
-
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 8e92a06ef48a..5fac99e5221d 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -56,14 +56,4 @@ static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
 };
-
-int thermal_gov_user_space_register(void)
-{
-	return thermal_register_governor(&thermal_gov_user_space);
-}
-
-void thermal_gov_user_space_unregister(void)
-{
-	thermal_unregister_governor(&thermal_gov_user_space);
-}
-
+THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
-- 
2.17.1

