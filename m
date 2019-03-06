Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA69C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2F2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfCFLrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:01 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:48549 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729566AbfCFLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:46:58 -0500
X-UUID: 3a0e664bd89f470a900163194d68004b-20190306
X-UUID: 3a0e664bd89f470a900163194d68004b-20190306
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1614344376; Wed, 06 Mar 2019 19:46:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:47 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 03/11] usb: mtu3: remove unnecessary local variable @req
Date:   Wed, 6 Mar 2019 19:46:15 +0800
Message-ID: <1551872783-13707-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable @req is unnecessary in qmu_tx_zlp_error_handler,
so remove it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_qmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 09f19f70fe8f..f4b5431264c1 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -382,16 +382,13 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 	struct mtu3_gpd_ring *ring = &mep->gpd_ring;
 	void __iomem *mbase = mtu->mac_base;
 	struct qmu_gpd *gpd_current = NULL;
-	struct usb_request *req = NULL;
 	struct mtu3_request *mreq;
 	dma_addr_t cur_gpd_dma;
 	u32 txcsr = 0;
 	int ret;
 
 	mreq = next_request(mep);
-	if (mreq && mreq->request.length == 0)
-		req = &mreq->request;
-	else
+	if (mreq && mreq->request.length != 0)
 		return;
 
 	cur_gpd_dma = read_txq_cur_addr(mbase, epnum);
@@ -402,7 +399,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 		return;
 	}
 
-	dev_dbg(mtu->dev, "%s send ZLP for req=%p\n", __func__, req);
+	dev_dbg(mtu->dev, "%s send ZLP for req=%p\n", __func__, mreq);
 
 	mtu3_clrbits(mbase, MU3D_EP_TXCR0(mep->epnum), TX_DMAREQEN);
 
-- 
2.20.1

