Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065BCC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997602420D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfE2V1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:27:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2V1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:27:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hW65m-0007LP-Rv; Wed, 29 May 2019 23:26:39 +0200
Date:   Wed, 29 May 2019 23:26:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.19-rt11
Message-ID: <20190529212638.g3gkor3n7xui5fhk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.19-rt11 patch set. 

Changes since v5.0.19-rt10:

  - Ignore a warning from lockdep when lockdep is disabled for different
    lock types.

  - Make the cpuidle an imx6 raw_spinlock_t.

  - Add a proper depends in Kconfig for Atmel's tclib based clocksource.
    Otherwise the allmodconfig on !ATMEL fails.

  - Revert the removal of TIMER_IRQSAFE in i915 because it is required.

  - Rework the softirq code.
    The basic idea is to have local-lock within local_bh_disable() which is
    used for synchronisation similar to mainline. With this synchronisation
    we can't have two softirqs processed in parallel on the same CPU. This
    allows to remove the extra synchronisation we had.

  - Rework the workqueue code.
    The worker_pool.lock is made to raw_spinlock_t. With this change we can
    schedule workitems from preempt-disable sections and sections with
    disabled interrupts. This change allows to remove all kthread_.*
    workarounds we used to have.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.19-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.19-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.19-rt11

The RT patch against v5.0.19 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.19-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.19-rt11.tar.xz

Sebastian

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 326e870d71239..d9ac80aa1eb0a 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -17,22 +17,22 @@
 #include "hardware.h"
 
 static int num_idle_cpus = 0;
-static DEFINE_SPINLOCK(cpuidle_lock);
+static DEFINE_RAW_SPINLOCK(cpuidle_lock);
 
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (++num_idle_cpus == num_online_cpus())
 		imx6_set_lpm(WAIT_UNCLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	cpu_do_idle();
 
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
 		imx6_set_lpm(WAIT_CLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	return index;
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index d7f4530a670a7..6a2c6bd774271 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -447,7 +447,7 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
-static void blk_queue_usage_counter_release_wrk(struct kthread_work *work)
+static void blk_queue_usage_counter_release_wrk(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, mq_pcpu_wake);
@@ -461,7 +461,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 		container_of(ref, struct request_queue, q_usage_counter);
 
 	if (wq_has_sleeper(&q->mq_freeze_wq))
-		kthread_schedule_work(&q->mq_pcpu_wake);
+		schedule_work(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(struct timer_list *t)
@@ -533,7 +533,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	spin_lock_init(&q->queue_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
-	kthread_init_work(&q->mq_pcpu_wake, blk_queue_usage_counter_release_wrk);
+	INIT_WORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_wrk);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a284ae213ec1d..fc7aefd42ae08 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,7 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread-cgroup.h>
+#include <linux/kthread.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 39cada8f205c5..470ac49501241 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -415,7 +415,7 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && ATMEL_TCLIB
 	select TIMER_OF if OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 6d22d9df6a433..fc2eeab823b70 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -461,7 +461,8 @@ int i915_sw_fence_await_dma_fence(struct i915_sw_fence *fence,
 		timer->dma = dma_fence_get(dma);
 		init_irq_work(&timer->work, irq_i915_sw_fence_work);
 
-		timer_setup(&timer->timer, timer_i915_sw_fence_wake, 0);
+		timer_setup(&timer->timer,
+			    timer_i915_sw_fence_wake, TIMER_IRQSAFE);
 		mod_timer(&timer->timer, round_jiffies_up(jiffies + timeout));
 
 		func = dma_i915_sw_fence_wake_timer;
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 53fa8167da8e0..3912526ead664 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -22,7 +22,6 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
-#include <linux/interrupt.h>
 
 #define DRIVER_NAME "rockchip-spi"
 
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 82f21fd4afb0d..1ef937d799e4f 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -29,7 +29,6 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
-#include <linux/kthread.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
@@ -330,7 +329,7 @@ static void pkg_thermal_schedule_work(int cpu, struct delayed_work *work)
 	schedule_delayed_work_on(cpu, work, ms);
 }
 
-static void pkg_thermal_notify_work(struct kthread_work *work)
+static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
 	struct pkg_device *pkgdev;
@@ -349,33 +348,9 @@ static void pkg_thermal_notify_work(struct kthread_work *work)
 	}
 
 	spin_unlock_irqrestore(&pkg_temp_lock, flags);
-}
-
-#ifdef CONFIG_PREEMPT_RT_FULL
-static DEFINE_KTHREAD_WORK(notify_work, pkg_thermal_notify_work);
-
-static int pkg_thermal_notify(u64 msr_val)
-{
-	kthread_schedule_work(&notify_work);
 	return 0;
 }
 
-static void pkg_thermal_notify_flush(void)
-{
-	kthread_flush_work(&notify_work);
-}
-
-#else  /* !CONFIG_PREEMPT_RT_FULL */
-
-static void pkg_thermal_notify_flush(void) { }
-
-static int pkg_thermal_notify(u64 msr_val)
-{
-	pkg_thermal_notify_work(NULL);
-	return 0;
-}
-#endif /* CONFIG_PREEMPT_RT_FULL */
-
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int pkgid = topology_logical_package_id(cpu);
@@ -573,7 +548,6 @@ static void __exit pkg_temp_thermal_exit(void)
 	platform_thermal_package_rate_control = NULL;
 
 	cpuhp_remove_state(pkg_thermal_hp_state);
-	pkg_thermal_notify_flush();
 	debugfs_remove_recursive(debugfs);
 	kfree(packages);
 }
diff --git a/fs/aio.c b/fs/aio.c
index f2bb4f2f8959c..c6682d40adb04 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -127,7 +127,7 @@ struct kioctx {
 	long			nr_pages;
 
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
-	struct kthread_work	free_kwork;	/* see free_ioctx() */
+	struct work_struct	free_work;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -613,9 +613,9 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
  * now it's safe to cancel any that need to be.
  */
-static void free_ioctx_users_work(struct kthread_work *work)
+static void free_ioctx_users_work(struct work_struct *work)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_kwork);
+	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
 	struct aio_kiocb *req;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -637,8 +637,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 
-	kthread_init_work(&ctx->free_kwork, free_ioctx_users_work);
-	kthread_schedule_work(&ctx->free_kwork);
+	INIT_WORK(&ctx->free_work, free_ioctx_users_work);
+	schedule_work(&ctx->free_work);
 }
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e317bb02a1a0c..76c61318fda5b 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -20,7 +20,7 @@
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
 #include <linux/atomic.h>
-#include <linux/kthread-cgroup.h>
+#include <linux/kthread.h>
 #include <linux/fs.h>
 
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c416c7358f388..3acd725729ca7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -550,7 +550,7 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
-	struct kthread_work	mq_pcpu_wake;
+	struct work_struct	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 40dd5ef9c154b..dbafa27af0efe 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -5,36 +5,7 @@
 #include <linux/preempt.h>
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-
-extern void __local_bh_disable(void);
-extern void _local_bh_enable(void);
-extern void __local_bh_enable(void);
-
-static inline void local_bh_disable(void)
-{
-	__local_bh_disable();
-}
-
-static inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
-{
-	__local_bh_disable();
-}
-
-static inline void local_bh_enable(void)
-{
-	__local_bh_enable();
-}
-
-static inline void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
-{
-	__local_bh_enable();
-}
-
-static inline void local_bh_enable_ip(unsigned long ip)
-{
-	__local_bh_enable();
-}
-
+extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -46,6 +17,7 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 	barrier();
 }
 #endif
