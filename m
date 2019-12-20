Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF77C206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:22:45 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:48255 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbfLTOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:22:45 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 9B52BC99
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 14:22:41 +0000 (GMT)
Received: (qmail 15641 invoked from network); 20 Dec 2019 14:22:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Dec 2019 14:22:41 -0000
Date:   Fri, 20 Dec 2019 14:22:39 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20191220142239.GM3178@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:40:02PM +0000, Valentin Schneider wrote:
> > +		/* Consider allowing a small imbalance between NUMA groups */
> > +		if (env->sd->flags & SD_NUMA) {
> > +			unsigned int imbalance_adj, imbalance_max;
> > +
> > +			/*
> > +			 * imbalance_adj is the allowable degree of imbalance
> > +			 * to exist between two NUMA domains. It's calculated
> > +			 * relative to imbalance_pct with a minimum of two
> > +			 * tasks or idle CPUs. The choice of two is due to
> > +			 * the most basic case of two communicating tasks
> > +			 * that should remain on the same NUMA node after
> > +			 * wakeup.
> > +			 */
> > +			imbalance_adj = max(2U, (busiest->group_weight *
> > +				(env->sd->imbalance_pct - 100) / 100) >> 1);
> > +
> > +			/*
> > +			 * Ignore small imbalances unless the busiest sd has
> > +			 * almost half as many busy CPUs as there are
> > +			 * available CPUs in the busiest group. Note that
> 
> This is all on the busiest group, so this should be more like:
> 
> 			 * Ignore small imbalances unless almost half of the
> 			 * busiest sg's CPUs are busy.
> 

Updated.

> > +			 * it is not exactly half as imbalance_adj must be
> > +			 * accounted for or the two domains do not converge
> > +			 * as equally balanced if the number of busy tasks is
> > +			 * roughly the size of one NUMA domain.
> > +			 */
> > +			imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> > +			if (env->imbalance <= imbalance_adj &&
> 
> I'm confused now, have we set env->imbalance to anything at this point?

No, it's a no-op in this context and I meant to take the check out.

> AIUI
> Vincent's suggestion was to hinge this purely on the weight vs idle_cpus /
> nr_running, IOW not use imbalance:
> 
> if (sd->flags & SD_NUMA) {                                                                         
> 	imbalance_adj = max(2U, (busiest->group_weight *                                           
> 				 (env->sd->imbalance_pct - 100) / 100) >> 1);                      
> 	imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;                              
>                                                                                                      
> 	if (busiest->idle_cpus >= imbalance_max) {                                                 
> 		env->imbalance = 0;                                                                
> 		return;                                                                            
> 	}                                                                                          
> }                                                                                                  
>        

And that's what it is now. Functionally it's equivalent similar other
than imbalance could be potentially anything (but should be zero).

> Now, I have to say I'm not sold on the idle_cpus thing, I'd much rather use
> the number of runnable tasks. We are setting up a threshold for how far we
> are willing to ignore imbalances; if we have overloaded CPUs we *really*
> should try to solve this. Number of tasks is the safer option IMO: when we
> do have one task per CPU, it'll be the same as if we had used idle_cpus, and
> when we don't have one task per CPU we'll load-balance more often that we
> would have with idle_cpus.
> 

I couldn't convince myself to really push back hard on the sum_nr_runnable
versus idle_cpus.  If the local group has spare capacity and the busiest
group has multiple tasks stacked on CPUs then it's most likely due to
CPU affinity. In that case, there is no guarantee tasks can move to the
local group either. In that case, the difference between sum_nr_running
and idle_cpus is almost moot.  There may be common use cases where the
distinction really matters but right now, I'm at the point where I think
such a change could be a separate patch with the use case included and
supporting data on why it must be sum_nr_running.  Right now, I feel it's
mostly a cosmetic issue given the context and intent of the patch.

-- 
Mel Gorman
SUSE Labs
