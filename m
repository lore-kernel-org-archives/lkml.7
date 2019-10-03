Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA538C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8757021783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118836;
	bh=pli4rmXhq7FOXLXjYFY5y1FXKnIqmfVOfCt3zRgefls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lhzvDn034IOsF0EnNn5031m7o8xnVqNdmgdPtPi9CiLlw2d9ACBbdlQehHTBI7wm1
	 w+IFsqcJPIPWB0jSi8oiLqnUVSM4GfZ8iL4xGx3Ek+TfF1d8cb6u1WJ5fCRH0YKQC0
	 SJWZtvT15epB1czzw3OMnJvR9/uqqCU8WspElP1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJCQHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732886AbfJCQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:07:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAB4222BE;
        Thu,  3 Oct 2019 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118828;
        bh=pli4rmXhq7FOXLXjYFY5y1FXKnIqmfVOfCt3zRgefls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFzBVGKBhqzCJ819X2ZkpAok9KkVANOC+xFX1hNThaxwD/tw1w8+PRNxI/vGkwP9C
         x0NimacNl1I6rSMSVl1FinjmYuYsRFjBImxGTfTnu9UZftjpHJfWO9+C3UsMUIgVYc
         55vlJYh+JBCMxWq25bFf55+waHqiXUDusmZbsNmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        zhengbin <zhengbin13@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/185] blk-mq: move cancel of requeue_work to the front of blk_exit_queue
Date:   Thu,  3 Oct 2019 17:51:42 +0200
Message-Id: <20191003154443.250657845@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit e26cc08265dda37d2acc8394604f220ef412299d ]

blk_exit_queue will free elevator_data, while blk_mq_requeue_work
will access it. Move cancel of requeue_work to the front of
blk_exit_queue to avoid use-after-free.

blk_exit_queue                blk_mq_requeue_work
  __elevator_exit               blk_mq_run_hw_queues
    blk_mq_exit_sched             blk_mq_run_hw_queue
      dd_exit_queue                 blk_mq_hctx_has_pending
        kfree(elevator_data)          blk_mq_sched_has_work
                                        dd_has_work

Fixes: fbc2a15e3433 ("blk-mq: move cancel of requeue_work into blk_mq_release")
Cc: stable@vger.kernel.org
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c    | 2 --
 block/blk-sysfs.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55139d2fca3e0..eac4448047366 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2294,8 +2294,6 @@ void blk_mq_release(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	cancel_delayed_work_sync(&q->requeue_work);
-
 	/* hctx kobj stays in hctx */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e54be402899da..9caf96c2c1081 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -811,6 +811,9 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_free_queue_stats(q->stats);
 
+	if (q->mq_ops)
+		cancel_delayed_work_sync(&q->requeue_work);
+
 	blk_exit_rl(q, &q->root_rl);
 
 	if (q->queue_tags)
-- 
2.20.1



