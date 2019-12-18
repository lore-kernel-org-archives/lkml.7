Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F073BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA6206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLRPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:44:06 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:53788 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbfLRPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:44:06 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id A9634B87BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:44:03 +0000 (GMT)
Received: (qmail 13458 invoked from network); 18 Dec 2019 15:44:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2019 15:44:03 -0000
Date:   Wed, 18 Dec 2019 15:44:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] sched, fair: Allow a small degree of load imbalance between
 SD_NUMA domains
Message-ID: <20191218154402.GF3178@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU load balancer balances between different domains to spread load
and strives to have equal balance everywhere. Communicating tasks can
migrate so they are topologically close to each other but these decisions
are independent. On a lightly loaded NUMA machine, two communicating tasks
pulled together at wakeup time can be pushed apart by the load balancer.
In isolation, the load balancer decision is fine but it ignores the tasks
data locality and the wakeup/LB paths continually conflict. NUMA balancing
is also a factor but it also simply conflicts with the load balancer.

This patch allows a degree of imbalance to exist between NUMA domains
based on the imbalance_pct defined by the scheduler domain to take into
account that data locality is also important. This slight imbalance is
allowed until the scheduler domain reaches almost 50% utilisation at which
point other factors like HT utilisation and memory bandwidth come into
play. While not commented upon in the code, the cutoff is important for
memory-bound parallelised non-communicating workloads that do not fully
utilise the entire machine. This is not necessarily the best universal
cut-off point but it appeared appropriate for a variety of workloads
and machines.

The most obvious impact is on netperf TCP_STREAM -- two simple
communicating tasks with some softirq offloaded depending on the
transmission rate.

2-socket Haswell machine 48 core, HT enabled
netperf-tcp -- mmtests config config-network-netperf-unbound
                       	      baseline              lbnuma-v1
Hmean     64         666.68 (   0.00%)      669.00 (   0.35%)
Hmean     128       1276.18 (   0.00%)     1285.59 *   0.74%*
Hmean     256       2366.78 (   0.00%)     2419.42 *   2.22%*
Hmean     1024      8123.94 (   0.00%)     8494.92 *   4.57%*
Hmean     2048     12962.45 (   0.00%)    13430.37 *   3.61%*
Hmean     3312     17709.24 (   0.00%)    17317.23 *  -2.21%*
Hmean     4096     19756.01 (   0.00%)    19480.56 (  -1.39%)
Hmean     8192     27469.59 (   0.00%)    27208.17 (  -0.95%)
Hmean     16384    30062.82 (   0.00%)    31135.21 *   3.57%*
Stddev    64           2.64 (   0.00%)        1.19 (  54.86%)
Stddev    128          6.22 (   0.00%)        0.65 (  89.51%)
Stddev    256          9.75 (   0.00%)       11.81 ( -21.07%)
Stddev    1024        69.62 (   0.00%)       38.48 (  44.74%)
Stddev    2048        72.73 (   0.00%)       58.22 (  19.94%)
Stddev    3312       412.35 (   0.00%)       67.77 (  83.57%)
Stddev    4096       345.02 (   0.00%)       81.07 (  76.50%)
Stddev    8192       280.09 (   0.00%)      250.19 (  10.68%)
Stddev    16384      452.99 (   0.00%)      222.97 (  50.78%)

Fairly small impact on average performance but note how much the standard
deviation is reduced showing much more stable results. A clearer story
is visible from the NUMA Balancing stats

Ops NUMA base-page range updates       21596.00         282.00
Ops NUMA PTE updates                   21596.00         282.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                   17786.00         134.00
Ops NUMA hint local faults %            9916.00         134.00
Ops NUMA hint local percent               55.75         100.00
Ops NUMA pages migrated                 4231.00           0.00

Without the patch, only 55.75% of sampled accesses are local.
With the patch, 100% of sampled accesses are local. A 2-socket
Broadwell showed better results on average but are not presented
for brevity. The patch holds up for 4-socket boxes as well

4-socket Haswell machine, 144 core, HT enabled
netperf-tcp

                       	      baseline              lbnuma-v1
Hmean     64         953.51 (   0.00%)      986.63 *   3.47%*
Hmean     128       1826.48 (   0.00%)     1887.48 *   3.34%*
Hmean     256       3295.19 (   0.00%)     3402.08 *   3.24%*
Hmean     1024     10915.40 (   0.00%)    11482.92 *   5.20%*
Hmean     2048     17833.82 (   0.00%)    19033.89 *   6.73%*
Hmean     3312     22690.72 (   0.00%)    24101.77 *   6.22%*
Hmean     4096     24422.23 (   0.00%)    26665.46 *   9.19%*
Hmean     8192     31250.11 (   0.00%)    33514.74 *   7.25%*
Hmean     16384    37033.70 (   0.00%)    38732.22 *   4.59%*

On this machine, the baseline measured 58.11% locality for sampled accesses
and 100% local accesses with the patch. Similarly, the patch holds up
for 2-socket machines with multiple L3 caches such as the AMD Epyc 2

2-socket EPYC-2 machine, 256 cores
netperf-tcp
Hmean     64        1564.63 (   0.00%)     1550.59 (  -0.90%)
Hmean     128       3028.83 (   0.00%)     3030.48 (   0.05%)
Hmean     256       5733.47 (   0.00%)     5769.51 (   0.63%)
Hmean     1024     18936.04 (   0.00%)    19216.15 *   1.48%*
Hmean     2048     27589.77 (   0.00%)    28200.45 *   2.21%*
Hmean     3312     35361.97 (   0.00%)    35881.94 *   1.47%*
Hmean     4096     37965.59 (   0.00%)    38702.01 *   1.94%*
Hmean     8192     48499.92 (   0.00%)    49530.62 *   2.13%*
Hmean     16384    54249.96 (   0.00%)    55937.24 *   3.11%*

