Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866222084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1BsrdId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfCAQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:00:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40502 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:00:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id x187so19842124oia.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W190I+yoZEdd0KSL3BGOC3ZLIzOQOJXLBGSLLzpQAP4=;
        b=D1BsrdIdDshr3lU3gfVOE8cWWYRYUjDEQgGH9NiJbfFJwB1YF6tozpgqwimx10vxfe
         GjR0RYGPwzA9u2R7ruiXCLWlxFNEIV8MVOSYQEieDl9Zz9dG1tIOnoF/q4D/tNsE4Kvl
         Q+r6rPcHv8u+xB6cFdJcZjdD8UGCG7uZ1tF1QZHjtbvfe5u25bQVSyguY/bR43l8hduq
         GMuKbLTYsBSCfhRWcB+Fh++mcNGXZ+fvulxxljhaAvcz1z9gxZPREiYGkEw7RR0NP64P
         G81ZryfeTlBmYDshM4kIhWSXRtIlKwmDmMt/KPQzCD0WvbMX22sVKEPbTp0KH3zNcdvb
         v5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W190I+yoZEdd0KSL3BGOC3ZLIzOQOJXLBGSLLzpQAP4=;
        b=eoxRBB7eDWjB3wkpUpgdjjaTwfXP8uLhYNsKhlcFhSZn4dkSFcW5GyUbsOfONlHZAZ
         Fqs/V9Zk9aItavwxhAp0wPyMuwbJ/1sJhNjz1oMLXPEUGoGSiNtUNuQbyoYX/kBLZcg6
         XknHp/9D8lTx3vGUkmQGO+4xBcPH2b6xuxJni8ncEoMY8bBIfib1PWReWUgS4PzXut5X
         aYWdx4aoGCdEf1bFclwBXcLJXV/LOMD8uPllr42R96/VOOWH9VQOfxGuRatLZL5+J73+
         v4j7B16zQYDFTD3g2j1kDDvzhA87ofCpeid/JY2fpocJVlwqCMOV/b6mAsuuBhqGMZbH
         8j1g==
X-Gm-Message-State: AHQUAuZhE58vLWRVivgHVnmFNcmwHb0CD7BJBV2Yj3toW43lQBCiQRv3
        AphFI+f9VYH8pshyjjGdC3gdIWg/2hKPLqg3BzpS1yU0
X-Google-Smtp-Source: AHgI3IacCeOjW33h8cstkaxyTXVKE5e1GxGf51NtRlghqz9L3It1fwf9yIQb+hIJss4zgKfkFMDc6RzL88/G63pl1u0=
X-Received: by 2002:aca:cc4d:: with SMTP id c74mr3791791oig.157.1551455999605;
 Fri, 01 Mar 2019 07:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20190301031201.7416-1-jannh@google.com> <20190301153258.GD22584@linux.intel.com>
In-Reply-To: <20190301153258.GD22584@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Mar 2019 16:59:33 +0100
Message-ID: <CAG48ez1LEKEd695bnoZ71k5EZ6ZxRc5wH3vfkbLA-XkMq1-_jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/unwind: handle NULL pointer calls better in frame unwinder
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:33 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
> On Fri, Mar 01, 2019 at 04:12:00AM +0100, Jann Horn wrote:
> > When the frame unwinder is invoked for an oops caused by a call to NULL,
> > it currently skips the parent function because BP still points to the
> > parent's stack frame; the (nonexistent) current function only has the first
> > half of a stack frame, and BP doesn't point to it yet.
> >
> > Add a special case for IP==0 that calculates a fake BP from SP, then uses
> > the real BP for the next frame.
> >
> > Note that this handles first_frame specially: We return information about
> > the parent function as long as the saved IP is >=first_frame, even if the
> > fake BP points below it.
> >
> > With an artificially-added NULL call in prctl_set_seccomp(), before this
> > patch, the trace is:
> >
> > Call Trace:
> >  ? prctl_set_seccomp+0x3a/0x50
> >  __x64_sys_prctl+0x457/0x6f0
> >  ? __ia32_sys_prctl+0x750/0x750
> >  do_syscall_64+0x72/0x160
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > After this patch, the trace is:
> >
> > Call Trace:
> >  prctl_set_seccomp+0x3a/0x50
> >  __x64_sys_prctl+0x457/0x6f0
> >  ? __ia32_sys_prctl+0x750/0x750
> >  do_syscall_64+0x72/0x160
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/include/asm/unwind.h  |  6 ++++++
> >  arch/x86/kernel/unwind_frame.c | 25 ++++++++++++++++++++++---
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
> > index 1f86e1b0a5cd..499578f7e6d7 100644
> > --- a/arch/x86/include/asm/unwind.h
> > +++ b/arch/x86/include/asm/unwind.h
> > @@ -23,6 +23,12 @@ struct unwind_state {
> >  #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
> >       bool got_irq;
> >       unsigned long *bp, *orig_sp, ip;
> > +     /*
> > +      * If non-NULL: The current frame is incomplete and doesn't contain a
> > +      * valid BP. When looking for the next frame, use this instead of the
> > +      * non-existent saved BP.
> > +      */
> > +     unsigned long *next_bp;
> >       struct pt_regs *regs;
> >  #else
> >       unsigned long *sp;
> > diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
> > index 3dc26f95d46e..9b9fd4826e7a 100644
> > --- a/arch/x86/kernel/unwind_frame.c
> > +++ b/arch/x86/kernel/unwind_frame.c
> > @@ -320,10 +320,14 @@ bool unwind_next_frame(struct unwind_state *state)
> >       }
> >
> >       /* Get the next frame pointer: */
> > -     if (state->regs)
> > +     if (state->next_bp) {
> > +             next_bp = state->next_bp;
> > +             state->next_bp = NULL;
> > +     } else if (state->regs) {
> >               next_bp = (unsigned long *)state->regs->bp;
> > -     else
> > +     } else {
> >               next_bp = (unsigned long *)READ_ONCE_TASK_STACK(state->task, *state->bp);
> > +     }
> >
> >       /* Move to the next frame if it's safe: */
> >       if (!update_stack_state(state, next_bp))
> > @@ -398,6 +402,21 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
> >
> >       bp = get_frame_pointer(task, regs);
> >
> > +     /*
> > +      * If we crash with IP==0, the last successfully executed instruction
> > +      * was probably an indirect function call with a NULL function pointer.
> > +      * That means that SP points into the middle of an incomplete frame:
> > +      * *SP is a return pointer, and *(SP-sizeof(unsigned long)) is where we
> > +      * would have written a frame pointer if we hadn't crashed.
> > +      * Pretend that the frame is complete and that BP points to it, but save
> > +      * the real BP so that we can use it when looking for the next frame.
> > +      */
> > +     if (regs && regs->ip == 0 &&
>
> Would it make sense to do 'regs->ip < PAGE_SIZE', a la show_fault_oops()?
> E.g. to handle bugs where a function pointer gets loaded with NULL+offset.

I don't think near-NULL function pointers make sense or are likely to
occur in practice. Near-NULL pointer dereferences happen when you add
a struct member offset to a NULL pointer, or something like that; but
functions are never inline in structs/arrays, so there isn't really a
reason to compute a function pointer by adding an offset to a (NULL)
pointer.
