Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0072085A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="XxPmdRh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfECBVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:21:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50633 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECBVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:21:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so5159679wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=9Q+7w7UqF5DNq3t8q8HxZL7nXCjR14iFzL96RMvZ8LA=;
        b=XxPmdRh+mFhAsW9r3I5c1s1i81tQyozBfpvnSLcptl8Sheb6Lj2VQCKlMlZLlTZCni
         scUKUiF1t6BKudOw33mRnjLtsWT9nn+4mu+6MQHWh3IXvI7vCUy/nd7rxyjpBlKVAxna
         2XZQDjO3TfuITrPDNA5cuaBZMCMdW3IGwJmgjpPTTiBCy/oSnuCuhfzT3HozA/f23qfb
         BLIsi1GSAonHFkXy0RPRGNa44l7F1T/VN+h3Zhveicb3t/8kwunjndGbkDCJB/odm/Ri
         MpMg0I3G67ujKa3ZCa4uC6nljoHmP6DdALlRYYjzBVkL+5ARQdIz4E8F7qbgnwnrN6Pk
         TjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=9Q+7w7UqF5DNq3t8q8HxZL7nXCjR14iFzL96RMvZ8LA=;
        b=VjXIRByksbJCLyfSUujviVVuSMbwQHcDJO6/BU19s0ODZe3i7g58DMqJh19DMl21Vs
         3dOjmD63rhacvjHSD6xfN2itCba8q1BqoCYPw2FvQQnTSS+iNiC31HvXQgHywlwv7nvT
         jOtQCtPXhY2lxPTDqEthtk/RUx9rOZaElmzdXXruB8hO1QJVpouo0g7BFRODlhuBktgW
         StrB6au0ERENMrC14f2O+gQ2yPuYq2eEngKiY3NhN/BJF6Rx1o2CtD/9Gr7xlgrgO5Ej
         iprosMn+565ZVVCLIA7B4rSdS3EM/rg7eRv7gKq3+nTp3adhI6dXhu6BPI4fcvXZyy3w
         Vzug==
X-Gm-Message-State: APjAAAUKPIZBbo+0Rec3Lm0zWKxLjx62FNd4wENKihXkzuw7DxYVxaI+
        m4/puYpGmiu0MVujBL5uA6nkyw==
X-Google-Smtp-Source: APXvYqwuWxo8pPIoiV6rnei2FLSSjDPp86f4Q5l8rrDCyGbWPK/vutC79XBhA4JwQ0Wml6qwCfx6fQ==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr4101334wmb.47.1556846499909;
        Thu, 02 May 2019 18:21:39 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d3sm785835wmf.46.2019.05.02.18.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 18:21:39 -0700 (PDT)
Message-ID: <5ccb97a3.1c69fb81.7061b.4674@mx.google.com>
Date:   Thu, 02 May 2019 18:21:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: next-20190502
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Tree: next
Subject: next/master boot bisection: next-20190502 on beagle-xm
To:     Tejun Heo <tj@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Ingo Molnar <mingo@kernel.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20190502 on beagle-xm

Summary:
  Start:      e8b243ea3b19 Add linux-next specific files for 20190502
  Details:    https://kernelci.org/boot/id/5ccb3ece59b51417ae5584af
  Plain log:  https://storage.kernelci.org//next/master/next-20190502/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-7/lab-baylibre/boot-omap3-beagle-xm.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190502/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-7/lab-baylibre/boot-omap3-beagle-xm.ht=
ml
  Result:     6d25be5782e4 sched/core, workqueues: Distangle worker account=
