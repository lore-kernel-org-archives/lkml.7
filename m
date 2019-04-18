Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A089DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AD1218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610565;
	bh=4hGNxzcFmBJluvLlOhgi5yAixVmolzW5Xa0IA3Pq6i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxjBAIES7cuIFzF6myCFoKBUDOc+hwgjcrVU4S5MT5xDXaTf3sktX0BQN+L/8btb4
	 AIeuk6P3AhY+X6NT4cz30Mae2WQgFdrTlhht/0djjcTEkonY2HxCFreEU5CCWkhq8+
	 MTMP3l3+obvlcIWgNRueVZaOhNB2O+hz55AjRzAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfDRSCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390786AbfDRSCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62058218A1;
        Thu, 18 Apr 2019 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610559;
        bh=4hGNxzcFmBJluvLlOhgi5yAixVmolzW5Xa0IA3Pq6i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AK+dOu2lzwqwpv6tKLj+XvyJ6O7ibPf9mpFEFGXJPw30dJnoQHJ4J4mlhgtyV6NAa
         /5ieovu+OcYG393r4Ns4N1vbIqwmufq3YDdR1WFYK7WC2Tug41vbFMHYN4Wmrl0i2R
         eryAl6vCKyHZqgaOmXkp5X3JbrDb8XDG66weAarI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 108/110] IB/hfi1: Failed to drain send queue when QP is put into error state
Date:   Thu, 18 Apr 2019 19:57:37 +0200
Message-Id: <20190418160447.737038054@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

commit 662d66466637862ef955f7f6e78a286d8cf0ebef upstream.

When a QP is put into error state, all pending requests in the send work
queue should be drained. The following sequence of events could lead to a
failure, causing a request to hang:

(1) The QP builds a packet and tries to send through SDMA engine.
    However, PIO engine is still busy. Consequently, this packet is put on
    the QP's tx list and the QP is put on the PIO waiting list. The field
    qp->s_flags is set with HFI1_S_WAIT_PIO_DRAIN;

(2) The QP is put into error state by the user application and
    notify_error_qp() is called, which removes the QP from the PIO waiting
    list and the packet from the QP's tx list. In addition, qp->s_flags is
    cleared of RVT_S_ANY_WAIT_IO bits, which does not include
    HFI1_S_WAIT_PIO_DRAIN bit;

(3) The hfi1_schdule_send() function is called to drain the QP's send
    queue. Subsequently, hfi1_do_send() is called. Since the flag bit
    HFI1_S_WAIT_PIO_DRAIN is set in qp->s_flags, hfi1_send_ok() fails.  As
    a result, hfi1_do_send() bails out without draining any request from
    the send queue;

(4) The PIO engine completes the sending and tries to wake up any QP on
    its waiting list. But the QP has been removed from the PIO waiting
    list and therefore is kept in sleep forever.

The fix is to clear qp->s_flags of HFI1_S_ANY_WAIT_IO bits in step (2).
HFI1_S_ANY_WAIT_IO includes RVT_S_ANY_WAIT_IO and HFI1_S_WAIT_PIO_DRAIN.

Fixes: 2e2ba09e48b7 ("IB/rdmavt, IB/hfi1: Create device dependent s_flags")
Cc: <stable@vger.kernel.org> # 4.19.x+
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/infiniband/hw/hfi1/qp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -784,7 +784,7 @@ void notify_error_qp(struct rvt_qp *qp)
 		write_seqlock(lock);
 		if (!list_empty(&priv->s_iowait.list) &&
 		    !(qp->s_flags & RVT_S_BUSY)) {
-			qp->s_flags &= ~RVT_S_ANY_WAIT_IO;
+			qp->s_flags &= ~HFI1_S_ANY_WAIT_IO;
 			list_del_init(&priv->s_iowait.list);
 			priv->s_iowait.lock = NULL;
 			rvt_put_qp(qp);


