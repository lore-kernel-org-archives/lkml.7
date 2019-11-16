Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B00EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AA820700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDvYjLtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfKPNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 08:16:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfKPNQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:16:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so13908000wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBRrOeFjzqnzfONE7OUt/W61tGgjVczN6HnwGIweIMY=;
        b=cDvYjLtSsqqISLupyBqRuzfoSBOW3mxJFlXdyx1Unip7m5FZH48Kkg/f7grqZn13QW
         qeHa72WXEHUifndhqySQZsiRK+iRvTG+DAZV2oqKFKS4Ca4GxV5dgGKWkKXVS3u102+O
         ZXdGtFhk8xwb1kPwzG+pOLiUYI3Y34FAdlWZYx0c8NB8J4lGPoGUVD5gcY0aR6umhP7n
         e/7GunXSLOK7fi58FbbDsN3P10gJFd93CWJUL4oKk/e4EvkBRD4cbuwcPwCZ1vNrJiCE
         NrTqNDmOgtCCZNuH6EKGUdYwHaSsz4y6qZnb6ayjUDK/Yhcb8fxyxeHlYRDPxgHpcjkS
         hYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBRrOeFjzqnzfONE7OUt/W61tGgjVczN6HnwGIweIMY=;
        b=Lq7ds6ONHXs+ecT93NH69VG7Y5UeAjNLXdtsHg7LPtTrFivFNZ3cDX+TMBP4tn+c0d
         PrGXyL5aucn7FdgQqqbjks071zKK5mtgnVEDZfBFhWasSVuH96GPNZjWxNVwuJOg2fhr
         TUbRo0cwau0LPDxG3Iv5WbnhHEzKBEaMYXaP4rlEvaHAw2LxcPVRac9MK0abBbYWBreK
         6QDw60Vp44ZJNup+BZZJVa64znVLFjq4KEZslPJaRDaf1JuSfXADOk0iLCxRJjLme2VL
         2D1HzxZRfNWZahi6U/1P+ynN36BdX90y1H9GsK6vRbs5MeF62rmVgf73bCWpvTcvxKky
         oZEA==
X-Gm-Message-State: APjAAAWdNE68N6qrlKbuSNlxzyeWyz6u6WsuIz0SFNCOMwHTxy8B3+sJ
        d9SKYYK4pePQyVdGcGyJ/rzexw==
X-Google-Smtp-Source: APXvYqxU+Ce984OIm+gEBSmPBiLEdlT1QPAD52gaDJ94Lrikl70nHZBdVaaGDkqzmNzdcHbIPoBUVQ==
X-Received: by 2002:adf:db41:: with SMTP id f1mr19862644wrj.351.1573910180899;
        Sat, 16 Nov 2019 05:16:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:b462:d85e:9aab:bc1d])
        by smtp.gmail.com with ESMTPSA id r2sm11128914wma.44.2019.11.16.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 05:16:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V2 2/2] cpuidle: Use the latency to call find_deepest_idle_state
Date:   Sat, 16 Nov 2019 14:16:13 +0100
Message-Id: <20191116131613.15733-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191116131613.15733-1-daniel.lezcano@linaro.org>
References: <20191116131613.15733-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the dev->forced_idle_latency_limit_ns is filled with the latency
value when this function is called, use it as a parameter to the
find_deepest_idle_state() function.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 7 +++++--
 include/linux/cpuidle.h   | 6 ++++--
 kernel/sched/idle.c       | 8 +++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 62226fadc02d..a02b701fc289 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -122,9 +122,12 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
  * @dev: cpuidle device for the given CPU.
  */
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+			       struct cpuidle_device *dev,
+			       u64 latency_limit_ns)
 {
-	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
+	return find_deepest_state(drv, dev,
+				  div_u64(latency_limit_ns, NSEC_PER_USEC),
+				  0, false);
 }
 
 #ifdef CONFIG_SUSPEND
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1f3f4dd01e48..b60f35b7d53e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -207,13 +207,15 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 
 #ifdef CONFIG_CPU_IDLE
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev);
+				      struct cpuidle_device *dev,
+				      u64 latency_limit_ns);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
 extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-					     struct cpuidle_device *dev)
+					     struct cpuidle_device *dev,
+					     u64 latency_limit_ns)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0a817e907192..fd4a8747e602 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -166,6 +166,9 @@ static void cpuidle_idle_call(void)
 	 */
 
 	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
+
+		u64 latency_limit_ns = dev->forced_idle_latency_limit_ns;
+
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -176,12 +179,15 @@ static void cpuidle_idle_call(void)
 			}
 
 			rcu_idle_exit();
+
+			latency_limit_ns = U64_MAX;
 		}
 
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
-		next_state = cpuidle_find_deepest_state(drv, dev);
+		next_state = cpuidle_find_deepest_state(drv, dev,
+							latency_limit_ns);
 		call_cpuidle(drv, dev, next_state);
 	} else {
 		bool stop_tick = true;
-- 
2.17.1

