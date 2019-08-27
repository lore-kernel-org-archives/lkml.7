Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CE3206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893261;
	bh=qodxeXGYfcOG3YludvI4FKuvMQVlM8+iqthkdXfuZj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JnufUQlpFL3E2oxK+yxst9ibfuKtvB9h8gqoa8qP7zQUX3SFoewTOZS7w2Knh+wCL
	 yXRHHqctoCzwdExOFrfuJyMQ6dn3Q0nxSEKN2wJ/JTsDEPV/MODRh+K/oDZhLnHR2A
	 K/95qAAdaDNClhK7mHTT7gMOqmgY914Riv5InFKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfH0IHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733133AbfH0IHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:07:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52715217F5;
        Tue, 27 Aug 2019 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893234;
        bh=qodxeXGYfcOG3YludvI4FKuvMQVlM8+iqthkdXfuZj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZPrZwIGrf6CDn6W2PfnzzXbT19rBUXRq9PcfYwIVVj181Y5F2IZeSPt9/lxtOhWf
         vAiGoFmIjNGMTluB3ki6wC0meS+uZyavgz5+Tv6m1lCJj7h0m5PkJ2X3ZZaig/waZA
         CGrjoZXb3H4mmOwtQeimHk0MbS+Xv9HKnUmcczIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 5.2 155/162] IB/hfi1: Drop stale TID RDMA packets
Date:   Tue, 27 Aug 2019 09:51:23 +0200
Message-Id: <20190827072744.196060505@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

commit d58c1834bf0d218a0bc00f8fb44874551b21da84 upstream.

In a congested fabric with adaptive routing enabled, traces show that
the sender could receive stale TID RDMA NAK packets that contain newer
KDETH PSNs and older Verbs PSNs. If not dropped, these packets could
cause the incorrect rewinding of the software flows and the incorrect
completion of TID RDMA WRITE requests, and eventually leading to memory
corruption and kernel crash.

The current code drops stale TID RDMA ACK/NAK packets solely based
on KDETH PSNs, which may lead to erroneous processing. This patch
fixes the issue by also checking the Verbs PSN. Addition checks are
added before rewinding the TID RDMA WRITE DATA packets.

Fixes: 9e93e967f7b4 ("IB/hfi1: Add a function to receive TID RDMA ACK packet")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Link: https://lore.kernel.org/r/20190815192033.105923.44192.stgit@awfm-01.aw.intel.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/tid_rdma.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -4480,7 +4480,7 @@ void hfi1_rc_rcv_tid_rdma_ack(struct hfi
 	struct rvt_swqe *wqe;
 	struct tid_rdma_request *req;
 	struct tid_rdma_flow *flow;
-	u32 aeth, psn, req_psn, ack_psn, fspsn, resync_psn, ack_kpsn;
+	u32 aeth, psn, req_psn, ack_psn, flpsn, resync_psn, ack_kpsn;
 	unsigned long flags;
 	u16 fidx;
 
@@ -4509,6 +4509,9 @@ void hfi1_rc_rcv_tid_rdma_ack(struct hfi
 		ack_kpsn--;
 	}
 
+	if (unlikely(qp->s_acked == qp->s_tail))
+		goto ack_op_err;
+
 	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
 
 	if (wqe->wr.opcode != IB_WR_TID_RDMA_WRITE)
@@ -4521,7 +4524,8 @@ void hfi1_rc_rcv_tid_rdma_ack(struct hfi
 	trace_hfi1_tid_flow_rcv_tid_ack(qp, req->acked_tail, flow);
 
 	/* Drop stale ACK/NAK */
-	if (cmp_psn(psn, full_flow_psn(flow, flow->flow_state.spsn)) < 0)
+	if (cmp_psn(psn, full_flow_psn(flow, flow->flow_state.spsn)) < 0 ||
+	    cmp_psn(req_psn, flow->flow_state.resp_ib_psn) < 0)
 		goto ack_op_err;
 
 	while (cmp_psn(ack_kpsn,
@@ -4683,8 +4687,12 @@ done:
 		switch ((aeth >> IB_AETH_CREDIT_SHIFT) &
 			IB_AETH_CREDIT_MASK) {
 		case 0: /* PSN sequence error */
+			if (!req->flows)
+				break;
 			flow = &req->flows[req->acked_tail];
-			fspsn = full_flow_psn(flow, flow->flow_state.spsn);
+			flpsn = full_flow_psn(flow, flow->flow_state.lpsn);
+			if (cmp_psn(psn, flpsn) > 0)
+				break;
 			trace_hfi1_tid_flow_rcv_tid_ack(qp, req->acked_tail,
 							flow);
 			req->r_ack_psn = mask_psn(be32_to_cpu(ohdr->bth[2]));


