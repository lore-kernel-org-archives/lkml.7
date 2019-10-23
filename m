Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E40CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="awNAdFys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbfJWJCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:02:46 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46780 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390590AbfJWJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:02:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N92cQT040531;
        Wed, 23 Oct 2019 04:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571821358;
        bh=vG+W4quqVd/rx5gPIFHyLx5O+cQx6BhNDY55hfW2vMM=;
        h=From:To:CC:Subject:Date;
        b=awNAdFysYIKsbC0K9Fa3reRPmlnmx4B27vKWMvmYPhzlbLokot9WQ63nJ0ePKbaoT
         DLDi792xpdzOmfU3VGNIllg3YjA2VIYXKtAW61a2ERRm+UQFuzhd1UloyDE2cMpiQV
         hicEgt9Gh2Z0fTFdnRwMHdp1SASYvToF9IEqcnfg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N92c1d021864;
        Wed, 23 Oct 2019 04:02:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 04:02:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 04:02:37 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N92Ynk085549;
        Wed, 23 Oct 2019 04:02:34 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: cdns3: gadget: Don't manage pullups
Date:   Wed, 23 Oct 2019 12:02:32 +0300
Message-ID: <20191023090232.27237-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB gadget core is supposed to manage pullups
of the controller. Don't manage pullups from within
the controller driver. Otherwise, function drivers
are not able to keep the controller disconnected from
the bus till they are ready. (e.g. g_webcam)

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Hi Greg/Felipe,

This can be used for -rc as it is a bug fix.

cheers,
-roger

 drivers/usb/cdns3/gadget.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 2ca280f4c054..714382d96055 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2324,8 +2324,6 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
 
 	cdns3_configure_dmult(priv_dev, NULL);
-
-	cdns3_gadget_pullup(&priv_dev->gadget, 1);
 }
 
 /**
@@ -2708,8 +2706,6 @@ static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
 	/* disable interrupt for device */
 	writel(0, &priv_dev->regs->usb_ien);
 
-	cdns3_gadget_pullup(&priv_dev->gadget, 0);
-
 	return 0;
 }
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

