Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B19C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E27220863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCRPCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCRPCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:02:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC9620850;
        Mon, 18 Mar 2019 15:02:52 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:02:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        sramana@codeaurora.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: extend total_ref_count usage to protect
 perf_trace_buf access
Message-ID: <20190318110250.7214cfa7@gandalf.local.home>
In-Reply-To: <1552906065-24137-1-git-send-email-prsood@codeaurora.org>
References: <1552906065-24137-1-git-send-email-prsood@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 16:17:45 +0530
Prateek Sood <prsood@codeaurora.org> wrote:

> A potential race exists between access of perf_trace_buf[i] from
> perf_trace_buf_alloc() and perf_trace_event_unreg(). This can
> result in perf_trace_buf[i] being NULL during access from memset()
> in perf_trace_buf_alloc().
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>  include/linux/trace_events.h    |  2 ++
>  include/trace/perf.h            |  5 ++++-
>  kernel/trace/trace_event_perf.c | 43 ++++++++++++++++++++++++++++-------------
>  kernel/trace/trace_kprobe.c     | 10 ++++++++--
>  kernel/trace/trace_syscalls.c   | 14 ++++++++++----
>  kernel/trace/trace_uprobe.c     |  2 ++
>  6 files changed, 56 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731..dbdad19 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -591,6 +591,8 @@ extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
>  extern void ftrace_profile_free_filter(struct perf_event *event);
>  void perf_trace_buf_update(void *record, u16 type);
>  void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
> +void get_perf_trace_buf(void);
> +void put_perf_trace_buf(void);
>  
>  void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>  void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index dbc6c74..f808c33 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -55,9 +55,10 @@
>  			     sizeof(u64));				\
>  	__entry_size -= sizeof(u32);					\
>  									\
> +	get_perf_trace_buf();						\
>  	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
>  	if (!entry)							\
> -		return;							\
> +		goto out;						\
>  									\
>  	perf_fetch_caller_regs(__regs);					\
>  									\
> @@ -68,6 +69,8 @@
>  	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
>  				  event_call, __count, __regs,		\
>  				  head, __task);			\
> +out:									\
> +	put_perf_trace_buf();						\

So this gets called in a trace point.

