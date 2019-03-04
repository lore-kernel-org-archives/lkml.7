Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D968C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D7821019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688586;
	bh=1r1N73xnHBn841DlmplQwerHWnWZdswoUXwKuLRtSKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVP2+hBStkdse37KhC3SzGNmb0Yo4w1eR01mgTgYiIQ+IcVG4XrQFWNKydgrhx+12
	 q0N0Pr2kCJaYUM8LQhWm+Fp+X4wUpk2IFupB8qNqieCkIczoMyRmDdg5PD2G2MiYQO
	 GvW29ZJYMWLFBafQTvVncEuuDmu1Xp1wNdP6KXAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfCDIgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfCDIgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3431220823;
        Mon,  4 Mar 2019 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688577;
        bh=1r1N73xnHBn841DlmplQwerHWnWZdswoUXwKuLRtSKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5q4XOoVXlGHcONvVxIqCv30gPhS0S/KUS9XmmKLNjgISBBynHJR+3rzdc2G1sUTM
         JQNSHWeL1iXh/AMinOS16vrpRpAKFNHzcuD9s++KxV3sIAdukjLgEcC0bps8viOvLG
         G+095Yh0gmzFIvN1f/W/dra5CjyRd18BjbkHgINE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaesoo Lee <jalee@purestorage.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 53/88] nvme-rdma: fix timeout handler
Date:   Mon,  4 Mar 2019 09:22:36 +0100
Message-Id: <20190304081632.640708219@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4c174e6366746ae8d49f9cc409f728eebb7a9ac9 ]

Currently, we have several problems with the timeout
handler:
1. If we timeout on the controller establishment flow, we will hang
because we don't execute the error recovery (and we shouldn't because
the create_ctrl flow needs to fail and cleanup on its own)
2. We might also hang if we get a disconnet on a queue while the
controller is already deleting. This racy flow can cause the controller
disable/shutdown admin command to hang.

We cannot complete a timed out request from the timeout handler without
mutual exclusion from the teardown flow (e.g. nvme_rdma_error_recovery_work).
So we serialize it in the timeout handler and teardown io and admin
queues to guarantee that no one races with us from completing the
request.

Reported-by: Jaesoo Lee <jalee@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ab6ec7295bf90..6e24b20304b53 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1679,18 +1679,28 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	dev_warn(req->queue->ctrl->ctrl.device,
-		 "I/O %d QID %d timeout, reset controller\n",
-		 rq->tag, nvme_rdma_queue_idx(req->queue));
+	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
+		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+		/*
+		 * Teardown immediately if controller times out while starting
+		 * or we are already started error recovery. all outstanding
+		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 */
+		flush_work(&ctrl->err_work);
+		nvme_rdma_teardown_io_queues(ctrl, false);
+		nvme_rdma_teardown_admin_queue(ctrl, false);
+		return BLK_EH_DONE;
+	}
 
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
+	nvme_rdma_error_recovery(ctrl);
 
-	return BLK_EH_DONE;
+	return BLK_EH_RESET_TIMER;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.19.1



