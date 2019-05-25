Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C133C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CED21883
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEYDSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfEYDRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B169121897;
        Sat, 25 May 2019 03:17:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBq-0001m6-Qy; Fri, 24 May 2019 23:17:46 -0400
Message-Id: <20190525031746.723993166@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [PATCH 10/16 v3] function_graph: Have the instances use their own ftrace_ops for
 filtering
References: <20190525031633.811342628@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow for instances to have their own ftrace_ops part of the fgraph_ops that
makes the funtion_graph tracer filter on the set_ftrace_filter file of the
instance and not the top instance.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 +
 kernel/trace/fgraph.c                | 63 +++++++++++++++++-----------
 kernel/trace/ftrace.c                |  6 +--
 kernel/trace/trace.h                 | 16 +++----
 kernel/trace/trace_functions.c       |  2 +-
 kernel/trace/trace_functions_graph.c |  8 +++-
 6 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d0307c9b866e..e6a596e7cdf4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -752,6 +752,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 };
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 09e5bf2740a8..8b52993044bc 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -15,14 +15,6 @@
 
 #include "ftrace_internal.h"
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-#define ASSIGN_OPS_HASH(opsname, val) \
-	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
-#else
-#define ASSIGN_OPS_HASH(opsname, val)
-#endif
-
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
 
@@ -303,9 +295,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	int cnt = 0;
 	int i;
 
-	if (!ftrace_ops_test(&global_ops, func, NULL))
-		goto out;
-
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
@@ -325,7 +314,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			atomic_inc(&current->trace_overrun);
 			break;
 		}
-		if (fgraph_array[i]->entryfunc(&trace, fgraph_array[i])) {
+		if (ftrace_ops_test(&gops->ops, func, NULL) &&
+		    gops->entryfunc(&trace, gops)) {
 			offset = current->curr_ret_stack;
 			/* Check the top level stored word */
 			type = get_fgraph_type(current, offset);
@@ -597,18 +587,27 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
-static struct ftrace_ops graph_ops = {
-	.func			= ftrace_stub,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
-				   FTRACE_OPS_FL_INITIALIZED |
-				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_FL_STUB,
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops)
+{
+	dst_ops->func = ftrace_stub;
+	dst_ops->flags = FTRACE_OPS_FL_RECURSION_SAFE |
+		FTRACE_OPS_FL_PID |
+		FTRACE_OPS_FL_STUB;
+
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
-	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
+	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
 	/* trampoline_size is only needed for dynamically allocated tramps */
 #endif
-	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
-};
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (src_ops) {
+		dst_ops->func_hash = &src_ops->local_hash;
+		mutex_init(&dst_ops->local_hash.regex_lock);
+		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+	}
+#endif
+}
 
 void ftrace_graph_sleep_time_control(bool enable)
 {
@@ -807,11 +806,20 @@ static int start_graph_tracing(void)
 
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int ret = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!gops->ops.func) {
+		gops->ops.flags |= FTRACE_OPS_FL_STUB;
+		gops->ops.func = ftrace_stub;
+#ifdef FTRACE_GRAPH_TRAMP_ADDR
+		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
+#endif
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
@@ -848,9 +856,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		 */
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
-
-		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		command = FTRACE_START_FUNC_RET;
 	}
+
+	ret = ftrace_startup(&gops->ops, command);
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -858,6 +867,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
@@ -880,10 +890,15 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	}
 
 	ftrace_graph_active--;
+
+	if (!ftrace_graph_active)
+		command = FTRACE_STOP_FUNC_RET;
+
+	ftrace_shutdown(&gops->ops, command);
+
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6719a6cae67b..6d2d2a41a246 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2675,6 +2675,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	ftrace_ops_init(ops);
+
 	ret = __register_ftrace_function(ops);
 	if (ret)
 		return ret;
@@ -6226,7 +6228,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
-	init_array_fgraph_ops(tr);
+	init_array_fgraph_ops(tr, tr->ops);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
@@ -6679,8 +6681,6 @@ int register_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret = -1;
 
-	ftrace_ops_init(ops);
-
 	mutex_lock(&ftrace_lock);
 
 	ret = ftrace_startup(ops, 0);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 40b0471194bf..c45932573317 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -933,8 +933,8 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned long flags, int pc);
-extern void init_array_fgraph_ops(struct trace_array *tr);
-extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
+extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -998,6 +998,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	preempt_enable_notrace();
 	return ret;
 }
+
 #else
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
@@ -1023,18 +1024,19 @@ static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
 
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops);
+
 #else /* CONFIG_FUNCTION_GRAPH_TRACER */
 static inline enum print_line_t
 print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 {
 	return TRACE_TYPE_UNHANDLED;
 }
-static inline void init_array_fgraph_ops(struct trace_array *tr) { }
-static inline int allocate_fgraph_ops(struct trace_array *tr)
-{
-	return 0;
-}
 static inline void free_fgraph_ops(struct trace_array *tr) { }
+/* ftrace_ops may not be defined */
+#define init_array_fgraph_ops(tr, ops) do { } while (0)
+#define allocate_fgraph_ops(tr, ops) ({ 0; })
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 extern struct list_head ftrace_pids;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9b45ede6ea89..cfe1dc27a677 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -68,7 +68,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (ret)
 		return ret;
 
-	ret = allocate_fgraph_ops(tr);
+	ret = allocate_fgraph_ops(tr, tr->ops);
 	if (ret) {
 		kfree(tr->ops);
 		return ret;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 064811ba846c..0434e6052650 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -287,7 +287,7 @@ static struct fgraph_ops funcgraph_ops = {
 	.retfunc = &trace_graph_return,
 };
 
-int allocate_fgraph_ops(struct trace_array *tr)
+int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	struct fgraph_ops *gops;
 
@@ -300,6 +300,9 @@ int allocate_fgraph_ops(struct trace_array *tr)
 
 	tr->gops = gops;
 	gops->private = tr;
+
+	fgraph_init_ops(&gops->ops, ops);
+
 	return 0;
 }
 
@@ -308,10 +311,11 @@ void free_fgraph_ops(struct trace_array *tr)
 	kfree(tr->gops);
 }
 
-__init void init_array_fgraph_ops(struct trace_array *tr)
+__init void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	tr->gops = &funcgraph_ops;
 	funcgraph_ops.private = tr;
+	fgraph_init_ops(&tr->gops->ops, ops);
 }
 
 static int graph_trace_init(struct trace_array *tr)
-- 
2.20.1


