Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BFC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C8D27B7F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFCEoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 00:44:46 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54993 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfFCEop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:44:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=liangyan.peng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTGZFi2_1559537059;
Received: from localhost(mailfrom:liangyan.peng@linux.alibaba.com fp:SMTPD_---0TTGZFi2_1559537059)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Jun 2019 12:44:27 +0800
From:   Liangyan <liangyan.peng@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     yun.wang@linux.alibaba.com, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com,
        "liangyan.ply" <liangyan.ply@linux.alibaba.com>,
        Liangyan <liangyan.peng@linux.alibaba.com>
Subject: [PATCH] sched/fair: don't restart enqueued cfs quota slack timer
Date:   Mon,  3 Jun 2019 12:43:09 +0800
Message-Id: <20190603044309.168065-1-liangyan.peng@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "liangyan.ply" <liangyan.ply@linux.alibaba.com>

start_cfs_slack_bandwidth() will restart the quota slack timer,
if it is called frequently, this timer will be restarted continuously
and may have no chance to expire to unthrottle cfs tasks.
This will cause that the throttled tasks can't be unthrottled in time
although they have remaining quota.

Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d90a64620072..fdb03c752f97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4411,9 +4411,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (runtime_refresh_within(cfs_b, min_left))
 		return;
 
-	hrtimer_start(&cfs_b->slack_timer,
+	if (!hrtimer_active(&cfs_b->slack_timer)) {
+		hrtimer_start(&cfs_b->slack_timer,
 			ns_to_ktime(cfs_bandwidth_slack_period),
 			HRTIMER_MODE_REL);
+	}
 }
 
 /* we know any runtime found here is valid as update_curr() precedes return */
-- 
2.14.4.44.g2045bb6

