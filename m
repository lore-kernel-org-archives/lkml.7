Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA25C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD24B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PuIStC4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfE1Jur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:50:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46007 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1Jur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:50:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so8111538pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FaonO9OiE+AFhe+XzZNJIiBBhebmapK5F5w7vlATJ/c=;
        b=PuIStC4qXaUUblnhJwW5cZH2ciMzQHqgVdzoJUd708iff9U5fXUszRdX28GKqQK39z
         Z5Hr/mdRRX+7Jt/91O32UDh1NiHOD7E2ZUS1EYQB2sPaD9IhrnL9WMt+yVfFgqAskYGX
         uA5TFCQQv7OX71v8480dGjCstE5xsxYm/yvLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaonO9OiE+AFhe+XzZNJIiBBhebmapK5F5w7vlATJ/c=;
        b=kIKsqzyljSNh4RkoZ5qyB7QmEIzGBClWrriZuUXf3md2WuZ8VhtzIyV7pKl4bDD9dl
         DclTaByRK8USRnlheBfN6kXlnJrkoPmIcH3VVJTkquMfCCZWQhMf5RAdJ3XutV1A4gjT
         32PEKSAEhOXO+bVpMRH7f3K5fjngnFBvKTzwLeEd57qvUcDiKuhxJ0jjjPQzB5W7Xxfu
         oRiMnZmgTix5iUrebaGnA8QjW865aTTtoO7YY9npihOQvVwTJATJoQtOGLikTZuvldZ/
         DMvhfI3b5SbsMSsaNN7u2S7LUxKCmgpZ2XpvAf+IFXKWBhHl8aDQcIBW8oHESUmpL3Q5
         JQag==
X-Gm-Message-State: APjAAAUBljYPVkDOEAR9Tw4Mji9mRDk1jPgjDq1+xE/3kxnWDmHuKq/W
        imTqUGjLaMRSvY4+0O+7gbKZLCH5WEllsw==
X-Google-Smtp-Source: APXvYqxFSSQx5XnRXFfK85Xi0//+oXeeOOT5gpHvZczAs4LwhQVUdJ2DBPHwEF3H8qpHQ/snZ7zIaw==
X-Received: by 2002:a17:902:404:: with SMTP id 4mr41395111ple.204.1559037046230;
        Tue, 28 May 2019 02:50:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f13sm2085716pje.11.2019.05.28.02.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 02:50:45 -0700 (PDT)
Date:   Tue, 28 May 2019 05:50:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH 01/16 v3] function_graph: Convert ret_stack to a series
 of longs
Message-ID: <20190528095043.GA252809@google.com>
References: <20190525031633.811342628@goodmis.org>
 <20190525031745.235716308@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525031745.235716308@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:16:34PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In order to make it possible to have multiple callbacks registered with the
