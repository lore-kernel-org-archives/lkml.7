Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B732086A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329725;
	bh=2VrxIXPzh7qElhPGuM2gjP6X4WGwjOXc3Ma+nNCB/jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JOEEXlaTmdr1eV2CIygTxnGFwQ6AUTwi2EgtfXW2iH87+2ezpfCunfrAliLmIE3DN
	 glviry8QXcia4FgmlHFoHZJt66m23JM0DYyrsQOGdLWnKQDRx3v6d1JtqFaZzAHB/r
	 cdq30bs0N5NtR5z0m2rbO2DbgNqsJT23yc5fBcfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfD0BmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfD0BmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8682621537;
        Sat, 27 Apr 2019 01:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329329;
        bh=2VrxIXPzh7qElhPGuM2gjP6X4WGwjOXc3Ma+nNCB/jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBhOaDaGZgLbM5iddWwnjvF0pYsUvasGIg8kbYvxrgi1LEHcY9s5RJnSY7u2I7nHF
         d1reJZLhehk2aDuVybyr+9jJUIQzy76ME6QGUHsmnLXnilT7ptP4AxpahjHJcJwbtT
         RgLZncvfUrIqwc2cUreH/sipaXswbNrrZtExFKDw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 46/53] nvme-fc: correct csn initialization and increments on error
Date:   Fri, 26 Apr 2019 21:40:43 -0400
Message-Id: <20190427014051.7522-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 67f471b6ed3b09033c4ac77ea03f92afdb1989fe ]

This patch fixes a long-standing bug that initialized the FC-NVME
cmnd iu CSN value to 1. Early FC-NVME specs had the connection starting
with CSN=1. By the time the spec reached approval, the language had
changed to state a connection should start with CSN=0.  This patch
corrects the initialization value for FC-NVME connections.

Additionally, in reviewing the transport, the CSN value is assigned to
the new IU early in the start routine. It's possible that a later dma
map request may fail, causing the command to never be sent to the
controller.  Change the location of the assignment so that it is
immediately prior to calling the lldd. Add a comment block to explain
the impacts if the lldd were to additionally fail sending the command.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9375fa705d82..67dec8860bf3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1844,7 +1844,7 @@ nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
 	memset(queue, 0, sizeof(*queue));
 	queue->ctrl = ctrl;
 	queue->qnum = idx;
-	atomic_set(&queue->csn, 1);
+	atomic_set(&queue->csn, 0);
 	queue->dev = ctrl->dev;
 
 	if (idx > 0)
@@ -1886,7 +1886,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
 	 */
 
 	queue->connection_id = 0;
-	atomic_set(&queue->csn, 1);
+	atomic_set(&queue->csn, 0);
 }
 
 static void
@@ -2182,7 +2182,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 {
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
-	u32 csn;
 	int ret, opstate;
 
 	/*
@@ -2197,8 +2196,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 
 	/* format the FC-NVME CMD IU and fcp_req */
 	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
-	csn = atomic_inc_return(&queue->csn);
-	cmdiu->csn = cpu_to_be32(csn);
 	cmdiu->data_len = cpu_to_be32(data_len);
 	switch (io_dir) {
 	case NVMEFC_FCP_WRITE:
@@ -2256,11 +2253,24 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	if (!(op->flags & FCOP_FLAGS_AEN))
 		blk_mq_start_request(op->rq);
 
+	cmdiu->csn = cpu_to_be32(atomic_inc_return(&queue->csn));
 	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
 					&ctrl->rport->remoteport,
 					queue->lldd_handle, &op->fcp_req);
 
 	if (ret) {
+		/*
+		 * If the lld fails to send the command is there an issue with
+		 * the csn value?  If the command that fails is the Connect,
+		 * no - as the connection won't be live.  If it is a command
+		 * post-connect, it's possible a gap in csn may be created.
+		 * Does this matter?  As Linux initiators don't send fused
+		 * commands, no.  The gap would exist, but as there's nothing
+		 * that depends on csn order to be delivered on the target
+		 * side, it shouldn't hurt.  It would be difficult for a
+		 * target to even detect the csn gap as it has no idea when the
+		 * cmd with the csn was supposed to arrive.
+		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
 		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 
-- 
2.19.1

