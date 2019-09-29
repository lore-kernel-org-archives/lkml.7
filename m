Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88AAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A133221882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765538;
	bh=QSdSMS2ESRitIwBikZ4EJDiZoFjouFXyqTxW+tZiNLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WeYPVwkzZbVKhbp6wVUG8IzpvbPARAE/en+kLqyu54J4y2uZ6KZ7+cAQ+PxUOoh4n
	 CnEHLon7nfHL8Nk1DQga037OuYcdN4Uk2fD1cp5hd7hC4OQYg0gf9G2GHebBMw+wfm
	 WZp7/PnSWT1o8z2QTwonemlSL+OUQ0ntm9dso2aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfI2N65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfI2N6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:58:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5305421835;
        Sun, 29 Sep 2019 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765533;
        bh=QSdSMS2ESRitIwBikZ4EJDiZoFjouFXyqTxW+tZiNLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffE6POoP3FyrI2Gp80ekFue16fP3MgdfRJSEnk1O2PQ/JtNAqQQaw9WyvOzzEmAOT
         g3iQmvLmgHVKRgliEGxfqxabMSq9pqByTBMejKmiUtwM6OqPkgRD4AkALUSL22sQ9z
         p2h+nwCw/buh7myJZ5YthBK6S+aCYWw8ECVSsT2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/63] blk-mq: change gfp flags to GFP_NOIO in blk_mq_realloc_hw_ctxs
Date:   Sun, 29 Sep 2019 15:54:21 +0200
Message-Id: <20190929135039.866758235@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 5b202853ffbc54b29f23c4b1b5f3948efab489a2 ]

blk_mq_realloc_hw_ctxs could be invoked during update hw queues.
At the momemt, IO is blocked. Change the gfp flags from GFP_KERNEL
to GFP_NOIO to avoid forever hang during memory allocation in
blk_mq_realloc_hw_ctxs.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c  |  2 +-
 block/blk-flush.c |  6 +++---
 block/blk-mq.c    | 17 ++++++++++-------
 block/blk.h       |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index af635f878f966..074ae9376189b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1165,7 +1165,7 @@ int blk_init_allocated_queue(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_ops);
 
-	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
+	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size, GFP_KERNEL);
 	if (!q->fq)
 		return -ENOMEM;
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 76487948a27fa..87fc49daa2b49 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -566,12 +566,12 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 EXPORT_SYMBOL(blkdev_issue_flush);
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size)
+		int node, int cmd_size, gfp_t flags)
 {
 	struct blk_flush_queue *fq;
 	int rq_sz = sizeof(struct request);
 
-	fq = kzalloc_node(sizeof(*fq), GFP_KERNEL, node);
+	fq = kzalloc_node(sizeof(*fq), flags, node);
 	if (!fq)
 		goto fail;
 
@@ -579,7 +579,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		spin_lock_init(&fq->mq_flush_lock);
 
 	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
-	fq->flush_rq = kzalloc_node(rq_sz, GFP_KERNEL, node);
+	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
 	if (!fq->flush_rq)
 		goto fail_rq;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 455fda99255a4..9dfafee65bce2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2198,12 +2198,12 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	 * runtime
 	 */
 	hctx->ctxs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
-					GFP_KERNEL, node);
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
 	if (!hctx->ctxs)
 		goto unregister_cpu_notifier;
 
-	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8), GFP_KERNEL,
-			      node))
+	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node))
 		goto free_ctxs;
 
 	hctx->nr_ctx = 0;
@@ -2216,7 +2216,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
+	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!hctx->fq)
 		goto exit_hctx;
 
@@ -2530,12 +2531,14 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(set),
-					GFP_KERNEL, node);
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node);
 		if (!hctxs[i])
 			break;
 
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node)) {
+		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask,
+					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+					node)) {
 			kfree(hctxs[i]);
 			hctxs[i] = NULL;
 			break;
diff --git a/block/blk.h b/block/blk.h
index 977d4b5d968d5..11e4ca2f2cd46 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,7 +124,7 @@ static inline void __blk_get_queue(struct request_queue *q)
 }
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size);
+		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
-- 
2.20.1



