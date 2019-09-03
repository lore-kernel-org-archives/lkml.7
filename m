Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B12C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F151623402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyTcRm1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfICN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:26:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56243 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbfICN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:26:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so14191625wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+KUFOLi4SDfxpw+wh60cyx+fQT2h5CX2/KwQSkt1v0=;
        b=kyTcRm1oaJeylAe6l2nIiT2LEvSM+QxCgPK72s3KjrHNzAMz2JYW5GJSHUHisYf4Qq
         AVljIDDEEipTC21XoLyhdWAoAZD0p1z+beSna0vnLk++8KSOOu6duR7PgSEDjoygucwB
         r7ZqB0MY9dB9eQWoGaH/OyZi6fBK2FgXT5zUs60nmkAeW7dRignOg5mhG8mb06XgQLXK
         P5kWDgP82qbAgyVsTv8X1e7OdtrylnzkhtGZ3mdQd8AFcOpKFUAXYjNp0fq8AoKyT07d
         v8tVhZTeP28YHWckF1XGIt1r2MMsUTFF4i47BdtYy3mgqiV2ZVfebgizo8Sx6nUTLSQl
         XPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+KUFOLi4SDfxpw+wh60cyx+fQT2h5CX2/KwQSkt1v0=;
        b=TTWzLWSNmjskxW4jsAtmcAoJh3JgdeLw6kwgHH4rqvCIz108hD9gr07GW7/ADK1pgC
         wHOxkRuvoJUz0Pmdhj8xQ5GYKLgqUIRT4oAJUMVR9fKex78HdhU7CeSlUdBvfsvD2oIi
         x1cWOUHyP1SIl6qD7rxutxRXtU3XM+dTzhVYJnqqXtTgiTXUqrdhziwfzT/QI7z+qMS5
         ruUWUqu45F7wwZpRBd2s4GSy8ePlO9PIEBBRVzivXtSjAG64ABbw95/9GRInXD8F3mlp
         U+BUW6puwR3rSMjpeCNLTkYBC/3cX30UudYopcQl2ws2D4lchkLBJ71XVHDRI7tSk6NM
         SWVQ==
X-Gm-Message-State: APjAAAXmLx0aV3dLdPviOxrLjObh8WZRtlL6pJBcmtNW+OO1xVSWt7U2
        MHPhEkvEC8b3S58c7F5btCt7zzXH1w==
X-Google-Smtp-Source: APXvYqyTCadPinvtH7bKUTnbVcINIumfjugoEdmYxq+t/v05nGgM7P1bNig9ecsIb7eJn/D1pcfO4A==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr16343wmd.104.1567517185517;
        Tue, 03 Sep 2019 06:26:25 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id w9sm3906668wra.15.2019.09.03.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:26:24 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v5 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Tue,  3 Sep 2019 15:25:59 +0200
Message-Id: <20190903132602.3440-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the feature that the tracing_max_latency file,
e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
notifications through the fsnotify framework when a new latency is
available.

One particularly interesting use of this facility is when enabling
threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
together with the preempt/irqsoff tracers. This makes it possible to
implement a user space program that can, with equal probability,
obtain traces of latencies that occur immediately after each other in
spite of the fact that the preempt/irqsoff tracers operate in overwrite
mode.

This facility works with the hwlat, preempt/irqsoff, and wakeup
tracers.

This patch also adds some unfortunate calls from __schedule() and
do_idle(). Those calls to the latency_fsnotify_disable/enable() are
needed because we cannot wake up the workqueue from these critical
sections without risking a deadlock. Similar problems would also arise
if we try to schedule a tasklet, raise a softirq, or wake up a kernel
thread. If a notification event would happen in the forbidden sections,
we schedule the fsnotify work as soon as we have exited them.

There was a suggestion to remove this latency_fsnotify_enable/disable()
gunk, or at least to combine it with the start_critical_timings() and
stop_critical_timings(). I have however not been able to come up with
a way to do it.

It seems like it would be possible to simply replace the calls to
latency_fsnotify_enable/disable() with calls to
start/stop_critical_timings(). However, the main problem is that it
would not work for the wakup tracer. The wakeup tracer needs a
facility that postpones the notifications, not one that prevents the
measurements because all its measurements takes place in the middle
of __schedule(). On the other hand, in some places, like in idle and
the console we need start stop functions that prevents the
measurements from being make.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 include/linux/ftrace.h            |  31 +++++++++
 kernel/sched/core.c               |   3 +
 kernel/sched/idle.c               |   3 +
 kernel/sched/sched.h              |   1 +
 kernel/trace/trace.c              | 112 +++++++++++++++++++++++++++++-
 kernel/trace/trace.h              |  22 ++++++
 kernel/trace/trace_hwlat.c        |   4 +-
 kernel/trace/trace_irqsoff.c      |   4 ++
 kernel/trace/trace_sched_wakeup.c |   4 ++
 9 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..b4d9700ef917 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -907,4 +907,35 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+DECLARE_PER_CPU(int, latency_notify_disable);