ing from rq lock

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     beagle-xm
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-7
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 6d25be5782e482eb93e3de0c94d0a517879377d0
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Mar 13 17:55:48 2019 +0100

    sched/core, workqueues: Distangle worker accounting from rq lock
    =

    The worker accounting for CPU bound workers is plugged into the core
    scheduler code and the wakeup code. This is not a hard requirement and
    can be avoided by keeping track of the state in the workqueue code
    itself.
    =

    Keep track of the sleeping state in the worker itself and call the
    notifier before entering the core scheduler. There might be false
    positives when the task is woken between that call and actually
    scheduling, but that's not really different from scheduling and being
    woken immediately after switching away. When nr_running is updated when
    the task is retunrning from schedule() then it is later compared when it
    is done from ttwu().
    =

    [ bigeasy: preempt_disable() around wq_worker_sleeping() by Daniel Bris=
tot de Oliveira ]
    =

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Acked-by: Tejun Heo <tj@kernel.org>
    Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/ad2b29b5715f970bffc1a7026cabd6ff0b24076a=
.1532952814.git.bristot@redhat.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..6184a0856aab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1685,10 +1685,6 @@ static inline void ttwu_activate(struct rq *rq, stru=
ct task_struct *p, int en_fl
 {
 	activate_task(rq, p, en_flags);
 	p->on_rq =3D TASK_ON_RQ_QUEUED;
-
-	/* If a worker is waking up, notify the workqueue: */
-	if (p->flags & PF_WQ_WORKER)
-		wq_worker_waking_up(p, cpu_of(rq));
 }
 =

 /*
@@ -2106,56 +2102,6 @@ try_to_wake_up(struct task_struct *p, unsigned int s=
tate, int wake_flags)
 	return success;
 }
 =

-/**
- * try_to_wake_up_local - try to wake up a local task with rq lock held
- * @p: the thread to be awakened
- * @rf: request-queue flags for pinning
- *
- * Put @p on the run-queue if it's not already there. The caller must
- * ensure that this_rq() is locked, @p is bound to this_rq() and not
- * the current task.
- */
-static void try_to_wake_up_local(struct task_struct *p, struct rq_flags *r=
f)
-{
-	struct rq *rq =3D task_rq(p);
-
-	if (WARN_ON_ONCE(rq !=3D this_rq()) ||
-	    WARN_ON_ONCE(p =3D=3D current))
-		return;
-
-	lockdep_assert_held(&rq->lock);
-
-	if (!raw_spin_trylock(&p->pi_lock)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet picked a replacement task.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&p->pi_lock);
-		rq_relock(rq, rf);
-	}
-
-	if (!(p->state & TASK_NORMAL))
-		goto out;
-
-	trace_sched_waking(p);
-
-	if (!task_on_rq_queued(p)) {
-		if (p->in_iowait) {
-			delayacct_blkio_end(p);
-			atomic_dec(&rq->nr_iowait);
-		}
-		ttwu_activate(rq, p, ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK);
-	}
-
-	ttwu_do_wakeup(rq, p, 0, rf);
-	ttwu_stat(p, smp_processor_id(), 0);
-out:
-	raw_spin_unlock(&p->pi_lock);
-}
-
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
@@ -3472,19 +3418,6 @@ static void __sched notrace __schedule(bool preempt)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
-
-			/*
-			 * If a worker went to sleep, notify and ask workqueue
-			 * whether it wants to wake up a task to maintain
-			 * concurrency.
-			 */
-			if (prev->flags & PF_WQ_WORKER) {
-				struct task_struct *to_wakeup;
-
-				to_wakeup =3D wq_worker_sleeping(prev);
-				if (to_wakeup)
-					try_to_wake_up_local(to_wakeup, &rf);
-			}
 		}
 		switch_count =3D &prev->nvcsw;
 	}
@@ -3544,6 +3477,20 @@ static inline void sched_submit_work(struct task_str=
uct *tsk)
 {
 	if (!tsk->state || tsk_is_pi_blocked(tsk))
 		return;
+
+	/*
+	 * If a worker went to sleep, notify and ask workqueue whether
+	 * it wants to wake up a task to maintain concurrency.
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
+	 */
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
+		wq_worker_sleeping(tsk);
+		preempt_enable_no_resched();
+	}
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
@@ -3552,6 +3499,12 @@ static inline void sched_submit_work(struct task_str=
uct *tsk)
 		blk_schedule_flush_plug(tsk);
 }
 =

+static void sched_update_worker(struct task_struct *tsk)
+{
+	if (tsk->flags & PF_WQ_WORKER)
+		wq_worker_running(tsk);
+}
+
 asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk =3D current;
