Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B9A206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411434;
	bh=yLIBXgIYg42usoCHmf+dkwStU3KhRHWdYsmEaixheZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKaFJtR9VZ1gLBN3rUujZhxL4N5je5b4OI2tY2J3z8PXDK0VghM6jFuLbZx24z0S9
	 7f1sxIkRUGycV7DvNx7BM7o+eDXvddN8ry/UwxTeh8VMhTYPt3s5MY2/fbz6FNAkNe
	 pumXCR5UmvZ6O7RMPNC2CfQBUHg00XGUHHR97UQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfCLRXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfCLRR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:57 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BE821850;
        Tue, 12 Mar 2019 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411077;
        bh=yLIBXgIYg42usoCHmf+dkwStU3KhRHWdYsmEaixheZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ooe2/0+Zc5K8M2M8vk4CgUgrSAgD7aplOCcPz2lLcOyVb7+05XI1hNYPNbnxiOXmp
         EW+C0qfuwFYgMJqpTUSg719jIkH81UEFBXdc57KF0ibeR2MPC4lhLNAKakcxh8YX9e
         moglffRDGNxmsoikkFj7AikFlTs7viIDF1IG2BfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 71/96] dmaengine: at_xdmac: Fix wrongfull report of a channel as in use
Date:   Tue, 12 Mar 2019 10:10:29 -0700
Message-Id: <20190312171039.978394570@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index ee7b48d5243c..b222dd7afe8e 100644
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



