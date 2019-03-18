Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B987C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF292183E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCRXbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCRXbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:31:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CC56356DE;
        Mon, 18 Mar 2019 23:31:52 +0000 (UTC)
Received: from treble (ovpn-120-200.rdu2.redhat.com [10.10.120.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF325D704;
        Mon, 18 Mar 2019 23:31:50 +0000 (UTC)
Date:   Mon, 18 Mar 2019 18:31:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Message-ID: <20190318233148.25uee3s6g7vuhags@treble>
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Mar 2019 23:31:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 01:15:44PM -0700, Andy Lutomirski wrote:
> On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
> <elena.reshetova@intel.com> wrote:
> >
> > If CONFIG_RANDOMIZE_KSTACK_OFFSET is selected,
> > the kernel stack offset is randomized upon each
> > entry to a system call after fixed location of pt_regs
> > struct.
> >
> > This feature is based on the original idea from
> > the PaX's RANDKSTACK feature:
> > https://pax.grsecurity.net/docs/randkstack.txt
> > All the credits for the original idea goes to the PaX team.
> > However, the design and implementation of
> > RANDOMIZE_KSTACK_OFFSET differs greatly from the RANDKSTACK
> > feature (see below).
> >
> > Reasoning for the feature:
> >
> > This feature aims to make considerably harder various
> > stack-based attacks that rely on deterministic stack
> > structure.
> > We have had many of such attacks in past [1],[2],[3]
> > (just to name few), and as Linux kernel stack protections
> > have been constantly improving (vmap-based stack
> > allocation with guard pages, removal of thread_info,
> > STACKLEAK), attackers have to find new ways for their
> > exploits to work.
> >
> > It is important to note that we currently cannot show
> > a concrete attack that would be stopped by this new
> > feature (given that other existing stack protections
> > are enabled), so this is an attempt to be on a proactive
> > side vs. catching up with existing successful exploits.
> >
> > The main idea is that since the stack offset is
> > randomized upon each system call, it is very hard for
> > attacker to reliably land in any particular place on
> > the thread stack when attack is performed.
> > Also, since randomization is performed *after* pt_regs,
> > the ptrace-based approach to discover randomization
> > offset during a long-running syscall should not be
> > possible.
> >
> > [1] jon.oberheide.org/files/infiltrate12-thestackisback.pdf
> > [2] jon.oberheide.org/files/stackjacking-infiltrate11.pdf
> > [3] googleprojectzero.blogspot.com/2016/06/exploiting-
> > recursion-in-linux-kernel_20.html

Now that thread_info is off the stack, and vmap stack guard pages exist,
it's not clear to me what the benefit is.

> > The main issue with this approach is that it slightly breaks the
> > processing of last frame in the unwinder, so I have made a simple
> > fix to the frame pointer unwinder (I guess others should be fixed
> > similarly) and stack dump functionality to "jump" over the random hole
> > at the end. My way of solving this is probably far from ideal,
> > so I would really appreciate feedback on how to improve it.
> 
> That's probably a question for Josh :)
> 
> Another way to do the dirty work would be to do:
> 
>     char *ptr = alloca(offset);
>     asm volatile ("" :: "m" (*ptr));
> 
> in do_syscall_64() and adjust compiler flags as needed to avoid warnings.  Hmm.

I like the alloca() idea a lot.  If you do the stack adjustment in C,
then everything should just work, with no custom hacks in entry code or
the unwinders.

> >  /*
> >   * This does 'call enter_from_user_mode' unless we can avoid it based on
> >   * kernel config or using the static jump infrastructure.
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 1f0efdb7b629..0816ec680c21 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -167,13 +167,19 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
> >
> >         PUSH_AND_CLEAR_REGS rax=$-ENOSYS
> >
> > +       RANDOMIZE_KSTACK                /* stores randomized offset in r15 */
> > +
> >         TRACE_IRQS_OFF
> >
> >         /* IRQs are off. */
> >         movq    %rax, %rdi
> >         movq    %rsp, %rsi
> > +       sub     %r15, %rsp          /* substitute random offset from rsp */
> >         call    do_syscall_64           /* returns with IRQs disabled */
> >
> > +       /* need to restore the gap */
> > +       add     %r15, %rsp       /* add random offset back to rsp */
> 
> Off the top of my head, the nicer way to approach this would be to
> change this such that mov %rbp, %rsp; popq %rbp or something like that
> will do the trick.  Then the unwinder could just see it as a regular
> frame.  Maybe Josh will have a better idea.

Yes, we could probably do something like that.  Though I think I'd much
rather do the alloca() thing.  

-- 
Josh