For amusement purposes, here are two graphs showing CPU utilisation on
the 2-socket Haswell machine over time based on mpstat with the ordering
of the CPUs based on topology.

http://www.skynet.ie/~mel/postings/lbnuma-20191218/netperf-tcp-mpstat-baseline.png
http://www.skynet.ie/~mel/postings/lbnuma-20191218/netperf-tcp-mpstat-lbnuma-v1r1.png

The lines on the left match up CPUs that are HT siblings or on the same
node. The machine has only one L3 cache per NUMA node or that would also
be shown.  It should be very clear from the images that the baseline
kernel spread the load with lighter utilisation across nodes while the
patched kernel had heavy utilisation of fewer CPUs on one node.

Hackbench generally shows good results across machines with some
differences depending on whether threads or sockets are used as well as
pipes or sockets.  This is the *worst* result from the 2-socket Haswell
machine

2-socket Haswell machine 48 core, HT enabled
hackbench-process-pipes -- mmtests config config-scheduler-unbound
                           5.5.0-rc1              5.5.0-rc1
                     	    baseline              lbnuma-v1
Amean     1        1.2580 (   0.00%)      1.2393 (   1.48%)
Amean     4        5.3293 (   0.00%)      5.2683 *   1.14%*
Amean     7        8.9067 (   0.00%)      8.7130 *   2.17%*
Amean     12      14.9577 (   0.00%)     14.5773 *   2.54%*
Amean     21      25.9570 (   0.00%)     25.6657 *   1.12%*
Amean     30      37.7287 (   0.00%)     37.1277 *   1.59%*
Amean     48      61.6757 (   0.00%)     60.0433 *   2.65%*
Amean     79     100.4740 (   0.00%)     98.4507 (   2.01%)
Amean     110    141.2450 (   0.00%)    136.8900 *   3.08%*
Amean     141    179.7747 (   0.00%)    174.5110 *   2.93%*
Amean     172    221.0700 (   0.00%)    214.7857 *   2.84%*
Amean     192    245.2007 (   0.00%)    238.3680 *   2.79%*

An earlier prototype of the patch showed major regressions for NAS C-class
when running with only half of the available CPUs -- 20-30% performance
hits were measured at the time. With this version of the patch, the impact
is marginal

NAS-C class OMP -- mmtests config hpc-nas-c-class-omp-half
                     	     baseline              lbnuma-v1
Amean     bt.C       64.29 (   0.00%)       70.31 *  -9.36%*
Amean     cg.C       26.33 (   0.00%)       25.73 (   2.31%)
Amean     ep.C       10.26 (   0.00%)       10.27 (  -0.10%)
Amean     ft.C       17.98 (   0.00%)       19.03 (  -5.84%)
Amean     is.C        0.99 (   0.00%)        0.99 (   0.40%)
Amean     lu.C       51.72 (   0.00%)       49.11 (   5.04%)
Amean     mg.C        8.12 (   0.00%)        8.13 (  -0.15%)
Amean     sp.C       82.76 (   0.00%)       84.52 (  -2.13%)
Amean     ua.C       58.64 (   0.00%)       57.57 (   1.82%)

There is some impact but there is a degree of variability and the ones
showing impact are mainly workloads that are mostly parallelised
and communicate infrequently between tests. It's a corner case where
the workload benefits heavily from spreading wide and early which is
not common. This is intended to illustrate the worst case measured.

In general, the patch simply seeks to avoid unnecessarily cross-node
migrations when a machine is lightly loaded but shows benefits for other
workloads. While tests are still running, so far it seems to benefit
light-utilisation smaller workloads on large machines and does not appear
to do any harm to larger or parallelised workloads.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..1dc8c7800fc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8637,10 +8637,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8680,7 +8676,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
-			return;
+			goto out_spare;
 		}
 
 		/*
@@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		env->migration_type = migrate_task;
 		env->imbalance = max_t(long, 0, (local->idle_cpus -
 						 busiest->idle_cpus) >> 1);
+
+out_spare:
+		/*
+		 * Whether balancing the number of running tasks or the number
+		 * of idle CPUs, consider allowing some degree of imbalance if
+		 * migrating between NUMA domains.
+		 */
+		if (env->sd->flags & SD_NUMA) {
+			unsigned int imbalance_adj, imbalance_max;
+
+			/*
+			 * imbalance_adj is the allowable degree of imbalance
+			 * to exist between two NUMA domains. It's calculated
+			 * relative to imbalance_pct with a minimum of two
+			 * tasks or idle CPUs.
+			 */
+			imbalance_adj = (busiest->group_weight *
+				(env->sd->imbalance_pct - 100) / 100) >> 1;
+			imbalance_adj = max(imbalance_adj, 2U);
+
+			/*
+			 * Ignore imbalance unless busiest sd is close to 50%
+			 * utilisation. At that point balancing for memory
+			 * bandwidth and potentially avoiding unnecessary use
+			 * of HT siblings is as relevant as memory locality.
+			 */
+			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
+			if (env->imbalance <= imbalance_adj &&
+			    busiest->sum_nr_running < imbalance_max) {
+				env->imbalance = 0;
+			}
+		}
 		return;
 	}
 

-- 
Mel Gorman
SUSE Labs
