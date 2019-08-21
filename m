Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82593C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfHUTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfHUTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJt-0004Dg-RE; Wed, 21 Aug 2019 21:30:57 +0200
Message-Id: <20190821192921.105793824@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 20/38] posix-cpu-timers: Provide array based access to
 expiry cache
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct task_cputime for the expiry cache is a pretty odd choice and
comes with magic defines to rename the fields for usage in the expiry
cache.

struct task_cputime is basically a u64 array with 3 members, but it has
distinct members.

The expiry cache content is different than the content of task_cputime
because

  expiry[PROF]  = task_cputime.stime + task_cputime.utime
  expiry[VIRT]  = task_cputime.utime
  expiry[SCHED] = task_cputime.sum_exec_runtime

So there is no direct mapping between task_cputime and the expiry cache and
the #define based remapping is just a horrible hack.

Having the expiry cache array based allows further simplification of the
expiry code.

To avoid an all in one cleanup which is hard to review add a temporary
anonymous union into struct task_cputime which allows array based access to
it. That requires to reorder the members. Add a build time sanity check to
validate that the members are at the same place.

The union and the build time checks will be removed after conversion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |   24 ++++++++++++++++++------
 include/linux/sched/types.h    |    4 ++--
 kernel/time/posix-cpu-timers.c |   12 +++++++++++-
 3 files changed, 31 insertions(+), 9 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,27 +65,39 @@ static inline int clockid_to_fd(const cl
 /*
  * Alternate field names for struct task_cputime when used on cache
  * expirations. Will go away soon.
+ *
+ * stime corresponds to CLOCKCPU_PROF
+ * utime corresponds to CLOCKCPU_VIRT
+ * sum_exex_runtime corresponds to CLOCKCPU_SCHED
+ *
+ * The ordering is currently enforced so struct task_cputime and the
+ * expiries array in struct posix_cputimers are equivalent.
  */
-#define virt_exp			utime
 #define prof_exp			stime
+#define virt_exp			utime
 #define sched_exp			sum_exec_runtime
 
 #ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data
- * @cputime_expires:	Earliest-expiration cache
+ * @cputime_expires:	Earliest-expiration cache task_cputime based
+ * @expiries:		Earliest-expiration cache array based
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	struct task_cputime	cputime_expires;
-	struct list_head	cpu_timers[CPUCLOCK_MAX];
+	/* Temporary union until all users are cleaned up */
+	union {
+		struct task_cputime	cputime_expires;
+		u64			expiries[CPUCLOCK_MAX];
+	};
+	struct list_head		cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(&pct->cputime_expires, 0, sizeof(pct->cputime_expires));
+	memset(&pct->expiries, 0, sizeof(pct->expiries));
 	INIT_LIST_HEAD(&pct->cpu_timers[0]);
 	INIT_LIST_HEAD(&pct->cpu_timers[1]);
 	INIT_LIST_HEAD(&pct->cpu_timers[2]);
@@ -96,7 +108,7 @@ void posix_cputimers_group_init(struct p
 static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 					       u64 runtime)
 {
-	pct->cputime_expires.sched_exp = runtime;
+	pct->expiries[CPUCLOCK_SCHED] = runtime;
 }
 
 /* Init task static initializer */
--- a/include/linux/sched/types.h
+++ b/include/linux/sched/types.h
@@ -6,8 +6,8 @@
 
 /**
  * struct task_cputime - collected CPU time counts
- * @utime:		time spent in user mode, in nanoseconds
  * @stime:		time spent in kernel mode, in nanoseconds
+ * @utime:		time spent in user mode, in nanoseconds
  * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
  *
  * This structure groups together three kinds of CPU time that are tracked for
@@ -15,8 +15,8 @@
  * these counts together and treat all three of them in parallel.
  */
 struct task_cputime {
-	u64				utime;
 	u64				stime;
+	u64				utime;
 	unsigned long long		sum_exec_runtime;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -18,13 +18,23 @@
 
 #include "posix-timers.h"
 
+static inline void temporary_check(void)
+{
+	BUILD_BUG_ON(offsetof(struct task_cputime, stime) !=
+		     CPUCLOCK_PROF * sizeof(u64));
+	BUILD_BUG_ON(offsetof(struct task_cputime, utime) !=
+		     CPUCLOCK_VIRT * sizeof(u64));
+	BUILD_BUG_ON(offsetof(struct task_cputime, sum_exec_runtime) !=
+		     CPUCLOCK_SCHED * sizeof(u64));
+}
+
 static void posix_cpu_timer_rearm(struct k_itimer *timer);
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
 {
 	posix_cputimers_init(pct);
 	if (cpu_limit != RLIM_INFINITY)
-		pct->cputime_expires.prof_exp = cpu_limit * NSEC_PER_SEC;
+		pct->expiries[CPUCLOCK_PROF] = cpu_limit * NSEC_PER_SEC;
 }
 
 /*


