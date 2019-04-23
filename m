Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADA420674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfDWO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:26:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDWO0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:26:54 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hIwNf-0000Vw-S0; Tue, 23 Apr 2019 16:26:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched: Provide a pointer to the valid CPU mask
Date:   Tue, 23 Apr 2019 16:26:36 +0200
Message-Id: <20190423142636.14347-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4b53a3412d66 ("sched/core: Remove the tsk_nr_cpus_allowed()
wrapper") the tsk_nr_cpus_allowed() wrapper was removed. There was not
much difference in !RT but in RT we used this to implement
migrate_disable(). Within a migrate_disable() section the CPU mask is
restricted to single CPU while the "normal" CPU mask remains untouched.

As an alternative implementation Ingo suggested to use
	struct task_struct {
		const cpumask_t		*cpus_ptr;
		cpumask_t		cpus_mask;
        };
with
	t->cpus_allowed_ptr = &t->cpus_allowed;

In -RT we then can switch the cpus_ptr to
	t->cpus_allowed_ptr = &cpumask_of(task_cpu(p));

in a migration disabled region. The rules are simple:
- Code that 'uses' ->cpus_allowed would use the pointer.
- Code that 'modifies' ->cpus_allowed would use the direct mask.

I proposed this patch as a series earlier and it was shutdown due to the
migrate_disable() bits. It has been said that migrate_disable() should
only be used with RT and thus not introduced without it.
I hereby propose only the mask CPU-bits.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/ia64/kernel/mca.c                     |  2 +-
 arch/mips/include/asm/switch_to.h          |  4 +--
 arch/mips/kernel/mips-mt-fpaff.c           |  2 +-
 arch/mips/kernel/traps.c                   |  6 ++--
 arch/powerpc/platforms/cell/spufs/sched.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c  |  2 +-
 drivers/infiniband/hw/hfi1/affinity.c      |  6 ++--
 drivers/infiniband/hw/hfi1/sdma.c          |  3 +-
 drivers/infiniband/hw/qib/qib_file_ops.c   |  7 ++--
 fs/proc/array.c                            |  4 +--
 include/linux/sched.h                      |  5 +--
 init/init_task.c                           |  3 +-
 kernel/cgroup/cpuset.c                     |  2 +-
 kernel/fork.c                              |  2 ++
 kernel/sched/core.c                        | 40 +++++++++++-----------
 kernel/sched/cpudeadline.c                 |  4 +--
 kernel/sched/cpupri.c                      |  4 +--
 kernel/sched/deadline.c                    |  6 ++--
 kernel/sched/fair.c                        | 34 +++++++++---------
 kernel/sched/rt.c                          |  4 +--
 kernel/trace/trace_hwlat.c                 |  2 +-
 lib/smp_processor_id.c                     |  2 +-
 samples/trace_events/trace-events-sample.c |  2 +-
 23 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 5cabb3fd159ff..7b4b58c168d59 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1830,7 +1830,7 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 	ti->cpu = cpu;
 	p->stack = ti;
 	p->state = TASK_UNINTERRUPTIBLE;
-	cpumask_set_cpu(cpu, &p->cpus_allowed);
+	cpumask_set_cpu(cpu, &p->cpus_mask);
 	INIT_LIST_HEAD(&p->tasks);
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 0f813bb753c63..09cbe9042828f 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -42,7 +42,7 @@ extern struct task_struct *ll_task;
  * inline to try to keep the overhead down. If we have been forced to run on
  * a "CPU" with an FPU because of a previous high level of FP computation,
  * but did not actually use the FPU during the most recent time-slice (CU1
- * isn't set), we undo the restriction on cpus_allowed.
+ * isn't set), we undo the restriction on cpus_mask.
  *
  * We're not calling set_cpus_allowed() here, because we have no need to
  * force prompt migration - we're already switching the current CPU to a
@@ -57,7 +57,7 @@ do {									\
 	    test_ti_thread_flag(__prev_ti, TIF_FPUBOUND) &&		\
 	    (!(KSTK_STATUS(prev) & ST0_CU1))) {				\
 		clear_ti_thread_flag(__prev_ti, TIF_FPUBOUND);		\
-		prev->cpus_allowed = prev->thread.user_cpus_allowed;	\
+		prev->cpus_mask = prev->thread.user_cpus_allowed;	\
 	}								\
 	next->thread.emulated_fp = 0;					\
 } while(0)
diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index a7c0f97e4b0d6..1a08428eedcf1 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -177,7 +177,7 @@ asmlinkage long mipsmt_sys_sched_getaffinity(pid_t pid, unsigned int len,
 	if (retval)
 		goto out_unlock;
 
-	cpumask_or(&allowed, &p->thread.user_cpus_allowed, &p->cpus_allowed);
+	cpumask_or(&allowed, &p->thread.user_cpus_allowed, p->cpus_ptr);
 	cpumask_and(&mask, &allowed, cpu_active_mask);
 
 out_unlock:
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 98ca55d622018..fb1b569e686d6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -891,12 +891,12 @@ static void mt_ase_fp_affinity(void)
 		 * restricted the allowed set to exclude any CPUs with FPUs,
 		 * we'll skip the procedure.
 		 */
-		if (cpumask_intersects(&current->cpus_allowed, &mt_fpu_cpumask)) {
+		if (cpumask_intersects(&current->cpus_mask, &mt_fpu_cpumask)) {
 			cpumask_t tmask;
 
 			current->thread.user_cpus_allowed
-				= current->cpus_allowed;
-			cpumask_and(&tmask, &current->cpus_allowed,
+				= current->cpus_mask;
+			cpumask_and(&tmask, &current->cpus_mask,
 				    &mt_fpu_cpumask);
 			set_cpus_allowed_ptr(current, &tmask);
 			set_thread_flag(TIF_FPUBOUND);
diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 9fcccb4490b93..a24010d4f35e5 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -141,7 +141,7 @@ void __spu_update_sched_info(struct spu_context *ctx)
 	 * runqueue. The context will be rescheduled on the proper node
 	 * if it is timesliced or preempted.
 	 */
-	cpumask_copy(&ctx->cpus_allowed, &current->cpus_allowed);
+	cpumask_copy(&ctx->cpus_allowed, current->cpus_ptr);
 
 	/* Save the current cpu id for spu interrupt routing. */
 	ctx->last_ran = raw_smp_processor_id();
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 604c0e3bcc830..f68baccc69f0a 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1503,7 +1503,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * may be scheduled elsewhere and invalidate entries in the
 	 * pseudo-locked region.
 	 */
-	if (!cpumask_subset(&current->cpus_allowed, &plr->d->cpu_mask)) {
+	if (!cpumask_subset(current->cpus_ptr, &plr->d->cpu_mask)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 4fe662c3bbc1c..c142b23bb4018 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1038,7 +1038,7 @@ int hfi1_get_proc_affinity(int node)
 	struct hfi1_affinity_node *entry;
 	cpumask_var_t diff, hw_thread_mask, available_mask, intrs_mask;
 	const struct cpumask *node_mask,
-		*proc_mask = &current->cpus_allowed;
+		*proc_mask = current->cpus_ptr;
 	struct hfi1_affinity_node_list *affinity = &node_affinity;
 	struct cpu_mask_set *set = &affinity->proc;
 
@@ -1046,7 +1046,7 @@ int hfi1_get_proc_affinity(int node)
 	 * check whether process/context affinity has already
 	 * been set
 	 */
-	if (cpumask_weight(proc_mask) == 1) {
+	if (current->nr_cpus_allowed == 1) {
 		hfi1_cdbg(PROC, "PID %u %s affinity set to CPU %*pbl",
 			  current->pid, current->comm,
 			  cpumask_pr_args(proc_mask));
@@ -1057,7 +1057,7 @@ int hfi1_get_proc_affinity(int node)
 		cpu = cpumask_first(proc_mask);
 		cpumask_set_cpu(cpu, &set->used);
 		goto done;
-	} else if (cpumask_weight(proc_mask) < cpumask_weight(&set->mask)) {
+	} else if (current->nr_cpus_allowed < cpumask_weight(&set->mask)) {
 		hfi1_cdbg(PROC, "PID %u %s affinity set to CPU set(s) %*pbl",
 			  current->pid, current->comm,
 			  cpumask_pr_args(proc_mask));
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index b0110728f5418..7e8139ee0cc1b 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -855,14 +855,13 @@ struct sdma_engine *sdma_select_user_engine(struct hfi1_devdata *dd,
 {
 	struct sdma_rht_node *rht_node;
 	struct sdma_engine *sde = NULL;
-	const struct cpumask *current_mask = &current->cpus_allowed;
 	unsigned long cpu_id;
 
 	/*
 	 * To ensure that always the same sdma engine(s) will be
 	 * selected make sure the process is pinned to this CPU only.
 	 */
-	if (cpumask_weight(current_mask) != 1)
+	if (current->nr_cpus_allowed != 1)
 		goto out;
 
 	cpu_id = smp_processor_id();
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 78fa634de98a3..27b6e664e59de 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -1142,7 +1142,7 @@ static __poll_t qib_poll(struct file *fp, struct poll_table_struct *pt)
 static void assign_ctxt_affinity(struct file *fp, struct qib_devdata *dd)
 {
 	struct qib_filedata *fd = fp->private_data;
-	const unsigned int weight = cpumask_weight(&current->cpus_allowed);
+	const unsigned int weight = current->nr_cpus_allowed;
 	const struct cpumask *local_mask = cpumask_of_pcibus(dd->pcidev->bus);
 	int local_cpu;
 
@@ -1623,9 +1623,8 @@ static int qib_assign_ctxt(struct file *fp, const struct qib_user_info *uinfo)
 		ret = find_free_ctxt(i_minor - 1, fp, uinfo);
 	else {
 		int unit;
-		const unsigned int cpu = cpumask_first(&current->cpus_allowed);
-		const unsigned int weight =
-			cpumask_weight(&current->cpus_allowed);
+		const unsigned int cpu = cpumask_first(current->cpus_ptr);
+		const unsigned int weight = current->nr_cpus_allowed;
 
 		if (weight == 1 && !test_bit(cpu, qib_cpulist))
 			if (!find_hca(cpu, &unit) && unit >= 0)
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2edbb657f859b..84908556ea586 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -381,9 +381,9 @@ static inline void task_context_switch_counts(struct seq_file *m,
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
-		   cpumask_pr_args(&task->cpus_allowed));
+		   cpumask_pr_args(task->cpus_ptr));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
-		   cpumask_pr_args(&task->cpus_allowed));
+		   cpumask_pr_args(task->cpus_ptr));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a15388..bf1e9e4f49297 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -652,7 +652,8 @@ struct task_struct {
 
 	unsigned int			policy;
 	int				nr_cpus_allowed;
-	cpumask_t			cpus_allowed;
+	const cpumask_t			*cpus_ptr;
+	cpumask_t			cpus_mask;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1399,7 +1400,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
 #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
-#define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
+#define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
diff --git a/init/init_task.c b/init/init_task.c
index c70ef656d0f40..3c27c0efa3166 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -72,7 +72,8 @@ struct task_struct init_task
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
 	.policy		= SCHED_NORMAL,
-	.cpus_allowed	= CPU_MASK_ALL,
+	.cpus_ptr	= &init_task.cpus_mask,
+	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4834c4214e9cd..d4da5e7610017 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2830,7 +2830,7 @@ static void cpuset_fork(struct task_struct *task)
 	if (task_css_is_root(task, cpuset_cgrp_id))
 		return;
 
-	set_cpus_allowed_ptr(task, &current->cpus_allowed);
+	set_cpus_allowed_ptr(task, current->cpus_ptr);
 	task->mems_allowed = current->mems_allowed;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b5..19aa3da17f7e7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -890,6 +890,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
 #endif
+	if (orig->cpus_ptr == &orig->cpus_mask)
+		tsk->cpus_ptr = &tsk->cpus_mask;
 
 	/*
 	 * One for us, one for whoever does the "release_task()" (usually
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda4..fa2f1e95f0a43 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -925,7 +925,7 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
-	if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
 	if (is_per_cpu_kthread(p))
@@ -1020,7 +1020,7 @@ static int migration_cpu_stop(void *data)
 	local_irq_disable();
 	/*
 	 * We need to explicitly wake pending tasks before running
-	 * __migrate_task() such that we will not miss enforcing cpus_allowed
+	 * __migrate_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
 	sched_ttwu_pending();
@@ -1051,7 +1051,7 @@ static int migration_cpu_stop(void *data)
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
-	cpumask_copy(&p->cpus_allowed, new_mask);
+	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
@@ -1121,7 +1121,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_allowed, new_mask))
+	if (cpumask_equal(p->cpus_ptr, new_mask))
 		goto out;
 
 	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
@@ -1284,10 +1284,10 @@ static int migrate_swap_stop(void *data)
 	if (task_cpu(arg->src_task) != arg->src_cpu)
 		goto unlock;
 
-	if (!cpumask_test_cpu(arg->dst_cpu, &arg->src_task->cpus_allowed))
+	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
 		goto unlock;
 
-	if (!cpumask_test_cpu(arg->src_cpu, &arg->dst_task->cpus_allowed))
+	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
 		goto unlock;
 
 	__migrate_swap_task(arg->src_task, arg->dst_cpu);
@@ -1329,10 +1329,10 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 	if (!cpu_active(arg.src_cpu) || !cpu_active(arg.dst_cpu))
 		goto out;
 
-	if (!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
+	if (!cpumask_test_cpu(arg.dst_cpu, arg.src_task->cpus_ptr))
 		goto out;
 
-	if (!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
+	if (!cpumask_test_cpu(arg.src_cpu, arg.dst_task->cpus_ptr))
 		goto out;
 
 	trace_sched_swap_numa(cur, arg.src_cpu, p, arg.dst_cpu);
@@ -1477,7 +1477,7 @@ void kick_process(struct task_struct *p)
 EXPORT_SYMBOL_GPL(kick_process);
 
 /*
- * ->cpus_allowed is protected by both rq->lock and p->pi_lock
+ * ->cpus_ptr is protected by both rq->lock and p->pi_lock
  *
  * A few notes on cpu_active vs cpu_online:
  *
@@ -1517,14 +1517,14 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		for_each_cpu(dest_cpu, nodemask) {
 			if (!cpu_active(dest_cpu))
 				continue;
-			if (cpumask_test_cpu(dest_cpu, &p->cpus_allowed))
+			if (cpumask_test_cpu(dest_cpu, p->cpus_ptr))
 				return dest_cpu;
 		}
 	}
 
 	for (;;) {
 		/* Any allowed, online CPU? */
-		for_each_cpu(dest_cpu, &p->cpus_allowed) {
+		for_each_cpu(dest_cpu, p->cpus_ptr) {
 			if (!is_cpu_allowed(p, dest_cpu))
 				continue;
 
@@ -1568,7 +1568,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 }
 
 /*
- * The caller (fork, wakeup) owns p->pi_lock, ->cpus_allowed is stable.
+ * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
 int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
@@ -1578,11 +1578,11 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	if (p->nr_cpus_allowed > 1)
 		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
 	else
-		cpu = cpumask_any(&p->cpus_allowed);
+		cpu = cpumask_any(p->cpus_ptr);
 
 	/*
 	 * In order not to call set_task_cpu() on a blocking task we need
-	 * to rely on ttwu() to place the task on a valid ->cpus_allowed
+	 * to rely on ttwu() to place the task on a valid ->cpus_ptr
 	 * CPU.
 	 *
 	 * Since this is common to all placement strategies, this lives here.
@@ -2453,7 +2453,7 @@ void wake_up_new_task(struct task_struct *p)
 #ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
-	 *  - cpus_allowed can change in the fork path
+	 *  - cpus_ptr can change in the fork path
 	 *  - any previously selected CPU might disappear through hotplug
 	 *
 	 * Use __set_task_cpu() to avoid calling sched_class::migrate_task_rq,
@@ -4319,7 +4319,7 @@ static int __sched_setscheduler(struct task_struct *p,
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, &p->cpus_allowed) ||
+			if (!cpumask_subset(span, p->cpus_ptr) ||
 			    rq->rd->dl_bw.bw == 0) {
 				task_rq_unlock(rq, p, &rf);
 				return -EPERM;
@@ -4918,7 +4918,7 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
 		goto out_unlock;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	cpumask_and(mask, &p->cpus_allowed, cpu_active_mask);
+	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
 out_unlock:
@@ -5495,7 +5495,7 @@ int task_can_attach(struct task_struct *p,
 	 * allowed nodes is unnecessary.  Thus, cpusets are not
 	 * applicable for such threads.  This prevents checking for
 	 * success of set_cpus_allowed_ptr() on all attached tasks
-	 * before cpus_allowed may be changed.
+	 * before cpus_mask may be changed.
 	 */
 	if (p->flags & PF_NO_SETAFFINITY) {
 		ret = -EINVAL;
@@ -5522,7 +5522,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (curr_cpu == target_cpu)
 		return 0;
 
-	if (!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
+	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
 	/* TODO: This is not properly updating schedstats */
@@ -5660,7 +5660,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		put_prev_task(rq, next);
 
 		/*
-		 * Rules for changing task_struct::cpus_allowed are holding
+		 * Rules for changing task_struct::cpus_mask are holding
 		 * both pi_lock and rq->lock, such that holding either
 		 * stabilizes the mask.
 		 *
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 50316455ea66a..d57fb2f8ae67b 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -124,14 +124,14 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
+	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
 		return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
+		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index daaadf939ccb1..f7d2c10b4c92e 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -98,11 +98,11 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 		if (skip)
 			continue;
 
-		if (cpumask_any_and(&p->cpus_allowed, vec->mask) >= nr_cpu_ids)
+		if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
 			continue;
 
 		if (lowest_mask) {
-			cpumask_and(lowest_mask, &p->cpus_allowed, vec->mask);
+			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
 
 			/*
 			 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43901fa3f2693..c1ef308610685 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -538,7 +538,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		 * If we cannot preempt any rq, fall back to pick any
 		 * online CPU:
 		 */
-		cpu = cpumask_any_and(cpu_active_mask, &p->cpus_allowed);
+		cpu = cpumask_any_and(cpu_active_mask, p->cpus_ptr);
 		if (cpu >= nr_cpu_ids) {
 			/*
 			 * Failed to find any suitable CPU.
@@ -1824,7 +1824,7 @@ static void set_curr_task_dl(struct rq *rq)
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_allowed))
+	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 	return 0;
 }
@@ -1974,7 +1974,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed) ||
+				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4d9e14bf1389..779a6fd053869 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1621,7 +1621,7 @@ static void task_numa_compare(struct task_numa_env *env,
 	 * be incurred if the tasks were swapped.
 	 */
 	/* Skip this swap candidate if cannot move to the source cpu */
-	if (!cpumask_test_cpu(env->src_cpu, &cur->cpus_allowed))
+	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
 		goto unlock;
 
 	/*
@@ -1718,7 +1718,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
 		env->dst_cpu = cpu;
@@ -5828,7 +5828,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 
 		/* Skip over this group if it has no CPUs allowed */
 		if (!cpumask_intersects(sched_group_span(group),
-					&p->cpus_allowed))
+					p->cpus_ptr))
 			continue;
 
 		local_group = cpumask_test_cpu(this_cpu,
@@ -5960,7 +5960,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		return cpumask_first(sched_group_span(group));
 
 	/* Traverse only the allowed CPUs */
-	for_each_cpu_and(i, sched_group_span(group), &p->cpus_allowed) {
+	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
@@ -6000,7 +6000,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 {
 	int new_cpu = cpu;
 
-	if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
+	if (!cpumask_intersects(sched_domain_span(sd), p->cpus_ptr))
 		return prev_cpu;
 
 	/*
@@ -6117,7 +6117,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	if (!test_idle_cores(target, false))
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
@@ -6151,7 +6151,7 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
@@ -6214,7 +6214,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
 			return -1;
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu))
 			break;
@@ -6251,7 +6251,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    available_idle_cpu(recent_used_cpu) &&
-	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
+	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
 		 * candidate for the next wake:
@@ -6597,7 +6597,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		int max_spare_cap_cpu = -1;
 
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
-			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
 			/* Skip CPUs that will be overutilized. */
@@ -6686,7 +6686,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		}
 
 		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
-			      cpumask_test_cpu(cpu, &p->cpus_allowed);
+			      cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
 	rcu_read_lock();
@@ -7442,14 +7442,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
+	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 3) running (obviously), or
 	 * 4) are cache-hot on their current CPU.
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
-	if (!cpumask_test_cpu(env->dst_cpu, &p->cpus_allowed)) {
+	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
 		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
@@ -7469,7 +7469,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 		/* Prevent to re-select dst_cpu via env's CPUs: */
 		for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
-			if (cpumask_test_cpu(cpu, &p->cpus_allowed)) {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
 				env->flags |= LBF_DST_PINNED;
 				env->new_dst_cpu = cpu;
 				break;
@@ -8098,7 +8098,7 @@ static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 
 /*
  * Group imbalance indicates (and tries to solve) the problem where balancing
- * groups is inadequate due to ->cpus_allowed constraints.
+ * groups is inadequate due to ->cpus_ptr constraints.
  *
  * Imagine a situation of two groups of 4 CPUs each and 4 tasks each with a
  * cpumask covering 1 CPU of the first group and 3 CPUs of the second group.
@@ -8767,7 +8767,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	/*
 	 * If the busiest group is imbalanced the below checks don't
 	 * work because they assume all things are equal, which typically
-	 * isn't true due to cpus_allowed constraints and the like.
+	 * isn't true due to cpus_ptr constraints and the like.
 	 */
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
@@ -9209,7 +9209,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * if the curr task on busiest CPU can't be
 			 * moved to this_cpu:
 			 */
-			if (!cpumask_test_cpu(this_cpu, &busiest->curr->cpus_allowed)) {
+			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
 				env.flags |= LBF_ALL_PINNED;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 90fa23d36565d..9b6d48f7b742b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1614,7 +1614,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_allowed))
+	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 
 	return 0;
@@ -1751,7 +1751,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
+				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 1e6db9cbe4dc5..fa95139445b28 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -277,7 +277,7 @@ static void move_to_next_cpu(void)
 	 * of this thread, than stop migrating for the duration
 	 * of the current test.
 	 */
-	if (!cpumask_equal(current_mask, &current->cpus_allowed))
+	if (!cpumask_equal(current_mask, current->cpus_ptr))
 		goto disable;
 
 	get_online_cpus();
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 157d9e31f6c21..60ba93fc42ce3 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,7 +23,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(&current->cpus_allowed, cpumask_of(this_cpu)))
+	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
 		goto out;
 
 	/*
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 5522692100ba0..8b4be8e1802a5 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -33,7 +33,7 @@ static void simple_thread_func(int cnt)
 
 	/* Silly tracepoints */
 	trace_foo_bar("hello", cnt, array, random_strings[len],
-		      &current->cpus_allowed);
+		      current->cpus_ptr);
 
 	trace_foo_with_template_simple("HELLO", cnt);
 
-- 
2.20.1

