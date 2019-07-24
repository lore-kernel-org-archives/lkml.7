Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80429C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD9229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563968876;
	bh=mBlNAmlgpbL8sIsWIS0MT/Km8ZKqFPisBuV/zTsyUU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CMPWjJ12uH3V3nIMPD/2aCRvCXIBTYW7RuD3VbhWlWTRaXqp+Ga2J+npB+nGG2aCr
	 tktiAnzKZ6G3Yv96gKOxyKnmPJ1Mvq8D6c92/pIFNptLtj/dNL5HoOwcCLjs7oX2W8
	 dWSSW23yscv56kMupjbbzNvGQ6v3ieiELn7XWni0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGXLry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfGXLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:47:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C506122387;
        Wed, 24 Jul 2019 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563968873;
        bh=mBlNAmlgpbL8sIsWIS0MT/Km8ZKqFPisBuV/zTsyUU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fW20VpN2srzvHeaON2aO9PX860hcw585Lgh8gjeSOCIXozBFl1aXstLO3FISoddd2
         mCm+LcnzB1FUNo1wCMfGn3zsJWmTU/ozny13dklCz3DHrxCfJ0X7lJM8EndoFPBA7d
         l8KF7HLC8T2tQa5sTG83bBoq/dkligeH2bI43MP8=
Date:   Wed, 24 Jul 2019 20:47:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] arm64: Make debug exception handlers visible
 from RCU
Message-Id: <20190724204748.94abebef1f184032d2e77f73@kernel.org>
In-Reply-To: <0290c71b-6ed3-c455-eb4a-3f6a670f5e37@arm.com>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
        <156378173770.12011.3832608237079432765.stgit@devnote2>
        <0290c71b-6ed3-c455-eb4a-3f6a670f5e37@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 18:07:56 +0100
James Morse <james.morse@arm.com> wrote:

> Hi,
> 
> On 22/07/2019 08:48, Masami Hiramatsu wrote:
> > Make debug exceptions visible from RCU so that synchronize_rcu()
> > correctly track the debug exception handler.
> > 
> > This also introduces sanity checks for user-mode exceptions as same
> > as x86's ist_enter()/ist_exit().
> > 
> > The debug exception can interrupt in idle task. For example, it warns
> > if we put a kprobe on a function called from idle task as below.
> > The warning message showed that the rcu_read_lock() caused this
> > problem. But actually, this means the RCU is lost the context which
> > is already in NMI/IRQ.
> 
> > So make debug exception visible to RCU can fix this warning.
> 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 9568c116ac7f..a6b244240db6 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -777,6 +777,42 @@ void __init hook_debug_fault_code(int nr,
> >  	debug_fault_info[nr].name	= name;
> >  }
> >  
> > +/*
> > + * In debug exception context, we explicitly disable preemption.
> > + * This serves two purposes: it makes it much less likely that we would
> > + * accidentally schedule in exception context and it will force a warning
> > + * if we somehow manage to schedule by accident.
> > + */
> > +static void debug_exception_enter(struct pt_regs *regs)
> > +{
> > +	if (user_mode(regs)) {
> > +		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> 
> Would moving entry.S's context_tracking_user_exit() call to be before do_debug_exception()
> also fix this?

It sounds like treating only user context, correct?
This part is just adding assertion, not fixing the problem which Naresh reported.

> 
> I don't know the reason its done 'after' debug exception handling. Its always been like
> this: commit 6c81fe7925cc4c42 ("arm64: enable context tracking").
> 
> 
> > +	} else {
> > +		/*
> > +		 * We might have interrupted pretty much anything.  In
> > +		 * fact, if we're a debug exception, we can even interrupt
> > +		 * NMI processing.
> 
> > +		 * We don't want in_nmi() to return true,
> > +		 * but we need to notify RCU.
> 
> How come? If you interrupted an SError or pseudo-nmi, it already is. Those paths should
> all be painted no-kprobe, but I'm sure there are gaps. The hw-breakpoints can almost
> certainly hook them.

I think that sentense means "we don't want that this code makes in_nmi() to return true"
So, if the breakpoint interrupts pNMI/SError context, it is OK that in_nmi() returns true.

> 
> 
> > +		 */
> > +		rcu_nmi_enter();
> 
> Can we interrupt printk()? Do we need printk_nmi_enter()? ... What about ftrace?

Good point! As far as I know, we don't use it because ftrace doesn't use printk.
But indeed, kprobes user can use printk and they have to call printk_nmi_enter()/exit(),
that must be commented in the documentation. Anyway, basically it is user's choice.

> 
> Because SError and pseudo-nmi can interrupt interrupt-masked code, we describe them as
> NMI. The only difference here is these exceptions are synchronous.
> 
> 
> I suspect we should make these debug exceptions nmi for EL1. We can then use this for the
> kprobe-re-entrance stuff so the pre/post hooks don't get run if they interrupted something
> also described as NMI.

I'm not sure how it can prevent... anyway because we have to run a single-stepping for
recovery, and kprobe already check the reentered kprobes and skip user-handlers in
such case.

Thank you,

> 
> 
> > +	}
> > +
> > +	preempt_disable();
> > +
> > +	/* This code is a bit fragile.  Test it. */
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
> > +}
> > +NOKPROBE_SYMBOL(debug_exception_enter);
> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>
