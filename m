Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA1CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D247021920
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfCUCyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:54:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:7064 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727437AbfCUCyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:54:38 -0400
X-UUID: 2792c8ca4da14b6cabb5447f7c31d10e-20190321
X-UUID: 2792c8ca4da14b6cabb5447f7c31d10e-20190321
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 67383489; Thu, 21 Mar 2019 10:54:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 10:54:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 10:54:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 03/11] usb: mtu3: remove unnecessary local variable @req
Date:   Thu, 21 Mar 2019 10:53:41 +0800
Message-ID: <1553136829-14712-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
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

