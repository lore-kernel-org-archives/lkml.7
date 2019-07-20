Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F7C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3A21873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563603764;
	bh=b3cKzrZLR6K6aoHcqxAfp/ErNMJGou6k3PvgWjOJwtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JSdKSFWuI8PnlUVvDzKDm6ULA7nKIrs5nHLqLj6ZRLldHPNG4rn92k8B4GbH9KZeh
	 KzhCP3oGv4KCIrIVgIAksNGGvnVPnURWcC7lTRAhFECTjIjciIh9fzCQiI8N5fTRd4
	 /60kGyUvY0rfKhAHT86gTQl7Usv7uWHjlo3qV/vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfGTGWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfGTGWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:22:42 -0400
Received: from devnote2 (72.65.214.202.bf.2iij.net [202.214.65.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23292184E;
        Sat, 20 Jul 2019 06:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563603761;
        bh=b3cKzrZLR6K6aoHcqxAfp/ErNMJGou6k3PvgWjOJwtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y+Po5yv00sQT614D6utHJsXmh0hTqAIXg6TtC1Dz4jbVIEBx+xLGZsDe4c3kfYYZ8
         9ORq164MIeUlDEdwiHhwjZthUkrqwcqHOJi59iDoNcdrvH6TkI5ylpV+9sORDE/UxS
         IaB3fOi26dkcdHxrOGUvqL945JTTbzQEsJttPC0A=
Date:   Sat, 20 Jul 2019 15:22:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH 1/3] arm64: kprobes: Recover pstate.D in single-step
 exception handler
Message-Id: <20190720152236.0ab1ade88176ba7c27306743@kernel.org>
In-Reply-To: <3a198660-35cc-0c65-6a6d-e30d2494ff21@arm.com>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
        <156342861775.8565.9122725195458920037.stgit@devnote2>
        <3a198660-35cc-0c65-6a6d-e30d2494ff21@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 11:07:33 +0100
James Morse <james.morse@arm.com> wrote:

> Hi!
> 
> On 18/07/2019 06:43, Masami Hiramatsu wrote:
> > On arm64, if a nested kprobes hit, it can crash the kernel with below
> > error message.
> > 
> > [  152.118921] Unexpected kernel single-step exception at EL1
> > 
> > This is because commit 7419333fa15e ("arm64: kprobe: Always clear
> > pstate.D in breakpoint exception handler") clears pstate.D always in
> > the nested kprobes. That is correct *unless* any nested kprobes
> > (single-stepping) runs inside other kprobes (including kprobes in
> >  user handler).
> 
> kprobes probing kprobes!? ... why do we support this?

That is NOT "supported", this is just for avoiding kernel crash as much
as possible.

The nested kprobe can unexpectedly happen, usually in kprobe user handlers.
Also, the critical functions outside of kprobe user handler, are blacklisted
(e.g. [PATCH 2/3]).

> We treat 'debug' as our highest exception level, it can interrupt pNMI and RAS-errors.
> Letting it loop doesn't sound like a good idea.

Agreed. that must be avoided.

> > When the 1st kprobe hits, do_debug_exception() will be called. At this
> > point, debug exception (= pstate.D) must be masked (=1).
> 
> > When the 2nd (nested) kprobe is hit before single-step of the first kprobe,
> 
> How does this happen?

As you may know, kprobes provides a handler interface to user. User must
carefully program the handler which doesn't cause this recursion, but
if he failed, he can put another probe on the function which is called
(indirectly) from the user handler.

> I guess the kprobe-helper-function gets called in debug context, but surely you can't
> kprobe a kprobe-helper-function? What stops this going in a loop?

The kprobe blacklist. __kprobes and NOKPROBE_SYMBOL() will blacklist it.

> > it modifies debug exception clear (pstate.D = 0).
> 
> After taking the first BRK, DAIF=0xf, everything is masked. When you take the second BRK
> this shouldn't change.

Yes, at the beginning of the 2nd BRK hit.
However in the 2nd BRK, it clears the D flag for single-step, and never recover it.

> 
> Those spsr_set_debug_flag() calls are modifying the spsr in the regs structure, they only
> become PSTATE when we eret for single-step.
> 
> 
> > Then, when the 1st kprobe setting up single-step, it saves current
> > DAIF, mask DAIF, enable single-step, and restore DAIF.
> 
> > However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
> > single-step exception happens soon after restoring DAIF.
> 
> PSTATE.D bit clearing should only be effective for the duration of the single-step.
> 
> 
> > To solve this issue, this refers saved pstate register to check the
> > previous pstate.D and recover it if needed.
> 
> (This sounds like undoing something that shouldn't have happened in the first place)
> 
> 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index bd5dfffca272..6e1dc0bb4c82 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -201,12 +201,14 @@ spsr_set_debug_flag(struct pt_regs *regs, int mask)
> >   * interrupt occurrence in the period of exception return and  start of
> >   * out-of-line single-step, that result in wrongly single stepping
> >   * into the interrupt handler.
> > + * This also controls debug flag, so that we can refer the saved pstate.
> >   */
> >  static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
> >  						struct pt_regs *regs)
> >  {
> >  	kcb->saved_irqflag = regs->pstate;
> >  	regs->pstate |= PSR_I_BIT;
> > +	spsr_set_debug_flag(regs, 0);
> 
> (Nit: this is the only caller of spsr_set_debug_flag(), as we're modifing regs->pstate
> directly here, can we lose the helper and just manipulate regs->pstate? )
> 
> >  }
> >  
> >  static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> > @@ -245,15 +251,12 @@ static void __kprobes setup_singlestep(struct kprobe *p,
> >  		kcb->kprobe_status = KPROBE_HIT_SS;
> >  	}
> >
> > -
> >  	if (p->ainsn.api.insn) {
> >  		/* prepare for single stepping */
> >  		slot = (unsigned long)p->ainsn.api.insn;
> >
> >  		set_ss_context(kcb, slot);	/* mark pending ss */
> >
> > -		spsr_set_debug_flag(regs, 0);
> > -
> >  		/* IRQs and single stepping do not mix well. */
> >  		kprobes_save_local_irqflag(kcb, regs);
> >  		kernel_enable_single_step(regs);
> 
> These two hunks look like cleanup, could we do this separately from a fix for stable?
> 
> 
> 
> > @@ -216,6 +218,10 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> >  		regs->pstate |= PSR_I_BIT;
> >  	else
> >  		regs->pstate &= ~PSR_I_BIT;
> > +
> > +	/* Recover pstate.D mask if needed */
> > +	if (kcb->saved_irqflag & PSR_D_BIT)
> > +		spsr_set_debug_flag(regs, 1);
> >  }
> 
> Ugh. .. I get it ..
> 
> I think the simplest summary of the problem is:
> Kprobes unmasks debug exceptions for single-step, then leaves them unmasked when the
> probed function is restarted.
> 
> I'd like to know more about this nested case, but I don't think its the simplest example
> of this problem.
> The commit message is describing both the interrupted and running PSTATE as PSTATE. I
> think it would be clearer if you called the interrupted one SPSR (saved pstate register).
> That's the value in the regs structure.

OK. I'm not sure why the original code decided only recovers irq flag.

> 
> Please don't re-manipulate the flags, its overly verbose and we've already got this wrong
> once! We should just blindly restore the DAIF setting we had before as its simpler.
> 
> Could we change kprobes_save_local_irqflag() to save the DAIF bits of pstate:
> | kcb->saved_irqflag = regs->pstate & DAIF_MASK;
> (DAIF_MASK is all four PSR bits)
> 
> So that we can then fix this in kprobes_restore_local_irqflag() with:
> | regs->pstate &= ~DAIF_MASK;
> | regs->pstate |= kcb->saved_irqflag

OK, that is much simpler and easy to understand.

> 
> (the value splicing is needed because regs->pstate also holds the 'condition code' flags,
> which could be modified by the single-step instruction, then depended on afterwards.)

Yes, that must be hold.

Thank you,

> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>
