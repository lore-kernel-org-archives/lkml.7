Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502EEC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3090206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+LONwYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfEEWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:39:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41968 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfEEWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:39:24 -0400
Received: by mail-io1-f68.google.com with SMTP id a17so1412360iot.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hqFM/Wnq0mI8eL9g6ojj89KNP8W9tnprH3vIcrFeQ8Y=;
        b=u+LONwYPypoJolNI8+EhbnQUCSxnTRqvvSb3iZd7OJLlxgfqIFDYtJlG0m1p2MZuU7
         ezDDYpL0pqil5pCtMZ8T6S3ogYgFcKDimuanybNx2czPj+6V/qeRTuyPY46ib4uKV1L5
         SreijyFwrL6olKGmns+Lo4q6poKBIsYD/WYuTDm6XHybA7E6qKLcbogz0oFKSN4JxvtO
         aTt6pm6D0LvEDB87Ybju7fZGUiQy+gpyIzZAoPBdsbud2P3Pq+Kwn+ozEF9MT5Xfm55z
         F0CYU/RdF2kDTL3Pmw9+249DNK7Ht9Mf6CkI5GsqGHC5ml/jjKA/KBqGBeqIspWQ0J8Z
         Ki2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hqFM/Wnq0mI8eL9g6ojj89KNP8W9tnprH3vIcrFeQ8Y=;
        b=n2MG+m54NYKx3TnZ60AqJyVSDlfNAtQwnLS44ew3RrJT6GnNLeynN2uBLJcVlwsA7z
         +bAQ2kNKSCsvNTOaWGgL4823ID/MIqQrlr+Q7AsQgcFCaAPR1Hf+Q4In/0XGBwUjlGym
         qhUJop8PAys+fW+C6o7mYWevPEO42VT6kTWiUFqkbXyJvvcLin4L9RgFc1Y691E+/wis
         fXMBE+NLDV2Rfl+t+fnpR7Dodm4SbDECOQ16r8+fA9x6a96AI9DCJ28FtNQplh4OJ8n2
         otBvdrb5NH/0ezxPUx+F97lrfN5TDP3oGorLoMSScVCWpi+wUpgbo2mV9ltbx1zBTOmx
         t5sQ==
X-Gm-Message-State: APjAAAUNeFuuxduXEcxDSMKUD4VCXTsnjYWXfkSjpBZdqQfrJdmVFPd7
        UWYJArW/WAjFSIPeSYhMqA==
X-Google-Smtp-Source: APXvYqxOOZq1zbRVkNDx1wKnJbRCC2gBcehT7cmp/LIxvgcdn3y30vW/qBE8CJQ/zUeQ1fXSqQNwuA==
X-Received: by 2002:a5d:84d9:: with SMTP id z25mr15523216ior.301.1557095963509;
        Sun, 05 May 2019 15:39:23 -0700 (PDT)
Received: from localhost.localdomain ([92.117.170.52])
        by smtp.gmail.com with ESMTPSA id 140sm4364180itv.44.2019.05.05.15.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 15:39:22 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for preempt/irqsoff tracers
Date:   Mon,  6 May 2019 00:39:15 +0200
Message-Id: <20190505223915.4569-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504164710.GA55790@google.com>
References: <20190504164710.GA55790@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 6:47 PM, Joel Fernandes wrote:
> On Wed, May 01, 2019 at 10:36:47PM +0200, Viktor Rosendahl wrote:
>> immediately after each other in spite of the fact that the
>> preempt/irqsoff tracers operate in overwrite mode.
>>
>> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
>
> I agree with the general idea, but I don't really like how it is done in the
> patch.
>

Can you explain more precisely what you agree with?

The general idea of being able to trace bursts of latencies?

Or the slightly more specific idea of notifying user space when
/sys/kernel/debug/tracing/trace has new data, and let user space do the rest?

> We do have a notification mechanism already in the form of trace_pipe. Can we
> not improve that in some way to be notified of a new trace data? In theory,
> the trace_pipe does fit into the description in the documentation: "Reads
> from this file will block until new data is retrieved"
>

