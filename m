Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFCBC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1152B216F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ah0T2vhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfFIBz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:55:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfFIBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:55:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sPBO022907;
        Sun, 9 Jun 2019 01:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=a9xr0ftUygGbe17n4LV66UNhDktetQVNmeRiOg3colM=;
 b=Ah0T2vhGXa9zgTbrmAjvdtjnBZ83Zh7/mlYE2UipD1SBZwHTBSbG5qyW5+/A40Pjsyge
 +IrtEVq8gFp8AsHjd6UiyUFDcJO+QyByXcv2HQDZh2Cp0z6AH+r6EQIzXI65/e0oK2ci
 iLu17e9RTZtr7oa28VAHTloyXVIi5XHjPixDeauI3MCafYV1XY4LxsU6SVsJfcEwkf5j
 jvYG7fv/5uQiAedN9MqIicNV3G5Xixh+YJbyUVGTWZJ1PF3y1jNCJ3soqptGhukknQEa
 qe4xrFmvEXbmVTZ1PP9AU9QEJemZrnQofJKD3xzEAxBTuEysdSE5GVl+64i3s+F9237x sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t04eta46u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591rSVS026593;
        Sun, 9 Jun 2019 01:54:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t024tcfmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x591sdLl009408;
        Sun, 9 Jun 2019 01:54:40 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:39 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 2/7] sched: introduce per-cpu var next_cpu to track search limit
Date:   Sat,  8 Jun 2019 18:49:49 -0700
Message-Id: <20190609014954.1033-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
References: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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

Introduce a per-cpu variable to track the limit upto which idle cpu search
was done in select_idle_cpu(). This will help to start the search next time
from there. This is necessary for rotating the search window over entire
LLC domain.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/core.c  | 2 ++
 kernel/sched/sched.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427..80657fc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -24,6 +24,7 @@
 #include <trace/events/sched.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
@@ -5966,6 +5967,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		struct rq *rq;
 
+		per_cpu(next_cpu, i) = -1;
 		rq = cpu_rq(i);
 		raw_spin_lock_init(&rq->lock);
 		rq->nr_running = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..4cecfa2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -994,6 +994,7 @@ static inline void update_idle_core(struct rq *rq) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
-- 
2.9.3

