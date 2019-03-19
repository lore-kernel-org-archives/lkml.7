Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B798AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866FC2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCSNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbfCSNiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E7EC3082E68;
        Tue, 19 Mar 2019 13:38:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id D36B15EDE1;
        Tue, 19 Mar 2019 13:37:58 +0000 (UTC)
Date:   Tue, 19 Mar 2019 14:37:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        fweisbec@gmail.com
Subject: Re: [PATCH] perf: fix use after free of perf_trace_buf
Message-ID: <20190319133758.GB20602@krava>
References: <20190318151529.GT6058@hirez.programming.kicks-ass.net>
 <1552998060-5735-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552998060-5735-1-git-send-email-prsood@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 19 Mar 2019 13:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:51:00PM +0530, Prateek Sood wrote:
> SyS_perf_event_open()
>   free_event()
>     _free_event()
>       tp_perf_event_destroy()
>         perf_trace_destroy()
>           perf_trace_event_unreg() //free perf_trace_buf
> 
> trace_cpu_frequency()
>   perf_trace_cpu()
>     perf_trace_buf_alloc() //access perf_trace_buf
> 
> 	CPU0					CPU1
> perf_trace_event_unreg()                perf_trace_cpu()
> 					head = (event_call->perf_events)
> 
> free_percpu(tp_event->perf_events)
> tp_event->perf_events = NULL
> --total_ref_count
> free_percpu(perf_trace_buf[i])
> perf_trace_buf[i] = NULL
> 
> 					raw_data = perf_trace_buf[rctx]
> 					memset(raw_data)
> 
> A potential race exists between access of perf_trace_buf from

so there's no actual backtrace of the crash, right?

jirka

> perf_trace_buf_alloc() and perf_trace_event_unreg(). This can
> result in perf_trace_buf[rctx] being NULL during access from memset()
> in perf_trace_buf_alloc().
> 
> Change-Id: I95ae774b9fcc653aa808f2d9f3e4359b3605e909
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>  include/linux/trace_events.h    |  2 ++
>  include/trace/perf.h            |  5 +++-
>  kernel/trace/trace_event_perf.c | 63 ++++++++++++++++++++++++++++++++++-------
>  kernel/trace/trace_kprobe.c     | 10 +++++--
>  kernel/trace/trace_syscalls.c   | 14 ++++++---
>  kernel/trace/trace_uprobe.c     |  2 ++
>  6 files changed, 79 insertions(+), 17 deletions(-)
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
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 4629a61..6caca88 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -21,7 +21,8 @@ typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
>  	perf_trace_t;
>  
>  /* Count the events in use (per event id, not per instance) */
> -static int	total_ref_count;
> +static int alloc_ref_count;
> +static atomic_t access_ref_count[PERF_NR_CONTEXTS];
>  
>  static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  				 struct perf_event *p_event)
> @@ -88,6 +89,34 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  	return 0;
>  }
>  
> +void get_perf_trace_buf(void)
> +{
> +	int rctx;
> +
> +	rctx = perf_swevent_get_recursion_context();
> +	if (rctx < 0)
> +		return;
> +
> +	atomic_inc(&access_ref_count[rctx]);
> +	perf_swevent_put_recursion_context(rctx);
> +}
> +EXPORT_SYMBOL_GPL(get_perf_trace_buf);
> +NOKPROBE_SYMBOL(get_perf_trace_buf);
> +
> +void put_perf_trace_buf(void)
> +{
> +	int rctx;
> +
> +	rctx = perf_swevent_get_recursion_context();
> +	if (rctx < 0)
> +		return;
> +
> +	atomic_dec(&access_ref_count[rctx]);
> +	perf_swevent_put_recursion_context(rctx);
> +}
> +EXPORT_SYMBOL_GPL(put_perf_trace_buf);
> +NOKPROBE_SYMBOL(put_perf_trace_buf);
> +
>  static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  				struct perf_event *p_event)
>  {
> @@ -108,7 +137,7 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  
>  	tp_event->perf_events = list;
>  
> -	if (!total_ref_count) {
> +	if (!alloc_ref_count) {
>  		char __percpu *buf;
>  		int i;
>  
> @@ -125,11 +154,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  	if (ret)
>  		goto fail;
>  
> -	total_ref_count++;
> +	alloc_ref_count++;
>  	return 0;
>  
>  fail:
> -	if (!total_ref_count) {
> +	if (!alloc_ref_count) {
>  		int i;
>  
>  		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
> @@ -150,6 +179,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  {
>  	struct trace_event_call *tp_event = p_event->tp_event;
>  	int i;
> +	bool retry;
>  
>  	if (--tp_event->perf_refcount > 0)
>  		goto out;
> @@ -165,10 +195,21 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  	free_percpu(tp_event->perf_events);
>  	tp_event->perf_events = NULL;
>  
> -	if (!--total_ref_count) {
> -		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
> -			free_percpu(perf_trace_buf[i]);
> -			perf_trace_buf[i] = NULL;
> +	if (!--alloc_ref_count) {
> +again:
> +		retry = false;
> +		for (i = 0; (i < PERF_NR_CONTEXTS) && perf_trace_buf[i]; i++) {
> +			if (!atomic_read(&access_ref_count[i])) {
> +				free_percpu(perf_trace_buf[i]);
> +				perf_trace_buf[i] = NULL;
> +			} else
> +				retry = true;
> +		}
> +
> +		if (retry) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(msecs_to_jiffies(1));
> +			goto again;
>  		}
>  	}
>  out:
> @@ -453,15 +494,17 @@ void perf_trace_buf_update(void *record, u16 type)
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
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
