Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB1C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37A5217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed1KUJxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfEVAaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:30:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55325 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:30:23 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so437562iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uixexa61vLL7bG4APLjVVV+OnUJ5QEtbhlZKcWVGZhM=;
        b=ed1KUJxJhWLIxVm+igbDnxgCAEKf9Dd9iB4fBuNUgs+AbjVAZ+1YVt6hrD5Xm0tEat
         h1GUm5Qhs3/QwgUDpIXG2kAj1oK5w06LygXNyXAxU5FSAuM16QbPATf85HthqsVycAOe
         2jP1epXBSIPi7GZhD+GB28RhFQ1JX4B1HJ9HP5CcPBHQ5NDuay4CybT0ZgEbFnzppyfr
         QUKuZJwvZlpM7STs6pkNtVOJCRMRJJUDWUZPeSO1tOuN63Xk21i355tLJcRGapOzUuSO
         +xxGnZYNODocdM0S4lvFo/Ht30OXZNZuATY+B1owUymOmQzngUt48Ws9Uu9GbZpoIZMI
         GRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uixexa61vLL7bG4APLjVVV+OnUJ5QEtbhlZKcWVGZhM=;
        b=OF7BVOG9egz5rFs4ALoaXJbyXSD4Q6wJhMKjgZKep/LjIJ/0FeXIQvWi96f3LeTxff
         raatKxbIb+Srv0GJtMiz5+KmMCjkfbBnZw/rsvH6Clm0MJmA6Rk+W/oE03VH0tKhXFH1
         Zy0dLCMeBBV5yqdPCkYE6YOl4cp5SV9fO4PQhFQWPE+tvnlPecIuL05fmK1ZuId+ehdJ
         4akoYiH38XyJCM2iiTz3PX2dBS826cN+sI3w+ze/u4Llm3+22eu1VSiPRyoi4WcQH6z6
         SkMTc/b+MrnlU9YF7r5ZEyIVN3ic72ZbMMN0qx8XC2oi/FHYGJ4gs2cae6/+l/K0yJ+h
         V19Q==
X-Gm-Message-State: APjAAAWUH4cIJsIMCv0mc+nuEnnXlmGqXB16zKTZ0mwgEYMBCsKSTqqq
        E924E4pchw6P/7W/FWUvRg==
X-Google-Smtp-Source: APXvYqy/VWeCjIOLYKoggdu92bbSuAfaucjSHuE4Lq0YchWe12+BvT+0QdvbcFyh38gB7IifbfJkEw==
X-Received: by 2002:a02:1049:: with SMTP id 70mr51581950jay.114.1558485021780;
        Tue, 21 May 2019 17:30:21 -0700 (PDT)
Received: from localhost.localdomain ([92.117.180.88])
        by smtp.gmail.com with ESMTPSA id t133sm7486309iod.84.2019.05.21.17.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 17:30:20 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Wed, 22 May 2019 02:30:14 +0200
Message-Id: <20190522003014.1359-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521120142.186487e9@gandalf.local.home>
References: <20190521120142.186487e9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/19 6:01 PM, Steven Rostedt wrote:>
>
> Note, you need to add the scheduling and power management maintainers
> when adding trace events to their code.
>

My bad.

> As these trace events become visible to user space, and you only need a
> callback to disable fsnotify, it may be better to just have a hard
> coded call to disable fsnotify (and have it be a nop when not
> configured).

My thinking was that it would not be defensible to clutter the idle and
scheduling code with calls to slightly obscure tracing code and that
perhaps some users would like to have these tracepoints for perf/ftrace but
I don't insist on it.

Below is a patch with hard coded calls.

> We can use a static branch if you want to keep the
> overhead down when not enabled, and enable the static branch when you
> start these latency tracers.
>

I noticed that it's possible to slightly simplify the enable/disble
functions, so I guess that this would not be necessary, especially since
one would need to handle the case when some CPUs are in the forbidden
sections when the tracers are enabled.

I can try to add the static branch if you want it though.

best regards,

Viktor
---
 include/linux/ftrace.h     |  13 +++++
 kernel/sched/core.c        |   2 +
 kernel/sched/idle.c        |   2 +
 kernel/sched/sched.h       |   1 +
 kernel/trace/trace.c       | 111 ++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h       |  12 ++++
 kernel/trace/trace_hwlat.c |   4 +-
 7 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 25e2995d4a4c..88c76f23277c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -907,4 +907,17 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+void trace_disable_fsnotify(void);
