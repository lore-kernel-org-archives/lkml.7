Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257114;
	bh=Tz/yU3J6RBiMdw7RQPjHS/u+UwGKzaseKox7SeAZ7b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RmWrY9OpRglWiLrln9YbQeGEEtZPZwIy1atGOY3urOqWbjpTCcPxIzH8taQnNduXv
	 6nYXIorMZNI0fFUo00BUMpDDUU5w8dbmGQAq0Eo9H0BMcqHU12pYKLS1iEGwmlYFAB
	 gmF/OZDySOx3rOzNLuTHugvHHWz5PZWNtqqrCTkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfCVMSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389888AbfCVMS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4DD2083D;
        Fri, 22 Mar 2019 12:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257108;
        bh=Tz/yU3J6RBiMdw7RQPjHS/u+UwGKzaseKox7SeAZ7b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBCrbijPgRreuHRCFZgY67r6qHtKKUZYF4MLvOxxc6ETGeMrzOMKcv/wCgtthxiwV
         nBF2ewa0cEuvIS2TprOHXRI1l3pBSLRVxBaOBuTNvi02MvAXXYLQEimCAICT4qD0gF
         X8w6afdbyBLpWfr2ryDxsb2vcKBFLGp7Lxl+W0M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 135/238] IB/rdmavt: Fix loopback send with invalidate ordering
Date:   Fri, 22 Mar 2019 12:15:54 +0100
Message-Id: <20190322111306.416884137@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 38bbc9f0381550d1d227fc57afa08436e36b32fc upstream.

The IBTA spec notes:

o9-5.2.1: For any HCA which supports SEND with Invalidate, upon receiving
an IETH, the Invalidate operation must not take place until after the
normal transport header validation checks have been successfully
completed.

The rdmavt loopback code does the validation after the invalidate.

Fix by relocating the operation specific logic for all SEND variants until
after the validity checks.

Cc: <stable@vger.kernel.org> #v4.20+
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/qp.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2893,18 +2893,8 @@ again:
 		goto send_comp;
 
 	case IB_WR_SEND_WITH_INV:
-		if (!rvt_invalidate_rkey(qp, wqe->wr.ex.invalidate_rkey)) {
-			wc.wc_flags = IB_WC_WITH_INVALIDATE;
-			wc.ex.invalidate_rkey = wqe->wr.ex.invalidate_rkey;
-		}
-		goto send;
-
 	case IB_WR_SEND_WITH_IMM:
-		wc.wc_flags = IB_WC_WITH_IMM;
-		wc.ex.imm_data = wqe->wr.ex.imm_data;
-		/* FALLTHROUGH */
 	case IB_WR_SEND:
-send:
 		ret = rvt_get_rwqe(qp, false);
 		if (ret < 0)
 			goto op_err;
@@ -2912,6 +2902,22 @@ send:
 			goto rnr_nak;
 		if (wqe->length > qp->r_len)
 			goto inv_err;
+		switch (wqe->wr.opcode) {
+		case IB_WR_SEND_WITH_INV:
+			if (!rvt_invalidate_rkey(qp,
+						 wqe->wr.ex.invalidate_rkey)) {
+				wc.wc_flags = IB_WC_WITH_INVALIDATE;
+				wc.ex.invalidate_rkey =
+					wqe->wr.ex.invalidate_rkey;
+			}
+			break;
+		case IB_WR_SEND_WITH_IMM:
+			wc.wc_flags = IB_WC_WITH_IMM;
+			wc.ex.imm_data = wqe->wr.ex.imm_data;
+			break;
+		default:
+			break;
+		}
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:


