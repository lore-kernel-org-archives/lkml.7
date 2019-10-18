Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C8CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F11222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwAEdNJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfJRPJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:09:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42488 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392041AbfJRPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:08:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so6642020wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uo29UJjtvwL9o1yUeP9/ak16jHRTsPhb3jCWvXhXP4E=;
        b=CwAEdNJrX1vvGP546EweBvQs90jLqJGMkP2ujgEGpr+/bLIW1+iZn+Gep54McD3zab
         gjqWmU92bI/MfVzm/cjQo/8leLOGkTmHex3IzaAmL4LHjLB+eFYjhNhmRGJeh+5C9nna
         BPhMhv9k4MTHpCpzk/hE4Nd3xB3lkgvO3Ismzg+LIn3XuOV8VuxN7Z9UcKUHNfodfOTf
         LOhW3CAM5BnN4h4I1SvSWTmGttXXizHCyDMfn5ysSlYK7Z0+Mfg9/qgswc7O0fFPQvpI
         xrazG0s8o/dGUUL3z75G5yawuB5lnBG3y8kMypNvpRuc+N7HNJXtJMioRbTzUI/kjutg
         LcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uo29UJjtvwL9o1yUeP9/ak16jHRTsPhb3jCWvXhXP4E=;
        b=EzKnwAOFvG3JzhUhG5IkWSoAZPigQc1wrl5h0iUp0WOl+cLeBiX8PRKgW4bFkRH+ap
         5EZsi3u2wF0dDBEMjYhtcqFlhH3FSDNUgiCowcZxqiIUjITthpeiCDx07GpYySMr9iuV
         t+BMc1q3dRp5dLduSJgTAKmTqmHAi8MBMLOpjZhkhfErBh8YghTng2zMmx8QMC7LvR0/
         Np/oJk/x0sVb6Vtu3jvsMjJ3fqSL8DCfK8mH1tqFwFmfkVOGFhMTaBExLV32Xfo84L36
         W/SD8N5viMeUdiOAJcFy1lwxPDyzZZ46R43+/TIgqlH/7ycB6AWMxThOxiN/lDbvvAJK
         eNKw==
X-Gm-Message-State: APjAAAXbwRx28RMXpUtU9bmeGcw4Rtf6QyoxuCmyRdsS8cUxHzz05czt
        YfryId4va9WL0QI9eZ2YYg==
X-Google-Smtp-Source: APXvYqy7mufT5baw/dcFWkcg/qLc0zmWihchUjihgZEOTeFKGOzjXQp7S0F5ERYHtI+icHZknCYkJA==
X-Received: by 2002:adf:a516:: with SMTP id i22mr8951223wrb.273.1571411336124;
        Fri, 18 Oct 2019 08:08:56 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id z6sm6035074wro.16.2019.10.18.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 08:08:55 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v10 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Fri, 18 Oct 2019 17:08:49 +0200
Message-Id: <20191018150852.4322-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018150852.4322-1-viktor.rosendahl@gmail.com>
References: <20191018150852.4322-1-viktor.rosendahl@gmail.com>
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
 kernel/trace/trace.c | 73 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h |  7 +++++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee9178365..2124646dfb2a 100644
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
@@ -1497,6 +1500,70 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 }
 
 unsigned long __read_mostly	tracing_thresh;
+static const struct file_operations tracing_max_lat_fops;
+
+#if defined(CONFIG_TRACER_MAX_TRACE) && defined(CONFIG_FSNOTIFY)
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
+static void latency_fsnotify(struct trace_array *tr)
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
+
+#else /* defined(CONFIG_TRACER_MAX_TRACE) && defined(CONFIG_FSNOTIFY) */
+
+#define trace_create_maxlat_file(tr, d_tracer)				\
+	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
+			  &tr->max_latency, &tracing_max_lat_fops)
+
+#endif
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 /*
@@ -1536,6 +1603,9 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+#ifdef CONFIG_FSNOTIFY
+	latency_fsnotify(tr);
+#endif
 }
 
 /**
@@ -8585,8 +8655,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d685c61085c0..8564c72ea7b5 100644
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
+#endif
+#if defined(CONFIG_TRACER_MAX_TRACE) && defined(CONFIG_FSNOTIFY)
+	struct dentry		*d_max_latency;
+	struct work_struct	fsnotify_work;
+	struct irq_work		fsnotify_irqwork;
 #endif
 	struct trace_pid_list	__rcu *filtered_pids;
 	/*
-- 
2.17.1

