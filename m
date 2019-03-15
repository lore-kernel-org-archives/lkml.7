Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D371FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA04218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3Ed0AYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfCOKMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:12:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfCOKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F6GfYNbJcfabAB+xV9Bd1oJrunP47oboReiOPuuQV0c=; b=d3Ed0AYAib1eOm3aZJtya/tsC
        ejee8xg5MVVcmnQ9yhumktuJUv+9OFvd3Luq8dH5MCvcB43hJeSgc6FqFJ2Cj8DemZfij5cTNBpoV
        24leyBO+SOAyrJmpGD/YKKjL+Qbxj3hfZyFgAUjnZF2ylXpQKvACSuRaiLOmqYoVmLA7MzzGY8vJT
        0isVMC+Cax/Gzx29MvNaxgOVY2uC4jB5g/rVPruwaSsrsNthCKmar+EOvioa4u5fFnHbBbW4pSWd2
        xiYWpEW9tlPY4MeT1dazG4/nkBvpNzqZ2302T7tGzP2JvbDDanGbhY1bcE8m2vt5Hknx04gL12M85
        Ft3X2vUrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4joe-0004z6-H4; Fri, 15 Mar 2019 10:12:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F53B21A7734B; Fri, 15 Mar 2019 11:11:50 +0100 (CET)
Date:   Fri, 15 Mar 2019 11:11:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315101150.GV5996@hirez.programming.kicks-ass.net>
References: <20190313150826.16862-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313150826.16862-1-pauld@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:08:26AM -0400, Phil Auld wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 310d0637fe4b..90cc67bbf592 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +extern const u64 max_cfs_quota_period;
> +int cfs_period_autotune_loop_limit   = 8;
> +int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */

static const ?

> +
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
>  		container_of(timer, struct cfs_bandwidth, period_timer);
> +	s64 nsstart, nsnow, new_period;

u64

>  	int overrun;
>  	int idle = 0;
> +	int count = 0;
>  
>  	raw_spin_lock(&cfs_b->lock);
> +	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));

we really should kill ktime :/ Anyway, you now do two indirect timer
calls back to back :/

And this is unconditional overhead.

>  	for (;;) {
>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>  		if (!overrun)
>  			break;
>  
> +		if (++count > cfs_period_autotune_loop_limit) {
> +			ktime_t old_period = ktime_to_ns(cfs_b->period);
> +
> +			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
> +			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
> +
> +			/*  Make sure new period will be larger than old. */
> +			if (new_period < old_period) {
> +				new_period = old_period;
> +			}
> +			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;

Computers _suck_ at /100. And since you're free to pick the constant,
pick a power of two, computers love those.

> +
> +			if (new_period >  max_cfs_quota_period)
> +				new_period = max_cfs_quota_period;
> +
> +			cfs_b->period = ns_to_ktime(new_period);
> +			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;

srsly!? Again, you can pick the constant to be anything, and you pick
such a horrid number?!

> +			pr_warn_ratelimited(
> +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);

period was ktime_t, remember...

> +

And these here lines all all waaay too long.

Also, is that complexity really needed?

> +			/* reset count so we don't come right back in here */
> +			count = 0;
> +		}
> +
>  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
>  	}
>  	if (idle)


Would not something simpler like the below also work?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea74d43924b2..b71557be6b42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
@@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	unsigned long flags;
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
@@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		if (++count > 3) {
+			u64 new, old = ktime_to_ns(cfs_b->period);
+
+			new = (old * 147) / 128; /* ~115% */
+			new = min(new, max_cfs_quota_period);
+
+			cfs_b->period = ns_to_ktime(new);
+
+			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
+			cfs_b->quota *= new;
+			cfs_b->quota /= old;
+
+			pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(),
+				new/NSEC_PER_USEC,
+				cfs_b->quota/NSEC_PER_USEC);
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