+#endif
 
 static inline void local_bh_disable(void)
 {
@@ -64,6 +36,5 @@ static inline void local_bh_enable(void)
 {
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
-#endif
 
 #endif /* _LINUX_BH_H */
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 4f4a33d9eb700..120d1d40704bc 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -159,7 +159,6 @@ struct cgroup_subsys_state {
 
 	/* percpu_ref killing and RCU release */
 	struct work_struct destroy_work;
-	struct kthread_work destroy_kwork;
 	struct rcu_work destroy_rwork;
 
 	/*
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 8bcd190042b93..9329de0d8bfdd 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,7 +13,6 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
-#include <linux/kthread.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -62,7 +61,6 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
- * IRQF_NO_SOFTIRQ_CALL - Do not process softirqs in the irq thread context (RT)
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -76,7 +74,6 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
-#define IRQF_NO_SOFTIRQ_CALL	0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
@@ -239,11 +236,7 @@ extern void resume_device_irqs(void);
 struct irq_affinity_notify {
 	unsigned int irq;
 	struct kref kref;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	struct kthread_work work;
-#else
 	struct work_struct work;
-#endif
 	void (*notify)(struct irq_affinity_notify *, const cpumask_t *mask);
 	void (*release)(struct kref *ref);
 };
@@ -520,11 +513,10 @@ struct softirq_action
 	void	(*action)(struct softirq_action *);
 };
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
-static inline void thread_do_softirq(void) { do_softirq(); }
-#ifdef __ARCH_HAS_DO_SOFTIRQ
+
+#if defined(__ARCH_HAS_DO_SOFTIRQ) && !defined(CONFIG_PREEMPT_RT_FULL)
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
@@ -532,48 +524,22 @@ static inline void do_softirq_own_stack(void)
 	__do_softirq();
 }
 #endif
-#else
-extern void thread_do_softirq(void);
-#endif
 
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
-#ifdef CONFIG_PREEMPT_RT_FULL
-extern void __raise_softirq_irqoff_ksoft(unsigned int nr);
-#else
-static inline void __raise_softirq_irqoff_ksoft(unsigned int nr)
-{
-	__raise_softirq_irqoff(nr);
-}
-#endif
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 extern void softirq_check_pending_idle(void);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
-DECLARE_PER_CPU(struct task_struct *, ktimer_softirqd);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
 {
 	return this_cpu_read(ksoftirqd);
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-static inline bool task_is_ktimer_softirqd(struct task_struct *tsk)
-{
-	return tsk == this_cpu_read(ktimer_softirqd);
-}
-
-#else
-static inline bool task_is_ktimer_softirqd(struct task_struct *tsk)
-{
-	return false;
-}
-
-#endif
-
 /* Tasklets --- multithreaded analogue of BHs.
 
    Main feature differing them of generic softirqs: tasklet
@@ -587,9 +553,8 @@ static inline bool task_is_ktimer_softirqd(struct task_struct *tsk)
      to be executed on some cpu at least once after this.
    * If the tasklet is already scheduled, but its execution is still not
      started, it will be executed only once.
-   * If this tasklet is already running on another CPU, it is rescheduled
-     for later.
-   * Schedule must not be called from the tasklet itself (a lockup occurs)
+   * If this tasklet is already running on another CPU (or schedule is called
+     from tasklet itself), it is rescheduled for later.
    * Tasklet is strictly serialized wrt itself, but not
      wrt another tasklets. If client needs some intertask synchronization,
      he makes it with spinlocks.
@@ -614,36 +579,27 @@ struct tasklet_struct name = { NULL, 0, ATOMIC_INIT(1), func, data }
 enum
 {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
-	TASKLET_STATE_RUN,	/* Tasklet is running (SMP only) */
-	TASKLET_STATE_PENDING	/* Tasklet is pending */
+	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-#define TASKLET_STATEF_SCHED	(1 << TASKLET_STATE_SCHED)
-#define TASKLET_STATEF_RUN	(1 << TASKLET_STATE_RUN)
-#define TASKLET_STATEF_PENDING	(1 << TASKLET_STATE_PENDING)
-
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
+#ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-static inline int tasklet_tryunlock(struct tasklet_struct *t)
-{
-	return cmpxchg(&t->state, TASKLET_STATEF_RUN, 0) == TASKLET_STATEF_RUN;
-}
-
 static inline void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
 	clear_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-extern void tasklet_unlock_wait(struct tasklet_struct *t);
-
+static inline void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+}
 #else
 #define tasklet_trylock(t) 1
-#define tasklet_tryunlock(t)	1
 #define tasklet_unlock_wait(t) do { } while (0)
 #define tasklet_unlock(t) do { } while (0)
 #endif
@@ -677,18 +633,17 @@ static inline void tasklet_disable(struct tasklet_struct *t)
 	smp_mb();
 }
 
-extern void tasklet_enable(struct tasklet_struct *t);
+static inline void tasklet_enable(struct tasklet_struct *t)
+{
+	smp_mb__before_atomic();
+	atomic_dec(&t->count);
+}
+
 extern void tasklet_kill(struct tasklet_struct *t);
 extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-extern void softirq_early_init(void);
-#else
-static inline void softirq_early_init(void) { }
-#endif
-
 struct tasklet_hrtimer {
 	struct hrtimer		timer;
 	struct tasklet_struct	tasklet;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f0daff29f07f5..def2b2aac8b17 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -70,7 +70,6 @@ enum irqchip_irq_state;
  * IRQ_IS_POLLED		- Always polled by another interrupt. Exclude
  *				  it from the spurious interrupt detection
  *				  mechanism and from core side polling.
- * IRQ_NO_SOFTIRQ_CALL		- No softirq processing in the irq thread context (RT)
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  */
 enum {
@@ -98,14 +97,13 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
-	IRQ_NO_SOFTIRQ_CALL	= (1 << 20),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_NO_SOFTIRQ_CALL)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
diff --git a/include/linux/kthread-cgroup.h b/include/linux/kthread-cgroup.h
deleted file mode 100644
index 53d34bca9d724..0000000000000
--- a/include/linux/kthread-cgroup.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_KTHREAD_CGROUP_H
-#define _LINUX_KTHREAD_CGROUP_H
-#include <linux/kthread.h>
-#include <linux/cgroup.h>
-
-#ifdef CONFIG_BLK_CGROUP
-void kthread_associate_blkcg(struct cgroup_subsys_state *css);
-struct cgroup_subsys_state *kthread_blkcg(void);
-#else
-static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
-static inline struct cgroup_subsys_state *kthread_blkcg(void)
-{
-	return NULL;
-}
-#endif
-#endif
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index d06f97bc6abb6..3d9d834c66a25 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -4,6 +4,7 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -196,12 +197,14 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
-extern struct kthread_worker kthread_global_worker;
-void kthread_init_global_worker(void);
-
-static inline bool kthread_schedule_work(struct kthread_work *work)
+#ifdef CONFIG_BLK_CGROUP
+void kthread_associate_blkcg(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_blkcg(void);
+#else
+static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_blkcg(void)
 {
-	return kthread_queue_work(&kthread_global_worker, work);
+	return NULL;
 }
-
+#endif
 #endif /* _LINUX_KTHREAD_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 946727b56fb8c..6a4884268f4c9 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -51,11 +51,7 @@
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 #define NMI_OFFSET	(1UL << NMI_SHIFT)
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-# define SOFTIRQ_DISABLE_OFFSET	(0)
-#else
-# define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
-#endif
+#define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
 
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
@@ -84,12 +80,12 @@
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
 				 | NMI_MASK))
-#ifndef CONFIG_PREEMPT_RT_FULL
-# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-# define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+long softirq_count(void);
+
 #else
-# define softirq_count()	((unsigned long)current->softirq_nestcnt)
-extern int in_serving_softirq(void);
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #endif
 
 /*
@@ -108,6 +104,7 @@ extern int in_serving_softirq(void);
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
 #define in_nmi()		(preempt_count() & NMI_MASK)
 #define in_task()		(!(preempt_count() & \
 				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 89a89f697c337..2cf422db5d18d 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -76,8 +76,7 @@ struct psi_group {
 	u64 total_prev[NR_PSI_STATES - 1];
 	u64 last_update;
 	u64 next_update;
-	struct work_struct clock_work;
-	struct timer_list clock_work_timer;
+	struct delayed_work clock_work;
 
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_STATES - 1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66611189e10e0..e1ea2ea52feb0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1211,8 +1211,6 @@ struct task_struct {
 #endif
 #ifdef CONFIG_PREEMPT_RT_BASE
 	struct rcu_head			put_rcu;
-	int				softirq_nestcnt;
-	unsigned int			softirqs_raised;
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
 # if defined CONFIG_HIGHMEM || defined CONFIG_X86_32
@@ -1424,7 +1422,6 @@ extern struct pid *cad_pid;
 /*
  * Per process flags
  */
-#define PF_IN_SOFTIRQ		0x00000001      /* Task is serving softirq */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
 #define PF_EXITPIDONE		0x00000008	/* PI exit done on shut down */
diff --git a/include/linux/swait.h b/include/linux/swait.h
index f426a0661aa03..21ae66cd41d30 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -299,4 +299,18 @@ do {									\
 	__ret;								\
 })
 
+#define __swait_event_lock_irq(wq, condition, lock, cmd)		\
+	___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,		\
+		       raw_spin_unlock_irq(&lock);			\
+		       cmd;						\
+		       schedule();					\
+		       raw_spin_lock_irq(&lock))
+
+#define swait_event_lock_irq(wq_head, condition, lock)			\
+	do {								\
+		if (condition)						\
+			break;						\
+		__swait_event_lock_irq(wq_head, condition, lock, );	\
+	} while (0)
+
 #endif /* _LINUX_SWAIT_H */
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e156321..546aa73fba6a4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -455,10 +455,6 @@ __alloc_workqueue_key(const char *fmt, unsigned int flags, int max_active,
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
-struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask);
-void free_workqueue_attrs(struct workqueue_attrs *attrs);
-int apply_workqueue_attrs(struct workqueue_struct *wq,
-			  const struct workqueue_attrs *attrs);
 int workqueue_set_unbound_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
diff --git a/init/main.c b/init/main.c
index db43c1bfc51e9..05d4d5f46e763 100644
--- a/init/main.c
+++ b/init/main.c
@@ -567,7 +567,6 @@ asmlinkage __visible void __init start_kernel(void)
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-	softirq_early_init();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 	boot_cpu_hotplug_init();
 
@@ -1120,7 +1119,6 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();
-	kthread_init_global_worker();
 
 	init_mm_internals();
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 294a71214e29e..f84bf28f36ba8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4697,10 +4697,10 @@ static void css_free_rwork_fn(struct work_struct *work)
 	}
 }
 
-static void css_release_work_fn(struct kthread_work *work)
+static void css_release_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_kwork);
+		container_of(work, struct cgroup_subsys_state, destroy_work);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
@@ -4760,8 +4760,8 @@ static void css_release(struct percpu_ref *ref)
 	struct cgroup_subsys_state *css =
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
-	kthread_init_work(&css->destroy_kwork, css_release_work_fn);
-	kthread_schedule_work(&css->destroy_kwork);
+	INIT_WORK(&css->destroy_work, css_release_work_fn);
+	queue_work(cgroup_destroy_wq, &css->destroy_work);
 }
 
 static void init_and_link_css(struct cgroup_subsys_state *css,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad73596b619d3..d211ac45fd300 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -259,12 +259,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 
 	if (desc->affinity_notify) {
 		kref_get(&desc->affinity_notify->kref);
-
-#ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_schedule_work(&desc->affinity_notify->work);
-#else
 		schedule_work(&desc->affinity_notify->work);
-#endif
 	}
 	irqd_set(data, IRQD_AFFINITY_SET);
 
@@ -302,8 +297,10 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 }
 EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
 
-static void _irq_affinity_notify(struct irq_affinity_notify *notify)
+static void irq_affinity_notify(struct work_struct *work)
 {
+	struct irq_affinity_notify *notify =
+		container_of(work, struct irq_affinity_notify, work);
 	struct irq_desc *desc = irq_to_desc(notify->irq);
 	cpumask_var_t cpumask;
 	unsigned long flags;
@@ -325,25 +322,6 @@ static void _irq_affinity_notify(struct irq_affinity_notify *notify)
 	kref_put(&notify->kref, notify->release);
 }
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-
-static void irq_affinity_notify(struct kthread_work *work)
-{
-	struct irq_affinity_notify *notify =
-		container_of(work, struct irq_affinity_notify, work);
-	_irq_affinity_notify(notify);
-}
-
-#else
-
-static void irq_affinity_notify(struct work_struct *work)
-{
-	struct irq_affinity_notify *notify =
-		container_of(work, struct irq_affinity_notify, work);
-	_irq_affinity_notify(notify);
-}
-#endif
-
 /**
  *	irq_set_affinity_notifier - control notification of IRQ affinity changes
  *	@irq:		Interrupt for which to enable/disable notification
@@ -372,11 +350,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	if (notify) {
 		notify->irq = irq;
 		kref_init(&notify->kref);
-#ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_init_work(&notify->work, irq_affinity_notify);
-#else
 		INIT_WORK(&notify->work, irq_affinity_notify);
-#endif
 	}
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -385,11 +359,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
-#else
 		cancel_work_sync(&old_notify->work);
-#endif
 		kref_put(&old_notify->kref, old_notify->release);
 	}
 
@@ -968,15 +938,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
-	/*
-	 * Interrupts which have real time requirements can be set up
-	 * to avoid softirq processing in the thread handler. This is
-	 * safe as these interrupts do not raise soft interrupts.
-	 */
-	if (irq_settings_no_softirq_call(desc))
-		_local_bh_enable();
-	else
-		local_bh_enable();
+	local_bh_enable();
 	return ret;
 }
 
@@ -1492,9 +1454,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 		}
 
