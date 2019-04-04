Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C269E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AA/slkH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfDDJsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:48:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38522 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbfDDJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554371267; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Opyb8KhrB2MB98Ju5eXKxdZcdra1hXOw/sp0QdFgVqM=;
        b=AA/slkH3SVqlR2L/oT6/FE9xNhhu4ISJD8wdmAFpTRmSPx3pP6/ecwaqdCpB47tANuRqvu
        2kdPILUL6mffq20u2IqBBTANDvDjAl7CxQhy0XYlkaudeZHXwX0EZG3Qw9u1kqWnfEgN+2
        ZYg71cS1nX3SwG051JQnLA57ieXHVKI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] usb: musb: jz4740: Let the platform probe the PHY
Date:   Thu,  4 Apr 2019 11:47:38 +0200
Message-Id: <20190404094739.23503-2-paul@crapouillou.net>
In-Reply-To: <20190404094739.23503-1-paul@crapouillou.net>
References: <20190404094739.23503-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By registering a generic USB PHY from within the driver, we may shadow
the USB PHY registered by the platform, which might be different.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/usb/musb/jz4740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index a60627bf7be3..ad35e09f90bd 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -74,7 +74,6 @@ static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
 
 static int jz4740_musb_init(struct musb *musb)
 {
-	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR(musb->xceiv)) {
 		pr_err("HS UDC: no transceiver configured\n");
@@ -183,7 +182,6 @@ static int jz4740_remove(struct platform_device *pdev)
 	struct jz4740_glue	*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister(pdev);
 	clk_disable_unprepare(glue->clk);
 
 	return 0;
-- 
2.11.0

