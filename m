Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC2A206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329842;
	bh=W441vUvKyZI3DLolgjroDMA/CMEv72SuN7sctSaCvEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tx2stCXyp8MgEITl1ZRT3eyLOc9QuuFlBfOQwsItvwSgaupxNTlwWNiLnCp26F1DM
	 ka9j4AKZ8l3WQ+j94Xo/0NlPTDuzvBSOTsrWDuxVRvP837DSdGQ3w5k23qKRrCALwu
	 TNyP9V2Fq3HxXxLW3CMFM3WL7VAez3jUIQWIsJfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfD0BlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfD0BlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A96720C01;
        Sat, 27 Apr 2019 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329280;
        bh=W441vUvKyZI3DLolgjroDMA/CMEv72SuN7sctSaCvEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Czz9j7G5NlcikK+SYLd0DsYYQLUWgx9d0mmMOCaSlGG/8Bsqi/EtIs6sjZ87/pB94
         6mYaF+ThS6MYxxzMFFtGEnXrkUYJyTVMdXXDwOmtJ9STWL5werP0PSmGF1QB4NVC95
         wACyVSpYc3PF8wy8OtAR2Eua1sAQV+lOJX2EbqI0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/53] IB/hfi1: Eliminate opcode tests on mr deref
Date:   Fri, 26 Apr 2019 21:40:16 -0400
Message-Id: <20190427014051.7522-19-sashal@kernel.org>
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

From: Kaike Wan <kaike.wan@intel.com>

[ Upstream commit a8639a79e85c18c16c10089edd589c7948f19bbd ]

When an old ack_queue entry is used to store an incoming request, it may
need to clean up the old entry if it is still referencing the
MR. Originally only RDMA READ request needed to reference MR on the
responder side and therefore the opcode was tested when cleaning up the
old entry. The introduction of tid rdma specific operations in the
ack_queue makes the specific opcode tests wrong.  Multiple opcodes (RDMA
READ, TID RDMA READ, and TID RDMA WRITE) may need MR ref cleanup.

Remove the opcode specific tests associated with the ack_queue.

Fixes: f48ad614c100 ("IB/hfi1: Move driver out of staging")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/rc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 6f013a565353..770c78c65730 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -2303,7 +2303,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 			update_ack_queue(qp, next);
 		}
 		e = &qp->s_ack_queue[qp->r_head_ack_queue];
-		if (e->opcode == OP(RDMA_READ_REQUEST) && e->rdma_sge.mr) {
+		if (e->rdma_sge.mr) {
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
@@ -2377,7 +2377,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 			update_ack_queue(qp, next);
 		}
 		e = &qp->s_ack_queue[qp->r_head_ack_queue];
-		if (e->opcode == OP(RDMA_READ_REQUEST) && e->rdma_sge.mr) {
+		if (e->rdma_sge.mr) {
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
-- 
2.19.1

