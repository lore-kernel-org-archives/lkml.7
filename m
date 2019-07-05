Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C34C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A530C21721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGEEiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:38:50 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:49102 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEEit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:38:49 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 0161A50E364A3B65FA7B;
        Fri,  5 Jul 2019 12:38:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x654c6d6013878;
        Fri, 5 Jul 2019 12:38:06 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070512384263-2103364 ;
          Fri, 5 Jul 2019 12:38:42 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH v2] sched: fix unlikely use of sched_info_on()
Date:   Fri, 5 Jul 2019 12:35:07 +0800
Message-Id: <1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-05 12:38:42,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-05 12:38:12,
        Serialize complete at 2019-07-05 12:38:12
X-MAIL: mse-fl2.zte.com.cn x654c6d6013878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_info_on() is called with unlikely hint, however, the test
is to be a constant(1) on which compiler will do nothing when
make defconfig, so remove the hint.

Also, fix a lack of {}.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v2: remove the hint rather than replace with likely, and fix a
coding style.

 kernel/sched/stats.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index aa0de24..ba683fe 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -157,9 +157,10 @@ static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t)
 {
 	unsigned long long now = rq_clock(rq), delta = 0;
 
-	if (unlikely(sched_info_on()))
+	if (sched_info_on()) {
 		if (t->sched_info.last_queued)
 			delta = now - t->sched_info.last_queued;
+	}
 	sched_info_reset_dequeued(t);
 	t->sched_info.run_delay += delta;
 
@@ -192,7 +193,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
  */
 static inline void sched_info_queued(struct rq *rq, struct task_struct *t)
 {
-	if (unlikely(sched_info_on())) {
+	if (sched_info_on()) {
 		if (!t->sched_info.last_queued)
 			t->sched_info.last_queued = rq_clock(rq);
 	}
@@ -239,7 +240,7 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 static inline void
 sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	if (unlikely(sched_info_on()))
+	if (sched_info_on())
 		__sched_info_switch(rq, prev, next);
 }
 
-- 
1.8.3.1

