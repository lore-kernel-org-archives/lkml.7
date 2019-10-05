Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12EDC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB422477
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570293737;
	bh=0IjufT6jSKEMpep9FAXN5Dd37rK1JuJ8DqvWyKI29Bg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XxhazBOb64txzRl8y6MPGHvDnFmQGkO2lf3jaQhK0+LeqZvjETCst9ibl3/QklsPI
	 T9aq5/qP7mIC8oE6lrkwmiHBznrdnji39wBE8/h3nWsNk/yIfif3e4rh2FuiF6bkol
	 Rz8WRRgGt6XFgCK8ChDghQ7F0y74A6V8elzyT73U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfJEQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfJEQmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:42:16 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95ACD22475;
        Sat,  5 Oct 2019 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570293735;
        bh=0IjufT6jSKEMpep9FAXN5Dd37rK1JuJ8DqvWyKI29Bg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r1VIV/pSNbhV7SmQkcEOvBjs6+w/6WdcDyB38D3oR2YDgZcuCHgCryf9I0wK0AxJ+
         jjUXJwYQT09klEQr++n/vjR0tNTlWUwKJlfUGKH5UMUxKCYXVWP7pujU6nGY6PvgTh
         I3D6ZLlQ8aQYO9J1z0HgEVfY35wmM5q+E3nul53s=
Date:   Sat, 5 Oct 2019 09:42:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 03/12] rcu: Force on tick when invoking lots
 of callbacks
Message-ID: <20191005164214.GI2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-3-paulmck@kernel.org>
 <20191003140955.GA27003@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003140955.GA27003@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:10:52PM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 02, 2019 at 06:38:54PM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > 
> > Callback invocation can run for a significant time period, and within
> > CONFIG_NO_HZ_FULL=y kernels, this period will be devoid of scheduler-clock
> > interrupts.  In-kernel execution without such interrupts can cause all
> > manner of malfunction, with RCU CPU stall warnings being but one result.
> > 
> > This commit therefore forces scheduling-clock interrupts on whenever more
> > than a few RCU callbacks are invoked.  Because offloaded callback invocation
> > can be preempted, this forcing is withdrawn on each context switch.  This
> > in turn requires that the loop invoking RCU callbacks reiterate the forcing
> > periodically.
> > 
> > [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  kernel/rcu/tree.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8110514..db673ae 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2151,6 +2151,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	rcu_nocb_unlock_irqrestore(rdp, flags);
> >  
> >  	/* Invoke callbacks. */
> > +	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> 
> No need for the IS_ENABLED(), the API takes care of that.
> 
> > +		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> >  	rhp = rcu_cblist_dequeue(&rcl);
> >  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >  		debug_rcu_head_unqueue(rhp);
> > @@ -2217,6 +2219,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	/* Re-invoke RCU core processing if there are callbacks remaining. */
> >  	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
> >  		invoke_rcu_core();
> > +	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> 
> Same here.

Good catches!  Applied, thank you!

							Thanx, Paul

> Thanks.
> 
> > +		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
> >  }
> >  
> >  /*
> > -- 
> > 2.9.5
> > 
