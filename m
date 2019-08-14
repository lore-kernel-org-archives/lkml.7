Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEAC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4172F214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfHNSA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:00:57 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52928 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfHNSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:00:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=liangyan.peng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TZUYsGz_1565805622;
Received: from localhost(mailfrom:liangyan.peng@linux.alibaba.com fp:SMTPD_---0TZUYsGz_1565805622)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 02:00:54 +0800
From:   Liangyan <liangyan.peng@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
Date:   Thu, 15 Aug 2019 02:00:21 +0800
Message-Id: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sched_cfs_period_timer() will refill cfs_b runtime and call
distribute_cfs_runtime() to unthrottle cfs_rq, sometimes cfs_b->runtime
will allocate all quota to one cfs_rq incorrectly.
This will cause other cfs_rq can't get runtime and will be throttled.
We find that one throttled cfs_rq has non-negative
cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
in snippet: distribute_cfs_runtime() {
runtime = -cfs_rq->runtime_remaining + 1; }.
This cast will cause that runtime will be a large number and
cfs_b->runtime will be subtracted to be zero at last.

This commit prevents cfs_rq to be assgined new runtime if it has been
throttled to avoid the above incorrect type cast.

Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81fd8a2a605b..b14d67d28138 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4068,6 +4068,8 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
+	if (cfs_rq->throttled)
+		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
-- 
2.14.4.44.g2045bb6

