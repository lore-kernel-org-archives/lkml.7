Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7F721871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kxPv+dna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfCOP7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:59:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfCOP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hjk1n1wEPFZC1bHFPZ6efXQGt8+eSh7bBVOvOmDFVik=; b=kxPv+dnarlN68LM+aa30BcVuQ
        8j3zKl0JkdQP0CHIIMNcgGu+UOoAN/Pw8ra7Qk7DsUMNSwTkzoT0PGemkkjQTxsHaE1zUf5vEXyR3
        Gwxkujuo5WGOqZCzqshxGjuvUNx0cfd26Td0DtI3S+yrwsmB3vRyO8ISEAc0RHCmDJaX1H9f8/mxZ
        KWQySyUYxIiufNNhqDJsGla2TLRW1zlEuJ1MdiVDXyT6SGIksR6O6o6NO3pSkeqtrwEIqX36UgLzo
        KLiJ9RdaHgVaXbDWBAvRMoXa8qny9JW0D30AxvCXOcwzGt7Rur+kFpq/GaLYXFoH2KB33MUAD3VI1
        SqNd33oNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4pFA-00018S-9q; Fri, 15 Mar 2019 15:59:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5A2321422949; Fri, 15 Mar 2019 16:59:33 +0100 (CET)
Date:   Fri, 15 Mar 2019 16:59:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315155933.GY5996@hirez.programming.kicks-ass.net>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315103357.GC6521@hirez.programming.kicks-ass.net>
 <20190315135124.GC27131@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315135124.GC27131@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:51:25AM -0400, Phil Auld wrote:
> On Fri, Mar 15, 2019 at 11:33:57AM +0100 Peter Zijlstra wrote:
> > On Fri, Mar 15, 2019 at 11:11:50AM +0100, Peter Zijlstra wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index ea74d43924b2..b71557be6b42 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
> > >  	return HRTIMER_NORESTART;
> > >  }
> > >  
> > > +extern const u64 max_cfs_quota_period;
> > > +
> > >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > >  {
> > >  	struct cfs_bandwidth *cfs_b =
> > > @@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > >  	unsigned long flags;
> > >  	int overrun;
> > >  	int idle = 0;
> > > +	int count = 0;
> > >  
> > >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > >  	for (;;) {
> > > @@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > >  		if (!overrun)
> > >  			break;
> > >  
> > > +		if (++count > 3) {
> > > +			u64 new, old = ktime_to_ns(cfs_b->period);
> > > +
> > > +			new = (old * 147) / 128; /* ~115% */
> > > +			new = min(new, max_cfs_quota_period);
> > 
> > Also, we can still engineer things to come unstuck; if we explicitly
> > configure period at 1e9 and then set a really small quota and then
> > create this insane amount of cgroups you have..
> > 
> > this code has no room to manouvre left.
> > 
> > Do we want to do anything about that? Or leave it as is, don't do that
> > then?
> > 
> 
> If the period is 1s it would be hard to make this loop fire repeatedly. I don't think
> it's that dependent on the quota other than getting some rqs throttled. The small quota
> would also mean fewer of them would get unthrottled per distribute call. You'd probably
> need _significantly_ more cgroups than my insane 2500 to hit it. 
> 
> Right now it settles out with a new period of ~12-15ms.  So ~200,000 cgroups?
> 
> Ben and I talked a little about this in another thread. I think hitting this is enough of 
> an edge case that this approach will make the problem go away. The only alternative we 
> came up with to reduce the time taken in unthrottle involved a fair bit of complexity 
> added to the every day code paths.  And might not help if the children all had their
> own quota/period settings active. 

Ah right. I forgot that part. And yes, I remember what was proposed to
avoid the tree walk, that wouldn't have been pretty.
