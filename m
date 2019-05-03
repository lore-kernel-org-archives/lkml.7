Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D5C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1412087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iLMy2Lbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfECRsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:48:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:48:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43HmK8J2845299
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 10:48:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43HmK8J2845299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556905701;
        bh=4+ckTtPbMORPhFYjpg2pFzQJAlYuwjP392LAUnNvpQE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iLMy2LbtFV36LwfrOcDB3xkqyHuVxtqg4ING5NMI91aZyj/NrJQ2fWYXRrNYwfoCl
         9XicAx7dIGl6ipK83gZwOFRBS5sd/9Dqk5DERjfSufh0L3iLNoAbkxkzvupVWmpQMs
         PF0F00jnf7WuIb9j4hXFnImzCNlRhP3grNzGTRoaozK7Vu9wlwjQvlgUV1E9z/TY09
         5IiQBJkvN0Nh7K507cxQi+C94gb2HK99NR5yVlzbuCoia9Lj8MjyGRya7gnA0wX/rg
         eTmz8kzucbA0d2lPlbHrZMCYyBctXtLBIBLuW0/F/Bksy/u348Rl+7b107IjYct/lH
         SRLOQhRCirARA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43HmKuE2845296;
        Fri, 3 May 2019 10:48:20 -0700
Date:   Fri, 3 May 2019 10:48:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5@git.kernel.org>
Cc:     npiggin@gmail.com, tglx@linutronix.de, rafael.j.wysocki@intel.com,
        fweisbec@gmail.com, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: hpa@zytor.com, npiggin@gmail.com, fweisbec@gmail.com,
          rafael.j.wysocki@intel.com, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190411033448.20842-6-npiggin@gmail.com>
References: <20190411033448.20842-6-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] nohz_full: Allow the boot CPU to be nohz_full
Git-Commit-ID: 08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5
Gitweb:     https://git.kernel.org/tip/08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:48 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 19:42:58 +0200

nohz_full: Allow the boot CPU to be nohz_full

Allow the boot CPU/CPU0 to be nohz_full. Have the boot CPU take the
do_timer duty during boot until a housekeeping CPU can take over.

This is supported when CONFIG_PM_SLEEP_SMP is not configured, or when
it is configured and the arch allows suspend on non-zero CPUs.

nohz_full has been trialed at a large supercomputer site and found to
significantly reduce jitter. In order to deploy it in production, they
need CPU0 to be nohz_full because their job control system requires
the application CPUs to start from 0, and the housekeeping CPUs are
placed higher. An equivalent job scheduling that uses CPU0 for
housekeeping could be achieved by modifying their system, but it is
preferable if nohz_full can support their environment without
modification.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-6-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index df401463a191..e49e8091f9ac 100644
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
index 6fa52cd6df0b..4aa917acbe1c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -121,10 +121,16 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
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
+#ifdef CONFIG_NO_HZ_FULL
+		WARN_ON(tick_nohz_full_running);
+#endif
 		tick_do_timer_cpu = cpu;
+	}
 #endif
 
 	/* Check, if the jiffies need an update */
@@ -395,8 +401,8 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
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
@@ -423,12 +429,15 @@ void __init tick_nohz_init(void)
 		return;
 	}
 
-	cpu = smp_processor_id();
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP) &&
+			!IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU)) {
+		cpu = smp_processor_id();
 
-	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
-			cpu);
-		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
+			pr_warn("NO_HZ: Clearing %d from nohz_full range "
+				"for timekeeping\n", cpu);
+			cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		}
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
@@ -904,8 +913,13 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
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
 
