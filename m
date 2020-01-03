Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8569C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4621D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgACLpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:45:40 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33722 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgACLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:45:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TmjSZUt_1578051936;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0TmjSZUt_1578051936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 19:45:36 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@linux.alibaba.com>
Subject: [PATCH] sched/fair: calculate delta runnable load only when it's needed
Date:   Fri,  3 Jan 2020 19:44:00 +0800
Message-Id: <20200103114400.17668-1-rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code of calculation for delta_sum/delta_avg to where
it is really needed to be done.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba749f579714..6b7e6b528e9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3366,16 +3366,17 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 
 	runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
 	runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
-	delta_sum = runnable_load_sum - se_weight(se) * se->avg.runnable_load_sum;
-	delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
-
-	se->avg.runnable_load_sum = runnable_sum;
-	se->avg.runnable_load_avg = runnable_load_avg;
 
 	if (se->on_rq) {
+		delta_sum = runnable_load_sum -
+				se_weight(se) * se->avg.runnable_load_sum;
+		delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
 		add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
 		add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
 	}
+
+	se->avg.runnable_load_sum = runnable_sum;
+	se->avg.runnable_load_avg = runnable_load_avg;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
-- 
2.24.0

