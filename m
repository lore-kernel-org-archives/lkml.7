Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC70C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522F523407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hznpY+JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfH3R5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:57:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60740 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3R5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:57:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHtS98101891;
        Fri, 30 Aug 2019 17:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=MKoiO8wHTekEqnX+NBdih3L3wgTlFIO7C/5rnxD7MlY=;
 b=hznpY+JQgdk3B9kxLXzaEKn+eFV7pK6pyxln3ShjIBkcuYZdA20MN61l+jX4t1Nrj8K4
 3Rxr0ci0La5NgR0YWjn83bxYE/LdUtSb1XnRhfEii1Sc+9ZQN3iwHrobPowoHdPO5OzT
 ettJpFzxCsk5AfKe4JnRoc1LIzFEyxC895H8vMQIA7vxXVykJ9aVYOfANtlF8LRbkfil
 MvxtFztXNyeBiZuQ2QUoyWCWRmCXAOIA0FU7uK3L276/lTf4eF8FzuXa/LkfWaDC2myH
 lI/WfxmLHM9t82ZIzSWoHKJzDamOO4xIOJZxKUY56PJRALORI3llD2n0CQ85g74eD1BH hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uq8me80mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:57:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrXA7135890;
        Fri, 30 Aug 2019 17:54:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uphavh0hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:37 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHsZQN014847;
        Fri, 30 Aug 2019 17:54:35 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:35 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 5/9] sched: Define macro for number of CPUs in core
Date:   Fri, 30 Aug 2019 10:49:40 -0700
Message-Id: <20190830174944.21741-6-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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

Introduce macro topology_sibling_weight for number of sibling CPUs in a
core and use in select_idle_cpu

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 include/linux/topology.h | 4 ++++
 kernel/sched/fair.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23ec9c6..8856503 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6205,7 +6205,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	if (sched_feat(SIS_PROP)) {
-		floor = cpumask_weight(topology_sibling_cpumask(target));
+		floor = topology_sibling_weight(target);
 		if (floor < 2)
 			floor = 2;
 		nr = (p->latency_nice * sd->span_weight) / LATENCY_NICE_MAX;
-- 
2.9.3

