Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F647C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3520665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUYO+D7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFZWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:53:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39034 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:53:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMosGV107404;
        Wed, 26 Jun 2019 22:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=IHmeBBARvTJvyxGE8gRA9Eyc7FSvzrhRzBOaOgYx4D8=;
 b=GUYO+D7hnI/gTC/AYf612nFTeZ/iN1H28+Zg2rNpIsrN/Ej0iRnGWdPU9uIabcWX/uKK
 notj+4mu67QKbhyFA9E5EZtyD746ZKIzqVI8D7QD5ptr4S6e7lw37cfQQp+FJgQ7n8re
 vuQ+/AwYQVXPAGbyLgPJFtb+bi1zlo1u83uk+CAhpMZuySPpl99dMQHT55SLX0ujn9z9
 uWbSevQw4dgNNJDlCS451L1QJyXZorGdDyoyeM07eQzcHDrJHFcWaZDTHPuaJepmeGDW
 DBypqS0FyC3UI3kpVWMEORziJ0X0iQ/1U5rua/tuPHmWT1zbzzbuZUvydra7loDW5oJB fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqmwag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMpxnN075815;
        Wed, 26 Jun 2019 22:52:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f4q9x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QMqQBd015901;
        Wed, 26 Jun 2019 22:52:26 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 15:52:26 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [RFC PATCH 2/3] sched: change scheduler to give preference to soft affinity CPUs
Date:   Wed, 26 Jun 2019 15:47:17 -0700
Message-Id: <20190626224718.21973-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soft affinity CPUs present in the cpumask cpus_preferred is used by the
scheduler in two levels of search. First is in determining wake affine
which choses the LLC domain and secondly while searching for idle CPUs in
LLC domain. In the first level it uses cpus_preferred to prune out the
search space. In the second level it first searches the cpus_preferred and
then cpus_allowed. Using affinity_unequal flag it breaks early to avoid
any overhead in the scheduler fast path when soft affinity is not used.
This only changes the wake up path of the scheduler, the idle balancing
is unchanged; together they achieve the "softness" of scheduling.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 137 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..53aa7f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5807,7 +5807,7 @@ static unsigned long capacity_spare_without(int cpu, struct task_struct *p)
  */
 static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
+		  int this_cpu, int sd_flag, struct cpumask *cpus)
 {
 	struct sched_group *idlest = NULL, *group = sd->groups;
 	struct sched_group *most_spare_sg = NULL;
@@ -5831,7 +5831,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 
 		/* Skip over this group if it has no CPUs allowed */
 		if (!cpumask_intersects(sched_group_span(group),
-					&p->cpus_allowed))
+					cpus))
 			continue;
 
 		local_group = cpumask_test_cpu(this_cpu,
@@ -5949,7 +5949,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
  */
 static int
-find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+find_idlest_group_cpu(struct sched_group *group, struct task_struct *p,
+		      int this_cpu, struct cpumask *cpus)
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
@@ -5963,7 +5964,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		return cpumask_first(sched_group_span(group));
 
 	/* Traverse only the allowed CPUs */
-	for_each_cpu_and(i, sched_group_span(group), &p->cpus_allowed) {
+	for_each_cpu_and(i, sched_group_span(group), cpus) {
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
@@ -5999,7 +6000,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 }
 
 static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
-				  int cpu, int prev_cpu, int sd_flag)
+				  int cpu, int prev_cpu, int sd_flag,
+				  struct cpumask *cpus)
 {
 	int new_cpu = cpu;
 
@@ -6023,13 +6025,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu, sd_flag);
+		group = find_idlest_group(sd, p, cpu, sd_flag, cpus);
+
 		if (!group) {
 			sd = sd->child;
 			continue;
 		}
 
-		new_cpu = find_idlest_group_cpu(group, p, cpu);
+		new_cpu = find_idlest_group_cpu(group, p, cpu, cpus);
 		if (new_cpu == cpu) {
 			/* Now try balancing at a lower domain level of 'cpu': */
 			sd = sd->child;
@@ -6104,6 +6107,27 @@ void __update_idle_core(struct rq *rq)
 	rcu_read_unlock();
 }
 
