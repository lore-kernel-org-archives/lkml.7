Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4031FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DF220656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuIYAYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEAUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:37:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52663 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:37:01 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so637498itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KAo6ijPdCS4aoHsw3o79Oxi2MB5E6AUiqT1snQkbWo=;
        b=bGuIYAYeo9Ag9IwHTV+sNMxXiahJ+gyUV9oPDMfeLh6nAJ7YAD2rplVBwZNKwn7V5d
         JW21fHWBzJ9iqBeJaTrko79n577lecZRU06PFqoMCW2yz49GZ5cY2nK3Xzn3dw3M+vdH
         3j0+Px+1Kbq0oa95lEOHXWRzWN6FQab9D/JZGOzbg7yBZ6rwruSR85X5nkckGepxjygh
         HAyQeUwCYGGUwRZUjAUB1xdkF94h3fhcFf72VaFvKsIuScZJvRMLln5A1D31bBafdQ41
         tQn+D2KSlzAB0WJvbg8h22EZ4inZwHPbnMSvHUIoOUNZ1SXFah2EZoGb7zKF88tL9irD
         YABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KAo6ijPdCS4aoHsw3o79Oxi2MB5E6AUiqT1snQkbWo=;
        b=cQcHSlluUreswQMDMGF+oC7GUFKHfGog8FttoegJGzc74FZotYuAoaFR/sxwyO5O2L
         SJG+Cbk3xXzLnQGtSmZI0lYHor9udiOpA44qiEjVKs+TxmKvFu8Fb5zx+Gc1LyRj3SSd
         MwTwyNZnawTr/DF23wo4u+lmg/faCiPMbp9sYCEwdSE0N17QIAbWvF0y26pOJ8xtPkP9
         QDMTO2P1UT3TS0w/d/6dXosa4CdvvyMY8bOSUh7O/z9+SPMaymODaiMCVbKIg1Y4veLI
         C8qbBVUTyyRWqLjZYcB9X65gVIKhFjCAP92ymzzzKpPq3BlgrqHzwKQg7CrE4JaRw2xX
         LFiA==
X-Gm-Message-State: APjAAAX5Q4p/9ReFmrb/TbX0lO4YJwj0vVjv/tfdlrKJApUckyw+CIfL
        prdeMHLKiEQpHiXvHZhBJw==
X-Google-Smtp-Source: APXvYqwTHcmMRjNgMB60ONlq+GbAAfOIUkIVKKYwajj8cCMrFHXW/1JfrkH233ZnRjnEWSInIYpizw==
X-Received: by 2002:a24:6e15:: with SMTP id w21mr9581660itc.170.1556743019665;
        Wed, 01 May 2019 13:36:59 -0700 (PDT)
Received: from localhost.localdomain ([92.117.183.162])
        by smtp.gmail.com with ESMTPSA id u16sm9323998iol.66.2019.05.01.13.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 13:36:59 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v2 1/4] ftrace: Implement fs notification for preempt/irqsoff tracers
Date:   Wed,  1 May 2019 22:36:47 +0200
Message-Id: <20190501203650.29548-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
References: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the feature that the trace file, e.g.
/sys/kernel/debug/tracing/trace will receive notifications through
the fsnotify framework when a new trace is available.

This makes it possible to implement a user space program that can,
with equal probability, obtain traces of latencies that occur
immediately after each other in spite of the fact that the
preempt/irqsoff tracers operate in overwrite mode.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 kernel/trace/Kconfig         | 10 ++++++++++
 kernel/trace/trace.c         | 31 +++++++++++++++++++++++++++++--
 kernel/trace/trace.h         |  5 +++++
 kernel/trace/trace_irqsoff.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8bd1d6d001d7..35e5fd3224f6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -234,6 +234,16 @@ config PREEMPT_TRACER
 	  enabled. This option and the irqs-off timing option can be
 	  used together or separately.)
 
