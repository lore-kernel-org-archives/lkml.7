Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C1BECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F253520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfJOK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:29:05 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43028 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbfJOK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:29:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tf7PwGJ_1571135337;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tf7PwGJ_1571135337)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 18:28:57 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 7/7] rcu: splite tasks_rcu to tasks.c
Date:   Tue, 15 Oct 2019 10:28:49 +0000
Message-Id: <20191015102850.2079-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015102850.2079-1-laijs@linux.alibaba.com>
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
Reply-To: <20191015102402.1978-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree_plugin.h is all about TREE_RCU&PREEMPT_RCU, where
TASKS_RCU is a quite different flavor which ought to
be in its own file.

The big '#ifdef CONFIG_TASKS_RCU' code block is moved to tasks.c
unchanged along with about 40 lines in the head of the file
and the function rcu_tasks_bootup_oddness() whose declaration
and call-site are also (forced) changed. Nothing else is changed.

./scripts/checkpatch.pl gives four warnings, but they don't
need to be fixed.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/Makefile      |   1 +
 kernel/rcu/tasks.c       | 395 +++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h        |   2 +
 kernel/rcu/tree_plugin.h |   1 +
 kernel/rcu/update.c      | 365 ------------------------------------
 5 files changed, 399 insertions(+), 365 deletions(-)
 create mode 100644 kernel/rcu/tasks.c

diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 82d5fba48b2f..c87f35bf0b4b 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
+obj-$(CONFIG_TASKS_RCU) += tasks.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/tasks.c b/kernel/rcu/tasks.c
new file mode 100644
index 000000000000..ba9f76187653
--- /dev/null
+++ b/kernel/rcu/tasks.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Read-Copy Update mechanism for mutual exclusion
+ *
+ * Copyright IBM Corporation, 2001
+ *
+ * Authors: Dipankar Sarma <dipankar@in.ibm.com>
+ *	    Manfred Spraul <manfred@colorfullife.com>
+ *
+ * Based on the original work by Paul McKenney <paulmck@linux.ibm.com>
+ * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ *		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/debug.h>
+#include <linux/moduleparam.h>
+#include <linux/kthread.h>
+#include <linux/tick.h>
+#include <linux/rcupdate_wait.h>
+#include <linux/sched/isolation.h>
+
+#include "rcu.h"
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "rcutask."
+
+/*
+ * Simple variant of RCU whose quiescent states are voluntary context
+ * switch, cond_resched_rcu_qs(), user-space execution, and idle.
+ * As such, grace periods can take one good long time.  There are no
+ * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
+ * because this implementation is intended to get the system into a safe
+ * state for some of the manipulations involved in tracing and the like.
+ * Finally, this implementation does not support high call_rcu_tasks()
+ * rates from multiple CPUs.  If this is required, per-CPU callback lists
+ * will be needed.
+ */
+
+/* Global list of callbacks and associated lock. */
+static struct rcu_head *rcu_tasks_cbs_head;
+static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
+static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
+static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
+
+/* Track exiting tasks in order to allow them to be waited for. */
+DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
+
+/* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
+#define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
+static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
+module_param(rcu_task_stall_timeout, int, 0644);
+
+static struct task_struct *rcu_tasks_kthread_ptr;
+
+/**
+ * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks() assumes
+ * that the read-side critical sections end at a voluntary context
+ * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * or transition to usermode execution.  As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
+{
+	unsigned long flags;
+	bool needwake;
+
+	rhp->next = NULL;
+	rhp->func = func;
+	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
+	needwake = !rcu_tasks_cbs_head;
+	*rcu_tasks_cbs_tail = rhp;
+	rcu_tasks_cbs_tail = &rhp->next;
+	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+	/* We can't create the thread unless interrupts are enabled. */
+	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
+		wake_up(&rcu_tasks_cbs_wq);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks);
+
+/**
+ * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
+ * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function
+ * preambles and profiling hooks.  The synchronize_rcu_tasks() function
+ * is not (yet) intended for heavy use from multiple CPUs.
+ *
+ * Note that this guarantee implies further memory-ordering guarantees.
+ * On systems with more than one CPU, when synchronize_rcu_tasks() returns,
+ * each CPU is guaranteed to have executed a full memory barrier since the
+ * end of its last RCU-tasks read-side critical section whose beginning
+ * preceded the call to synchronize_rcu_tasks().  In addition, each CPU
+ * having an RCU-tasks read-side critical section that extends beyond
+ * the return from synchronize_rcu_tasks() is guaranteed to have executed
+ * a full memory barrier after the beginning of synchronize_rcu_tasks()
+ * and before the beginning of that RCU-tasks read-side critical section.
+ * Note that these guarantees include CPUs that are offline, idle, or
+ * executing in user mode, as well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked synchronize_rcu_tasks(), which returned
+ * to its caller on CPU B, then both CPU A and CPU B are guaranteed
+ * to have executed a full memory barrier during the execution of
+ * synchronize_rcu_tasks() -- even if CPU A and CPU B are the same CPU
+ * (but again only if the system has more than one CPU).
+ */
+void synchronize_rcu_tasks(void)
+{
+	/* Complain if the scheduler has not started.  */
+	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "synchronize_rcu_tasks called too soon");
+
+	/* Wait for the grace period. */
+	wait_rcu_gp(call_rcu_tasks);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
+
+/**
+ * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
+
+/* See if tasks are still holding out, complain if so. */
+static void check_holdout_task(struct task_struct *t,
+			       bool needreport, bool *firstreport)
+{
+	int cpu;
+
+	if (!READ_ONCE(t->rcu_tasks_holdout) ||
+	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
+	    !READ_ONCE(t->on_rq) ||
+	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
+	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+		WRITE_ONCE(t->rcu_tasks_holdout, false);
+		list_del_init(&t->rcu_tasks_holdout_list);
+		put_task_struct(t);
+		return;
+	}
+	rcu_request_urgent_qs_task(t);
+	if (!needreport)
+		return;
+	if (*firstreport) {
+		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
+		*firstreport = false;
+	}
+	cpu = task_cpu(t);
+	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
+		 t, ".I"[is_idle_task(t)],
+		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
+		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
+		 t->rcu_tasks_idle_cpu, cpu);
+	sched_show_task(t);
+}
+
+/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
+static int __noreturn rcu_tasks_kthread(void *arg)
+{
+	unsigned long flags;
+	struct task_struct *g, *t;
+	unsigned long lastreport;
+	struct rcu_head *list;
+	struct rcu_head *next;
+	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
+
+	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
+	housekeeping_affine(current, HK_FLAG_RCU);
+
+	/*
+	 * Each pass through the following loop makes one check for
+	 * newly arrived callbacks, and, if there are some, waits for
+	 * one RCU-tasks grace period and then invokes the callbacks.
+	 * This loop is terminated by the system going down.  ;-)
+	 */
+	for (;;) {
+
+		/* Pick up any new callbacks. */
+		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
+		list = rcu_tasks_cbs_head;
+		rcu_tasks_cbs_head = NULL;
+		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
+		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+
+		/* If there were none, wait a bit and start over. */
+		if (!list) {
+			wait_event_interruptible(rcu_tasks_cbs_wq,
+						 rcu_tasks_cbs_head);
+			if (!rcu_tasks_cbs_head) {
+				WARN_ON(signal_pending(current));
+				schedule_timeout_interruptible(HZ/10);
+			}
+			continue;
+		}
+
+		/*
+		 * Wait for all pre-existing t->on_rq and t->nvcsw
+		 * transitions to complete.  Invoking synchronize_rcu()
+		 * suffices because all these transitions occur with
+		 * interrupts disabled.  Without this synchronize_rcu(),
+		 * a read-side critical section that started before the
+		 * grace period might be incorrectly seen as having started
+		 * after the grace period.
+		 *
+		 * This synchronize_rcu() also dispenses with the
+		 * need for a memory barrier on the first store to
+		 * ->rcu_tasks_holdout, as it forces the store to happen
+		 * after the beginning of the grace period.
+		 */
+		synchronize_rcu();
+
+		/*
+		 * There were callbacks, so we need to wait for an
+		 * RCU-tasks grace period.  Start off by scanning
+		 * the task list for tasks that are not already
+		 * voluntarily blocked.  Mark these tasks and make
+		 * a list of them in rcu_tasks_holdouts.
+		 */
+		rcu_read_lock();
+		for_each_process_thread(g, t) {
+			if (t != current && READ_ONCE(t->on_rq) &&
+			    !is_idle_task(t)) {
+				get_task_struct(t);
+				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+				WRITE_ONCE(t->rcu_tasks_holdout, true);
+				list_add(&t->rcu_tasks_holdout_list,
+					 &rcu_tasks_holdouts);
+			}
+		}
+		rcu_read_unlock();
+
+		/*
+		 * Wait for tasks that are in the process of exiting.
+		 * This does only part of the job, ensuring that all
+		 * tasks that were previously exiting reach the point
+		 * where they have disabled preemption, allowing the
+		 * later synchronize_rcu() to finish the job.
+		 */
+		synchronize_srcu(&tasks_rcu_exit_srcu);
+
+		/*
+		 * Each pass through the following loop scans the list
+		 * of holdout tasks, removing any that are no longer
+		 * holdouts.  When the list is empty, we are done.
+		 */
+		lastreport = jiffies;
+
+		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
+		fract = 10;
+
+		for (;;) {
+			bool firstreport;
+			bool needreport;
+			int rtst;
+			struct task_struct *t1;
+
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (fract > 1)
+				fract--;
+
+			rtst = READ_ONCE(rcu_task_stall_timeout);
+			needreport = rtst > 0 &&
+				     time_after(jiffies, lastreport + rtst);
+			if (needreport)
+				lastreport = jiffies;
+			firstreport = true;
+			WARN_ON(signal_pending(current));
+			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
+						rcu_tasks_holdout_list) {
+				check_holdout_task(t, needreport, &firstreport);
+				cond_resched();
+			}
+		}
+
+		/*
+		 * Because ->on_rq and ->nvcsw are not guaranteed
+		 * to have a full memory barriers prior to them in the
+		 * schedule() path, memory reordering on other CPUs could
+		 * cause their RCU-tasks read-side critical sections to
+		 * extend past the end of the grace period.  However,
+		 * because these ->nvcsw updates are carried out with
+		 * interrupts disabled, we can use synchronize_rcu()
+		 * to force the needed ordering on all such CPUs.
+		 *
+		 * This synchronize_rcu() also confines all
+		 * ->rcu_tasks_holdout accesses to be within the grace
+		 * period, avoiding the need for memory barriers for
+		 * ->rcu_tasks_holdout accesses.
+		 *
+		 * In addition, this synchronize_rcu() waits for exiting
+		 * tasks to complete their final preempt_disable() region
+		 * of execution, cleaning up after the synchronize_srcu()
+		 * above.
+		 */
+		synchronize_rcu();
+
+		/* Invoke the callbacks. */
+		while (list) {
+			next = list->next;
+			local_bh_disable();
+			list->func(list);
+			local_bh_enable();
+			list = next;
+			cond_resched();
+		}
+		/* Paranoid sleep to keep this from entering a tight loop */
+		schedule_timeout_uninterruptible(HZ/10);
+	}
+}
+
+/* Spawn rcu_tasks_kthread() at core_initcall() time. */
+static int __init rcu_spawn_tasks_kthread(void)
+{
+	struct task_struct *t;
+
+	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
+		return 0;
+	smp_mb(); /* Ensure others see full kthread. */
+	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_kthread);
+
+/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_start(void)
+{
+	preempt_disable();
+	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	preempt_enable();
+}
+
+/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_finish(void)
+{
+	preempt_disable();
+	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
+	preempt_enable();
+}
+
+#ifndef CONFIG_TINY_RCU
+/*
+ * Print any non-default Tasks RCU settings.
+ */
+void __init rcu_tasks_bootup_oddness(void)
+{
+	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
+		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
+	else
+		pr_info("\tTasks RCU enabled.\n");
+}
+#endif /* #ifndef CONFIG_TINY_RCU */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 75ae55b6270a..65e3d928eb6a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -390,6 +390,8 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 #define RCU_NAME rcu_name
 #endif /* #else #ifdef CONFIG_TRACING */
 
