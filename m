Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A39C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1575A2175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEYDSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfEYDRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A639F2189E;
        Sat, 25 May 2019 03:17:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBp-0001ii-Lr; Fri, 24 May 2019 23:17:45 -0400
Message-Id: <20190525031745.556089635@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:36 -0400
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
Subject: [PATCH 03/16 v3] fgraph: Have the current->ret_stack go down not up
References: <20190525031633.811342628@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Change the direction of the current->ret_stack shadown stack to move the
same as most normal arch stacks do.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 63e701771c20..b0f8ae269351 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -27,8 +27,9 @@
 #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
-/* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+#define SHADOW_STACK_MAX_INDEX SHADOW_STACK_INDEX
+/* Leave on a little buffer at the bottom */
+#define SHADOW_STACK_MIN_INDEX FGRAPH_RET_INDEX
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 #define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
@@ -89,16 +90,16 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
+	if (current->curr_ret_stack <= SHADOW_STACK_MIN_INDEX) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = current->curr_ret_stack;
-	RET_STACK_INC(current->curr_ret_stack);
-	ret_stack = RET_STACK(current, index);
+	RET_STACK_DEC(current->curr_ret_stack);
+	ret_stack = RET_STACK(current, current->curr_ret_stack);
+	/* Make sure interrupts see the current value of curr_ret_stack */
 	barrier();
 	ret_stack->ret = ret;
 	ret_stack->func = func;
@@ -129,7 +130,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	return 0;
  out_ret:
-	RET_STACK_DEC(current->curr_ret_stack);
+	RET_STACK_INC(current->curr_ret_stack);
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -144,9 +145,8 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	int index;
 
 	index = current->curr_ret_stack;
-	RET_STACK_DEC(index);
 
-	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
+	if (unlikely(index < 0 || index >= SHADOW_STACK_MAX_INDEX)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic, otherwise we have no where to go */
@@ -239,7 +239,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	RET_STACK_DEC(current->curr_ret_stack);
+	RET_STACK_INC(current->curr_ret_stack);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
@@ -302,9 +302,9 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	RET_STACK_DEC(index);
+	RET_STACK_INC(index);
 
-	for (i = index; i >= 0; RET_STACK_DEC(i)) {
+	for (i = index; i < SHADOW_STACK_MAX_INDEX; RET_STACK_INC(i)) {
 		ret_stack = RET_STACK(task, i);
 		if (ret_stack->retp == retp)
 			return ret_stack->ret;
@@ -322,13 +322,13 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		return ret;
 
 	task_idx = task->curr_ret_stack;
-	RET_STACK_DEC(task_idx);
+	RET_STACK_INC(task_idx);
 
-	if (!task->ret_stack || task_idx < *idx)
+	if (!task->ret_stack || task_idx > *idx)
 		return ret;
 
 	task_idx -= *idx;
-	RET_STACK_INC(*idx);
+	RET_STACK_DEC(*idx);
 
 	return RET_STACK(task, task_idx);
 }
@@ -391,7 +391,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
-			t->curr_ret_stack = 0;
+			t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
 			smp_wmb();
@@ -436,10 +436,11 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
+	for (index = next->curr_ret_stack + FGRAPH_RET_INDEX;
+	     index < SHADOW_STACK_MAX_INDEX; ) {
 		ret_stack = RET_STACK(next, index);
 		ret_stack->calltime += timestamp;
-		index -= FGRAPH_RET_INDEX;
+		index += FGRAPH_RET_INDEX;
 	}
 }
 
@@ -530,7 +531,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 {
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
-	t->curr_ret_stack = 0;
+	t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
 	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
-- 
2.20.1


