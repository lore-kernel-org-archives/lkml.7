Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416BC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1DD2184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562353607;
	bh=HbT6GjKIt8KN1EszbArMgTRUv6VU2lotBYYghQKjJfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nC1RbQQ2hwkfSHZyh5rRwgXraLzvXMPcihxCuuPfnAq1F6U09v1yOsxzLMXu0bx0N
	 ssFDoDlvgVWwyTbOT1L8sJ8MfxuueENxfkSi0/NyCD898dwXpFx4uSwU7ph/NksuJA
	 zuuXjx77NLHCe9dT+1LtPEPy/mCzwP0sgiJIhro0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGETGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGETGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:06:45 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0105D2184C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562353604;
        bh=HbT6GjKIt8KN1EszbArMgTRUv6VU2lotBYYghQKjJfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p18WGPG2+GQJ8CLnYv8I+0g/Pc3+61jdWQ+lW+ff4UOCDQIL0ONPUhlEctQSl+tat
         gyS69SxM5k5YMc2xlqZog3zNl3eUo1oqfMltQI4hydn2eOf81iKg4V4DKushsq5QM4
         xTYEfzvzOaQsH30rWeYNihJQcL88f7aVX/YpNMdU=
Received: by mail-wm1-f49.google.com with SMTP id s3so10134919wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 12:06:43 -0700 (PDT)
X-Gm-Message-State: APjAAAUCedmGjZMY2KWTlCoRpNucLITFjKyFME4JI3X5tpFg/eDBUyYQ
        SAEiw8x8P/s/8XI/VCYGU/Qw1kngDKxDCH5G1kveFw==
X-Google-Smtp-Source: APXvYqzfAqVyuTBN6+XXc7hO/eJ6B4/qezSHKvjU9F4rsEKkXDgjzoyfE4z7kbYNwgKjHRWtRg33jAqbJZQPOlEg8IE=
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr439608wmf.161.1562353602534;
 Fri, 05 Jul 2019 12:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
In-Reply-To: <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Jul 2019 12:06:31 -0700
X-Gmail-Original-Message-ID: <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
Message-ID: <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more robust
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 8:47 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 04/07/2019 16:51, Thomas Gleixner wrote:
> >   2) The loop termination logic is interesting at best.
> >
> >      If the machine has no TSC or cpu_khz is not known yet it tries 1
> >      million times to ack stale IRR/ISR bits. What?
> >
> >      With TSC it uses the TSC to calculate the loop termination. It takes a
> >      timestamp at entry and terminates the loop when:
> >
> >         (rdtsc() - start_timestamp) >= (cpu_hkz << 10)
> >
> >      That's roughly one second.
> >
> >      Both methods are problematic. The APIC has 256 vectors, which means
> >      that in theory max. 256 IRR/ISR bits can be set. In practice this is
> >      impossible as the first 32 vectors are reserved and not affected and
> >      the chance that more than a few bits are set is close to zero.
>
> [Disclaimer.  I talked to Thomas in private first, and he asked me to
> post this publicly as the CVE is almost a decade old already.]
>
> I'm afraid that this isn't quite true.
>
> In terms of IDT vectors, the first 32 are reserved for exceptions, but
> only the first 16 are reserved in the LAPIC.  Vectors 16-31 are fair
> game for incoming IPIs (SDM Vol3, 10.5.2 Valid Interrupt Vectors).
>
> In practice, this makes Linux vulnerable to CVE-2011-1898 / XSA-3, which
> I'm disappointed to see wasn't shared with other software vendors at the
> time.
>
> Because TPR is 0, an incoming IPI can trigger #AC, #CP, #VC or #SX
> without an error code on the stack, which results in a corrupt pt_regs
> in the exception handler, and a stack underflow on the way back out,
> most likely with a fault on IRET.
>
> These can be addressed by setting TPR to 0x10, which will inhibit
> delivery of any errant IPIs in this range, but some extra sanity logic
> may not go amiss.  An error code on a 64bit stack can be spotted with
> `testb $8, %spl` due to %rsp being aligned before pushing the exception
> frame.

Several years ago, I remember having a discussion with someone (Jan
Beulich, maybe?) about how to efficiently make the entry code figure
out the error code situation automatically.  I suspect it was on IRC
and I can't find the logs.  I'm thinking that maybe we should just
make Linux's idtentry code do something like this.

If nothing else, we could make idtentry do:

testl $8, %esp   /* shorter than testb IIRC */
jz 1f  /* or jnz -- too lazy to figure it out */
pushq $-1
1:

instead of the current hardcoded push.  The cost of a mispredicted
branch here will be smallish compared to the absurdly large cost of
the entry itself.  But I thought I had something more clever than
this.  This sequence works, but it still feels like it should be
possible to do better:

.macro PUSH_ERROR_IF_NEEDED
    /*
     * Before the IRET frame is pushed, RSP is aligned to a 16-byte
     * boundary.  After SS .. RIP and the error code are pushed, RSP is
     * once again aligned.  Pushing -1 will put -1 in the error code slot
     * (regs->orig_ax) if there was no error code.
    */

    pushq    $-1                /* orig_ax = -1, maybe */
    /* now RSP points to orig_ax (aligned) or di (misaligned) */
    pushq    $0
    /* now RSP points to di (misaligned) or si (aligned) */
    orq    $8, %rsp
    /* now RSP points to di */
    addq    $8, %rsp
    /* now RSP points to orig_ax, and we're in good shape */
.endm

Is there a better sequence for this?

A silly downside here is that the ORC annotations need to know the
offset to the IRET frame.  Josh, how ugly would it be to teach the
unwinder that UNWIND_HINT_IRET_REGS actually means "hey, maybe I'm 8
bytes off -- please realign RSP when doing your calculation"?

FWIW, the entry code is rather silly here in that it actually only
uses the orig_ax slot as a temporary dumping ground for the error code
and then it replaces it with -1 later on.  I don't remember whether
anything still cares about the -1.  Once upon a time, there was some
code that assumed that -1 meant "not in a syscall" and anything else
meant "in a syscall", but, if so, I suspect we should just kill that
code regardless.


>
> Another interesting problem is an IPI which its vector 0x80.  A cunning
> attacker can use this to simulate system calls from unsuspecting
> positions in userspace, or for interrupting kernel context.  At the very
> least the int0x80 path does an unconditional swapgs, so will try to run
> with the user gs, and I expect things will explode quickly from there.

At least SMAP helps here on non-FSGSBASE systems.  With FSGSBASE, I
suppose we could harden this by adding a special check to int $0x80 to
validate GSBASE.

>
> One option here is to look at ISR and complain if it is found to be set.

Barring some real hackery, we're toast long before we get far enough to do that.
