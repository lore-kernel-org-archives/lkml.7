Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C6C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ECA21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571103654;
	bh=R1ax1zsWYAvkPrP01kPj8dcw5zoIPP9CQn6nTx74Phw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BG0zwg0Fy09dzeKZ1rYNmn6qfHtF3Xo3WbeuR0M/RuLIR7+oxT62nBCr/DeZ3w8LD
	 HKii2p5aHHr5fHQbgeaORO7DoV6XRQHE2885IPx8CsnTJJCL0vxBlFXerbhF1NdZkp
	 CPTg53H+Twg+vkRKYReD2Js/xRZIkdzZ4hwNBS5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfJOBkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfJOBkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:40:52 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AAA2089C;
        Tue, 15 Oct 2019 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571103651;
        bh=R1ax1zsWYAvkPrP01kPj8dcw5zoIPP9CQn6nTx74Phw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=198G0W5IzKDD7NrNwQwlatA/Y0vFEsu7U4S5V8ldd5M6HCXrHZ0jG9UVfm1tN6Nsx
         oFl/PLipMRNnQFdJAtHuNhaqeCzk2IujaCOP6EZkdfpeB8t6VZ/NP+/6onV4KNjkAo
         QaeyT+6mHKZwgtFR0E7SO10A89iO55bfSSUqkndY=
Date:   Mon, 14 Oct 2019 18:40:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix data-race due to atomic_t copy-by-value
Message-ID: <20191015014048.GJ2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <5da2509f.1c69fb81.bb59c.b8e2SMTPIN_ADDED_BROKEN@mx.google.com>
 <20191014180039.GA89937@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014180039.GA89937@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 02:00:39PM -0400, Joel Fernandes wrote:
> On Wed, Oct 09, 2019 at 05:57:43PM +0200, Marco Elver wrote:
> > This fixes a data-race where `atomic_t dynticks` is copied by value. The
> > copy is performed non-atomically, resulting in a data-race if `dynticks`
> > is updated concurrently.
> > 
> > This data-race was found with KCSAN:
> > ==================================================================
> > BUG: KCSAN: data-race in dyntick_save_progress_counter / rcu_irq_enter
> > 
> > write to 0xffff989dbdbe98e0 of 4 bytes by task 10 on cpu 3:
> >  atomic_add_return include/asm-generic/atomic-instrumented.h:78 [inline]
> >  rcu_dynticks_snap kernel/rcu/tree.c:310 [inline]
> >  dyntick_save_progress_counter+0x43/0x1b0 kernel/rcu/tree.c:984
> >  force_qs_rnp+0x183/0x200 kernel/rcu/tree.c:2286
> >  rcu_gp_fqs kernel/rcu/tree.c:1601 [inline]
> >  rcu_gp_fqs_loop+0x71/0x880 kernel/rcu/tree.c:1653
> >  rcu_gp_kthread+0x22c/0x3b0 kernel/rcu/tree.c:1799
> >  kthread+0x1b5/0x200 kernel/kthread.c:255
> >  <snip>
> > 
> > read to 0xffff989dbdbe98e0 of 4 bytes by task 154 on cpu 7:
> >  rcu_nmi_enter_common kernel/rcu/tree.c:828 [inline]
> >  rcu_irq_enter+0xda/0x240 kernel/rcu/tree.c:870
> >  irq_enter+0x5/0x50 kernel/softirq.c:347
> >  <snip>
> > 
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 7 PID: 154 Comm: kworker/7:1H Not tainted 5.3.0+ #5
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > Workqueue: kblockd blk_mq_run_work_fn
> > ==================================================================
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> I believe Paul has already queued this, but anyway I have reviewed it as well
> and it LGTM.

It is still in the development portion, so it is still mutable.  ;-)

> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you both!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  include/trace/events/rcu.h |  4 ++--
> >  kernel/rcu/tree.c          | 11 ++++++-----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 694bd040cf51..fdd31c5fd126 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -442,7 +442,7 @@ TRACE_EVENT_RCU(rcu_fqs,
> >   */
> >  TRACE_EVENT_RCU(rcu_dyntick,
> >  
> > -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> > +	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
> >  
> >  	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> >  
> > @@ -457,7 +457,7 @@ TRACE_EVENT_RCU(rcu_dyntick,
> >  		__entry->polarity = polarity;
> >  		__entry->oldnesting = oldnesting;
> >  		__entry->newnesting = newnesting;
> > -		__entry->dynticks = atomic_read(&dynticks);
> > +		__entry->dynticks = dynticks;
> >  	),
> >  
> >  	TP_printk("%s %lx %lx %#3x", __entry->polarity,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 81105141b6a8..62e59596a30a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -576,7 +576,7 @@ static void rcu_eqs_enter(bool user)
> >  	}
> >  
> >  	lockdep_assert_irqs_disabled();
> > -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	rdp = this_cpu_ptr(&rcu_data);
> >  	do_nocb_deferred_wakeup(rdp);
> > @@ -649,14 +649,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 * leave it in non-RCU-idle state.
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> > -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> > +				  atomic_read(&rdp->dynticks));
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> >  			   rdp->dynticks_nmi_nesting - 2);
> >  		return;
> >  	}
> >  
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> > -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >  
> >  	if (irq)
> > @@ -743,7 +744,7 @@ static void rcu_eqs_exit(bool user)
> >  	rcu_dynticks_task_exit();
> >  	rcu_dynticks_eqs_exit();
> >  	rcu_cleanup_after_idle();
> > -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	WRITE_ONCE(rdp->dynticks_nesting, 1);
> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > @@ -827,7 +828,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  	}
> >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> >  			  rdp->dynticks_nmi_nesting,
> > -			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> > +			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> >  		   rdp->dynticks_nmi_nesting + incby);
> >  	barrier();
> > -- 
> > 2.23.0.581.g78d2f28ef7-goog
> > 
> > 
