Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD0FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99FB2342B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzMQSCQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfH3R67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:58:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34742 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3R67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:58:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHtAwa101451;
        Fri, 30 Aug 2019 17:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=9Wemge0RcmvnUsm0W5wu0Dr6YJPAmuaEVvIIaiA/fIo=;
 b=PzMQSCQbH8ep8HL4bItrtKKaSC1zwTs1jJ48UmgBO2ipfeNZHA7D6G8IXWXR0VK/Oeh8
 Fcog1R9T7nHYDXbu3dqysVa7b34rc1joj0EwJPxfu334uwVZhVMwzb/R3iF89k7qvY/O
 Z2/HUcjDuTqdU5LaqBxUfo+qGwK13bCVviO5KcGuuvuyAk2oI8CS2B5AEdgZ+OipFTDh
 kcyEH3cuR3gWvy4S+Z9IqjVlB8dCoEokDcpkST8qpH8jITNMQ4jiOJEnXrVVhi64wMqx
 nnN3zy57hg/8Z753vCbn8jhYSdpe2LsAxpr+00wU3CziO/jiKx0jdsQ21B9G2FICSbIy mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uq8me80p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:57:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrA8C047245;
        Fri, 30 Aug 2019 17:54:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2upkrgnsft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHsaax014855;
        Fri, 30 Aug 2019 17:54:36 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:36 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 6/9] x86/smpboot: Optimize cpumask_weight_sibling macro for x86
Date:   Fri, 30 Aug 2019 10:49:41 -0700
Message-Id: <20190830174944.21741-7-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=983
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use per-CPU variable for cpumask_weight_sibling macro in case of x86 for
fast lookup in select_idle_cpu. This avoids reading multiple cache lines
in case of systems with large numbers of CPUs where bitmask can span
multiple cache lines. Even if bitmask spans only one cache line this avoids
looping through it to find the number of bits and gets it in O(1).

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

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
index 362dd89..57ad88d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -85,6 +85,9 @@
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 
+/* representing number of HT siblings of each CPU */
+DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpumask_weight_sibling);
+
 /* representing HT and core siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
@@ -520,6 +523,8 @@ void set_cpu_sibling_map(int cpu)
 
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
+		per_cpu(cpumask_weight_sibling, cpu) =
+		    cpumask_weight(topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		c->booted_cores = 1;
@@ -529,8 +534,13 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_smt && match_smt(c, o)))
+		if ((i == cpu) || (has_smt && match_smt(c, o))) {
 			link_mask(topology_sibling_cpumask, cpu, i);
+			per_cpu(cpumask_weight_sibling, cpu) =
+			    cpumask_weight(topology_sibling_cpumask(cpu));
+			per_cpu(cpumask_weight_sibling, i) =
+			    cpumask_weight(topology_sibling_cpumask(i));
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
-- 
2.9.3

