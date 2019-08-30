Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5794CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E69720659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FspEGmsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3Rzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:55:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfH3Rzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:55:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHt6W8088827;
        Fri, 30 Aug 2019 17:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Q2qdMLRHecPiIPN2E6gdWBN0ht98T6Ymkz5bYq0/bUI=;
 b=FspEGmsDlvgpXNRFrK5TYCtR7IGQakBPDUWLpO7nfF/KitJK4rN/YMnIyHLLHNZMFqUr
 ozD1sV13Lc+Mf5KLDNNPqbnR3gzJSit1mfQNV6AvFEv0Rt5s6rRE25UAJOBYdCLVPTb2
 XPTxXOQ6tKpVBtKH22vkgPyhEnjIfRjeW7SblCOW2Bp7fconEv3ev+nXFf1v9UYt4ElF
 1YSLjW1u9XVAS3UezG8ZZNdN3Z+wRX95MtTm+dNR4wzQCZv/wsSKUfdj+GYzns25kmwB
 wy8fqabpU25m0fZ5mYxkd8adx5q6BOXjkHvVzJ5uznvT6HJ2QY9gy25M9g2qu4q09fnU vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uq8fsg22m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:55:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrA86047224;
        Fri, 30 Aug 2019 17:54:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2upkrgnshy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHsbdb014864;
        Fri, 30 Aug 2019 17:54:38 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:37 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 8/9] sched: introduce per-cpu var next_cpu to track search limit
Date:   Fri, 30 Aug 2019 10:49:43 -0700
Message-Id: <20190830174944.21741-9-subhra.mazumdar@oracle.com>
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
index 47969bc..5862d54 100644
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
index 365c928..cca2b09 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1002,6 +1002,7 @@ static inline void update_idle_core(struct rq *rq) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
-- 
2.9.3

