Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E7C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F552173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbfGRJUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:20:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfGRJUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:20:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5C128;
        Thu, 18 Jul 2019 02:20:32 -0700 (PDT)
Received: from blommer (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 478A33F71A;
        Thu, 18 Jul 2019 02:20:30 -0700 (PDT)
Date:   Thu, 18 Jul 2019 10:20:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
Message-ID: <20190718092022.GA3625@blommer>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
 <156342863822.8565.7624877983728871995.stgit@devnote2>
 <20190718062215.GG14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718062215.GG14271@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> > Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> > handlers since the software breakpoint can be hit on idle task.

Why precisely do we need to elide these? Are we seeing warnings today?

> The exception entry and exit use irq_enter() and irq_exit(), in this
> case, correct?  Otherwise RCU will be ignoring this CPU.

This is missing today, which sounds like the underlying bug.

Thanks,
Mark.

> 
> 							Thanx, Paul
> 
> > Actually, we don't need it because those handlers run in exception
> > context where the interrupts are disabled. This means those are never
> > preempted.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm64/kernel/debug-monitors.c |   14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > index f8719bd30850..48222a4760c2 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -207,16 +207,16 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
> >  
> >  	list = user_mode(regs) ? &user_step_hook : &kernel_step_hook;
> >  
> > -	rcu_read_lock();
> > -
> > +	/*
> > +	 * Since single-step exception disables interrupt, this function is
> > +	 * entirely not preemptible, and we can use rcu list safely here.
> > +	 */
> >  	list_for_each_entry_rcu(hook, list, node)	{
> >  		retval = hook->fn(regs, esr);
> >  		if (retval == DBG_HOOK_HANDLED)
> >  			break;
> >  	}
> >  
> > -	rcu_read_unlock();
> > -
> >  	return retval;
> >  }
> >  NOKPROBE_SYMBOL(call_step_hook);
> > @@ -305,14 +305,16 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> >  
> >  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
> >  
> > -	rcu_read_lock();
> > +	/*
> > +	 * Since brk exception disables interrupt, this function is
> > +	 * entirely not preemptible, and we can use rcu list safely here.
> > +	 */
> >  	list_for_each_entry_rcu(hook, list, node) {
> >  		unsigned int comment = esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
> >  
> >  		if ((comment & ~hook->mask) == hook->imm)
> >  			fn = hook->fn;
> >  	}
> > -	rcu_read_unlock();
> >  
> >  	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
> >  }
> > 