-		if (new->flags & IRQF_NO_SOFTIRQ_CALL)
-			irq_settings_set_no_softirq_call(desc);
-
 		if (irq_settings_can_autoenable(desc)) {
 			irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 		} else {
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 47e2f9e23586f..e43795cd2ccfb 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,7 +17,6 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
-	_IRQ_NO_SOFTIRQ_CALL	= IRQ_NO_SOFTIRQ_CALL,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -32,7 +31,6 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
-#define IRQ_NO_SOFTIRQ_CALL	GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -43,16 +41,6 @@ irq_settings_clr_and_set(struct irq_desc *desc, u32 clr, u32 set)
 	desc->status_use_accessors |= (set & _IRQF_MODIFY_MASK);
 }
 
-static inline bool irq_settings_no_softirq_call(struct irq_desc *desc)
-{
-	return desc->status_use_accessors & _IRQ_NO_SOFTIRQ_CALL;
-}
-
-static inline void irq_settings_set_no_softirq_call(struct irq_desc *desc)
-{
-	desc->status_use_accessors |= _IRQ_NO_SOFTIRQ_CALL;
-}
-
 static inline bool irq_settings_is_per_cpu(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_PER_CPU;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b9c1c66e48967..5373355412672 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -20,7 +20,6 @@
 #include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
-#include <linux/cgroup.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -1182,19 +1181,6 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
-DEFINE_KTHREAD_WORKER(kthread_global_worker);
-EXPORT_SYMBOL(kthread_global_worker);
-
-__init void kthread_init_global_worker(void)
-{
-	kthread_global_worker.task = kthread_create(kthread_worker_fn,
-						    &kthread_global_worker,
-						    "kswork");
-	if (WARN_ON(IS_ERR(kthread_global_worker.task)))
-		return;
-	wake_up_process(kthread_global_worker.task);
-}
-
 #ifdef CONFIG_BLK_CGROUP
 /**
  * kthread_associate_blkcg - associate blkcg to current kthread
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cd18804e529df..59ce9b0ebf04b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -699,7 +699,8 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE(class->name != lock->name &&
+				     lock->key != &__lockdep_no_validate__);
 			return class;
 		}
 	}
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 02c5abf9f5817..928fe5893a57d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -441,8 +441,7 @@ static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
 		rnp->rew.rew_func = func;
-		if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) ||
-		    !READ_ONCE(rcu_par_gp_wq) ||
+		if (!READ_ONCE(rcu_par_gp_wq) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No workqueues yet or last leaf, do direct call. */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b102221d780cd..4306fa1eb60f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3583,6 +3583,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	if (!tsk->state)
 		return;
+
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b59c557cca0af..0e97ca9306efc 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -124,7 +124,6 @@
  * sampling of the aggregate task states would be.
  */
 
-#include <linux/sched.h>
 #include "../workqueue_internal.h"
 #include <linux/sched/loadavg.h>
 #include <linux/seq_file.h>
@@ -132,6 +131,7 @@
 #include <linux/seqlock.h>
 #include <linux/cgroup.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/psi.h>
 #include "sched.h"
 
@@ -166,7 +166,6 @@ static struct psi_group psi_system = {
 };
 
 static void psi_update_work(struct work_struct *work);
-static void psi_sched_update_work(struct timer_list *t);
 
 static void group_init(struct psi_group *group)
 {
@@ -175,8 +174,7 @@ static void group_init(struct psi_group *group)
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->next_update = sched_clock() + psi_period;
-	INIT_WORK(&group->clock_work, psi_update_work);
-	timer_setup(&group->clock_work_timer, psi_sched_update_work, 0);
+	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
 	mutex_init(&group->stat_lock);
 }
 
@@ -369,14 +367,14 @@ static bool update_stats(struct psi_group *group)
 	return nonidle_total;
 }
 
-static void psi_sched_delayed_work(struct psi_group *group, unsigned long delay);
-
 static void psi_update_work(struct work_struct *work)
 {
+	struct delayed_work *dwork;
 	struct psi_group *group;
 	bool nonidle;
 
-	group = container_of(work, struct psi_group, clock_work);
+	dwork = to_delayed_work(work);
+	group = container_of(dwork, struct psi_group, clock_work);
 
 	/*
 	 * If there is task activity, periodically fold the per-cpu
@@ -395,7 +393,7 @@ static void psi_update_work(struct work_struct *work)
 		now = sched_clock();
 		if (group->next_update > now)
 			delay = nsecs_to_jiffies(group->next_update - now) + 1;
-		psi_sched_delayed_work(group, delay);
+		schedule_delayed_work(dwork, delay);
 	}
 }
 
@@ -509,20 +507,6 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 	return &psi_system;
 }
 
-static void psi_sched_update_work(struct timer_list *t)
-{
-	struct psi_group *group = from_timer(group, t, clock_work_timer);
-
-	schedule_work(&group->clock_work);
-}
-
-static void psi_sched_delayed_work(struct psi_group *group, unsigned long delay)
-{
-	if (!timer_pending(&group->clock_work_timer) &&
-	    !work_pending(&group->clock_work))
-		mod_timer(&group->clock_work_timer, delay);
-}
-
 void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
@@ -556,14 +540,10 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		     wq_worker_last_func(task) == psi_update_work))
 		wake_clock = false;
 
-	if (wake_clock) {
-		if (task_is_ktimer_softirqd(task))
-			wake_clock = false;
-	}
 	while ((group = iterate_groups(task, &iter))) {
 		psi_group_change(group, cpu, clear, set);
-		if (wake_clock)
-			psi_sched_delayed_work(group, PSI_FREQ);
+		if (wake_clock && !delayed_work_pending(&group->clock_work))
+			schedule_delayed_work(&group->clock_work, PSI_FREQ);
 	}
 }
 
@@ -660,8 +640,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	del_timer_sync(&cgroup->psi.clock_work_timer);
-	cancel_work_sync(&cgroup->psi.clock_work);
+	cancel_delayed_work_sync(&cgroup->psi.clock_work);
 	free_percpu(cgroup->psi.pcpu);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4a9c845ba3f7e..473369122ddd0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -21,14 +21,12 @@
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
-#include <linux/delay.h>
 #include <linux/ftrace.h>
 #include <linux/smp.h>
 #include <linux/smpboot.h>
 #include <linux/tick.h>
-#include <linux/locallock.h>
 #include <linux/irq.h>
-#include <linux/sched/types.h>
+#include <linux/locallock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -59,136 +57,12 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
-#ifdef CONFIG_PREEMPT_RT_FULL
-#define TIMER_SOFTIRQS ((1 << TIMER_SOFTIRQ) | (1 << HRTIMER_SOFTIRQ))
-DEFINE_PER_CPU(struct task_struct *, ktimer_softirqd);
-#endif
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
 };
 
-#ifdef CONFIG_NO_HZ_COMMON
-# ifdef CONFIG_PREEMPT_RT_FULL
-
-struct softirq_runner {
-	struct task_struct *runner[NR_SOFTIRQS];
-};
-
-static DEFINE_PER_CPU(struct softirq_runner, softirq_runners);
-
-static inline void softirq_set_runner(unsigned int sirq)
-{
-	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
-
-	sr->runner[sirq] = current;
-}
-
-static inline void softirq_clr_runner(unsigned int sirq)
-{
-	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
-
-	sr->runner[sirq] = NULL;
-}
-
-static bool softirq_check_runner_tsk(struct task_struct *tsk,
-				     unsigned int *pending)
-{
-	bool ret = false;
-
-	if (!tsk)
-		return ret;
-
-	/*
-	 * The wakeup code in rtmutex.c wakes up the task
-	 * _before_ it sets pi_blocked_on to NULL under
-	 * tsk->pi_lock. So we need to check for both: state
-	 * and pi_blocked_on.
-	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
-	 * task does cpu_chill().
-	 */
-	raw_spin_lock(&tsk->pi_lock);
-	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
-	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
-		/* Clear all bits pending in that task */
-		*pending &= ~(tsk->softirqs_raised);
-		ret = true;
-	}
-	raw_spin_unlock(&tsk->pi_lock);
-
-	return ret;
-}
-
-/*
- * On preempt-rt a softirq running context might be blocked on a
- * lock. There might be no other runnable task on this CPU because the
- * lock owner runs on some other CPU. So we have to go into idle with
- * the pending bit set. Therefor we need to check this otherwise we
- * warn about false positives which confuses users and defeats the
- * whole purpose of this test.
- *
- * This code is called with interrupts disabled.
- */
-void softirq_check_pending_idle(void)
-{
-	struct task_struct *tsk;
-	static int rate_limit;
-	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
-	u32 warnpending;
-	int i;
-
-	if (rate_limit >= 10)
-		return;
-
-	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
-	if (!warnpending)
-		return;
-	for (i = 0; i < NR_SOFTIRQS; i++) {
-		tsk = sr->runner[i];
-
-		if (softirq_check_runner_tsk(tsk, &warnpending))
-			warnpending &= ~(1 << i);
-	}
-
-	if (warnpending) {
-		tsk = __this_cpu_read(ksoftirqd);
-		softirq_check_runner_tsk(tsk, &warnpending);
-	}
-
-	if (warnpending) {
-		tsk = __this_cpu_read(ktimer_softirqd);
-		softirq_check_runner_tsk(tsk, &warnpending);
-	}
-
-	if (warnpending) {
-		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
-		       warnpending);
-		rate_limit++;
-	}
-}
-# else
-/*
- * On !PREEMPT_RT we just printk rate limited:
- */
-void softirq_check_pending_idle(void)
-{
-	static int ratelimit;
-
-	if (ratelimit < 10 &&
-	    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-		pr_warn("NOHZ: local_softirq_pending %02x\n",
-			(unsigned int) local_softirq_pending());
-		ratelimit++;
-	}
-}
-# endif
-
-#else /* !CONFIG_NO_HZ_COMMON */
-static inline void softirq_set_runner(unsigned int sirq) { }
-static inline void softirq_clr_runner(unsigned int sirq) { }
-#endif
-
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
@@ -204,38 +78,6 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-static void wakeup_timer_softirqd(void)
-{
-	/* Interrupts are disabled: no need to stop preemption */
-	struct task_struct *tsk = __this_cpu_read(ktimer_softirqd);
-
-	if (tsk && tsk->state != TASK_RUNNING)
-		wake_up_process(tsk);
-}
-
-#endif
-
-static void handle_softirq(unsigned int vec_nr)
-{
-	struct softirq_action *h = softirq_vec + vec_nr;
-	int prev_count;
-
-	prev_count = preempt_count();
-
-	kstat_incr_softirqs_this_cpu(vec_nr);
-
-	trace_softirq_entry(vec_nr);
-	h->action(h);
-	trace_softirq_exit(vec_nr);
-	if (unlikely(prev_count != preempt_count())) {
-		pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
-		       vec_nr, softirq_to_name[vec_nr], h->action,
-		       prev_count, preempt_count());
-		preempt_count_set(prev_count);
-	}
-}
-
 #ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
