Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC369C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A3B2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTrdssA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfC0OgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:36:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44978 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfC0OgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:36:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so10128583ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5vc0Fh7WVBEgxYINTNsSBAHF75OIY/EqVtxxKOnOMeU=;
        b=MTrdssA0TPWQa4lNDrtuZYmFjZtQEp9NuJXqUFJnOAP0JcSMEATBgM9kPNKibwinXU
         +Hd+Ht+XFjZr69eWzu/wdFQb1oaxzSM3Vqkz2IVL2dBjBEZ7pHDVPXOsOEBvd6DNWL7w
         SJzA23Z7Y/BhudD2sfsUomqLtvK9Id1KfkATcOD1992bWeZAI6VG41atqyO8lZll5aL2
         7Mnp0mO3oM5kMbeq09mfXN+TdBg07KXEhJJ4V/z3osDE3X1S5YKv9uHpBJDHbWCoLxQx
         IYNKfg0a9BAn7WvEBCeEtFW4Jyh4sJGadUhX0hKXJtA4jJT9G1pIQZ7nvHwFWmBJvO6Z
         tbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5vc0Fh7WVBEgxYINTNsSBAHF75OIY/EqVtxxKOnOMeU=;
        b=oq3L5e9WB6XodMcROeVtwOnQuA6S0xm5aMSNWMCJdGfx56es1cAZlHazZjnVEFh2DD
         0bgbp84rzSzP1gM5elD0L/2GUi/01EbKOUx2SGTGh4/sCRBfJhAYYhd1eiKIgyhw+NAG
         RKuCkvUoh5W27PWo+EivZ3G7968FQJd7oRgpKxmhyG9leWykiAALmgqT7JFfygsXtj/b
         bAGL6LIQQN87yZqfruCz4OJwKh85+kzs4iWJKCwVJutSKo5pOdN5i/VvL/jaFFjX0XwU
         KOE/jeuH1BgGXq3tNVTELAYgRCAhR0HNr19rw7AZevoNn4P87R6lJV/K0u/Yu97TfbbN
         KHEw==
X-Gm-Message-State: APjAAAXGSQVco0krHYk7NoWm4pyd12Cf1uEK2x+dk0BpPBARWmSwRzed
        ePhsK1tu7CSWX1qUTEmqzdLy7g==
X-Google-Smtp-Source: APXvYqxM6qi/XDrPHpLp+RXLlmfNtCXJbY2FGNByAhSqp/7Ums1A1rJ2C5zXW0rMIhKX2jVXPoZkDA==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr19630105ljc.155.1553697361156;
        Wed, 27 Mar 2019 07:36:01 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q2sm4548789lfj.58.2019.03.27.07.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:35:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 3/4] cpuidle: Export the next timer/tick expiration for a CPU
Date:   Wed, 27 Mar 2019 15:35:47 +0100
Message-Id: <20190327143548.25305-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327143548.25305-1-ulf.hansson@linaro.org>
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to predict the sleep duration for a CPU that is entering idle,
knowing when the next timer/tick is going to expire, is extremely useful.
Both the teo and the menu cpuidle governors already makes use of this
information, while selecting an idle state.

Moving forward, the similar prediction needs to be done, but for a group of
idle CPUs rather than for a single idle CPU. Following changes implements a
new genpd governor, which needs this.

Support this, by sharing a new function called
tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
tick, whatever that expires first.

Additionally, when cpuidle is about to invoke the ->enter() callback, then
call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
struct cpuidle_device, as to make it available outside cpuidle.

Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
governor's ->select() callback has already made a decision whether to stop
the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
the next timer expiration, whatever origin.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v13:
	- As suggested by Rafael, use WRITE|READ_ONCE when writing/reading the
	next_hrtimer variable and also avoid it from containing a stale value.

---
 drivers/cpuidle/cpuidle.c | 19 +++++++++++++++++--
 include/linux/cpuidle.h   |  1 +
 include/linux/tick.h      |  7 ++++++-
 kernel/time/tick-sched.c  | 12 ++++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..0f4b7c45df3e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -328,9 +328,23 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		  int index)
 {
+	int ret = 0;
+
+	/*
+	 * Store the next hrtimer, which becomes either next tick or the next
+	 * timer event, whatever expires first. Additionally, to make this data
+	 * useful for consumers outside cpuidle, we rely on that the governor's
+	 * ->select() callback have decided, whether to stop the tick or not.
+	 */
+	WRITE_ONCE(dev->next_hrtimer, tick_nohz_get_next_hrtimer());
+
 	if (cpuidle_state_is_coupled(drv, index))
-		return cpuidle_enter_state_coupled(dev, drv, index);
-	return cpuidle_enter_state(dev, drv, index);
+		ret = cpuidle_enter_state_coupled(dev, drv, index);
+	else
+		ret = cpuidle_enter_state(dev, drv, index);
+
+	WRITE_ONCE(dev->next_hrtimer, 0);
+	return ret;
 }
 
 /**
@@ -511,6 +525,7 @@ static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
 	dev->last_residency = 0;
+	dev->next_hrtimer = 0;
 }
 
 /**
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..bb9a0db89f1a 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,6 +83,7 @@ struct cpuidle_device {
 	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	ktime_t			next_hrtimer;
 
 	int			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..8891b5ac3e40 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -122,6 +122,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
+extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -145,7 +146,11 @@ static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 static inline bool tick_nohz_idle_got_tick(void) { return false; }
-
+static inline ktime_t tick_nohz_get_next_hrtimer(void)
+{
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(ktime_get(), TICK_NSEC);
+}
 static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
 	*delta_next = TICK_NSEC;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..8d18e03124ff 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1022,6 +1022,18 @@ bool tick_nohz_idle_got_tick(void)
 	return false;
 }
 
+/**
+ * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
+ * or the tick, whatever that expires first. Note that, if the tick has been
+ * stopped, it returns the next hrtimer.
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_next_hrtimer(void)
+{
+	return __this_cpu_read(tick_cpu_device.evtdev)->next_event;
+}
+
 /**
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
  * @delta_next: duration until the next event if the tick cannot be stopped
-- 
2.17.1

