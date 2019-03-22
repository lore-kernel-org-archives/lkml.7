Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13192183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254066;
	bh=jaOKnZvxeB3E+wqp9LaOdzjY/TeRb5x60MgkG2Rg8wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcH8U30lCCK3kHw+g2iPvYoTUgdBJ1cs52aBkwlCBRRrHFHcOxFnS/f6Mo3VpMyEG
	 A4eRTL6MVQY4w9ruWeLl541FbEaqd70XlQGlQCb+uus1D9USvXHb9is/nlfXscWfze
	 MiwEp+L3FGXUr47oT1EoDyiv/ihbAy5/LFlSejIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfCVL1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbfCVL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C103D2183E;
        Fri, 22 Mar 2019 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254061;
        bh=jaOKnZvxeB3E+wqp9LaOdzjY/TeRb5x60MgkG2Rg8wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB6sOueBfg1zCAEW9Y7C126Utfap73GWA0LJsQEHos81yQJ2SnbOg7tYUEHRC5ask
         WCrGLDF7YfXOh4H1Y+gGa05DvQpv5gpFNeJhFJoi155d5gxElV75IuS/bZwhruXKSr
         W7xqDNttdz1zJ+ixzAjlVaDyhhUnQhCwKDYiq2fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 020/230] RDMA/srp: Rework SCSI device reset handling
Date:   Fri, 22 Mar 2019 12:12:38 +0100
Message-Id: <20190322111238.158845287@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 48396e80fb6526ea5ed267bd84f028bae56d2f9e upstream.

Since .scsi_done() must only be called after scsi_queue_rq() has
finished, make sure that the SRP initiator driver does not call
.scsi_done() while scsi_queue_rq() is in progress. Although
invoking sg_reset -d while I/O is in progress works fine with kernel
v4.20 and before, that is not the case with kernel v5.0-rc1. This
patch avoids that the following crash is triggered with kernel
v5.0-rc1:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000138
CPU: 0 PID: 360 Comm: kworker/0:1H Tainted: G    B             5.0.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:blk_mq_dispatch_rq_list+0x116/0xb10
Call Trace:
 blk_mq_sched_dispatch_requests+0x2f7/0x300
 __blk_mq_run_hw_queue+0xd6/0x180
 blk_mq_run_work_fn+0x27/0x30
 process_one_work+0x4f1/0xa20
 worker_thread+0x67/0x5b0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Cc: <stable@vger.kernel.org>
Fixes: 94a9174c630c ("IB/srp: reduce lock coverage of command completion")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2594,7 +2594,6 @@ static int srp_reset_device(struct scsi_
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
 	struct srp_rdma_ch *ch;
-	int i, j;
 	u8 status;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP reset_device called\n");
@@ -2606,15 +2605,6 @@ static int srp_reset_device(struct scsi_
 	if (status)
 		return FAILED;
 
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
-
-			srp_finish_req(ch, req, scmnd->device, DID_RESET << 16);
-		}
-	}
-
 	return SUCCESS;
 }
 


