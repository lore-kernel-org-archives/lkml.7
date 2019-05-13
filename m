Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136132085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKH6uBkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEMVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:50:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33218 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEMVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:50:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so19695365edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNSehQ0HlUuvAJBCW7j7sD8dF4I59FYKm2p33WbX/b8=;
        b=mKH6uBkfpeoJYurCU8uzAnGJT2YKaMEm1UhrOOlyFVCqL72vyzKVcOQdd5AG7nFs+A
         Co6p78vfZj0ISU7re3J9vhEyzIyIY8Iaizwtj404co0SwMyBXtWP95wSnV6vxis7iaCh
         NX9VdikJ2s3EQh4RrZVVsvRUz3Xe6HfC4OBZys1lLAoWcGJ+H9imvthbjqXI7Bt+WuTZ
         nv7UgPvu00EoolARa27jWG3U+A8MrMZp5YRj8S+YtDQPe48MP8+pLOUAatgVUjltLxom
         mZWAGDNwW5Lj89RKQ4ux7cuJbuBFxb8swikeTzfSmOnAOSSGNQVnez32qdSIKrFbSsci
         FCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNSehQ0HlUuvAJBCW7j7sD8dF4I59FYKm2p33WbX/b8=;
        b=ikNdw+WA+F7ECeyhNXi6iQeACkPo4wk9CLjrTjVIWN8HgS7fUK4IXTfLgfWDbvehnS
         udzD4iuYQ1KEpuHaFQ6Qoaj3vBfn/OwE1n5l/WhEYIC0KxJJkO8aGNkf2zLdBKdxZCNL
         d2CpljncCxDn1iZvbOEPsCwqsrPWiQu0dkwffxCsjgxu00KNqyfz2XPgV8HkXtTbEXOV
         uqwJROWi/Hv+YAzemKfGyEFCvUaOGG9EMNrtiCx5Jszw/INDOF8sG5r4MFodgq0ZhyVI
         4FHbvBcAxvw0PimeYxbz8VbVb7ebyaZVwOm5DTWCqiV0QY3DdkHmzvjyLcSl6ziK5pUd
         kYbw==
X-Gm-Message-State: APjAAAUmB+ZfY1hYuddLrwwfg8wips+TETqx0kCapVhy9l88qTDwCceE
        qjUd0efYW9NFHdkPKb0tSw==
X-Google-Smtp-Source: APXvYqxgqs4xLA0916nI/uTz9+ehlQ6RAPrwVH6UCp3azlauUrNlhfLY9Bn5sOiKpITYQe1LrnTPQw==
X-Received: by 2002:a17:906:d926:: with SMTP id rn6mr8057011ejb.191.1557784213282;
        Mon, 13 May 2019 14:50:13 -0700 (PDT)
Received: from localhost.localdomain ([92.117.184.230])
        by smtp.gmail.com with ESMTPSA id g11sm4040891eda.42.2019.05.13.14.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:50:12 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v3 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Mon, 13 May 2019 23:50:05 +0200
Message-Id: <20190513215008.11256-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
References: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
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

This patch also add four new tracepoints, for entering/exiting
__schedule() and do_idle(). Those tracepoints are needed to disable
and enable the notificaton facility because we cannot wake up the
workqueue from these critical sections without risking a deadlock.
Similar problems would also arise if we try to schedule a tasklet,
raise a softirq, or wake up a kernel thread.

If a notification event would happen in the forbidden sections, we
schedule the fsnotify work as soon as we have exited
do_idle()/__schedule().

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 include/trace/events/power.h |  40 +++++++++
 include/trace/events/sched.h |  40 +++++++++
 kernel/sched/core.c          |   2 +
 kernel/sched/idle.c          |   2 +
 kernel/trace/trace.c         | 160 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h         |  10 +++
 kernel/trace/trace_hwlat.c   |   4 +-
 7 files changed, 255 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index f7aece721aed..40ab747274bd 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -40,6 +40,46 @@ DEFINE_EVENT(cpu, cpu_idle,
 	TP_ARGS(state, cpu_id)
 );
 
