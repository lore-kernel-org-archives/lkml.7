Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A0BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7563F206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYs1wyOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfHFP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:56:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33474 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfHFP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ccFJ0+Yk3Ygr382M3ipxrJ+i7bZZ7I6g5tgANDgoKPI=; b=GYs1wyOlTY7RfhDMzkJTkt0xu
        V8orAAb/FG3jhf+uP5Xa30UfJtaWWtIDPx8pypLcjYmHpmaXUx7rilUQM0nGVpzOMXgwomm44QAZs
        zBt3U1jPOnBLaHLbCjpYKFIDvFUiELgndQfrrGMKsvpIqiF/MkoC+NdPMfed6pdF97Nc11PjQJ9jO
        PbYLhsqnpuMeYmBl2e3fK+ki6OC6uXguJjCnoDGr94tuw0W0wJEr0VFr5vJvSVVC5i3CZuq/gPpi2
        7OGQ0qZkRvhMyo1vpZsXfwTQ7QZZg/Yj3YTMshnGFAgTIOCBjxarc7/JDe1ZG9VtmI1p0UN8NB4UR
        fHVYJmClQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1p1-0004TT-3R; Tue, 06 Aug 2019 15:56:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D693D3067E2;
        Tue,  6 Aug 2019 17:55:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F5A5201B3995; Tue,  6 Aug 2019 17:56:20 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:56:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
Message-ID: <20190806155620.GV2332@hirez.programming.kicks-ass.net>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:40:20PM +0200, Vincent Guittot wrote:
> The load_balance algorithm contains some heuristics which have becomes
> meaningless since the rework of metrics and the introduction of PELT.
> 
> Furthermore, it's sometimes difficult to fix wrong scheduling decisions
> because everything is based on load whereas some imbalances are not
> related to the load. The current algorithm ends up to create virtual and
> meaningless value like the avg_load_per_task or tweaks the state of a
> group to make it overloaded whereas it's not, in order to try to migrate
> tasks.
> 
> load_balance should better qualify the imbalance of the group and define
> cleary what has to be moved to fix this imbalance.
> 
> The type of sched_group has been extended to better reflect the type of
> imbalance. We now have :
> 	group_has_spare
> 	group_fully_busy
> 	group_misfit_task
> 	group_asym_capacity
> 	group_imbalanced
> 	group_overloaded
> 
> Based on the type of sched_group, load_balance now sets what it wants to
> move in order to fix the imnbalance. It can be some load as before but
> also some utilization, a number of task or a type of task:
> 	migrate_task
> 	migrate_util
> 	migrate_load
> 	migrate_misfit
> 
> This new load_balance algorithm fixes several pending wrong tasks
> placement:
> - the 1 task per CPU case with asymetrics system
> - the case of cfs task preempted by other class
> - the case of tasks not evenly spread on groups with spare capacity
> 
> The load balance decisions have been gathered in 3 functions:
> - update_sd_pick_busiest() select the busiest sched_group.
> - find_busiest_group() checks if there is an imabalance between local and
>   busiest group.
> - calculate_imbalance() decides what have to be moved.

I like this lots, very good stuff.

It is weird how misfit is still load, but istr later patches cure that.

