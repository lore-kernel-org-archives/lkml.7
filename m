Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF2C20828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552940168;
	bh=d5kxGT8RwjZLbBUOvdTXENsbpwEcgOAcXJdOyotlUpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AXBuZ18L0r2g+CcnxPomQ2Uox3M2i/fguFcAu6Bw98ToJtgCwNhVhkhbll+29eX4w
	 k2ZUfDoNCCFM/POeawCxwCnYckv/y6HbzUey7X1a3E223yr+bd0OQs9I/yQJ0/RM4U
	 qLh8cx7lpCJvY2YA1c0Uc4Http1aSoW81pHuuOFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCRUQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:16:05 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3565520828
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552940164;
        bh=d5kxGT8RwjZLbBUOvdTXENsbpwEcgOAcXJdOyotlUpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FY1kRnOiEt3DTCWpTUj7Uxsd36wdnyGqmUJS6ux1dqa5iXUMm2a87ZAKfmZzqeL/r
         gQxVMJxblFJcj7nAt5mjUJUo3EYePhD5keS3b4nHytvt7HpDaQ+Zyp5czEdstk41NS
         uk+IA+eHx42Uf52St4oeqXE7uOPxVu2YwCdp37ec=
Received: by mail-wr1-f46.google.com with SMTP id y13so14037600wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:16:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWhtITK8LlxPiL14lFNhiGCWXcaaU/AArOGZh10i2DwE9UxhP6q
        Xei27r7bgZej5quLNI+cV565Dm3oL9O52d21vkeJbQ==
X-Google-Smtp-Source: APXvYqz2h5oZQsfnagbVN2fIOcUKpuup9+0isfAFEktbJB4xDywTpD2k2hFtFsfBP7tIR9PdkkebJ2rZYiCcLNpYLzs=
X-Received: by 2002:adf:e58f:: with SMTP id l15mr13302886wrm.309.1552940162745;
 Mon, 18 Mar 2019 13:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190318094128.1488-1-elena.reshetova@intel.com>
In-Reply-To: <20190318094128.1488-1-elena.reshetova@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Mar 2019 13:15:44 -0700
X-Gmail-Original-Message-ID: <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
Message-ID: <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
<elena.reshetova@intel.com> wrote:
>
> If CONFIG_RANDOMIZE_KSTACK_OFFSET is selected,
> the kernel stack offset is randomized upon each
> entry to a system call after fixed location of pt_regs
> struct.
>
> This feature is based on the original idea from
> the PaX's RANDKSTACK feature:
> https://pax.grsecurity.net/docs/randkstack.txt
> All the credits for the original idea goes to the PaX team.
> However, the design and implementation of
> RANDOMIZE_KSTACK_OFFSET differs greatly from the RANDKSTACK
> feature (see below).
>
> Reasoning for the feature:
>
> This feature aims to make considerably harder various
> stack-based attacks that rely on deterministic stack
> structure.
> We have had many of such attacks in past [1],[2],[3]
> (just to name few), and as Linux kernel stack protections
> have been constantly improving (vmap-based stack
> allocation with guard pages, removal of thread_info,
> STACKLEAK), attackers have to find new ways for their
> exploits to work.
>
> It is important to note that we currently cannot show
> a concrete attack that would be stopped by this new
> feature (given that other existing stack protections
> are enabled), so this is an attempt to be on a proactive
> side vs. catching up with existing successful exploits.
>
> The main idea is that since the stack offset is
> randomized upon each system call, it is very hard for
> attacker to reliably land in any particular place on
> the thread stack when attack is performed.
> Also, since randomization is performed *after* pt_regs,
> the ptrace-based approach to discover randomization
> offset during a long-running syscall should not be
> possible.
>
> [1] jon.oberheide.org/files/infiltrate12-thestackisback.pdf
> [2] jon.oberheide.org/files/stackjacking-infiltrate11.pdf
> [3] googleprojectzero.blogspot.com/2016/06/exploiting-
> recursion-in-linux-kernel_20.html
>
> Design description:
>
> During most of the kernel's execution, it runs on the "thread
> stack", which is allocated at fork.c/dup_task_struct() and stored in
> a per-task variable (tsk->stack). Since stack is growing downward,
> the stack top can be always calculated using task_top_of_stack(tsk)
> function, which essentially returns an address of tsk->stack + stack
> size. When VMAP_STACK is enabled, the thread stack is allocated from
> vmalloc space.
>
> Thread stack is pretty deterministic on its structure - fixed in size,
> and upon every entry from a userspace to kernel on a
> syscall the thread stack is started to be constructed from an
> address fetched from a per-cpu cpu_current_top_of_stack variable.
> The first element to be pushed to the thread stack is the pt_regs struct
> that stores all required CPU registers and sys call parameters.
>
> The goal of RANDOMIZE_KSTACK_OFFSET feature is to add a random offset
> after the pt_regs has been pushed to the stack and the rest of thread
> stack (used during the syscall processing) every time a process issues
> a syscall. The source of randomness can be taken either from rdtsc or
> rdrand with performance implications listed below. The value of random
> offset is stored in a callee-saved register (r15 currently) and the
> maximum size of random offset is defined by __MAX_STACK_RANDOM_OFFSET
> value, which currently equals to 0xFF0.
>
> As a result this patch introduces 8 bits of randomness
> (bits 4 - 11 are randomized, bits 0-3 must be zero due to stack alignment)
> after pt_regs location on the thread stack.
> The amount of randomness can be adjusted based on how much of the
> stack space we wish/can trade for security.

