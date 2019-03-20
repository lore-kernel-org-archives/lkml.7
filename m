Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ED02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfCTNi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:38:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbfCTNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:38:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5EA94886A6512A2182FF;
        Wed, 20 Mar 2019 21:38:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 21:38:44 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched/fair: Make sync_entity_load_avg and remove_entity_load_avg static
Date:   Wed, 20 Mar 2019 21:38:39 +0800
Message-ID: <20190320133839.21392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnigs:

kernel/sched/fair.c:3570:6: warning: symbol 'sync_entity_load_avg' was not declared. Should it be static?
kernel/sched/fair.c:3583:6: warning: symbol 'remove_entity_load_avg' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb..5c42291 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3567,7 +3567,7 @@ static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
  * Synchronize entity load avg of dequeued entity without locking
  * the previous rq.
  */
-void sync_entity_load_avg(struct sched_entity *se)
+static void sync_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	u64 last_update_time;
@@ -3580,7 +3580,7 @@ void sync_entity_load_avg(struct sched_entity *se)
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
  */
-void remove_entity_load_avg(struct sched_entity *se)
+static void remove_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	unsigned long flags;
-- 
2.7.0


