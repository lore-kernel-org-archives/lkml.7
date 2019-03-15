Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C08218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCONap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfCONap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D36443016643;
        Fri, 15 Mar 2019 13:30:44 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C3481001DC9;
        Fri, 15 Mar 2019 13:30:44 +0000 (UTC)
Date:   Fri, 15 Mar 2019 09:30:42 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315133042.GB27131@pauld.bos.csb>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315101150.GV5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 15 Mar 2019 13:30:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:11:50AM +0100 Peter Zijlstra wrote:
> On Wed, Mar 13, 2019 at 11:08:26AM -0400, Phil Auld wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 310d0637fe4b..90cc67bbf592 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
> >  	return HRTIMER_NORESTART;
> >  }
> >  
> > +extern const u64 max_cfs_quota_period;
> > +int cfs_period_autotune_loop_limit   = 8;
> > +int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
> 
> static const ?
> 
> > +
> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> >  {
> >  	struct cfs_bandwidth *cfs_b =
> >  		container_of(timer, struct cfs_bandwidth, period_timer);
> > +	s64 nsstart, nsnow, new_period;
> 
> u64
> 
> >  	int overrun;
> >  	int idle = 0;
> > +	int count = 0;
> >  
> >  	raw_spin_lock(&cfs_b->lock);
> > +	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
> 
> we really should kill ktime :/ Anyway, you now do two indirect timer
> calls back to back :/
> 
> And this is unconditional overhead.
> 
> >  	for (;;) {
> >  		overrun = hrtimer_forward_now(timer, cfs_b->period);
> >  		if (!overrun)
> >  			break;
> >  
> > +		if (++count > cfs_period_autotune_loop_limit) {
> > +			ktime_t old_period = ktime_to_ns(cfs_b->period);
> > +
> > +			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
> > +			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
> > +
> > +			/*  Make sure new period will be larger than old. */
> > +			if (new_period < old_period) {
> > +				new_period = old_period;
> > +			}
> > +			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;
> 
> Computers _suck_ at /100. And since you're free to pick the constant,
> pick a power of two, computers love those.
> 

Fair enough, I was thinking percents. And also that once we get in here it's not a really hot path.

> > +
> > +			if (new_period >  max_cfs_quota_period)
> > +				new_period = max_cfs_quota_period;
> > +
> > +			cfs_b->period = ns_to_ktime(new_period);
> > +			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;
> 
> srsly!? Again, you can pick the constant to be anything, and you pick
> such a horrid number?!
> 

Same as above :)


> > +			pr_warn_ratelimited(
> > +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> > +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
> 
> period was ktime_t, remember...
> 
> > +
> 
> And these here lines all all waaay too long.
> 
> Also, is that complexity really needed?
> 
> > +			/* reset count so we don't come right back in here */
> > +			count = 0;
> > +		}
> > +
> >  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
> >  	}
> >  	if (idle)
> 
> 
> Would not something simpler like the below also work?
> 

I expect it would.... but the original concept increased the period to 
a bit more (15%) than the average time it was taking to go around the loop.  
This version will run the loop a lot longer as it's only increasing by 
15% each time. 

In my setup it would go from ~2000 to ~11000 and be done.  This one 
will go off, raise 2000 to 2300,  then fire again, raise to 2645 , etc.

Unless it's getting reset this would still be a one time thing so that
may not matter.

The math calculations do look better though. I knew there had to be a 
better way to scale up the quota. It just wasn't jumping out at me :)


Thanks,

Phil

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ea74d43924b2..b71557be6b42 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +extern const u64 max_cfs_quota_period;
> +
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
> @@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	unsigned long flags;
>  	int overrun;
>  	int idle = 0;
> +	int count = 0;
>  
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	for (;;) {
> @@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  		if (!overrun)
>  			break;
>  
> +		if (++count > 3) {
> +			u64 new, old = ktime_to_ns(cfs_b->period);
> +
> +			new = (old * 147) / 128; /* ~115% */
> +			new = min(new, max_cfs_quota_period);
> +
> +			cfs_b->period = ns_to_ktime(new);
> +
> +			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
> +			cfs_b->quota *= new;
> +			cfs_b->quota /= old;
> +
> +			pr_warn_ratelimited(
> +	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> +				smp_processor_id(),
> +				new/NSEC_PER_USEC,
> +				cfs_b->quota/NSEC_PER_USEC);
> +
> +			/* reset count so we don't come right back in here */
> +			count = 0;
> +		}
> +
>  		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
>  	}
>  	if (idle)

-- 