+extern void rcu_tasks_bootup_oddness(void);
+
 /* Forward declarations for tree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c2d2502e4d2d..23c70b970f84 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -77,6 +77,7 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
 		pr_info("\tRCU debug extended QS entry/exit.\n");
 	rcupdate_announce_bootup_oddness();
+	rcu_tasks_bootup_oddness();
 }
 
 #ifdef CONFIG_PREEMPT_RCU
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2f529470cafa..2225d233126e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -473,370 +473,6 @@ int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
-#ifdef CONFIG_TASKS_RCU
-
-/*
- * Simple variant of RCU whose quiescent states are voluntary context
- * switch, cond_resched_rcu_qs(), user-space execution, and idle.
- * As such, grace periods can take one good long time.  There are no
- * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
- * because this implementation is intended to get the system into a safe
- * state for some of the manipulations involved in tracing and the like.
- * Finally, this implementation does not support high call_rcu_tasks()
- * rates from multiple CPUs.  If this is required, per-CPU callback lists
- * will be needed.
- */
-
-/* Global list of callbacks and associated lock. */
-static struct rcu_head *rcu_tasks_cbs_head;
-static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
-static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
-
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
-
-/* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
-#define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
-static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
-module_param(rcu_task_stall_timeout, int, 0644);
-
-static struct task_struct *rcu_tasks_kthread_ptr;
-
-/**
- * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
- * @rhp: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks() assumes
- * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
- * or transition to usermode execution.  As such, there are no read-side
- * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
- * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
- *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
- */
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
-{
-	unsigned long flags;
-	bool needwake;
-
-	rhp->next = NULL;
-	rhp->func = func;
-	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-	needwake = !rcu_tasks_cbs_head;
-	*rcu_tasks_cbs_tail = rhp;
-	rcu_tasks_cbs_tail = &rhp->next;
-	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
-	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
-		wake_up(&rcu_tasks_cbs_wq);
-}
-EXPORT_SYMBOL_GPL(call_rcu_tasks);
-
-/**
- * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
- *
- * Control will return to the caller some time after a full rcu-tasks
- * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
- * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
- *
- * This is a very specialized primitive, intended only for a few uses in
- * tracing and other situations requiring manipulation of function
- * preambles and profiling hooks.  The synchronize_rcu_tasks() function
- * is not (yet) intended for heavy use from multiple CPUs.
- *
- * Note that this guarantee implies further memory-ordering guarantees.
- * On systems with more than one CPU, when synchronize_rcu_tasks() returns,
- * each CPU is guaranteed to have executed a full memory barrier since the
- * end of its last RCU-tasks read-side critical section whose beginning
- * preceded the call to synchronize_rcu_tasks().  In addition, each CPU
- * having an RCU-tasks read-side critical section that extends beyond
- * the return from synchronize_rcu_tasks() is guaranteed to have executed
- * a full memory barrier after the beginning of synchronize_rcu_tasks()
- * and before the beginning of that RCU-tasks read-side critical section.
- * Note that these guarantees include CPUs that are offline, idle, or
- * executing in user mode, as well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked synchronize_rcu_tasks(), which returned
- * to its caller on CPU B, then both CPU A and CPU B are guaranteed
- * to have executed a full memory barrier during the execution of
- * synchronize_rcu_tasks() -- even if CPU A and CPU B are the same CPU
- * (but again only if the system has more than one CPU).
- */
-void synchronize_rcu_tasks(void)
-{
-	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
-
-	/* Wait for the grace period. */
-	wait_rcu_gp(call_rcu_tasks);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
-
-/**
- * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
- *
- * Although the current implementation is guaranteed to wait, it is not
- * obligated to, for example, if there are no pending callbacks.
- */
-void rcu_barrier_tasks(void)
-{
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks();
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
-
-/* See if tasks are still holding out, complain if so. */
-static void check_holdout_task(struct task_struct *t,
-			       bool needreport, bool *firstreport)
-{
-	int cpu;
-
-	if (!READ_ONCE(t->rcu_tasks_holdout) ||
-	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
-	    !READ_ONCE(t->on_rq) ||
-	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
-		WRITE_ONCE(t->rcu_tasks_holdout, false);
-		list_del_init(&t->rcu_tasks_holdout_list);
-		put_task_struct(t);
-		return;
-	}
-	rcu_request_urgent_qs_task(t);
-	if (!needreport)
-		return;
-	if (*firstreport) {
-		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
-		*firstreport = false;
-	}
-	cpu = task_cpu(t);
-	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
-		 t, ".I"[is_idle_task(t)],
-		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
-		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
-		 t->rcu_tasks_idle_cpu, cpu);
-	sched_show_task(t);
-}
-
-/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
-static int __noreturn rcu_tasks_kthread(void *arg)
-{
-	unsigned long flags;
-	struct task_struct *g, *t;
-	unsigned long lastreport;
-	struct rcu_head *list;
-	struct rcu_head *next;
-	LIST_HEAD(rcu_tasks_holdouts);
-	int fract;
-
-	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_FLAG_RCU);
-
-	/*
-	 * Each pass through the following loop makes one check for
-	 * newly arrived callbacks, and, if there are some, waits for
-	 * one RCU-tasks grace period and then invokes the callbacks.
-	 * This loop is terminated by the system going down.  ;-)
-	 */
-	for (;;) {
-
-		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-		list = rcu_tasks_cbs_head;
-		rcu_tasks_cbs_head = NULL;
-		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
-
-		/* If there were none, wait a bit and start over. */
-		if (!list) {
-			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 rcu_tasks_cbs_head);
-			if (!rcu_tasks_cbs_head) {
-				WARN_ON(signal_pending(current));
-				schedule_timeout_interruptible(HZ/10);
-			}
-			continue;
-		}
-
-		/*
-		 * Wait for all pre-existing t->on_rq and t->nvcsw
-		 * transitions to complete.  Invoking synchronize_rcu()
-		 * suffices because all these transitions occur with
-		 * interrupts disabled.  Without this synchronize_rcu(),
-		 * a read-side critical section that started before the
-		 * grace period might be incorrectly seen as having started
-		 * after the grace period.
-		 *
-		 * This synchronize_rcu() also dispenses with the
-		 * need for a memory barrier on the first store to
-		 * ->rcu_tasks_holdout, as it forces the store to happen
-		 * after the beginning of the grace period.
-		 */
-		synchronize_rcu();
-
-		/*
-		 * There were callbacks, so we need to wait for an
-		 * RCU-tasks grace period.  Start off by scanning
-		 * the task list for tasks that are not already
-		 * voluntarily blocked.  Mark these tasks and make
-		 * a list of them in rcu_tasks_holdouts.
-		 */
-		rcu_read_lock();
-		for_each_process_thread(g, t) {
-			if (t != current && READ_ONCE(t->on_rq) &&
-			    !is_idle_task(t)) {
-				get_task_struct(t);
-				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-				WRITE_ONCE(t->rcu_tasks_holdout, true);
-				list_add(&t->rcu_tasks_holdout_list,
-					 &rcu_tasks_holdouts);
-			}
-		}
-		rcu_read_unlock();
-
-		/*
-		 * Wait for tasks that are in the process of exiting.
-		 * This does only part of the job, ensuring that all
-		 * tasks that were previously exiting reach the point
-		 * where they have disabled preemption, allowing the
-		 * later synchronize_rcu() to finish the job.
-		 */
-		synchronize_srcu(&tasks_rcu_exit_srcu);
-
-		/*
-		 * Each pass through the following loop scans the list
-		 * of holdout tasks, removing any that are no longer
-		 * holdouts.  When the list is empty, we are done.
-		 */
-		lastreport = jiffies;
-
-		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
-		fract = 10;
-
-		for (;;) {
-			bool firstreport;
-			bool needreport;
-			int rtst;
-			struct task_struct *t1;
-
-			if (list_empty(&rcu_tasks_holdouts))
-				break;
-
-			/* Slowly back off waiting for holdouts */
-			schedule_timeout_interruptible(HZ/fract);
-
-			if (fract > 1)
-				fract--;
-
-			rtst = READ_ONCE(rcu_task_stall_timeout);
-			needreport = rtst > 0 &&
-				     time_after(jiffies, lastreport + rtst);
-			if (needreport)
-				lastreport = jiffies;
-			firstreport = true;
-			WARN_ON(signal_pending(current));
-			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-						rcu_tasks_holdout_list) {
-				check_holdout_task(t, needreport, &firstreport);
-				cond_resched();
-			}
-		}
-
-		/*
-		 * Because ->on_rq and ->nvcsw are not guaranteed
-		 * to have a full memory barriers prior to them in the
-		 * schedule() path, memory reordering on other CPUs could
-		 * cause their RCU-tasks read-side critical sections to
-		 * extend past the end of the grace period.  However,
-		 * because these ->nvcsw updates are carried out with
-		 * interrupts disabled, we can use synchronize_rcu()
-		 * to force the needed ordering on all such CPUs.
-		 *
-		 * This synchronize_rcu() also confines all
-		 * ->rcu_tasks_holdout accesses to be within the grace
-		 * period, avoiding the need for memory barriers for
-		 * ->rcu_tasks_holdout accesses.
-		 *
-		 * In addition, this synchronize_rcu() waits for exiting
-		 * tasks to complete their final preempt_disable() region
-		 * of execution, cleaning up after the synchronize_srcu()
-		 * above.
-		 */
-		synchronize_rcu();
-
-		/* Invoke the callbacks. */
-		while (list) {
-			next = list->next;
-			local_bh_disable();
-			list->func(list);
-			local_bh_enable();
-			list = next;
-			cond_resched();
-		}
-		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_uninterruptible(HZ/10);
-	}
-}
-
-/* Spawn rcu_tasks_kthread() at core_initcall() time. */
-static int __init rcu_spawn_tasks_kthread(void)
-{
-	struct task_struct *t;
-
-	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
-		return 0;
-	smp_mb(); /* Ensure others see full kthread. */
-	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
-	return 0;
-}
-core_initcall(rcu_spawn_tasks_kthread);
-
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void)
-{
-	preempt_disable();
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
-}
-
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void)
-{
-	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
-	preempt_enable();
-}
-
-#endif /* #ifdef CONFIG_TASKS_RCU */
-
-#ifndef CONFIG_TINY_RCU
-
-/*
- * Print any non-default Tasks RCU settings.
- */
-static void __init rcu_tasks_bootup_oddness(void)
-{
-#ifdef CONFIG_TASKS_RCU
-	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
-		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
-	else
-		pr_info("\tTasks RCU enabled.\n");
-#endif /* #ifdef CONFIG_TASKS_RCU */
-}
-
-#endif /* #ifndef CONFIG_TINY_RCU */
-
 #ifdef CONFIG_PROVE_RCU
 
 /*
@@ -924,7 +560,6 @@ void __init rcupdate_announce_bootup_oddness(void)
 		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
 	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
 		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
-	rcu_tasks_bootup_oddness();
 }
 
 #endif /* #ifndef CONFIG_TINY_RCU */
-- 
2.20.1

