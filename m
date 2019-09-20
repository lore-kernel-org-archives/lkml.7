Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F342080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWCDCVa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392628AbfITPW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:22:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35897 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbfITPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:22:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so7197132wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxChQ2KhuPQDXJyvF0uqDEGqjNvnWGadSs4vVg4OZC4=;
        b=GWCDCVa9x+LcBo9RIkPxzZlkKsL8iwDQ6ed4sHkCJgp1p8wnBORtjJaIr+QsPnTmTy
         bpEmCBAn8yBA9tIwX5v0a0SVkSkD8lKq3TfhWldqe2cCLWOkdPTvBWffAgfv0ZtsUPzD
         jAgt+CqJzAG2rL2AWMGsGICTjoU32PPBBXZG6pNJxRHlnzZ1YciIp/n5zXCGnbviBDax
         SdwiSfRez14+Z+0lZZevT8p552ENzueu6oSr/Jw7y3Ils18cFMpzKHQS4P529wBexIyT
         e9DsF7a7jyBzeqdI13a8y4+naZ0z+1oe+62fQF4xTAlEb7vgyHBcYLqgRdoOfCTs+kDF
         rcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxChQ2KhuPQDXJyvF0uqDEGqjNvnWGadSs4vVg4OZC4=;
        b=kQWg7mJbcqPjz4zcvyTX8gUQKb6eDRNCZVtEI4m5YZ+dKXZbzRfwufihq4OXB6aJqB
         EXNV+G7C6iDg65OuJe/2Vgz4ZBAr73h+7o4/j+JnQ6cwY9ZWpwQzicQ1VUlIr2R7uKcz
         i2kqlQ+Q/a0RxJHOHiEfr6/X1z8yIzAwPUoGI6KOXD+LBUHDlBecWskW/OSCeqUECcrt
         DWktw2GxZG5DXfY99RWizCKH2p3B70Galt0IzAKx5YdBFPu34gyNIf9C9Ci3wWm41d5P
         paKfJLaQvx6RsicJBLCg2r3M4dQzA9Ea2y93SGZ4V5vYFbMHLbf/KkHJmq+nAwR4+/j/
         VhcA==
X-Gm-Message-State: APjAAAWqPgSEL0fkHaILQuNunrfZrR7Nj2dhcViuT3gD1dWieL4uw1vd
        wbpVGUlbN/Mv+DpTjFe5Gg==
X-Google-Smtp-Source: APXvYqwSov2RFYjiycJUdmsX1tCGJszjG119pBIcDVV7ViT/emxjjg2iLDsVBRwWgngn5nEkOtlcyg==
X-Received: by 2002:adf:c58b:: with SMTP id m11mr11831072wrg.252.1568992944803;
        Fri, 20 Sep 2019 08:22:24 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id x2sm3152901wrn.81.2019.09.20.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:22:24 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v7 1/4] ftrace: Implement fs notification for tracing_max_latency
Date:   Fri, 20 Sep 2019 17:22:16 +0200
Message-Id: <20190920152219.12920-2-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
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
 kernel/trace/trace.c       | 75 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h       | 18 +++++++++
 kernel/trace/trace_hwlat.c |  4 +-
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 947ba433865f..2d2150bf0d42 100644
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