I am not quite sure what kind of solution you are after here. Could you be more
specific?

I think that it would be weird if we used trace_pipe to send a message with
the meaning "new data is available in the trace file". To me this would seem
like (re)inventing a special purpose alternative to inotify.

Another option would be to allow the user to consume the the latency traces
directly from trace_pipe, without using the trace file. This would make sense
to me and would indeed be a much better solution. If somebody is able to make
such an implementation I am all for it.

However, I do not know how to do this. I believe that it would lead towards a
significant rewrite of the latency tracers, probably also how the ftrace
buffering works.

My solution is clearly a hack but it has the benefits of requiring quite
small and straightforward changes to the kernel and the really ugly things are
then done in user space.

>>
>> +	config PREEMPTIRQ_FSNOTIFY

> Does this have to be a CONFIG option? If prefer if the code automatically
> does the notification and it is always enabled. I don't see any drawbacks of
> that.
>

I was just thinking that sending fsnotify events to a sysfs file is a bit off
the beaten track and I figured that some people would like to opt out.

It can of course be changed so that it is always enabled when a tracer that
requires it is enabled, if there is general agreement on this point.

>> +
>>  config SCHED_TRACER
>>  	bool "Scheduling Latency Tracer"
>>  	select GENERIC_TRACER
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index ca1ee656d6d8..ebefb8d4e072 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -44,6 +44,8 @@
>>  #include <linux/trace.h>
>>  #include <linux/sched/clock.h>
>>  #include <linux/sched/rt.h>
>> +#include <linux/fsnotify.h>
>> +#include <linux/workqueue.h>
>>
>>  #include "trace.h"
>>  #include "trace_output.h"
>> @@ -8191,6 +8193,32 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>>  		return;
>>  }
>>
>> +#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
>> +
>> +static void trace_notify_workfn(struct work_struct *work)
> [snip]
>
> I prefer if this facility is available to other tracers as well such as
> the wakeup tracer which is similar in output (check
> Documentation/trace/ftrace.txt). I believe this should be a generic trace
> facility, and not tracer specific.
>

This should be possible.

If we stick with the fsnotify idea, it's possible to move the functions for it
to trace.c and to use it also from other tracers.

It is also possible to do a few small adjustments to the latency-collector and
to rename it the trace-collector, so that it can work for the wakeup case also.
The random sleep games probably don't make sense for the wakeup case but it's
already now a command line option.

Below is a suggestion for how to make the facility more generic and usable by
by both preempt/irqsoff and wakeup.

best regards,

Viktor
---
 kernel/trace/Kconfig              | 11 +++++++
 kernel/trace/trace.c              | 50 +++++++++++++++++++++++++++++--
 kernel/trace/trace.h              | 15 ++++++++++
 kernel/trace/trace_irqsoff.c      |  5 ++++
 kernel/trace/trace_sched_wakeup.c |  7 ++++-
 5 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8bd1d6d001d7..ca6a63004adf 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -244,6 +244,17 @@ config SCHED_TRACER
 	  This tracer tracks the latency of the highest priority task
 	  to be scheduled in, starting from the point it has woken up.
 
+config TRACE_FSNOTIFY
+	bool "Generate fsnotify events for the trace file"
+	default n
+	depends on (IRQSOFF_TRACER || PREEMPT_TRACER || SCHED_TRACER)
+	depends on FSNOTIFY
+	help
+	  This option will enable the generation of fsnotify events for the
+	  trace file. This makes it possible for userspace to be notified about
+	  modification of /sys/kernel/debug/tracing/trace through the inotify
+	  interface.
+
 config HWLAT_TRACER
 	bool "Tracer to detect hardware latencies (like SMIs)"
 	select GENERIC_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee656d6d8..1640fd302e9a 100644
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
@@ -8191,6 +8193,50 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 		return;
 }
 
