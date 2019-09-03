Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34B221883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qkU5IxFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfICULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:11:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:39168 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICULu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:11:50 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F320B2B2575;
        Tue,  3 Sep 2019 16:11:48 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id rvY9gHCSTsx5; Tue,  3 Sep 2019 16:11:48 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1CF892B2570;
        Tue,  3 Sep 2019 16:11:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1CF892B2570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567541508;
        bh=57WgWCutST52GXRh12pskRN7awprTjq+ZKG/doskusE=;
        h=From:To:Date:Message-Id;
        b=qkU5IxFt6HMH0dqvTxgm004rBycM2LaECACvPJ0zi/9ys6zyVv8rPWuUm7Wug0nqh
         SjHLX3KDgOheZQ3e8km3u/1yw31cTJxRBFscxO2CD7R2eo2jpSlhpQ5/bDU0V5pVlO
         6/5d3kZDhoSQP/lzx7GoeFozaWY6vd1gH6PIYnu0FkJP8ZnFfqCNJHEpCwskSZr0sN
         ShsSWt9C3JWSXrHRj5A+ac/UyCtQLdzD5LRjbvAIDlPLK70R0kywTFt1TNNpPlU6/m
         WFO2fYWBKoom0clHV6dutMGZ3W9OF99byrgsJWOngEGQd1mkNuV7hs6L2x7Ck7olNZ
         UpYhKTDqnqVzw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kjCdBeFWk0a8; Tue,  3 Sep 2019 16:11:48 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id BD8BB2B256B;
        Tue,  3 Sep 2019 16:11:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state racy load
Date:   Tue,  3 Sep 2019 16:11:34 -0400
Message-Id: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The membarrier_state field is located within the mm_struct, which
is not guaranteed to exist when used from runqueue-lock-free iteration
on runqueues by the membarrier system call.

Copy the membarrier_state from the mm_struct into the next task_struct
in the scheduler prepare task switch. Upon membarrier registration,
iterate over each runqueue and copy the membarrier_state from the
mm_struct into all currently running task struct which have the same mm
as the current task.

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
 include/linux/sched.h     |  4 ++
 include/linux/sched/mm.h  | 13 +++++++
 kernel/sched/core.c       |  1 +
 kernel/sched/membarrier.c | 78 ++++++++++++++++++++++++++++-----------
 4 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..e24d52a4c37a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1130,6 +1130,10 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_MEMBARRIER
+	atomic_t membarrier_state;
+#endif
+
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_sig;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4a7944078cc3..3577cd7b3dbb 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -371,7 +371,17 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 static inline void membarrier_execve(struct task_struct *t)
 {
 	atomic_set(&t->mm->membarrier_state, 0);
+	atomic_set(&t->membarrier_state, 0);
 }
+
+static inline void membarrier_prepare_task_switch(struct task_struct *t)
+{
+	if (!t->mm)
+		return;
+	atomic_set(&t->membarrier_state,
+		   atomic_read(&t->mm->membarrier_state));
+}
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
@@ -386,6 +396,9 @@ static inline void membarrier_execve(struct task_struct *t)
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 }
+static inline void membarrier_prepare_task_switch(struct task_struct *t)
+{
+}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578118d6..8d4f1f20db15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3038,6 +3038,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	membarrier_prepare_task_switch(next);
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..d564ca1b5d69 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -72,8 +72,8 @@ static int membarrier_global_expedited(void)
 
 		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
+		if (p && (atomic_read(&p->membarrier_state) &
+			  MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
 			else
@@ -177,6 +177,46 @@ static int membarrier_private_expedited(int flags)
 	return 0;
 }
 
+static void sync_other_runqueues_membarrier_state(struct mm_struct *mm)
+{
+	int cpu;
+
+	if (num_online_cpus() == 1)
+		return;
+
+	/*
+	 * For multi-mm user threads, we need to ensure all future scheduler
+	 * executions will observe @mm's new membarrier state.
+	 */
+	synchronize_rcu();
+
+	/*
+	 * For each cpu runqueue (except the current cpu), if the task's mm
+	 * match @mm, ensure that all @mm's membarrier state set bits are also
+	 * set in in the runqueue's current task membarrier state.
+	 *
+	 * Use an atomic_or() to set the task membarrier state, thus ensuring
+	 * this operation is always additive. This is important in case many
+	 * different membarrier registration commands are invoked concurrently,
+	 * given that they do not hold the mmap_sem.
+	 */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct task_struct *p;
+
+		/* Skip current CPU. */
+		if (cpu == raw_smp_processor_id())
+			continue;
+		rcu_read_lock();
+		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
+		if (p && p->mm == mm)
+			atomic_or(atomic_read(&mm->membarrier_state),
+				  &p->membarrier_state);
+		rcu_read_unlock();
+	}
+	cpus_read_unlock();
+}
+
 static int membarrier_register_global_expedited(void)
 {
 	struct task_struct *p = current;
@@ -186,6 +226,8 @@ static int membarrier_register_global_expedited(void)
 	    MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &mm->membarrier_state);
+	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &p->membarrier_state);
+
 	if (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1) {
 		/*
 		 * For single mm user, single threaded process, we can
@@ -196,12 +238,7 @@ static int membarrier_register_global_expedited(void)
 		 */
 		smp_mb();
 	} else {
-		/*
-		 * For multi-mm user threads, we need to ensure all
-		 * future scheduler executions will observe the new
-		 * thread flag state for this mm.
-		 */
-		synchronize_rcu();
+		sync_other_runqueues_membarrier_state(mm);
 	}
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
 		  &mm->membarrier_state);
@@ -213,12 +250,14 @@ static int membarrier_register_private_expedited(int flags)
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
@@ -226,20 +265,15 @@ static int membarrier_register_private_expedited(int flags)
 	 * groups, which use the same mm. (CLONE_VM but not
 	 * CLONE_THREAD).
 	 */
-	if (atomic_read(&mm->membarrier_state) & state)
+	if ((atomic_read(&mm->membarrier_state) & ready_state))
 		return 0;
-	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
-		atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE,
-			  &mm->membarrier_state);
-	if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
-		/*
-		 * Ensure all future scheduler executions will observe the
-		 * new thread flag state for this process.
-		 */
-		synchronize_rcu();
-	}
-	atomic_or(state, &mm->membarrier_state);
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	atomic_or(set_state, &mm->membarrier_state);
+	atomic_or(set_state, &p->membarrier_state);
+	if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1))
+		sync_other_runqueues_membarrier_state(mm);
+	atomic_or(ready_state, &mm->membarrier_state);
 
 	return 0;
 }
-- 
2.17.1

