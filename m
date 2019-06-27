Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF5C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7B421726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfF0BeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:34:02 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:44400 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfF0BeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:34:02 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id F12E77F48397E624B942;
        Thu, 27 Jun 2019 09:33:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x5R1XKP8032512;
        Thu, 27 Jun 2019 09:33:20 +0800 (GMT-8)
        (envelope-from ran.xiaokai@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019062709334724-1749299 ;
          Thu, 27 Jun 2019 09:33:47 +0800 
From:   Ran Xiaokai <ran.xiaokai@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] sched/rt: Remove unnecessary (!rt_rq->tg) check
Date:   Thu, 27 Jun 2019 09:30:58 +0800
Message-Id: <1561599058-11857-1-git-send-email-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-06-27 09:33:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-06-27 09:33:25,
        Serialize complete at 2019-06-27 09:33:25
X-MAIL: mse-fl2.zte.com.cn x5R1XKP8032512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if CONFIG_RT_GROUP_SCHED is configured, every rt_rq belongs to
a certain task_group. Even top rt_rq belongs to root_task_group.
So NULL check in sched_rt_runtime() is unnecessary.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/sched/rt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1e6b909dca36..803e8b86c6f5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -436,16 +436,13 @@ static inline int on_rt_rq(struct sched_rt_entity *rt_se)
 	return rt_se->on_rq;
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
-
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
 {
-	if (!rt_rq->tg)
-		return RUNTIME_INF;
-
 	return rt_rq->rt_runtime;
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+
 static inline u64 sched_rt_period(struct rt_rq *rt_rq)
 {
 	return ktime_to_ns(rt_rq->tg->rt_bandwidth.rt_period);
@@ -561,11 +558,6 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 
 #else /* !CONFIG_RT_GROUP_SCHED */
 
-static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_runtime;
-}
-
 static inline u64 sched_rt_period(struct rt_rq *rt_rq)
 {
 	return ktime_to_ns(def_rt_bandwidth.rt_period);
-- 
2.15.2

