Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B25C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3862083B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfGZVYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:24:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfGZVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7h8-00030h-Kh; Fri, 26 Jul 2019 23:24:06 +0200
Message-Id: <20190726212124.117528401@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 1/8] preempt: Use CONFIG_PREEMPTION where appropriate
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the preemption code, scheduler and init task over to use
CONFIG_PREEMPTION.

That's the first step towards RT in that area. The more complex changes are
coming separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-generic/preempt.h |    4 ++--
 include/linux/preempt.h       |    6 +++---
 include/linux/sched.h         |    6 +++---
 init/init_task.c              |    2 +-
 init/main.c                   |    2 +-
 kernel/sched/core.c           |   14 +++++++-------
 kernel/sched/fair.c           |    2 +-
 kernel/sched/sched.h          |    4 ++--
 8 files changed, 20 insertions(+), 20 deletions(-)

--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -78,11 +78,11 @@ static __always_inline bool should_resch
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
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1759,7 +1759,7 @@ static inline int test_tsk_need_resched(
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 extern int _cond_resched(void);
 #else
 static inline int _cond_resched(void) { return 0; }
@@ -1788,12 +1788,12 @@ static inline void cond_resched_rcu(void
 
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
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3581,7 +3581,7 @@ static inline void sched_tick_start(int
 static inline void sched_tick_stop(int cpu) { }
 #endif
 
-#if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
+#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
 /*
  * If the value passed in is equal to the current preempt count
@@ -3782,7 +3782,7 @@ pick_next_task(struct rq *rq, struct tas
  *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
  *      called on the nearest possible occasion:
  *
- *       - If the kernel is preemptible (CONFIG_PREEMPT=y):
+ *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
  *
  *         - in syscall or exception context, at the next outmost
  *           preempt_enable(). (this might be as soon as the wake_up()'s
@@ -3791,7 +3791,7 @@ pick_next_task(struct rq *rq, struct tas
  *         - in IRQ context, return from interrupt-handler to
  *           preemptible context
  *
- *       - If the kernel is not preemptible (CONFIG_PREEMPT is not set)
+ *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
  *         then at the next:
  *
  *          - cond_resched() call
@@ -4033,7 +4033,7 @@ static void __sched notrace preempt_sche
 	} while (need_resched());
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 /*
  * this is the entry point to schedule() from in-kernel preemption
  * off of preempt_enable. Kernel preemptions off return from interrupt
@@ -4105,7 +4105,7 @@ asmlinkage __visible void __sched notrac
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
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7376,7 +7376,7 @@ static int detach_tasks(struct lb_env *e
 		detached++;
 		env->imbalance -= load;
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		/*
 		 * NEWIDLE balancing is a source of latency, so preemptible
 		 * kernels will stop after the first task is detached to minimize
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1943,7 +1943,7 @@ unsigned long arch_scale_freq_capacity(i
 #endif
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
 
@@ -1995,7 +1995,7 @@ static inline int _double_lock_balance(s
 	return ret;
 }
 
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 /*
  * double_lock_balance - lock the busiest runqueue, this_rq is locked already.


