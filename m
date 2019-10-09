Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B4C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91CD2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfJIJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:05:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42481 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbfJIJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:05:17 -0400
X-UUID: 81f012e1f9b44c2c851bb795067c102c-20191009
X-UUID: 81f012e1f9b44c2c851bb795067c102c-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 556026422; Wed, 09 Oct 2019 17:05:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:05:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:05:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 1/2] usb: mtu3: add a new function to do status stage
Date:   Wed, 9 Oct 2019 17:04:59 +0800
Message-ID: <1570611900-7112-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 78F6DC5777EFE46E7CDDFEAA2B0951DD3B205190962CA1F84679D165410B24462000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exact a new static function to do status stage

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4da216c99726..df3fd055792f 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -153,6 +153,15 @@ static void ep0_stall_set(struct mtu3_ep *mep0, bool set, u32 pktrdy)
 		set ? "SEND" : "CLEAR", decode_ep0_state(mtu));
 }
 
+static void ep0_do_status_stage(struct mtu3 *mtu)
+{
+	void __iomem *mbase = mtu->mac_base;
+	u32 value;
+
+	value = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
+	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
+}
+
 static int ep0_queue(struct mtu3_ep *mep0, struct mtu3_request *mreq);
 
 static void ep0_dummy_complete(struct usb_ep *ep, struct usb_request *req)
@@ -297,8 +306,7 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 		ep0_load_test_packet(mtu);
 
 	/* send status before entering test mode. */
-	value = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
-	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
+	ep0_do_status_stage(mtu);
 
 	/* wait for ACK status sent by host */
 	readl_poll_timeout_atomic(mbase + U3D_EP0CSR, value,
@@ -632,7 +640,6 @@ __acquires(mtu->lock)
 {
 	struct usb_ctrlrequest setup;
 	struct mtu3_request *mreq;
-	void __iomem *mbase = mtu->mac_base;
 	int handled = 0;
 
 	ep0_read_setup(mtu, &setup);
@@ -668,10 +675,7 @@ __acquires(mtu->lock)
 		mtu->delayed_status = true;
 	} else if (le16_to_cpu(setup.wLength) == 0) { /* no data stage */
 
-		mtu3_writel(mbase, U3D_EP0CSR,
-			(mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS)
-			| EP0_SETUPPKTRDY | EP0_DATAEND);
-
+		ep0_do_status_stage(mtu);
 		/* complete zlp request directly */
 		mreq = next_ep0_request(mtu);
 		if (mreq && !mreq->request.length)
@@ -802,12 +806,9 @@ static int ep0_queue(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	}
 
 	if (mtu->delayed_status) {
-		u32 csr;
 
 		mtu->delayed_status = false;
-		csr = mtu3_readl(mtu->mac_base, U3D_EP0CSR) & EP0_W1C_BITS;
-		csr |= EP0_SETUPPKTRDY | EP0_DATAEND;
-		mtu3_writel(mtu->mac_base, U3D_EP0CSR, csr);
+		ep0_do_status_stage(mtu);
 		/* needn't giveback the request for handling delay STATUS */
 		return 0;
 	}
-- 
2.23.0