@@ -251,48 +93,7 @@ static bool ksoftirqd_running(unsigned long pending)
 		return false;
 	return tsk && (tsk->state == TASK_RUNNING);
 }
-
-static inline int ksoftirqd_softirq_pending(void)
-{
-	return local_softirq_pending();
-}
-
-static void handle_pending_softirqs(u32 pending)
-{
-	struct softirq_action *h = softirq_vec;
-	int softirq_bit;
-
-	local_irq_enable();
-
-	h = softirq_vec;
-
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
-
-		h += softirq_bit - 1;
-		vec_nr = h - softirq_vec;
-		handle_softirq(vec_nr);
-
-		h++;
-		pending >>= softirq_bit;
-	}
-
-	if (__this_cpu_read(ksoftirqd) == current)
-		rcu_softirq_qs();
-	local_irq_disable();
-}
-
-static void run_ksoftirqd(unsigned int cpu)
-{
-	local_irq_disable();
-	if (ksoftirqd_softirq_pending()) {
-		__do_softirq();
-		local_irq_enable();
-		cond_resched();
-		return;
-	}
-	local_irq_enable();
-}
+#endif
 
 /*
  * preempt_count and SOFTIRQ_OFFSET usage:
@@ -304,6 +105,101 @@ static void run_ksoftirqd(unsigned int cpu)
  * softirq and whether we just have bh disabled.
  */
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static DEFINE_LOCAL_IRQ_LOCK(bh_lock);
+static DEFINE_PER_CPU(long, softirq_counter);
+
+long softirq_count(void)
+{
+	return raw_cpu_read(softirq_counter);
+}
+EXPORT_SYMBOL(softirq_count);
+
+void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+{
+	unsigned long __maybe_unused flags;
+	long soft_cnt;
+
+	WARN_ON_ONCE(in_irq());
+	if (!in_atomic())
+		local_lock(bh_lock);
+	soft_cnt = this_cpu_inc_return(softirq_counter);
+	WARN_ON_ONCE(soft_cnt == 0);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	local_irq_save(flags);
+	if (soft_cnt == 1)
+		trace_softirqs_off(ip);
+	local_irq_restore(flags);
+#endif
+}
+EXPORT_SYMBOL(__local_bh_disable_ip);
+
+static void local_bh_disable_rt(void)
+{
+	local_bh_disable();
+}
+
+void _local_bh_enable(void)
+{
+	unsigned long __maybe_unused flags;
+	long soft_cnt;
+
+	soft_cnt = this_cpu_dec_return(softirq_counter);
+	WARN_ON_ONCE(soft_cnt < 0);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	local_irq_save(flags);
+	if (soft_cnt == 0)
+		trace_softirqs_on(_RET_IP_);
+	local_irq_restore(flags);
+#endif
+
+	if (!in_atomic())
+		local_unlock(bh_lock);
+}
+
+void _local_bh_enable_rt(void)
+{
+	_local_bh_enable();
+}
+
+void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+{
+	u32 pending;
+	long count;
+
+	WARN_ON_ONCE(in_irq());
+	lockdep_assert_irqs_enabled();
+
+	local_irq_disable();
+	count = this_cpu_read(softirq_counter);
+
+	if (unlikely(count == 1)) {
+		pending = local_softirq_pending();
+		if (pending) {
+			if (!in_atomic())
+				__do_softirq();
+			else
+				wakeup_softirqd();
+		}
+		trace_softirqs_on(ip);
+	}
+	count = this_cpu_dec_return(softirq_counter);
+	WARN_ON_ONCE(count < 0);
+	local_irq_enable();
+
+	if (!in_atomic())
+		local_unlock(bh_lock);
+
+	preempt_check_resched();
+}
+EXPORT_SYMBOL(__local_bh_enable_ip);
+
+#else
+static void local_bh_disable_rt(void) { }
+static void _local_bh_enable_rt(void) { }
+
 /*
  * This one is for softirq.c-internal use,
  * where hardirqs are disabled legitimately:
@@ -398,6 +294,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
+#endif
 
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
@@ -453,8 +350,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
+	struct softirq_action *h;
 	bool in_hardirq;
 	__u32 pending;
+	int softirq_bit;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -466,14 +365,47 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+#endif
 	in_hardirq = lockdep_softirq_start();
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
 
-	handle_pending_softirqs(pending);
+	local_irq_enable();
+
+	h = softirq_vec;
+
+	while ((softirq_bit = ffs(pending))) {
+		unsigned int vec_nr;
+		int prev_count;
+
+		h += softirq_bit - 1;
+
+		vec_nr = h - softirq_vec;
+		prev_count = preempt_count();
+
+		kstat_incr_softirqs_this_cpu(vec_nr);
+
+		trace_softirq_entry(vec_nr);
+		h->action(h);
+		trace_softirq_exit(vec_nr);
+		if (unlikely(prev_count != preempt_count())) {
+			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
+			       vec_nr, softirq_to_name[vec_nr], h->action,
+			       prev_count, preempt_count());
+			preempt_count_set(prev_count);
+		}
+		h++;
+		pending >>= softirq_bit;
+	}
+#ifndef CONFIG_PREEMPT_RT_FULL
+	if (__this_cpu_read(ksoftirqd) == current)
+		rcu_softirq_qs();
+#endif
+	local_irq_disable();
 
 	pending = local_softirq_pending();
 	if (pending) {
@@ -486,11 +418,14 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
+#ifndef CONFIG_PREEMPT_RT_FULL
 	__local_bh_enable(SOFTIRQ_OFFSET);
+#endif
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 asmlinkage __visible void do_softirq(void)
 {
 	__u32 pending;
@@ -508,310 +443,8 @@ asmlinkage __visible void do_softirq(void)
 
 	local_irq_restore(flags);
 }
+#endif
 
-/*
- * This function must run with irqs disabled!
- */
-void raise_softirq_irqoff(unsigned int nr)
-{
-	__raise_softirq_irqoff(nr);
-
-	/*
-	 * If we're in an interrupt or softirq, we're done
-	 * (this also catches softirq-disabled code). We will
-	 * actually run the softirq once we return from
-	 * the irq or softirq.
-	 *
-	 * Otherwise we wake up ksoftirqd to make sure we
-	 * schedule the softirq soon.
-	 */
-	if (!in_interrupt())
-		wakeup_softirqd();
-}
-
-void __raise_softirq_irqoff(unsigned int nr)
-{
-	trace_softirq_raise(nr);
-	or_softirq_pending(1UL << nr);
-}
-
-static inline void local_bh_disable_nort(void) { local_bh_disable(); }
-static inline void _local_bh_enable_nort(void) { _local_bh_enable(); }
-static void ksoftirqd_set_sched_params(unsigned int cpu) { }
-
-#else /* !PREEMPT_RT_FULL */
-
-/*
- * On RT we serialize softirq execution with a cpu local lock per softirq
- */
-static DEFINE_PER_CPU(struct local_irq_lock [NR_SOFTIRQS], local_softirq_locks);
-
-void __init softirq_early_init(void)
-{
-	int i;
-
-	for (i = 0; i < NR_SOFTIRQS; i++)
-		local_irq_lock_init(local_softirq_locks[i]);
-}
-
-static void lock_softirq(int which)
-{
-	local_lock(local_softirq_locks[which]);
-}
-
-static void unlock_softirq(int which)
-{
-	local_unlock(local_softirq_locks[which]);
-}
-
-static void do_single_softirq(int which)
-{
-	unsigned long old_flags = current->flags;
-
-	current->flags &= ~PF_MEMALLOC;
-	vtime_account_irq_enter(current);
-	current->flags |= PF_IN_SOFTIRQ;
-	lockdep_softirq_enter();
-	local_irq_enable();
-	handle_softirq(which);
-	local_irq_disable();
-	lockdep_softirq_exit();
-	current->flags &= ~PF_IN_SOFTIRQ;
-	vtime_account_irq_enter(current);
-	current_restore_flags(old_flags, PF_MEMALLOC);
-}
-
-/*
- * Called with interrupts disabled. Process softirqs which were raised
- * in current context (or on behalf of ksoftirqd).
- */
-static void do_current_softirqs(void)
-{
-	while (current->softirqs_raised) {
-		int i = __ffs(current->softirqs_raised);
-		unsigned int pending, mask = (1U << i);
-
-		current->softirqs_raised &= ~mask;
-		local_irq_enable();
-
-		/*
-		 * If the lock is contended, we boost the owner to
-		 * process the softirq or leave the critical section
-		 * now.
-		 */
-		lock_softirq(i);
-		local_irq_disable();
-		softirq_set_runner(i);
-		/*
-		 * Check with the local_softirq_pending() bits,
-		 * whether we need to process this still or if someone
-		 * else took care of it.
-		 */
-		pending = local_softirq_pending();
-		if (pending & mask) {
-			set_softirq_pending(pending & ~mask);
-			do_single_softirq(i);
-		}
-		softirq_clr_runner(i);
-		WARN_ON(current->softirq_nestcnt != 1);
-		local_irq_enable();
-		unlock_softirq(i);
-		local_irq_disable();
-	}
-}
-
-void __local_bh_disable(void)
-{
-	if (++current->softirq_nestcnt == 1)
-		migrate_disable();
-}
-EXPORT_SYMBOL(__local_bh_disable);
-
-void __local_bh_enable(void)
-{
-	if (WARN_ON(current->softirq_nestcnt == 0))
-		return;
-
-	local_irq_disable();
-	if (current->softirq_nestcnt == 1 && current->softirqs_raised)
-		do_current_softirqs();
-	local_irq_enable();
-
-	if (--current->softirq_nestcnt == 0)
-		migrate_enable();
-}
-EXPORT_SYMBOL(__local_bh_enable);
-
-void _local_bh_enable(void)
-{
-	if (WARN_ON(current->softirq_nestcnt == 0))
-		return;
-	if (--current->softirq_nestcnt == 0)
-		migrate_enable();
-}
-EXPORT_SYMBOL(_local_bh_enable);
-
-int in_serving_softirq(void)
-{
-	return current->flags & PF_IN_SOFTIRQ;
-}
-EXPORT_SYMBOL(in_serving_softirq);
-
-/* Called with preemption disabled */
-static void run_ksoftirqd(unsigned int cpu)
-{
-	local_irq_disable();
-	current->softirq_nestcnt++;
-
-	do_current_softirqs();
-	current->softirq_nestcnt--;
-	local_irq_enable();
-	cond_resched();
-}
-
-/*
- * Called from netif_rx_ni(). Preemption enabled, but migration
- * disabled. So the cpu can't go away under us.
- */
-void thread_do_softirq(void)
-{
-	if (!in_serving_softirq() && current->softirqs_raised) {
-		current->softirq_nestcnt++;
-		do_current_softirqs();
-		current->softirq_nestcnt--;
-	}
-}
-
-static void do_raise_softirq_irqoff(unsigned int nr)
-{
-	unsigned int mask;
-
-	mask = 1UL << nr;
-
-	trace_softirq_raise(nr);
-	or_softirq_pending(mask);
-
-	/*
-	 * If we are not in a hard interrupt and inside a bh disabled
-	 * region, we simply raise the flag on current. local_bh_enable()
-	 * will make sure that the softirq is executed. Otherwise we
-	 * delegate it to ksoftirqd.
-	 */
-	if (!in_irq() && current->softirq_nestcnt)
-		current->softirqs_raised |= mask;
-	else if (!__this_cpu_read(ksoftirqd) || !__this_cpu_read(ktimer_softirqd))
-		return;
-
-	if (mask & TIMER_SOFTIRQS)
-		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
-	else
-		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
-}
-
-static void wakeup_proper_softirq(unsigned int nr)
-{
-	if ((1UL << nr) & TIMER_SOFTIRQS)
-		wakeup_timer_softirqd();
-	else
-		wakeup_softirqd();
-}
-
-void __raise_softirq_irqoff(unsigned int nr)
-{
-	do_raise_softirq_irqoff(nr);
-	if (!in_irq() && !current->softirq_nestcnt)
-		wakeup_proper_softirq(nr);
-}
-
-/*
- * Same as __raise_softirq_irqoff() but will process them in ksoftirqd
- */
-void __raise_softirq_irqoff_ksoft(unsigned int nr)
-{
-	unsigned int mask;
-
-	if (WARN_ON_ONCE(!__this_cpu_read(ksoftirqd) ||
-			 !__this_cpu_read(ktimer_softirqd)))
-		return;
-	mask = 1UL << nr;
-
-	trace_softirq_raise(nr);
-	or_softirq_pending(mask);
-	if (mask & TIMER_SOFTIRQS)
-		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
-	else
-		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
-	wakeup_proper_softirq(nr);
-}
-
-/*
- * This function must run with irqs disabled!
- */
-void raise_softirq_irqoff(unsigned int nr)
-{
-	do_raise_softirq_irqoff(nr);
-
-	/*
-	 * If we're in an hard interrupt we let irq return code deal
-	 * with the wakeup of ksoftirqd.
-	 */
-	if (in_irq())
-		return;
-	/*
-	 * If we are in thread context but outside of a bh disabled
-	 * region, we need to wake ksoftirqd as well.
-	 *
-	 * CHECKME: Some of the places which do that could be wrapped
-	 * into local_bh_disable/enable pairs. Though it's unclear
-	 * whether this is worth the effort. To find those places just
-	 * raise a WARN() if the condition is met.
-	 */
-	if (!current->softirq_nestcnt)
-		wakeup_proper_softirq(nr);
-}
-
-static inline int ksoftirqd_softirq_pending(void)
-{
-	return current->softirqs_raised;
-}
-
-static inline void local_bh_disable_nort(void) { }
-static inline void _local_bh_enable_nort(void) { }
-
-static inline void ksoftirqd_set_sched_params(unsigned int cpu)
-{
-	/* Take over all but timer pending softirqs when starting */
-	local_irq_disable();
-	current->softirqs_raised = local_softirq_pending() & ~TIMER_SOFTIRQS;
-	local_irq_enable();
-}
-
-static inline void ktimer_softirqd_set_sched_params(unsigned int cpu)
-{
-	struct sched_param param = { .sched_priority = 1 };
-
-	sched_setscheduler(current, SCHED_FIFO, &param);
-
-	/* Take over timer pending softirqs when starting */
-	local_irq_disable();
-	current->softirqs_raised = local_softirq_pending() & TIMER_SOFTIRQS;
-	local_irq_enable();
-}
-
-static inline void ktimer_softirqd_clr_sched_params(unsigned int cpu,
-						    bool online)
-{
-	struct sched_param param = { .sched_priority = 0 };
-
-	sched_setscheduler(current, SCHED_NORMAL, &param);
-}
-
-static int ktimer_softirqd_should_run(unsigned int cpu)
-{
-	return current->softirqs_raised;
-}
-
-#endif /* PREEMPT_RT_FULL */
 /*
  * Enter an interrupt context.
  */
