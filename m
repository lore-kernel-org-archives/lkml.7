Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26560C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBFC21726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r5eThZKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfF0BfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:35:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF0BfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:35:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1Y7f9126686;
        Thu, 27 Jun 2019 01:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=a9xr0ftUygGbe17n4LV66UNhDktetQVNmeRiOg3colM=;
 b=r5eThZKJiCb2FqA1NijJ4sdwbkeLoMrSLtV/3ZYr+7junX54Jf75FdKxfkWZdEbXQud9
 B/yzr7OZ/zkiydLAJ+NNFUXog6nMmi7VyC+FuzYb+8ETuLnumqzBHCGE/fqRiwFz+rHt
 XecyNtmPlSzRmNMpgxATTvKuedxEo07UVbuy3Wd0DVuuV8S/ci0g9WUzPZQ3Va6WyoAF
 DvvagwUOBwgkg+xZt9q1SCXVArbGwQYzF/ZMH7a7Wa6xjQ6V6cdgAs3MK7mBW4bWYK/r
 BMjdxHYckLAeA/zqUF0p3AIFtfE99iA7OX39+ImNuHu+Dwtx7ha/KgLPwdH7K0Qz2Shh qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pwdky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R1Xuru160444;
        Thu, 27 Jun 2019 01:34:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t99f4rpma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 01:34:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R1YR5r005643;
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
Subject: [PATCH v3 2/7] sched: introduce per-cpu var next_cpu to track search limit
Date:   Wed, 26 Jun 2019 18:29:14 -0700
Message-Id: <20190627012919.4341-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270017
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