+void trace_enable_fsnotify(void);
+
+#else
+
+#define trace_disable_fsnotify() do { } while (0)
+#define trace_enable_fsnotify() do { } while (0)
+
+#endif
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..440cd1a62722 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
 	struct rq *rq;
 	int cpu;
 
+	trace_disable_fsnotify();
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
@@ -3449,6 +3450,7 @@ static void __sched notrace __schedule(bool preempt)
 	}
 
 	balance_callback(rq);
+	trace_enable_fsnotify();
 }
 
 void __noreturn do_task_dead(void)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..1a38bcdb3652 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -225,6 +225,7 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+	trace_disable_fsnotify();
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
@@ -284,6 +285,7 @@ static void do_idle(void)
 	smp_mb__after_atomic();
 
 	sched_ttwu_pending();
+	/* schedule_idle() will call trace_enable_fsnotify() */
 	schedule_idle();
 
 	if (unlikely(klp_patch_pending(current)))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..e22871d489a5 100644
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
index 2c92b3d9ea30..5dcc1147cbcc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -44,6 +44,8 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
+#include <linux/fsnotify.h>
+#include <linux/workqueue.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -1481,6 +1483,111 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 
 unsigned long __read_mostly	tracing_thresh;
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+static const struct file_operations tracing_max_lat_fops;
+static struct workqueue_struct *fsnotify_wq;
+static DEFINE_PER_CPU(atomic_t, notify_disabled) = ATOMIC_INIT(0);
+static DEFINE_PER_CPU(struct llist_head, notify_list);
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
+	atomic_set(&tr->notify_pending, 0);
+	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
+					      d_tracer, &tr->max_latency,
+					      &tracing_max_lat_fops);
+}
+
+/*
+ * Disable fsnotify while in scheduler and idle code. Trying wake anything up
+ * from there, such as calling queue_work() is prone to deadlock.
+ */
+void trace_disable_fsnotify(void)
+{
+	int cpu;
+
+	cpu = smp_processor_id();
+	atomic_set(&per_cpu(notify_disabled, cpu), 1);
+}
+EXPORT_SYMBOL(trace_disable_fsnotify);
+
+void trace_enable_fsnotify(void)
+{
+	int cpu;
+	struct trace_array *tr;
+	struct llist_head *list;
+	struct llist_node *node;
+
+	cpu = smp_processor_id();
+	atomic_set(&per_cpu(notify_disabled, cpu), 0);
+
+	list = &per_cpu(notify_list, cpu);
+	for (node = llist_del_first(list); node != NULL;
+	     node = llist_del_first(list)) {
+		tr = llist_entry(node, struct trace_array, notify_ll);
+		atomic_set(&tr->notify_pending, 0);
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+	}
+}
+EXPORT_SYMBOL(trace_enable_fsnotify);
+
+__init static int trace_maxlat_fsnotify_init(void)
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
+late_initcall_sync(trace_maxlat_fsnotify_init);
+
+void trace_maxlat_fsnotify(struct trace_array *tr)
+{
+	int cpu;
+
+	if (!fsnotify_wq)
+		return;
+
+	cpu = smp_processor_id();
+	if (!atomic_read(&per_cpu(notify_disabled, cpu)))
+		queue_work(fsnotify_wq, &tr->fsnotify_work);
+	else {
+		/*
+		 * notify_pending prevents us from adding the same entry to
+		 * more than one notify_list. It will get queued in
+		 * trace_enable_fsnotify()
+		 */
+		if (!atomic_xchg(&tr->notify_pending, 1))
+			llist_add(&tr->notify_ll, &per_cpu(notify_list, cpu));
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
@@ -1519,6 +1626,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+	trace_maxlat_fsnotify(tr);
 }
 
 /**
@@ -8533,8 +8641,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1974ce818ddb..f95027813296 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/trace_seq.h>
 #include <linux/glob.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -265,6 +266,12 @@ struct trace_array {
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
@@ -786,6 +793,11 @@ void update_max_tr_single(struct trace_array *tr,
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