Why do you need four zero bits at the bottom?  x86_64 Linux only
maintains 8 byte stack alignment.

>
> The main issue with this approach is that it slightly breaks the
> processing of last frame in the unwinder, so I have made a simple
> fix to the frame pointer unwinder (I guess others should be fixed
> similarly) and stack dump functionality to "jump" over the random hole
> at the end. My way of solving this is probably far from ideal,
> so I would really appreciate feedback on how to improve it.

That's probably a question for Josh :)

Another way to do the dirty work would be to do:

    char *ptr = alloca(offset);
    asm volatile ("" :: "m" (*ptr));

in do_syscall_64() and adjust compiler flags as needed to avoid warnings.  Hmm.

>
> Performance:
>
> 1) lmbench: ./lat_syscall -N 1000000 null
>     base:                     Simple syscall: 0.1774 microseconds
>     random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
>     random_offset (rdrand): Simple syscall: 0.3702 microseconds
>
> 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
>     base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
>     random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
>     random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop
>

Egads!  RDTSC is nice and fast but probably fairly easy to defeat.
RDRAND is awful.  I had hoped for better.

So perhaps we need a little percpu buffer that collects 64 bits of
randomness at a time, shifts out the needed bits, and refills the
buffer when we run out.

>  /*
>   * This does 'call enter_from_user_mode' unless we can avoid it based on
>   * kernel config or using the static jump infrastructure.
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1f0efdb7b629..0816ec680c21 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -167,13 +167,19 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
>
>         PUSH_AND_CLEAR_REGS rax=$-ENOSYS
>
> +       RANDOMIZE_KSTACK                /* stores randomized offset in r15 */
> +
>         TRACE_IRQS_OFF
>
>         /* IRQs are off. */
>         movq    %rax, %rdi
>         movq    %rsp, %rsi
> +       sub     %r15, %rsp          /* substitute random offset from rsp */
>         call    do_syscall_64           /* returns with IRQs disabled */
>
> +       /* need to restore the gap */
> +       add     %r15, %rsp       /* add random offset back to rsp */

Off the top of my head, the nicer way to approach this would be to
change this such that mov %rbp, %rsp; popq %rbp or something like that
will do the trick.  Then the unwinder could just see it as a regular
frame.  Maybe Josh will have a better idea.
