Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402021734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556732467;
	bh=2oTmPhZqaw3vNZbfB7bs4LyPn7qmFvHgcHnsZW4i4n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pv90yqlNuGla7uAL/ifPbSsO883d55wSla8v5o4JpIDmjS/5i0LfOq9cPNBS8lCvo
	 2jVkT+DgDz4QvWqMQf1GCwxq7Bnn1E1oAQ0ghnyLsHfJOwPfPqd5J4b95knhBLPfbt
	 VZ0dtE2nFiGlJEbi9G336BzpYH1XV9/STIi2ieMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEARlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEARlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:41:05 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB200217D4
        for <linux-kernel@vger.kernel.org>; Wed,  1 May 2019 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556732464;
        bh=2oTmPhZqaw3vNZbfB7bs4LyPn7qmFvHgcHnsZW4i4n0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jv7KC42MJxT8+3jykKY/7gnfrf6z6+cTx4xVH6r0kgUkJyaGQSHvAUM+QQGRsxYbT
         tXXZkEvyGIu3aY+uY041gZvJmj26qwRa063PUIp9UgGsEC/IxR6Shd8JAZlRLXETs0
         NOCkRYPiiYzqSQeGBPeDGabmYLf91IbszsuFkPyY=
Received: by mail-wm1-f46.google.com with SMTP id b67so4866236wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:41:03 -0700 (PDT)
X-Gm-Message-State: APjAAAV/+m00gaK85kjA9U/ap/YY8cERMbzmXoqxcL43reINooJP6fp1
        XcpOINL89lXws3vWwRINPMfg8mm21tSLLcdma4XHUw==
X-Google-Smtp-Source: APXvYqy1Hmv5g4Rys7L1REgIHb6mADZx4IN01lQcN/xXhxJGjq3CTbQvaVDfFeqkIll/vkb1fmQnpDrydR54DpOAVik=
X-Received: by 2002:a7b:c844:: with SMTP id c4mr7222559wml.108.1556732462310;
 Wed, 01 May 2019 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
 <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net> <C79FA889-BD9B-4427-902F-52EE33A3E6EF@intel.com>
In-Reply-To: <C79FA889-BD9B-4427-902F-52EE33A3E6EF@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 1 May 2019 10:40:50 -0700
X-Gmail-Original-Message-ID: <CALCETrV4zACb9L_FaU12ZF1O6_vjVyGrcyWwk-mfSUhyxGMXJA@mail.gmail.com>
Message-ID: <CALCETrV4zACb9L_FaU12ZF1O6_vjVyGrcyWwk-mfSUhyxGMXJA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base as
 GSBASE at the paranoid_entry
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 6:52 AM Bae, Chang Seok <chang.seok.bae@intel.com> w=
rote:
>
>
> > On Apr 5, 2019, at 06:50, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> >
> >
> >> On Apr 5, 2019, at 2:35 AM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
> >>
> >>> On Mon, 25 Mar 2019, Thomas Gleixner wrote:
> >>>> On Fri, 15 Mar 2019, Chang S. Bae wrote:
> >>>> ENTRY(paranoid_exit)
> >>>>   UNWIND_HINT_REGS
> >>>>   DISABLE_INTERRUPTS(CLBR_ANY)
> >>>>   TRACE_IRQS_OFF_DEBUG
> >>>> +    ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",    "nop",\
> >>>> +        X86_FEATURE_FSGSBASE
> >>>> +    wrgsbase    %rbx
> >>>> +    jmp    .Lparanoid_exit_no_swapgs;
> >>>
> >>> Again. A few newlines would make it more readable.
> >>>
> >>> This modifies the semantics of paranoid_entry and paranoid_exit. Look=
ing at
> >>> the usage sites there is the following code in the nmi maze:
> >>>
> >>>   /*
> >>>    * Use paranoid_entry to handle SWAPGS, but no need to use paranoid=
_exit
> >>>    * as we should not be calling schedule in NMI context.
> >>>    * Even with normal interrupts enabled. An NMI should not be
> >>>    * setting NEED_RESCHED or anything that normal interrupts and
> >>>    * exceptions might do.
> >>>    */
> >>>   call    paranoid_entry
> >>>   UNWIND_HINT_REGS
> >>>
> >>>   /* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
> >>>   movq    %rsp, %rdi
> >>>   movq    $-1, %rsi
> >>>   call    do_nmi
> >>>
> >>>   /* Always restore stashed CR3 value (see paranoid_entry) */
> >>>   RESTORE_CR3 scratch_reg=3D%r15 save_reg=3D%r14
> >>>
> >>>   testl    %ebx, %ebx            /* swapgs needed? */
> >>>   jnz    nmi_restore
> >>> nmi_swapgs:
> >>>   SWAPGS_UNSAFE_STACK
> >>> nmi_restore:
> >>>   POP_REGS
> >>>
> >>> I might be missing something, but how is that supposed to work when
> >>> paranoid_entry uses FSGSBASE? I think it's broken, but if it's not th=
en
> >>> there is a big fat comment missing explaining why.
> >>
> >> So this _is_ broken.
> >>
> >>  On entry:
> >>
> >>     rbx =3D rdgsbase()
> >>     wrgsbase(KERNEL_GS)
> >>
> >>  On exit:
> >>
> >>     if (ebx =3D=3D 0)
> >>          swapgs
> >>
> >> The resulting matrix:
> >>
> >>  |  ENTRY GS    | RBX        | EXIT        | GS on IRET    | RESULT
> >>  |        |        |        |        |
> >> 1 |  KERNEL_GS    | KERNEL_GS    | EBX =3D=3D 0    | USER_GS    | FAIL
> >>  |        |        |        |        |
> >> 2 |  KERNEL_GS    | KERNEL_GS    | EBX !=3D 0    | KERNEL_GS    | ok
> >>  |        |        |        |        |
> >> 3 |  USER_GS    | USER_GS    | EBX =3D=3D 0    | USER_GS    | ok
> >>  |        |        |        |        |
> >> 4 |  USER_GS    | USER_GS    | EBX !=3D 0    | KERNEL_GS    | FAIL
> >>
> >>
> >> #1 Just works by chance because it's unlikely that the lower 32bits of=
 a
