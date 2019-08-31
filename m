Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4764C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D0722CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfHaLIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 07:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfHaLIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 07:08:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2AE22CE9;
        Sat, 31 Aug 2019 11:08:40 +0000 (UTC)
Date:   Sat, 31 Aug 2019 07:08:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Various tracing fixes
Message-ID: <20190831070839.3f7dbc33@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Small fixes and minor cleanups for Tracing

 - Make exported ftrace function not static
 - Fix NULL pointer dereference in reading probes as they are created
 - Fix NULL pointer dereference in k/uprobe clean up path
 - Various documentation fixes


Please pull the latest trace-v5.3-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.3-rc6

Tag SHA1: b0d99ebe7abd58ab40cd18b4d2ac26ca394909d1
Head SHA1: c68c9ec1c52e5bcd221eb09bc5344ad4f407b204


Denis Efremov (1):
      tracing: Make exported ftrace_set_clr_event non-static

Jakub Kicinski (1):
      tracing: Correct kdoc formats

Jisheng Zhang (1):
      ftrace/x86: Remove mcount() declaration

Naveen N. Rao (2):
      ftrace: Fix NULL pointer dereference in t_probe_next()
      ftrace: Check for successful allocation of hash

Steven Rostedt (VMware) (1):
      ftrace: Check for empty hash and comment the race with registering probes

Xinpeng Liu (1):
      tracing/probe: Fix null pointer dereference

----
 arch/x86/include/asm/ftrace.h |  1 -
 include/linux/trace_events.h  |  1 +
 kernel/trace/ftrace.c         | 17 +++++++++++++++++
 kernel/trace/trace.c          | 26 ++++++++++++++------------
 kernel/trace/trace_events.c   |  2 +-
 kernel/trace/trace_probe.c    |  3 ++-
 6 files changed, 35 insertions(+), 15 deletions(-)
---------------------------
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 287f1f7b2e52..c38a66661576 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -16,7 +16,6 @@
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #ifndef __ASSEMBLY__
-extern void mcount(void);
 extern atomic_t modifying_ftrace_code;
 extern void __fentry__(void);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..30a8cdcfd4a4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -548,6 +548,7 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
 
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca34503f178..f9821a3374e9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3095,6 +3095,14 @@ t_probe_next(struct seq_file *m, loff_t *pos)
 		hnd = &iter->probe_entry->hlist;
 
 	hash = iter->probe->ops.func_hash->filter_hash;
+
+	/*
+	 * A probe being registered may temporarily have an empty hash
+	 * and it's at the end of the func_probes list.
+	 */
+	if (!hash || hash == EMPTY_HASH)
+		return NULL;
+
 	size = 1 << hash->size_bits;
 
  retry:
@@ -4320,12 +4328,21 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	mutex_unlock(&ftrace_lock);
 
+	/*
+	 * Note, there's a small window here that the func_hash->filter_hash
+	 * may be NULL or empty. Need to be carefule when reading the loop.
+	 */
 	mutex_lock(&probe->ops.func_hash->regex_lock);
 
 	orig_hash = &probe->ops.func_hash->filter_hash;
 	old_hash = *orig_hash;
 	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS, old_hash);
 
+	if (!hash) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ftrace_match_records(hash, glob, strlen(glob));
 
 	/* Nothing found? */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 525a97fbbc60..563e80f9006a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1567,9 +1567,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 
 /**
  * update_max_tr_single - only copy one trace over, and reset the rest
- * @tr - tracer
- * @tsk - task with the latency
- * @cpu - the cpu of the buffer to copy.
+ * @tr: tracer
+ * @tsk: task with the latency
+ * @cpu: the cpu of the buffer to copy.
  *
  * Flip the trace of a single CPU buffer between the @tr and the max_tr.
  */
@@ -1767,7 +1767,7 @@ static void __init apply_trace_boot_options(void);
 
 /**
  * register_tracer - register a tracer with the ftrace system.
- * @type - the plugin for the tracer
+ * @type: the plugin for the tracer
  *
  * Register a new plugin tracer.
  */
@@ -2230,9 +2230,9 @@ static bool tracing_record_taskinfo_skip(int flags)
 /**
  * tracing_record_taskinfo - record the task info of a task
  *
- * @task  - task to record
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *        - TRACE_RECORD_TGID for recording tgid
+ * @task:  task to record
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo(struct task_struct *task, int flags)
 {
@@ -2258,10 +2258,10 @@ void tracing_record_taskinfo(struct task_struct *task, int flags)
 /**
  * tracing_record_taskinfo_sched_switch - record task info for sched_switch
  *
- * @prev - previous task during sched_switch
- * @next - next task during sched_switch
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *          TRACE_RECORD_TGID for recording tgid
+ * @prev: previous task during sched_switch
+ * @next: next task during sched_switch
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
 					  struct task_struct *next, int flags)
@@ -3072,7 +3072,9 @@ static void trace_printk_start_stop_comm(int enabled)
 
 /**
  * trace_vbprintk - write binary msg to tracing buffer
- *
+ * @ip:    The address of the caller
+ * @fmt:   The string format to write to the buffer
+ * @args:  Arguments for @fmt
  */
 int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..648930823b57 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -787,7 +787,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dbef0d135075..fb6bfbc5bf86 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -895,7 +895,8 @@ void trace_probe_cleanup(struct trace_probe *tp)
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
-	kfree(call->class->system);
+	if (call->class)
+		kfree(call->class->system);
 	kfree(call->name);
 	kfree(call->print_fmt);
 }
