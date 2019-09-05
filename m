Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A88C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FFE206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCRZlILW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfIENZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:25:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37970 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbfIENZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:25:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so2784202wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VeYMyHmjXU2DfFSsH+Rdd7j1oiT874EAkgVuiJOpfr8=;
        b=HCRZlILW9fX5WPub/ngi5PB6qCnZZI26XJmDxp+A/C9wXraRGCwBXXPJdIXpd/IryI
         HQqLpJEhCtVTT1Og/vfltC3XY/Imr9SSg96cLgPXTqOyyS8mC/ua/647E9r6LRIC0Cu/
         Hh2fkpnJ34Gg1k8VRFFMBEAdJ6yn8tt4DheOGlWmAQMGTGFaaV4Iw4vWaMX3BAeElwIJ
         8RtUxhSbDgVjNtm31Sbu08jW0hBCQm1OzKIR91QCLTfj3iA4vbT0qeqJ4N8XC+JKr7gU
         bDWuZGnosZ/Oi1F58icDdHpcmzg57l+ETY7msY+JbxAKRoVH1hX6ZhY4FaGFxl23lqOr
         snig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VeYMyHmjXU2DfFSsH+Rdd7j1oiT874EAkgVuiJOpfr8=;
        b=jCWtO8zGwPjY5shgDWUAfrti3tyD79GenVB50VyuIQuZ9xXm/DQUS5SGPvHQnTOEVd
         K6zUE+TGHoYomGlZOUCjeGmFNH/miKalC2OmxRBkzgD9Cjdetlf8VNwurBY6tqAN/XJ+
         VzHfVj3WrlqC7G1f6510rjFcpFUvSJOG+TiJp1JIZARLM+o90OXr0aJQ3IOvjpJ4MvL5
         QEEk+jacR2eILDO4RlT3x9fLW6jKUTTtZcvRuNA1l2trpN9Ny7j26Un/anLjrTzHSrw2
         6bN4bv3ymYUv/Xf4uO6b+aDAgZLni352MstY//DBNVDuLfzyMUex7XywW1vV4M/N5ueg
         xoKg==
X-Gm-Message-State: APjAAAUOdkPdq51pjkypvx3qW9CsfjxKc+R1FpEgxhQkBM4vSGAelNb1
        19FHGB+v8xeOU0vWu3X/QooGktOGJQ==
X-Google-Smtp-Source: APXvYqyOZEZTMjq+gNVwznZYg+khooefMfjFXPPu25GdKbueQ6YXxJA58ZmWYJOtEisHJGvcOZSX/g==
X-Received: by 2002:a05:6000:1c3:: with SMTP id t3mr2846865wrx.76.1567689953337;
        Thu, 05 Sep 2019 06:25:53 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id y3sm8652635wmg.2.2019.09.05.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:25:52 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v6 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Thu,  5 Sep 2019 15:25:45 +0200
Message-Id: <20190905132548.5116-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
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

The tracers may call the latency_fsnotify() from places such as
__schedule() or do_idle(); this makes it impossible to call
queue_work() directly without risking a deadlock. The same would
happen with a softirq,  kernel thread or tasklet. For this reason we
use the irq_work mechanism to call queue_work().

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 kernel/trace/trace.c       | 75 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h       | 18 +++++++++
 kernel/trace/trace_hwlat.c |  4 +-
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 563e80f9006a..72ac20c4aaa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -44,6 +44,9 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
+#include <linux/fsnotify.h>
+#include <linux/irq_work.h>
+#include <linux/workqueue.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -1480,6 +1483,74 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 
 unsigned long __read_mostly	tracing_thresh;
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+static const struct file_operations tracing_max_lat_fops;
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
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /*
  * Copy the new maximum trace into the separate maximum-trace
@@ -1518,6 +1589,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	/* record this tasks comm */
 	tracing_record_cmdline(tsk);
+	latency_fsnotify(tr);
 }
 
 /**
@@ -8550,8 +8622,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
-	trace_create_file("tracing_max_latency", 0644, d_tracer,
-			&tr->max_latency, &tracing_max_lat_fops);
+	trace_create_maxlat_file(tr, d_tracer);
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..4913ed1138aa 100644
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
@@ -785,6 +792,17 @@ void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
+	defined(CONFIG_FSNOTIFY)
+
+void latency_fsnotify(struct trace_array *tr);
+
+#else
+
+#define latency_fsnotify(tr)     do { } while (0)
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
-- 
2.17.1

