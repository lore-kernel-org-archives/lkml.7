Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E47C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F852084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfKYO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:26:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:57482 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbfKYO00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:26:26 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xAPEPvGa014695;
        Mon, 25 Nov 2019 08:25:57 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xAPEPuZS014692;
        Mon, 25 Nov 2019 08:25:56 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 25 Nov 2019 08:25:56 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20191125142556.GU9491@gate.crashing.org>
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr> <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr> <877e3tbvsa.fsf@mpe.ellerman.id.au> <20191121101552.GR16031@gate.crashing.org> <87y2w49rgo.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2w49rgo.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 09:32:23PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> >> > +static inline void call_do_irq(struct pt_regs *regs, void *sp)
> >> > +{
> >> > +	register unsigned long r3 asm("r3") = (unsigned long)regs;
> >> > +
> >> > +	/* Temporarily switch r1 to sp, call __do_irq() then restore r1 */
> >> > +	asm volatile(
> >> > +		"	"PPC_STLU"	1, %2(%1);\n"
> >> > +		"	mr		1, %1;\n"
> >> > +		"	bl		%3;\n"
> >> > +		"	"PPC_LL"	1, 0(1);\n" :
> >> > +		"+r"(r3) :
> >> > +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
> >> > +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
> >> > +		"r0", "r2", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
> >> > +}
> >> 
> >> If we add a nop after the bl, so the linker could insert a TOC restore,
> >> then I don't think there's any circumstance under which we expect this
> >> to actually clobber r2, is there?
> >
> > That is mostly correct.
> 
> That's the standard I aspire to :P
> 
> > If call_do_irq was a no-inline function, there would not be problems.
> >
> > What TOC does __do_irq require in r2 on entry, and what will be there
> > when it returns?
> 
> The kernel TOC, and also the kernel TOC, unless something's gone wrong
> or I'm missing something.

If that is the case, we can just do the bl, no nop at all?  And that works
for all of our ABIs.

If we can be certain that we have the kernel TOC in r2 on entry to
call_do_irq, that is!  (Or it establishes it itself).


Segher
