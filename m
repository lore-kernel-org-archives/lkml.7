Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96287C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717B2215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgACOba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:31:30 -0500
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:40904 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727598AbgACOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:31:30 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 9A84D1C2CC9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 14:31:26 +0000 (GMT)
Received: (qmail 5515 invoked from network); 3 Jan 2020 14:31:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jan 2020 14:31:26 -0000
Date:   Fri, 3 Jan 2020 14:31:21 +0000
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
Message-ID: <20200103143051.GA3027@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 02:31:40PM +0100, Vincent Guittot wrote:
> > +               /* Consider allowing a small imbalance between NUMA groups */
> > +               if (env->sd->flags & SD_NUMA) {
> > +                       unsigned int imbalance_adj, imbalance_max;
> > +
> > +                       /*
> > +                        * imbalance_adj is the allowable degree of imbalance
> > +                        * to exist between two NUMA domains. It's calculated
> > +                        * relative to imbalance_pct with a minimum of two
> > +                        * tasks or idle CPUs. The choice of two is due to
> > +                        * the most basic case of two communicating tasks
> > +                        * that should remain on the same NUMA node after
> > +                        * wakeup.
> > +                        */
> > +                       imbalance_adj = max(2U, (busiest->group_weight *
> > +                               (env->sd->imbalance_pct - 100) / 100) >> 1);
> > +
> > +                       /*
> > +                        * Ignore small imbalances unless the busiest sd has
> > +                        * almost half as many busy CPUs as there are
> > +                        * available CPUs in the busiest group. Note that
> > +                        * it is not exactly half as imbalance_adj must be
> > +                        * accounted for or the two domains do not converge
> > +                        * as equally balanced if the number of busy tasks is
> > +                        * roughly the size of one NUMA domain.
> > +                        */
> > +                       imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> > +                       if (env->imbalance <= imbalance_adj &&
> 
> AFAICT, env->imbalance is undefined there. I have tried your patch
> with the below instead
> 

Even when fixed, other corner cases were hit for parallelised loads that
benefit from spreading early. At the moment I'm testing a variant of the
first approach except it adjust small balances at low utilisation and
otherwise balances at normal. It appears to work for basic communicating
tasks at relatively low utitisation that fits within a node without
obviously impacting higher utilisation non-communicating workloads but
more testing time will be needed to be sure.

It's still based on sum_nr_running as a cut-off instead of idle_cpus as
at low utilisation, there is not much of a material difference in the
cut-offs given that either approach can be misleading depending on the
load of the individual tasks, any cpu binding configurations and the
degree the tasks are memory-bound.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba749f579714..58ba2f0c6363 100644
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
@@ -8691,16 +8686,39 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
+			long imbalance_adj, imbalance_max;
+
+			/*
+			 * imbalance_adj is the allowable degree of imbalance
+			 * to exist between two NUMA domains. imbalance_pct
+			 * is used to estimate the number of active tasks
+			 * needed before memory bandwidth may be as important
+			 * as memory locality.
+			 */
+			imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
+
+			/*
+			 * Allow small imbalances when the busiest group has
+			 * low utilisation.
+			 */
+			imbalance_max = imbalance_adj << 1;
+			if (busiest->sum_nr_running < imbalance_max)
+				env->imbalance -= min(env->imbalance, imbalance_adj);
+		}
+
 		return;
 	}
 

-- 
Mel Gorman
SUSE Labs
