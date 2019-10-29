Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57670CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oot3PFX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbfJ2PPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:15:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60130 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388595AbfJ2PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:15:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TFFIwF009724;
        Tue, 29 Oct 2019 10:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572362118;
        bh=EjyBteXlv8fFNuD+sDu3/51WIDE97L/GH2r4eM1/VIU=;
        h=From:To:CC:Subject:Date;
        b=oot3PFX6k2ql4kj9akf+Gf/1g4iR7nF+EYl8sI88me50D9T1lhZI2VVVoERoLPMqt
         rga57zbqLJqLxxc81xK0rrF/dJivmucyjFYT91RKO3vNFCrtPAc03GQpgl3JAenbcX
         2kOMkIJJie6MhoCNeuOObkX+uk3kFGMPH6W/GMug=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TFFIZe085994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 10:15:18 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 10:15:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 10:15:05 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TFFF3J127253;
        Tue, 29 Oct 2019 10:15:16 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
Date:   Tue, 29 Oct 2019 17:15:14 +0200
Message-ID: <20191029151514.28495-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account gadget driver's speed limit when programming
controller speed.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Hi Greg,

Please apply this for -rc.
Without this, g_audio is broken on cdns3 USB controller is
connected to a Super-Speed host.

cheers,
-roger

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

