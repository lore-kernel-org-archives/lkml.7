Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7280F23406
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfH1KQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46412 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfH1KQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v09-0000Gr-EB; Wed, 28 Aug 2019 12:16:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AD5FD1C0DE5;
        Wed, 28 Aug 2019 12:16:27 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:27 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Provide array based access to
 expiry cache
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.105793824@linutronix.de>
References: <20190821192921.105793824@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738764.5747.1120683591684720795.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     11b8462f7e1d25f639c88949a2746a9c2667a766
Gitweb:        https://git.kernel.org/tip/11b8462f7e1d25f639c88949a2746a9c2667a766
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:35 +02:00

posix-cpu-timers: Provide array based access to expiry cache

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.105793824@linutronix.de

---
 include/linux/posix-timers.h   | 24 ++++++++++++++++++------
 include/linux/sched/types.h    |  4 ++--
 kernel/time/posix-cpu-timers.c | 12 +++++++++++-
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index a3731ba..ed0f6ec 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,27 +65,39 @@ static inline int clockid_to_fd(const clockid_t clk)
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
@@ -96,7 +108,7 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
 static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 					       u64 runtime)
 {
-	pct->cputime_expires.sched_exp = runtime;
+	pct->expiries[CPUCLOCK_SCHED] = runtime;
 }
 
 /* Init task static initializer */
diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
index 2c5c28d..3c3e049 100644
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
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 3e29d16..a38b6d0 100644
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
