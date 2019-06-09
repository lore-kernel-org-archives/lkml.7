Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B7C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F05216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LiIQZXHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfFIBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:55:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38994 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfFIBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:55:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sjiX047014;
        Sun, 9 Jun 2019 01:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=VbEHN/1QClutR//aKQqhr92z0vYm5E31Frkb2yISumQ=;
 b=LiIQZXHvwljGFQm11jDaAbO+wgfCvhBs+aeVLOjvR5X1Fj7QXklHhO+INYPzOZ4FxJ/b
 D1X8I4frknJvKUg1QyBgijfmanyVRW0QSuuYqkVVzLRVa0nL3VsM5l60yWv5BzTwJrwn
 NRMv3D4Lm9w/BGP7onv/jjNi0NGBVmJ8hUgsFCr8Ot12xGNYdVtb/c0DX4WSjE5lIC6k
 vqT1F95s15s8csWlMbHAB5fhzaT1Fd30Qig/TxDhp0NiZxFmD1gkSvKkL6kI8KTw+KA5
 Yw/Fkn1tb6mVAMR4JHATx3tsp5kuqfTSC8htN5FLBy84xxa+T8yRAPyhxTxCjbb5yhfV qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02hea9wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sf7B108928;
        Sun, 9 Jun 2019 01:54:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t04bku22s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x591scaH024571;
        Sun, 9 Jun 2019 01:54:39 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:38 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 1/7] sched: limit cpu search in select_idle_cpu
Date:   Sat,  8 Jun 2019 18:49:48 -0700
Message-Id: <20190609014954.1033-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
References: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906090012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906090013
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

