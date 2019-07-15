Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0AC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF89420820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfGOCrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:47:45 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:35460 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGOCrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:47:45 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 10CE852413BCD4FE596A;
        Mon, 15 Jul 2019 10:47:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6F2lMco084815;
        Mon, 15 Jul 2019 10:47:22 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071510472352-2346524 ;
          Mon, 15 Jul 2019 10:47:23 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH] sched/fair: fix coccinelle warnings
Date:   Mon, 15 Jul 2019 10:45:26 +0800
Message-Id: <1563158726-43940-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-15 10:47:23,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-15 10:47:23,
        Serialize complete at 2019-07-15 10:47:23
X-MAIL: mse-fl2.zte.com.cn x6F2lMco084815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following coccinelle warning:
./kernel/sched/fair.c:8688:9-10: WARNING: return of 0/1 in function 'voluntary_active_balance' with return type bool

Return type bool instead of 0/1.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95..c44b157 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8685,7 +8685,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	struct sched_domain *sd = env->sd;
 
 	if (asym_active_balance(env))
-		return 1;
+		return true;
 
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
@@ -8697,13 +8697,13 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	    (env->src_rq->cfs.h_nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
-			return 1;
+			return true;
 	}
 
 	if (env->src_grp_type == group_misfit_task)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
1.8.3.1

