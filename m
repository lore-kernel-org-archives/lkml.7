Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE7C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF02342B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hRAHlA+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3Rzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:55:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfH3Rzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:55:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHt6PD088735;
        Fri, 30 Aug 2019 17:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=wAuaqsNTYu9PLpGsR9PztanzZXV9e3lo4XXN0aBZ7ak=;
 b=hRAHlA+GNBi6Flv1rXd9eR+sCusOVFNJveXPZXWPKKNjyFckv84qXx+3FXkNl7q4qrps
 hQWfQsP2nUte9wgn3kpfuocRoqJ+Z1NUKjeYMjhP+JPPqz+pk/PjXYaAig/028asw6VC
 8R9ujkLD2dVz5zU48Av00W3BOBgvlKDNQ2WgYz+Nk0iVMYMVP1L0yJQUDmDM4pxUr7MA
 SAKfj10xIxmhRnEr9iBbDzoINb6VwJUGNbEb2WV4Mqsn9/zPjU6UBxCiX7cul+4CRJV8
 tooWuxsWQVqP4oAn1x3aYN7YVeZOmaaqFSt8AEMr2EVx7cIrGCD74CvbXnng+PMeB+AQ IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uq8fsg20y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:55:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrrnH072175;
        Fri, 30 Aug 2019 17:54:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2upc8xrmea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHsXMU014831;
        Fri, 30 Aug 2019 17:54:33 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:33 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 2/9] sched: add search limit as per latency-nice
Date:   Fri, 30 Aug 2019 10:49:37 -0700
Message-Id: <20190830174944.21741-3-subhra.mazumdar@oracle.com>
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
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put upper and lower limit on CPU search in select_idle_cpu. The lower limit
is set to amount of CPUs in a core  while upper limit is derived from the
latency-nice of the thread. This ensures for any architecture we will
usually search beyond a core. Changing the latency-nice value by user will
change the search cost making it appropriate for given workload.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b08d00c..c31082d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, floor, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6205,11 +6205,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	if (sched_feat(SIS_PROP)) {
-		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+		floor = cpumask_weight(topology_sibling_cpumask(target));
+		if (floor < 2)
+			floor = 2;
+		nr = (p->latency_nice * sd->span_weight) / LATENCY_NICE_MAX;
+		if (nr < floor)
+			nr = floor;
 	}
 
 	time = local_clock();
-- 
2.9.3

