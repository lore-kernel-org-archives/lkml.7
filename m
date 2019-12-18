Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A9C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747E2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="jMN5+QfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLRTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:47:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34526 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:47:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id 1so1100844uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1xpdtNHXlWaPkYmK/vLojLeBKA/LKyDWWwoVGPQ3/EE=;
        b=jMN5+QfJA2AF+eAz/SwDkZ6MSSY0s5Uym9VhV0H8pZ06xIMymQIvv7nk9+thDX/KpZ
         Bne3A6R1BH3oVZEvQ6Vg/PU2Qbxrbi46Bzvu+hgZFtCFE00gAWFrygw8eTgsT5iEhs54
         FI3/yrf1Zwl9On+XYXugNchMH117ypSlXan35TmwEsM6TOhEUhkuK/HvJgUB5Aezr12U
         dnXSTpwPl49aDYQOupB3zocpuP3tElipJV5eyLOYAMlVITFe7sAlZVDSvtY1rsszQVwy
         NwZ9sGkI2CsGVQBIKpDNiivPjn99BkKr1u8x3BHdacg097x9m0O5ea+Kf0ZV0Cy5oUJx
         yxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1xpdtNHXlWaPkYmK/vLojLeBKA/LKyDWWwoVGPQ3/EE=;
        b=i523a1/ZzDyRfO9QAidMFBkbeoOvWnZwe92taawFVxVb3CcssykItUgfqeU2KR6Hl+
         fjtFVDEJ7Cf1b7cFP6dMC6p+9rvrZ4WpFYoiSiVnMKeglnIf5wlwxjSqAwYg7vltADuM
         Mk+6p5ErW5CNTd6fCT/RYqn2i/bSKqkQmXawCnfxxcXsNHp9nG91+8qTlJSKxrONYejO
         xlIqomJmPN5v7m30ICDacM/Bro4QYyhapJn4Uq8rHLK+WkgCLkR4/quxaqAJNCqj66rb
         qzNoeRXIB2ZRwbq3VNGK/E+lkxg3nObFszZjWVzvFPQe+xX38cqea/iVhpk8WsPVKPUe
         nTvw==
X-Gm-Message-State: APjAAAXvZku6Vn6ekNfW0CJzEqpCFeUaMWtBfuYqol0Gfw4SJuA9LxuA
        0+S862Am3glRclL48YO3vuFHcg==
X-Google-Smtp-Source: APXvYqw1r0qjZ3K5moY1NH9aOjeyCLJbM40mDJmw59uVlavetZaMEPkdAtaQAk5bO9a8y3z81Xe8cg==
X-Received: by 2002:ab0:69c7:: with SMTP id u7mr2587946uaq.111.1576698456781;
        Wed, 18 Dec 2019 11:47:36 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id t36sm819219uat.10.2019.12.18.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:47:36 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:47:35 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, nachukannan@gmail.com,
        saiprakash.ranjan@outlook.com
Subject: Re: [PATCH] docs: ftrace: Specifies when buffers get clear
Message-ID: <20191218194735.nfgkps35r25emy33@frank-laptop>
References: <20191216042756.qnho3v2upqg4wm7o@frank-laptop>
 <20191216095251.4bee634e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216095251.4bee634e@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 09:52:51AM -0500, Steven Rostedt wrote:
