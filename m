Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95544C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227120718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt/a7IWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKNUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:49:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36802 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKNUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:49:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so8303086wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oWWPOw6fdrBRTkuHcbjpSalRr8DpkMzBATp+Y4u/Wi8=;
        b=rt/a7IWypW4wtkJoudbYLho4zeXLAf5IPNd5Ze8W+5q2lq5CjFfKrbC9nzmJDaH7Jx
         gaSXhhoNvyRV9+UBxVZViFNnyAXWrGEg3R4UHApBO2w3VKJvtvnfB0o68MDspdYPOigj
         5CGSBySyeqlk5kaeuhWx364d5OxKrB6fufaP3Owj6N79t7/i7L8+5lWG8hQyd+ahfrnd
         UZuTb7d7K2MbsBcPT5ta5ebG37ckCpzIxTxK0zgliAEi4S4zhAtYbhH1BdraLWCVw6bz
         OXQjYt68pcve1IejybTh3R5+0zdJlvdqzaotZrokJWC6y2ztJBlzUnZpkc0LqwRvKm3n
         9DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oWWPOw6fdrBRTkuHcbjpSalRr8DpkMzBATp+Y4u/Wi8=;
        b=TGVvy8hZ0vuKMffSTWaGKmACl2GujFK7iPLBhvZaC7w7foy9TVSCpoU4bqSVn7Dz8L
         N6oDkhbjoOHEzvLU7w6mbWv8BuDqzBKQiCPRwIrJq99ynbXDq0qzJJG1EMcgNu/k1xgV
         PaV9Rpfx6m36LiPx/mrkCm/m26R6h/IAG8jFKywCKBkZrZg2RGXIXWzh0GptubLqcZ7M
         bL+p2y3z0wDrPPc7TjzHhG/8UxDXaKlkAhcJEMqZaS7fHAvYcEK59Q4rXVdetXH2FaPR
         7Fo9+LFAGzJWXBh0wL8+Pvyu47GIav4Mq03Uxty3/HEqqYhbxKXIUPDINSJ26WLSjDHy
         UbUQ==
X-Gm-Message-State: APjAAAW/VUma1s5f2bMPECTG763PRiCny3mll8+aRFS2SrWf3U3htOcG
        EUj4lGbcwf4S4k7U6RjcRDdJWA==
X-Google-Smtp-Source: APXvYqytmE5xfwxigB2kpreMFO7j8tebwVLiY0a9RA5TWaq+pNFy4tQzBX6ZEZkJIgvBUvH51Fnm6g==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr8014390wru.133.1573764564226;
        Thu, 14 Nov 2019 12:49:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3115:aefb:2495:829a])
        by smtp.gmail.com with ESMTPSA id a206sm7954485wmf.15.2019.11.14.12.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:49:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V1 1/3] cpuidle: Replace use_deepest_state flag by forced_idle_latency_limit_ns
Date:   Thu, 14 Nov 2019 21:49:12 +0100
Message-Id: <20191114204914.21206-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to specify a latency constraint when choosing an idle state at
play_idle time. Instead of duplicating the information in the
structure or propagate the latency in the call stack, change the
use_deepest_state by forced_latency_limit_ns to introduce this
constraint. The idea being that when it is set, idle is forced
(i.e. no governors), but there is a latency limit for the state to
use.

A zero latency constraint means "do not use the deepest idle state
path" as the 'use_deepest_state' boolean was used in the
cpuidle_idle_call.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 10 +++++-----
 include/linux/cpuidle.h   |  6 +++---
 kernel/sched/idle.c       |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 44ae39f2b47a..62226fadc02d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -100,19 +100,19 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 
 /**
  * cpuidle_use_deepest_state - Set/clear governor override flag.
- * @enable: New value of the flag.
+ * @latency_limit_ns: A latency limit constraint
  *
- * Set/unset the current CPU to use the deepest idle state (override governors
- * going forward if set).
+ * Set/unset the current CPU to use the deepest idle state with the exit
+ * latency within @latency_limit_ns
  */
-void cpuidle_use_deepest_state(bool enable)
+void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->forced_idle_latency_limit_ns = latency_limit_ns;
 	preempt_enable();
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d23a3b1ddcf6..1f3f4dd01e48 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,7 +83,6 @@ struct cpuidle_driver_kobj;
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
 	ktime_t			next_hrtimer;
@@ -91,6 +90,7 @@ struct cpuidle_device {
 	int			last_state_idx;
 	int			last_residency;
 	u64			poll_limit_ns;
+	u64			forced_idle_latency_limit_ns;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
@@ -210,7 +210,7 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
@@ -218,7 +218,7 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..d4681b3d7074 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_deepest_state(1);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_deepest_state(0);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
-- 
2.17.1

