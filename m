Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55CC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A897C21871
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEYDRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbfEYDRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C52218A2;
        Sat, 25 May 2019 03:17:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBq-0001ma-W5; Fri, 24 May 2019 23:17:47 -0400
Message-Id: <20190525031746.882732112@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:44 -0400
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
Subject: [PATCH 11/16 v3] function_graph: Add "task variables" per task for fgraph_ops
References: <20190525031633.811342628@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a "task variables" array on the tasks shadow ret_stack that is the
size of longs for each possible registered fgraph_ops. That's a total of 16,
taking up 8 * 16 = 128 bytes (out of a page size 4k).

This will allow for fgraph_ops to do specific features on a per task basis
having a way to maintain state for each task.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/fgraph.c  | 72 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e6a596e7cdf4..a0bdd1745e56 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -754,6 +754,7 @@ struct fgraph_ops {
 	trace_func_graph_ret_t		retfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
+	int				idx;
 };
 
 /*
@@ -792,6 +793,7 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8b52993044bc..3bb1204c6cf9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -88,12 +88,19 @@ enum {
 
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
-#define SHADOW_STACK_MAX_INDEX SHADOW_STACK_INDEX
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_ARRAY_SIZE)
 /* Leave on a little buffer at the bottom */
 #define SHADOW_STACK_MIN_INDEX (FGRAPH_RET_INDEX + 1)
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+/*
+ * Each fgraph_ops has a reservered unsigned long at the end (top) of the
+ * ret_stack to store task specific state.
+ */
+#define SHADOW_STACK_TASK_VARS(ret_stack) \
+	((unsigned long *)(&(ret_stack)[SHADOW_STACK_MAX_INDEX]))
+
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
@@ -130,6 +137,44 @@ static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
 	return;
 }
 
+static void ret_stack_set_task_var(struct task_struct *t, int idx, long val)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	gvals[idx] = val;
+}
+
+static unsigned long *
+ret_stack_get_task_var(struct task_struct *t, int idx)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	return &gvals[idx];
+}
+
+static void ret_stack_init_task_vars(unsigned long *ret_stack)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(ret_stack);
+
+	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
+}
+
+/**
+ * fgraph_get_task_var - retrieve a task specific state variable
+ * @gops: The ftrace_ops that owns the task specific variable
+ *
+ * Every registered fgraph_ops has a task state variable
+ * reserved on the task's ret_stack. This function returns the
+ * address to that variable.
+ *
+ * Returns the address to the fgraph_ops @gops tasks specific
+ * unsigned long variable.
+ */
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops)
+{
+	return ret_stack_get_task_var(current, gops->idx);
+}
+
 /*
  * @offset: The index into @t->ret_stack to find the ret_stack entry
  * @index: Where to place the index into @t->ret_stack of that entry
@@ -647,6 +692,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
@@ -706,6 +752,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->tracing_graph_pause, 0);
 	atomic_set(&t->trace_overrun, 0);
+	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
 	t->curr_ret_depth = -1;
@@ -804,6 +851,24 @@ static int start_graph_tracing(void)
 	return ret;
 }
 
+static void init_task_vars(int idx)
+{
+	struct task_struct *g, *t;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (idle_task(cpu)->ret_stack)
+			ret_stack_set_task_var(idle_task(cpu), idx, 0);
+	}
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		if (t->ret_stack)
+			ret_stack_set_task_var(t, idx, 0);
+	} while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -840,6 +905,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	fgraph_array[i] = gops;
 	if (i + 1 > fgraph_array_cnt)
 		fgraph_array_cnt = i + 1;
+	gops->idx = i;
 
 	ftrace_graph_active++;
 
@@ -857,6 +923,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
 		command = FTRACE_START_FUNC_RET;
+	} else {
+		init_task_vars(gops->idx);
 	}
 
 	ret = ftrace_startup(&gops->ops, command);
@@ -881,6 +949,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (i >= fgraph_array_cnt)
 		goto out;
 
+	WARN_ON_ONCE(gops->idx != i);
+
 	fgraph_array[i] = &fgraph_stub;
 	if (i + 1 == fgraph_array_cnt) {
 		for (; i >= 0; i--)
-- 
2.20.1


