Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937E3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638AF21726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4SVzbI3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfF0BgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:36:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfF0BgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:36:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1YCMA126699;
        Thu, 27 Jun 2019 01:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=VbEHN/1QClutR//aKQqhr92z0vYm5E31Frkb2yISumQ=;
 b=4SVzbI3PTa1d6ZtlFfzdq4OpRoH2mHBNiIw0hMRwLYbMRulF1Sv4kFxVEz4Mqk5ul5Wh
 scNu+UQWDFFnPX/s48GKmbZAApR7LdNtj2faItRNnnm7RK2ZsZJSrcxncZs6ykWWUWU5
 v/I1/bDecj9v7tsuXgu8fvxk77RHH/+JvngbIrrcwUCMv4WWmkK1Aqie7+zOoieI+sDQ
 d2TT50e3rvIpK2C2n702urOjlpTSL8LkZ7fM6Tn2YS+LEBXVYGLizjcQpC3700VzIcUC
 IQYr+8wHF3zrjogQQU4Xr2RDTYy76U9JUcgAKPrnd7RQTo6kkaUe7OC1jcR5O4jpNjQe 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9pwdm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1Wovm158183;
        Thu, 27 Jun 2019 01:34:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6v2sey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R1YQV0009358;
        Thu, 27 Jun 2019 01:34:26 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 18:34:26 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [PATCH v3 1/7] sched: limit cpu search in select_idle_cpu
Date:   Wed, 26 Jun 2019 18:29:13 -0700
Message-Id: <20190627012919.4341-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put upper and lower limit on cpu search of select_idle_cpu. The lower limit
is amount of cpus in a core while upper limit is twice that. This ensures
for any architecture we will usually search beyond a core. The upper limit
also helps in keeping the search cost low and constant.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..b58f08f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, limit, floor, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6206,10 +6206,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		floor = cpumask_weight(topology_sibling_cpumask(target));
+		if (floor < 2)
+			floor = 2;
+		limit = floor << 1;
+		if (span_avg > floor*avg_cost) {
 			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+			if (nr > limit)
+				nr = limit;
+		} else {
+			nr = floor;
+		}
 	}
 
 	time = local_clock();
-- 
2.9.3

