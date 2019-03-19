Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DED2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ViEfFk7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCSNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:51:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39110 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfCSNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553003512; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=13ybQO1lo/UgcybEPzuD28JlMQVR6h+cJlGCnO57j3c=;
        b=ViEfFk7GqLKco8h53w5RoaN9sw+0MX8pe3eQR8bWthWuE71D9pHdhH/kWD4qAoazUpoo3h
        z2iV3C+zxoW4yCWSPNc1pcrtxHJ3qfFMPoSW0V9PxS3C2As/UQiC9tC3RmxrBxnLTCMTFL
        RYjH7idv6VOs2l237nYQSRwtyea8kc0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: musb: Silence error about blacklisting hubs if !CONFIG_USB
Date:   Tue, 19 Mar 2019 14:51:46 +0100
Message-Id: <20190319135146.25995-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers, like jz4740-musb, don't depend on CONFIG_USB.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b7d56272f9d1..9f5a4819a744 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1497,10 +1497,11 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 	} else {
 		musb->is_multipoint = 0;
 		type = "";
-#ifndef	CONFIG_USB_OTG_BLACKLIST_HUB
-		pr_err("%s: kernel must blacklist external hubs\n",
-		       musb_driver_name);
-#endif
+		if (IS_ENABLED(CONFIG_USB) &&
+		    !IS_ENABLED(CONFIG_USB_OTG_BLACKLIST_HUB)) {
+			pr_err("%s: kernel must blacklist external hubs\n",
+			       musb_driver_name);
+		}
 	}
 
 	/* log release info */
-- 
2.11.0

