Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270EEC0030B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C222082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JwfiTWXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbfIFDNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:13:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:40242 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404399AbfIFDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:13:10 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5038F32CD9F;
        Thu,  5 Sep 2019 23:13:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id tg531-NP8s4k; Thu,  5 Sep 2019 23:13:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5C32132CD94;
        Thu,  5 Sep 2019 23:13:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5C32132CD94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567739588;
        bh=OHiXB6c6Aq/DVWxgPieqLxnRsyM32aIz9s8F9U1fnvg=;
        h=From:To:Date:Message-Id;
        b=JwfiTWXQfG7W4FwvhfQPgYVjoUmW7MxWLXL8wTzcznGEk5+krXerQwGJQEu0Kelih
         Cw9dks/m2dL7gxghDH+JQXg62Kns+6ORWzNJbyKqNe70pPzruQ7pHR2fmqklMnRhUU
         oYQAkNfFOhpk4vBnJi6aKqbOwJ3DlivcQRbqABo4itQf8eyzxcGEuYMsGZn4kVSkdH
         6/7vTMPJ+Nulbh/59OpD4/q6OezVOaTvY0Y5x8tdaVDFbo7++65TpCIq5dmdklUwgU
         7IKy17LE6f12s/8gX8x8cgS2/hUhp01nwuKC+GzKbVvG4YZ5SnVKY8Nk5M4lw2NNWh
         o8i2vBjRIotZw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OegJDeV3NoUE; Thu,  5 Sep 2019 23:13:08 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 949C232CD7D;
        Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state racy load
Date:   Thu,  5 Sep 2019 23:13:00 -0400
Message-Id: <20190906031300.1647-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The membarrier_state field is located within the mm_struct, which
is not guaranteed to exist when used from runqueue-lock-free iteration
on runqueues by the membarrier system call.

Copy the membarrier_state from the mm_struct into the scheduler runqueue
in the scheduler prepare task switch when the scheduler switches between
mm.

When registering membarrier for mm, after setting the registration bit
in the mm membarrier state, issue a synchronize_rcu() to ensure the
scheduler observes the change. In order to take care of the case
where a runqueue keeps executing the target mm without swapping to
other mm, iterate over each runqueue and issue an IPI to copy the
membarrier_state from the mm_struct into each runqueue which have the
same mm which state has just been modified.

Move the mm membarrier_state field closer to pgd in mm_struct so sched
switch prepare hits a cache line which is already touched by the
scheduler switch_mm.

membarrier_execve() hook now needs to clear the runqueue's membarrier
state in addition to clear the mm membarrier state, so move its
implementation into the scheduler membarrier code so it can access the
runqueue structure.

As suggested by Linus, move all membarrier.c RCU read-side locks outside
of the for each cpu loops. In fact, it turns out that
membarrier_global_expedited() does not need the RCU read-side critical
section because it does not need to use task_rcu_dereference() anymore,
relying instead on the runqueue's membarrier_state.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/mm_types.h  |   7 +-
 include/linux/sched/mm.h  |   6 +-
 kernel/sched/core.c       |   1 +
 kernel/sched/membarrier.c | 141 +++++++++++++++++++++++++++-----------
 kernel/sched/sched.h      |  33 +++++++++
 5 files changed, 141 insertions(+), 47 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a7a1083b6fb..7020572eb605 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -382,6 +382,9 @@ struct mm_struct {
 		unsigned long task_size;	/* size of task vm space */
 		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
+#ifdef CONFIG_MEMBARRIER
+		atomic_t membarrier_state;
+#endif
 
 		/**
 		 * @mm_users: The number of users including userspace.
@@ -452,9 +455,7 @@ struct mm_struct {
 		unsigned long flags; /* Must use atomic bitops to access */
 
 		struct core_state *core_state; /* coredumping support */
-#ifdef CONFIG_MEMBARRIER
-		atomic_t membarrier_state;
-#endif
+
 #ifdef CONFIG_AIO
 		spinlock_t			ioctx_lock;
 		struct kioctx_table __rcu	*ioctx_table;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 8557ec664213..7070dbef8066 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -370,10 +370,8 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 	sync_core_before_usermode();
 }
 
