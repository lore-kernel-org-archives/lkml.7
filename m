Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35474C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 03:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E62D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 03:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDMD0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 23:26:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfDMD0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 23:26:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65B8312948CB023D649B;
        Sat, 13 Apr 2019 11:26:41 +0800 (CST)
Received: from huawei.com (10.175.104.193) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 11:26:35 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Use 'unsigned long' for group_shares,group_runnable
Date:   Sat, 13 Apr 2019 03:32:34 +0000
Message-ID: <20190413033234.30002-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

group_share and group_runnable are tracked as 'unsigned long',
however some functions using them as 'long' which is ultimately
assigned back to 'unsigned long' variables in reweight_entity.

Since there is not scope on using a different and signed type,
this change improves code consistency and avoids further type
conversions. More important, to prevent undefined behavior
caused by overflow.

Using them as 'long' resulted in the following stack trace (on top
of v4.19.34)

==============================================================================
UBSAN: Undefined behaviour in kernel/sched/fair.c:3055:9
signed integer overflow:
1048576 * 9144968455305 cannot be represented in type 'long int'
dump_backtrace+0x0/0x338
show_stack+0x28/0x38
dump_stack+0xc8/0x100
ubsan_epilogue+0x18/0x6c
handle_overflow+0x170/0x1c0
__ubsan_handle_mul_overflow+0x34/0x44
update_cfs_group+0x244/0x248
dequeue_entity+0x478/0x12c0
dequeue_task_fair+0x6c/0xd98
__sched_setscheduler+0x320/0xdf0
_sched_setscheduler+0xf4/0x158
do_sched_setscheduler+0x118/0x1a0
__arm64_sys_sched_setscheduler+0x50/0x70
el0_svc_common+0xf4/0x258
el0_svc_handler+0x50/0xa8

==============================================================================

UBSAN: Undefined behaviour in kernel/sched/fair.c:3111:11
signed integer overflow:
97833896519391 * 952504 cannot be represented in type 'long int'
Call trace:
dump_backtrace+0x0/0x338
show_stack+0x28/0x38
dump_stack+0xc8/0x100
ubsan_epilogue+0x18/0x6c
handle_overflow+0x170/0x1c0
__ubsan_handle_mul_overflow+0x34/0x44
update_cfs_group+0x210/0x248
enqueue_entity+0x7b4/0x1868
enqueue_task_fair+0x12c/0xe70
__sched_setscheduler+0x4cc/0xdf0
_sched_setscheduler+0xf4/0x158
do_sched_setscheduler+0x118/0x1a0
__arm64_sys_sched_setscheduler+0x50/0x70
el0_svc_common+0xf4/0x258
el0_svc_handler+0x50/0xa8
el0_svc+0x8/0xc
==============================================================================

Cc: stable@vger.kernel.org 
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..cf003a31c220 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2920,9 +2920,9 @@ void reweight_task(struct task_struct *p, int prio)
  *
  * hence icky!
  */
-static long calc_group_shares(struct cfs_rq *cfs_rq)
+static unsigned long calc_group_shares(struct cfs_rq *cfs_rq)
 {
-	long tg_weight, tg_shares, load, shares;
+	unsigned long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
 
 	tg_shares = READ_ONCE(tg->shares);
@@ -2951,7 +2951,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 	 * case no task is runnable on a CPU MIN_SHARES=2 should be returned
 	 * instead of 0.
 	 */
-	return clamp_t(long, shares, MIN_SHARES, tg_shares);
+	return clamp_t(unsigned long, shares, MIN_SHARES, tg_shares);
 }
 
 /*
@@ -2981,9 +2981,9 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
  * Where these max() serve both to use the 'instant' values to fix the slow
  * from-idle and avoid the /0 on to-idle, similar to (6).
  */
-static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
+static unsigned long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
 {
-	long runnable, load_avg;
+	unsigned long runnable, load_avg;
 
 	load_avg = max(cfs_rq->avg.load_avg,
 		       scale_load_down(cfs_rq->load.weight));
@@ -2995,7 +2995,7 @@ static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
 	if (load_avg)
 		runnable /= load_avg;
 
-	return clamp_t(long, runnable, MIN_SHARES, shares);
+	return clamp_t(unsigned long, runnable, MIN_SHARES, shares);
 }
 #endif /* CONFIG_SMP */
 
@@ -3008,7 +3008,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares, runnable;
+	unsigned long shares, runnable;
 
 	if (!gcfs_rq)
 		return;
-- 
2.17.1

