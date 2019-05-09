Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB8C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBBB204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427957;
	bh=QzCzpG7nqtzDp/K2VGk2Dc3YCAeq6d3p0u/YucM0gio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0tHiEwRD6b2eEiM5bR1RC7eet748cPh3q9JZYS7Viu2OJurYVFCR0JCndTk8D/Z05
	 xZsDFuqVhVaqGEvicKbadJUuGnSS9h3VxNxJbwNwg1vDLVu+uiQbVJKrhGlu1WjWwP
	 HE0qjbK6D/cu3l0DNa/z0qTE9qY/pnMAxwUkdP2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfEISwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfEISwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:52:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF0A2177E;
        Thu,  9 May 2019 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427953;
        bh=QzCzpG7nqtzDp/K2VGk2Dc3YCAeq6d3p0u/YucM0gio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iX3G8Lt6BxkS0x7YyRtPwp5i7SVWpfqUSP3ClzNMkMeSk3v8GQYQodOSrVzPdoWfK
         6q62MEVbAxMiOpzrtzq9eARqSgmNO3IwC7ruP45dJjvn3l02pna7fI3/jrCWDXG3Mu
         HJ3F05moBAQ9HafEoSV78HyiZ8R69cgtzU8nediE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 65/95] blk-mq: introduce blk_mq_complete_request_sync()
Date:   Thu,  9 May 2019 20:42:22 +0200
Message-Id: <20190509181314.017487714@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1b8f21b74c3c9c82fce5a751d7aefb7cc0b8d33d ]

In NVMe's error handler, follows the typical steps of tearing down
hardware for recovering controller:

1) stop blk_mq hw queues
2) stop the real hw queues
3) cancel in-flight requests via
	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
cancel_request():
	mark the request as abort
	blk_mq_complete_request(req);
4) destroy real hw queues

However, there may be race between #3 and #4, because blk_mq_complete_request()
may run q->mq_ops->complete(rq) remotelly and asynchronously, and
->complete(rq) may be run after #4.

This patch introduces blk_mq_complete_request_sync() for fixing the
above race.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c         | 7 +++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5a2585d69c817..6930c82ab75fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -657,6 +657,13 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+void blk_mq_complete_request_sync(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e030f5f76b66..7e092bdac27f6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -306,6 +306,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.20.1



