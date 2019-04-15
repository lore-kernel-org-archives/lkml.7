Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C31CC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464472073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355791;
	bh=IhKfWWEhStqe2GxnIxQ3ILeLP4G6tNh9inIXyQeczUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZ+Gs19ZhRdDbC1I8F8Rh5Uu8NPmtcj3ZNSs+1n8tbJlQFiGdpRZZzft5N/sfCn+Z
	 JcrClsEYNxwDFZ+Fw0psLIl+RMC+F6ybYibjBFskLlAiNOZgHzE96eXppeePM19C8P
	 nonGQkkubIJwx4zaDgpuXHcVYvyKujRLZ1mWnHcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfDOTNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfDOTNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E61218A1;
        Mon, 15 Apr 2019 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355588;
        bh=IhKfWWEhStqe2GxnIxQ3ILeLP4G6tNh9inIXyQeczUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIAQImInHZPvNNwoa5qxmgCgsrEDkQUwGlSiMWkSuAZYma9fyATHprSqhE4pq8uHI
         wXuMkuInXrmRdOSBK62AIv/+WzRJfSAreE66z49xhTXhqCpZ1uxS2VH4xdBgE/0sEK
         Fkmv+3lDKePHr6XZbPF5EdL4Rlv0StgLZ2hdv/iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.0 078/117] block: Revert v5.0 blk_mq_request_issue_directly() changes
Date:   Mon, 15 Apr 2019 21:00:48 +0200
Message-Id: <20190415183748.914356583@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit fd9c40f64c514bdc585a21e2e33fa5f83ca8811b upstream.

blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests that
have been queued. If that happens when blk_mq_try_issue_directly() is called
by the dm-mpath driver then dm-mpath will try to resubmit a request that is
already queued and a kernel crash follows. Since it is nontrivial to fix
blk_mq_request_issue_directly(), revert the blk_mq_request_issue_directly()
changes that went into kernel v5.0.

This patch reverts the following commits:
* d6a51a97c0b2 ("blk-mq: replace and kill blk_mq_request_issue_directly") # v5.0.
* 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests") # v5.0.
* 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: James Smart <james.smart@broadcom.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: <stable@vger.kernel.org>
Reported-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c     |    4 -
 block/blk-mq-sched.c |    8 ++-
 block/blk-mq.c       |  122 ++++++++++++++++++++++++++-------------------------
 block/blk-mq.h       |    6 --
 4 files changed, 71 insertions(+), 69 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1246,8 +1246,6 @@ static int blk_cloned_rq_check_limits(st
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
-	blk_qc_t unused;
-
 	if (blk_cloned_rq_check_limits(q, rq))
 		return BLK_STS_IOERR;
 
@@ -1263,7 +1261,7 @@ blk_status_t blk_insert_cloned_request(s
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused, true, true);
+	return blk_mq_request_issue_directly(rq, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -423,10 +423,12 @@ void blk_mq_sched_insert_requests(struct
 		 * busy in case of 'none' scheduler, and this way may save
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async)
+		if (!hctx->dispatch_busy && !e && !run_queue_async) {
 			blk_mq_try_issue_list_directly(hctx, list);
-		else
-			blk_mq_insert_requests(hctx, ctx, list);
+			if (list_empty(list))
+				return;
+		}
+		blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1805,74 +1805,76 @@ static blk_status_t __blk_mq_issue_direc
 	return ret;
 }
 
-blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass, bool last)
+						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
-	blk_status_t ret = BLK_STS_RESOURCE;
-	int srcu_idx;
-	bool force = false;
 
-	hctx_lock(hctx, &srcu_idx);
 	/*
-	 * hctx_lock is needed before checking quiesced flag.
+	 * RCU or SRCU read lock is needed before checking quiesced flag.
 	 *
-	 * When queue is stopped or quiesced, ignore 'bypass', insert
-	 * and return BLK_STS_OK to caller, and avoid driver to try to
-	 * dispatch again.
+	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
+	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
+	 * and avoid driver to try to dispatch again.
 	 */