+DECLARE_STATIC_KEY_FALSE(latency_notify_key);
+
+void latency_fsnotify_process(void);
+
+/*
+ * Disable/enable fsnotify while in scheduler and idle code. Trying to wake
+ * anything up from there, such as calling queue_work() is prone to deadlock.
+ */
+static inline void latency_fsnotify_disable(void)
+{
+	this_cpu_inc(latency_notify_disable);
+}
+
+static inline void latency_fsnotify_enable(void)
+{
+	this_cpu_dec(latency_notify_disable);
+	if (static_branch_unlikely(&latency_notify_key))
+		latency_fsnotify_process();
+}
+
+#else
+
+#define latency_fsnotify_disable() do { } while (0)
+#define latency_fsnotify_enable()  do { } while (0)
+
+#endif
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578118d6..e3c1dc801073 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3198,6 +3198,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
+	latency_fsnotify_enable();
 	balance_callback(rq);
 	preempt_enable();
 
@@ -3820,6 +3821,7 @@ static void __sched notrace __schedule(bool preempt)
 
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
+	latency_fsnotify_disable();
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -3883,6 +3885,7 @@ static void __sched notrace __schedule(bool preempt)
 		rq_unlock_irq(rq, &rf);
 	}
 
+	latency_fsnotify_enable();
 	balance_callback(rq);
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..5fc87d99a407 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -236,6 +236,7 @@ static void do_idle(void)
 
 	__current_set_polling();
 	tick_nohz_idle_enter();
+	latency_fsnotify_disable();
 
 	while (!need_resched()) {
 		check_pgt_cache();
@@ -265,6 +266,8 @@ static void do_idle(void)
 		arch_cpu_idle_exit();
 	}
 
