Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F13C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95720896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wR1Xo3Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391300AbfFKNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:50:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387866AbfFKNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=weJ+BdbI8Q90N8a+OOAeypEBoVRkubIK5bltMKMV/f0=; b=wR1Xo3SpqWqwzufYCGoJxXd+P
        IX0sP1A8tp4aRwAT5IqhpOi2dNXgSvBe1FCTDtZHZY9Zj+lLAbAtc3MZk8qSXSqQYeDT+RXVpJmhF
        h5xgpBXkw/beP8Om3U//CtYWl7NYimwKd028qGjhTEgtQgv+IKsWNJTsuRCDYulmAzNAhZUS+t6eH
        4Qf/wVhya/c4D41yJOEcSy9sgEjyVd4DUuWN/5lkpGKkDv6vgIbgCdZ9reyfJmVT9U0gNolWDDfhz
        WXJS892PRO+ujgCUf23gn5Qoo49FxwfC61Nn7f/EqX13LdgQsN5HxlDRGvrz+orUb56dlRCWBNQTM
        YvS9hU1Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hahAC-0004pJ-Kz; Tue, 11 Jun 2019 13:50:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3842520236A40; Tue, 11 Jun 2019 15:50:11 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:50:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     bsegall@google.com, linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611135011.GX3436@hirez.programming.kicks-ass.net>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
 <20190611130417.GA15412@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611130417.GA15412@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:04:17AM -0400, Phil Auld wrote:
> On Thu, Jun 06, 2019 at 10:21:01AM -0700 bsegall@google.com wrote:
> > When a cfs_rq sleeps and returns its quota, we delay for 5ms before
> > waking any throttled cfs_rqs to coalesce with other cfs_rqs going to
> > sleep, as this has to be done outside of the rq lock we hold.
> > 
> > The current code waits for 5ms without any sleeps, instead of waiting
> > for 5ms from the first sleep, which can delay the unthrottle more than
> > we want. Switch this around so that we can't push this forward forever.
> > 
> > This requires an extra flag rather than using hrtimer_active, since we
> > need to start a new timer if the current one is in the process of
> > finishing.
> > 
> > Signed-off-by: Ben Segall <bsegall@google.com>
> > Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>
> > ---
> >  kernel/sched/fair.c  | 7 +++++++
> >  kernel/sched/sched.h | 1 +
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8213ff6e365d..2ead252cfa32 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4729,6 +4729,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
> >  	if (runtime_refresh_within(cfs_b, min_left))
> >  		return;
> >  
> > +	/* don't push forwards an existing deferred unthrottle */
> > +	if (cfs_b->slack_started)
> > +		return;
> > +	cfs_b->slack_started = true;
> > +
> >  	hrtimer_start(&cfs_b->slack_timer,
> >  			ns_to_ktime(cfs_bandwidth_slack_period),
> >  			HRTIMER_MODE_REL);
> > @@ -4782,6 +4787,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >  
> >  	/* confirm we're still not at a refresh boundary */
> >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > +	cfs_b->slack_started = false;
> >  	if (cfs_b->distribute_running) {
> >  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  		return;
> > @@ -4920,6 +4926,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> >  	cfs_b->distribute_running = 0;
> > +	cfs_b->slack_started = false;
> >  }
> >  
> >  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index efa686eeff26..60219acda94b 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -356,6 +356,7 @@ struct cfs_bandwidth {
> >  	u64			throttled_time;
> >  
> >  	bool                    distribute_running;
> > +	bool                    slack_started;
> >  #endif
> >  };
> >  
> > -- 
> > 2.22.0.rc1.257.g3120a18244-goog
> > 
> 
> I think this looks good. I like not delaying that further even if it
> does not fix Dave's use case. 
> 
> It does make it glaring that I should have used false/true for setting
> distribute_running though :)
> 
> 
> Acked-by: Phil Auld <pauld@redhat.com>

Thanks!

Should this patch have a Fixes: tag?
