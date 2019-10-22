Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03592CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45D4205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klVQDaLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfJVRvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:51:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJVRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:51:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so10371104pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8G55Jk1GMPqeRi9vYI00VqhDvFZ9rV5IjptXWat2EE=;
        b=klVQDaLwF6kWCiJ1zGp4RUrWoW463FEGlriiVWZr0uHuoXzGwAbtsW2x2N0wm6XhUf
         WIaoyQgwlPYs1aQ0vCRQy+07Ate2zN4Qnm0Ad88arGgrBf20LiEbQEfzpDBuB2Ut+WRj
         JJu0Bdbon8TcQlnPINIsObEqcq+Crw0U2oO+OKbLrgGm8zutBjdaQMBfHL3c9caPSh2t
         GtWIsq8CmDEKAXyJ3qvFRSK+GcJTYOtr17OxzpEp+6wigc+tCEnVG4SxCDLBIajNXwhK
         Nc1maja9m7uEbS0PYWxiqaDdtxmThWWLw2D0Gnra1s09p6Fs7HkGfxph7En5vHtjcuwz
         1Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8G55Jk1GMPqeRi9vYI00VqhDvFZ9rV5IjptXWat2EE=;
        b=kZt5v3IntWO0+6155Xp07NDSzem6UU1jcREFJyKHFwVwljJYeA1Ejt6OaARHNoOjg1
         ZwrWFJtSJy3K73zP2MUb2BHFt19wnumRrt59Z/rqlrbcEreiu5BQvJILili6xm7khfUF
         bvBh/DUN9WtQguF15SZU2zKsR2HP3iRibAu8PVPGYZQEHVGQOkWvjMgQk/5Ay+PsQuJy
         G85EqZ7qy0HU756mjDetIlsPyVddX9Dq7qQCATcAo0vXJ2NG5I3OOlFNzfXu4OFUxUi8
         oce4yluChMr6Vx6mDCqmQUQbGFD6XcXZy4I14Ihwrl98g9hHIo4IwXovii9rNe5ttn7C
         U61g==
X-Gm-Message-State: APjAAAUrlEOuq6Y71twtNKWuoc1qu/Hm51rURat+0cPs9diu0F0Psx7V
        xT4NxYscjgjv1WNhfxj8Hqw=
X-Google-Smtp-Source: APXvYqx+8dMIyayjlRFych8T6fSuszslv11Dfz/dX1nD2wPhisqjVn5eFr+jiyw+ClxzUjN1k8VZHw==
X-Received: by 2002:a17:90a:bb0a:: with SMTP id u10mr6394716pjr.14.1571766658750;
        Tue, 22 Oct 2019 10:50:58 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::a087])
        by smtp.gmail.com with ESMTPSA id u11sm25858211pgo.65.2019.10.22.10.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 10:50:57 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:50:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
References: <20191004112237.GA19463@hirez.programming.kicks-ass.net>
 <20191004094228.5a5774fe@gandalf.local.home>
 <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
 <20191021204310.3c26f730@oasis.local.home>
 <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
 <20191021231630.49805757@oasis.local.home>
 <20191021231904.4b968dc1@oasis.local.home>
 <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
 <20191022071956.07e21543@gandalf.local.home>
 <20191022094455.6a0a1a27@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022094455.6a0a1a27@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:44:55AM -0400, Steven Rostedt wrote:
