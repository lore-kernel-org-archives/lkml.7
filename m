Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C3C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD93E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfHZMQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:16:53 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51962 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731810AbfHZMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:16:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=liangyan.peng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TaW1GMf_1566821793;
Received: from localhost(mailfrom:liangyan.peng@linux.alibaba.com fp:SMTPD_---0TaW1GMf_1566821793)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 20:16:41 +0800
From:   Liangyan <liangyan.peng@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: [PATCH v3] sched/fair: don't assign runtime for throttled cfs_rq
Date:   Mon, 26 Aug 2019 20:16:33 +0800
Message-Id: <20190826121633.6538-1-liangyan.peng@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sched_cfs_period_timer() will refill cfs_b runtime and call
distribute_cfs_runtime to unthrottle cfs_rq, sometimes cfs_b->runtime
will allocate all quota to one cfs_rq incorrectly, then other cfs_rqs
attached to this cfs_b can't get runtime and will be throttled.

We find that one throttled cfs_rq has non-negative
cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
in snippet: distribute_cfs_runtime() {
runtime = -cfs_rq->runtime_remaining + 1; }.
The runtime here will change to a large number and consume all
cfs_b->runtime in this cfs_b period.

According to Ben Segall, the throttled cfs_rq can have
account_cfs_rq_runtime called on it because it is throttled before
idle_balance, and the idle_balance calls update_rq_clock to add time
that is accounted to the task.

This commit prevents cfs_rq to be assgined new runtime if it has been
throttled until that distribute_cfs_runtime is called.

Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..500f5db0de0b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4470,6 +4470,8 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
+	if (cfs_rq->throttled)
+		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
@@ -4673,6 +4675,9 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
+		/* By the above check, this should never be true */
+		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
+
 		runtime = -cfs_rq->runtime_remaining + 1;
 		if (runtime > remaining)
 			runtime = remaining;
-- 
2.14.4.44.g2045bb6