+/*
+ * Tracepoint for entering do_idle():
+ */
+TRACE_EVENT(do_idle_enter,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d", __entry->cpu)
+);
+
+/*
+ * Tracepoint for exiting do_idle():
+ */
+TRACE_EVENT(do_idle_exit,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d", __entry->cpu)
+);
+
 TRACE_EVENT(powernv_throttle,
 
 	TP_PROTO(int chip_id, const char *reason, int pmax),
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfadab07..6a3dae7b3249 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -183,6 +183,46 @@ TRACE_EVENT(sched_switch,
 		__entry->next_comm, __entry->next_pid, __entry->next_prio)
 );
 
+/*
+ * Tracepoint for entering __schedule():
+ */
+TRACE_EVENT(sched_schedule_enter,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d", __entry->cpu)
+);
+
+/*
+ * Tracepoint for exiting __schedule():
+ */
+TRACE_EVENT(sched_schedule_exit,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d", __entry->cpu)
+);
+
 /*
  * Tracepoint for a task being migrated:
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..c9d86fcc48f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
 	int cpu;
 
 	cpu = smp_processor_id();
+	trace_sched_schedule_enter(cpu);
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
@@ -3448,6 +3449,7 @@ static void __sched notrace __schedule(bool preempt)
 	}
 
 	balance_callback(rq);
+	trace_sched_schedule_exit(cpu);
 }
 
 void __noreturn do_task_dead(void)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..e328e045c6e8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -224,6 +224,7 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+	trace_do_idle_enter(cpu);
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
@@ -287,6 +288,7 @@ static void do_idle(void)
 
 	if (unlikely(klp_patch_pending(current)))
 		klp_update_patch_state(current);
+	trace_do_idle_exit(cpu);
 }
 
 bool cpu_in_idle(unsigned long pc)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec439999f387..608e0dbdf851 100644
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
@@ -1481,6 +1485,157 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 
 unsigned long __read_mostly	tracing_thresh;
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+static const struct file_operations tracing_max_lat_fops;
+static struct workqueue_struct *fsnotify_wq;
+static DEFINE_PER_CPU(int, notify_disabled);
+static DEFINE_PER_CPU(struct trace_array *, notify_delayed_tr);
+
+static void trace_fsnotify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      fsnotify_work);
+	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
+		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static void trace_create_maxlat_file(struct trace_array *tr,
+				      struct dentry *d_tracer)
+{
+	INIT_WORK(&tr->fsnotify_work, trace_fsnotify_workfn);
+	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
+					      d_tracer, &tr->max_latency,
+					      &tracing_max_lat_fops);
+}
+
+/*
+ * Disable fsnotify while in scheduler and idle code. Trying wake anyting up
+ * from there is prone to deadlock.
+ */
+static inline void notrace trace_disable_fsnotify(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(notify_disabled, cpu) = 1;
+	raw_local_irq_restore(flags);
+}
+
+static inline void notrace trace_enable_fsnotify(void)
+{
+	int cpu;
+	struct trace_array *tr;
+	unsigned long flags;
+	bool do_queue = false;
+
+	raw_local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(notify_disabled, cpu) = 0;
+	tr = per_cpu(notify_delayed_tr, cpu);
+	if (tr != NULL) {
+		per_cpu(notify_delayed_tr, cpu) = NULL;
+		do_queue = true;
+	}
+	raw_local_irq_restore(flags);
+
+	if (do_queue && fsnotify_wq)
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+}
+
+static void notrace probe_sched_enter(void *nihil, int cpu)
+{
+	trace_disable_fsnotify();
+}
+
+static void notrace probe_sched_exit(void *nihil, int cpu)
+{
+	trace_enable_fsnotify();
+}
+
+static __init void trace_maxlat_fsnotify_init(void)
+{
+	int ret;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(notify_disabled, cpu) = 1;
+	smp_wmb();
+
+	ret = register_trace_sched_schedule_enter(probe_sched_enter, NULL);
+	if (ret) {
+		pr_info("tracing_max_latency: Could not activate tracepoint probe to sched_schedule_enter\n");
+		return;
+	}
+
+	ret = register_trace_sched_schedule_exit(probe_sched_exit, NULL);
+	if (ret) {
+		pr_info("tracing_max_latency: Could not activate tracepoint probe to sched_schedule_exit\n");
+		goto fail_deprobe_sched_enter;
+	}
+
+	ret = register_trace_do_idle_enter(probe_sched_enter, NULL);
+	if (ret) {
+		pr_info("tracing_max_latency: Could not activate tracepoint probe to do_idle_enter\n");
+		goto fail_deprobe_sched_exit;
+	}
+
+	ret = register_trace_do_idle_exit(probe_sched_exit, NULL);
+	if (ret) {
+		pr_info("tracing_max_latency: Could not activate tracepoint probe to do_idle_exit\n");
+		goto fail_deprobe_idle_enter;
+	}
+
+	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
+				      WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (fsnotify_wq)
+		return;
+
+	pr_err("Unable to allocate tr_max_lat_wq");
+
+	unregister_trace_do_idle_exit(probe_sched_exit, NULL);
+
+fail_deprobe_idle_enter:
+	unregister_trace_do_idle_enter(probe_sched_enter, NULL);
+
+fail_deprobe_sched_exit:
+	unregister_trace_sched_schedule_exit(probe_sched_exit, NULL);
+
+fail_deprobe_sched_enter:
+	unregister_trace_sched_schedule_enter(probe_sched_enter, NULL);
+}
+
+void trace_maxlat_fsnotify(struct trace_array *tr)
+{
+	int cpu = smp_processor_id();
+
+	if (!fsnotify_wq)
+		return;
+
+	if (!per_cpu(notify_disabled, cpu))
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+	else
+		/* queue it in trace_enable_fsnotify() */
+		per_cpu(notify_delayed_tr, cpu) = tr;
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
+#define trace_maxlat_fsnotify_init() do {} while (0)
+
+#endif
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /*
  * Copy the new maximum trace into the separate maximum-trace
@@ -1519,6 +1674,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+	trace_maxlat_fsnotify(tr);
 }
 
 /**
@@ -8242,8 +8398,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
@@ -8404,6 +8559,7 @@ static __init int tracer_init_tracefs(void)
 {
 	struct dentry *d_tracer;
 
+	trace_maxlat_fsnotify_init();
 	trace_access_lock_init();
 
 	d_tracer = tracing_init_dentry();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 639047b259d7..3456d6a47a47 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/trace_seq.h>
 #include <linux/glob.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -265,6 +266,10 @@ struct trace_array {
 #endif
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	unsigned long		max_latency;
+#ifdef CONFIG_FSNOTIFY
+	struct dentry		*d_max_latency;
+	struct work_struct	fsnotify_work;
+#endif
 #endif
 	struct trace_pid_list	__rcu *filtered_pids;
 	/*
@@ -781,6 +786,11 @@ void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+void trace_maxlat_fsnotify(struct trace_array *tr);
+#endif
+
 #ifdef CONFIG_STACKTRACE
 void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
 		   int pc);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 1e6db9cbe4dc..44a47f81d949 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -254,8 +254,10 @@ static int get_sample(void)
 		trace_hwlat_sample(&s);
 
 		/* Keep a running maximum ever recorded hardware latency */
-		if (sample > tr->max_latency)
+		if (sample > tr->max_latency) {
 			tr->max_latency = sample;
+			trace_maxlat_fsnotify(tr);
+		}
 	}
 
 out:
-- 
2.17.1

