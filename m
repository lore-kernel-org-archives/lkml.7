Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582C2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ckoe/WcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfLJRMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:12:00 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44680 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997880; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2aUsQE1DKgvq3JL2eyia+DJerAH/OPdkjkm9YCiprVI=;
        b=ckoe/WcJW9nAej0d598EGa+W+KhVYQIfib3owkcpmcgkVEmMUw4QmFQbiwsRMB9kcAXoqS
        ETDTiS5Ssy3e0+KhVH6LAeooSTa+mYmgYFWLktO0MTo5K1y/zEwXUqvQ2rYOWcODvpmZvI
        8DXNMhc7Q/vGd+TndWsgjgFOLOxUcWQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 7/7] usb: musb: jz4740: Disable pullup at init
Date:   Tue, 10 Dec 2019 18:11:10 +0100
Message-Id: <20191210171110.62141-7-paul@crapouillou.net>
In-Reply-To: <20191210171110.62141-1-paul@crapouillou.net>
References: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pullup may be already enabled before the driver is initialized.
It has to be disabled at init time, as we cannot guarantee that a gadget
driver will be bound to the UDC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3: New patch

 drivers/usb/musb/jz4740.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index f948eca654f3..1af9e4053312 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -75,6 +75,7 @@ static const struct musb_hdrc_config jz4740_musb_config = {
 static int jz4740_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller->parent;
+	u8 power;
 	int err;
 
 	if (dev->of_node)
@@ -97,6 +98,14 @@ static int jz4740_musb_init(struct musb *musb)
 	musb->isr = jz4740_musb_interrupt;
 	musb->dma_share_usb_irq = true;
 
+	/*
+	 * If the SoC booted from USB the pullup might still be set.
+	 * Disable it until a gadget is bound.
+	 */
+	power = musb_readb(musb->mregs, MUSB_POWER);
+	power &= ~MUSB_POWER_SOFTCONN;
+	musb_writeb(musb->mregs, MUSB_POWER, power);
+
 	return 0;
 }
 
-- 
2.24.0

