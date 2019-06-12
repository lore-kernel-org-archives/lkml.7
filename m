Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245EDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF07F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hycc4AFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfFLUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:13:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35074 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfFLUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:13:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so18305318wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrmwYmseyI81svrde0Rr2oIWo/3RlcrMJfQXdcGN0wc=;
        b=hycc4AFmNBd3iCrgBCvwcW73IW9t0fXQWjFMf8HKUFOs05iYwvP2TJNV0gb7cclKVf
         xe6z1gODNFL3Mt9N6FMkD/wwaTBm4OaYFYIp0beAEsuQ0D81JJTR6HHKNNdPIvHBZiKW
         PzQCP5h2LKEnNUV/c5bQjPd6WPtPiWIQJXaH4nP3MPkh1KwwEj/D8dnM7qSpa0KfWuN5
         HsU8SXj4+r4OEr7o0KsKvjqfYLyriGoZ/pZpwvjpfuVrXhho97mnUyequ7fj8jTWG+WD
         z6ZNWww7mUtWx59Y4S4m1dQMcwmYt3XAaYAD9aHZhxghnEkNLus3N/XkWj5tr0Oe3Xsf
         nL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrmwYmseyI81svrde0Rr2oIWo/3RlcrMJfQXdcGN0wc=;
        b=tATZukIQcetYYMQxe4hHBa/COs9QweacUOphX1PwdDpuLtVdyptSQjSod8sd81vu8k
         hzsEFF3lx3ArWDf6jwDbR/IN2Tnk6l8k5kiA4muMhjnjBvsxo35K65KaU4usQgHW6VpE
         VyTzDBH54tY2UWyCrC42oX3icmctsKa5xaQ+PcetY6lstO8fXyjH4wpQ+Ufa37Yy47Sx
         ZPUp4tP90c+MWID8OClyRNpW35tOz/fs9gYXxm9FBxmWeMesBWtmGz8hFdu2vwqPk0zt
         xd9Q/8w8UzWmjIwFIsAWfJ5w5sVH37qiZ5QHy7k6AqrCcKkurcR6hSHPJpp47gTMRWwD
         7ZAw==
X-Gm-Message-State: APjAAAVH6Cr+bagK6luZLf6nQx5JWhHlkgkutyv/cvGik136LNjT4ALp
        docNW+PxBXGr9TeMQBMU8eNLBQ==
X-Google-Smtp-Source: APXvYqz7DIAmKSXQbKZle0WtdzNIdjQ1mFKvamHzPP6lnKS8wkI3kMS/tWsmbdX8u5cjTIl48G4X3Q==
X-Received: by 2002:adf:ff86:: with SMTP id j6mr23986979wrr.318.1560370423295;
        Wed, 12 Jun 2019 13:13:43 -0700 (PDT)
Received: from mai.imgcgcw.net (237.65.130.77.rev.sfr.net. [77.130.65.237])
        by smtp.gmail.com with ESMTPSA id l8sm1119566wrg.40.2019.06.12.13.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:13:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 2/2] thermal/drivers/core: Use governor table to initialize
Date:   Wed, 12 Jun 2019 22:13:25 +0200
Message-Id: <20190612201325.1150-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612201325.1150-1-daniel.lezcano@linaro.org>
References: <20190612201325.1150-1-daniel.lezcano@linaro.org>
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

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/fair_share.c      | 12 +------
 drivers/thermal/gov_bang_bang.c   | 11 +------
 drivers/thermal/power_allocator.c | 11 +------
 drivers/thermal/step_wise.c       | 11 +------
 drivers/thermal/thermal_core.c    | 52 +++++++++++++++++--------------
 drivers/thermal/thermal_core.h    | 40 ------------------------
 drivers/thermal/user_space.c      | 12 +------
 7 files changed, 34 insertions(+), 115 deletions(-)

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
index 3ac0e2b564e2..533530529607 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -243,36 +243,42 @@ int thermal_build_list_of_policies(char *buf)
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
 
-static void __init thermal_unregister_governors(void)
-{
-	thermal_gov_step_wise_unregister();
-	thermal_gov_fair_share_unregister();
-	thermal_gov_bang_bang_unregister();
-	thermal_gov_user_space_unregister();
-	thermal_gov_power_allocator_unregister();
+		for_each_governor_table(gov) {
+			if (gov == governor)
+				break;
+			thermal_unregister_governor(*gov);
+		}
+	}
+
+	return ret;
 }
 
 /*
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index be901e84aa65..cb423b97ef01 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -89,46 +89,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
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

