Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669121872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573511911;
	bh=MTnAZHsrbhZ3P2DpDk2IhyzQezhY/28XsVTmndfHSJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ykdW8VgZieTRyCdYAnylJvA3NTHIv24cGZf/CreB5n0o+XrS3UQkHT3JVFgv9b2ut
	 BkzMg9yqQwRjCcyiJ5Fkqch/Y/0yG66hfIzlUN1s08kb1m2jTW9YFnsjeLxGxxeyby
	 sf9XYCh6MXzbZ3AebQuM1KLeU1rUl13WDSRqxw+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKKWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKKWi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:38:29 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00E8206A3;
        Mon, 11 Nov 2019 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573511909;
        bh=MTnAZHsrbhZ3P2DpDk2IhyzQezhY/28XsVTmndfHSJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMct2kYf+NtU1SSeKGfu7vJH+lus4FP6GOyRkboWV2X3sC6a6hYEvnBaDzjUm/cFG
         O8wPTx72oFD+CoDcM+Bn8RH1J0ao4dObawW4zfgl6LVYl/AZuIHtfkP86umsfTXR1R
         bv1eSQGZO9nNCe8iPPmE+Upkh4kyU4/dp8DzS0e0=
Date:   Mon, 11 Nov 2019 23:38:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/4] irq_work: Weaken ordering in irq_work_run_list()
Message-ID: <20191111223825.GA27917@lenoir>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-5-frederic@kernel.org>
 <20191111084313.GN4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111084313.GN4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:43:13AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 08, 2019 at 05:08:58PM +0100, Frederic Weisbecker wrote:
> 
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 49c53f80a13a..b709ab05cbfd 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > @@ -34,8 +34,8 @@ static bool irq_work_claim(struct irq_work *work)
> >  	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
> >  	/*
> >  	 * If the work is already pending, no need to raise the IPI.
> > +	 * The pairing atomic_andnot() followed by a barrier in irq_work_run()
> > +	 * makes sure everything we did before is visible.
> >  	 */
> >  	if (oflags & IRQ_WORK_PENDING)
> >  		return false;
> 
> > @@ -151,14 +151,16 @@ static void irq_work_run_list(struct llist_head *list)
> >  		 * to claim that work don't rely on us to handle their data
> >  		 * while we are in the middle of the func.
> >  		 */
> > -		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
> > +		atomic_andnot(IRQ_WORK_PENDING, &work->flags);
> > +		smp_mb__after_atomic();
> 
> I think I'm prefering you use:
> 
> 		flags = atomic_fetch_andnot_acquire(IRQ_WORK_PENDING, &work->flags);

Ah good point. Preparing that.

> 
> Also, I'm cursing at myself for the horrible comments here.

Hmm, I wrote many of those, which one? :o)

Thanks.

> 
> >  		work->func(work);
> >  		/*
> >  		 * Clear the BUSY bit and return to the free state if
> >  		 * no-one else claimed it meanwhile.
> >  		 */
> > -		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
> > +		(void)atomic_cmpxchg(&work->flags, flags & ~IRQ_WORK_PENDING,
> > +				     flags & ~IRQ_WORK_CLAIMED);
> >  	}
> >  }
> >  
> > -- 
> > 2.23.0
> > 
