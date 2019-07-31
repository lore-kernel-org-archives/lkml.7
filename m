Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AA4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BFB2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vxSpLiSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfGaR4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:56:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32893 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfGaR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:56:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHtL5x3777215
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:55:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHtL5x3777215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595721;
        bh=T1ILyo/EzeOcsHSxBCqrjuJ/2yciUWatAK4ngKfQAd0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vxSpLiSYmnZTgDSsBrfFPKQNhfPY28EYp94ECFx9PxKLC1VPnjJouOLgAhKCJPaVv
         PgHxXovxiy5mVFn4+HcCWHZpR9kyEAz9QOZ9Mdb5DGnr67igg+hggRvHltdoq62vlu
         t34U3n4FDl0q0Fqo+vWYAVmvo89vdXzbBMT/+XMUG5s454Pmzs97r3Ek5LE7QH3w0P
         JR3Q54eLEm1giru/0xByQxxr4ZGiPHEk8JYZj7DfNZ/Zs6yGtRNaTgYTuO8Rlc1n+k
         ymPPD6j7TShU4v5MlWgE0Bhio83rlJChPtro/JYOCwBSvSvFXs5mVxGr7A0++2h4TA
         J7bjX/3PjSd8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHtKia3777212;
        Wed, 31 Jul 2019 10:55:20 -0700
Date:   Wed, 31 Jul 2019 10:55:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c1a280b68d4e6b6db4a65aa7865c22d8789ddf09@git.kernel.org>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        mhiramat@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, paulmck@linux.ibm.com, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, rostedt@goodmis.org,
          mhiramat@kernel.org, linux-kernel@vger.kernel.org,
          paulmck@linux.ibm.com, hpa@zytor.com, tglx@linutronix.de,
          pbonzini@redhat.com, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20190726212124.117528401@linutronix.de>
References: <20190726212124.117528401@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] sched/preempt: Use CONFIG_PREEMPTION where
 appropriate
Git-Commit-ID: c1a280b68d4e6b6db4a65aa7865c22d8789ddf09
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

Commit-ID:  c1a280b68d4e6b6db4a65aa7865c22d8789ddf09
Gitweb:     https://git.kernel.org/tip/c1a280b68d4e6b6db4a65aa7865c22d8789ddf09
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:37 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:34 +0200

sched/preempt: Use CONFIG_PREEMPTION where appropriate

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the preemption code, scheduler and init task over to use
CONFIG_PREEMPTION.

That's the first step towards RT in that area. The more complex changes are
coming separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.117528401@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/preempt.h |  4 ++--
 include/linux/preempt.h       |  6 +++---
 include/linux/sched.h         |  6 +++---
 init/init_task.c              |  2 +-
 init/main.c                   |  2 +-
 kernel/sched/core.c           | 14 +++++++-------
 kernel/sched/fair.c           |  2 +-
 kernel/sched/sched.h          |  4 ++--
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index c3046c920063..d683f5e6d791 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -78,11 +78,11 @@ static __always_inline bool should_resched(int preempt_offset)
 			tif_need_resched());
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index dd92b1a93919..bbb68dba37cc 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -182,7 +182,7 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #define preempt_enable() \
 do { \
 	barrier(); \
@@ -203,7 +203,7 @@ do { \
 		__preempt_schedule(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT */
+#else /* !CONFIG_PREEMPTION */
 #define preempt_enable() \
 do { \
 	barrier(); \
@@ -217,7 +217,7 @@ do { \
 } while (0)
 
 #define preempt_check_resched() do { } while (0)
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 #define preempt_disable_notrace() \
 do { \
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..6947516a2d3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1767,7 +1767,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 extern int _cond_resched(void);
 #else
 static inline int _cond_resched(void) { return 0; }
@@ -1796,12 +1796,12 @@ static inline void cond_resched_rcu(void)
 
 /*
  * Does a critical section need to be broken due to another
- * task waiting?: (technically does not depend on CONFIG_PREEMPT,
+ * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
  * but a general need for low latency)
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	return spin_is_contended(lock);
 #else
 	return 0;
diff --git a/init/init_task.c b/init/init_task.c
index 7ab773b9b3cd..bfe06c53b14e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,7 +174,7 @@ struct task_struct init_task
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.ret_stack	= NULL,
 #endif
-#if defined(CONFIG_TRACING) && defined(CONFIG_PREEMPT)
+#if defined(CONFIG_TRACING) && defined(CONFIG_PREEMPTION)
 	.trace_recursion = 0,
 #endif
 #ifdef CONFIG_LIVEPATCH
diff --git a/init/main.c b/init/main.c
index 96f8d5af52d6..653693da8da6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -433,7 +433,7 @@ noinline void __ref rest_init(void)
 
 	/*
 	 * Enable might_sleep() and smp_processor_id() checks.
-	 * They cannot be enabled earlier because with CONFIG_PREEMPT=y
+	 * They cannot be enabled earlier because with CONFIG_PREEMPTION=y
 	 * kernel_thread() would trigger might_sleep() splats. With
 	 * CONFIG_PREEMPT_VOLUNTARY=y the init task might have scheduled
 	 * already, but it's stuck on the kthreadd_done completion.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..604a5e137efe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3581,7 +3581,7 @@ static inline void sched_tick_start(int cpu) { }
 static inline void sched_tick_stop(int cpu) { }
 #endif
 
-#if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
+#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
 /*
  * If the value passed in is equal to the current preempt count
@@ -3782,7 +3782,7 @@ again:
  *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
  *      called on the nearest possible occasion:
  *
- *       - If the kernel is preemptible (CONFIG_PREEMPT=y):
+ *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
  *
  *         - in syscall or exception context, at the next outmost
  *           preempt_enable(). (this might be as soon as the wake_up()'s
@@ -3791,7 +3791,7 @@ again:
  *         - in IRQ context, return from interrupt-handler to
  *           preemptible context
  *
- *       - If the kernel is not preemptible (CONFIG_PREEMPT is not set)
+ *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
  *         then at the next:
  *
  *          - cond_resched() call
@@ -4033,7 +4033,7 @@ static void __sched notrace preempt_schedule_common(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 /*
  * this is the entry point to schedule() from in-kernel preemption
  * off of preempt_enable. Kernel preemptions off return from interrupt
@@ -4105,7 +4105,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 /*
  * this is the entry point to schedule() from kernel preemption
@@ -5416,7 +5416,7 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 int __sched _cond_resched(void)
 {
 	if (should_resched(0)) {
@@ -5433,7 +5433,7 @@ EXPORT_SYMBOL(_cond_resched);
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
  * call schedule, and on return reacquire the lock.
  *
- * This works OK both with and without CONFIG_PREEMPT. We do strange low-level
+ * This works OK both with and without CONFIG_PREEMPTION. We do strange low-level
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..aff9d76d8d65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7430,7 +7430,7 @@ static int detach_tasks(struct lb_env *env)
 		detached++;
 		env->imbalance -= load;
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		/*
 		 * NEWIDLE balancing is a source of latency, so preemptible
 		 * kernels will stop after the first task is detached to minimize
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..f2ce6ba1c5d5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1943,7 +1943,7 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
 
@@ -1995,7 +1995,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	return ret;
 }
 
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 /*
  * double_lock_balance - lock the busiest runqueue, this_rq is locked already.
