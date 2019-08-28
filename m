Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040EF2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfH1KQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfH1KQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v07-0000FY-Mb; Wed, 28 Aug 2019 12:16:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 55FFC1C07D2;
        Wed, 28 Aug 2019 12:16:26 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:26 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Create a container struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.819418976@linutronix.de>
References: <20190821192920.819418976@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738620.5737.2354001941349917643.tip-bot2@tip-bot2>
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

Commit-ID:     2b69942f9021bf75bd1b001f53bd2578361fadf3
Gitweb:        https://git.kernel.org/tip/2b69942f9021bf75bd1b001f53bd2578361fadf3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:33 +02:00

posix-cpu-timers: Create a container struct

Per task/process data of posix CPU timers is all over the place which
makes the code hard to follow and requires ifdeffery.

Create a container to hold all this information in one place, so data is
consolidated and the ifdeffery can be confined to the posix timer header
file and removed from places like fork.

As a first step, move the cpu_timers list head array into the new struct
and clean up the initializers and simplify fork. The remaining #ifdef in
fork will be removed later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.819418976@linutronix.de

---
 include/linux/init_task.h      | 11 +-----------
 include/linux/posix-timers.h   | 34 +++++++++++++++++++++++++++++++++-
 include/linux/sched.h          |  4 +++-
 include/linux/sched/signal.h   |  5 +++--
 kernel/fork.c                  | 11 ++++-------
 kernel/time/posix-cpu-timers.c | 20 +++++++++----------
 6 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 6049baa..2c620d7 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -36,17 +36,6 @@ extern struct cred init_cred;
 #define INIT_PREV_CPUTIME(x)
 #endif
 
-#ifdef CONFIG_POSIX_TIMERS
-#define INIT_CPU_TIMERS(s)						\
-	.cpu_timers = {							\
-		LIST_HEAD_INIT(s.cpu_timers[0]),			\
-		LIST_HEAD_INIT(s.cpu_timers[1]),			\
-		LIST_HEAD_INIT(s.cpu_timers[2]),			\
-	},
-#else
-#define INIT_CPU_TIMERS(s)
-#endif
-
 #define INIT_TASK_COMM "swapper"
 
 /* Attach to the init_task data structure for proper alignment */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 033374b..cdef897 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -62,6 +62,40 @@ static inline int clockid_to_fd(const clockid_t clk)
 	return ~(clk >> 3);
 }
 
+#ifdef CONFIG_POSIX_TIMERS
+/**
+ * posix_cputimers - Container for posix CPU timer related data
+ * @cpu_timers:		List heads to queue posix CPU timers
+ *
+ * Used in task_struct and signal_struct
+ */
+struct posix_cputimers {
+	struct list_head	cpu_timers[CPUCLOCK_MAX];
+};
+
+static inline void posix_cputimers_init(struct posix_cputimers *pct)
+{
+	INIT_LIST_HEAD(&pct->cpu_timers[0]);
+	INIT_LIST_HEAD(&pct->cpu_timers[1]);
+	INIT_LIST_HEAD(&pct->cpu_timers[2]);
+}
+
+/* Init task static initializer */
+#define INIT_CPU_TIMERLISTS(c)	{					\
+	LIST_HEAD_INIT(c.cpu_timers[0]),				\
+	LIST_HEAD_INIT(c.cpu_timers[1]),				\
+	LIST_HEAD_INIT(c.cpu_timers[2]),				\
+}
+
+#define INIT_CPU_TIMERS(s)						\
+	.posix_cputimers = {						\
+		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
+	},
+#else
+struct posix_cputimers { };
+#define INIT_CPU_TIMERS(s)
+#endif
+
 #define REQUEUE_PENDING 1
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811..fde844a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -28,6 +28,7 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/posix-timers.h>
 #include <linux/rseq.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -878,8 +879,9 @@ struct task_struct {
 
 #ifdef CONFIG_POSIX_TIMERS
 	struct task_cputime		cputime_expires;
-	struct list_head		cpu_timers[3];
 #endif
+	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
+	struct posix_cputimers		posix_cputimers;
 
 	/* Process credentials: */
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index efd8ce7..88fbb3f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/cred.h>
 #include <linux/refcount.h>
+#include <linux/posix-timers.h>
 
 /*
  * Types defining task->signal and task->sighand and APIs using them:
@@ -151,9 +152,9 @@ struct signal_struct {
 	/* Earliest-expiration cache. */
 	struct task_cputime cputime_expires;
 
