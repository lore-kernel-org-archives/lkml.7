Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75316C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23B2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFOm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:42:59 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:41377 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgAFOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:42:58 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id D7B1BB87FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 14:42:55 +0000 (GMT)
Received: (qmail 18866 invoked from network); 6 Jan 2020 14:42:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jan 2020 14:42:55 -0000
Date:   Mon, 6 Jan 2020 14:42:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
Message-ID: <20200106144250.GA3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V2
o Only allow a small imbalance when utilisation is low to address reports that
  higher utilisation workloads were hitting corner cases.

Changelog since V1
o Alter code flow 						vincent.guittot
o Use idle CPUs for comparison instead of sum_nr_running	vincent.guittot
o Note that the division is still in place. Without it and taking
  imbalance_adj into account before the cutoff, two NUMA domains
  do not converage as being equally balanced when the number of
  busy tasks equals the size of one domain (50% of the sum).

The CPU load balancer balances between different domains to spread load
and strives to have equal balance everywhere. Communicating tasks can
migrate so they are topologically close to each other but these decisions
are independent. On a lightly loaded NUMA machine, two communicating tasks
pulled together at wakeup time can be pushed apart by the load balancer.
In isolation, the load balancer decision is fine but it ignores the tasks
data locality and the wakeup/LB paths continually conflict. NUMA balancing
is also a factor but it also simply conflicts with the load balancer.

This patch allows a degree of imbalance to exist between NUMA domains based
on the imbalance_pct defined by the scheduler domain when utilisation is
very low. This slight imbalance is allowed until the number of running
tasks reaches the point where imbalance_pct may be noticable.

The most obvious impact is on netperf TCP_STREAM -- two simple
communicating tasks with some softirq offload depending on the
transmission rate.

2-socket Haswell machine 48 core, HT enabled
netperf-tcp -- mmtests config config-network-netperf-unbound
                       	      baseline              lbnuma-v3
Hmean     64         666.67 (   0.00%)      676.19 *   1.43%*
Hmean     128       1276.33 (   0.00%)     1301.66 *   1.98%*
Hmean     256       2394.38 (   0.00%)     2426.15 *   1.33%*
Hmean     1024      8163.19 (   0.00%)     8510.80 *   4.26%*
Hmean     2048     13102.01 (   0.00%)    13356.81 *   1.94%*
Hmean     3312     18072.51 (   0.00%)    17343.81 *  -4.03%*
Hmean     4096     19967.79 (   0.00%)    19451.95 *  -2.58%*
Hmean     8192     28458.73 (   0.00%)    28000.46 *  -1.61%*
Hmean     16384    30295.77 (   0.00%)    29145.59 *  -3.80%*
Stddev    64           5.07 (   0.00%)        0.33 (  93.55%)
Stddev    128         15.24 (   0.00%)        2.45 (  83.90%)
Stddev    256         23.90 (   0.00%)       10.62 (  55.58%)
Stddev    1024        57.66 (   0.00%)       19.20 (  66.70%)
Stddev    2048        97.52 (   0.00%)       43.19 (  55.71%)
Stddev    3312       344.31 (   0.00%)       86.02 (  75.02%)
Stddev    4096       177.54 (   0.00%)       60.12 (  66.13%)
Stddev    8192       423.47 (   0.00%)      239.01 (  43.56%)
Stddev    16384      183.18 (   0.00%)       96.91 (  47.09%)

Fairly small impact on average performance but note how much the standard
deviation is reduced.

Ops NUMA base-page range updates       22576.00         336.00
Ops NUMA PTE updates                   22576.00         336.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                   18487.00         162.00
Ops NUMA hint local faults %           10662.00          96.00
Ops NUMA hint local percent               57.67          59.26
Ops NUMA pages migrated                 4365.00          66.00

Without the patch, only 55.75% of sampled accesses are local.  In an
earlier changelog, 100% of sampled accesses are local and indeed on
most machines, this was still the case. In this specific case, the
local sampled rates was 59.26% but note the "base-page range updates"
and "PTE updates".  The activity with the patch is negligible as were
the number of faults. The small number of pages migrated were related to
shared libraries.  A 2-socket Broadwell showed better results on average
but are not presented for brevity as the performance was similar except
it showed 100% of the sampled NUMA hints were local. The patch holds up
for a 4-socket Haswell box and an AMD Epyc 2 based machine.

For dbench, the impact depends on the filesystem used and the number of
clients. On XFS, there is little difference as the clients typically
communicate with workqueues which have a separate class of scheduler
problem at the moment. For ext4, performance is generally better,
particularly for small numbers of clients as NUMA balancing activity is
negligible with the patch applied.

A more interesting example is the Facebook schbench which uses a
number of messaging threads to communicate with worker threads. In this
configuration, one messaging thread is used per NUMA node and the number of
worker threads is varied. The 50, 75, 90, 95, 99, 99.5 and 99.9 percentiles
for response latency is then reported.

Lat 50.00th-qrtle-1        44.00 (   0.00%)       36.00 (  18.18%)
Lat 75.00th-qrtle-1        53.00 (   0.00%)       41.00 (  22.64%)
Lat 90.00th-qrtle-1        57.00 (   0.00%)       42.00 (  26.32%)
Lat 95.00th-qrtle-1        63.00 (   0.00%)       43.00 (  31.75%)
Lat 99.00th-qrtle-1        76.00 (   0.00%)       52.00 (  31.58%)
Lat 99.50th-qrtle-1        89.00 (   0.00%)       53.00 (  40.45%)
Lat 99.90th-qrtle-1        98.00 (   0.00%)       59.00 (  39.80%)
Lat 50.00th-qrtle-2        42.00 (   0.00%)       41.00 (   2.38%)
Lat 75.00th-qrtle-2        48.00 (   0.00%)       45.00 (   6.25%)
Lat 90.00th-qrtle-2        53.00 (   0.00%)       51.00 (   3.77%)
Lat 95.00th-qrtle-2        55.00 (   0.00%)       52.00 (   5.45%)
Lat 99.00th-qrtle-2        62.00 (   0.00%)       59.00 (   4.84%)
Lat 99.50th-qrtle-2        63.00 (   0.00%)       61.00 (   3.17%)
Lat 99.90th-qrtle-2        68.00 (   0.00%)       65.00 (   4.41%)

For higher worker threads, the differences become negligible but it's
interesting to note the difference in wakeup latency at low utilisation
and mpstat confirms that activity was almost all on one node until
the number of worker threads increase.

Hackbench generally showed neutral results across a range of machines.
This is different to earlier versions of the patch which allowed imbalances
for higher degrees of utilisation. perf bench pipe showed negligible
differences in overall performance as the

An earlier prototype of the patch showed major regressions for NAS C-class
when running with only half of the available CPUs -- 20-30% performance
hits were measured at the time. With this version of the patch, the impact
is not detected as the number of threads used was always high enough
that normal load balancing was applied. Similarly, there were report of
regressions for the autonuma benchmark against earlier versions but again,
normal load balancing now applies for that workload.

In general, the patch simply seeks to avoid unnecessary cross-node
migrations when a machine is lightly loaded where load balancing across
NUMA nodes can be noticable. For low utilisation workloads, this patch
generally behaves better with less NUMA balancing activity. For high
utilisation, there is no change in behaviour.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba749f579714..e541b700e339 100644
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
@@ -8681,7 +8677,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 			return;
 		}
-
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
 			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
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
 
