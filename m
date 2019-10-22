Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB67FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD49021872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfJVSKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfJVSKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:10:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0CA20B7C;
        Tue, 22 Oct 2019 18:10:22 +0000 (UTC)
Date:   Tue, 22 Oct 2019 14:10:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022141021.2c4496c2@gandalf.local.home>
In-Reply-To: <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
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
        <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 10:50:56 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > +static void my_hijack_func(unsigned long ip, unsigned long pip,
> > +			   struct ftrace_ops *ops, struct pt_regs *regs)  
> 
> 1.
> To pass regs into the callback ftrace_regs_caller() has huge amount
> of stores to do. Saving selector registers is not fast. pushf/popf are even slower.
> ~200 bytes of stack is being used for save/restore.
> This is pure overhead that bpf execution cannot afford.
> bpf is different from traditional ftrace and other tracing, since
> it's often active 24/7. Every nanosecond counts.

Live patching is the same as what you have. If not even more critical.

Note, it would be easy to also implement a "just give me IP regs" flag,
or have that be the default if IPMODIFY is set and REGS is not.


> So for bpf I'm generating assembler trampoline tailored to specific kernel
> function that has its fentry nop replaced with a call to that trampoline.
> Instead of 20+ register save I save only arguments of that kernel function.
> For example the trampoline that attaches to kfree_skb() will save only two registers
> (rbp and rdi on x86) and will use 16 bytes of stack.
> 
> 2.
> The common ftrace callback api allows ftrace infra to use generic ftrace_ops_list_func()
> that works for all ftracers, but it doesn't scale.

That only happens if you have more than one callback to a same
function. Otherwise you get a dedicated trampoline.


> We see different teams writing bpf services that attach to the same function.
> In addition there are 30+ kprobes active in other places, so for every
> fentry the ftrace_ops_list_func() walks long linked list and does hash
> lookup for each. That's not efficient and we see this slowdown in practice.
> Because of unique trampoline for every kernel function single
> generic list caller is not possible.
> Instead generated unique trampoline handles all attached bpf program
> for this particular kernel function in a sequence of calls.

Why not have a single ftrace_ops() that calls this utility and do the
multiplexing then?

> No link lists to walk, no hash tables to lookup.
> All overhead is gone.
> 
> 3.
> The existing kprobe bpf progs are using pt_regs to read arguments. Due to

That was done because kprobes in general work off of int3. And the
saving of pt_regs was to reuse the code and allow kprobes to work both
with or without a ftrace helper.

> that ugliness all of them are written for single architecture (x86-64).
> Porting them to arm64 is not that hard, but porting to 32-bit arch is close
> to impossible. With custom generated trampoline we'll have bpf progs that
> work as-is on all archs. raw_tracepoint bpf progs already demonstrated
> that such portability is possible. This new kprobe++ progs will be similar.
> 
> 4.
> Due to uniqueness of bpf trampoline sharing trampoline between ftracers
> and bpf progs is not possible, so users would have to choose whether to
> ftrace that particular kernel function or attach bpf to it.
> Attach is not going to stomp on each other. I'm reusing ftrace_make_call/nop
> approach that checks that its a 'nop' being replaced.

What about the approach I showed here? Just register a ftrace_ops with
ip modify set, and then call you unique trampoline directly.

It would keep the modification all in one place instead of having
multiple implementations of it. We can make ftrace call your trampoline
just like it was called directly, without writing a whole new
infrastructure.

-- Steve


> 
> There probably will be some gotchas and unforeseen issues, since prototype
> is very rough and not in reviewable form yet. Will share when it's ready.

