Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FADC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5876F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfEONxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:53:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbfEONxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:53:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDquhK123722
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:53:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgjv0csbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:53:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrjOD49414252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FEB52052;
        Wed, 15 May 2019 13:53:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B9D8E52050;
        Wed, 15 May 2019 13:53:42 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 4/6] sched/fair: Define core capacity to limit task packing
Date:   Wed, 15 May 2019 19:23:20 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-0016-0000-0000-0000027C033A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0017-0000-0000-000032D8D3F7
Message-Id: <20190515135322.19393-5-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task packing on a core needs to be bounded based on its capacity. This
patch defines a new method which acts as a tipping point for task packing.

The Core capacity is the method which limits task packing above certain
point. In general, the capacity of a core is defined to be the aggregated
sum of all the CPUs in the Core.

Some architectures does not have core capacity linearly increasing with the
number of threads( or CPUs) in the core. For such cases, architecture
specific calculations needs to be done to find core capacity.

The `arch_scale_core_capacity` is currently tuned for `powerpc` arch by
scaling capacity w.r.t to the number of online SMT in the core.

The patch provides default handler for other architecture by scaling core
capacity w.r.t. to the capacity of all the threads in the core.

ToDo: SMT mode is calculated each time a jitter task wakes up leading to
redundant decision time which can be eliminated by keeping track of online
CPUs during hotplug task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  4 ++++
 arch/powerpc/kernel/smp.c           | 32 +++++++++++++++++++++++++++++
 kernel/sched/fair.c                 | 19 +++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b01c3df..1c777ee67180 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,10 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+#define arch_scale_core_capacity	powerpc_scale_core_capacity
+
+unsigned long powerpc_scale_core_capacity(int first_smt,
+					  unsigned long smt_cap);
 
 int dlpar_cpu_readd(int cpu);
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e784342bdaa1..256ab2a50f6e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1173,6 +1173,38 @@ static void remove_cpu_from_masks(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Calculate capacity of a core based on the active threads in the core
+ * Scale the capacity of first SM-thread based on total number of
+ * active threads in the respective smt_mask.
+ *
+ * The scaling is done such that for
+ * SMT-4, core_capacity = 1.5x first_cpu_capacity
+ * and for SMT-8, core_capacity multiplication factor is 2x
+ *
+ * So, core_capacity multiplication factor = (1 + smt_mode*0.125)
+ *
+ * @first_cpu: First/any CPU id in the core
+ * @cap: Capacity of the first_cpu
+ */
+inline unsigned long powerpc_scale_core_capacity(int first_cpu,
+		unsigned long cap) {
+	struct cpumask select_idles;
+	struct cpumask *cpus = &select_idles;
+	int cpu, smt_mode = 0;
+
+	cpumask_and(cpus, cpu_smt_mask(first_cpu), cpu_online_mask);
+
+	/* Find SMT mode from active SM-threads */
+	for_each_cpu(cpu, cpus)
+		smt_mode++;
+
+	/* Scale core capacity based on smt mode */
+	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
+}
+#endif
+
 static inline void add_cpu_to_smallcore_masks(int cpu)
 {
 	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b7eea9dc4644..2578e6bdf85b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6231,6 +6231,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#ifdef CONFIG_SCHED_SMT
+
+#ifndef arch_scale_core_capacity
+static inline unsigned long arch_scale_core_capacity(int first_thread,
+						     unsigned long smt_cap)
+{
+	/* Default capacity of core is sum of cap of all the threads */
+	unsigned long ret = 0;
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(first_thread))
+		ret += cpu_rq(sibling)->cpu_capacity;
+
+	return ret;
+}
+#endif
+
+#endif
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-- 
2.17.1