> On Tue, 22 Oct 2019 07:19:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > I'm not touching dyn_ftrace.
> > > Actually calling my stuff ftrace+bpf is probably not correct either.
> > > I'm reusing code patching of nop into call that ftrace does. That's it.
> > > Turned out I cannot use 99% of ftrace facilities.
> > > ftrace_caller, ftrace_call, ftrace_ops_list_func and the whole ftrace api
> > > with ip, parent_ip and pt_regs cannot be used for this part of the work.
> > > bpf prog needs to access raw function arguments. To achieve that I'm  
> > 
> > You can do that today with the ftrace facility, just like live patching
> > does. You register a ftrace_ops with the flag FTRACE_OPS_FL_IPMODIFY,
> > and your func will set the regs->ip to your bpf handler. When the
> > ftrace_ops->func returns, instead of going back to the called
> > function, it can jump to your bpf_handler. You can create a shadow stack
> > (like function graph tracer does) to save the return address for where
> > you bpf handler needs to return to. As your bpf_handler needs raw
> > access to the parameters, it may not even need the shadow stack because
> > it should know the function it is reading the parameters from.
> 
> To show just how easy this is, I wrote up a quick hack that hijacks the
> wake_up_process() function and adds a trace_printk() to see what was
> woken up. My output from the trace is this:
> 
>           <idle>-0     [007] ..s1    68.517276: my_wake_up: We are waking up rcu_preempt:10
>            <...>-1240  [001] ....    68.517727: my_wake_up: We are waking up kthreadd:2
>            <...>-1240  [001] d..1    68.517973: my_wake_up: We are waking up kworker/1:0:17
>             bash-1188  [003] d..2    68.519020: my_wake_up: We are waking up kworker/u16:3:140
>             bash-1188  [003] d..2    68.519138: my_wake_up: We are waking up kworker/u16:3:140
>             sshd-1187  [005] d.s2    68.519295: my_wake_up: We are waking up kworker/5:2:517
>           <idle>-0     [007] ..s1    68.522293: my_wake_up: We are waking up rcu_preempt:10
>           <idle>-0     [007] ..s1    68.526309: my_wake_up: We are waking up rcu_preempt:10
> 
> I added the code to the trace-event-sample.c sample module, and got the
> above when I loaded that module (modprobe trace-event-sample).
> 
> It's mostly non arch specific (that is, you can do this with any
> arch that supports the IPMODIFY flag). The only parts that would need
> arch specific code is the regs->ip compare. The pip check can also be
> done less "hacky". But this shows you how easy this can be done today.
> Not sure what is missing that you need.

yes. I've studied all these possibilites, tried a bunch ways to extend
and reuse ftrace_ops, but every time found something fundamental to
the existing ftrace design that doesn't work for bpf usage.
See below:

> Here's the patch:
> 
> diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
> index 1a72b7d95cdc..526a6098c811 100644
> --- a/samples/trace_events/trace-events-sample.c
> +++ b/samples/trace_events/trace-events-sample.c
> @@ -11,6 +11,41 @@
>  #define CREATE_TRACE_POINTS
>  #include "trace-events-sample.h"
>  
> +#include <linux/ftrace.h>
> +
> +int wake_up_process(struct task_struct *p);
> +
> +int x;
> +
> +static int my_wake_up(struct task_struct *p)
> +{
> +	int ret;
> +
> +	trace_printk("We are waking up %s:%d\n", p->comm, p->pid);
> +	ret = wake_up_process(p);
> +	/* Force not having a tail call */
> +	if (!x)
> +		return ret;
> +	return 0;
> +}
> +
> +static void my_hijack_func(unsigned long ip, unsigned long pip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)

1.
To pass regs into the callback ftrace_regs_caller() has huge amount
of stores to do. Saving selector registers is not fast. pushf/popf are even slower.
~200 bytes of stack is being used for save/restore.
This is pure overhead that bpf execution cannot afford.
bpf is different from traditional ftrace and other tracing, since
it's often active 24/7. Every nanosecond counts.
So for bpf I'm generating assembler trampoline tailored to specific kernel
function that has its fentry nop replaced with a call to that trampoline.
Instead of 20+ register save I save only arguments of that kernel function.
For example the trampoline that attaches to kfree_skb() will save only two registers
(rbp and rdi on x86) and will use 16 bytes of stack.

2.
The common ftrace callback api allows ftrace infra to use generic ftrace_ops_list_func()
that works for all ftracers, but it doesn't scale.
We see different teams writing bpf services that attach to the same function.
In addition there are 30+ kprobes active in other places, so for every
fentry the ftrace_ops_list_func() walks long linked list and does hash
lookup for each. That's not efficient and we see this slowdown in practice.
Because of unique trampoline for every kernel function single
generic list caller is not possible.
Instead generated unique trampoline handles all attached bpf program
for this particular kernel function in a sequence of calls.
No link lists to walk, no hash tables to lookup.
All overhead is gone.

3.
The existing kprobe bpf progs are using pt_regs to read arguments. Due to
that ugliness all of them are written for single architecture (x86-64).
Porting them to arm64 is not that hard, but porting to 32-bit arch is close
to impossible. With custom generated trampoline we'll have bpf progs that
work as-is on all archs. raw_tracepoint bpf progs already demonstrated
that such portability is possible. This new kprobe++ progs will be similar.

4.
Due to uniqueness of bpf trampoline sharing trampoline between ftracers
and bpf progs is not possible, so users would have to choose whether to
ftrace that particular kernel function or attach bpf to it.
Attach is not going to stomp on each other. I'm reusing ftrace_make_call/nop
approach that checks that its a 'nop' being replaced.

There probably will be some gotchas and unforeseen issues, since prototype
is very rough and not in reviewable form yet. Will share when it's ready.

