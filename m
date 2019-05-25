Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13158C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D836A21773
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfEYDSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfEYDRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9EA218A6;
        Sat, 25 May 2019 03:17:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBq-0001jg-2k; Fri, 24 May 2019 23:17:46 -0400
Message-Id: <20190525031745.973033833@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:38 -0400
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
Subject: [PATCH 05/16 v3] function_graph: Allow multiple users to attach to function graph
References: <20190525031633.811342628@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow for multiple users to attach to function graph tracer at the same
time. Only 16 simultaneous users can attach to the tracer. This is because
there's an array that stores the pointers to the attached fgraph_ops. When a
a function being traced is entered, each of the ftrace_ops entryfunc is
called and if it returns non zero, its index into the array will be added to
the shadow stack.

On exit of the function being traced, the shadow stack will contain the
indexes of the ftrace_ops on the array that want their retfunc to be called.

Because a function may sleep for a long time (if a task sleeps itself), the
return of the function may be literally days later. If the ftrace_ops is
removed, its place on the array is replaced with a ftrace_ops that contains
the stub functions and that will be called when the function finally
returns.

If another ftrace_ops is added that happens to get the same index into the
array, its return function may be called. But that's actually the way things
current work with the old function graph tracer. If one tracer is removed
and another is added, the new one will get the return calls of the function
traced by the previous one, thus this is not a regression. This can be fixed
by adding a counter to each time the array item is updated and save that on
the shadow stack as well, such that it wont be called if the index saved
does not match the index on the array.

Note, being able to filter functions when both are called is not completely
handled yet, but that shouldn't be too hard to manage.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |   2 +
 kernel/trace/fgraph.c  | 334 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 283 insertions(+), 53 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..6fe69e0dc415 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -787,6 +787,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp);
 /*
  * Sometimes we don't want to trace a function with the function
  * graph tracer but we want them to keep traced by the usual function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 93b0e243a742..a01d418791dc 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -25,24 +25,144 @@
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
+
+/*
+ * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
+ * is allocated on the task's ret_stack, then each fgraph_ops on the
+ * fgraph_array[]'s entryfunc is called and if that returns non-zero, the
+ * index into the fgraph_array[] for that fgraph_ops is added to the ret_stack.
+ * As the associated ftrace_ret_stack saved for those fgraph_ops needs to
+ * be found, the index to it is also added to the ret_stack along with the
+ * index of the fgraph_array[] to each fgraph_ops that needs their retfunc
+ * called.
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * to the last ftrace_ret_stack saved. All references to the
+ * ftrace_ret_stack has the format of:
+ *
+ * bits:  0 - 13	Index in words from the previous ftrace_ret_stack
+ * bits: 14 - 15	Type of storage
+ *			  0 - reserved
+ *			  1 - fgraph_array index
+ * For fgraph_array_index:
+ *  bits: 16 - 23	The fgraph_ops fgraph_array index
+ *
+ * That is, at the end of function_graph_enter, if the first and forth
+ * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
+ * on the return of the function being traced, this is what will be on the
+ * task's shadow ret_stack: (the stack grows upward)
+ *
+
+ * |                                  |
+ * |             (X) | (N)            | ( N words away from previous ret_stack)
+ * +----------------------------------+
+ * | struct ftrace_ret_stack          |
+ * |   (stores the saved ret pointer) |
+ * +----------------------------------+
+ * | (0 << FGRAPH_ARRAY_SHIFT)|(1)    | ( 0 for index of first fgraph_ops)
+ * +----------------------------------+
+ * | (3 << FGRAPH_ARRAY_SHIFT)|(2)    | ( 3 for index of fourth fgraph_ops)
+ * |                                  | <- task->curr_ret_stack (points to data)
+ * +----------------------------------+
+ * |                                  |
+ *
+ * If a backtrace is required, and the real return pointer needs to be
+ * fetched, then it looks at the task's curr_ret_stack index, if it
+ * is greater less than the top, it would subtact one, and then mask the value
+ * on the ret_stack by FGRAPH_RET_INDEX_MASK and subtract FGRAPH_RET_INDEX
+ * from that, to get the index of the ftrace_ret_stack structure stored
+ * on the shadow stack.
+ */
+
+#define FGRAPH_RET_INDEX_SIZE	14
+#define FGRAPH_RET_INDEX_MASK	((1 << FGRAPH_RET_INDEX_SIZE) - 1)
+
+
+#define FGRAPH_TYPE_SIZE	2
+#define FGRAPH_TYPE_MASK	((1 << FGRAPH_TYPE_SIZE) - 1)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_RET_INDEX_SIZE
+
+enum {
+	FGRAPH_TYPE_RESERVED	= 0,
+	FGRAPH_TYPE_ARRAY	= 1,
+};
+
+#define FGRAPH_ARRAY_SIZE	16
+#define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
+#define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
+/* Currently the max stack index can't be more than register callers */
+#define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
+
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 #define SHADOW_STACK_MAX_INDEX SHADOW_STACK_INDEX
 /* Leave on a little buffer at the bottom */
