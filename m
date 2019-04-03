Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF461C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:10:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49692 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:10:12 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549954800"; 
   d="scan'208";a="30724118"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 03:10:11 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 3 Apr 2019 03:10:10 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH v2 2/3] dmaengine: at_xdmac: enhance channel errors handling in tasklet
Date:   Wed, 3 Apr 2019 12:09:52 +0200
Message-ID: <20190403100953.26199-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403100953.26199-1-nicolas.ferre@microchip.com>
References: <20190403100953.26199-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement the identification of errors with stoping the channel and
dumping the descriptor that led to the error case.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: added Ludovic's tag
    address Vinod's comments (typo, comment, empty line before logical blocks)

 drivers/dma/at_xdmac.c | 48 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 37a269420435..b7117474a10d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1575,6 +1575,46 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 		dmaengine_desc_get_callback_invoke(txd, NULL);
 }
 
+static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	struct at_xdmac_desc	*bad_desc;
+
+	/*
+	 * The descriptor currently at the head of the active list is
+	 * broken. Since we don't have any way to report errors, we'll
+	 * just have to scream loudly and try to continue with other
+	 * descriptors queued (if any).
+	 */
+	if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
+		dev_err(chan2dev(&atchan->chan), "read bus error!!!");
+	if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
+		dev_err(chan2dev(&atchan->chan), "write bus error!!!");
+	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
+		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
+
+	spin_lock_bh(&atchan->lock);
+
+	/* Channel must be disabled first as it's not done automatically */
+	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
+	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
+		cpu_relax();
+
+	bad_desc = list_first_entry(&atchan->xfers_list,
+				    struct at_xdmac_desc,
+				    xfer_node);
+
+	spin_unlock_bh(&atchan->lock);
+
+	/* Print bad descriptor's details if needed */
+	dev_dbg(chan2dev(&atchan->chan),
+		 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
+		 __func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
+		 bad_desc->lld.mbr_ubc);
+
+	/* Then continue with usual descriptor management */
+}
+
 static void at_xdmac_tasklet(unsigned long data)
 {
 	struct at_xdmac_chan	*atchan = (struct at_xdmac_chan *)data;
@@ -1594,12 +1634,8 @@ static void at_xdmac_tasklet(unsigned long data)
 		   || (atchan->irq_status & error_mask)) {
 		struct dma_async_tx_descriptor  *txd;
 
-		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
-			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
-		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
-			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
-		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
-			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
+		if (atchan->irq_status & error_mask)
+			at_xdmac_handle_error(atchan);
 
 		spin_lock(&atchan->lock);
 		desc = list_first_entry(&atchan->xfers_list,
-- 
2.17.1

