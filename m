Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991B6206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KByUEDGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfG2NEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:04:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfG2NEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UNRNFNpyua4IZgEVGmrq1rayoxpXQ2fy0513IVPUaME=; b=KByUEDGrp2Ob/BvKrSyCMgpQA
        dyrT6D1UDYZ65rIA0ghkWHVWmMq8HP48S1xhKNVwAR/Qd1W6dYljRLHNpWdA/jcjPS4ia6vYQHBJi
        90pq3WV/HAIQuYsY7WwoWS5uMRY1nN9ObhXW3foEnE4rhwbfyT98ixEfvQcxFaI4BEcynD3BPV3f+
        yoh+8WgmjTD3qGj/ATfH+IgpOH760zi3Y64TaW13uP2NapDfawHop823aALkLIn6ngxDlGT8SgUcs
        GCkRC6Ri4uozsm3+oCWUjsfH9FqMS61u4DAFLjrpLkLgN7g4CwPbMTfuIiKOoZeDV/0TgL9HMCbVp
        5lRDogrtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs5KS-0000gk-6v; Mon, 29 Jul 2019 13:04:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20E8320AFFE9E; Mon, 29 Jul 2019 15:04:38 +0200 (CEST)
Date:   Mon, 29 Jul 2019 15:04:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729130438.GE31398@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
 <20190729092519.GR25636@localhost.localdomain>
 <20190729111510.GD31398@hirez.programming.kicks-ass.net>
 <20190729112702.GA8927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729112702.GA8927@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:27:02PM +0200, Juri Lelli wrote:
> On 29/07/19 13:15, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 11:25:19AM +0200, Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 26/07/19 16:54, Peter Zijlstra wrote:
> > > > Because pick_next_task() implies set_curr_task() and some of the
> > > > details haven't matter too much, some of what _should_ be in
> > > > set_curr_task() ended up in pick_next_task, correct this.
> > > > 
> > > > This prepares the way for a pick_next_task() variant that does not
> > > > affect the current state; allowing remote picking.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  kernel/sched/deadline.c |   23 ++++++++++++-----------
> > > >  kernel/sched/rt.c       |   27 ++++++++++++++-------------
> > > >  2 files changed, 26 insertions(+), 24 deletions(-)
> > > > 
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
> > > >  }
> > > >  #endif
> > > >  
> > > > -static inline void set_next_task(struct rq *rq, struct task_struct *p)
> > > > +static void set_next_task_dl(struct rq *rq, struct task_struct *p)
> > > >  {
> > > >  	p->se.exec_start = rq_clock_task(rq);
> > > >  
> > > >  	/* You can't push away the running task */
> > > >  	dequeue_pushable_dl_task(rq, p);
> > > > +
> > > > +	if (hrtick_enabled(rq))
> > > > +		start_hrtick_dl(rq, p);
> > > > +
> > > > +	if (rq->curr->sched_class != &dl_sched_class)
> > > > +		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> > > > +
> > > > +	if (rq->curr != p)
> > > > +		deadline_queue_push_tasks(rq);
> > > 
> > > It's a minor thing, but I was wondering why you added the check on curr.
> > > deadline_queue_push_tasks() already checks if are there pushable tasks,
> > > plus curr can still be of a different class at this point?
> > 
> > Hmm, so by moving that code into set_next_task() it is exposed to the:
> > 
> >   if (queued)
> >     deuque_task();
> >   if (running)
> >     put_prev_task();
> > 
> >   /* do stuff */
> > 
> >   if (queued)
> >     enqueue_task();
> >   if (running)
> >     set_next_task();
> > 
> > patter from core.c; and in that case nothing changes. That said; I
> > might've gotten it wrong.
> 
> Right. But, I was wondering about the __schedule()->pick_next_task()
> case, where, say, prev (rq->curr) is RT/CFS and next (p) is DEADLINE.

So we do pick_next_task() first and then set rq->curr (obviously). So
the first set_next_task() will see rq->curr != p and we'll do the push
balance stuff.

Then the above pattern will always see rq->curr == p and we'll not
trigger push balancing.

Now, looking at it, this also doesn't do push balancing when we
re-select the same task, even though we really should be doing it. So I
suppose not adding the condition, and always doing the push balance,
while wasteful, is not wrong.

Hmm?
