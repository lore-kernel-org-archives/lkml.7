Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E19C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE5D213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mejCWGbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfCTMh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:37:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51420 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCTMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:37:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2KCbLeI013780;
        Wed, 20 Mar 2019 07:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553085441;
        bh=KcdPyOwDBneVWZGmbzL8ddvTQtfe4EjO663fhCFVqEc=;
        h=From:To:CC:Subject:Date;
        b=mejCWGbPeP/vystmGGxF7X+UcmADZGsYE2wxNSYomKTojhFBnOqY230FM4P+pfBxH
         TPNZQIdp9aa4e4+no+MgwOtiiFVoRTMUnTDeaFxJLFjhN4dJqrGZu5nScdP7vKzB2x
         5J7d+asV9ZfjurYQq/7RXz+AWN0SQETPDk9hKuKQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2KCbLdl056869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 07:37:21 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 07:37:21 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 07:37:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2KCbLAi010052;
        Wed, 20 Mar 2019 07:37:21 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2] net: phy: Add DP83825I to the DP83822 driver
Date:   Wed, 20 Mar 2019 07:36:55 -0500
Message-ID: <20190320123655.6289-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DP83825I ethernet PHY to the DP83822 driver.
These devices share the same WoL register bits and addresses.

The phy_driver init was made into a macro as there may be future
devices appended to this driver that will share the register space.

http://www.ti.com/lit/gpn/dp83825i

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Updated id and mask to new ID_MATCH macro, removed extra line - https://lore.kernel.org/patchwork/patch/1052329/

 drivers/net/phy/dp83822.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index bbd8c22067f3..97d45bd5b38e 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -15,6 +15,8 @@
 #include <linux/netdevice.h>
 
 #define DP83822_PHY_ID	        0x2000a240
+#define DP83825I_PHY_ID		0x2000a150
+
 #define DP83822_DEVADDR		0x1f
 
 #define MII_DP83822_PHYSCR	0x11
@@ -304,26 +306,30 @@ static int dp83822_resume(struct phy_device *phydev)
 	return 0;
 }
 
+#define DP83822_PHY_DRIVER(_id, _name)				\
+	{							\
+		PHY_ID_MATCH_MODEL(_id),			\
+		.name		= (_name),			\
+		.features	= PHY_BASIC_FEATURES,		\
+		.soft_reset	= dp83822_phy_reset,		\
+		.config_init	= dp83822_config_init,		\
+		.get_wol = dp83822_get_wol,			\
+		.set_wol = dp83822_set_wol,			\
+		.ack_interrupt = dp83822_ack_interrupt,		\
+		.config_intr = dp83822_config_intr,		\
+		.suspend = dp83822_suspend,			\
+		.resume = dp83822_resume,			\
+	}
+
 static struct phy_driver dp83822_driver[] = {
-	{
-		.phy_id = DP83822_PHY_ID,
-		.phy_id_mask = 0xfffffff0,
-		.name = "TI DP83822",
-		.features = PHY_BASIC_FEATURES,
-		.config_init = dp83822_config_init,
-		.soft_reset = dp83822_phy_reset,
-		.get_wol = dp83822_get_wol,
-		.set_wol = dp83822_set_wol,
-		.ack_interrupt = dp83822_ack_interrupt,
-		.config_intr = dp83822_config_intr,
-		.suspend = dp83822_suspend,
-		.resume = dp83822_resume,
-	 },
+	DP83822_PHY_DRIVER(DP83822_PHY_ID, "TI DP83822"),
+	DP83822_PHY_DRIVER(DP83825I_PHY_ID, "TI DP83825I"),
 };
 module_phy_driver(dp83822_driver);
 
 static struct mdio_device_id __maybe_unused dp83822_tbl[] = {
 	{ DP83822_PHY_ID, 0xfffffff0 },
+	{ DP83825I_PHY_ID, 0xfffffff0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
-- 
2.20.1.390.gb5101f9297

