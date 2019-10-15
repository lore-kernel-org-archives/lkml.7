Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD82FECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A831821835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utsn5BX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfJOLTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:19:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfJOLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:19:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so23382939wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2JvHxnoC8bH62AR1Wfq+93R3iXtnm2Ph/wB6+IUW6nU=;
        b=Utsn5BX8JagnV5m3jEea96QvkQJ782+ATu6kr0LZPro9xcKV3hIWLTKyQ79rhyjUQ9
         U1dcYcrDxVJMkpwJggurqxqWBVhIyCJFb+/cQGONrNIpthvyvatSjf6ofY58r63LC+hv
         kjnNAGjA0J2X0HEQJ00FR5imnChHChJ3tZJ+E8veWs5D7Mx/RuXNVEN8tJUXB0NndRXB
         P2uYMnTwwpJuSB1IIvcqZ0uiTkot6Z1/M1wsyhuxoMToO/vk56n6zPh1ebxMfYo//h7D
         lPpwh0rEAeTZQlMb4e/8xewy721zMBq7QkSm4dSMnvMczpZb6TDaybolv+3WDW/Ryn4o
         wykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2JvHxnoC8bH62AR1Wfq+93R3iXtnm2Ph/wB6+IUW6nU=;
        b=mGJJSNi0OA98J8BGTow7As6H+G165TtRpV1bgBt/Je7OrTOxedQrKlLi5e/lVZ0D7U
         bUhXmh7xabfKtAvVXWHnqfYq5v3hUEQbjwtXRaYmamxThsz6WNuxaqJrCW+pdaF4JxEQ
         UMJwFOF5ANsaSZgVF1xse+H15YZiRM65hS67gSsrXgisMt0ooARVs5abl17LU/VSTGeT
         ZcyE+vvIZfJMLkLWWyqSc8qoxhZsfndyrUJjmtDjGsGmUfW4qJiDFiYaY9Hvflnn6j7m
         zkpeciRiZqE6ARtVGaPJjVdF94cBgMRE2idXRLWlcigZ8JISdRrGVCAE9FMykHxoC3BH
         2Kpw==
X-Gm-Message-State: APjAAAXhOa9A3qasV5D4byMBIj+yTS3oxLxwATvVybdzeVZ+TnIEadGV
        wv/L9bTBexcXh73TQWlXoQ==
X-Google-Smtp-Source: APXvYqwn6yHm4Jl8OVQc+vytiZrBvMDzegmvyBR2h9olDcia3QjsSoWcKAJy+E+rIsDv6+IDW/0hPg==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr32329514wru.382.1571138354623;
        Tue, 15 Oct 2019 04:19:14 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id l9sm18487303wme.45.2019.10.15.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:19:14 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v9 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Tue, 15 Oct 2019 13:19:07 +0200
Message-Id: <20191015111910.4496-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
References: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
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

This facility works with the preempt/irqsoff, and wakeup tracers.

The tracers may call the latency_fsnotify() from places such as
__schedule() or do_idle(); this makes it impossible to call
queue_work() directly without risking a deadlock. The same would
happen with a softirq,  kernel thread or tasklet. For this reason we
use the irq_work mechanism to call queue_work().

This patch creates a new workqueue. The reason for doing this is that
I wanted to use the WQ_UNBOUND and WQ_HIGHPRI flags.  My thinking was
that WQ_UNBOUND might help with the latency in some important cases.

If we use:

queue_work(system_highpri_wq, &tr->fsnotify_work);

then the work will (almost) always execute on the same CPU but if we are
unlucky that CPU could be too busy while there could be another CPU in
the system that would be able to process the work soon enough.

queue_work_on() could be used to queue the work on another CPU but it
seems difficult to select the right CPU.

Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
---
 kernel/trace/trace.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h | 18 +++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee9178365..523e3e57f1d4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -45,6 +45,9 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
+#include <linux/fsnotify.h>
+#include <linux/irq_work.h>
+#include <linux/workqueue.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -1497,6 +1500,74 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 }
 
 unsigned long __read_mostly	tracing_thresh;
+static const struct file_operations tracing_max_lat_fops;
+
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+static struct workqueue_struct *fsnotify_wq;
+
+static void latency_fsnotify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      fsnotify_work);
+	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
+		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
+{
+	struct trace_array *tr = container_of(iwork, struct trace_array,
+					      fsnotify_irqwork);
+	queue_work(fsnotify_wq, &tr->fsnotify_work);
+}
+
+static void trace_create_maxlat_file(struct trace_array *tr,
+				     struct dentry *d_tracer)
+{
+	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
+	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
+	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
+					      d_tracer, &tr->max_latency,
+					      &tracing_max_lat_fops);
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
+	/*
+	 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
+	 * possible that we are called from __schedule() or do_idle(), which
+	 * could cause a deadlock.
+	 */
+	irq_work_queue(&tr->fsnotify_irqwork);
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
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 /*
@@ -1536,6 +1607,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+	latency_fsnotify(tr);
 }
 
 /**
@@ -8585,8 +8657,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d685c61085c0..2fb9b7353a99 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -16,6 +16,8 @@
 #include <linux/trace_events.h>
 #include <linux/compiler.h>
 #include <linux/glob.h>
+#include <linux/irq_work.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -264,6 +266,11 @@ struct trace_array {
 #endif
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	unsigned long		max_latency;
+#ifdef CONFIG_FSNOTIFY
+	struct dentry		*d_max_latency;
+	struct work_struct	fsnotify_work;
+	struct irq_work		fsnotify_irqwork;
+#endif
 #endif
 	struct trace_pid_list	__rcu *filtered_pids;
 	/*
@@ -786,6 +793,17 @@ void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+void latency_fsnotify(struct trace_array *tr);
+
+#else
+
+static void latency_fsnotify(struct trace_array *tr) { }
+
+#endif
+
 #ifdef CONFIG_STACKTRACE
 void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
 		   int pc);
-- 
2.17.1