-#define SHADOW_STACK_MIN_INDEX FGRAPH_RET_INDEX
+#define SHADOW_STACK_MIN_INDEX (FGRAPH_RET_INDEX + 1)
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
 
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
 static int fgraph_array_cnt;
-#define FGRAPH_ARRAY_SIZE	16
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int get_ret_stack_index(struct task_struct *t, int offset)
+{
+	return current->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+}
+
+static inline int get_fgraph_type(struct task_struct *t, int offset)
+{
+	return (current->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) &
+		FGRAPH_TYPE_MASK;
+}
+
+static inline int get_fgraph_array(struct task_struct *t, int offset)
+{
+	return (current->ret_stack[offset] >> FGRAPH_ARRAY_SHIFT) &
+		FGRAPH_ARRAY_MASK;
+}
+
+/*
+ * @offset: The index into @t->ret_stack to find the ret_stack entry
+ * @index: Where to place the index into @t->ret_stack of that entry
+ *
+ * Calling this with:
+ *
+ *   offset = task->curr_ret_stack;
+ *   do {
+ *	ret_stack = get_ret_stack(task, offset, &offset);
+ *   } while (ret_stack);
+ *
+ * Will iterate through all the ret_stack entries from curr_ret_stack
+ * down to the first one.
+ */
+static inline struct ftrace_ret_stack *
+get_ret_stack(struct task_struct *t, int offset, int *index)
+{
+	int idx;
+
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
+	if (offset < 0 || offset >= SHADOW_STACK_MAX_INDEX)
+		return NULL;
+
+	idx = get_ret_stack_index(t, offset);
+
+	if (idx <= 0 || idx > FGRAPH_MAX_INDEX)
+		return NULL;
+
+	offset += idx;
+	if (offset >= SHADOW_STACK_MAX_INDEX)
+		return NULL;
+
+	*index = offset + FGRAPH_RET_INDEX;;
+	return RET_STACK(t, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -116,10 +236,36 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 
 	calltime = trace_clock_local();
 
-	RET_STACK_DEC(current->curr_ret_stack);
-	ret_stack = RET_STACK(current, current->curr_ret_stack);
 	/* Make sure interrupts see the current value of curr_ret_stack */
+	index = current->curr_ret_stack - FGRAPH_RET_INDEX;
+	/* ret offset = 1 ; type = reserved */
+	current->ret_stack[index - 1] = 1;
+	ret_stack = RET_STACK(current, index);
+	ret_stack->ret = ret;
+	/*
+	 * The undwinders expect curr_ret_stack to point to either max index
+	 * or an index where to find the next ret_stack. Even though the
+	 * ret stack might be bogus, we want to write the ret and the
+	 * index to find the ret_stack before we increment the stack point.
+	 * If an interrupt comes in now before we increment the curr_ret_stack
+	 * it may blow away what we wrote. But that's fine, because the
+	 * index will still be correct (even though the ret wont be).
+	 * What we worry about is the index being correct after we increment
+	 * the curr_ret_stack and before we update that index, as if an
+	 * interrupt comes in and does an unwind stack dump, it will need
+	 * at least a correct index!
+	 */
+	barrier();
+	current->curr_ret_stack = index - 1;
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
 	barrier();
+
+	/* Still keep it reserved even if an interrupt came in */
+	current->ret_stack[index - 1] = 1;
+
 	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
@@ -136,6 +282,12 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	int offset;
+	int start;
+	int type;
+	int val;
+	int cnt = 0;
+	int i;
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
@@ -143,37 +295,87 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
 		goto out;
 
-	/* Only trace if the calling function expects to */
-	if (!fgraph_array[0]->entryfunc(&trace))
+	/* Use start for the distance to ret_stack (skipping over reserve) */
+	start = current->curr_ret_stack + 1;
+
+	for (i = 0; i < fgraph_array_cnt; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (gops == &fgraph_stub)
+			continue;
+
+		if (current->curr_ret_stack < 1) {
+			atomic_inc(&current->trace_overrun);
+			break;
+		}
+		if (fgraph_array[i]->entryfunc(&trace)) {
+			offset = current->curr_ret_stack;
+			/* Check the top level stored word */
+			type = get_fgraph_type(current, offset);
+
+			val = (i << FGRAPH_ARRAY_SHIFT) |
+				(FGRAPH_TYPE_ARRAY << FGRAPH_TYPE_SHIFT) |
+				(start - offset);
+
+			/* We can reuse the top word if it is reserved */
+			if (type == FGRAPH_TYPE_RESERVED) {
+				current->ret_stack[offset] = val;
+				cnt++;
+				continue;
+			}
+			val++;
+			offset--;
+
+			current->ret_stack[offset] = val;
+			/*
+			 * Write the value before we increment, so that
+			 * if an interrupt comes in after we increment
+			 * it will still see the value and skip over
+			 * this.
+			 */
+			barrier();
+			current->curr_ret_stack = offset;
+			/*
+			 * Have to write again, in case an interrupt
+			 * came in before the increment and after we
+			 * wrote the value.
+			 */
+			barrier();
+			current->ret_stack[offset] = val;
+			cnt++;
+		}
+	}
+
+	if (!cnt)
 		goto out_ret;
 
 	return 0;
  out_ret:
-	RET_STACK_INC(current->curr_ret_stack);
+	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-static void
+static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 			unsigned long frame_pointer)
 {
 	struct ftrace_ret_stack *ret_stack;
 	int index;
 
-	index = current->curr_ret_stack;
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
 
-	if (unlikely(index < 0 || index >= SHADOW_STACK_MAX_INDEX)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
+		WARN(1, "Bad function graph ret_stack pointer: %d",
+		     current->curr_ret_stack);
 		/* Might as well panic, otherwise we have no where to go */
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 
-	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -193,12 +395,12 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
-		     current->ret_stack[index].fp,
+		     ret_stack->fp,
 		     frame_pointer,
 		     (void *)ret_stack->func,
 		     ret_stack->ret);
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 #endif
 
@@ -206,13 +408,15 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth--;
+	trace->depth = current->curr_ret_depth;
 	/*
 	 * We still want to trace interrupts coming in if
 	 * max_depth is set to 1. Make sure the decrement is
 	 * seen before ftrace_graph_return.
 	 */
 	barrier();
+
+	return ret_stack;
 }
 
 /*
@@ -246,27 +450,44 @@ static struct notifier_block ftrace_suspend_notifier = {
  */
 unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
+	int offset;
+	int index;
+	int idx;
+	int i;
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
-	trace.rettime = trace_clock_local();
-	fgraph_array[0]->retfunc(&trace);
-	/*
-	 * The ftrace_graph_return() may still access the current
-	 * ret_stack structure, we need to make sure the update of
-	 * curr_ret_stack is after that.
-	 */
-	barrier();
-	RET_STACK_INC(current->curr_ret_stack);
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
+		return (unsigned long)panic;
 	}
 
