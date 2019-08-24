Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0FCC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2692146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="FDKi03sX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JePkrS4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfHXRuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 13:50:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34495 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfHXRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:50:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 35AC5210DC;
        Sat, 24 Aug 2019 13:50:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 24 Aug 2019 13:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=8Wtw1vtZ5NpN95p5+pBlk0n3xz
        +nskk3VGn79kzaP3k=; b=FDKi03sXVcLNLCAKXeMNZPS1GXyGmBDiJgGj9tZrT1
        2E85/X9qdpIljjdi5LZ2M0EVj8MmkdTZBACKqNYyObyG//eM9/AGlVJHlYkZ0xws
        CLDR8wZ4IU+nISwHhkhqsWT+YP/xQR1map8PRzhhtw/W4K/IESW7XmMq8+Ebduid
        759NYtVWklowFKJ/p1RwMO8fn9vtrZKcRCU76S7JlnRtRN5Vonvq+9cEMrIDAYVt
        Y3dfL05VjByA9ciBepaPJ8oj8iZVV1hdFWkVlPvbKjj2qyPWAE9L4IzuPU8pujfO
        lI2s+PydZ+EALADPzM4DWXVwBQo9ZZlXlWRsJFtkaZ5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8Wtw1vtZ5NpN95p5+
        pBlk0n3xz+nskk3VGn79kzaP3k=; b=JePkrS4ulA/ZIhjXYnZuqK/YIw3G340mr
        SFVMpMP0HjDUE8S8XmlUyl9cxaXXE17xaKzhr+6eDTbyXl7/syBIgujXfx6iG5Tc
        6VoEzfGWLYyrEfNRncBptnbVFZcIcDPap0i28IvkVF0omBqDImr3kEUKJXc0ohvs
        INsNmvt3G2KF5oBmMsTZ5qLH5ty6Kqwg4rHOGVNd5Ufzt86Fp6HdUsTxNvk7L1ez
        wPY92j6udbfEiaYAxXLj2q4VICy3pHWCtls6Og1Qlb75mz58PdYAZ3x9wMA9INVf
        KeYCVMXmqoSwog5vr3QLUQMBGo9LEIvXlW1ZqaFZZoOUAlyKtdEBg==
X-ME-Sender: <xms:0XhhXfG5yOMcRZxxO5t9pRvnOtCIdJEbhYYqFiHuS4C3pFP9zk7r9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehtddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:0XhhXQmn1lxwowupyNJheso6Z3-KUeO-YBiHZL2rRqp0S0Fd_4pjrg>
    <xmx:0XhhXcIhbu07u1j_6MPs4nWjiSaOTe8g6Jz7p3m1-j2cvk7z0hVMyA>
    <xmx:0XhhXRa1D3T_VA-j7-agciLov-g4xWa6fgzcs1z_UmDTmlsehpR7Fg>
    <xmx:1HhhXcd8_1mvgTjJ1WDXPMWFItE5qH64ezmy5zVSR47otXKNAcsAjw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18CDB8005A;
        Sat, 24 Aug 2019 13:50:09 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <sboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] bus: sunxi-rsb: Make interrupt handling more robust
Date:   Sat, 24 Aug 2019 12:50:13 -0500
Message-Id: <20190824175013.28840-1-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RSB controller has two registers for controlling interrupt inputs:
RSB_INTE, which has bits for each possible interrupt, and the global
interrupt enable bit in RSB_CTRL.

Currently, we enable the bits in RSB_INTE before each transfer, but this
is unnecessary because we never disable them. Move the initialization of
RSB_INTE so it is done only once.

We also set the global interrupt enable bit before each transfer. Unlike
other bits in RSB_CTRL, this bit is cleared by writing a zero. Thus, we
clear the bit in the post-timeout cleanup code, so note that in the
comment.

However, if we do receive an interrupt, we do not clear the bit. Nor do
we clear interrupt statuses before starting a transfer. Thus, if some
other driver uses the RSB bus while Linux is suspended (as both Trusted
Firmware and SCP firmware do to control the PMIC), we receive spurious
interrupts upon resume. This causes false completion of a transfer, and
the next transfer starts prematurely, causing a LOAD_BSY condition. The
end result is that some transfers at resume fail with -EBUSY.

With this patch, all transfers reliably succeed during/after resume.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bus/sunxi-rsb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index be79d6c6a4e4..b8043b58568a 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -274,7 +274,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 	reinit_completion(&rsb->complete);
 
 	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
-	       rsb->regs + RSB_INTE);
+	       rsb->regs + RSB_INTS);
 	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
 	       rsb->regs + RSB_CTRL);
 
@@ -282,7 +282,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 					    msecs_to_jiffies(100))) {
 		dev_dbg(rsb->dev, "RSB timeout\n");
 
-		/* abort the transfer */
+		/* abort the transfer and disable interrupts */
 		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
 
 		/* clear any interrupt flags */
@@ -480,6 +480,9 @@ static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
 	status = readl(rsb->regs + RSB_INTS);
 	rsb->status = status;
 
+	/* Disable any further interrupts */
+	writel(0, rsb->regs + RSB_CTRL);
+
 	/* Clear interrupts */
 	status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
 		   RSB_INTS_TRANS_OVER);
@@ -718,6 +721,9 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 		goto err_reset_assert;
 	}
 
+	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
+	       rsb->regs + RSB_INTE);
+
 	/* initialize all devices on the bus into RSB mode */
 	ret = sunxi_rsb_init_device_mode(rsb);
 	if (ret)
-- 
2.21.0

