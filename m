Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8999C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C91214C6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RiO1entq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfFIB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:56:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfFIB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:56:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591rVSk045996;
        Sun, 9 Jun 2019 01:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=M22S+yXv7CwPTWZ1zjBEwvPnuKzCuITH1o+VnT2DFaY=;
 b=RiO1entqfsJYL+pWLuyXmc9YeJ8YUlscwz48P6/SBEMgaMqShC066qoolKx0f7MYUU9l
 lnQX6XffWy9N6vcug4EWWRrQ8kTmjx4DeyB2pQM/0JI69wmXI9acV+w21uyC+KNwsQ+v
 foqnUosNz8JaCFVajANdrsyAjLoxiJZRuPI1mrq6sof9RVJePYQo9AqpnBxnZQhJmHOU
 kE3tGfEZ6XCGg1B27Fo2xbAHkIoi+ASyVpRX7zdVbtqRctlqgucgpufcDzCMKYgcPgVn
 soLGbKetqZJLpD7EWUVkkxwPs6wi37irZ9Yq6WFypDbQP8EjSS3mgmU4RwzVEc6qm4SL VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02hea9wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591siNY109034;
        Sun, 9 Jun 2019 01:54:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t04bku22q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x591sfVM009413;
        Sun, 9 Jun 2019 01:54:41 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:41 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 6/7] x86/smpboot: introduce per-cpu variable for HT siblings
Date:   Sat,  8 Jun 2019 18:49:53 -0700
Message-Id: <20190609014954.1033-7-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
References: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906090012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906090013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-cpu variable to keep the number of HT siblings of a cpu.
This will be used for quick lookup in select_idle_cpu to determine the
limits of search. This patch does it only for x86.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 17 ++++++++++++++++-
 include/linux/topology.h        |  4 ++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index da545df..1e90cbd 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -22,6 +22,7 @@ extern int smp_num_siblings;
 extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpumask_weight_sibling);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38..dd19c71 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -111,6 +111,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #ifdef CONFIG_SMP
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
+#define topology_sibling_weight(cpu)	(per_cpu(cpumask_weight_sibling, cpu))
 
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd89..20bf676 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -85,6 +85,10 @@
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 
+/* representing number of HT siblings of each CPU */
+DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpumask_weight_sibling);
+EXPORT_PER_CPU_SYMBOL(cpumask_weight_sibling);
+
 /* representing HT and core siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
@@ -520,6 +524,8 @@ void set_cpu_sibling_map(int cpu)
 
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
+		per_cpu(cpumask_weight_sibling, cpu) =
+		    cpumask_weight(topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		c->booted_cores = 1;
@@ -529,8 +535,12 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_smt && match_smt(c, o)))
+		if ((i == cpu) || (has_smt && match_smt(c, o))) {
 			link_mask(topology_sibling_cpumask, cpu, i);
+			threads = cpumask_weight(topology_sibling_cpumask(cpu));
+			per_cpu(cpumask_weight_sibling, cpu) = threads;
+			per_cpu(cpumask_weight_sibling, i) = threads;
+		}
 
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
@@ -1173,6 +1183,8 @@ static __init void disable_smp(void)
 	else
 		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
+	per_cpu(cpumask_weight_sibling, 0) =
+	    cpumask_weight(topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
 }
 
@@ -1482,6 +1494,8 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_core_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
+		per_cpu(cpumask_weight_sibling, sibling) =
+		    cpumask_weight(topology_sibling_cpumask(sibling));
 		/*/
 		 * last thread sibling in this cpu core going down
 		 */
@@ -1495,6 +1509,7 @@ static void remove_siblinginfo(int cpu)
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
+	per_cpu(cpumask_weight_sibling, cpu) = 0;
 	cpumask_clear(topology_core_cpumask(cpu));
 	c->cpu_core_id = 0;
 	c->booted_cores = 0;
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e..a85aea1 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -190,6 +190,10 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_sibling_cpumask
 #define topology_sibling_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_sibling_weight
+#define topology_sibling_weight(cpu)	\
+		cpumask_weight(topology_sibling_cpumask(cpu))
+#endif
 #ifndef topology_core_cpumask
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
-- 
2.9.3