-	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
-		bypass = false;
-		goto out_unlock;
+		bypass_insert = false;
+		goto insert;
 	}
 
-	if (unlikely(q->elevator && !bypass))
-		goto out_unlock;
+	if (q->elevator && !bypass_insert)
+		goto insert;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
-		goto out_unlock;
+		goto insert;
 
 	if (!blk_mq_get_driver_tag(rq)) {
 		blk_mq_put_dispatch_budget(hctx);
-		goto out_unlock;
+		goto insert;
 	}
 
-	/*
-	 * Always add a request that has been through
-	 *.queue_rq() to the hardware dispatch list.
-	 */
-	force = true;
-	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
-out_unlock:
+	return __blk_mq_issue_directly(hctx, rq, cookie, last);
+insert:
+	if (bypass_insert)
+		return BLK_STS_RESOURCE;
+
+	blk_mq_request_bypass_insert(rq, run_queue);
+	return BLK_STS_OK;
+}
+
+static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, blk_qc_t *cookie)
+{
+	blk_status_t ret;
+	int srcu_idx;
+
+	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
+
+	hctx_lock(hctx, &srcu_idx);
+
+	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
+	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+		blk_mq_request_bypass_insert(rq, true);
+	else if (ret != BLK_STS_OK)
+		blk_mq_end_request(rq, ret);
+
+	hctx_unlock(hctx, srcu_idx);
+}
+
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
+{
+	blk_status_t ret;
+	int srcu_idx;
+	blk_qc_t unused_cookie;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	hctx_lock(hctx, &srcu_idx);
+	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
 	hctx_unlock(hctx, srcu_idx);
-	switch (ret) {
-	case BLK_STS_OK:
-		break;
-	case BLK_STS_DEV_RESOURCE:
-	case BLK_STS_RESOURCE:
-		if (force) {
-			blk_mq_request_bypass_insert(rq, run_queue);
-			/*
-			 * We have to return BLK_STS_OK for the DM
-			 * to avoid livelock. Otherwise, we return
-			 * the real result to indicate whether the
-			 * request is direct-issued successfully.
-			 */
-			ret = bypass ? BLK_STS_OK : ret;
-		} else if (!bypass) {
-			blk_mq_sched_insert_request(rq, false,
-						    run_queue, false);
-		}
-		break;
-	default:
-		if (!bypass)
-			blk_mq_end_request(rq, ret);
-		break;
-	}
 
 	return ret;
 }
@@ -1880,20 +1882,22 @@ out_unlock:
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
-	blk_qc_t unused;
-	blk_status_t ret = BLK_STS_OK;
-
 	while (!list_empty(list)) {
+		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		if (ret == BLK_STS_OK)
-			ret = blk_mq_try_issue_directly(hctx, rq, &unused,
-							false,
+		ret = blk_mq_request_issue_directly(rq, list_empty(list));
+		if (ret != BLK_STS_OK) {
+			if (ret == BLK_STS_RESOURCE ||
+					ret == BLK_STS_DEV_RESOURCE) {
+				blk_mq_request_bypass_insert(rq,
 							list_empty(list));
-		else
-			blk_mq_sched_insert_request(rq, false, true, false);
+				break;
+			}
+			blk_mq_end_request(rq, ret);
+		}
 	}
 
 	/*
@@ -1901,7 +1905,7 @@ void blk_mq_try_issue_list_directly(stru
 	 * the driver there was more coming, but that turned out to
 	 * be a lie.
 	 */
-	if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
+	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
@@ -2014,13 +2018,13 @@ static blk_qc_t blk_mq_make_request(stru
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie, false, true);
+					&cookie);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie, false, true);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -67,10 +67,8 @@ void blk_mq_request_bypass_insert(struct
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
-blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-						struct request *rq,
-						blk_qc_t *cookie,
-						bool bypass, bool last);
+/* Used by blk_insert_cloned_request() to issue request directly */
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 


