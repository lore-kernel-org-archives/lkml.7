Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09991C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99420840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfGYHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729584AbfGYHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:09:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P76YKb089283
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:09:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty520ep8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:09:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 25 Jul 2019 08:09:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 08:09:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P79Erh34603108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 07:09:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C8144C046;
        Thu, 25 Jul 2019 07:09:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBFD44C040;
        Thu, 25 Jul 2019 07:09:12 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.169])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 07:09:12 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: [RFC v4 8/8] powerpc: Set turbo domain to NUMA node for task packing
Date:   Thu, 25 Jul 2019 12:38:57 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725070857.6639-1-parth@linux.ibm.com>
References: <20190725070857.6639-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072507-0012-0000-0000-00000335FA98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072507-0013-0000-0000-0000216F910F
Message-Id: <20190725070857.6639-9-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an powerpc architecture specific implementation for
defining the turbo domain to make searching of the core to be bound within
the NUMA.  This provides a way to decrease the searching time for specific
architectures where we know the domain for the power budget.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 arch/powerpc/kernel/smp.c           | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 1c777ee67180..410b94c9e1a2 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -133,10 +133,13 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
 #define arch_scale_core_capacity	powerpc_scale_core_capacity
+#define arch_turbo_domain		powerpc_turbo_domain
 
 unsigned long powerpc_scale_core_capacity(int first_smt,
 					  unsigned long smt_cap);
 
+struct cpumask *powerpc_turbo_domain(int cpu);
+
 int dlpar_cpu_readd(int cpu);
 #endif
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 149a3fbf8ed3..856f7233190e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1200,6 +1200,11 @@ unsigned long powerpc_scale_core_capacity(int first_cpu,
 	/* Scale core capacity based on smt mode */
 	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
 }
+
+inline struct cpumask *powerpc_turbo_domain(int cpu)
+{
+	return cpumask_of_node(cpu_to_node(cpu));
+}
 #endif
 
 static inline void add_cpu_to_smallcore_masks(int cpu)
-- 
2.17.1

