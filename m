Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF654C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC7F218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eKhlECiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfCUOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:42:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41366 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCUOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553179373; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Y6zik/OXb4wlKL56pTqENQbTKhIMGne//RzaGCY864Y=;
        b=eKhlECiAwPXB7Rd8KV0/LkWmDTrDj8bQgaejHKKnMa3o4bLht0HOK7UicWVKTPKjs5pnfx
        VQfETFXZiT0Qf5WURG5Jbk/YXm/FbTx+ww0N95o7vPWtcACSuk8QnjuRLZrPcemlFXP2Pi
        u2H5YbDAHAa+qDZQPjjw663UzmWFhTY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: musb: Force-disable pullup on shutdown
Date:   Thu, 21 Mar 2019 15:42:46 +0100
Message-Id: <20190321144246.3547-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the musb is shutdown, for instance when the driver is unloaded,
force-disable the pullup. Otherwise, the host will still see the gadget
device even after the shutdown.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_gadget.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ffe462a657b1..a78a7391031b 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1808,11 +1808,18 @@ int musb_gadget_setup(struct musb *musb)
 
 void musb_gadget_cleanup(struct musb *musb)
 {
+	unsigned long flags;
+
 	if (musb->port_mode == MUSB_HOST)
 		return;
 
 	cancel_delayed_work_sync(&musb->gadget_work);
 	usb_del_gadget_udc(&musb->g);
+
+	/* Force-disable the pull-up */
+	spin_lock_irqsave(&musb->lock, flags);
+	musb_pullup(musb, 0);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 /*
-- 
2.11.0

