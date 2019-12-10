Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D06C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8662073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IlcUnQKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfLJRLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:11:18 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44542 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997875; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ieF5xZ/8Wpa93L9RcsyCzivv7UxtKR/9LQicNKqMIN8=;
        b=IlcUnQKg4IzdB3E9wLwHX2m2k57dEFlmC13YAE/M/w8bWBPhvbNgw1xB9Cj9AFNUGkMvOR
        r4/JEfw2OqRIJpF/n39FoReLCaEry/vXnKIzRToetKJ9ftRqTf5CKp9us9iy2FWbtBevrw
        dBXSptNFmRBK0c3JglRmcjzP0FrKUA4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 1/7] usb: musb: dma: Correct parameter passed to IRQ handler
Date:   Tue, 10 Dec 2019 18:11:04 +0100
Message-Id: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ handler was passed a pointer to a struct dma_controller, but the
argument was then casted to a pointer to a struct musb_dma_controller.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Rebase on 5.4-rc4
    v3: Rebase on 5.5-rc1

 drivers/usb/musb/musbhsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 5fc6825745f2..2d3751d885b4 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -425,7 +425,7 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	controller->controller.channel_abort = dma_channel_abort;
 
 	if (request_irq(irq, dma_controller_irq, 0,
-			dev_name(musb->controller), &controller->controller)) {
+			dev_name(musb->controller), controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
 		musb_dma_controller_destroy(&controller->controller);
 
-- 
2.24.0

