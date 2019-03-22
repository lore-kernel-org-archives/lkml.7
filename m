Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731A21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257117;
	bh=WcWHsNNVlV1q3rfuDshAlJVM4NiN5y2gIrAeMPBbTzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJ0O8RSqqbCU4+8ETUk8FibCfRUZy5nFKAQLPokE1VQd5yq+YD+miRrP+Cizb+WLS
	 bOZ4W4RaGdDvJRtkGQhEpI0CwAgrk4ST72T9Y2w/0WpQGqouRa81feZIfzOWvasw37
	 L4we8tVHESFRN16+oQT3QnQYTWmekf+g1cB5sbWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfCVMSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390322AbfCVMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0226E218A1;
        Fri, 22 Mar 2019 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257111;
        bh=WcWHsNNVlV1q3rfuDshAlJVM4NiN5y2gIrAeMPBbTzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+/S20Qi8zD4ZlJNVWrckJoRqakT/efYkUAKnRW7vSx8WZ8BEewAd9z32END12YUw
         znndRJP+S533pYc3FscejJ0SQiooChPsNGrr1YojmHaA0neByZGqV3/apAw35Yq/vl
         NdvmxBVtRT2pWK3sX2wAAddnJEE5HqowTP+utmzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 136/238] IB/rdmavt: Fix concurrency panics in QP post_send and modify to error
Date:   Fri, 22 Mar 2019 12:15:55 +0100
Message-Id: <20190322111306.470949972@linuxfoundation.org>
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

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit d757c60eca9b22f4d108929a24401e0fdecda0b1 upstream.

The RC/UC code path can go through a software loopback. In this code path
the receive side QP is manipulated.

If two threads are working on the QP receive side (i.e. post_send, and
modify_qp to an error state), QP information can be corrupted.

(post_send via loopback)
  set r_sge
  loop
     update r_sge
(modify_qp)
     take r_lock
     update r_sge <---- r_sge is now incorrect
(post_send)
     update r_sge <---- crash, etc.
     ...

This can lead to one of the two following crashes:

 BUG: unable to handle kernel NULL pointer dereference at (null)
  IP:  hfi1_copy_sge+0xf1/0x2e0 [hfi1]
  PGD 8000001fe6a57067 PUD 1fd9e0c067 PMD 0
 Call Trace:
  ruc_loopback+0x49b/0xbc0 [hfi1]
  hfi1_do_send+0x38e/0x3e0 [hfi1]
  _hfi1_do_send+0x1e/0x20 [hfi1]
  process_one_work+0x17f/0x440
  worker_thread+0x126/0x3c0
  kthread+0xd1/0xe0
  ret_from_fork_nospec_begin+0x21/0x21

or:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
  IP:  rvt_clear_mr_refs+0x45/0x370 [rdmavt]
  PGD 80000006ae5eb067 PUD ef15d0067 PMD 0
 Call Trace:
  rvt_error_qp+0xaa/0x240 [rdmavt]
  rvt_modify_qp+0x47f/0xaa0 [rdmavt]
  ib_security_modify_qp+0x8f/0x400 [ib_core]
  ib_modify_qp_with_udata+0x44/0x70 [ib_core]
  modify_qp.isra.23+0x1eb/0x2b0 [ib_uverbs]
  ib_uverbs_modify_qp+0xaa/0xf0 [ib_uverbs]
  ib_uverbs_write+0x272/0x430 [ib_uverbs]
  vfs_write+0xc0/0x1f0
  SyS_write+0x7f/0xf0
  system_call_fastpath+0x1c/0x21

Fix by using the appropriate locking on the receiving QP.

Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
Cc: <stable@vger.kernel.org> #v4.9+
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/qp.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2785,6 +2785,18 @@ again:
 }
 EXPORT_SYMBOL(rvt_copy_sge);
 
+static enum ib_wc_status loopback_qp_drop(struct rvt_ibport *rvp,
+					  struct rvt_qp *sqp)
+{
+	rvp->n_pkt_drops++;
+	/*
+	 * For RC, the requester would timeout and retry so
+	 * shortcut the timeouts and just signal too many retries.
+	 */
+	return sqp->ibqp.qp_type == IB_QPT_RC ?
+		IB_WC_RETRY_EXC_ERR : IB_WC_SUCCESS;
+}
+
 /**
  * ruc_loopback - handle UC and RC loopback requests
  * @sqp: the sending QP
@@ -2857,17 +2869,14 @@ again:
 	}
 	spin_unlock_irqrestore(&sqp->s_lock, flags);
 
-	if (!qp || !(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) ||
+	if (!qp) {
+		send_status = loopback_qp_drop(rvp, sqp);
+		goto serr_no_r_lock;
+	}
+	spin_lock_irqsave(&qp->r_lock, flags);
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) ||
 	    qp->ibqp.qp_type != sqp->ibqp.qp_type) {
-		rvp->n_pkt_drops++;
-		/*
-		 * For RC, the requester would timeout and retry so
-		 * shortcut the timeouts and just signal too many retries.
-		 */
-		if (sqp->ibqp.qp_type == IB_QPT_RC)
-			send_status = IB_WC_RETRY_EXC_ERR;
-		else
-			send_status = IB_WC_SUCCESS;
+		send_status = loopback_qp_drop(rvp, sqp);
 		goto serr;
 	}
 
@@ -3047,6 +3056,7 @@ do_write:
 		     wqe->wr.send_flags & IB_SEND_SOLICITED);
 
 send_comp:
+	spin_unlock_irqrestore(&qp->r_lock, flags);
 	spin_lock_irqsave(&sqp->s_lock, flags);
 	rvp->n_loop_pkts++;
 flush_send:
@@ -3073,6 +3083,7 @@ rnr_nak:
 	}
 	if (sqp->s_rnr_retry_cnt < 7)
 		sqp->s_rnr_retry--;
+	spin_unlock_irqrestore(&qp->r_lock, flags);
 	spin_lock_irqsave(&sqp->s_lock, flags);
 	if (!(ib_rvt_state_ops[sqp->state] & RVT_PROCESS_RECV_OK))
 		goto clr_busy;
@@ -3101,6 +3112,8 @@ err:
 	rvt_rc_error(qp, wc.status);
 
 serr:
+	spin_unlock_irqrestore(&qp->r_lock, flags);
+serr_no_r_lock:
 	spin_lock_irqsave(&sqp->s_lock, flags);
 	rvt_send_complete(sqp, wqe, send_status);
 	if (sqp->ibqp.qp_type == IB_QPT_RC) {