+static inline int
+scan_cpu_mask_for_idle_cores(struct cpumask *cpus, int target)
+{
+	int core, cpu;
+
+	for_each_cpu_wrap(core, cpus, target) {
+		bool idle = true;
+
+		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			cpumask_clear_cpu(cpu, cpus);
+			if (!idle_cpu(cpu))
+				idle = false;
+		}
+
+		if (idle)
+			return core;
+	}
+
+	return -1;
+}
+
 /*
  * Scan the entire LLC domain for idle cores; this dynamically switches off if
  * there are no idle cores left in the system; tracked through
@@ -6112,7 +6136,7 @@ void __update_idle_core(struct rq *rq)
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int core, cpu;
+	int core;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -6120,21 +6144,22 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	if (!test_idle_cores(target, false))
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
+	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_preferred);
+	core = scan_cpu_mask_for_idle_cores(cpus, target);
 
-	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
+	if (core >= 0)
+		return core;
 
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			__cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
-				idle = false;
-		}
+	if (!p->affinity_unequal)
+		goto out;
 
-		if (idle)
-			return core;
-	}
+	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
+	cpumask_andnot(cpus, cpus, &p->cpus_preferred);
+	core = scan_cpu_mask_for_idle_cores(cpus, target);
 
+	if (core >= 0)
+		return core;
+out:
 	/*
 	 * Failed to find an idle core; stop looking for one.
 	 */
@@ -6143,24 +6168,40 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	return -1;
 }
 
+static inline int
+scan_cpu_mask_for_idle_smt(struct cpumask *cpus, int target)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		if (!cpumask_test_cpu(cpu, cpus))
+			continue;
+		if (idle_cpu(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
 /*
  * Scan the local SMT mask for idle CPUs.
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
 
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
-		if (available_idle_cpu(cpu))
-			return cpu;
-	}
+	cpu = scan_cpu_mask_for_idle_smt(&p->cpus_preferred, target);
 
-	return -1;
+	if (cpu >= 0 || !p->affinity_unequal)
+		return cpu;
+
+	cpumask_andnot(cpus, &p->cpus_allowed, &p->cpus_preferred);
+
+	return scan_cpu_mask_for_idle_smt(cpus, target);
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -6177,6 +6218,24 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 
 #endif /* CONFIG_SCHED_SMT */
 
+static inline int
+scan_cpu_mask_for_idle_cpu(struct cpumask *cpus, int target,
+			   struct sched_domain *sd, int *nr)
+{
+	int cpu;
+
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+		if (!--(*nr))
+			return -1;
+		if (!cpumask_test_cpu(cpu, cpus))
+			continue;
+		if (available_idle_cpu(cpu))
+			break;
+	}
+
+	return cpu;
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6185,10 +6244,11 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct sched_domain *this_sd;
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, nr = INT_MAX, nr_begin;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6212,16 +6272,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			nr = 4;
 	}
 
+	nr_begin = nr;
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
-		if (!--nr)
-			return -1;
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
-		if (available_idle_cpu(cpu))
-			break;
-	}
+	cpu = scan_cpu_mask_for_idle_cpu(&p->cpus_preferred, target, sd, &nr);
+
+	if (!nr || !p->affinity_unequal || cpu != target || nr >= nr_begin - 1)
+		goto out;
+
+	cpumask_andnot(cpus, &p->cpus_allowed, &p->cpus_preferred);
+
+	cpu = scan_cpu_mask_for_idle_cpu(cpus, target, sd, &nr);
+out:
 
 	time = local_clock() - time;
 	cost = this_sd->avg_scan_cost;
@@ -6677,6 +6739,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	struct cpumask *cpus = &p->cpus_preferred;
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
@@ -6689,7 +6752,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		}
 
 		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
-			      cpumask_test_cpu(cpu, &p->cpus_allowed);
+			      cpumask_test_cpu(cpu, cpus);
 	}
 
 	rcu_read_lock();
@@ -6718,7 +6781,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	if (unlikely(sd)) {
 		/* Slow path */
-		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag, cpus);
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
 
-- 
2.9.3

