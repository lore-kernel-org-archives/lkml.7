Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C44C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF70424650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLSP6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:58:21 -0500
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:37415 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbfLSP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:58:21 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id E831BB8700
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 15:58:18 +0000 (GMT)
Received: (qmail 24766 invoked from network); 19 Dec 2019 15:58:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Dec 2019 15:58:18 -0000
Date:   Thu, 19 Dec 2019 15:58:16 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219155816.GK3178@techsingularity.net>
References: <20191218154402.GF3178@techsingularity.net>
 <20191219144539.GA19614@linaro.org>
 <20191219151824.GI3178@techsingularity.net>
 <20191219154117.GB19614@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191219154117.GB19614@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 04:41:17PM +0100, Vincent Guittot wrote:
> > I don't understand. If I move SD_NUMA checks above the imbalance
> > calculation, how do I know whether the imbalance should be ignored?
> 
> You are only clearing env->imbalance before returning if the condition
> between sum_nr_running with weight doesn't  match so you don't care about
> what will be the value of env->imbalance in the other case so you can have 
> 
> 		if ((env->sd->flags & SD_NUMA) &&
> 			( allow some degrees of imbalance )) {
> 				env->imbalance = 0
> 				return;
> 		}
> 
> 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> 			unsigned int nr_diff = busiest->sum_nr_running;
> 			/*
> 			 * When prefer sibling, evenly spread running tasks on
> 			 * groups.
> 			 */
> 			env->migration_type = migrate_task;
> 			lsub_positive(&nr_diff, local->sum_nr_running);
> 			env->imbalance = nr_diff >> 1;
> 			return;
> 		}
> 
> 		/*
> 		 * If there is no overload, we just want to even the number of
> 		 * idle cpus.
> 		 */
> 		env->migration_type = migrate_task;
> 		env->imbalance = max_t(long, 0, (local->idle_cpus -
> 						 busiest->idle_cpus) >> 1);
> 		return;
> 	}
> 	

Ok, that's clear. In an earlier version, I was not just resetting it, I
was adjusting the estimated imbalance but it was fragile. I can move the
check as you suggest.

> > > > @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > > >  		env->migration_type = migrate_task;
> > > >  		env->imbalance = max_t(long, 0, (local->idle_cpus -
> > > >  						 busiest->idle_cpus) >> 1);
> > > > +
> > > > +out_spare:
> > > > +		/*
> > > > +		 * Whether balancing the number of running tasks or the number
> > > > +		 * of idle CPUs, consider allowing some degree of imbalance if
> > > > +		 * migrating between NUMA domains.
> > > > +		 */
> > > > +		if (env->sd->flags & SD_NUMA) {
> > > > +			unsigned int imbalance_adj, imbalance_max;
> > > > +
> > > > +			/*
> > > > +			 * imbalance_adj is the allowable degree of imbalance
> > > > +			 * to exist between two NUMA domains. It's calculated
> > > > +			 * relative to imbalance_pct with a minimum of two
> > > > +			 * tasks or idle CPUs.
> > > > +			 */
> > > > +			imbalance_adj = (busiest->group_weight *
> > > > +				(env->sd->imbalance_pct - 100) / 100) >> 1;
> > > > +			imbalance_adj = max(imbalance_adj, 2U);
> > > > +
> > > > +			/*
> > > > +			 * Ignore imbalance unless busiest sd is close to 50%
> > > > +			 * utilisation. At that point balancing for memory
> > > > +			 * bandwidth and potentially avoiding unnecessary use
> > > > +			 * of HT siblings is as relevant as memory locality.
> > > > +			 */
> > > > +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> > > > +			if (env->imbalance <= imbalance_adj &&
> > > > +			    busiest->sum_nr_running < imbalance_max) {i
> > > 
> > > Shouldn't you consider the number of busiest->idle_cpus instead of the busiest->sum_nr_running ?
> > > 
> > 
> > Why? CPU affinity could have stacked multiple tasks on one CPU where
> > as I'm looking for a proxy hint on the amount of bandwidth required.
> > sum_nr_running does not give me an accurate estimate but it's better than
> > idle cpus.
> 
> Because even if you have multiple tasks on one CPU, only one will run at a
> time on the CPU and others will wait so the bandwidth is effectively link to
> the number of running CPUs more than number of runnable tasks
> 

Ok, I can try that. There is the corner case where tasks can be stacked on
the one CPU without affinities being involved but it's rare. That might
change again in the future if unbound workqueues get special cased to
allow a wakee to stack on top of the workqueues CPU as it's essentially
sync but it's not likely to make that much of a difference.

-- 
Mel Gorman
SUSE Labs
