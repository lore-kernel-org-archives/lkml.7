Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D6B218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfCVObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:31:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbfCVObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:31:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2841C2B3E542ACF75D86;
        Fri, 22 Mar 2019 22:30:47 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:30:38 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched/fair: Make some functions static
Date:   Fri, 22 Mar 2019 22:30:30 +0800
Message-ID: <20190322143030.17348-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

kernel/sched/fair.c:2596:6: warning: symbol 'task_tick_numa' was not declared. Should it be static?
kernel/sched/fair.c:3570:6: warning: symbol 'sync_entity_load_avg' was not declared. Should it be static?
kernel/sched/fair.c:3583:6: warning: symbol 'remove_entity_load_avg' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb..18fb781 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2593,7 +2593,7 @@ void task_numa_work(struct callback_head *work)
 /*
  * Drive the periodic memory faults..
  */
-void task_tick_numa(struct rq *rq, struct task_struct *curr)
+static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
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