@@ -3562,6 +3515,7 @@ asmlinkage __visible void __sched schedule(void)
 		__schedule(false);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
+	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
 =

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ddee541ea97a..56180c9286f5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -841,43 +841,32 @@ static void wake_up_worker(struct worker_pool *pool)
 }
 =

 /**
- * wq_worker_waking_up - a worker is waking up
+ * wq_worker_running - a worker is running again
  * @task: task waking up
- * @cpu: CPU @task is waking up to
  *
- * This function is called during try_to_wake_up() when a worker is
- * being awoken.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
+ * This function is called when a worker returns from schedule()
  */
-void wq_worker_waking_up(struct task_struct *task, int cpu)
+void wq_worker_running(struct task_struct *task)
 {
 	struct worker *worker =3D kthread_data(task);
 =

-	if (!(worker->flags & WORKER_NOT_RUNNING)) {
-		WARN_ON_ONCE(worker->pool->cpu !=3D cpu);
+	if (!worker->sleeping)
+		return;
+	if (!(worker->flags & WORKER_NOT_RUNNING))
 		atomic_inc(&worker->pool->nr_running);
-	}
+	worker->sleeping =3D 0;
 }
 =

 /**
  * wq_worker_sleeping - a worker is going to sleep
  * @task: task going to sleep
  *
- * This function is called during schedule() when a busy worker is
- * going to sleep.  Worker on the same cpu can be woken up by
- * returning pointer to its task.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
- *
- * Return:
- * Worker task on @cpu to wake up, %NULL if none.
+ * This function is called from schedule() when a busy worker is
+ * going to sleep.
  */
-struct task_struct *wq_worker_sleeping(struct task_struct *task)
+void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker =3D kthread_data(task), *to_wakeup =3D NULL;
+	struct worker *next, *worker =3D kthread_data(task);
 	struct worker_pool *pool;
 =

 	/*
@@ -886,13 +875,15 @@ struct task_struct *wq_worker_sleeping(struct task_st=
ruct *task)
 	 * checking NOT_RUNNING.
 	 */
 	if (worker->flags & WORKER_NOT_RUNNING)
-		return NULL;
+		return;
 =

 	pool =3D worker->pool;
 =

-	/* this can only happen on the local cpu */
-	if (WARN_ON_ONCE(pool->cpu !=3D raw_smp_processor_id()))
-		return NULL;
+	if (WARN_ON_ONCE(worker->sleeping))
+		return;
+
+	worker->sleeping =3D 1;
+	spin_lock_irq(&pool->lock);
 =

 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
@@ -906,9 +897,12 @@ struct task_struct *wq_worker_sleeping(struct task_str=
uct *task)
 	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
