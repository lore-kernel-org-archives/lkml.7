Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26233205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QRoB0vcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfDDJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58190 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbfDDJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554370670; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=F5VToilLnMBME9L+TXy2uaYnd9STb1aEJYklDsxqWuQ=;
        b=QRoB0vcM9gcLxl3Uf7c5RHDTeJTflknGkL7a27BdL6DxyUKMmsxbUiREfovQ0IkMfYIkEx
        QBXDb9EhacgyA0xz2tislqRLgK632OO/+24rhnmHDoiYKgAfd6QZTvkFMwLO4LKKu06JWe
        LlxEVLSuspXuHt3iWm1vIqwHIV2PFFM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: musb: Disable pullup in gadget setup
Date:   Thu,  4 Apr 2019 11:37:43 +0200
Message-Id: <20190404093743.6470-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pullup may be already enabled before the driver is initialized.
It has to be disabled at init time, as we cannot guarantee that a gadget
driver will be bound to the UDC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ffe462a657b1..094dc59c834c 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1794,6 +1794,7 @@ int musb_gadget_setup(struct musb *musb)
 
 	musb->is_active = 0;
 	musb_platform_try_idle(musb, 0);
+	musb_pullup(musb, 0);
 
 	status = usb_add_gadget_udc(musb->controller, &musb->g);
 	if (status)
-- 
2.11.0