Here's a whole pile of nits, some overlap with what Valentin already
noted. His suggestions for the changelog also make sense to me.

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8205,10 +8205,10 @@ static bool update_sd_pick_busiest(struc
 {
 	struct sg_lb_stats *busiest = &sds->busiest_stat;
 
-
 	/* Make sure that there is at least one task to pull */
 	if (!sgs->sum_h_nr_running)
 		return false;
+
 	/*
 	 * Don't try to pull misfit tasks we can't help.
 	 * We can use max_capacity here as reduction in capacity on some
@@ -8239,11 +8239,11 @@ static bool update_sd_pick_busiest(struc
 		break;
 
 	case group_imbalanced:
-		/* Select the 1st imbalanced group as we don't have
-		 * any way to choose one more than another
+		/*
+		 * Select the 1st imbalanced group as we don't have any way to
+		 * choose one more than another
 		 */
 		return false;
-		break;
 
 	case group_asym_capacity:
 		/* Prefer to move from lowest priority CPU's work */
@@ -8253,8 +8253,8 @@ static bool update_sd_pick_busiest(struc
 
 	case group_misfit_task:
 		/*
-		 * If we have more than one misfit sg go with the
-		 * biggest misfit.
+		 * If we have more than one misfit sg go with the biggest
+		 * misfit.
 		 */
 		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
 			return false;
@@ -8262,14 +8262,14 @@ static bool update_sd_pick_busiest(struc
 
 	case group_fully_busy:
 		/*
-		 * Select the fully busy group with highest avg_load.
-		 * In theory, there is no need to pull task from such
-		 * kind of group because tasks have all compute
-		 * capacity that they need but we can still improve the
-		 * overall throughput by reducing contention when
-		 * accessing shared HW resources.
-		 * XXX for now avg_load is not computed and always 0 so
-		 * we select the 1st one.
+		 * Select the fully busy group with highest avg_load.  In
+		 * theory, there is no need to pull task from such kind of
+		 * group because tasks have all compute capacity that they need
+		 * but we can still improve the overall throughput by reducing
+		 * contention when accessing shared HW resources.
+		 *
+		 * XXX for now avg_load is not computed and always 0 so we
+		 * select the 1st one.
 		 */
 		if (sgs->avg_load <= busiest->avg_load)
 			return false;
@@ -8277,11 +8277,11 @@ static bool update_sd_pick_busiest(struc
 
 	case group_has_spare:
 		/*
-		 * Select not overloaded group with lowest number of
-		 * idle cpus. We could also compare the spare capacity
-		 * which is more stable but it can end up that the
-		 * group has less spare capacity but finally more idle
-		 * cpus which means less opportunity to pull tasks.
+		 * Select not overloaded group with lowest number of idle cpus.
+		 * We could also compare the spare capacity which is more
+		 * stable but it can end up that the group has less spare
+		 * capacity but finally more idle cpus which means less
+		 * opportunity to pull tasks.
 		 */
 		if (sgs->idle_cpus >= busiest->idle_cpus)
 			return false;
@@ -8289,10 +8289,10 @@ static bool update_sd_pick_busiest(struc
 	}
 
 	/*
-	 * Candidate sg has no more than one task per CPU and
-	 * has higher per-CPU capacity. Migrating tasks to less
-	 * capable CPUs may harm throughput. Maximize throughput,
-	 * power/energy consequences are not considered.
+	 * Candidate sg has no more than one task per CPU and has higher
+	 * per-CPU capacity. Migrating tasks to less capable CPUs may harm
+	 * throughput. Maximize throughput, power/energy consequences are not
+	 * considered.
 	 */
 	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
 	    (sgs->group_type <= group_fully_busy) &&
@@ -8428,6 +8428,7 @@ static inline void calculate_imbalance(s
 
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -8442,8 +8443,8 @@ static inline void calculate_imbalance(s
 
 	if (busiest->group_type == group_asym_capacity) {
 		/*
-		 * In case of asym capacity, we will try to migrate all load
-		 * to the preferred CPU
+		 * In case of asym capacity, we will try to migrate all load to
+		 * the preferred CPU
 		 */
 		env->balance_type = migrate_load;
 		env->imbalance = busiest->group_load;
@@ -8483,7 +8484,8 @@ static inline void calculate_imbalance(s
 			 * groups.
 			 */
 			env->balance_type = migrate_task;
-			env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
+			env->imbalance = (busiest->sum_h_nr_running -
+					  local->sum_h_nr_running) >> 1;
 			return;
 		}
 
@@ -8502,7 +8504,7 @@ static inline void calculate_imbalance(s
 	 */
 	if (local->group_type < group_overloaded) {
 		/*
-		 * Local will become overvloaded so the avg_load metrics are
+		 * Local will become overloaded so the avg_load metrics are
 		 * finally needed
 		 */
 
@@ -8514,12 +8516,12 @@ static inline void calculate_imbalance(s
 	}
 
 	/*
-	 * Both group are or will become overloaded and we're trying to get
-	 * all the CPUs to the average_load, so we don't want to push
-	 * ourselves above the average load, nor do we wish to reduce the
-	 * max loaded CPU below the average load. At the same time, we also
-	 * don't want to reduce the group load below the group capacity.
-	 * Thus we look for the minimum possible imbalance.
+	 * Both group are or will become overloaded and we're trying to get all
+	 * the CPUs to the average_load, so we don't want to push ourselves
+	 * above the average load, nor do we wish to reduce the max loaded CPU
+	 * below the average load. At the same time, we also don't want to
+	 * reduce the group load below the group capacity.  Thus we look for
+	 * the minimum possible imbalance.
 	 */
 	env->balance_type = migrate_load;
 	env->imbalance = min(
@@ -8641,7 +8643,6 @@ static struct sched_group *find_busiest_
 		if (100 * busiest->avg_load <=
 				env->sd->imbalance_pct * local->avg_load)
 			goto out_balanced;
-
 	}
 
 	/* Try to move all excess tasks to child's sibling domain */
@@ -8651,7 +8652,7 @@ static struct sched_group *find_busiest_
 
 	if (busiest->group_type != group_overloaded &&
 	     (env->idle == CPU_NOT_IDLE ||
-	      local->idle_cpus <= (busiest->idle_cpus + 1)))
+	      local->idle_cpus <= (busiest->idle_cpus + 1))) {
 		/*
 		 * If the busiest group is not overloaded
 		 * and there is no imbalance between this and busiest group
@@ -8661,15 +8662,14 @@ static struct sched_group *find_busiest_
 		 * group.
 		 */
 		goto out_balanced;
+	}
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
 	calculate_imbalance(env, &sds);
-
 	return env->imbalance ? sds.busiest : NULL;
 
 out_balanced:
-
 	env->imbalance = 0;
 	return NULL;
 }
