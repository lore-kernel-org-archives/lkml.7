Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE1AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E412070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfEMLq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:46:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfEMLq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:46:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B79F0D9A9249F0DAFF06;
        Mon, 13 May 2019 19:46:57 +0800 (CST)
Received: from linux-wjgadX.huawei.com (10.90.31.46) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 May 2019 19:46:48 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Subject: [RFC v2] irqchip/gic-its: fix command queue pointer comparison bug
Date:   Mon, 13 May 2019 19:42:06 +0800
Message-ID: <1557747726-28283-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we run several VMs with PCI passthrough and GICv4 enabled, not
pinning vCPUs, we will occasionally see below warnings in dmesg:

ITS queue timeout (65440 65504 480)
ITS cmd its_build_vmovp_cmd failed

The reason for the above issue is that in BUILD_SINGLE_CMD_FUNC:
1. Post the write command.
2. Release the lock.
3. Start to read GITS_CREADR to get the reader pointer.
4. Compare the reader pointer to the target pointer.
5. If reader pointer does not reach the target, sleep 1us and continue
to try.

If we have several processors running the above concurrently, other
CPUs will post write commands while the 1st CPU is waiting the
completion. So we may have below issue:

phase 1:
---rd_idx-----from_idx-----to_idx--0---------

wait 1us:

phase 2:
--------------from_idx-----to_idx--0-rd_idx--

That is the rd_idx may fly ahead of to_idx, and if in case to_idx is
near the wrap point, rd_idx will wrap around. So the below condition
will not be met even after 1s:

if (from_idx < to_idx && rd_idx >= to_idx)

There is another theoretical issue. For a slow and busy ITS, the
initial rd_idx may fall behind from_idx a lot, just as below:

---rd_idx---0--from_idx-----to_idx-----------

This will cause the wait function exit too early.

Actually, it does not make much sense to use from_idx to judge if
to_idx is wrapped, but we need a initial rd_idx when lock is still
acquired, and it can be used to judge whether to_idx is wrapped and
the current rd_idx is wrapped.

We switch to a method of calculating the delta of two adjacent reads
and accumulating it to get the sum, so that we can get the real rd_idx
from the wrapped value even when the queue is almost full.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7577755..f05acd4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -745,32 +745,40 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
 }
 
 static int its_wait_for_range_completion(struct its_node *its,
-					 struct its_cmd_block *from,
+					 u64	origin_rd_idx,
 					 struct its_cmd_block *to)
 {
-	u64 rd_idx, from_idx, to_idx;
+	u64 rd_idx, prev_idx, to_idx, sum;
+	s64 delta;
 	u32 count = 1000000;	/* 1s! */
 
-	from_idx = its_cmd_ptr_to_offset(its, from);
 	to_idx = its_cmd_ptr_to_offset(its, to);
+	if (to_idx < origin_rd_idx)
+		to_idx += ITS_CMD_QUEUE_SZ;
+
+	prev_idx = origin_rd_idx;
+	sum = origin_rd_idx;
 
 	while (1) {
 		rd_idx = readl_relaxed(its->base + GITS_CREADR);
 
-		/* Direct case */
-		if (from_idx < to_idx && rd_idx >= to_idx)
-			break;
+		/* Wrap around for CREADR */
+		if (rd_idx >= prev_idx)
+			delta = rd_idx - prev_idx;
+		else
+			delta = rd_idx + ITS_CMD_QUEUE_SZ - prev_idx;
 
-		/* Wrapped case */
-		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
+		sum += delta;
+		if (sum >= to_idx)
 			break;
 
 		count--;
 		if (!count) {
 			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
-					   from_idx, to_idx, rd_idx);
+					   origin_rd_idx, to_idx, sum);
 			return -1;
 		}
+		prev_idx = rd_idx;
 		cpu_relax();
 		udelay(1);
 	}
@@ -787,6 +795,7 @@ void name(struct its_node *its,						\
 	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
 	synctype *sync_obj;						\
 	unsigned long flags;						\
+	u64 rd_idx;							\
 									\
 	raw_spin_lock_irqsave(&its->lock, flags);			\
 									\
@@ -808,10 +817,11 @@ void name(struct its_node *its,						\
 	}								\
 									\
 post:									\
+	rd_idx = readl_relaxed(its->base + GITS_CREADR);		\
 	next_cmd = its_post_commands(its);				\
 	raw_spin_unlock_irqrestore(&its->lock, flags);			\
 									\
-	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
+	if (its_wait_for_range_completion(its, rd_idx, next_cmd))	\
 		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
 }
 
-- 
1.8.3.1