> >>  per CPU kernel GS are all 0.
> >>
> >>  But it's just a question of probability that this turns into a
> >>  non-debuggable once per year crash (think KASLR).
> >>
> >> #4 This can happen when the NMI hits the kernel in some other entry co=
de
> >>  _BEFORE_ or _AFTER_ swapgs.
> >>
> >>  User space using GS addressing with GS[31:0] !=3D 0 will crash and bu=
rn.
> >>
> >>
> >
> > Hi all-
> >
> > In a previous incarnation of these patches, I complained about the use =
of SWAPGS in the paranoid path. Now I=E2=80=99m putting my maintainer foot =
down.  On a non-FSGSBASE system, the paranoid path known, definitively, whi=
ch GS is where, so SWAPGS is annoying. With FSGSBASE, unless you start look=
ing at the RIP that you interrupted, you cannot know whether you have user =
or kernel GSBASE live, since they can have literally the same value.  One o=
f the numerous versions of this patch compared the values and just said =E2=
=80=9Cwell, it=E2=80=99s harmless to SWAPGS if user code happens to use the=
 same value as the kernel=E2=80=9D.  I complained that it was far too fragi=
le.
> >
> > So I=E2=80=99m putting my foot down. If you all want my ack, you=E2=80=
=99re going to save the old GS, load the new one with WRGSBASE, and, on ret=
urn, you=E2=80=99re going to restore the old one with WRGSBASE. You will no=
t use SWAPGS in the paranoid path.
> >
> > Obviously, for the non-paranoid path, it all keeps working exactly like=
 it does now.
>
> Although I can see some other concerns with this, looks like it is still =
worth pursuing.
>
> >
> > Furthermore, if you folks even want me to review this series, the ptrac=
e tests need to be in place.  On inspection of the current code (after the =
debacle a few releases back), it appears the SETREGSET=E2=80=99s effect dep=
ends on the current values in the registers =E2=80=94 it does not actually =
seem to reliably load the whole state. So my confidence will be greatly inc=
reased if your series first adds a test that detects that bug (and fails!),=
 then fixes the bug in a tiny little patch, then adds FSGSBASE, and keeps t=
he test working.
> >
>
> I think I need to understand the issue. Appreciate if you can elaborate a=
 little bit.
>

This patch series gives a particular behavior to PTRACE_SETREGS and
PTRACE_POKEUSER.  There should be a test case that validates that
behavior, including testing the weird cases where gs !=3D 0 and gsbase
contains unusual values.  Some existing tests might be pretty close to
doing what's needed.

Beyond that, the current putreg() code does this:

    case offsetof(struct user_regs_struct,gs_base):
        /*
         * Exactly the same here as the %fs handling above.
         */
        if (value >=3D TASK_SIZE_MAX)
            return -EIO;
        if (child->thread.gsbase !=3D value)
            return do_arch_prctl_64(child, ARCH_SET_GS, value);
        return 0;

and do_arch_prctl_64(), in turn, does this:

    case ARCH_SET_GS: {
        if (unlikely(arg2 >=3D TASK_SIZE_MAX))
            return -EPERM;

        preempt_disable();
        /*
         * ARCH_SET_GS has always overwritten the index
         * and the base. Zero is the most sensible value
         * to put in the index, and is the only value that
         * makes any sense if FSGSBASE is unavailable.
         */
        if (task =3D=3D current) {
         [not used for ptrace]
        } else {
            task->thread.gsindex =3D 0;
            x86_gsbase_write_task(task, arg2);
        }

        ...

So writing the value that was already there to gsbase via putreg()
does nothing, but writing a *different* value implicitly clears gs,
but writing a different value will clear gs.

This behavior is, AFAICT, complete nonsense.  It happens to work
because usually gdb writes the same value back, and, in any case, gs
comes *after* gsbase in user_regs_struct, so gs gets replaced anyway.
But I think that this behavior should be fixed up and probably tested.
Certainly the behavior should *not* be the same on a fsgsbase kernel,
and and the fsgsbase behavior definitely needs a selftest.