>  }
>  
>  /*
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 4629a61..fabfc21 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -21,7 +21,7 @@ typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
>  	perf_trace_t;
>  
>  /* Count the events in use (per event id, not per instance) */
> -static int	total_ref_count;
> +static atomic_t	total_ref_count;
>  
>  static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  				 struct perf_event *p_event)
> @@ -88,6 +88,27 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  	return 0;
>  }
>  
> +void get_perf_trace_buf()
> +{
> +	atomic_inc(&total_ref_count);
> +}
> +EXPORT_SYMBOL_GPL(get_perf_trace_buf);
> +NOKPROBE_SYMBOL(get_perf_trace_buf);
> +
> +void put_perf_trace_buf()
> +{
> +	int index;
> +
> +	if (atomic_dec_and_test(&total_ref_count)) {
> +		for (index = 0; index < PERF_NR_CONTEXTS; index++) {
> +			free_percpu(perf_trace_buf[index]);

free_percpu() calls spin locks and lots of other code, which because
you called this from a tracepoint, could cause deadlocks. Not only
that, it too calls tracepoints. Which will cause this to recurse.

This doesn't look like the right solution to me.

-- Steve


> +			perf_trace_buf[index] = NULL;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(put_perf_trace_buf);
> +NOKPROBE_SYMBOL(put_perf_trace_buf);
> +
>  static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  				struct perf_event *p_event)
>  {
> @@ -108,7 +129,7 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  
>  	tp_event->perf_events = list;
>  
> -	if (!total_ref_count) {
> +	if (!atomic_read(&total_ref_count)) {
>  		char __percpu *buf;
>  		int i;
>  
> @@ -125,11 +146,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  	if (ret)
>  		goto fail;
>  
> -	total_ref_count++;
> +	get_perf_trace_buf();
>  	return 0;
>  
>  fail:
> -	if (!total_ref_count) {
> +	if (!atomic_read(&total_ref_count)) {
>  		int i;
>  
>  		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
> @@ -164,13 +185,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  
>  	free_percpu(tp_event->perf_events);
>  	tp_event->perf_events = NULL;
> -
> -	if (!--total_ref_count) {
> -		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
> -			free_percpu(perf_trace_buf[i]);
> -			perf_trace_buf[i] = NULL;
> -		}
> -	}
> +	put_perf_trace_buf();
>  out:
>  	module_put(tp_event->mod);
>  }
> @@ -453,15 +468,17 @@ void perf_trace_buf_update(void *record, u16 type)
>  	memset(&regs, 0, sizeof(regs));
>  	perf_fetch_caller_regs(&regs);
>  
> +	get_perf_trace_buf();
>  	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
>  	if (!entry)
> -		return;
> +		goto out;
>  
>  	entry->ip = ip;
>  	entry->parent_ip = parent_ip;
>  	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
>  			      1, &regs, &head, NULL);
> -
> +out:
> +	put_perf_trace_buf();
>  #undef ENTRY_SIZE
>  }
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5d5129b..7830190 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1166,15 +1166,18 @@ static int kretprobe_event_define_fields(struct trace_event_call *event_call)
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
> +	get_perf_trace_buf();
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!entry)
> -		return 0;
> +		goto out;
>  
>  	entry->ip = (unsigned long)tk->rp.kp.addr;
>  	memset(&entry[1], 0, dsize);
>  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
>  	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
>  			      head, NULL);
> +out:
> +	put_perf_trace_buf();
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(kprobe_perf_func);
> @@ -1202,15 +1205,18 @@ static int kretprobe_event_define_fields(struct trace_event_call *event_call)
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
> +	get_perf_trace_buf();
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!entry)
> -		return;
> +		goto out;
>  
>  	entry->func = (unsigned long)tk->rp.kp.addr;
>  	entry->ret_ip = (unsigned long)ri->ret_addr;
>  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
>  	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
>  			      head, NULL);
> +out:
> +	put_perf_trace_buf();
>  }
>  NOKPROBE_SYMBOL(kretprobe_perf_func);
>  
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index f93a56d..a08110f 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -608,9 +608,10 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	size = ALIGN(size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
> +	get_perf_trace_buf();
>  	rec = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!rec)
> -		return;
> +		goto out;
>  
>  	rec->nr = syscall_nr;
>  	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
> @@ -620,12 +621,14 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
>  	    hlist_empty(head)) {
>  		perf_swevent_put_recursion_context(rctx);
> -		return;
> +		goto out;
>  	}
>  
>  	perf_trace_buf_submit(rec, size, rctx,
>  			      sys_data->enter_event->event.type, 1, regs,
>  			      head, NULL);
> +out:
> +	put_perf_trace_buf();
>  }
>  
>  static int perf_sysenter_enable(struct trace_event_call *call)
> @@ -706,9 +709,10 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	size = ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
> +	get_perf_trace_buf();
>  	rec = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!rec)
> -		return;
> +		goto out;
>  
>  	rec->nr = syscall_nr;
>  	rec->ret = syscall_get_return_value(current, regs);
> @@ -717,11 +721,13 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
>  	    hlist_empty(head)) {
>  		perf_swevent_put_recursion_context(rctx);
> -		return;
> +		goto out;
>  	}
>  
>  	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type,
>  			      1, regs, head, NULL);
> +out:
> +	put_perf_trace_buf();
>  }
>  
>  static int perf_sysexit_enable(struct trace_event_call *call)
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index be78d99..c931b22 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1116,6 +1116,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	if (hlist_empty(head))
>  		goto out;
>  
> +	get_perf_trace_buf();
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!entry)
>  		goto out;
> @@ -1140,6 +1141,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
>  			      head, NULL);
>   out:
> +	put_perf_trace_buf();
>  	preempt_enable();
>  }
>  

