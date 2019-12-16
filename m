Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96460C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74782206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfLPOwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbfLPOwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:52:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53992206A5;
        Mon, 16 Dec 2019 14:52:53 +0000 (UTC)
Date:   Mon, 16 Dec 2019 09:52:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, nachukannan@gmail.com,
        saiprakash.ranjan@outlook.com
Subject: Re: [PATCH] docs: ftrace: Specifies when buffers get clear
Message-ID: <20191216095251.4bee634e@gandalf.local.home>
In-Reply-To: <20191216042756.qnho3v2upqg4wm7o@frank-laptop>
References: <20191216042756.qnho3v2upqg4wm7o@frank-laptop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2019 23:27:56 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> Clarify in a few places where the ring buffer and the "snapshot"
> buffer are cleared as a side effect of an operation.
> 
> This will avoid users lost of tracing data because of these so far
> undocumented behavior.
> 
> Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> ---
>  Documentation/trace/ftrace.rst | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index d2b5657ed33e..5cc65314e16d 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -95,7 +95,8 @@ of ftrace. Here is a list of some of the key files:
>    current_tracer:
>  
>  	This is used to set or display the current tracer
> -	that is configured.
> +	that is configured. Changing the current tracer clears
> +        the ring buffer content as well as the "snapshot" buffer.
>  
>    available_tracers:
>  
> @@ -126,7 +127,9 @@ of ftrace. Here is a list of some of the key files:
>  	This file holds the output of the trace in a human
>  	readable format (described below). Note, tracing is temporarily
>  	disabled when the file is open for reading. Once all readers
> -	are closed, tracing is re-enabled.
> +	are closed, tracing is re-enabled. Opening this file for
> +        writing with the O_TRUNC flag clears the ring buffer content
> +        as well as the "snapshot" buffer.

Writing O_TRUNC into trace does not touch the snapshot buffer. I just
tested to make sure (because that's not the behavior I remember making):

 # cd /sys/kernel/tracing
 # echo 1 > events/sched/enable
 # echo 1 > snapshot
 # head -15 snapshot  
# tracer: nop
#
# entries-in-buffer/entries-written: 3563/3563   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-20130 [007] d.h. 243924.135391: sched_stat_runtime: comm=bash pid=20130 runtime=584815 [ns] vruntime=116509213 [ns]
            bash-20130 [007] d... 243924.135853: sched_waking: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
            bash-20130 [007] d... 243924.135859: sched_wake_idle_without_ipi: cpu=2
            bash-20130 [007] d... 243924.135861: sched_wakeup: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
 # echo 0 > tracing_on
 # head -15 trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1697/1697   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            sshd-20125 [005] d... 244126.123095: sched_stat_runtime: comm=sshd pid=20125 runtime=101555 [ns] vruntime=153686839 [ns]
            sshd-20125 [005] d... 244126.123100: sched_switch: prev_comm=sshd prev_pid=20125 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
            bash-20130 [007] d... 244126.123173: sched_waking: comm=kworker/u16:3 pid=20190 prio=120 target_cpu=006
            bash-20130 [007] d... 244126.123177: sched_wake_idle_without_ipi: cpu=6
 # echo > trace
 # head -15 trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
 # head -15 snapshot
 # tracer: nop
#
# entries-in-buffer/entries-written: 3563/3563   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-20130 [007] d.h. 243924.135391: sched_stat_runtime: comm=bash pid=20130 runtime=584815 [ns] vruntime=116509213 [ns]
            bash-20130 [007] d... 243924.135853: sched_waking: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
            bash-20130 [007] d... 243924.135859: sched_wake_idle_without_ipi: cpu=2
            bash-20130 [007] d... 243924.135861: sched_wakeup: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002

>  
>    trace_pipe:
>  
> @@ -490,6 +493,9 @@ of ftrace. Here is a list of some of the key files:
>  
>  	  # echo global > trace_clock
>  
> +        Setting a clock clears the ring buffer content as well as the
> +        "snapshot" buffer.
> +

Yeah, this is true, because the sorting algorithm relies on the trace
clocks matching in the buffers. If this becomes an issue, I'm sure we
could change it.

-- Steve

>    trace_marker:
>  
>  	This is a very useful file for synchronizing user space

