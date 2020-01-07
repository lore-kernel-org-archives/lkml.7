Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F2CC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FED2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:57:01 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:36547 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgAGJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:57:01 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 218571C2E13
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 09:56:58 +0000 (GMT)
Received: (qmail 973 invoked from network); 7 Jan 2020 09:56:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jan 2020 09:56:57 -0000
Date:   Tue, 7 Jan 2020 09:56:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107095655.GF3466@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:38:26AM +0100, Vincent Guittot wrote:
> > > This looks weird to me because you use imbalance_pct, which is
> > > meaningful only compare a ratio, to define a number that will be then
> > > compared to a number of tasks without taking into account the weight
> > > of the node. So whatever the node size, 32 or 128 CPUs, the
> > > imbalance_adj will be the same: 3 with the default imbalance_pct of
> > > NUMA level which is 125 AFAICT
> > >
> >
> > The intent in this version was to only cover the low utilisation case
> > regardless of the NUMA node size. There were too many corner cases
> > where the tradeoff of local memory latency versus local memory bandwidth
> > cannot be quantified. See Srikar's report as an example but it's a general
> > problem. The use of imbalance_pct was simply to find the smallest number of
> > running tasks were (imbalance_pct - 100) would be 1 running task and limit
> 
> But using imbalance_pct alone doesn't mean anything.

Other than figuring out "how many running tasks are required before
imbalance_pct is roughly equivalent to one fully active CPU?". Even then,
it's a bit weak as imbalance_pct makes hard-coded assumptions on what
the tradeoff of cross-domain migration is without considering the hardware.

> Using similar to the below
> 
>     busiest->group_weight * (env->sd->imbalance_pct - 100) / 100
> 
> would be more meaningful
> 

It's meaningful to some sense from a conceptual point of view but
setting the low utilisation cutoff depending on the number of CPUs on
the node does not account for any local memory latency vs bandwidth.
i.e. on a small or mid-range machine the cutoff will make sense. On
larger machines, the cutoff could be at the point where memory bandwidth
is saturated leading to a scenario whereby upgrading to a larger
machine performs worse than the smaller machine.

Much more importantly, doing what you suggest allows an imbalance
of more CPUs than are backed by a single LLC. On high-end AMD EPYC 2
machines, busiest->group_weight scaled by imbalance_pct spans multiple L3
caches. That is going to have side-effects. While I also do not account
for the LLC group_weight, it's unlikely the cut-off I used would be
smaller than an LLC cache on a large machine as the cache.

These two points are why I didn't take the group weight into account.

Now if you want, I can do what you suggest anyway as long as you are happy
that the child domain weight is also taken into account and to bound the
largest possible allowed imbalance to deal with the case of a node having
multiple small LLC caches. That means that some machines will be using the
size of the node and some machines will use the size of an LLC. It's less
predictable overall as some machines will be "special" relative to others
making it harder to reproduce certain problems locally but it would take
imbalance_pct into account in a way that you're happy with.

Also bear in mind that whether LLC is accounted for or not, the final
result should be halved similar to the other imbalance calculations to
avoid over or under load balancing.

> Or you could use the util_avg so you will take into account if the
> tasks are short running ones or long running ones
> 

util_avg can be skewed if there are big outliers. Even then, it's not
a great metric for the low utilisation cutoff. Large numbers of mostly
idle but running tasks would be treated similarly to small numbers of
fully active tasks. It's less predictable and harder to reason about how
load balancing behaves across a variety of workloads.

Based on what you suggest, the result looks like this (build tested
only)


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba749f579714..1b2c7bed2db5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8648,10 +8648,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	/*
 	 * Try to use spare capacity of local group without overloading it or
 	 * emptying busiest.
-	 * XXX Spreading tasks across NUMA nodes is not always the best policy
-	 * and special care should be taken for SD_NUMA domain level before
-	 * spreading the tasks. For now, load_balance() fully relies on
-	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
@@ -8691,16 +8687,41 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
-			return;
-		}
+		} else {
 
-		/*
-		 * If there is no overload, we just want to even the number of
-		 * idle cpus.
-		 */
-		env->migration_type = migrate_task;
-		env->imbalance = max_t(long, 0, (local->idle_cpus -
+			/*
+			 * If there is no overload, we just want to even the number of
+			 * idle cpus.
+			 */
+			env->migration_type = migrate_task;
+			env->imbalance = max_t(long, 0, (local->idle_cpus -
 						 busiest->idle_cpus) >> 1);
+		}
+
+		/* Consider allowing a small imbalance between NUMA groups */
+		if (env->sd->flags & SD_NUMA) {
+			struct sched_domain *child = env->sd->child;
+			unsigned int imbalance_adj;
+
+			/*
+			 * Calculate an acceptable degree of imbalance based
+			 * on imbalance_adj. However, do not allow a greater
+			 * imbalance than the child domains weight to avoid
+			 * a case where the allowed imbalance spans multiple
+			 * LLCs.
+			 */
+			imbalance_adj = busiest->group_weight * (env->sd->imbalance_pct - 100) / 100;
+			imbalance_adj = min(imbalance_adj, child->span_weight);
+			imbalance_adj >>= 1;
+
+			/*
+			 * Ignore small imbalances when the busiest group has
+			 * low utilisation.
+			 */
+			if (busiest->sum_nr_running < imbalance_adj)
+				env->imbalance = 0;
+		}
+
 		return;
 	}
 