-static inline void membarrier_execve(struct task_struct *t)
-{
-	atomic_set(&t->mm->membarrier_state, 0);
-}
+extern void membarrier_execve(struct task_struct *t);
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578118d6..1cffc1aa403c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3038,6 +3038,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	membarrier_prepare_task_switch(rq, prev, next);
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 7e0a0d6535f3..5744c300d29e 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -30,6 +30,28 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_sync_rq_state(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *) info;
+
+	if (current->mm != mm)
+		return;
+	WRITE_ONCE(this_rq()->membarrier_state,
+		   atomic_read(&mm->membarrier_state));
+	/*
+	 * Issue a memory barrier after setting MEMBARRIER_STATE_GLOBAL_EXPEDITED
+	 * in the current runqueue to guarantee that no memory access following
+	 * registration is reordered before registration.
+	 */
+	smp_mb();
+}
+
+void membarrier_execve(struct task_struct *t)
+{
+	atomic_set(&t->mm->membarrier_state, 0);
+	WRITE_ONCE(this_rq()->membarrier_state, 0);
+}
+
 static int membarrier_global_expedited(void)
 {
 	int cpu;
@@ -57,8 +79,6 @@ static int membarrier_global_expedited(void)
 
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct task_struct *p;
-
 		/*
 		 * Skipping the current CPU is OK even through we can be
 		 * migrated at any point. The current CPU, at the point
@@ -70,16 +90,13 @@ static int membarrier_global_expedited(void)
 		if (cpu == raw_smp_processor_id())
 			continue;
 
-		rcu_read_lock();
-		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
+		if (READ_ONCE(cpu_rq(cpu)->membarrier_state) &
+		    MEMBARRIER_STATE_GLOBAL_EXPEDITED) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
 			else
 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
 		}
-		rcu_read_unlock();
 	}
 	if (!fallback) {
 		preempt_disable();
@@ -136,6 +153,7 @@ static int membarrier_private_expedited(int flags)
 	}
 
 	cpus_read_lock();
+	rcu_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
 
@@ -149,7 +167,6 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
-		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
 		if (p && p->mm == current->mm) {
 			if (!fallback)
@@ -157,8 +174,8 @@ static int membarrier_private_expedited(int flags)
 			else
 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
 		}
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 	if (!fallback) {
 		preempt_disable();
 		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
@@ -177,6 +194,71 @@ static int membarrier_private_expedited(int flags)
 	return 0;
 }
 
+static void sync_runqueues_membarrier_state(struct mm_struct *mm)
+{
+	int membarrier_state = atomic_read(&mm->membarrier_state);
+	bool fallback = false;
+	cpumask_var_t tmpmask;
+	int cpu;
+
+	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1) {
+		WRITE_ONCE(this_rq()->membarrier_state, membarrier_state);
+
+		/*
+		 * For single mm user, we can simply issue a memory barrier
+		 * after setting MEMBARRIER_STATE_GLOBAL_EXPEDITED in the
+		 * mm and in the current runqueue to guarantee that no memory
+		 * access following registration is reordered before
+		 * registration.
+		 */
+		smp_mb();
+		return;
+	}
+
+	/*
+	 * For mm with multiple users, we need to ensure all future
+	 * scheduler executions will observe @mm's new membarrier
+	 * state.
+	 */
+	synchronize_rcu();
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
+		/* Fallback for OOM. */
+		fallback = true;
+	}
+
+	/*
+	 * For each cpu runqueue, if the task's mm match @mm, ensure that all
+	 * @mm's membarrier state set bits are also set in in the runqueue's
+	 * membarrier state. This ensures that a runqueue scheduling
+	 * between threads which are users of @mm has its membarrier state
+	 * updated.
+	 */
+	cpus_read_lock();
+	rcu_read_lock();
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct task_struct *p;
+
+		p = task_rcu_dereference(&rq->curr);
+		if (p && p->mm == mm) {
+			if (!fallback)
+				__cpumask_set_cpu(cpu, tmpmask);
+			else
+				smp_call_function_single(cpu, ipi_sync_rq_state,
+							 mm, 1);
+		}
+	}
+	rcu_read_unlock();
+	if (!fallback) {
+		preempt_disable();
+		smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);
+		preempt_enable();
+		free_cpumask_var(tmpmask);
+	}
+	cpus_read_unlock();
+}
+
 static int membarrier_register_global_expedited(void)
 {
 	struct task_struct *p = current;
@@ -186,23 +268,7 @@ static int membarrier_register_global_expedited(void)
 	    MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &mm->membarrier_state);