> On Sun, 15 Dec 2019 23:27:56 -0500
> "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
> 
> > Clarify in a few places where the ring buffer and the "snapshot"
> > buffer are cleared as a side effect of an operation.
> > 
> > This will avoid users lost of tracing data because of these so far
> > undocumented behavior.
> > 
> > Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> > ---
> >  Documentation/trace/ftrace.rst | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index d2b5657ed33e..5cc65314e16d 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -95,7 +95,8 @@ of ftrace. Here is a list of some of the key files:
> >    current_tracer:
> >  
> >  	This is used to set or display the current tracer
> > -	that is configured.
> > +	that is configured. Changing the current tracer clears
> > +        the ring buffer content as well as the "snapshot" buffer.
> >  
> >    available_tracers:
> >  
> > @@ -126,7 +127,9 @@ of ftrace. Here is a list of some of the key files:
> >  	This file holds the output of the trace in a human
> >  	readable format (described below). Note, tracing is temporarily
> >  	disabled when the file is open for reading. Once all readers
> > -	are closed, tracing is re-enabled.
> > +	are closed, tracing is re-enabled. Opening this file for
> > +        writing with the O_TRUNC flag clears the ring buffer content
> > +        as well as the "snapshot" buffer.
> 
> Writing O_TRUNC into trace does not touch the snapshot buffer. I just
> tested to make sure (because that's not the behavior I remember making):
>

You are right. I should test it before email you. Sorry about that.
I miss read tracing_reset_all_online_cpus() when in reality it was
tracing_reset_online_cpus(), this kind of things happens to me when I
read kernel source code more than 12 hours per day to try to catchup ;)

vim-linux-coding-style does not include .rst files, so this patch has
the spacing wrong too, I fixed it in the v2 that I sent you too.

>  # cd /sys/kernel/tracing
>  # echo 1 > events/sched/enable
>  # echo 1 > snapshot
>  # head -15 snapshot  
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3563/3563   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             bash-20130 [007] d.h. 243924.135391: sched_stat_runtime: comm=bash pid=20130 runtime=584815 [ns] vruntime=116509213 [ns]
>             bash-20130 [007] d... 243924.135853: sched_waking: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
>             bash-20130 [007] d... 243924.135859: sched_wake_idle_without_ipi: cpu=2
>             bash-20130 [007] d... 243924.135861: sched_wakeup: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
>  # echo 0 > tracing_on
>  # head -15 trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1697/1697   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             sshd-20125 [005] d... 244126.123095: sched_stat_runtime: comm=sshd pid=20125 runtime=101555 [ns] vruntime=153686839 [ns]
>             sshd-20125 [005] d... 244126.123100: sched_switch: prev_comm=sshd prev_pid=20125 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
>             bash-20130 [007] d... 244126.123173: sched_waking: comm=kworker/u16:3 pid=20190 prio=120 target_cpu=006
>             bash-20130 [007] d... 244126.123177: sched_wake_idle_without_ipi: cpu=6
>  # echo > trace
>  # head -15 trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>  # head -15 snapshot
>  # tracer: nop
> #
> # entries-in-buffer/entries-written: 3563/3563   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             bash-20130 [007] d.h. 243924.135391: sched_stat_runtime: comm=bash pid=20130 runtime=584815 [ns] vruntime=116509213 [ns]
>             bash-20130 [007] d... 243924.135853: sched_waking: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
>             bash-20130 [007] d... 243924.135859: sched_wake_idle_without_ipi: cpu=2
>             bash-20130 [007] d... 243924.135861: sched_wakeup: comm=kworker/u16:2 pid=20112 prio=120 target_cpu=002
> 
> >  
> >    trace_pipe:
> >  
> > @@ -490,6 +493,9 @@ of ftrace. Here is a list of some of the key files:
> >  
> >  	  # echo global > trace_clock
> >  
> > +        Setting a clock clears the ring buffer content as well as the
> > +        "snapshot" buffer.
> > +
> 
> Yeah, this is true, because the sorting algorithm relies on the trace
> clocks matching in the buffers. If this becomes an issue, I'm sure we
> could change it.
> 

Besides, if the new clock is not in nanoseconds or "a clock at
all" (e.g. it is a counter) changing the clock it would produce an
inaccurate interpretation of the snapshot if we don't store the clock
that was used to fill the buffer that is in the snapshot. So, I think
that it is OK to reset the snapshot in this case. I just wanted to
document this behavior.

Thanks a lot for your quick response and sorry for my delay. I'm still
playing with email filters to properly accommodate the email flow of the
lists.

I want to congratulate you for such a nice piece of code you wrote:
ftrace. Being an Outreachy intern (mentors and co-interns CCed in this
email) and be able to learn so much from your code is a great
opportunity!

thanks
frank a.


> -- Steve
> 
> >    trace_marker:
> >  
> >  	This is a very useful file for synchronizing user space
> 
