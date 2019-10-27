Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F054CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC1420717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211089;
	bh=KllF1Vd9QjJ+moQw4J7Yv+052X+bzOtxMFBqtCgyhEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpiXTM69vSwvZh9IY4aakt9QxBtVe4/GKfiMOhX6qxDmZv3lj7MMdD9x75u2CPT9z
	 nY49XY/UIRwMlpGq09v74O94qi1c6vLKrqcWKfe/pqaSIVG0mXDE012LyQsOjAVDF8
	 Zq3NrLey0DIIsav1xq9XXEGX9d6PDHT2zgODacvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfJ0VSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731205AbfJ0VSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:18:04 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00939208C0;
        Sun, 27 Oct 2019 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211083;
        bh=KllF1Vd9QjJ+moQw4J7Yv+052X+bzOtxMFBqtCgyhEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmSa8qLk0Mis/iN3/vLQd8zPuuN2homikEB/uIQJU/YHmhePo/2XBFRq+VHyViI/v
         z3PTckGXaAjCqdcz/WggfXWxNDiG8x6M268cgcuxCCquMuhSxhz+U/XgVujLMPg5cj
         kfr/G3whOcJW24FJBMKE8E+7hLedq0QFVqL2TPew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Dave Chinner <dchinner@redhat.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 026/197] blk-mq: honor IO scheduler for multiqueue devices
Date:   Sun, 27 Oct 2019 21:59:04 +0100
Message-Id: <20191027203353.126808171@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a12de1d42d74ef3c80e9fb9a2da94daaef747869 ]

If a device is using multiple queues, the IO scheduler may be bypassed.
This may hurt performance for some slow MQ devices, and it also breaks
zoned devices which depend on mq-deadline for respecting the write order
in one zone.

Don't bypass io scheduler if we have one setup.

This patch can double sequential write performance basically on MQ
scsi_debug when mq-deadline is applied.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a79b9ad1aba18..ed41cde93641c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1998,6 +1998,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 
 		blk_add_rq_to_plug(plug, rq);
+	} else if (q->elevator) {
+		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
@@ -2021,8 +2023,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
 		}
-	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
-			!data.hctx->dispatch_busy)) {
+	} else if ((q->nr_hw_queues > 1 && is_sync) ||
+			!data.hctx->dispatch_busy) {
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
 		blk_mq_sched_insert_request(rq, false, true, true);
-- 
2.20.1