+	config PREEMPTIRQ_FSNOTIFY
+	bool "Generate fsnotify events for the latency tracers"
+	default n
+	depends on (IRQSOFF_TRACER || PREEMPT_TRACER) && FSNOTIFY
+	help
+	  This option will enable the generation of fsnotify events for the
+	  trace file. This makes it possible for userspace to be notified about
+	  modification of /sys/kernel/debug/tracing/trace through the inotify
+	  interface.
+
 config SCHED_TRACER
 	bool "Scheduling Latency Tracer"
 	select GENERIC_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee656d6d8..ebefb8d4e072 100644
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
@@ -8191,6 +8193,32 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 		return;
 }
 
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+
+static void trace_notify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      notify_work);
+	fsnotify(tr->d_trace->d_inode, FS_MODIFY, tr->d_trace->d_inode,
+		 FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static void trace_create_trace_file(struct trace_array *tr,
+				    struct dentry *d_tracer)
+{
+	/* For notify we need to init the work structure and save the pointer */
+	INIT_WORK(&tr->notify_work, trace_notify_workfn);
+	tr->d_trace = trace_create_file("trace", 0644, d_tracer, tr,
+					&tracing_fops);
+}
+
+#else /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
+#define trace_create_trace_file(tr, d_tracer) \
+	trace_create_file("trace", 0644, d_tracer, tr, &tracing_fops)
+
+#endif
+
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
@@ -8209,8 +8237,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_options", 0644, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", 0644, d_tracer,
-			  tr, &tracing_fops);
+	trace_create_trace_file(tr, d_tracer);
 
 	trace_create_file("trace_pipe", 0444, d_tracer,
 			  tr, &tracing_pipe_fops);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..59dc01ac52fd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/trace_seq.h>
 #include <linux/glob.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -302,6 +303,10 @@ struct trace_array {
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct dentry		*event_dir;
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+	struct dentry		*d_trace;
+	struct work_struct	notify_work;
+#endif
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..07a391e845de 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -82,6 +82,31 @@ static inline int irqsoff_display_graph(struct trace_array *tr, int set)
  */
 static __cacheline_aligned_in_smp	unsigned long max_sequence;
 
+#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
+
+static struct workqueue_struct *notify_wq;
+
+static __init void trace_file_notify_init(void)
+{
+	notify_wq = alloc_workqueue("irqsoff_notify_wq",
+				    WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!notify_wq)
+		pr_err("Unable to allocate irqsoff_notify_wq");
+}
+
+static inline void trace_file_notify(struct trace_array *tr)
+{
+	if (likely(notify_wq))
+		queue_work(notify_wq, &tr->notify_work);
+}
+
+#else /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
+#define trace_file_notify_init() do {} while (0)
+#define trace_file_notify(tr) do {} while (0)
+
+#endif /* !CONFIG_PREEMPTIRQ_FSNOTIFY */
+
 #ifdef CONFIG_FUNCTION_TRACER
 /*
  * Prologue for the preempt and irqs off function tracers.
@@ -323,6 +348,7 @@ check_critical_timing(struct trace_array *tr,
 	u64 T0, T1, delta;
 	unsigned long flags;
 	int pc;
+	bool notify = false;
 
 	T0 = data->preempt_timestamp;
 	T1 = ftrace_now(cpu);
@@ -353,6 +379,7 @@ check_critical_timing(struct trace_array *tr,
 	if (likely(!is_tracing_stopped())) {
 		tr->max_latency = delta;
 		update_max_tr_single(tr, current, cpu);
+		notify = true;
 	}
 
 	max_sequence++;
@@ -364,6 +391,13 @@ check_critical_timing(struct trace_array *tr,
 	data->critical_sequence = max_sequence;
 	data->preempt_timestamp = ftrace_now(cpu);
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+
+	/*
+	 * We are optimizing for a high threshold, meaning that this will
+	 * happen seldom
+	 */
+	if (unlikely(notify))
+		trace_file_notify(tr);
 }
 
 static nokprobe_inline void
@@ -745,6 +779,7 @@ static struct tracer preemptirqsoff_tracer __read_mostly =
 
 __init static int init_irqsoff_tracer(void)
 {
+	trace_file_notify_init();
 #ifdef CONFIG_IRQSOFF_TRACER
 	register_tracer(&irqsoff_tracer);
 #endif
-- 
2.17.1

