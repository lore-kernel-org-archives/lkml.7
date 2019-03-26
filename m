Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956762075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZMWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:22:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC502075C;
        Tue, 26 Mar 2019 12:21:59 +0000 (UTC)
Date:   Tue, 26 Mar 2019 08:21:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com
Subject: Re: [PATCH v2 2/3] sched/fair: do not expose some tracepoints to
 user if CONFIG_SCHEDSTATS is not set
Message-ID: <20190326082157.1d0c01cb@gandalf.local.home>
In-Reply-To: <1553602391-11926-3-git-send-email-laoar.shao@gmail.com>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
        <1553602391-11926-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Ingo,

Are you OK with this patch? If you ack it, I'll pull it in through my
tree.

-- Steve


On Tue, 26 Mar 2019 20:13:10 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
> be not exposed to user if CONFIG_SCHEDSTATS is not set.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/trace/events/sched.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 9a4bdfa..c8c7c7e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -241,7 +241,6 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>  DEFINE_EVENT(sched_process_template, sched_process_free,
>  	     TP_PROTO(struct task_struct *p),
>  	     TP_ARGS(p));
> -	     
>  
>  /*
>   * Tracepoint for a task exiting:
> @@ -336,11 +335,20 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>  		  __entry->pid, __entry->old_pid)
>  );
>  
> +
> +#ifdef CONFIG_SCHEDSTATS
> +#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT
> +#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS
> +#else
> +#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT_NOP
> +#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS_NOP
> +#endif
> +
>  /*
>   * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
>   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
>   */
> -DECLARE_EVENT_CLASS(sched_stat_template,
> +DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
>  
>  	TP_PROTO(struct task_struct *tsk, u64 delay),
>  
> @@ -363,12 +371,11 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>  			(unsigned long long)__entry->delay)
>  );
>  
> -
>  /*
>   * Tracepoint for accounting wait time (time the task is runnable
>   * but not actually running due to scheduler contention).
>   */
> -DEFINE_EVENT(sched_stat_template, sched_stat_wait,
> +DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_wait,
>  	     TP_PROTO(struct task_struct *tsk, u64 delay),
>  	     TP_ARGS(tsk, delay));
>  
> @@ -376,7 +383,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>   * Tracepoint for accounting sleep time (time the task is not runnable,
>   * including iowait, see below).
>   */
> -DEFINE_EVENT(sched_stat_template, sched_stat_sleep,
> +DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_sleep,
>  	     TP_PROTO(struct task_struct *tsk, u64 delay),
>  	     TP_ARGS(tsk, delay));
>  
> @@ -384,14 +391,14 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>   * Tracepoint for accounting iowait time (time the task is not runnable
>   * due to waiting on IO to complete).
>   */
> -DEFINE_EVENT(sched_stat_template, sched_stat_iowait,
> +DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_iowait,
>  	     TP_PROTO(struct task_struct *tsk, u64 delay),
>  	     TP_ARGS(tsk, delay));
>  
>  /*
>   * Tracepoint for accounting blocked time (time the task is in uninterruptible).
>   */
> -DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
> +DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_blocked,
>  	     TP_PROTO(struct task_struct *tsk, u64 delay),
>  	     TP_ARGS(tsk, delay));
>  

