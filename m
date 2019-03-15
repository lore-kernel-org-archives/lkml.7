Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101AD21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pk7cXEb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfCOKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:34:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfCOKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DE9vYJOLUl34sVnx393zC533e+R/EoW9VaI1gxga6l0=; b=pk7cXEb9QB93vcdn5NgktPDxq
        kHLV/dO6ZihdtcPc2RrplAxn4pmPV9gkl5002Xlb5/bC9mapQCmGtjs06Rf+6y4Vgh0ZmRzJ+FmyU
        gp/ChAGpgtxg45tvXmKRNlBEOIm2YwHMTiaJDjcLsxftML00pAAKNM7mWME0bpuKnvQcmGGZjy8DJ
        YuD2QpdejsK3FnoGbpb0nBrETr/AXcVPwNhxibprM1wQAM1DWNuoN9wm3D4qsu41Enm7+9ynboYjj
        INwO7GK0yeVYHRUMABVy0n2oyqGrcrPL+p/R47Mk+XVRBzxfJd0IU6Z2PkL9ORcn/g4BdaQSKzm4N
        92oolecnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4kA2-00055j-IG; Fri, 15 Mar 2019 10:33:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50EE020118D7E; Fri, 15 Mar 2019 11:33:57 +0100 (CET)
Date:   Fri, 15 Mar 2019 11:33:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315103357.GC6521@hirez.programming.kicks-ass.net>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315101150.GV5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:11:50AM +0100, Peter Zijlstra wrote:
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

Also, we can still engineer things to come unstuck; if we explicitly
configure period at 1e9 and then set a really small quota and then
create this insane amount of cgroups you have..

this code has no room to manouvre left.

Do we want to do anything about that? Or leave it as is, don't do that
then?

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
