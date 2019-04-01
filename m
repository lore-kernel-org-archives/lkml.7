Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55412192B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138568;
	bh=Fnf6UQyeAfzbE5jn/6R56bXVUC3rMjUzT2FTJYsH4Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PefcF7F/qgC2l7mtRZq1nFOuGsbe7L0aVx/8u0Ev1JQlb5DTjWY8VCtnW3UDQHflW
	 4mAr0qZyni8DfnjNytv1eZQbxWXkjhjf4EYvtbFAd7wtv9pV39zZvjn48aNiGNNM7T
	 vX//AaIRHCW+cBOrdHiish5t+qYeHkL3S+nkc4FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfDARJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfDARJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A6421925;
        Mon,  1 Apr 2019 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138564;
        bh=Fnf6UQyeAfzbE5jn/6R56bXVUC3rMjUzT2FTJYsH4Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIZVKmdtcVMndRf91+WTipe4nrfnCY2LQ6Aj52GvNJHpFIdOhOciKpejYre1Imgwc
         eKuu8hMtauCR60d6xgLwFjyXYu2LhV5zuD5H3UyKuJ0Wec3SfoSJZpi8JiFa1ecd6a
         xml4TMllW/8Y9WocGaNJ8HjyTKzJztgxCLyaeiZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Leun <kbug@newton.leun.net>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.0 103/146] blk-mq: fix sbitmap ws_active for shared tags
Date:   Mon,  1 Apr 2019 19:01:55 +0200
Message-Id: <20190401170057.386300794@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit e861857545567adec8da3bdff728efdf7db12285 upstream.

We now wrap sbitmap waitqueues in an active counter, so we can avoid
iterating wakeups unless we have waiters there. This works as long as
everyone that's manipulating the waitqueues use the proper helpers. For
the tag wait case for shared tags, however, we add ourselves to the
waitqueue without incrementing/decrementing the ->ws_active count. This
means that wakeups can take a long time to happen.

Fix this by manually doing the inc/dec as needed for the wait queue
handling.

Reported-by: Michael Leun <kbug@newton.leun.net>
Tested-by: Michael Leun <kbug@newton.leun.net>
Cc: stable@vger.kernel.org
Reviewed-by: Omar Sandoval <osandov@fb.com>
Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1076,7 +1076,13 @@ static int blk_mq_dispatch_wake(wait_que
 	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
 
 	spin_lock(&hctx->dispatch_wait_lock);
-	list_del_init(&wait->entry);
+	if (!list_empty(&wait->entry)) {
+		struct sbitmap_queue *sbq;
+
+		list_del_init(&wait->entry);
+		sbq = &hctx->tags->bitmap_tags;
+		atomic_dec(&sbq->ws_active);
+	}
 	spin_unlock(&hctx->dispatch_wait_lock);
 
 	blk_mq_run_hw_queue(hctx, true);
@@ -1092,6 +1098,7 @@ static int blk_mq_dispatch_wake(wait_que
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
+	struct sbitmap_queue *sbq = &hctx->tags->bitmap_tags;
 	struct wait_queue_head *wq;
 	wait_queue_entry_t *wait;
 	bool ret;
@@ -1115,7 +1122,7 @@ static bool blk_mq_mark_tag_wait(struct
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
-	wq = &bt_wait_ptr(&hctx->tags->bitmap_tags, hctx)->wait;
+	wq = &bt_wait_ptr(sbq, hctx)->wait;
 
 	spin_lock_irq(&wq->lock);
 	spin_lock(&hctx->dispatch_wait_lock);
@@ -1125,6 +1132,7 @@ static bool blk_mq_mark_tag_wait(struct
 		return false;
 	}
 
+	atomic_inc(&sbq->ws_active);
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
@@ -1145,6 +1153,7 @@ static bool blk_mq_mark_tag_wait(struct
 	 * someone else gets the wakeup.
 	 */
 	list_del_init(&wait->entry);
+	atomic_dec(&sbq->ws_active);
 	spin_unlock(&hctx->dispatch_wait_lock);
 	spin_unlock_irq(&wq->lock);
 