-	struct list_head cpu_timers[3];
-
 #endif
+	/* Empty if CONFIG_POSIX_TIMERS=n */
+	struct posix_cputimers posix_cputimers;
 
 	/* PID/PID hash table linkage. */
 	struct pid *pids[PIDTYPE_MAX];
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1..b6a135e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1523,6 +1523,7 @@ void __cleanup_sighand(struct sighand_struct *sighand)
  */
 static void posix_cpu_timers_init_group(struct signal_struct *sig)
 {
+	struct posix_cputimers *pct = &sig->posix_cputimers;
 	unsigned long cpu_limit;
 
 	cpu_limit = READ_ONCE(sig->rlim[RLIMIT_CPU].rlim_cur);
@@ -1531,10 +1532,7 @@ static void posix_cpu_timers_init_group(struct signal_struct *sig)
 		sig->cputimer.running = true;
 	}
 
-	/* The timer lists. */
-	INIT_LIST_HEAD(&sig->cpu_timers[0]);
-	INIT_LIST_HEAD(&sig->cpu_timers[1]);
-	INIT_LIST_HEAD(&sig->cpu_timers[2]);
+	posix_cputimers_init(pct);
 }
 #else
 static inline void posix_cpu_timers_init_group(struct signal_struct *sig) { }
@@ -1649,9 +1647,8 @@ static void posix_cpu_timers_init(struct task_struct *tsk)
 	tsk->cputime_expires.prof_exp = 0;
 	tsk->cputime_expires.virt_exp = 0;
 	tsk->cputime_expires.sched_exp = 0;
-	INIT_LIST_HEAD(&tsk->cpu_timers[0]);
-	INIT_LIST_HEAD(&tsk->cpu_timers[1]);
-	INIT_LIST_HEAD(&tsk->cpu_timers[2]);
+
+	posix_cputimers_init(&tsk->posix_cputimers);
 }
 #else
 static inline void posix_cpu_timers_init(struct task_struct *tsk) { }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b1c9766..849e204 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -407,11 +407,11 @@ static void cleanup_timers_list(struct list_head *head)
  *
  * This must be called with the siglock held.
  */
-static void cleanup_timers(struct list_head *head)
+static void cleanup_timers(struct posix_cputimers *pct)
 {
-	cleanup_timers_list(head);
-	cleanup_timers_list(++head);
-	cleanup_timers_list(++head);
+	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_PROF]);
+	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_VIRT]);
+	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_SCHED]);
 }
 
 /*
@@ -421,11 +421,11 @@ static void cleanup_timers(struct list_head *head)
  */
 void posix_cpu_timers_exit(struct task_struct *tsk)
 {
-	cleanup_timers(tsk->cpu_timers);
+	cleanup_timers(&tsk->posix_cputimers);
 }
 void posix_cpu_timers_exit_group(struct task_struct *tsk)
 {
-	cleanup_timers(tsk->signal->cpu_timers);
+	cleanup_timers(&tsk->signal->posix_cputimers);
 }
 
 static inline int expires_gt(u64 expires, u64 new_exp)
@@ -446,10 +446,10 @@ static void arm_timer(struct k_itimer *timer)
 	struct cpu_timer_list *next;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->cpu_timers;
+		head = p->posix_cputimers.cpu_timers;
 		cputime_expires = &p->cputime_expires;
 	} else {
-		head = p->signal->cpu_timers;
+		head = p->signal->posix_cputimers.cpu_timers;
 		cputime_expires = &p->signal->cputime_expires;
 	}
 	head += CPUCLOCK_WHICH(timer->it_clock);
@@ -773,8 +773,8 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
+	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
 	struct task_cputime *tsk_expires = &tsk->cputime_expires;
-	struct list_head *timers = tsk->cpu_timers;
 	u64 expires, stime, utime;
 	unsigned long soft;
 
@@ -879,9 +879,9 @@ static void check_process_timers(struct task_struct *tsk,
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
+	struct list_head *timers = sig->posix_cputimers.cpu_timers;
 	u64 utime, ptime, virt_expires, prof_expires;
 	u64 sum_sched_runtime, sched_expires;
-	struct list_head *timers = sig->cpu_timers;
 	struct task_cputime cputime;
 	unsigned long soft;
 
