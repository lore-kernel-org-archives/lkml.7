Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9C20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367808;
	bh=Nq7/zn6sPam6YoJESzrggwYN7jHAPVaFO8S+blezE8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ks8gKjo+mfaDau7BUDkN7n+K9MgXY8v2E7cIpM/GO4L00rDRuxzh1L2ndoOMXHvNi
	 /lC30oDplESgQCVSBNNXLaQqhhhcoU3p4awz+dci6UZLZkynFSqKv3RjaWDm0XcM/5
	 NccI3T15pm6gaQijHg0BEtsd1rSFZ5psXhrtrPSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfB1PaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387596AbfB1PJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BCC206B8;
        Thu, 28 Feb 2019 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366592;
        bh=Nq7/zn6sPam6YoJESzrggwYN7jHAPVaFO8S+blezE8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHjKR8eefo0STqWmHPo2Dgk6SZY8+5Zz7DIJZbFn8YGaqK1hXkj2u+W3Th0nYoWDY
         2RIdU08F4IoJmv2M0O6olvxkAxm+Id5ZE0ztSTw6HsnUK3riytgCCwuB5Fh2OvtfU9
         r3HrOGldwhYW8GlqedwRFR3D9T+K1XMQj7BoLCOc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 53/81] dmaengine: at_xdmac: Fix wrongfull report of a channel as in use
Date:   Thu, 28 Feb 2019 10:07:45 -0500
Message-Id: <20190228150813.10256-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

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
index 4e557684f792d..fe69dccfa0c05 100644
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
@@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
 
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
-		 __func__, atchan->status);
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+		__func__, atchan->irq_status);
 
 	error_mask = AT_XDMAC_CIS_RBEIS
 		     | AT_XDMAC_CIS_WBEIS
@@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
 
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
 
 		spin_lock(&atchan->lock);
@@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 			atchan = &atxdmac->chan[i];
 			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
-			atchan->status = chan_status & chan_imr;
+			atchan->irq_status = chan_status & chan_imr;
 			dev_vdbg(atxdmac->dma.dev,
 				 "%s: chan%d: imr=0x%x, status=0x%x\n",
 				 __func__, i, chan_imr, chan_status);
@@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
 
-			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
+			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
 				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 
 			tasklet_schedule(&atchan->tasklet);
-- 
2.19.1

