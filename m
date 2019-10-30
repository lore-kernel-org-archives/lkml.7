Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B0CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDCA2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="II6ACmzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfJ3MQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:16:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44116 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ3MQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:16:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9UCGETt070977;
        Wed, 30 Oct 2019 07:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572437774;
        bh=Q6fJp/D85GCtxw/JAkXw+eDiNJA5WY/u3vdZ6m5FFrI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=II6ACmzIya4JLZKfOrRJdQDfE6CwpW4T5yU4qEj/6uRApb8jt7vUMLq5WzjzuElSZ
         rkGvKIse5Bg17YntxpM2ZKyAp3q+uUm70lJicmQNmEoNUvqrOkVbnNKZZhJPXdbnKK
         hLZI+rtsG+tgzzHqzoKpxaY9WAVJ1bG6cBHAy/Tw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9UCGDRZ003977
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Oct 2019 07:16:13 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 07:16:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 07:16:00 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9UCG9vT062301;
        Wed, 30 Oct 2019 07:16:10 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
Date:   Wed, 30 Oct 2019 14:16:07 +0200
Message-ID: <20191030121607.21739-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029151514.28495-1-rogerq@ti.com>
References: <20191029151514.28495-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account gadget driver's speed limit when programming
controller speed.

Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
---

Changelog:
v2
- Add Fixes line

 drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 40dad4e8d0dc..1c724c20d468 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
 	unsigned long flags;
+	enum usb_device_speed max_speed = driver->max_speed;
 
 	spin_lock_irqsave(&priv_dev->lock, flags);
 	priv_dev->gadget_driver = driver;
+
+	/* limit speed if necessary */
+	max_speed = min(driver->max_speed, gadget->max_speed);
+
+	switch (max_speed) {
+	case USB_SPEED_FULL:
+		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
+		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
+		break;
+	case USB_SPEED_HIGH:
+		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
+		break;
+	case USB_SPEED_SUPER:
+		break;
+	default:
+		dev_err(priv_dev->dev,
+			"invalid maximum_speed parameter %d\n",
+			max_speed);
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default to superspeed */
+		max_speed = USB_SPEED_SUPER;
+		break;
+	}
+
 	cdns3_gadget_config(priv_dev);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return 0;
@@ -2570,12 +2596,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	/* Check the maximum_speed parameter */
 	switch (max_speed) {
 	case USB_SPEED_FULL:
-		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
-		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
-		break;
 	case USB_SPEED_HIGH:
-		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
-		break;
 	case USB_SPEED_SUPER:
 		break;
 	default:
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

