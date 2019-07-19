Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C317C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfGSKHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:07:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSKHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:07:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C0D337;
        Fri, 19 Jul 2019 03:07:39 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625283F59C;
        Fri, 19 Jul 2019 03:07:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: kprobes: Recover pstate.D in single-step
 exception handler
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
 <156342861775.8565.9122725195458920037.stgit@devnote2>
From:   James Morse <james.morse@arm.com>
Message-ID: <3a198660-35cc-0c65-6a6d-e30d2494ff21@arm.com>
Date:   Fri, 19 Jul 2019 11:07:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156342861775.8565.9122725195458920037.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 18/07/2019 06:43, Masami Hiramatsu wrote:
> On arm64, if a nested kprobes hit, it can crash the kernel with below
> error message.
> 
> [  152.118921] Unexpected kernel single-step exception at EL1
> 
> This is because commit 7419333fa15e ("arm64: kprobe: Always clear
> pstate.D in breakpoint exception handler") clears pstate.D always in
> the nested kprobes. That is correct *unless* any nested kprobes
> (single-stepping) runs inside other kprobes (including kprobes in
>  user handler).

kprobes probing kprobes!? ... why do we support this?

We treat 'debug' as our highest exception level, it can interrupt pNMI and RAS-errors.
Letting it loop doesn't sound like a good idea.


> When the 1st kprobe hits, do_debug_exception() will be called. At this
> point, debug exception (= pstate.D) must be masked (=1).

> When the 2nd (nested) kprobe is hit before single-step of the first kprobe,

How does this happen?
I guess the kprobe-helper-function gets called in debug context, but surely you can't
kprobe a kprobe-helper-function? What stops this going in a loop?


> it modifies debug exception clear (pstate.D = 0).

After taking the first BRK, DAIF=0xf, everything is masked. When you take the second BRK
this shouldn't change.

Those spsr_set_debug_flag() calls are modifying the spsr in the regs structure, they only
become PSTATE when we eret for single-step.


> Then, when the 1st kprobe setting up single-step, it saves current
> DAIF, mask DAIF, enable single-step, and restore DAIF.

> However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
> single-step exception happens soon after restoring DAIF.

PSTATE.D bit clearing should only be effective for the duration of the single-step.


> To solve this issue, this refers saved pstate register to check the
> previous pstate.D and recover it if needed.

(This sounds like undoing something that shouldn't have happened in the first place)


> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index bd5dfffca272..6e1dc0bb4c82 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -201,12 +201,14 @@ spsr_set_debug_flag(struct pt_regs *regs, int mask)
>   * interrupt occurrence in the period of exception return and  start of
>   * out-of-line single-step, that result in wrongly single stepping
>   * into the interrupt handler.
> + * This also controls debug flag, so that we can refer the saved pstate.
>   */
>  static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
>  						struct pt_regs *regs)
>  {
>  	kcb->saved_irqflag = regs->pstate;
>  	regs->pstate |= PSR_I_BIT;
> +	spsr_set_debug_flag(regs, 0);

(Nit: this is the only caller of spsr_set_debug_flag(), as we're modifing regs->pstate
directly here, can we lose the helper and just manipulate regs->pstate? )

>  }
>  
>  static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> @@ -245,15 +251,12 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>  		kcb->kprobe_status = KPROBE_HIT_SS;
>  	}
>
> -
>  	if (p->ainsn.api.insn) {
>  		/* prepare for single stepping */
>  		slot = (unsigned long)p->ainsn.api.insn;
>
>  		set_ss_context(kcb, slot);	/* mark pending ss */
>
> -		spsr_set_debug_flag(regs, 0);
> -
>  		/* IRQs and single stepping do not mix well. */
>  		kprobes_save_local_irqflag(kcb, regs);
>  		kernel_enable_single_step(regs);

These two hunks look like cleanup, could we do this separately from a fix for stable?



> @@ -216,6 +218,10 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
>  		regs->pstate |= PSR_I_BIT;
>  	else
>  		regs->pstate &= ~PSR_I_BIT;
> +
> +	/* Recover pstate.D mask if needed */
> +	if (kcb->saved_irqflag & PSR_D_BIT)
> +		spsr_set_debug_flag(regs, 1);
>  }

Ugh. .. I get it ..

I think the simplest summary of the problem is:
Kprobes unmasks debug exceptions for single-step, then leaves them unmasked when the
probed function is restarted.

I'd like to know more about this nested case, but I don't think its the simplest example
of this problem.
The commit message is describing both the interrupted and running PSTATE as PSTATE. I
think it would be clearer if you called the interrupted one SPSR (saved pstate register).
That's the value in the regs structure.


Please don't re-manipulate the flags, its overly verbose and we've already got this wrong
once! We should just blindly restore the DAIF setting we had before as its simpler.

Could we change kprobes_save_local_irqflag() to save the DAIF bits of pstate:
| kcb->saved_irqflag = regs->pstate & DAIF_MASK;
(DAIF_MASK is all four PSR bits)

So that we can then fix this in kprobes_restore_local_irqflag() with:
| regs->pstate &= ~DAIF_MASK;
| regs->pstate |= kcb->saved_irqflag

(the value splicing is needed because regs->pstate also holds the 'condition code' flags,
which could be modified by the single-step instruction, then depended on afterwards.)


Thanks,

James