> function_graph tracer, the retstack needs to be converted from an array of
> ftrace_ret_stack structures to an array of longs. This will allow to store
> the list of callbacks on the stack for the return side of the functions.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/sched.h |   2 +-
>  kernel/trace/fgraph.c | 124 ++++++++++++++++++++++++------------------
>  2 files changed, 71 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 11837410690f..1850d8a3c3f0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1113,7 +1113,7 @@ struct task_struct {
>  	int				curr_ret_depth;
>  
>  	/* Stack of return addresses for return function tracing: */
> -	struct ftrace_ret_stack		*ret_stack;
> +	unsigned long			*ret_stack;

Can it be converted to an array of unsigned int so the shadown stack space
can be better used? This way stack overflow chance is lesser if there are too
many registered fgraph users and the function call depth is too deep.
AFAICS from patch 5/13, you need only 32-bits for the ftrace_ret_stack
offset, type and array index, so the upper 32-bit would not be used.

thanks,

 - Joel


>  
>  	/* Timestamp for last schedule: */
>  	unsigned long long		ftrace_timestamp;
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8dfd5021b933..df48bbfc0a5a 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -23,6 +23,18 @@
>  #define ASSIGN_OPS_HASH(opsname, val)
>  #endif
>  
> +#define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
> +#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
> +#define SHADOW_STACK_SIZE (PAGE_SIZE)
> +#define SHADOW_STACK_INDEX			\
> +	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
> +/* Leave on a buffer at the end */
> +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> +
> +#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
> +#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
> +#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
> +
>  static bool kill_ftrace_graph;
>  int ftrace_graph_active;
>  
> @@ -59,6 +71,7 @@ static int
>  ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  			 unsigned long frame_pointer, unsigned long *retp)
>  {
> +	struct ftrace_ret_stack *ret_stack;
>  	unsigned long long calltime;
>  	int index;
>  
> @@ -75,23 +88,25 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	smp_rmb();
>  
>  	/* The return trace stack is full */
> -	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
> +	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
>  		atomic_inc(&current->trace_overrun);
>  		return -EBUSY;
>  	}
>  
>  	calltime = trace_clock_local();
>  
> -	index = ++current->curr_ret_stack;
> +	index = current->curr_ret_stack;
> +	RET_STACK_INC(current->curr_ret_stack);
> +	ret_stack = RET_STACK(current, index);
>  	barrier();
> -	current->ret_stack[index].ret = ret;
> -	current->ret_stack[index].func = func;
> -	current->ret_stack[index].calltime = calltime;
> +	ret_stack->ret = ret;
> +	ret_stack->func = func;
> +	ret_stack->calltime = calltime;
>  #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> -	current->ret_stack[index].fp = frame_pointer;
> +	ret_stack->fp = frame_pointer;
>  #endif
>  #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
> -	current->ret_stack[index].retp = retp;
> +	ret_stack->retp = retp;
>  #endif
>  	return 0;
>  }
> @@ -113,7 +128,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  
>  	return 0;
>   out_ret:
> -	current->curr_ret_stack--;
> +	RET_STACK_DEC(current->curr_ret_stack);
>   out:
>  	current->curr_ret_depth--;
>  	return -EBUSY;
> @@ -124,11 +139,13 @@ static void
>  ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  			unsigned long frame_pointer)
>  {
> +	struct ftrace_ret_stack *ret_stack;
>  	int index;
>  
>  	index = current->curr_ret_stack;
> +	RET_STACK_DEC(index);
>  
> -	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
> +	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
>  		ftrace_graph_stop();
>  		WARN_ON(1);
>  		/* Might as well panic, otherwise we have no where to go */
> @@ -136,6 +153,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  		return;
>  	}
>  
> +	ret_stack = RET_STACK(current, index);
>  #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>  	/*
>  	 * The arch may choose to record the frame pointer used
> @@ -151,22 +169,22 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  	 * Note, -mfentry does not use frame pointers, and this test
>  	 *  is not needed if CC_USING_FENTRY is set.
>  	 */
> -	if (unlikely(current->ret_stack[index].fp != frame_pointer)) {
> +	if (unlikely(ret_stack->fp != frame_pointer)) {
>  		ftrace_graph_stop();
>  		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
>  		     "  from func %ps return to %lx\n",
>  		     current->ret_stack[index].fp,
>  		     frame_pointer,
> -		     (void *)current->ret_stack[index].func,
> -		     current->ret_stack[index].ret);
> +		     (void *)ret_stack->func,
> +		     ret_stack->ret);
>  		*ret = (unsigned long)panic;
>  		return;
>  	}
>  #endif
>  
> -	*ret = current->ret_stack[index].ret;
> -	trace->func = current->ret_stack[index].func;
> -	trace->calltime = current->ret_stack[index].calltime;
> +	*ret = ret_stack->ret;
> +	trace->func = ret_stack->func;
> +	trace->calltime = ret_stack->calltime;
>  	trace->overrun = atomic_read(&current->trace_overrun);
>  	trace->depth = current->curr_ret_depth--;
>  	/*
> @@ -220,7 +238,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  	 * curr_ret_stack is after that.
>  	 */
>  	barrier();
> -	current->curr_ret_stack--;
> +	RET_STACK_DEC(current->curr_ret_stack);
>  
>  	if (unlikely(!ret)) {
>  		ftrace_graph_stop();
> @@ -246,12 +264,13 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  struct ftrace_ret_stack *
>  ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  {
> -	idx = task->curr_ret_stack - idx;
> +	int index = task->curr_ret_stack;
>  
> -	if (idx >= 0 && idx <= task->curr_ret_stack)
> -		return &task->ret_stack[idx];
> +	index -= FGRAPH_RET_INDEX * (idx + 1);
> +	if (index < 0)
> +		return NULL;
>  
> -	return NULL;
> +	return RET_STACK(task, index);
>  }
>  
>  /**
> @@ -273,18 +292,20 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  				    unsigned long ret, unsigned long *retp)
>  {
> +	struct ftrace_ret_stack *ret_stack;
>  	int index = task->curr_ret_stack;
>  	int i;
>  
>  	if (ret != (unsigned long)return_to_handler)
>  		return ret;
>  
> -	if (index < 0)
> -		return ret;
> +	RET_STACK_DEC(index);
>  
> -	for (i = 0; i <= index; i++)
> -		if (task->ret_stack[i].retp == retp)
> -			return task->ret_stack[i].ret;
> +	for (i = index; i >= 0; RET_STACK_DEC(i)) {
> +		ret_stack = RET_STACK(task, i);
> +		if (ret_stack->retp == retp)
> +			return ret_stack->ret;
> +	}
>  
>  	return ret;
>  }
> @@ -298,14 +319,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  		return ret;
>  
>  	task_idx = task->curr_ret_stack;
> +	RET_STACK_DEC(task_idx);
>  
>  	if (!task->ret_stack || task_idx < *idx)
>  		return ret;
>  
>  	task_idx -= *idx;
> -	(*idx)++;
> +	RET_STACK_INC(*idx);
>  
> -	return task->ret_stack[task_idx].ret;
> +	return RET_STACK(task, task_idx);
>  }
>  #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
>  
> @@ -339,7 +361,7 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
>  
>  /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
> -static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
> +static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {
>  	int i;
>  	int ret = 0;
> @@ -347,10 +369,7 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
>  	struct task_struct *g, *t;
>  
>  	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
> -		ret_stack_list[i] =
> -			kmalloc_array(FTRACE_RETFUNC_DEPTH,
> -				      sizeof(struct ftrace_ret_stack),
> -				      GFP_KERNEL);
> +		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
>  		if (!ret_stack_list[i]) {
>  			start = 0;
>  			end = i;
> @@ -369,9 +388,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
>  		if (t->ret_stack == NULL) {
>  			atomic_set(&t->tracing_graph_pause, 0);
>  			atomic_set(&t->trace_overrun, 0);
> -			t->curr_ret_stack = -1;
> +			t->curr_ret_stack = 0;
>  			t->curr_ret_depth = -1;
> -			/* Make sure the tasks see the -1 first: */
> +			/* Make sure the tasks see the 0 first: */
>  			smp_wmb();
>  			t->ret_stack = ret_stack_list[start++];
>  		}
> @@ -389,6 +408,7 @@ static void
>  ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
>  			struct task_struct *prev, struct task_struct *next)
>  {
> +	struct ftrace_ret_stack *ret_stack;
>  	unsigned long long timestamp;
>  	int index;
>  
> @@ -413,8 +433,11 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
>  	 */
>  	timestamp -= next->ftrace_timestamp;
>  
> -	for (index = next->curr_ret_stack; index >= 0; index--)
> -		next->ret_stack[index].calltime += timestamp;
> +	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
> +		ret_stack = RET_STACK(next, index);
> +		ret_stack->calltime += timestamp;
> +		index -= FGRAPH_RET_INDEX;
> +	}
>  }
>  
>  static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
> @@ -457,10 +480,10 @@ void update_function_graph_func(void)
>  		ftrace_graph_entry = __ftrace_graph_entry;
>  }
>  
> -static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
> +static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
>  
>  static void
> -graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
> +graph_init_task(struct task_struct *t, unsigned long *ret_stack)
>  {
>  	atomic_set(&t->tracing_graph_pause, 0);
>  	atomic_set(&t->trace_overrun, 0);
> @@ -476,7 +499,7 @@ graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
>   */
>  void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
>  {
> -	t->curr_ret_stack = -1;
> +	t->curr_ret_stack = 0;
>  	t->curr_ret_depth = -1;
>  	/*
>  	 * The idle task has no parent, it either has its own
> @@ -486,14 +509,11 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
>  		WARN_ON(t->ret_stack != per_cpu(idle_ret_stack, cpu));
>  
>  	if (ftrace_graph_active) {
> -		struct ftrace_ret_stack *ret_stack;
> +		unsigned long *ret_stack;
>  
>  		ret_stack = per_cpu(idle_ret_stack, cpu);
>  		if (!ret_stack) {
> -			ret_stack =
> -				kmalloc_array(FTRACE_RETFUNC_DEPTH,
> -					      sizeof(struct ftrace_ret_stack),
> -					      GFP_KERNEL);
> +			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
>  			if (!ret_stack)
>  				return;
>  			per_cpu(idle_ret_stack, cpu) = ret_stack;
> @@ -507,15 +527,13 @@ void ftrace_graph_init_task(struct task_struct *t)
>  {
>  	/* Make sure we do not use the parent ret_stack */
>  	t->ret_stack = NULL;
> -	t->curr_ret_stack = -1;
> +	t->curr_ret_stack = 0;
>  	t->curr_ret_depth = -1;
>  
>  	if (ftrace_graph_active) {
> -		struct ftrace_ret_stack *ret_stack;
> +		unsigned long *ret_stack;
>  
> -		ret_stack = kmalloc_array(FTRACE_RETFUNC_DEPTH,
> -					  sizeof(struct ftrace_ret_stack),
> -					  GFP_KERNEL);
> +		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
>  		if (!ret_stack)
>  			return;
>  		graph_init_task(t, ret_stack);
> @@ -524,7 +542,7 @@ void ftrace_graph_init_task(struct task_struct *t)
>  
>  void ftrace_graph_exit_task(struct task_struct *t)
>  {
> -	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
> +	unsigned long *ret_stack = t->ret_stack;
>  
>  	t->ret_stack = NULL;
>  	/* NULL must become visible to IRQs before we free it: */
> @@ -536,12 +554,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
>  /* Allocate a return stack for each task */
>  static int start_graph_tracing(void)
>  {
> -	struct ftrace_ret_stack **ret_stack_list;
> +	unsigned long **ret_stack_list;
>  	int ret, cpu;
>  
> -	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
> -				       sizeof(struct ftrace_ret_stack *),
> -				       GFP_KERNEL);
> +	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
>  
>  	if (!ret_stack_list)
>  		return -ENOMEM;
> -- 
> 2.20.1
> 
> 