-	if (atomic_read(&mm->mm_users) == 1) {
-		/*
-		 * For single mm user, single threaded process, we can
-		 * simply issue a memory barrier after setting
-		 * MEMBARRIER_STATE_GLOBAL_EXPEDITED to guarantee that
-		 * no memory access following registration is reordered
-		 * before registration.
-		 */
-		smp_mb();
-	} else {
-		/*
-		 * For multi-mm user threads, we need to ensure all
-		 * future scheduler executions will observe the new
-		 * thread flag state for this mm.
-		 */
-		synchronize_rcu();
-	}
+	sync_runqueues_membarrier_state(mm);
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
 		  &mm->membarrier_state);
 
@@ -213,12 +279,14 @@ static int membarrier_register_private_expedited(int flags)
 {
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
-	int state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY;
+	int ready_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED;
 
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
-		state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
+		ready_state =
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
 	}
 
 	/*
@@ -226,20 +294,13 @@ static int membarrier_register_private_expedited(int flags)
 	 * groups, which use the same mm. (CLONE_VM but not
 	 * CLONE_THREAD).
 	 */
-	if ((atomic_read(&mm->membarrier_state) & state) == state)
+	if ((atomic_read(&mm->membarrier_state) & ready_state) == ready_state)
 		return 0;
-	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
-		atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE,
-			  &mm->membarrier_state);
-	if (atomic_read(&mm->mm_users) != 1) {
-		/*
-		 * Ensure all future scheduler executions will observe the
-		 * new thread flag state for this process.
-		 */
-		synchronize_rcu();
-	}
-	atomic_or(state, &mm->membarrier_state);
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	atomic_or(set_state, &mm->membarrier_state);
+	sync_runqueues_membarrier_state(mm);
+	atomic_or(ready_state, &mm->membarrier_state);
 
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..ac26baa855e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -907,6 +907,10 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_MEMBARRIER
+	int membarrier_state;
+#endif
+
 #ifdef CONFIG_SMP
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
@@ -2423,3 +2427,32 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+#ifdef CONFIG_MEMBARRIER
+/*
+ * The scheduler provides memory barriers required by membarrier between:
+ * - prior user-space memory accesses and store to rq->membarrier_state,
+ * - store to rq->membarrier_state and following user-space memory accesses.
+ * In the same way it provides those guarantees around store to rq->curr.
+ */
+static inline void membarrier_prepare_task_switch(struct rq *rq,
+						  struct task_struct *prev,
+						  struct task_struct *next)
+{
+	int membarrier_state = 0;
+	struct mm_struct *next_mm = next->mm;
+
+	if (prev->mm == next_mm)
+		return;
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (READ_ONCE(rq->membarrier_state) != membarrier_state)
+		WRITE_ONCE(rq->membarrier_state, membarrier_state);
+}
+#else
+static inline void membarrier_prepare_task_switch(struct rq *rq,
+						  struct task_struct *prev,
+						  struct task_struct *next)
+{
+}
+#endif
-- 
2.17.1

