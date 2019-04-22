Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17AEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF620693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDVMjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:39:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfDVMjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:39:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33B597885303043C4C65;
        Mon, 22 Apr 2019 20:39:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 22 Apr 2019 20:39:21 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH] net: phy: marvell: add new default led configure for m88e151x
Date:   Mon, 22 Apr 2019 20:38:13 +0800
Message-ID: <1555936693-29260-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The default m88e151x LED configuration is 0x1177, used LED[0]
for 1000M link, LED[1] for 100M link, and LED[2] for active.
But for some boards, which use LED[0] for link, and LED[1] for
active, prefer to be 0x1040. To be compatible with this case,
this patch defines a new dev_flag, and set it before connect
phy in HNS3 driver. When phy initializing, using the new
LED configuration if the dev_flag set.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 3 +++
 drivers/net/phy/marvell.c                               | 6 +++++-
 include/linux/marvell_phy.h                             | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 12be4e2..1e81348 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
+#include <linux/marvell_phy.h>
 
 #include "hclge_cmd.h"
 #include "hclge_main.h"
@@ -209,6 +210,8 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 
 	linkmode_clear_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
 
+	phydev->dev_flags |= MARVELL_PHY_LED0_LINK_LED1_ACTIVE;
+
 	ret = phy_connect_direct(netdev, phydev,
 				 hclge_mac_adjust_link,
 				 PHY_INTERFACE_MODE_SGMII);
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 8754cb8..a7e8c81 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -137,6 +137,7 @@
 #define MII_PHY_LED_CTRL	        16
 #define MII_88E1121_PHY_LED_DEF		0x0030
 #define MII_88E1510_PHY_LED_DEF		0x1177
+#define MII_88E1510_PHY_LED0_LINK_LED1_ACTIVE	0x1040
 
 #define MII_M1011_PHY_STATUS		0x11
 #define MII_M1011_PHY_STATUS_1000	0x8000
@@ -633,7 +634,10 @@ static void marvell_config_led(struct phy_device *phydev)
 	 * LED[2] .. Blink, Activity
 	 */
 	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
-		def_config = MII_88E1510_PHY_LED_DEF;
+		if (phydev->dev_flags & MARVELL_PHY_LED0_LINK_LED1_ACTIVE)
+			def_config = MII_88E1510_PHY_LED0_LINK_LED1_ACTIVE;
+		else
+			def_config = MII_88E1510_PHY_LED_DEF;
 		break;
 	default:
 		return;
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 73d0474..af6b11d 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -34,5 +34,6 @@
 /* struct phy_device dev_flags definitions */
 #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
 #define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002
+#define MARVELL_PHY_LED0_LINK_LED1_ACTIVE	0x00000004
 
 #endif /* _MARVELL_PHY_H */
-- 
2.7.4

