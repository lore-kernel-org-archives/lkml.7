Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC12184B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998491;
	bh=IFricLxjZ2CbigobXvKrwRQG/+/LFZejjFUj5/eHWZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ospZ46LHPfnKUYcAUTx9s92XP/YeCCRlgda0blXgeZIcmxZkH8Xm+6gkVos2k7CeH
	 iW5gN+j+SiySLlUZvCtnd3S5uZov/8eep0wWYZh+Mn73Ew81zvkI7/PlkgolGHGVM6
	 oNKwWpAQEJ056RQaJ6eMx4r7iohU03Go9mOMLDI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbfGXUBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405422AbfGXUB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:01:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30ED72173B;
        Wed, 24 Jul 2019 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998486;
        bh=IFricLxjZ2CbigobXvKrwRQG/+/LFZejjFUj5/eHWZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNXgSFpTZLoixMUXSAHlzsF9dCkheRAtvaP7ZcBJgOL//Vdx0jTqS8PcLCwk2tGRJ
         jIKY0kdcwhWjDDhDF41ORDdoF4juSRCK6hMEZStNBTywrVOeT5tlFfAtzRogmaEJad
         +eWjM276RqXy3Sy9AzcvxkvTcsNuy44PQvGQ7k9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/271] wil6210: fix spurious interrupts in 3-msi
Date:   Wed, 24 Jul 2019 21:18:00 +0200
Message-Id: <20190724191656.239203362@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e10b0eddd5235aa5aef4e40b970e34e735611a80 ]

Interrupt is set in ICM (ICR & ~IMV) rising trigger.
As the driver masks the IRQ after clearing it, there can
be a race where an additional spurious interrupt is triggered
when the driver unmask the IRQ.
This can happen in case HW triggers an interrupt after the clear
and before the mask.

