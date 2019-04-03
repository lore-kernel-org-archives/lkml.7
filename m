Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54857C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4B6206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCKYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:24:13 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:53838 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDCKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:24:07 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549954800"; 
   d="scan'208";a="26665179"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 03:24:07 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 3 Apr 2019 03:24:06 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH v3 3/3] dmaengine: at_xdmac: only monitor overflow errors for peripheral xfer
Date:   Wed, 3 Apr 2019 12:23:59 +0200
Message-ID: <20190403102359.27698-3-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403102359.27698-1-nicolas.ferre@microchip.com>
References: <20190403102359.27698-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overflow error flag (ROI: Request Overflow Error) is only relevant
for the case when the channel handles a peripheral synchronized transfer.
Not in the case of memory to memory transfer where there is no hardware
request signal.

Remove the use of this interrupt source in such a case. It's based on
the first descriptor which holds the configuration for the whole
linked list transfer.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v3: no change
v2: added Ludovic's tag

 drivers/dma/at_xdmac.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1dd7edaefbdc..06cbe54e4c30 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -308,6 +308,11 @@ static inline int at_xdmac_csize(u32 maxburst)
 	return csize;
 };
 
+static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
+{
+	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
+}
+
 static inline u8 at_xdmac_get_dwidth(u32 cfg)
 {
 	return (cfg & AT_XDMAC_CC_DWIDTH_MASK) >> AT_XDMAC_CC_DWIDTH_OFFSET;
@@ -389,7 +394,13 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
 
 	at_xdmac_chan_write(atchan, AT_XDMAC_CID, 0xffffffff);
-	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE | AT_XDMAC_CIE_ROIE;
+	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE;
+	/*
+	 * Request Overflow Error is only for peripheral synchronized transfers
+	 */
+	if (at_xdmac_chan_is_peripheral_xfer(first->lld.mbr_cfg))
+		reg |= AT_XDMAC_CIE_ROIE;
+
 	/*
 	 * There is no end of list when doing cyclic dma, we need to get
 	 * an interrupt after each periods.
-- 
2.17.1

