Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD03C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0710420659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGHEyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:54:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728184AbfGHEym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:54:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x684q59b140485
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 00:54:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tkrgj98rj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 00:54:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 8 Jul 2019 05:54:39 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 05:54:37 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x684saJc30802290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 04:54:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC944C046;
        Mon,  8 Jul 2019 04:54:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A1F4C044;
        Mon,  8 Jul 2019 04:54:35 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.94])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 04:54:35 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        subhra.mazumdar@oracle.com
Subject: [RFC 2/2] sched/fair: Optimize the idle CPU search
Date:   Mon,  8 Jul 2019 10:24:32 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708045432.18774-1-parth@linux.ibm.com>
References: <20190708045432.18774-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19070804-0012-0000-0000-000003302CE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070804-0013-0000-0000-000021698C2E
Message-Id: <20190708045432.18774-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize idle CPUs search by marking already found non idle CPUs during
idle core search. This reduces iteration count when searching for idle
CPUs, resulting in the lower iteration count.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c |  3 +++
 kernel/sched/fair.c | 13 +++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5a6bdc956c8..196e4eaca66e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5951,6 +5951,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, iterator_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 void __init sched_init(void)
 {
@@ -5991,6 +5992,8 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(iterator_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20affe03379d..2b70b94b3e66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5295,6 +5295,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, iterator_mask);
+DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
@@ -6084,6 +6085,7 @@ void __update_idle_core(struct rq *rq)
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(iterator_mask);
+	struct cpumask *idle_cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
@@ -6099,8 +6101,10 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			__cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
+			if (!available_idle_cpu(cpu)) {
 				idle = false;
+				__cpumask_clear_cpu(cpu, idle_cpus);
+			}
 		}
 
 		if (idle)
@@ -6161,6 +6165,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 time, cost;
 	s64 delta;
 	int cpu, nr = INT_MAX;
+	struct cpumask *idle_cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6186,11 +6191,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	for_each_cpu_wrap(cpu, idle_cpus, target) {
 		if (!--nr)
 			return -1;
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
 		if (available_idle_cpu(cpu))
 			break;
 	}
@@ -6210,6 +6213,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
+	struct cpumask *idle_cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 
 	if (available_idle_cpu(target))
 		return target;
@@ -6239,6 +6243,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	cpumask_and(idle_cpus, sched_domain_span(sd), &p->cpus_allowed);
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
-- 
2.17.1