+#ifdef CONFIG_TRACE_FSNOTIFY
+
+static struct workqueue_struct *notify_wq;
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
+static __init void trace_file_notify_init(void)
+{
+	notify_wq = alloc_workqueue("irqsoff_notify_wq",
+				    WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!notify_wq)
+		pr_err("Unable to allocate irqsoff_notify_wq");
+}
+
+void trace_file_notify(struct trace_array *tr)
+{
+	if (likely(notify_wq))
+		queue_work(notify_wq, &tr->notify_work);
+}
+
+#else /* !CONFIG_TRACE_FSNOTIFY */
+
+#define trace_create_trace_file(tr, d_tracer) \
+	trace_create_file("trace", 0644, d_tracer, tr, &tracing_fops)
+
+#define trace_file_notify_init() do {} while (0)
+
+#endif /* !CONFIG_TRACE_FSNOTIFY */
+
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
@@ -8209,8 +8255,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_options", 0644, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", 0644, d_tracer,
-			  tr, &tracing_fops);
+	trace_create_trace_file(tr, d_tracer);
 
 	trace_create_file("trace_pipe", 0444, d_tracer,
 			  tr, &tracing_pipe_fops);
@@ -8415,6 +8460,7 @@ static __init int tracer_init_tracefs(void)
 {
 	struct dentry *d_tracer;
 
+	trace_file_notify_init();
 	trace_access_lock_init();
 
 	d_tracer = tracing_init_dentry();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..46f20c9bcf36 100644
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
+#ifdef CONFIG_TRACE_FSNOTIFY
+	struct dentry		*d_trace;
+	struct work_struct	notify_work;
+#endif
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
@@ -774,6 +779,16 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		    struct trace_pid_list **new_pid_list,
 		    const char __user *ubuf, size_t cnt);
 
+#ifdef CONFIG_TRACE_FSNOTIFY
+
+void trace_file_notify(struct trace_array *tr);
+
+#else /* !CONFIG_TRACE_FSNOTIFY */
+
+#define trace_file_notify(tr) do {} while (0)
+
+#endif /* !CONFIG_TRACE_FSNOTIFY */
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		   void *cond_data);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..911bb635fb4e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -323,6 +323,7 @@ check_critical_timing(struct trace_array *tr,
 	u64 T0, T1, delta;
 	unsigned long flags;
 	int pc;
+	bool notify = false;
 
 	T0 = data->preempt_timestamp;
 	T1 = ftrace_now(cpu);
@@ -353,6 +354,7 @@ check_critical_timing(struct trace_array *tr,
 	if (likely(!is_tracing_stopped())) {
 		tr->max_latency = delta;
 		update_max_tr_single(tr, current, cpu);
+		notify = true;
 	}
 
 	max_sequence++;
@@ -364,6 +366,9 @@ check_critical_timing(struct trace_array *tr,
 	data->critical_sequence = max_sequence;
 	data->preempt_timestamp = ftrace_now(cpu);
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+
+	if (unlikely(notify))
+		trace_file_notify(tr);
 }
 
 static nokprobe_inline void
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 743b2b520d34..c87e901108b9 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -437,6 +437,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	long disabled;
 	int cpu;
 	int pc;
+	bool report = false;
+	struct trace_array *tr = wakeup_trace;
 
 	tracing_record_cmdline(prev);
 
@@ -481,7 +483,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	T1 = ftrace_now(cpu);
 	delta = T1-T0;
 
-	if (!report_latency(wakeup_trace, delta))
+	report = report_latency(wakeup_trace, delta);
+	if (!report)
 		goto out_unlock;
 
 	if (likely(!is_tracing_stopped())) {
@@ -495,6 +498,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	local_irq_restore(flags);
 out:
 	atomic_dec(&per_cpu_ptr(wakeup_trace->trace_buffer.data, cpu)->disabled);
+	if (unlikely(report))
+		trace_file_notify(tr);
 }
 
 static void __wakeup_reset(struct trace_array *tr)
-- 
2.17.1

