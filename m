Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C78C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0F2183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368265;
	bh=BVykPxi92+rozj/jGCbVg+Budb7fEO6Vj8Ki72MTWLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHTQsqoj/1ln3GC+TpBTbMoAgfUkehHchovlJoJ2SMddNQuGe/pFgQH2tq/GuhZIA
	 TSgAGE9mRO698B121Gdh7Mgt3iR3wepL+pAnGTAf1bHESvYS9x7uf1mH8iJ8MZ1L5h
	 +tAgtJRfr65WUYiXFbWNVPKU21aSgka0P+aW8qoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfDDI5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730039AbfDDI5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C8552075E;
        Thu,  4 Apr 2019 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368261;
        bh=BVykPxi92+rozj/jGCbVg+Budb7fEO6Vj8Ki72MTWLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvnuWmpZ2cioJFQhCm8xjTfS/3QNOowhWMqW+0jkqkQ0MlLEyJJCElimR1sq174U7
         CvEg5sy3gdb3NPH+ao9ppZGjX9RQ2fZ5zoHtNkO8SXzIcM3bNdm1CKH0L/WJ+GphfZ
         JmRDbJxl3znFgSOdmBxoLtASCtTSatgR+xd4PF3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/121] iw_cxgb4: fix srqidx leak during connection abort
Date:   Thu,  4 Apr 2019 10:47:48 +0200
Message-Id: <20190404084549.595166765@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f368ff188ae4b3ef6f740a15999ea0373261b619 ]

When an application aborts the connection by moving QP from RTS to ERROR,
then iw_cxgb4's modify_rc_qp() RTS->ERROR logic sets the
*srqidxp to 0 via t4_set_wq_in_error(&qhp->wq, 0), and aborts the
connection by calling c4iw_ep_disconnect().

c4iw_ep_disconnect() does the following:
 1. sends up a close_complete_upcall(ep, -ECONNRESET) to libcxgb4.
 2. sends abort request CPL to hw.

But, since the close_complete_upcall() is sent before sending the
ABORT_REQ to hw, libcxgb4 would fail to release the srqidx if the
connection holds one. Because, the srqidx is passed up to libcxgb4 only
after corresponding ABORT_RPL is processed by kernel in abort_rpl().

This patch handle the corner-case by moving the call to
close_complete_upcall() from c4iw_ep_disconnect() to abort_rpl().  So that
libcxgb4 is notified about the -ECONNRESET only after abort_rpl(), and
libcxgb4 can relinquish the srqidx properly.

Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index daf7a56e5d7e..e17f11782821 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1884,8 +1884,10 @@ static int abort_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 	}
 	mutex_unlock(&ep->com.mutex);
 
-	if (release)
+	if (release) {
+		close_complete_upcall(ep, -ECONNRESET);
 		release_ep_resources(ep);
+	}
 	c4iw_put_ep(&ep->com);
 	return 0;
 }
@@ -3584,7 +3586,6 @@ int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp)
 	if (close) {
 		if (abrupt) {
 			set_bit(EP_DISC_ABORT, &ep->com.history);
-			close_complete_upcall(ep, -ECONNRESET);
 			ret = send_abort(ep);
 		} else {
 			set_bit(EP_DISC_CLOSE, &ep->com.history);
-- 
2.19.1



