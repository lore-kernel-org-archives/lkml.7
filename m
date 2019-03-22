Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08BC20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255916;
	bh=0fI+ZXnX7s2QP62W3hcyl+l7OMo8QRcIQj7SwJzuci4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UNjnqIEwjTmwlt1MmOyAMYeaX/+p08//opoZaqWUMpjUwCdf6sda3ujY+BEhMRFMl
	 hxHoHddAO+Pmp7KZrXNKZD10Ngo1cm8asv2I0+LGHLclVa46fgqEj8oDSQle4lOT2r
	 9jVrpyyb+tlNXpma2/6SX4jcR0AdqD+lpEDQ8/m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbfCVL6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387838AbfCVL6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031B820850;
        Fri, 22 Mar 2019 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255909;
        bh=0fI+ZXnX7s2QP62W3hcyl+l7OMo8QRcIQj7SwJzuci4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EluuUmnbJFUiH3rHuw2uMdRLXdUmHdbd6pQ5iFv//6ROhSYKAMZfe6rVnm515HgsC
         A8ZBROx3ymAIWZ+Tq8qrmsAEHxDQvF5+y0o8H8+c/Hf91rXtSqdsGchz6rPxqB3raS
         xiuTYuaS3fmmgV+bloeUlGpxIX+4Qo3LQkGGrL1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 051/280] blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue
Date:   Fri, 22 Mar 2019 12:13:24 +0100
Message-Id: <20190322111309.169307172@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aef1897cd36dcf5e296f1d2bae7e0d268561b685 ]

When requeue, if RQF_DONTPREP, rq has contained some driver
specific data, so insert it to hctx dispatch list to avoid any
merge. Take scsi as example, here is the trace event log (no
io scheduler, because RQF_STARTED would prevent merging),

   kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
   kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
   kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
   kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]

(32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
the sdb only contained the part of (32768 + 8), then only that part
was completed. The lucky thing was that scsi_io_completion detected
it and requeued the remaining part. So we didn't get corrupted data.
However, the requeue of (32776 + 8) is not expected.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 23a53b67cf0d..7d53f2314d7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -701,12 +701,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & RQF_SOFTBARRIER))
+		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
 			continue;
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, true, false, false);
+		/*
+		 * If RQF_DONTPREP, rq has contained some driver specific
+		 * data, so insert it to hctx dispatch list to avoid any
+		 * merge.
+		 */
+		if (rq->rq_flags & RQF_DONTPREP)
+			blk_mq_request_bypass_insert(rq, false);
+		else
+			blk_mq_sched_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
-- 
2.19.1



