Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD11C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0B220693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369721;
	bh=uyVnT9mQx9rPvxxJQv5y3Ab30S5ol39ZuxLClLG8J6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlfS3wsQucehAhmiZtKz7yl6xgC1RUvHCgs+ucxx5f8nlT58BHTK/NJBnrRdSrxV+
	 EvoFQMy4RWDnrCG0DO2tO/naHz2TTfePMtjXnfog0bMD/UP+IRRTFa78LLzYVFqsLp
	 +9fnhvCA4A178d7jpCBx9TXzLOl0FlgI3oq6IP0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfDDJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387814AbfDDJQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E67520652;
        Thu,  4 Apr 2019 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369381;
        bh=uyVnT9mQx9rPvxxJQv5y3Ab30S5ol39ZuxLClLG8J6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIb5yPX8lcWTQtX/Z7Ce1kxbYDzNM35W0f9JFlyxiyA/2zsGgytQOMGv4pesIN3Ov
         WUCrV1xP2cx8b9bhOZ+ODswYdtJNR6S1hXHJe/eQg+daUVsS/I+eRNU2jYZcHqa7hT
         CfXEevETxZtUn4dAXVnJ7l7WcVw9AyLxGJyEcfrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 187/246] block, bfq: fix queue removal from weights tree
Date:   Thu,  4 Apr 2019 10:48:07 +0200
Message-Id: <20190404084625.730501230@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9dee8b3b057e1da26f85f1842f2aaf3bb200fb94 ]

bfq maintains an ordered list, through a red-black tree, of unique
weights of active bfq_queues. This list is used to detect whether there
are active queues with differentiated weights. The weight of a queue is
removed from the list when both the following two conditions become
true:

(1) the bfq_queue is flagged as inactive
(2) the has no in-flight request any longer;

Unfortunately, in the rare cases where condition (2) becomes true before
condition (1), the removal fails, because the function to remove the
weight of the queue (bfq_weights_tree_remove) is rightly invoked in the
path that deactivates the bfq_queue, but mistakenly invoked *before* the
function that actually performs the deactivation (bfq_deactivate_bfqq).

This commits moves the invocation of bfq_weights_tree_remove for
condition (1) to after bfq_deactivate_bfqq. As a consequence of this
move, it is necessary to add a further reference to the queue when the
weight of a queue is added, because the queue might otherwise be freed
before bfq_weights_tree_remove is invoked. This commit adds this
reference and makes all related modifications.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 17 +++++++++++++----
 block/bfq-wf2q.c    |  6 +++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f010810c095f..e5ed28629271 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -747,6 +747,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 inc_counter:
 	bfqq->weight_counter->num_active++;
+	bfqq->ref++;
 }
 
 /*
@@ -771,6 +772,7 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 
 reset_entity_pointer:
 	bfqq->weight_counter = NULL;
+	bfq_put_queue(bfqq);
 }
 
 /*
@@ -782,9 +784,6 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
 
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
-
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
@@ -818,6 +817,15 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			bfqd->num_groups_with_pending_reqs--;
 		}
 	}
+
+	/*
+	 * Next function is invoked last, because it causes bfqq to be
+	 * freed if the following holds: bfqq is not in service and
+	 * has no dispatched request. DO NOT use bfqq after the next
+	 * function invocation.
+	 */
+	__bfq_weights_tree_remove(bfqd, bfqq,
+				  &bfqd->queue_weights_tree);
 }
 
 /*
@@ -1011,7 +1019,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st;
+	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st -
+		(bfqq->weight_counter != NULL);
 }
 
 /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 72adbbe975d5..4aab1a8191f0 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1667,15 +1667,15 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues--;
 
-	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, bfqq);
-
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
 
 	bfqg_stats_update_dequeue(bfqq_group(bfqq));
 
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+
+	if (!bfqq->dispatched)
+		bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
-- 
2.19.1



