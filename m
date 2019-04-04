Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D34CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1502214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368655;
	bh=futYYTW+fd3gv41rJ3uZ+KMoM75gHrjnlVIvV5eT8Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQRVH097iUhxIaqkTFv/VQpeCkXxqcwEfoSjAKtlaLpZ4AcsPhzA/n5O+xA90SdSP
	 2YaSqOqlVeK5Gf48Jc+eg4YYy44uFopzV8DQ1ABcjmL73BUnbm0TVgC1Vquqovzwsx
	 GddxWgtvYO6PL56t8MSwNcCN12CbXNeJhhSAnSLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfDDJEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfDDJEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60B52147C;
        Thu,  4 Apr 2019 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368648;
        bh=futYYTW+fd3gv41rJ3uZ+KMoM75gHrjnlVIvV5eT8Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqRM+MpPvKT7wPEa86QzRv5nR4wOkCbRLGqVIEKHoSbN1OghQOa54p3lkavvSKeFU
         YWxZPxa+XWeH+WGoN7a+FhC9Hfa+We35ANCxJaa/tAJl4tZkpGDczkTWwzFb8ky1GL
         L/5rZVYMy/uTM1jRFU7Knnzklq3h+d2R6IRFO3tE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/187] iw_cxgb4: fix srqidx leak during connection abort
Date:   Thu,  4 Apr 2019 10:47:34 +0200
Message-Id: <20190404084608.768122439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 0f83cbec33f3..a68569ec86bf 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1904,8 +1904,10 @@ static int abort_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
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
@@ -3608,7 +3610,6 @@ int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp)
 	if (close) {
 		if (abrupt) {
 			set_bit(EP_DISC_ABORT, &ep->com.history);
-			close_complete_upcall(ep, -ECONNRESET);
 			ret = send_abort(ep);
 		} else {
 			set_bit(EP_DISC_CLOSE, &ep->com.history);
-- 
2.19.1