+	trace.rettime = trace_clock_local();
+
+	offset = current->curr_ret_stack;
+	index = get_ret_stack_index(current, offset);
+
+	/* index has to be at least one! Optimize for it */
+	i = 0;
+	do {
+		idx = get_fgraph_array(current, offset + i);
+		fgraph_array[idx]->retfunc(&trace);
+		i++;
+	} while (i < index);
+
+	/*
+	 * The ftrace_graph_return() may still access the current
+	 * ret_stack structure, we need to make sure the update of
+	 * curr_ret_stack is after that.
+	 */
+	barrier();
+	current->curr_ret_stack += index + FGRAPH_RET_INDEX;
+	current->curr_ret_depth--;
 	return ret;
 }
 
@@ -284,15 +505,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
+	struct ftrace_ret_stack *ret_stack = NULL;
 	int index = task->curr_ret_stack;
 
-	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
-
-	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;
 
-	return RET_STACK(task, index);
+	do {
+		ret_stack = get_ret_stack(task, index, &index);
+	} while (ret_stack && --idx >= 0);
+
+	return ret_stack;
 }
 
 /**
@@ -315,16 +538,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index = task->curr_ret_stack;
-	int i;
+	int i = task->curr_ret_stack;
 
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	RET_STACK_INC(index);
-
-	for (i = index; i < SHADOW_STACK_MAX_INDEX; RET_STACK_INC(i)) {
-		ret_stack = RET_STACK(task, i);
+	while (i < SHADOW_STACK_MAX_INDEX) {
+		ret_stack = get_ret_stack(current, i, &i);
+		if (!ret_stack)
+			break;
 		if (ret_stack->retp == retp)
 			return ret_stack->ret;
 	}
@@ -335,21 +557,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	int task_idx;
+	struct ftrace_ret_stack *ret_stack;
+	int task_idx = task->curr_ret_stack;
+	int i;
 
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	task_idx = task->curr_ret_stack;
-	RET_STACK_INC(task_idx);
-
-	if (!task->ret_stack || task_idx > *idx)
+	if (!idx)
 		return ret;
 
-	task_idx -= *idx;
-	RET_STACK_DEC(*idx);
+	i = *idx;
+	do {
+		ret_stack = get_ret_stack(task, task_idx, &task_idx);
+		i--;
+	} while (i >= 0 && ret_stack);
+
+	if (ret_stack)
+		return ret_stack->ret;
 
-	return RET_STACK(task, task_idx);
+	return ret;
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -450,11 +677,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack + FGRAPH_RET_INDEX;
-	     index < SHADOW_STACK_MAX_INDEX; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index += FGRAPH_RET_INDEX;
+	for (index = next->curr_ret_stack; index < SHADOW_STACK_MAX_INDEX; ) {
+		ret_stack = get_ret_stack(next, index, &index);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -506,6 +732,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 	atomic_set(&t->tracing_graph_pause, 0);
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;
@@ -517,7 +745,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
  */
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
-	t->curr_ret_stack = 0;
+	t->curr_ret_stack = SHADOW_STACK_MAX_INDEX;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
-- 
2.20.1


