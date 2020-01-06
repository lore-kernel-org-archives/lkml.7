Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D08C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3220731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgAFVZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgAFVZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:25:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87AD020731;
        Mon,  6 Jan 2020 21:25:29 +0000 (UTC)
Date:   Mon, 6 Jan 2020 16:25:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes for 5.5-rc5
Message-ID: <20200106162528.56814293@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various tracing fixes:

 - kbuild found missing define of MCOUNT_INSN_SIZE for various build configs
 - Initialize variable to zero as gcc thinks it is used undefined
    (it really isn't but the code is subtle enough that this doesn't hurt)
 - Convert from do_div() to div64_ull() to prevent potential divide by zero
 - Unregister a trace point on error path in sched_wakeup tracer
 - Use signed offset for archs that can have stext not be first
 - A simple indentation fix (whitespace error)


Please pull the latest trace-v5.5-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5-rc5

Tag SHA1: f648cd56e3506f76f81703a43545729147a7c80f
Head SHA1: 72879ee0c53e2fc17f443f7b1adcc0d5130cd934


Colin Ian King (1):
      tracing: Fix indentation issue

Joel Fernandes (Google) (1):
      tracing: Change offset type to s32 in preempt/irq tracepoints

Kaitao Cheng (1):
      kernel/trace: Fix do not unregister tracepoints when register sched_migrate_task fail

Steven Rostedt (VMware) (3):
      tracing: Initialize val to zero in parse_entry of inject code
      tracing: Define MCOUNT_INSN_SIZE when not defined without direct calls
      tracing: Have stack tracer compile when MCOUNT_INSN_SIZE is not defined

Wen Yang (1):
      ftrace: Avoid potential division by zero in function profiler

----
 include/trace/events/preemptirq.h  |  8 ++++----
 kernel/trace/fgraph.c              | 14 ++++++++++++++
 kernel/trace/ftrace.c              |  6 +++---
 kernel/trace/trace_events_inject.c |  2 +-
 kernel/trace/trace_sched_wakeup.c  |  4 +++-
 kernel/trace/trace_seq.c           |  2 +-
 kernel/trace/trace_stack.c         |  5 +++++
 7 files changed, 31 insertions(+), 10 deletions(-)
---------------------------
diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 95fba0471e5b..3f249e150c0c 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -18,13 +18,13 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 	TP_ARGS(ip, parent_ip),
 
 	TP_STRUCT__entry(
-		__field(u32, caller_offs)
-		__field(u32, parent_offs)
+		__field(s32, caller_offs)
+		__field(s32, parent_offs)
 	),
 
 	TP_fast_assign(
-		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
-		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
+		__entry->caller_offs = (s32)(ip - (unsigned long)_stext);
+		__entry->parent_offs = (s32)(parent_ip - (unsigned long)_stext);
 	),
 
 	TP_printk("caller=%pS parent=%pS",
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a2659735db73..1af321dec0f1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -96,6 +96,20 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	return 0;
 }
 
+/*
+ * Not all archs define MCOUNT_INSN_SIZE which is used to look for direct
+ * functions. But those archs currently don't support direct functions
+ * anyway, and ftrace_find_rec_direct() is just a stub for them.
+ * Define MCOUNT_INSN_SIZE to keep those archs compiling.
+ */
+#ifndef MCOUNT_INSN_SIZE
+/* Make sure this only works without direct calls */
+# ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#  error MCOUNT_INSN_SIZE not defined with direct calls enabled
+# endif
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ac99a3500076..9bf1f2cd515e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -526,8 +526,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	}
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	avg = rec->time;
-	do_div(avg, rec->counter);
+	avg = div64_ul(rec->time, rec->counter);
 	if (tracing_thresh && (avg < tracing_thresh))
 		goto out;
 #endif
@@ -553,7 +552,8 @@ static int function_stat_show(struct seq_file *m, void *v)
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev,
+				  rec->counter * (rec->counter - 1) * 1000);
 	}
 
 	trace_seq_init(&s);
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d45079ee62f8..22bcf7c51d1e 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -195,7 +195,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 	unsigned long irq_flags;
 	void *entry = NULL;
 	int entry_size;
-	u64 val;
+	u64 val = 0;
 	int len;
 
 	entry = trace_alloc_entry(call, &entry_size);
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 5e43b9664eca..617e297f46dc 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -630,7 +630,7 @@ static void start_wakeup_tracer(struct trace_array *tr)
 	if (ret) {
 		pr_info("wakeup trace: Couldn't activate tracepoint"
 			" probe to kernel_sched_migrate_task\n");
-		return;
+		goto fail_deprobe_sched_switch;
 	}
 
 	wakeup_reset(tr);
@@ -648,6 +648,8 @@ static void start_wakeup_tracer(struct trace_array *tr)
 		printk(KERN_ERR "failed to start wakeup tracer\n");
 
 	return;
+fail_deprobe_sched_switch:
+	unregister_trace_sched_switch(probe_wakeup_sched_switch, NULL);
 fail_deprobe_wake_new:
 	unregister_trace_sched_wakeup_new(probe_wakeup, NULL);
 fail_deprobe:
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 344e4c1aa09c..87de6edafd14 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -381,7 +381,7 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 		       int prefix_type, int rowsize, int groupsize,
 		       const void *buf, size_t len, bool ascii)
 {
-		unsigned int save_len = s->seq.len;
+	unsigned int save_len = s->seq.len;
 
 	if (s->full)
 		return 0;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 4df9a209f7ca..c557f42a9397 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -283,6 +283,11 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	local_irq_restore(flags);
 }
 
+/* Some archs may not define MCOUNT_INSN_SIZE */
+#ifndef MCOUNT_INSN_SIZE
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 static void
 stack_trace_call(unsigned long ip, unsigned long parent_ip,
 		 struct ftrace_ops *op, struct pt_regs *pt_regs)
