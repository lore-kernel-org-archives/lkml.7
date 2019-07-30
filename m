Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185082087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQ2b9gY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfG3IVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:21:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfG3IVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3dKEy5ji6QEBPMbimMeBP1tKJGWt+kqGCyCU/WHvBl0=; b=nQ2b9gY6IpQ2byORo3iheCPy2
        kvM9V3ulVXdGINzUTDfcuixAldcGMttRrBFAJGx58uYEd3ezB2/H4KoVuACrVuevfJYysLwMNFjYM
        qcQCZKmPX4lATx1ReTq72h7QIHOtF3g9kicbHHkOkpIreriLrIESMc4BKipUNt4Pcz9mQ2Y3Cw2yw
        npA9f2wz7iPPMLyyCGQ1N7XlBzdDNjGOECFilI+WzRa+T1m65biW34xTwGoHj92kQ88OEiuxHCNOL
        eUlws5hB4yJHfDhlBtHM8rU8om/kT9SD4IAQDgipBxw3nTAjU//gwqVg0erjQubNOu//wCP8qleqJ
        3C6+Pfvbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNNd-0005P9-JV; Tue, 30 Jul 2019 08:21:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 598A620D27EAB; Tue, 30 Jul 2019 10:21:08 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:21:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190730082108.GJ31381@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <20190729164932.GN31398@hirez.programming.kicks-ass.net>
 <20190730064115.GC8927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730064115.GC8927@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:41:15AM +0200, Juri Lelli wrote:
> On 29/07/19 18:49, Peter Zijlstra wrote:
> > On Fri, Jul 26, 2019 at 09:27:55AM +0100, Dietmar Eggemann wrote:
> > > Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
> > > enqueue_dl_entity().
> > > 
> > > Move the check that the dl_se is not on the dl_rq from
> > > __dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
> > > side and use the on_dl_rq() helper function.
> > > 
> > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > ---
> > >  kernel/sched/deadline.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 1fa005f79307..a9cb52ceb761 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> > >  	struct sched_dl_entity *entry;
> > >  	int leftmost = 1;
> > >  
> > > -	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
> > > -
> > >  	while (*link) {
> > >  		parent = *link;
> > >  		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
> > > @@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
> > >  {
> > >  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> > >  
> > > -	if (RB_EMPTY_NODE(&dl_se->rb_node))
> > > -		return;
> > > -
> > >  	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
> > >  	RB_CLEAR_NODE(&dl_se->rb_node);
> > >  
> > > @@ -1466,6 +1461,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
> > >  
> > >  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
> > >  {
> > > +	if (!on_dl_rq(dl_se))
> > > +		return;
> > 
> > Why allow double dequeue instead of WARN?
> 
> As I was saying to Valentin, it can currently happen that a task could
> have already been dequeued by update_curr_dl()->throttle called by
> dequeue_task_dl() before calling __dequeue_task_dl(). Do you think we
> should check for this condition before calling into dequeue_dl_entity()?

Yes, that's what ->dl_throttled is for, right? And !->dl_throttled &&
!on_dl_rq() is a BUG.
