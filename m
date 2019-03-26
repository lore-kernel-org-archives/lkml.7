Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A3720848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfCZCVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfCZCVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:21:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C1F20823;
        Tue, 26 Mar 2019 02:21:07 +0000 (UTC)
Date:   Mon, 25 Mar 2019 22:21:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/fair: do not expose some tracepoints to user
 if CONFIG_SCHEDSTATS is not set
Message-ID: <20190325222105.637f7e23@oasis.local.home>
In-Reply-To: <1553564407-1162-3-git-send-email-laoar.shao@gmail.com>
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
        <1553564407-1162-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 09:40:06 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
> be not exposed to user if CONFIG_SCHEDSTATS is not set.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/trace/events/sched.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 9a4bdfa..4686c7f 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>  		  __entry->pid, __entry->old_pid)
>  );
>  
> +#ifdef CONFIG_SCHEDSTATS

Instead of doing this #ifdef here, perhaps we should have at the top of the file:

#ifdef CONFIG_SCHEDSTATS
# define TRACE_EVENT_SCHEDSTAT TRACE_EVENT
#else
# define TRACE_EVENT_SCHEDSTAT TRACE_EVENT_NOP
#endif

And then switch the sched stat tracepoints from TRACE_EVENT to
use TRACE_EVENT_SCHEDSTAT.

And if my magic macro hat is working while sitting on the shelf (don't
have time to put it on), then the TRACE_EVENT_SCHEDSTAT will work like
a TRACE_EVENT when enabled, and a TRACE_EVENT_NOP when not.

Can you give that a try?

If this works, you don't need to duplicate all the parameters again.

-- Steve

>  /*
>   * XXX the below sched_stat tracepoints only apply to
> SCHED_OTHER/BATCH/IDLE
>   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
> @@ -395,6 +396,19 @@ static inline long
> __trace_sched_switch_state(bool preempt, struct task_struct *
> TP_PROTO(struct task_struct *tsk, u64 delay), TP_ARGS(tsk, delay));
>  
> +#else /* CONFIG_SCHEDSTATS */
> +
> +TRACE_EVENT_NONE(sched_stat_wait,
> +		 TP_PROTO(struct task_struct *tsk, u64 delay));
> +TRACE_EVENT_NONE(sched_stat_sleep,
> +		 TP_PROTO(struct task_struct *tsk, u64 delay));
> +TRACE_EVENT_NONE(sched_stat_iowait,
> +		 TP_PROTO(struct task_struct *tsk, u64 delay));
> +TRACE_EVENT_NONE(sched_stat_blocked,
> +		 TP_PROTO(struct task_struct *tsk, u64 delay));
> +
> +#endif /* CONFIG_SCHEDSTATS */
> +
>  /*
>   * Tracepoint for accounting runtime (time the task is executing
>   * on a CPU).

