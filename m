Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C8C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRYSl5Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfDDMHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfDDMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1141141pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GeZXoBMqmzTuupceIwGFvfd0pygb3Zlg1aRO1Ip9RVk=;
        b=SRYSl5SfN6Y6cMMBOqIAPXYShqY1apEl72ruqsUwys2ZIR2gomxjjKxlPFd18zrKKZ
         QWU2hctNn66mmGoRGDdUt1tkBGjT0G7zdnJEYj8+T3K8fqgI6y5ADJo/94m+En2wb8Tz
         KxgHTNrWH8BLltu0peJlyVMMXzk4fc442oB6kpgJ6riAp35FKLjWmWlvfgchzaexdvC2
         62swS2JhCu3m5QfUtpC3uAvsC4PZkxDlRgOwTjBKIaZ1g/Af/DlpCXEuSTLDRCckfxuM
         fM8L7nrVmWEXB/reYZOKLLiFZYpjEL0En8wbG/EubxhqiB6DJMmKRAPwk7OhT9qdxg57
         90gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GeZXoBMqmzTuupceIwGFvfd0pygb3Zlg1aRO1Ip9RVk=;
        b=I2A7DqYOVKrBCOwRGtrSfat1DsL3RGFyWh/Pvh1TstdTqM1WS0ZZjMh+4aVytJiqx/
         wV0s8Pqm3p3vXTuk/2jMPxqqw3R3Tn2YezpAWbZGQxM2KbLWzk53zDQsceOrIZHIlJkc
         MVRGChwqagMJAwwXxQMq/zcLAFVm/5nNMKhi4zl7zXhffjo9C5Ous0FRAV9ryOhSPb+/
         qiPbkOD5E//cBGassXngTh0zOOTidpebGfk34oI6idgmOTD5riTekOU2NlfMNgXX7uct
         cbuHfYmsajZBuqAnCvfPKRO3IpjUdbtbO0LxHjUwAy4LI0M5/Y1vQiLbL8VlVGoiJztm
         plhA==
X-Gm-Message-State: APjAAAX/4eTHISMl6gUhn3PQEMunypSPKkt6Y9RYFGyXKqt3O2cs52py
        YoOmY9g0d7zLROjtJ6EULUk=
X-Google-Smtp-Source: APXvYqxc+P6OxwCBUNKmQn2SfxKJE1s+mYQC3lwE7v7aYSiZXAqgGN1qL9KQwTsTbgClMLV8XLKRJA==
X-Received: by 2002:a63:1654:: with SMTP id 20mr5586968pgw.166.1554379650590;
        Thu, 04 Apr 2019 05:07:30 -0700 (PDT)
Received: from bobo.local0.net (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id j22sm24720668pfn.129.2019.04.04.05.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:29 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nohz_full: Allow the boot CPU to be full nohz
Date:   Thu,  4 Apr 2019 22:07:04 +1000
Message-Id: <20190404120704.18479-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404120704.18479-1-npiggin@gmail.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the boot CPU to be full nohz, and have it take the do_timer duty
temporarily during boot.

nohz_full has been successful at significantly reducing jitter for a
large supercomputer customer, but their job control system requires
CPU0 to be for housekeeping.

This will cause suspend / kexec freeze to occur on a non-boot CPU,
so the option may need to be made conditional by arch?

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 27 +++++++++++----------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 529143b4c8d2..31146c13226e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -46,6 +46,14 @@ ktime_t tick_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
+#ifdef CONFIG_NO_HZ_FULL
+/*
+ * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
+ * tick_do_timer_cpu and it should be taken over by an eligible secondary
+ * when one comes online.
+ */
+static int tick_do_timer_boot_cpu __read_mostly = -1;
+#endif
 
 /*
  * Debugging: see timer_list.c
@@ -167,6 +175,26 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static void giveup_do_timer(void *info)
+{
+	int cpu = *(unsigned int *)info;
+
+	WARN_ON(tick_do_timer_cpu != smp_processor_id());
+
+	tick_do_timer_cpu = cpu;
+}
+
+static void tick_take_do_timer_from_boot(void)
+{
+	int cpu = smp_processor_id();
+	int from = tick_do_timer_boot_cpu;
+
+	if (from >= 0 && from != cpu)
+		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
+}
+#endif
+
 /*
  * Setup the tick device
  */
@@ -186,12 +214,26 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			if (!tick_nohz_full_cpu(cpu))
-				tick_do_timer_cpu = cpu;
-			else
-				tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+			tick_do_timer_cpu = cpu;
+
 			tick_next_period = ktime_get();
 			tick_period = NSEC_PER_SEC / HZ;
+#ifdef CONFIG_NO_HZ_FULL
+			/*
+			 * The boot CPU may be nohz_full, in which case set
+			 * tick_do_timer_boot_cpu so the first housekeeping
+			 * secondary that comes up will take do_timer from
+			 * us.
+			 */
+			if (tick_nohz_full_cpu(cpu))
+				tick_do_timer_boot_cpu = cpu;
+
+		} else if (tick_do_timer_boot_cpu != -1 &&
+						!tick_nohz_full_cpu(cpu)) {
+			tick_take_do_timer_from_boot();
+			tick_do_timer_boot_cpu = -1;
+			WARN_ON(tick_do_timer_cpu != cpu);
+#endif
 		}
 
 		/*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..c0105bf4ecd9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -121,10 +121,14 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * into a long sleep. If two CPUs happen to assign themselves to
 	 * this duty, then the jiffies update is still serialized by
 	 * jiffies_lock.
+	 *
+	 * If nohz_full is enabled, this should not happen because the
+	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)
-	    && !tick_nohz_full_cpu(cpu))
+	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+		WARN_ON(tick_nohz_full_running);
 		tick_do_timer_cpu = cpu;
+	}
 #endif
 
 	/* Check, if the jiffies need an update */
@@ -395,8 +399,8 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
 	/*
-	 * The boot CPU handles housekeeping duty (unbound timers,
-	 * workqueues, timekeeping, ...) on behalf of full dynticks
+	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
@@ -423,14 +427,6 @@ void __init tick_nohz_init(void)
 		return;
 	}
 
-	cpu = smp_processor_id();
-
-	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
-			cpu);
-		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
-	}
-
 	for_each_cpu(cpu, tick_nohz_full_mask)
 		context_tracking_cpu_set(cpu);
 
@@ -904,8 +900,13 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		/*
 		 * Boot safety: make sure the timekeeping duty has been
 		 * assigned before entering dyntick-idle mode,
+		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE)
+		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
+			return false;
+
+		/* Should not happen for nohz-full */
+		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
 			return false;
 	}
 
-- 
2.20.1

