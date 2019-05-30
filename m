Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB49C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDEF25C3A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191684;
	bh=ugqQNPg0abMAcNuXkyn4nCmWIk8iEm6zxwSqp5peVXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sSr2tLC0LQl+6Pw/mtzfrG+TnSYrM6Bwu4Zann497Dtd6qhSNMuyDVVJDdTWuyF94
	 BCD8V3NxesDhWqiEvKjzwfhp71C4TSnlMxcX+odbX1vRHlUqk4nTHw0XdQ94WdpVjE
	 FTH2Vy328KJA8GEC4i3JTPbsKHqBdc4kfQlcyE+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfE3DLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfE3DK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F60244A9;
        Thu, 30 May 2019 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185826;
        bh=ugqQNPg0abMAcNuXkyn4nCmWIk8iEm6zxwSqp5peVXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXBp4vgN53kW/79aguGqe4cFwpMTju+zLX6R3zRGuf3yVo+GAt9bv2BLvYRslzrB6
         5PQYB+lTPR8YXDvfkq43sj5l3FM8tpX9N+H8foux19FEel95jyD4XdLgqnvD33ifgn
         FuIZtV0OlY48h5uwXTEikYlPVk0tK+6TK9rjjRz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 126/405] nvme-rdma: fix a NULL deref when an admin connect times out
Date:   Wed, 29 May 2019 20:02:04 -0700
Message-Id: <20190530030547.416760333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1007709d7d06fab09bf2d007657575958676282b ]

If we timeout the admin startup sequence we might not yet have
an I/O tagset allocated which causes the teardown sequence to crash.
Make nvme_tcp_teardown_io_queues safe by not iterating inflight tags
if the tagset wasn't allocated.

Fixes: 4c174e636674 ("nvme-rdma: fix timeout handler")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11a5ecae78c8d..e1824c2e0a1c0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -914,8 +914,9 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set, nvme_cancel_request,
-			&ctrl->ctrl);
+	if (ctrl->ctrl.admin_tagset)
+		blk_mq_tagset_busy_iter(ctrl->ctrl.admin_tagset,
+			nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
@@ -926,8 +927,9 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
-				&ctrl->ctrl);
+		if (ctrl->ctrl.tagset)
+			blk_mq_tagset_busy_iter(ctrl->ctrl.tagset,
+				nvme_cancel_request, &ctrl->ctrl);
 		if (remove)
 			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
-- 
2.20.1



