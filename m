Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009BF2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVPkyn0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfHERCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:02:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53821 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbfHERCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:02:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so75470153wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+IiyIv/QVlUWmx804ezFK4A4Fw8LXcM/x4rGCJj+JDM=;
        b=WVPkyn0n5tb9CV7ZaunY6rCfNEDplgh1SISnuZcsRAd6+CwHMooFSdKdPV4FZWkP5i
         /bPMWNWAXWvsmwOdsp/ekVvEUO02IPM3PHegVGgzc6xAvr9V0VBnarnVM696ZHF5k095
         pO1BzDnCrQHrMtGcJD5M3U8bnaXZAKl/9AxbqnfwVupxSbPqscXt4Qm6Q+vSZLJfN8kB
         hpAYA6Zripmsc2Q98gFZQ35I6USKZsWvxN5Lz+ggcYuPypXUJl/xEVAOFAlhPCD0q8rh
         Jey7ftL9jsk2A63nd0drlaZ7mzT003RS2Y3OEN8/tRxfWo2XYC1ombPkQyHL8uFSeFi+
         Oz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+IiyIv/QVlUWmx804ezFK4A4Fw8LXcM/x4rGCJj+JDM=;
        b=BZF0OcsJpc1LwiW6c9gvpW6S5njefVkMVbbs4XvU7BWExl6QTBCBbFcdpWh5GQh9yF
         bcUwWhAMXi6bX/TC5aPVat+dJAkYpoqC8RiuzftMFKFHaArzoxn+ebBaj5v+4GBOPzk7
         Pg2oi+xFCp4OHJwFAp9A8qbCcI+ExXWcDEBwqrfPTX9vzuCVhuZaNqCVrfvUH/zN62kO
         VATkCOEsorYLdBU1wlCizSzG+WgS99NGWipjXkyRkCtKmUEAn2UmTSU8RLBG+HifE4Ok
         uu5GgPYYb4gC5MeYE6v8DwXXTHNuGyhGgxEC6pllIZmsNyNoz4VD7mPEnB3VvTclNqF7
         Oknw==
X-Gm-Message-State: APjAAAUwxzRPpLlwm6fam8czlvgnoS/zFHsCzirkerhMzanyM+HP5qhb
        O1hXtGNkE307JJ7xbHh/RWfkfQ==
X-Google-Smtp-Source: APXvYqzw/80pNXBne/sIiLOxE2KOrY5gRuvPAWkv5eFPOkE6QGcw7WFLB8aA/q+l2eIOYRP5G1TDkg==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr20717489wmi.80.1565024548256;
        Mon, 05 Aug 2019 10:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e5cb:2287:9bbb:b7eb])
        by smtp.gmail.com with ESMTPSA id v29sm28893685wrv.74.2019.08.05.10.02.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:02:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] cpuidle: play_idle: Make play_idle more flexible
Date:   Mon,  5 Aug 2019 19:02:06 +0200
Message-Id: <20190805170208.26873-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The play_idle function has two users, the intel powerclamp and the
idle_injection.

The idle injection cooling device uses the function via the
idle_injection powercap's APIs. Unfortunately, play_idle is currently
limited by the idle state depth, by default the deepest idle state is
selected. On the ARM[64] platforms, most of the time it is the cluster
idle state, the exit latency and the residency can be very high. That
reduces the scope of the idle injection usage because the impact on
the performances can be very significant and the idle injection would
make sense only if the frequency scaling fails to cool down the CPU by
dropping the static leakage and force the CPU to regain part of its
thermal capacity.

If the idle injection cycles are done with a shallow state like a
retention state, the cooling effect can give similar results than the
cpufreq cooling device.

In order to prepare the function to receive an idle state parameter,
let's replace the 'use_deepest_state' boolean field with 'use_state'
and use this value to enter the specific idle state.

The current code keeps the default behavior which is go to the deepest
idle state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
 include/linux/cpuidle.h   | 12 +++++-------
 kernel/sched/idle.c       |  9 ++++-----
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0895b988fa92..86fcf7278c1a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 }
 
 /**
- * cpuidle_use_deepest_state - Set/clear governor override flag.
- * @enable: New value of the flag.
+ * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
+ * @state: An integer for an idle state
  *
- * Set/unset the current CPU to use the deepest idle state (override governors
- * going forward if set).
+ * Specify an idle state the cpuidle framework must step in and bypass
+ * the idle state selection process.
  */
-void cpuidle_use_deepest_state(bool enable)
+void cpuidle_use_state(int state)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->use_state = state;
 	preempt_enable();
 }
 
 /**
  * cpuidle_find_deepest_state - Find the deepest available idle state.
- * @drv: cpuidle driver for the given CPU.
- * @dev: cpuidle device for the given CPU.
  */
-int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+int cpuidle_find_deepest_state(void)
 {
+	struct cpuidle_device *dev = cpuidle_get_device();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
 	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
 
@@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
+	dev->use_state = -1;
 	dev->last_residency = 0;
 	dev->next_hrtimer = 0;
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1a9f54eb3aa1..6c58e71a9995 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -80,9 +80,9 @@ struct cpuidle_driver_kobj;
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	unsigned int		use_state;
 	ktime_t			next_hrtimer;
 
 	int			last_state_idx;
@@ -200,19 +200,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev);
+extern int cpuidle_find_deepest_state(void);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_use_state(int state);
 #else
-static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-					     struct cpuidle_device *dev)
+static inline int cpuidle_find_deepest_state(void)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_state(int state)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b98283fc6914..c102e03dee6e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() || dev->use_state != -1) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -181,8 +181,7 @@ static void cpuidle_idle_call(void)
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
-		next_state = cpuidle_find_deepest_state(drv, dev);
-		call_cpuidle(drv, dev, next_state);
+		call_cpuidle(drv, dev, dev->use_state);
 	} else {
 		bool stop_tick = true;
 
@@ -328,7 +327,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_state(cpuidle_find_deepest_state());
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -339,7 +338,7 @@ void play_idle(unsigned long duration_us)
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_state(-1);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
-- 
2.17.1

