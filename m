Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A9C468AA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3D216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562359210;
	bh=3rNzLuURIot9kjZOouo8mpgcH2k7Tx+lkD/aZzwEAaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EddM2+N6o+t4QJ/yA+y7WSLcZn9CtfEJksrPLe1iRdmQOGZpJmx70hAijwKM9NoyZ
	 HnbD40KSzZEm9TarQAmhHxOTJbmU1F6D/xQTXmJYbYEJgo2MKhbms1Q+R0hrPvqo3N
	 liwHk7jwYJn8nuwM5TLzVyJ6tk/0xO4uLJo1A/gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfGEUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfGEUkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:40:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A97A216FD
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562359207;
        bh=3rNzLuURIot9kjZOouo8mpgcH2k7Tx+lkD/aZzwEAaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lMXbFdQ54rR/dKtXF5R72dQoV+V9vHUXz3N9RZXXoKmh1I07WVMJBVIKmNFV5wDRl
         vs1r+/AklWuPuI9JIZWYSNBqg/UMVaLC0lKuRzBLQZDh1b9qy70UVBkeCmu1MCixVQ
         DesmFg4y1MALHJl5wXn1dwEQXZegoN01tx/DD4HI=
Received: by mail-wr1-f49.google.com with SMTP id z1so6423183wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:40:07 -0700 (PDT)
X-Gm-Message-State: APjAAAV+9G0VEizjYP1Yt9cPPIUvg73xUrCO3k2aSZpP0Nur7ofeBJ96
        9PtT8k4yhj3E236BhzG9aUjiNJ8JxMYmGnepj8Ch1A==
X-Google-Smtp-Source: APXvYqxtiocly/BYYea3ro/QNS5JGxuLXt7ZZrobIITcEb2FsllteUnfu94+coqcz/AYUlZ/0EtAA4+jedjrgvTRJpI=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr4974171wrm.265.1562359206078;
 Fri, 05 Jul 2019 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
 <alpine.DEB.2.21.1907052227140.3648@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907052227140.3648@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Jul 2019 13:39:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXPX5CXOOVHhN2Npvxh=ZRSA4ttC+VaNekF1W13Z=FLkA@mail.gmail.com>
Message-ID: <CALCETrXPX5CXOOVHhN2Npvxh=ZRSA4ttC+VaNekF1W13Z=FLkA@mail.gmail.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more robust
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 1:36 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 5 Jul 2019, Andy Lutomirski wrote:
> > On Fri, Jul 5, 2019 at 8:47 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > > Because TPR is 0, an incoming IPI can trigger #AC, #CP, #VC or #SX
> > > without an error code on the stack, which results in a corrupt pt_regs
> > > in the exception handler, and a stack underflow on the way back out,
> > > most likely with a fault on IRET.
> > >
> > > These can be addressed by setting TPR to 0x10, which will inhibit
> > > delivery of any errant IPIs in this range, but some extra sanity logic
> > > may not go amiss.  An error code on a 64bit stack can be spotted with
> > > `testb $8, %spl` due to %rsp being aligned before pushing the exception
> > > frame.
> >
> > Several years ago, I remember having a discussion with someone (Jan
> > Beulich, maybe?) about how to efficiently make the entry code figure
> > out the error code situation automatically.  I suspect it was on IRC
> > and I can't find the logs.  I'm thinking that maybe we should just
> > make Linux's idtentry code do something like this.
> >
> > If nothing else, we could make idtentry do:
> >
> > testl $8, %esp   /* shorter than testb IIRC */
> > jz 1f  /* or jnz -- too lazy to figure it out */
> > pushq $-1
> > 1:
>
> Errm, no. We should not silently paper over it. If we detect that this came
> in with a wrong stack frame, i.e. not from a CPU originated exception, then
> we truly should yell loud. Also in that case you want to check the APIC:ISR
> and issue an EOI to clear it.

It gives us the option to replace idtentry with something
table-driven.  I don't think I love it, but it's not an awful idea.



>
> > > Another interesting problem is an IPI which its vector 0x80.  A cunning
> > > attacker can use this to simulate system calls from unsuspecting
> > > positions in userspace, or for interrupting kernel context.  At the very
> > > least the int0x80 path does an unconditional swapgs, so will try to run
> > > with the user gs, and I expect things will explode quickly from there.
> >
> > At least SMAP helps here on non-FSGSBASE systems.  With FSGSBASE, I
>
> How does it help? It still crashes the kernel.
>
> > suppose we could harden this by adding a special check to int $0x80 to
> > validate GSBASE.
>
> > > One option here is to look at ISR and complain if it is found to be set.
> >
> > Barring some real hackery, we're toast long before we get far enough to
> > do that.
>
> No. We can map the APIC into the user space visible page tables for PTI
> without compromising the PTI isolation and it can be read very early on
> before SWAPGS. All you need is a register to clobber not more. It the ISR
> is set, then go into an error path, yell loudly, issue EOI and return.
> The only issue I can see is: It's slow :)
>
>

I think this will be really extremely slow.  If we can restrict this
to x2apic machines, then maybe it's not so awful.

FWIW, if we just patch up the GS thing, then we are still vulnerable:
the bad guy can arrange for a privileged process to have register
state corresponding to a dangerous syscall and then send an int $0x80
via the APIC.
