Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD30C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3392073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NK0Q5iJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfLJRLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:11:48 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44640 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997879; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA9dGk1g1L3XkhKv8k/AjrabKAl/WeRx/DgLZ3AP0bA=;
        b=NK0Q5iJohdJA3j0hhdvcovFWX92WFBCRtkwOFCKcIvCSZeh/rzZYamODBg4Z5Innxs9be2
        oslDM+WoZo2aBRy0rLhwrHyOVAD1qKZ3KL60SMNiB4dBeJSwRpIWIQRbINFN0gQxYwEace
        Z9GpJTWeShP0Vbq24yfwXV+y6WhAk4g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 5/7] usb: musb: jz4740: Silence error if code is -EPROBE_DEFER
Date:   Tue, 10 Dec 2019 18:11:08 +0100
Message-Id: <20191210171110.62141-5-paul@crapouillou.net>
In-Reply-To: <20191210171110.62141-1-paul@crapouillou.net>
References: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid printing any error message if the error code is -EPROBE_DEFER.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch
    v3: Rebase on 5.5-rc1

 drivers/usb/musb/jz4740.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index bbecfdee6ea1..5e885fa26829 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -81,14 +81,17 @@ static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
 static int jz4740_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller->parent;
+	int err;
 
 	if (dev->of_node)
 		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
 	else
 		musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(musb->xceiv)) {
-		dev_err(dev, "No transceiver configured\n");
-		return PTR_ERR(musb->xceiv);
+		err = PTR_ERR(musb->xceiv);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "No transceiver configured: %d", err);
+		return err;
 	}
 
 	/* Silicon does not implement ConfigData register.
-- 
2.24.0

