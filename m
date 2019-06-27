Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4EC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6221882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cMK89/vD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfF0BfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:35:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF0BfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:35:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1YVOj126968;
        Thu, 27 Jun 2019 01:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=x+M0Mv5Zb9UXiRYfxKM6z9oZmTfxBCdsXIjXQ8gVKSc=;
 b=cMK89/vDK+iJSBobMebhV6kATak9oM4LlA4o2JRVhOrKeSJ8vnsyEYYdsnodlPvH9G4E
 nE9HUXfTMD84Hdja9SA6U8JPvs7Z9+WlQgen8A0l5fO223qhJji0WwFWWoZsOQxY4SQ9
 xgeiUGYhGIWwSoUOg6zhlubTRpmsP3RrrqqUex56qCh8FRXTkEcylUClrvuyrSo2yq2P
 5kxJfUphdi7rJLw8P5WudZnQq/SbLiFie4SDuU3hCKM1ffml9zUvxe7SAt/taIcbaZ/h
 r6qUHZgBjOB1aRScyKHPB49+Ap0rzpZlkFq4x2bnnrVOQOI2gHe2MzR16ZUJ8lwp7poa dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pwdm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1Y9XO018162;
        Thu, 27 Jun 2019 01:34:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7d4a3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R1YR8N007567;
        Thu, 27 Jun 2019 01:34:27 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 18:34:27 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [PATCH v3 3/7] sched: rotate the cpu search window for better spread
Date:   Wed, 26 Jun 2019 18:29:15 -0700
Message-Id: <20190627012919.4341-4-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=905 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rotate the cpu search window for better spread of threads. This will ensure
an idle cpu will quickly be found if one exists.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b58f08f..c1ca88e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, limit, floor, nr = INT_MAX;
+	int cpu, limit, floor, target_tmp, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6219,9 +6219,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		}
 	}
 
+	if (per_cpu(next_cpu, target) != -1)
+		target_tmp = per_cpu(next_cpu, target);
+	else
+		target_tmp = target;
+
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
+		per_cpu(next_cpu, target) = cpu;
 		if (!--nr)
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-- 
2.9.3

