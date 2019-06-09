Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D483C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78C5214C6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3IF36AOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfFIBzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:55:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfFIBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:55:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sPXL030735;
        Sun, 9 Jun 2019 01:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Tct/r78PzAI1Nw33grKOwsL1YAYVa9bkSMicZSxpV80=;
 b=3IF36AOHrFtJBtxlz+7tjE9oeJxfjQmdFoTKKDZ3Tb6f8QtBIPZHZX8/dt6xpamj+3jq
 yJpplKIvkAnz95GMArc8mOtSIyvuhW58mHwTnDIEGVl4wZZe2Z2Zc2nUAbW168fca3wg
 6NMYTiNFRwJbHsb1w6m8TzxJYzLTNfcGeYIPbbWrPmQipslJRQ7tmuoJ2a7gdJElvU/R
 69Y60jT6Gglj+H4edFIa/v+yji6JTyrBTj4ULIm4CzFVteK/3QIurCCIYwuOYZrQSTsp
 qM8Mcs9BoUdzcPCQKNhIqcNb2DW31oxUFEsMprC/1stBVQR+OxNO7fv+QELmZ4OUSOsm iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nqa0mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591rAUx026301;
        Sun, 9 Jun 2019 01:54:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t024tcfmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x591sgTv030487;
        Sun, 9 Jun 2019 01:54:42 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:42 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 7/7] sched: use per-cpu variable cpumask_weight_sibling
Date:   Sat,  8 Jun 2019 18:49:54 -0700
Message-Id: <20190609014954.1033-8-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
References: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=764
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906090012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=806 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906090013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use per-cpu var cpumask_weight_sibling for quick lookup in select_idle_cpu.
This is the fast path of scheduler and every cycle is worth saving. Usage
of cpumask_weight can result in iterations.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a74808..878f11c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6206,7 +6206,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		floor = cpumask_weight(topology_sibling_cpumask(target));
+		floor = topology_sibling_weight(target);
 		if (floor < 2)
 			floor = 2;
 		limit = floor << 1;
-- 
2.9.3