@@ -823,17 +456,26 @@ void irq_enter(void)
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable_nort();
+		local_bh_disable();
 		tick_irq_enter();
-		_local_bh_enable_nort();
+		_local_bh_enable();
 	}
 
 	__irq_enter();
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+static inline void invoke_softirq(void)
+{
+	if (softirq_count() == 0)
+		wakeup_softirqd();
+}
+
+#else
+
 static inline void invoke_softirq(void)
 {
-#ifndef CONFIG_PREEMPT_RT_FULL
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
@@ -856,19 +498,8 @@ static inline void invoke_softirq(void)
 	} else {
 		wakeup_softirqd();
 	}
-#else /* PREEMPT_RT_FULL */
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (__this_cpu_read(ksoftirqd) &&
-			__this_cpu_read(ksoftirqd)->softirqs_raised)
-		wakeup_softirqd();
-	if (__this_cpu_read(ktimer_softirqd) &&
-			__this_cpu_read(ktimer_softirqd)->softirqs_raised)
-		wakeup_timer_softirqd();
-	local_irq_restore(flags);
-#endif
 }
+#endif
 
 static inline void tick_irq_exit(void)
 {
@@ -903,6 +534,49 @@ void irq_exit(void)
 	trace_hardirq_exit(); /* must be last! */
 }
 
+/*
+ * This function must run with irqs disabled!
+ */
+#ifdef CONFIG_PREEMPT_RT_FULL
+void raise_softirq_irqoff(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+
+	/*
+	 * If we're in an hard interrupt we let irq return code deal
+	 * with the wakeup of ksoftirqd.
+	 */
+	if (in_irq())
+		return;
+	/*
+	 * If were are not in BH-disabled section then we have to wake
+	 * ksoftirqd.
+	 */
+	if (softirq_count() == 0)
+		wakeup_softirqd();
+}
+
+#else
+
+inline void raise_softirq_irqoff(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+
+	/*
+	 * If we're in an interrupt or softirq, we're done
+	 * (this also catches softirq-disabled code). We will
+	 * actually run the softirq once we return from
+	 * the irq or softirq.
+	 *
+	 * Otherwise we wake up ksoftirqd to make sure we
+	 * schedule the softirq soon.
+	 */
+	if (!in_interrupt())
+		wakeup_softirqd();
+}
+
+#endif
+
 void raise_softirq(unsigned int nr)
 {
 	unsigned long flags;
@@ -912,6 +586,12 @@ void raise_softirq(unsigned int nr)
 	local_irq_restore(flags);
 }
 
+void __raise_softirq_irqoff(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	or_softirq_pending(1UL << nr);
+}
+
 void open_softirq(int nr, void (*action)(struct softirq_action *))
 {
 	softirq_vec[nr].action = action;
@@ -936,38 +616,11 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (!tasklet_trylock(t)) {
-		local_irq_restore(flags);
-		return;
-	}
-
 	head = this_cpu_ptr(headp);
-again:
-	/* We may have been preempted before tasklet_trylock
-	 * and __tasklet_action may have already run.
-	 * So double check the sched bit while the takslet
-	 * is locked before adding it to the list.
-	 */
-	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
-		t->next = NULL;
-		*head->tail = t;
-		head->tail = &(t->next);
-		raise_softirq_irqoff(softirq_nr);
-		tasklet_unlock(t);
-	} else {
-		/* This is subtle. If we hit the corner case above
-		 * It is possible that we get preempted right here,
-		 * and another task has successfully called
-		 * tasklet_schedule(), then this function, and
-		 * failed on the trylock. Thus we must be sure
-		 * before releasing the tasklet lock, that the
-		 * SCHED_BIT is clear. Otherwise the tasklet
-		 * may get its SCHED_BIT set, but not added to the
-		 * list
-		 */
-		if (!tasklet_tryunlock(t))
-			goto again;
-	}
+	t->next = NULL;
+	*head->tail = t;
+	head->tail = &(t->next);
+	raise_softirq_irqoff(softirq_nr);
 	local_irq_restore(flags);
 }
 
@@ -985,21 +638,11 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
-void tasklet_enable(struct tasklet_struct *t)
-{
-	if (!atomic_dec_and_test(&t->count))
-		return;
-	if (test_and_clear_bit(TASKLET_STATE_PENDING, &t->state))
-		tasklet_schedule(t);
-}
-EXPORT_SYMBOL(tasklet_enable);
-
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
-	int loops = 1000000;
 
 	local_irq_disable();
 	list = tl_head->head;
@@ -1011,56 +654,25 @@ static void tasklet_action_common(struct softirq_action *a,
 		struct tasklet_struct *t = list;
 
 		list = list->next;
-		/*
-		 * Should always succeed - after a tasklist got on the
-		 * list (after getting the SCHED bit set from 0 to 1),
-		 * nothing but the tasklet softirq it got queued to can
-		 * lock it:
-		 */
-		if (!tasklet_trylock(t)) {
-			WARN_ON(1);
-			continue;
-		}
 
-		t->next = NULL;
-
-		if (unlikely(atomic_read(&t->count))) {
-out_disabled:
-			/* implicit unlock: */
-			wmb();
-			t->state = TASKLET_STATEF_PENDING;
-			continue;
-		}
-		/*
-		 * After this point on the tasklet might be rescheduled
-		 * on another CPU, but it can only be added to another
-		 * CPU's tasklet list if we unlock the tasklet (which we
-		 * dont do yet).
-		 */
-		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-			WARN_ON(1);
-again:
-		t->func(t->data);
-
-		while (!tasklet_tryunlock(t)) {
-			/*
-			 * If it got disabled meanwhile, bail out:
-			 */
-			if (atomic_read(&t->count))
-				goto out_disabled;
-			/*
-			 * If it got scheduled meanwhile, re-execute
-			 * the tasklet function:
-			 */
-			if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-				goto again;
-			if (!--loops) {
-				printk("hm, tasklet state: %08lx\n", t->state);
-				WARN_ON(1);
+		if (tasklet_trylock(t)) {
+			if (!atomic_read(&t->count)) {
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
+							&t->state))
+					BUG();
+				t->func(t->data);
 				tasklet_unlock(t);
-				break;
+				continue;
 			}
+			tasklet_unlock(t);
 		}
+
+		local_irq_disable();
+		t->next = NULL;
+		*tl_head->tail = t;
+		tl_head->tail = &t->next;
+		__raise_softirq_irqoff(softirq_nr);
+		local_irq_enable();
 	}
 }
 
