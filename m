Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2E22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfHSPr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfHSPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqr-0006xX-NM; Mon, 19 Aug 2019 17:45:45 +0200
Message-Id: <20190819143803.676155761@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 24/44] posix-cpu-timers: Create a container struct
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per task/process data of posix CPU timers is all over the place which
makes the code hard to follow and requires ifdeffery.

Create a container to hold all this information in one place, so data is
consolidated and the ifdeffery can be confined to the posix timer header
file and removed from places like fork.

As a first step, move the cpu_timers list head array into the new struct
and clean up the initializers and simplify fork. The remaining #ifdef in
fork will be removed later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/init_task.h      |   11 -----------
 include/linux/posix-timers.h   |   33 +++++++++++++++++++++++++++++++++
 include/linux/sched.h          |    3 ++-
 include/linux/sched/signal.h   |    4 ++--
 kernel/fork.c                  |   11 ++++-------
 kernel/time/posix-cpu-timers.c |   20 ++++++++++----------
 6 files changed, 51 insertions(+), 31 deletions(-)

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
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -62,6 +62,39 @@ static inline int clockid_to_fd(const cl
 	return ~(clk >> 3);
 }
 
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
+#ifdef CONFIG_POSIX_TIMERS
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
+#define INIT_CPU_TIMERS(s)
+#endif
+
 #define REQUEUE_PENDING 1
 
 /**
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -28,6 +28,7 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/posix-timers.h>
 #include <linux/rseq.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -878,7 +879,7 @@ struct task_struct {
 
 #ifdef CONFIG_POSIX_TIMERS
 	struct task_cputime		cputime_expires;
-	struct list_head		cpu_timers[3];
+	struct posix_cputimers		posix_cputimers;
 #endif
 
 	/* Process credentials: */
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/cred.h>
 #include <linux/refcount.h>
+#include <linux/posix-timers.h>
 
 /*
  * Types defining task->signal and task->sighand and APIs using them:
@@ -151,8 +152,7 @@ struct signal_struct {
 	/* Earliest-expiration cache. */
 	struct task_cputime cputime_expires;
 
-	struct list_head cpu_timers[3];
-
+	struct posix_cputimers posix_cputimers;
 #endif
 
 	/* PID/PID hash table linkage. */
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1523,6 +1523,7 @@ void __cleanup_sighand(struct sighand_st
  */
 static void posix_cpu_timers_init_group(struct signal_struct *sig)
 {
+	struct posix_cputimers *pct = &sig->posix_cputimers;
 	unsigned long cpu_limit;
 
 	cpu_limit = READ_ONCE(sig->rlim[RLIMIT_CPU].rlim_cur);
@@ -1531,10 +1532,7 @@ static void posix_cpu_timers_init_group(
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
@@ -1649,9 +1647,8 @@ static void posix_cpu_timers_init(struct
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
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -407,11 +407,11 @@ static void cleanup_timers_list(struct l
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
@@ -421,11 +421,11 @@ static void cleanup_timers(struct list_h
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
@@ -446,10 +446,10 @@ static void arm_timer(struct k_itimer *t
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
@@ -773,8 +773,8 @@ static inline void check_dl_overrun(stru
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
+	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
 	struct task_cputime *tsk_expires = &tsk->cputime_expires;
-	struct list_head *timers = tsk->cpu_timers;
 	u64 expires, stime, utime;
 	unsigned long soft;
 
@@ -879,9 +879,9 @@ static void check_process_timers(struct
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
+	struct list_head *timers = sig->posix_cputimers.cpu_timers;
 	u64 utime, ptime, virt_expires, prof_expires;
 	u64 sum_sched_runtime, sched_expires;
-	struct list_head *timers = sig->cpu_timers;
 	struct task_cputime cputime;
 	unsigned long soft;
 