-	    !list_empty(&pool->worklist))
-		to_wakeup =3D first_idle_worker(pool);
-	return to_wakeup ? to_wakeup->task : NULL;
+	    !list_empty(&pool->worklist)) {
+		next =3D first_idle_worker(pool);
+		if (next)
+			wake_up_process(next->task);
+	}
+	spin_unlock_irq(&pool->lock);
 }
 =

 /**
@@ -4929,7 +4923,7 @@ static void rebind_workers(struct worker_pool *pool)
 		 *
 		 * WRITE_ONCE() is necessary because @worker->flags may be
 		 * tested without holding any lock in
-		 * wq_worker_waking_up().  Without it, NOT_RUNNING test may
+		 * wq_worker_running().  Without it, NOT_RUNNING test may
 		 * fail incorrectly leading to premature concurrency
 		 * management operations.
 		 */
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index cb68b03ca89a..498de0e909a4 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -44,6 +44,7 @@ struct worker {
 	unsigned long		last_active;	/* L: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
+	int			sleeping;	/* None */
 =

 	/*
 	 * Opaque string set with work_set_desc().  Printed out with task
@@ -72,8 +73,8 @@ static inline struct worker *current_wq_worker(void)
  * Scheduler hooks for concurrency managed workqueue.  Only to be used from
  * sched/ and workqueue.c.
  */
-void wq_worker_waking_up(struct task_struct *task, int cpu);
-struct task_struct *wq_worker_sleeping(struct task_struct *task);
+void wq_worker_running(struct task_struct *task);
+void wq_worker_sleeping(struct task_struct *task);
 work_func_t wq_worker_last_func(struct task_struct *task);
 =

 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [886b7a50100a50f1cbd08a6f8ec5884dfbe082dc] ipv6: A few fixes on der=
eferencing rt->from
git bisect good 886b7a50100a50f1cbd08a6f8ec5884dfbe082dc
# bad: [e8b243ea3b19b6f3b9fffca232a2c7b000964d6b] Add linux-next specific f=
iles for 20190502
git bisect bad e8b243ea3b19b6f3b9fffca232a2c7b000964d6b
# good: [d13fae4bf81ec35bd694284a4d3d3277019775e8] Merge remote-tracking br=
anch 'crypto/master'
git bisect good d13fae4bf81ec35bd694284a4d3d3277019775e8
# good: [70fae12f36808fea9de35ea322828fac4e427fdf] Merge remote-tracking br=
anch 'spi/for-next'
git bisect good 70fae12f36808fea9de35ea322828fac4e427fdf
# bad: [d9e74c2c211c3492615c7275cef32fe7be9f095f] Merge remote-tracking bra=
nch 'soundwire/next'
git bisect bad d9e74c2c211c3492615c7275cef32fe7be9f095f
# bad: [fd410ac5176a1cbcb18270f663baf59440521b37] Merge remote-tracking bra=
nch 'kvm/linux-next'
git bisect bad fd410ac5176a1cbcb18270f663baf59440521b37
# bad: [d40b775496f84f407da1929320e30766a6c68669] Merge branch 'locking/cor=
e'
git bisect bad d40b775496f84f407da1929320e30766a6c68669
# good: [d0d7b847679aeb875c832a0c1e6c09ffd9567bc0] Merge branch 'x86/apic'
git bisect good d0d7b847679aeb875c832a0c1e6c09ffd9567bc0
# good: [d15d356887e770c5f2dcf963b52c7cb510c9e42d] perf/x86: Make perf call=
chains work without CONFIG_FRAME_POINTER
git bisect good d15d356887e770c5f2dcf963b52c7cb510c9e42d
# bad: [afbc33eaab4b66f0462de6a9338e5500e23fff18] Merge branch 'ras/core'
git bisect bad afbc33eaab4b66f0462de6a9338e5500e23fff18
# bad: [9b019acb72e4b5741d88e8936d6f200ed44b66b2] sched/nohz: Run NOHZ idle=
 load balancer on HK_FLAG_MISC CPUs
git bisect bad 9b019acb72e4b5741d88e8936d6f200ed44b66b2
# bad: [1b174a2cb67a3a156d5a28426ae14241e6dfa655] sched/core: Remove ttwu_a=
ctivate()
git bisect bad 1b174a2cb67a3a156d5a28426ae14241e6dfa655
# good: [71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d] sched/fair: Make sync_en=
tity_load_avg() and remove_entity_load_avg() static
git bisect good 71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d
# good: [67d4f6ff2fb69e02bd6365a91ca3939b7a14deac] sched/topology: Skip dup=
licate group rewrites in build_sched_groups()
git bisect good 67d4f6ff2fb69e02bd6365a91ca3939b7a14deac
# bad: [6d25be5782e482eb93e3de0c94d0a517879377d0] sched/core, workqueues: D=
istangle worker accounting from rq lock
git bisect bad 6d25be5782e482eb93e3de0c94d0a517879377d0
# good: [e2abb398115e9c33f3d1e25bf6d1d08badc58b13] sched/fair: Remove unnee=
ded prototype of capacity_of()
git bisect good e2abb398115e9c33f3d1e25bf6d1d08badc58b13
# first bad commit: [6d25be5782e482eb93e3de0c94d0a517879377d0] sched/core, =
workqueues: Distangle worker accounting from rq lock
---------------------------------------------------------------------------=
----