@@ -1092,7 +704,7 @@ void tasklet_kill(struct tasklet_struct *t)
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		do {
-			msleep(1);
+			yield();
 		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
 	}
 	tasklet_unlock_wait(t);
@@ -1166,26 +778,28 @@ void __init softirq_init(void)
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action);
 }
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
-void tasklet_unlock_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
-		/*
-		 * Hack for now to avoid this busy-loop:
-		 */
-#ifdef CONFIG_PREEMPT_RT_FULL
-		msleep(1);
-#else
-		barrier();
-#endif
-	}
-}
-EXPORT_SYMBOL(tasklet_unlock_wait);
-#endif
-
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return ksoftirqd_softirq_pending();
+	return local_softirq_pending();
+}
+
+static void run_ksoftirqd(unsigned int cpu)
+{
+	local_bh_disable_rt();
+	local_irq_disable();
+	if (local_softirq_pending()) {
+		/*
+		 * We can safely run softirq on inline stack, as we are not deep
+		 * in the task stack here.
+		 */
+		__do_softirq();
+		local_irq_enable();
+		_local_bh_enable_rt();
+		cond_resched();
+		return;
+	}
+	local_irq_enable();
+	_local_bh_enable_rt();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1252,35 +866,97 @@ static int takeover_tasklets(unsigned int cpu)
 
 static struct smp_hotplug_thread softirq_threads = {
 	.store			= &ksoftirqd,
-	.setup			= ksoftirqd_set_sched_params,
 	.thread_should_run	= ksoftirqd_should_run,
 	.thread_fn		= run_ksoftirqd,
 	.thread_comm		= "ksoftirqd/%u",
 };
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-static struct smp_hotplug_thread softirq_timer_threads = {
-	.store			= &ktimer_softirqd,
-	.setup			= ktimer_softirqd_set_sched_params,
-	.cleanup		= ktimer_softirqd_clr_sched_params,
-	.thread_should_run	= ktimer_softirqd_should_run,
-	.thread_fn		= run_ksoftirqd,
-	.thread_comm		= "ktimersoftd/%u",
-};
-#endif
-
 static __init int spawn_ksoftirqd(void)
 {
+#ifdef CONFIG_PREEMPT_RT_FULL
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		lockdep_set_novalidate_class(per_cpu_ptr(&bh_lock.lock, cpu));
+#endif
+
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
-#ifdef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(smpboot_register_percpu_thread(&softirq_timer_threads));
-#endif
+
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+/*
+ * On preempt-rt a softirq running context might be blocked on a
+ * lock. There might be no other runnable task on this CPU because the
+ * lock owner runs on some other CPU. So we have to go into idle with
+ * the pending bit set. Therefor we need to check this otherwise we
+ * warn about false positives which confuses users and defeats the
+ * whole purpose of this test.
+ *
+ * This code is called with interrupts disabled.
+ */
+void softirq_check_pending_idle(void)
+{
+	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
+	static int rate_limit;
+	bool okay = false;
+	u32 warnpending;
+
+	if (rate_limit >= 10)
+		return;
+
+	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
+
+	if (!tsk)
+		return;
+	/*
+	 * If ksoftirqd is blocked on a lock then we may go idle with pending
+	 * softirq.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
+		okay = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+	if (okay)
+		return;
+	/*
+	 * The softirq lock is held in non-atomic context and the owner is
+	 * blocking on a lock. It will schedule softirqs once the counter goes
+	 * back to zero.
+	 */
+	if (this_cpu_read(softirq_counter) > 0)
+		return;
+
+	printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
+	       warnpending);
+	rate_limit++;
+}
+
+#else
+
+void softirq_check_pending_idle(void)
+{
+	static int ratelimit;
+
+	if (ratelimit < 10 &&
+	    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
+		pr_warn("NOHZ: local_softirq_pending %02x\n",
+			(unsigned int) local_softirq_pending());
+		ratelimit++;
+	}
+}
+
+#endif
+
 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that
  *   GCC does not inline them incorrectly. ]
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a33d51ac52100..6e5d62bdebf22 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -721,22 +721,6 @@ static void hrtimer_switch_to_hres(void)
 	retrigger_next_event(NULL);
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-static void run_clock_set_delay(struct kthread_work *work)
-{
-	clock_was_set();
-}
-
-static DEFINE_KTHREAD_WORK(clock_set_delay_work, run_clock_set_delay);
-
-void clock_was_set_delayed(void)
-{
-	kthread_schedule_work(&clock_set_delay_work);
-}
-
-#else /* PREEMPT_RT_FULL */
-
 static void clock_was_set_work(struct work_struct *work)
 {
 	clock_was_set();
@@ -752,7 +736,6 @@ void clock_was_set_delayed(void)
 {
 	schedule_work(&hrtimer_work);
 }
-#endif
 
 #else
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 272b74ae4c709..227dba00dd0ef 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -216,6 +216,9 @@ static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
 static DEFINE_MUTEX(timer_keys_mutex);
 
+static void timer_update_keys(struct work_struct *work);
+static DECLARE_WORK(timer_update_work, timer_update_keys);
+
 #ifdef CONFIG_SMP
 unsigned int sysctl_timer_migration = 1;
 
@@ -232,18 +235,17 @@ static void timers_update_migration(void)
 static inline void timers_update_migration(void) { }
 #endif /* !CONFIG_SMP */
 
-static void timer_update_keys(struct kthread_work *work)
+static void timer_update_keys(struct work_struct *work)
 {
 	mutex_lock(&timer_keys_mutex);
 	timers_update_migration();
 	static_branch_enable(&timers_nohz_active);
 	mutex_unlock(&timer_keys_mutex);
 }
-static DEFINE_KTHREAD_WORK(timer_update_swork, timer_update_keys);
 
 void timers_update_nohz(void)
 {
-	kthread_schedule_work(&timer_update_swork);
+	schedule_work(&timer_update_work);
 }
 
 int timer_migration_handler(struct ctl_table *table, int write,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9077deb6e2358..7914df2fa9ba1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -49,8 +49,6 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
-#include <linux/locallock.h>
-#include <linux/delay.h>
 
 #include "workqueue_internal.h"
 
@@ -125,11 +123,6 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
- *    On RT we need the extra protection via rt_lock_idle_list() for
- *    the list manipulations against read access from
- *    wq_worker_sleeping(). All other places are nicely serialized via
- *    pool->lock.
- *
  * A: wq_pool_attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
@@ -151,7 +144,7 @@ enum {
 /* struct worker is defined in workqueue_internal.h */
 
 struct worker_pool {
-	spinlock_t		lock;		/* the pool lock */
+	raw_spinlock_t		lock;		/* the pool lock */
 	int			cpu;		/* I: the associated cpu */
 	int			node;		/* I: the associated node ID */
 	int			id;		/* I: pool ID */
@@ -304,8 +297,8 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
-static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
+static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -357,8 +350,6 @@ EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 
-static DEFINE_LOCAL_IRQ_LOCK(pendingb_lock);
-
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 
@@ -435,31 +426,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
 		else
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-static inline void rt_lock_idle_list(struct worker_pool *pool)
-{
-	preempt_disable();
-}
-static inline void rt_unlock_idle_list(struct worker_pool *pool)
-{
-	preempt_enable();
-}
-static inline void sched_lock_idle_list(struct worker_pool *pool) { }
-static inline void sched_unlock_idle_list(struct worker_pool *pool) { }
-#else
-static inline void rt_lock_idle_list(struct worker_pool *pool) { }
-static inline void rt_unlock_idle_list(struct worker_pool *pool) { }
-static inline void sched_lock_idle_list(struct worker_pool *pool)
-{
-	spin_lock_irq(&pool->lock);
-}
-static inline void sched_unlock_idle_list(struct worker_pool *pool)
-{
-	spin_unlock_irq(&pool->lock);
-}
-#endif
-
-
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
 static struct debug_obj_descr work_debug_descr;
@@ -862,20 +828,14 @@ static struct worker *first_idle_worker(struct worker_pool *pool)
  * Wake up the first idle worker of @pool.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
-	struct worker *worker;
-
-	rt_lock_idle_list(pool);
-
-	worker = first_idle_worker(pool);
+	struct worker *worker = first_idle_worker(pool);
 
 	if (likely(worker))
 		wake_up_process(worker->task);
-
-	rt_unlock_idle_list(pool);
 }
 
 /**
@@ -904,7 +864,7 @@ void wq_worker_running(struct task_struct *task)
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker = kthread_data(task);
+	struct worker *next, *worker = kthread_data(task);
 	struct worker_pool *pool;
 
 	/*
@@ -921,18 +881,26 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 
 	worker->sleeping = 1;
+	raw_spin_lock_irq(&pool->lock);
 
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
 	 * worklist not empty test sequence is in insert_work().
 	 * Please read comment there.
+	 *
+	 * NOT_RUNNING is clear.  This means that we're bound to and
+	 * running on the local cpu w/ rq lock held and preemption
+	 * disabled, which in turn means that none else could be
+	 * manipulating idle_list, so dereferencing idle_list without pool
+	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
 	    !list_empty(&pool->worklist)) {
-		sched_lock_idle_list(pool);
-		wake_up_worker(pool);
-		sched_unlock_idle_list(pool);
+		next = first_idle_worker(pool);
+		if (next)
+			wake_up_process(next->task);
 	}
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -942,7 +910,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * the scheduler to get a worker's last known identity.
  *
  * CONTEXT:
- * spin_lock_irq(rq->lock)
+ * raw_spin_lock_irq(rq->lock)
  *
  * Return:
  * The last work function %current executed as a worker, NULL if it
@@ -963,7 +931,7 @@ work_func_t wq_worker_last_func(struct task_struct *task)
  * Set @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 {
@@ -988,7 +956,7 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 {
@@ -1036,7 +1004,7 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
  * actually occurs, it should be easy to locate the culprit work function.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  *
  * Return:
  * Pointer to worker which is executing @work if found, %NULL
@@ -1071,7 +1039,7 @@ static struct worker *find_worker_executing_work(struct worker_pool *pool,
  * nested inside outer list_for_each_entry_safe().
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void move_linked_works(struct work_struct *work, struct list_head *head,
 			      struct work_struct **nextp)
@@ -1149,11 +1117,9 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
-		rcu_read_lock();
-		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		put_pwq(pwq);
-		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
-		rcu_read_unlock();
+		raw_spin_unlock_irq(&pwq->pool->lock);
 	}
 }
 
@@ -1186,7 +1152,7 @@ static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
@@ -1257,7 +1223,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
 
-	local_lock_irqsave(pendingb_lock, *flags);
+	local_irq_save(*flags);
 
 	/* try to steal the timer if it exists */
 	if (is_dwork) {
@@ -1285,7 +1251,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	if (!pool)
 		goto fail;
 
-	spin_lock(&pool->lock);
+	raw_spin_lock(&pool->lock);
 	/*
 	 * work->data is guaranteed to point to pwq only while the work
 	 * item is queued on pwq->wq, and both updating work->data to point
@@ -1314,17 +1280,17 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
-		spin_unlock(&pool->lock);
+		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
 	}
-	spin_unlock(&pool->lock);
+	raw_spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
-	local_unlock_irqrestore(pendingb_lock, *flags);
+	local_irq_restore(*flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
-	cpu_chill();
+	cpu_relax();
 	return -EAGAIN;
 }
 
@@ -1339,7 +1305,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
  * work_struct flags.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 			struct list_head *head, unsigned int extra_flags)
@@ -1426,13 +1392,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * queued or lose PENDING.  Grabbing PENDING and queueing should
 	 * happen with IRQ disabled.
 	 */
-#ifndef CONFIG_PREEMPT_RT_FULL
-	/*
-	 * nort: On RT the "interrupts-disabled" rule has been replaced with
-	 * pendingb_lock.
-	 */
 	lockdep_assert_irqs_disabled();
-#endif
 
 	debug_work_activate(work);
 
@@ -1460,7 +1420,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	if (last_pool && last_pool != pwq->pool) {
 		struct worker *worker;
 
-		spin_lock(&last_pool->lock);
+		raw_spin_lock(&last_pool->lock);
 
 		worker = find_worker_executing_work(last_pool, work);
 
@@ -1468,11 +1428,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 			pwq = worker->current_pwq;
 		} else {
 			/* meh... not running there, queue here */
-			spin_unlock(&last_pool->lock);
-			spin_lock(&pwq->pool->lock);
+			raw_spin_unlock(&last_pool->lock);
+			raw_spin_lock(&pwq->pool->lock);
 		}
 	} else {
-		spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pwq->pool->lock);
 	}
 
 	/*
@@ -1485,7 +1445,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pwq->pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1517,7 +1477,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	insert_work(pwq, work, worklist, work_flags);
 
 out:
-	spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pwq->pool->lock);
 	rcu_read_unlock();
 }
 
@@ -1538,14 +1498,14 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 	bool ret = false;
 	unsigned long flags;
 
-	local_lock_irqsave(pendingb_lock,flags);
+	local_irq_save(flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_work(cpu, wq, work);
 		ret = true;
 	}
 
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_work_on);
@@ -1553,12 +1513,11 @@ EXPORT_SYMBOL(queue_work_on);
 void delayed_work_timer_fn(struct timer_list *t)
 {
 	struct delayed_work *dwork = from_timer(dwork, t, timer);
+	unsigned long flags;
 
-	/* XXX */
-	/* local_lock(pendingb_lock); */
-	/* should have been called from irqsafe timer with irq already off */
+	local_irq_save(flags);
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	/* local_unlock(pendingb_lock); */
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(delayed_work_timer_fn);
 
@@ -1613,14 +1572,14 @@ bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	unsigned long flags;
 
 	/* read the comment in __queue_work() */
-	local_lock_irqsave(pendingb_lock, flags);
+	local_irq_save(flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret = true;
 	}
 
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_delayed_work_on);
@@ -1655,7 +1614,7 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 
 	if (likely(ret >= 0)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
-		local_unlock_irqrestore(pendingb_lock, flags);
+		local_irq_restore(flags);
 	}
 
 	/* -ENOENT from try_to_grab_pending() becomes %true */
@@ -1666,12 +1625,11 @@ EXPORT_SYMBOL_GPL(mod_delayed_work_on);
 static void rcu_work_rcufn(struct rcu_head *rcu)
 {
 	struct rcu_work *rwork = container_of(rcu, struct rcu_work, rcu);
-	unsigned long flags;
 
 	/* read the comment in __queue_work() */
-	local_lock_irqsave(pendingb_lock, flags);
+	local_irq_disable();
 	__queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_enable();
 }
 
 /**
@@ -1706,7 +1664,7 @@ EXPORT_SYMBOL(queue_rcu_work);
  * necessary.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_enter_idle(struct worker *worker)
 {
@@ -1723,9 +1681,7 @@ static void worker_enter_idle(struct worker *worker)
 	worker->last_active = jiffies;
 
 	/* idle_list is LIFO */
-	rt_lock_idle_list(pool);
 	list_add(&worker->entry, &pool->idle_list);
-	rt_unlock_idle_list(pool);
 
 	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
@@ -1748,7 +1704,7 @@ static void worker_enter_idle(struct worker *worker)
  * @worker is leaving idle state.  Update stats.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_leave_idle(struct worker *worker)
 {
@@ -1758,9 +1714,7 @@ static void worker_leave_idle(struct worker *worker)
 		return;
 	worker_clr_flags(worker, WORKER_IDLE);
 	pool->nr_idle--;
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 }
 
 static struct worker *alloc_worker(int node)
@@ -1888,11 +1842,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker_attach_to_pool(worker, pool);
 
 	/* start the newly created worker */
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
 	wake_up_process(worker->task);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	return worker;
 
@@ -1911,7 +1865,7 @@ static struct worker *create_worker(struct worker_pool *pool)
  * be idle.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void destroy_worker(struct worker *worker)
 {
@@ -1928,9 +1882,7 @@ static void destroy_worker(struct worker *worker)
 	pool->nr_workers--;
 	pool->nr_idle--;
 
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 	worker->flags |= WORKER_DIE;
 	wake_up_process(worker->task);
 }
@@ -1939,7 +1891,7 @@ static void idle_worker_timeout(struct timer_list *t)
 {
 	struct worker_pool *pool = from_timer(pool, t, idle_timer);
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
 		struct worker *worker;
@@ -1957,7 +1909,7 @@ static void idle_worker_timeout(struct timer_list *t)
 		destroy_worker(worker);
 	}
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -1988,8 +1940,8 @@ static void pool_mayday_timeout(struct timer_list *t)
 	struct worker_pool *pool = from_timer(pool, t, mayday_timer);
 	struct work_struct *work;
 
-	spin_lock_irq(&pool->lock);
-	spin_lock(&wq_mayday_lock);		/* for wq->maydays */
+	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock(&wq_mayday_lock);		/* for wq->maydays */
 
 	if (need_to_create_worker(pool)) {
 		/*
@@ -2002,8 +1954,8 @@ static void pool_mayday_timeout(struct timer_list *t)
 			send_mayday(work);
 	}
 
-	spin_unlock(&wq_mayday_lock);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock(&wq_mayday_lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INTERVAL);
 }
@@ -2022,7 +1974,7 @@ static void pool_mayday_timeout(struct timer_list *t)
  * may_start_working() %true.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
  * manager.
  */
@@ -2031,7 +1983,7 @@ __releases(&pool->lock)
 __acquires(&pool->lock)
 {
 restart:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
@@ -2047,7 +1999,7 @@ __acquires(&pool->lock)
 	}
 
 	del_timer_sync(&pool->mayday_timer);
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/*
 	 * This is necessary even after a new worker was just successfully
 	 * created as @pool->lock was dropped and the new worker might have
@@ -2070,7 +2022,7 @@ __acquires(&pool->lock)
  * and may_start_working() is true.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
  *
  * Return:
@@ -2093,7 +2045,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	swake_up_one(&wq_manager_wait);
 	return true;
 }
 
@@ -2109,7 +2061,7 @@ static bool manage_workers(struct worker *worker)
  * call this function to process a work.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void process_one_work(struct worker *worker, struct work_struct *work)
 __releases(&pool->lock)
@@ -2191,7 +2143,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	lock_map_acquire(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
@@ -2246,7 +2198,7 @@ __acquires(&pool->lock)
 	 */
 	cond_resched();
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	/* clear cpu intensive status */
 	if (unlikely(cpu_intensive))
@@ -2272,7 +2224,7 @@ __acquires(&pool->lock)
  * fetches a work from the top and executes it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.
  */
 static void process_scheduled_works(struct worker *worker)
@@ -2314,11 +2266,11 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		set_pf_worker(false);
 
@@ -2384,7 +2336,7 @@ static int worker_thread(void *__worker)
 	 */
 	worker_enter_idle(worker);
 	__set_current_state(TASK_IDLE);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	schedule();
 	goto woke_up;
 }
@@ -2438,7 +2390,7 @@ static int rescuer_thread(void *__rescuer)
 	should_stop = kthread_should_stop();
 
 	/* see whether any pwq is asking for help */
-	spin_lock_irq(&wq_mayday_lock);
+	raw_spin_lock_irq(&wq_mayday_lock);
 
 	while (!list_empty(&wq->maydays)) {
 		struct pool_workqueue *pwq = list_first_entry(&wq->maydays,
@@ -2450,11 +2402,11 @@ static int rescuer_thread(void *__rescuer)
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
 
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
 
 		worker_attach_to_pool(rescuer, pool);
 
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 
 		/*
 		 * Slurp in all works issued via this workqueue and
@@ -2483,10 +2435,10 @@ static int rescuer_thread(void *__rescuer)
 			 * incur MAYDAY_INTERVAL delay inbetween.
 			 */
 			if (need_to_create_worker(pool)) {
-				spin_lock(&wq_mayday_lock);
+				raw_spin_lock(&wq_mayday_lock);
 				get_pwq(pwq);
 				list_move_tail(&pwq->mayday_node, &wq->maydays);
-				spin_unlock(&wq_mayday_lock);
+				raw_spin_unlock(&wq_mayday_lock);
 			}
 		}
 
@@ -2504,14 +2456,14 @@ static int rescuer_thread(void *__rescuer)
 		if (need_more_worker(pool))
 			wake_up_worker(pool);
 
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 
 		worker_detach_from_pool(rescuer);
 
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 	}
 
-	spin_unlock_irq(&wq_mayday_lock);
+	raw_spin_unlock_irq(&wq_mayday_lock);
 
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
@@ -2591,7 +2543,7 @@ static void wq_barrier_func(struct work_struct *work)
  * underneath us, so we can't reliably determine pwq from @target.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
@@ -2678,7 +2630,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	for_each_pwq(pwq, wq) {
 		struct worker_pool *pool = pwq->pool;
 
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 
 		if (flush_color >= 0) {
 			WARN_ON_ONCE(pwq->flush_color != -1);
@@ -2695,7 +2647,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 			pwq->work_color = work_color;
 		}
 
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 
 	if (flush_color >= 0 && atomic_dec_and_test(&wq->nr_pwqs_to_flush))
@@ -2895,9 +2847,9 @@ void drain_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		bool drained;
 
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		drained = !pwq->nr_active && list_empty(&pwq->delayed_works);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
 			continue;
@@ -2933,7 +2885,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 		return false;
 	}
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
 	pwq = get_work_pwq(work);
 	if (pwq) {
@@ -2949,7 +2901,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	check_flush_dependency(pwq->wq, work);
 
 	insert_wq_barrier(pwq, barr, work, worker);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	/*
 	 * Force a lock recursion deadlock when using flush_work() inside a
@@ -2968,7 +2920,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	rcu_read_unlock();
 	return true;
 already_gone:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	rcu_read_unlock();
 	return false;
 }
@@ -3069,7 +3021,7 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 
 	/* tell other tasks trying to grab @work to back off */
 	mark_work_canceling(work);
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 
 	/*
 	 * This allows canceling during early boot.  We know that @work
@@ -3130,10 +3082,10 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 bool flush_delayed_work(struct delayed_work *dwork)
 {
-	local_lock_irq(pendingb_lock);
+	local_irq_disable();
 	if (del_timer_sync(&dwork->timer))
 		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_unlock_irq(pendingb_lock);
+	local_irq_enable();
 	return flush_work(&dwork->work);
 }
 EXPORT_SYMBOL(flush_delayed_work);
@@ -3171,7 +3123,7 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
 		return false;
 
 	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 
@@ -3281,7 +3233,7 @@ EXPORT_SYMBOL_GPL(execute_in_process_context);
  *
  * Undo alloc_workqueue_attrs().
  */
-void free_workqueue_attrs(struct workqueue_attrs *attrs)
+static void free_workqueue_attrs(struct workqueue_attrs *attrs)
 {
 	if (attrs) {
 		free_cpumask_var(attrs->cpumask);
@@ -3291,21 +3243,20 @@ void free_workqueue_attrs(struct workqueue_attrs *attrs)
 
 /**
  * alloc_workqueue_attrs - allocate a workqueue_attrs
- * @gfp_mask: allocation mask to use
  *
  * Allocate a new workqueue_attrs, initialize with default settings and
  * return it.
  *
  * Return: The allocated new workqueue_attr on success. %NULL on failure.
  */
-struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask)
+static struct workqueue_attrs *alloc_workqueue_attrs(void)
 {
 	struct workqueue_attrs *attrs;
 
-	attrs = kzalloc(sizeof(*attrs), gfp_mask);
+	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		goto fail;
-	if (!alloc_cpumask_var(&attrs->cpumask, gfp_mask))
+	if (!alloc_cpumask_var(&attrs->cpumask, GFP_KERNEL))
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
@@ -3362,7 +3313,7 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
  */
 static int init_worker_pool(struct worker_pool *pool)
 {
-	spin_lock_init(&pool->lock);
+	raw_spin_lock_init(&pool->lock);
 	pool->id = -1;
 	pool->cpu = -1;
 	pool->node = NUMA_NO_NODE;
@@ -3383,7 +3334,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	pool->refcnt = 1;
 
 	/* shouldn't fail above this point */
-	pool->attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	pool->attrs = alloc_workqueue_attrs();
 	if (!pool->attrs)
 		return -ENOMEM;
 	return 0;
@@ -3448,15 +3399,15 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
 	 */
-	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
+	raw_spin_lock_irq(&pool->lock);
+	swait_event_lock_irq(wq_manager_wait,
 			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 
 	mutex_lock(&wq_pool_attach_mutex);
 	if (!list_empty(&pool->workers))
@@ -3610,7 +3561,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 		return;
 
 	/* this function can be called during early boot w/ irq disabled */
-	spin_lock_irqsave(&pwq->pool->lock, flags);
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
 	/*
 	 * During [un]freezing, the caller is responsible for ensuring that
@@ -3633,7 +3584,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 		pwq->max_active = 0;
 	}
 
-	spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
 
 /* initialize newly alloced @pwq which is associated with @wq and @pool */
@@ -3806,8 +3757,8 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 
 	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_node_ids), GFP_KERNEL);
 
-	new_attrs = alloc_workqueue_attrs(GFP_KERNEL);
-	tmp_attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	new_attrs = alloc_workqueue_attrs();
+	tmp_attrs = alloc_workqueue_attrs();
 	if (!ctx || !new_attrs || !tmp_attrs)
 		goto out_free;
 
@@ -3943,7 +3894,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
  *
  * Return: 0 on success and -errno on failure.
  */
-int apply_workqueue_attrs(struct workqueue_struct *wq,
+static int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs)
 {
 	int ret;
@@ -3954,7 +3905,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(apply_workqueue_attrs);
 
 /**
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
@@ -4032,9 +3982,9 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	spin_lock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
-	spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
 	old_pwq = numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
@@ -4153,7 +4103,7 @@ struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
 		return NULL;
 
 	if (flags & WQ_UNBOUND) {
-		wq->unbound_attrs = alloc_workqueue_attrs(GFP_KERNEL);
+		wq->unbound_attrs = alloc_workqueue_attrs();
 		if (!wq->unbound_attrs)
 			goto err_free_wq;
 	}
@@ -4422,10 +4372,10 @@ unsigned int work_busy(struct work_struct *work)
 	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (pool) {
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (find_worker_executing_work(pool, work))
 			ret |= WORK_BUSY_RUNNING;
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -4631,10 +4581,10 @@ void show_workqueue_state(void)
 		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
 		for_each_pwq(pwq, wq) {
-			spin_lock_irqsave(&pwq->pool->lock, flags);
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
 				show_pwq(pwq);
-			spin_unlock_irqrestore(&pwq->pool->lock, flags);
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
 			 * We could be printing a lot from atomic context, e.g.
 			 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4648,7 +4598,7 @@ void show_workqueue_state(void)
 		struct worker *worker;
 		bool first = true;
 
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
 
@@ -4667,7 +4617,7 @@ void show_workqueue_state(void)
 		}
 		pr_cont("\n");
 	next_pool:
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
 		 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4697,7 +4647,7 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 		struct worker_pool *pool = worker->pool;
 
 		if (pool) {
-			spin_lock_irq(&pool->lock);
+			raw_spin_lock_irq(&pool->lock);
 			/*
 			 * ->desc tracks information (wq name or
 			 * set_worker_desc()) for the latest execution.  If
@@ -4711,7 +4661,7 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 					scnprintf(buf + off, size - off, "-%s",
 						  worker->desc);
 			}
-			spin_unlock_irq(&pool->lock);
+			raw_spin_unlock_irq(&pool->lock);
 		}
 	}
 
@@ -4742,7 +4692,7 @@ static void unbind_workers(int cpu)
 
 	for_each_cpu_worker_pool(pool, cpu) {
 		mutex_lock(&wq_pool_attach_mutex);
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 
 		/*
 		 * We've blocked all attach/detach operations. Make all workers
@@ -4756,7 +4706,7 @@ static void unbind_workers(int cpu)
 
 		pool->flags |= POOL_DISASSOCIATED;
 
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*
@@ -4782,9 +4732,9 @@ static void unbind_workers(int cpu)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		wake_up_worker(pool);
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 }
 
@@ -4811,7 +4761,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
 
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 
 	pool->flags &= ~POOL_DISASSOCIATED;
 
@@ -4850,7 +4800,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WRITE_ONCE(worker->flags, worker_flags);
 	}
 
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -5302,7 +5252,7 @@ static struct workqueue_attrs *wq_sysfs_prep_attrs(struct workqueue_struct *wq)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	attrs = alloc_workqueue_attrs();
 	if (!attrs)
 		return NULL;
 
@@ -5724,7 +5674,7 @@ static void __init wq_numa_init(void)
 		return;
 	}
 
-	wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs(GFP_KERNEL);
+	wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
 	BUG_ON(!wq_update_unbound_numa_attrs_buf);
 
 	/*
@@ -5799,7 +5749,7 @@ int __init workqueue_init_early(void)
 	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
 		struct workqueue_attrs *attrs;
 
-		BUG_ON(!(attrs = alloc_workqueue_attrs(GFP_KERNEL)));
+		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
 		unbound_std_wq_attrs[i] = attrs;
 
@@ -5808,7 +5758,7 @@ int __init workqueue_init_early(void)
 		 * guaranteed by max_active which is enforced by pwqs.
 		 * Turn off NUMA so that dfl_pwq is used for all nodes.
 		 */
-		BUG_ON(!(attrs = alloc_workqueue_attrs(GFP_KERNEL)));
+		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
 		attrs->no_numa = true;
 		ordered_wq_attrs[i] = attrs;
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/core/dev.c b/net/core/dev.c
index e066156da2a9a..f4c796baea35e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6478,7 +6478,7 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	list_splice_tail(&repoll, &list);
 	list_splice(&list, &sd->poll_list);
 	if (!list_empty(&sd->poll_list))
-		__raise_softirq_irqoff_ksoft(NET_RX_SOFTIRQ);
+		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 
 	net_rps_action_and_irq_enable(sd);
 out:
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 872878755777e..3f24414150e27 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -77,7 +77,6 @@
 #include <linux/string.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/slab.h>
-#include <linux/locallock.h>
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -205,8 +204,6 @@ static const struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_LOCAL_IRQ_LOCK(icmp_sk_lock);
-
 static struct sock *icmp_sk(struct net *net)
 {
 	return *this_cpu_ptr(net->ipv4.icmp_sk);
@@ -217,16 +214,12 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 {
 	struct sock *sk;
 
-	if (!local_trylock(icmp_sk_lock))
-		return NULL;
-
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
-		local_unlock(icmp_sk_lock);
 		return NULL;
 	}
 	return sk;
@@ -235,7 +228,6 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 static inline void icmp_xmit_unlock(struct sock *sk)
 {
 	spin_unlock(&sk->sk_lock.slock);
-	local_unlock(icmp_sk_lock);
 }
 
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f3d8cb9b7a79e..9a2ff79a93ad9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,7 +62,6 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
-#include <linux/locallock.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -638,7 +637,6 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
-static DEFINE_LOCAL_IRQ_LOCK(tcp_sk_lock);
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -773,7 +771,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.tos = ip_hdr(skb)->tos;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	local_lock(tcp_sk_lock);
 	ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
 	if (sk)
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
@@ -786,7 +783,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	ctl_sk->sk_mark = 0;
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
-	local_unlock(tcp_sk_lock);
 	local_bh_enable();
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -867,7 +863,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	arg.tos = tos;
 	arg.uid = sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	local_lock(tcp_sk_lock);
 	ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
 	if (sk)
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
@@ -879,7 +874,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 
 	ctl_sk->sk_mark = 0;
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
-	local_unlock(tcp_sk_lock);
 	local_bh_enable();
 }
 
