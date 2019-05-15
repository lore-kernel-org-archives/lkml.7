Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6702084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921335;
	bh=dTmFT7TKTriO5IZguRXx5X7JbuvISHT99RvkbIsNXhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTmJgVhrRqYhpbA0zRfpKumnhSCN214pZXEeilM7bhFHAAYyrpOB55di0To+06Cis
	 uHZZ9YaBfSMvjs6AY8KN4xfKOExOq360f6N9r97F26LfpLPQXhBSyyeLPLRr84WO7e
	 OGWwxx82+Y8zqsBQUlC0tvAwtFv5hHBQD1e7x3l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfEOLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbfEOLSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:18:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A287320818;
        Wed, 15 May 2019 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919109;
        bh=dTmFT7TKTriO5IZguRXx5X7JbuvISHT99RvkbIsNXhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvJX9HCUS7qgP3xRymKYbhD44EHsnZLhd66oJNad7ePhtnIHSRI/zPgRJAZE3Cdr8
         Q4Omaztq648DNyWNwRcJ9wlN1reTh82TIbONa/+QAQZReM9HQrfEWXzC5VvhaxAyUy
         1+vfcnR4gfXgzCXZLG46IufdOCaNdzeKTqKMEz/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruishuang Wang <ruishuangw@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/115] RDMA/vmw_pvrdma: Return the correct opcode when creating WR
Date:   Wed, 15 May 2019 12:55:51 +0200
Message-Id: <20190515090704.619087084@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6325e01b6cdf4636b721cf7259c1616e3cf28ce2 ]

Since the IB_WR_REG_MR opcode value changed, let's set the PVRDMA device
opcodes explicitly.

Reported-by: Ruishuang Wang <ruishuangw@vmware.com>
Fixes: 9a59739bd01f ("IB/rxe: Revise the ib_wr_opcode enum")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Ruishuang Wang <ruishuangw@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    | 35 +++++++++++++++++++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  6 ++++
 include/uapi/rdma/vmw_pvrdma-abi.h           |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index 984aa3484928d..4463e1c1a764e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -407,7 +407,40 @@ static inline enum ib_qp_state pvrdma_qp_state_to_ib(enum pvrdma_qp_state state)
 
 static inline enum pvrdma_wr_opcode ib_wr_opcode_to_pvrdma(enum ib_wr_opcode op)
 {
-	return (enum pvrdma_wr_opcode)op;
+	switch (op) {
+	case IB_WR_RDMA_WRITE:
+		return PVRDMA_WR_RDMA_WRITE;
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		return PVRDMA_WR_RDMA_WRITE_WITH_IMM;
+	case IB_WR_SEND:
+		return PVRDMA_WR_SEND;
+	case IB_WR_SEND_WITH_IMM:
+		return PVRDMA_WR_SEND_WITH_IMM;
+	case IB_WR_RDMA_READ:
+		return PVRDMA_WR_RDMA_READ;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		return PVRDMA_WR_ATOMIC_CMP_AND_SWP;
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		return PVRDMA_WR_ATOMIC_FETCH_AND_ADD;
+	case IB_WR_LSO:
+		return PVRDMA_WR_LSO;
+	case IB_WR_SEND_WITH_INV:
+		return PVRDMA_WR_SEND_WITH_INV;
+	case IB_WR_RDMA_READ_WITH_INV:
+		return PVRDMA_WR_RDMA_READ_WITH_INV;
+	case IB_WR_LOCAL_INV:
+		return PVRDMA_WR_LOCAL_INV;
+	case IB_WR_REG_MR:
+		return PVRDMA_WR_FAST_REG_MR;
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
+		return PVRDMA_WR_MASKED_ATOMIC_CMP_AND_SWP;
+	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
+		return PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD;
+	case IB_WR_REG_SIG_MR:
+		return PVRDMA_WR_REG_SIG_MR;
+	default:
+		return PVRDMA_WR_ERROR;
+	}
 }
 
 static inline enum ib_wc_status pvrdma_wc_status_to_ib(
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index d7162f2b7979a..4d9c99dd366b1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -695,6 +695,12 @@ int pvrdma_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
 			wqe_hdr->ex.imm_data = wr->ex.imm_data;
 
+		if (unlikely(wqe_hdr->opcode == PVRDMA_WR_ERROR)) {
+			*bad_wr = wr;
+			ret = -EINVAL;
+			goto out;
+		}
+
 		switch (qp->ibqp.qp_type) {
 		case IB_QPT_GSI:
 		case IB_QPT_UD:
diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vmw_pvrdma-abi.h
index 912ea1556a0b0..fd801c7be1204 100644
--- a/include/uapi/rdma/vmw_pvrdma-abi.h
+++ b/include/uapi/rdma/vmw_pvrdma-abi.h
@@ -76,6 +76,7 @@ enum pvrdma_wr_opcode {
 	PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD,
 	PVRDMA_WR_BIND_MW,
 	PVRDMA_WR_REG_SIG_MR,
+	PVRDMA_WR_ERROR,
 };
 
 enum pvrdma_wc_status {
-- 
2.20.1



