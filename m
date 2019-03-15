Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E787C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E6D218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfCOQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfCOQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7F6A3086202;
        Fri, 15 Mar 2019 16:19:31 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27182600C2;
        Fri, 15 Mar 2019 16:19:31 +0000 (UTC)
Date:   Fri, 15 Mar 2019 12:19:29 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315161929.GH27131@pauld.bos.csb>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315103357.GC6521@hirez.programming.kicks-ass.net>
 <20190315135124.GC27131@pauld.bos.csb>
 <20190315155933.GY5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315155933.GY5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 15 Mar 2019 16:19:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 04:59:33PM +0100 Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 09:51:25AM -0400, Phil Auld wrote:
> > On Fri, Mar 15, 2019 at 11:33:57AM +0100 Peter Zijlstra wrote:
> > > On Fri, Mar 15, 2019 at 11:11:50AM +0100, Peter Zijlstra wrote:
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index ea74d43924b2..b71557be6b42 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
> > > >  	return HRTIMER_NORESTART;
> > > >  }
> > > >  
> > > > +extern const u64 max_cfs_quota_period;
> > > > +
> > > >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > > >  {
> > > >  	struct cfs_bandwidth *cfs_b =
> > > > @@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > > >  	unsigned long flags;
> > > >  	int overrun;
> > > >  	int idle = 0;
> > > > +	int count = 0;
> > > >  
> > > >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > > >  	for (;;) {
> > > > @@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> > > >  		if (!overrun)
> > > >  			break;
> > > >  
> > > > +		if (++count > 3) {
> > > > +			u64 new, old = ktime_to_ns(cfs_b->period);
> > > > +
> > > > +			new = (old * 147) / 128; /* ~115% */
> > > > +			new = min(new, max_cfs_quota_period);
> > > 
> > > Also, we can still engineer things to come unstuck; if we explicitly
> > > configure period at 1e9 and then set a really small quota and then
> > > create this insane amount of cgroups you have..
> > > 
> > > this code has no room to manouvre left.
> > > 
> > > Do we want to do anything about that? Or leave it as is, don't do that
> > > then?
> > > 
> > 
> > If the period is 1s it would be hard to make this loop fire repeatedly. I don't think
> > it's that dependent on the quota other than getting some rqs throttled. The small quota
> > would also mean fewer of them would get unthrottled per distribute call. You'd probably
> > need _significantly_ more cgroups than my insane 2500 to hit it. 
> > 
> > Right now it settles out with a new period of ~12-15ms.  So ~200,000 cgroups?
> > 
> > Ben and I talked a little about this in another thread. I think hitting this is enough of 
> > an edge case that this approach will make the problem go away. The only alternative we 
> > came up with to reduce the time taken in unthrottle involved a fair bit of complexity 
> > added to the every day code paths.  And might not help if the children all had their
> > own quota/period settings active. 
> 
> Ah right. I forgot that part. And yes, I remember what was proposed to
> avoid the tree walk, that wouldn't have been pretty.

I'm glad I was not the only one who was not excited by that  :)



-- 