To prevent the second spurious interrupt the driver needs to mask the
IRQ before reading and clearing it.

Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 65 ++++++++++++--------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index 5d287a8e1b45..0655cd884514 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -296,21 +296,24 @@ void wil_configure_interrupt_moderation(struct wil6210_priv *wil)
 static irqreturn_t wil6210_irq_rx(int irq, void *cookie)
 {
 	struct wil6210_priv *wil = cookie;
-	u32 isr = wil_ioread32_and_clear(wil->csr +
-					 HOSTADDR(RGF_DMA_EP_RX_ICR) +
-					 offsetof(struct RGF_ICR, ICR));
+	u32 isr;
 	bool need_unmask = true;
 
+	wil6210_mask_irq_rx(wil);
+
+	isr = wil_ioread32_and_clear(wil->csr +
+				     HOSTADDR(RGF_DMA_EP_RX_ICR) +
+				     offsetof(struct RGF_ICR, ICR));
+
 	trace_wil6210_irq_rx(isr);
 	wil_dbg_irq(wil, "ISR RX 0x%08x\n", isr);
 
 	if (unlikely(!isr)) {
 		wil_err_ratelimited(wil, "spurious IRQ: RX\n");
+		wil6210_unmask_irq_rx(wil);
 		return IRQ_NONE;
 	}
 
-	wil6210_mask_irq_rx(wil);
-
 	/* RX_DONE and RX_HTRSH interrupts are the same if interrupt
 	 * moderation is not used. Interrupt moderation may cause RX
 	 * buffer overflow while RX_DONE is delayed. The required
@@ -355,21 +358,24 @@ static irqreturn_t wil6210_irq_rx(int irq, void *cookie)
 static irqreturn_t wil6210_irq_rx_edma(int irq, void *cookie)
 {
 	struct wil6210_priv *wil = cookie;
-	u32 isr = wil_ioread32_and_clear(wil->csr +
-					 HOSTADDR(RGF_INT_GEN_RX_ICR) +
-					 offsetof(struct RGF_ICR, ICR));
+	u32 isr;
 	bool need_unmask = true;
 
+	wil6210_mask_irq_rx_edma(wil);
+
+	isr = wil_ioread32_and_clear(wil->csr +
+				     HOSTADDR(RGF_INT_GEN_RX_ICR) +
+				     offsetof(struct RGF_ICR, ICR));
+
 	trace_wil6210_irq_rx(isr);
 	wil_dbg_irq(wil, "ISR RX 0x%08x\n", isr);
 
 	if (unlikely(!isr)) {
 		wil_err(wil, "spurious IRQ: RX\n");
+		wil6210_unmask_irq_rx_edma(wil);
 		return IRQ_NONE;
 	}
 
-	wil6210_mask_irq_rx_edma(wil);
-
 	if (likely(isr & BIT_RX_STATUS_IRQ)) {
 		wil_dbg_irq(wil, "RX status ring\n");
 		isr &= ~BIT_RX_STATUS_IRQ;
@@ -403,21 +409,24 @@ static irqreturn_t wil6210_irq_rx_edma(int irq, void *cookie)
 static irqreturn_t wil6210_irq_tx_edma(int irq, void *cookie)
 {
 	struct wil6210_priv *wil = cookie;
-	u32 isr = wil_ioread32_and_clear(wil->csr +
-					 HOSTADDR(RGF_INT_GEN_TX_ICR) +
-					 offsetof(struct RGF_ICR, ICR));
+	u32 isr;
 	bool need_unmask = true;
 
+	wil6210_mask_irq_tx_edma(wil);
+
+	isr = wil_ioread32_and_clear(wil->csr +
+				     HOSTADDR(RGF_INT_GEN_TX_ICR) +
+				     offsetof(struct RGF_ICR, ICR));
+
 	trace_wil6210_irq_tx(isr);
 	wil_dbg_irq(wil, "ISR TX 0x%08x\n", isr);
 
 	if (unlikely(!isr)) {
 		wil_err(wil, "spurious IRQ: TX\n");
+		wil6210_unmask_irq_tx_edma(wil);
 		return IRQ_NONE;
 	}
 
-	wil6210_mask_irq_tx_edma(wil);
-
 	if (likely(isr & BIT_TX_STATUS_IRQ)) {
 		wil_dbg_irq(wil, "TX status ring\n");
 		isr &= ~BIT_TX_STATUS_IRQ;
@@ -446,21 +455,24 @@ static irqreturn_t wil6210_irq_tx_edma(int irq, void *cookie)
 static irqreturn_t wil6210_irq_tx(int irq, void *cookie)
 {
 	struct wil6210_priv *wil = cookie;
-	u32 isr = wil_ioread32_and_clear(wil->csr +
-					 HOSTADDR(RGF_DMA_EP_TX_ICR) +
-					 offsetof(struct RGF_ICR, ICR));
+	u32 isr;
 	bool need_unmask = true;
 
+	wil6210_mask_irq_tx(wil);
+
+	isr = wil_ioread32_and_clear(wil->csr +
+				     HOSTADDR(RGF_DMA_EP_TX_ICR) +
+				     offsetof(struct RGF_ICR, ICR));
+
 	trace_wil6210_irq_tx(isr);
 	wil_dbg_irq(wil, "ISR TX 0x%08x\n", isr);
 
 	if (unlikely(!isr)) {
 		wil_err_ratelimited(wil, "spurious IRQ: TX\n");
+		wil6210_unmask_irq_tx(wil);
 		return IRQ_NONE;
 	}
 
-	wil6210_mask_irq_tx(wil);
-
 	if (likely(isr & BIT_DMA_EP_TX_ICR_TX_DONE)) {
 		wil_dbg_irq(wil, "TX done\n");
 		isr &= ~BIT_DMA_EP_TX_ICR_TX_DONE;
@@ -532,20 +544,23 @@ static bool wil_validate_mbox_regs(struct wil6210_priv *wil)
 static irqreturn_t wil6210_irq_misc(int irq, void *cookie)
 {
 	struct wil6210_priv *wil = cookie;
-	u32 isr = wil_ioread32_and_clear(wil->csr +
-					 HOSTADDR(RGF_DMA_EP_MISC_ICR) +
-					 offsetof(struct RGF_ICR, ICR));
+	u32 isr;
+
+	wil6210_mask_irq_misc(wil, false);
+
+	isr = wil_ioread32_and_clear(wil->csr +
+				     HOSTADDR(RGF_DMA_EP_MISC_ICR) +
+				     offsetof(struct RGF_ICR, ICR));
 
 	trace_wil6210_irq_misc(isr);
 	wil_dbg_irq(wil, "ISR MISC 0x%08x\n", isr);
 
 	if (!isr) {
 		wil_err(wil, "spurious IRQ: MISC\n");
+		wil6210_unmask_irq_misc(wil, false);
 		return IRQ_NONE;
 	}
 
-	wil6210_mask_irq_misc(wil, false);
-
 	if (isr & ISR_MISC_FW_ERROR) {
 		u32 fw_assert_code = wil_r(wil, wil->rgf_fw_assert_code_addr);
 		u32 ucode_assert_code =
-- 
2.20.1



