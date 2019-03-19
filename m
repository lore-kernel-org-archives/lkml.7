Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63905C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229392146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R342p9eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCSSdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:33:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41624 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCSSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:33:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JIXGsX117654;
        Tue, 19 Mar 2019 13:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553020396;
        bh=j9WG3homOTDAhTLIiWDJ+alfI+kbBYTrFWFNC81eTj8=;
        h=From:To:CC:Subject:Date;
        b=R342p9eYQBjjaVLqP4p24Nj7kOdTMt6hwe5cdc2Ka9V6iIc55HUlHuhYUiHyLa7Wb
         lQ8/T3XwG9wRtxGx7B8c8E2vIGTqSxWgdF8PghAC7610r+QLr6NQsM/iKzGqxmYfQe
         vPlAcfCOjxIZu95mmT0IaIxOnKBAQFJ+WfBcTyk4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JIXGWo051635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 13:33:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 13:33:15 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 13:33:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JIXF1B031293;
        Tue, 19 Mar 2019 13:33:15 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] net: phy: Add DP83825I to the DP83822 driver
Date:   Tue, 19 Mar 2019 13:32:51 -0500
Message-ID: <20190319183251.403-1-dmurphy@ti.com>
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

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/dp83822.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index bbd8c22067f3..02dc05b86326 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -15,6 +15,8 @@
 #include <linux/netdevice.h>
 
 #define DP83822_PHY_ID	        0x2000a240
+#define DP83825I_PHY_ID		0x2000a150
+
 #define DP83822_DEVADDR		0x1f
 
 #define MII_DP83822_PHYSCR	0x11
@@ -304,26 +306,32 @@ static int dp83822_resume(struct phy_device *phydev)
 	return 0;
 }
 
+#define DP83822_PHY_DRIVER(_id, _name)				\
+	{							\
+		.phy_id		= _id,				\
+		.phy_id_mask	= 0xfffffff0,			\
+		.name		= _name,			\
+		.features	= PHY_BASIC_FEATURES,		\
+								\
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

