Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E96CC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFF021670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGEUgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:36:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36072 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:36:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjUwb-0007Ma-LP; Fri, 05 Jul 2019 22:36:33 +0200
Date:   Fri, 5 Jul 2019 22:36:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
In-Reply-To: <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907052227140.3648@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de> <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019, Andy Lutomirski wrote:
> On Fri, Jul 5, 2019 at 8:47 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > Because TPR is 0, an incoming IPI can trigger #AC, #CP, #VC or #SX
> > without an error code on the stack, which results in a corrupt pt_regs
> > in the exception handler, and a stack underflow on the way back out,
> > most likely with a fault on IRET.
> >
> > These can be addressed by setting TPR to 0x10, which will inhibit
> > delivery of any errant IPIs in this range, but some extra sanity logic
> > may not go amiss.  An error code on a 64bit stack can be spotted with
> > `testb $8, %spl` due to %rsp being aligned before pushing the exception
> > frame.
> 
> Several years ago, I remember having a discussion with someone (Jan
> Beulich, maybe?) about how to efficiently make the entry code figure
> out the error code situation automatically.  I suspect it was on IRC
> and I can't find the logs.  I'm thinking that maybe we should just
> make Linux's idtentry code do something like this.
> 
> If nothing else, we could make idtentry do:
> 
> testl $8, %esp   /* shorter than testb IIRC */
> jz 1f  /* or jnz -- too lazy to figure it out */
> pushq $-1
> 1:

Errm, no. We should not silently paper over it. If we detect that this came
in with a wrong stack frame, i.e. not from a CPU originated exception, then
we truly should yell loud. Also in that case you want to check the APIC:ISR
and issue an EOI to clear it.

> > Another interesting problem is an IPI which its vector 0x80.  A cunning
> > attacker can use this to simulate system calls from unsuspecting
> > positions in userspace, or for interrupting kernel context.  At the very
> > least the int0x80 path does an unconditional swapgs, so will try to run
> > with the user gs, and I expect things will explode quickly from there.
> 
> At least SMAP helps here on non-FSGSBASE systems.  With FSGSBASE, I

How does it help? It still crashes the kernel.

> suppose we could harden this by adding a special check to int $0x80 to
> validate GSBASE.

> > One option here is to look at ISR and complain if it is found to be set.
> 
> Barring some real hackery, we're toast long before we get far enough to
> do that.

No. We can map the APIC into the user space visible page tables for PTI
without compromising the PTI isolation and it can be read very early on
before SWAPGS. All you need is a register to clobber not more. It the ISR
is set, then go into an error path, yell loudly, issue EOI and return.
The only issue I can see is: It's slow :)

Thanks,

	tglx


