Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0181C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27F21934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254356;
	bh=sVsH8fCbNlGT5dTipVQLZek2ISfRrugONVK4Hni9ICo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+pGPVQZaMRNt4O/7NlsUKGixTlhp6syw7djxj4Egdt9yz1EyhM3TpKPVQdOU9WBT
	 80j5AIdDbGbfoxvrE2CXwAeHPS2kD8TgdNfhSKGxOyWKiZ9rpHRGLsihfZ9/zND2DT
	 R9aua+jQZwBUSCcr1j8nVzqgQeLjwWdYwu9KpnMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfCVLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfCVLc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E9320449;
        Fri, 22 Mar 2019 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254347;
        bh=sVsH8fCbNlGT5dTipVQLZek2ISfRrugONVK4Hni9ICo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXm0lS/PNXey7yJ5n/7F92OhF8Eo3sV9xm20RX56zC2RmolEaX7cBkjcTJFUC4XAP
         llNdwP/zi9vt03hY5l3mu4XvNtt+SO7jKO61qFLvIR17c4DXm6aJWGPlY2q1ClnErh
         1BQeWi4fqrBQziHvbv7TSn6Xaprv78O1INAjNc90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 107/230] dmaengine: at_xdmac: Fix wrongfull report of a channel as in use
Date:   Fri, 22 Mar 2019 12:14:05 +0100
Message-Id: <20190322111244.112563351@linuxfoundation.org>
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

[ Upstream commit dc3f595b6617ebc0307e0ce151e8f2f2b2489b95 ]

atchan->status variable is used to store two different information:
 - pass channel interrupts status from interrupt handler to tasklet;
 - channel information like whether it is cyclic or paused;

This causes a bug when device_terminate_all() is called,
(AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End
of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of
atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when
a new descriptor for a cyclic transfer is created, the driver reports
the channel as in use:

if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
	dev_err(chan2dev(chan), "channel currently used\n");
	return NULL;
}

This patch fixes the bug by adding a different struct member to keep
the interrupts status separated from the channel status bits.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 82a7c89caae2..af24c5bf32d6 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -203,6 +203,7 @@ struct at_xdmac_chan {
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
+	u32				irq_status;
 	unsigned long			status;
 	struct tasklet_struct		tasklet;
 	struct dma_slave_config		sconfig;
@@ -1582,8 +1583,8 @@ static void at_xdmac_tasklet(unsigned long data)
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
 
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
-		 __func__, atchan->status);
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+		__func__, atchan->irq_status);
 
 	error_mask = AT_XDMAC_CIS_RBEIS
 		     | AT_XDMAC_CIS_WBEIS
@@ -1591,15 +1592,15 @@ static void at_xdmac_tasklet(unsigned long data)
 
 	if (at_xdmac_chan_is_cyclic(atchan)) {
 		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
-		   || (atchan->status & error_mask)) {
+	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
+		   || (atchan->irq_status & error_mask)) {
 		struct dma_async_tx_descriptor  *txd;
 
-		if (atchan->status & AT_XDMAC_CIS_RBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
 			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_WBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
 			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_ROIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
 		spin_lock_bh(&atchan->lock);
@@ -1654,7 +1655,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 			atchan = &atxdmac->chan[i];
 			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
-			atchan->status = chan_status & chan_imr;
+			atchan->irq_status = chan_status & chan_imr;
 			dev_vdbg(atxdmac->dma.dev,
 				 "%s: chan%d: imr=0x%x, status=0x%x\n",
 				 __func__, i, chan_imr, chan_status);
@@ -1668,7 +1669,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
 
-			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
+			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
 				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 
 			tasklet_schedule(&atchan->tasklet);
-- 
2.19.1