+	latency_fsnotify_enable();
+
 	/*
 	 * Since we fell out of the loop above, we know TIF_NEED_RESCHED must
 	 * be set, propagate it into PREEMPT_NEED_RESCHED.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..467d6ad03f16 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -46,6 +46,7 @@
 #include <linux/debugfs.h>
 #include <linux/delayacct.h>
 #include <linux/energy_model.h>
+#include <linux/ftrace.h>
 #include <linux/init_task.h>
 #include <linux/kprobes.h>
 #include <linux/kthread.h>
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 563e80f9006a..a622263a69e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -44,6 +44,10 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
+#include <linux/fsnotify.h>
+#include <linux/workqueue.h>
+#include <trace/events/power.h>
+#include <trace/events/sched.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -1480,6 +1484,110 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 
 unsigned long __read_mostly	tracing_thresh;
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+static const struct file_operations tracing_max_lat_fops;
+static struct workqueue_struct *fsnotify_wq;
+static DEFINE_PER_CPU(struct llist_head, notify_list);
+
+DEFINE_PER_CPU(int, latency_notify_disable);
+DEFINE_STATIC_KEY_FALSE(latency_notify_key);
+
+static void latency_fsnotify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      fsnotify_work);
+	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
+		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static void trace_create_maxlat_file(struct trace_array *tr,
+				     struct dentry *d_tracer)
+{
+	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
+	atomic_set(&tr->notify_pending, 0);
+	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
+					      d_tracer, &tr->max_latency,
+					      &tracing_max_lat_fops);
+}
+
+void latency_fsnotify_stop(void)
+{
+	/* Make sure all CPUs see caller's previous actions to stop tracer */
+	smp_wmb();
+	static_branch_disable(&latency_notify_key);
+	latency_fsnotify_process();
+}
+
+void latency_fsnotify_start(void)
+{
+	static_branch_enable(&latency_notify_key);
+	/* Make sure all CPUs see key value before caller continue */
+	smp_wmb();
+}
+
+void latency_fsnotify_process(void)
+{
+	struct trace_array *tr;
+	struct llist_head *list;
+	struct llist_node *node;
+
+	if (this_cpu_read(latency_notify_disable))
+		return;
+
+	list = this_cpu_ptr(&notify_list);
+	for (node = llist_del_first(list); node != NULL;
+	     node = llist_del_first(list)) {
+		tr = llist_entry(node, struct trace_array, notify_ll);
+		atomic_set(&tr->notify_pending, 0);
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+	}
+}
+
+__init static int latency_fsnotify_init(void)
+{
+	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
+				      WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!fsnotify_wq) {
+		pr_err("Unable to allocate tr_max_lat_wq\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+late_initcall_sync(latency_fsnotify_init);
+
+void latency_fsnotify(struct trace_array *tr)
+{
+	if (!fsnotify_wq)
+		return;
+
+	if (!this_cpu_read(latency_notify_disable))
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+	else {
+		/*
+		 * notify_pending prevents us from adding the same entry to
+		 * more than one notify_list. It will get queued in
+		 * latency_enable_fsnotify()
+		 */
+		if (!atomic_xchg(&tr->notify_pending, 1))
+			llist_add(&tr->notify_ll, this_cpu_ptr(&notify_list));
+	}
+}
+
+/*
+ * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+ *  defined(CONFIG_FSNOTIFY)
+ */
+#else
+
+#define trace_create_maxlat_file(tr, d_tracer)				\
+	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
+			  &tr->max_latency, &tracing_max_lat_fops)
+
+#endif
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /*
  * Copy the new maximum trace into the separate maximum-trace
@@ -1518,6 +1626,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+	latency_fsnotify(tr);
 }
 
 /**
@@ -8550,8 +8659,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..d9f83b2aaa71 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -16,6 +16,7 @@
 #include <linux/trace_events.h>
 #include <linux/compiler.h>
 #include <linux/glob.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -264,6 +265,12 @@ struct trace_array {
 #endif
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	unsigned long		max_latency;
+#ifdef CONFIG_FSNOTIFY
+	struct dentry		*d_max_latency;
+	struct work_struct	fsnotify_work;
+	atomic_t		notify_pending;
+	struct llist_node	notify_ll;
+#endif
 #endif
 	struct trace_pid_list	__rcu *filtered_pids;
 	/*
@@ -785,6 +792,21 @@ void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+void latency_fsnotify(struct trace_array *tr);
+void latency_fsnotify_start(void);
+void latency_fsnotify_stop(void);
+
+#else
+
+#define latency_fsnotify(tr)     do { } while (0)
+#define latency_fsnotify_start() do { } while (0)
+#define latency_fsnotify_stop()  do { } while (0)
+
+#endif
+
 #ifdef CONFIG_STACKTRACE
 void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
 		   int pc);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index fa95139445b2..9c379261ee89 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -254,8 +254,10 @@ static int get_sample(void)
 		trace_hwlat_sample(&s);
 
 		/* Keep a running maximum ever recorded hardware latency */
-		if (sample > tr->max_latency)
+		if (sample > tr->max_latency) {
 			tr->max_latency = sample;
+			latency_fsnotify(tr);
+		}
 	}
 
 out:
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..29403a83a5f0 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -557,6 +557,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	if (irqsoff_busy)
 		return -EBUSY;
 
+	latency_fsnotify_start();
 	save_flags = tr->trace_flags;
 
 	/* non overwrite screws up the latency tracers */
@@ -591,16 +592,19 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
 	ftrace_reset_array_ops(tr);
 
 	irqsoff_busy = false;
+	latency_fsnotify_stop();
 }
 
 static void irqsoff_tracer_start(struct trace_array *tr)
 {
+	latency_fsnotify_start();
 	tracer_enabled = 1;
 }
 
 static void irqsoff_tracer_stop(struct trace_array *tr)
 {
 	tracer_enabled = 0;
+	latency_fsnotify_stop();
 }
 
 #ifdef CONFIG_IRQSOFF_TRACER
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 743b2b520d34..3dc90d9f605b 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -669,6 +669,7 @@ static bool wakeup_busy;
 
 static int __wakeup_tracer_init(struct trace_array *tr)
 {
+	latency_fsnotify_start();
 	save_flags = tr->trace_flags;
 
 	/* non overwrite screws up the latency tracers */
@@ -727,10 +728,12 @@ static void wakeup_tracer_reset(struct trace_array *tr)
 	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
 	ftrace_reset_array_ops(tr);
 	wakeup_busy = false;
+	latency_fsnotify_stop();
 }
 
 static void wakeup_tracer_start(struct trace_array *tr)
 {
+	latency_fsnotify_start();
 	wakeup_reset(tr);
 	tracer_enabled = 1;
 }
@@ -738,6 +741,7 @@ static void wakeup_tracer_start(struct trace_array *tr)
 static void wakeup_tracer_stop(struct trace_array *tr)
 {
 	tracer_enabled = 0;
+	latency_fsnotify_stop();
 }
 
 static struct tracer wakeup_tracer __read_mostly =
-- 
2.17.1

