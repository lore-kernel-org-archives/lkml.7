Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3CF218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfCOPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfCOPap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C9E30A9CE5;
        Fri, 15 Mar 2019 15:30:45 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F035D75E;
        Fri, 15 Mar 2019 15:30:44 +0000 (UTC)
Date:   Fri, 15 Mar 2019 11:30:42 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315153042.GF27131@pauld.bos.csb>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315101150.GV5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 15 Mar 2019 15:30:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:11:50AM +0100 Peter Zijlstra wrote:
> On Wed, Mar 13, 2019 at 11:08:26AM -0400, Phil Auld wrote:

...

> Computers _suck_ at /100. And since you're free to pick the constant,
> pick a power of two, computers love those.
> 
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

In my defense here, all the fair.c imbalance pct code also uses 100 :)


> > +			pr_warn_ratelimited(
> > +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> > +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
> 
> period was ktime_t, remember...

Indeed. Worked but was incorrect. 

> 
> Would not something simpler like the below also work?


With my version:

[ 4246.030004] cfs_period_timer[cpu16]: period too short, scaling up (new cfs_period_us 5276, cfs_quota_us = 303973)
[ 4246.346978] cfs_period_timer[cpu16]: period too short, scaling up (new cfs_period_us 17474, cfs_quota_us = 1006569)

(most of the time it's only one message. Sometimes it does a smaller increase once first like this)



with the below:

[  117.235804] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2492, cfs_quota_us = 143554)
[  117.346807] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2862, cfs_quota_us = 164863)
[  117.470569] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3286, cfs_quota_us = 189335)
[  117.574883] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3774, cfs_quota_us = 217439)
[  117.652907] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4335, cfs_quota_us = 249716)
[  118.090535] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4978, cfs_quota_us = 286783)
[  122.098009] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 5717, cfs_quota_us = 329352)
[  126.255209] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 6566, cfs_quota_us = 378240)
[  126.358060] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 7540, cfs_quota_us = 434385)
[  126.538358] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 8660, cfs_quota_us = 498865)
[  126.614304] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 9945, cfs_quota_us = 572915)
[  126.817085] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 11422, cfs_quota_us = 657957)
[  127.352038] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 13117, cfs_quota_us = 755623)
[  127.598043] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 15064, cfs_quota_us = 867785)


Plus on repeats I see an occasional 

[  152.803384] sched_cfs_period_timer: 9 callbacks suppressed



I'll rework the maths in the averaged version and post v2 if that makes sense.

It may have the extra timer fetch, although maybe I could rework it so that it used the 
nsstart time the first time and did not need to do it twice in a row. I had originally
reverted the hrtimer_forward_now() to hrtimer_forward() but put that back. 


Thanks for looking at it. 


Also, fwiw, this was reported earlier by Anton Blanchard in https://lkml.org/lkml/2018/12/3/1047


Cheers,
Phil

> 
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
