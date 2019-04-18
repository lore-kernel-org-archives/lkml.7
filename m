Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A55F2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611221;
	bh=6tgg33U8eaYsQnWBaNoIIW9pos3Z+gZPxNZeAbaTdlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KtqvpjIbrFCOp7z6KHFpwkY3xuoWvLJD65YehJq6J98MI5DuROCKTlZwCj9yd3XwX
	 6R5I71N1/B9v5eNi/qhEO6IgeDfCZibTFi9ED7Yio6sd4WGSuwdWyz31pJ+x1NK9XX
	 nBl9HHmA5KSqw23MmxxJUKr8kTC8J7W6kUVt/5Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbfDRSNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404074AbfDRSNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3492186A;
        Thu, 18 Apr 2019 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611213;
        bh=6tgg33U8eaYsQnWBaNoIIW9pos3Z+gZPxNZeAbaTdlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5AbhS/hYzQjZsMBJvBNRWIggFDb7+YqM6PF8LRaYrij0zoxArYJ7VMJTj0e+1WCG
         AB+aG8NRWHKfkejX8klis+0CykoQBHFbs+cyixju75YGeA/HmRJzq6csjGg8eTTCZ9
         +/W/3y5tQpWT4SVlbFD8/CfDC0WXcAbbvfb3snEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 93/93] IB/hfi1: Failed to drain send queue when QP is put into error state
Date:   Thu, 18 Apr 2019 19:58:11 +0200
Message-Id: <20190418160446.067021267@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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
@@ -833,7 +833,7 @@ void notify_error_qp(struct rvt_qp *qp)
 		write_seqlock(lock);
 		if (!list_empty(&priv->s_iowait.list) &&
 		    !(qp->s_flags & RVT_S_BUSY)) {
-			qp->s_flags &= ~RVT_S_ANY_WAIT_IO;
+			qp->s_flags &= ~HFI1_S_ANY_WAIT_IO;
 			list_del_init(&priv->s_iowait.list);
 			priv->s_iowait.lock = NULL;
 			rvt_put_qp(qp);


