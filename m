Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B021873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wkKVUjVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfCVI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:58:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:58:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8wHGo041587
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553245097;
        bh=BN1y5tO/T5qwrbeB/Wmll4SJ1P6DeeeoG+PEijbfj1o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wkKVUjVBquAvr7RwQ1IM+NOIKblYPgezjyf+KlsZR6kMExpqsjlk/iTlGkPs3orme
         881u//n5qDYTToOr/J0PXJoGBh3DdSwSOUi3fys/PUZJSQP4dW/wELGzdr9weDDqmG
         myHlWOi8oRc40fBsS40/3n+j2EJXBTmoCZ1WA08o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M8wHT4065709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:58:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:58:16 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M8w9b9016866;
        Fri, 22 Mar 2019 03:58:15 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] phy: ti-pipe3: Fix SATA & USB PHY power up sequence
Date:   Fri, 22 Mar 2019 10:58:06 +0200
Message-ID: <20190322085807.30216-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322085807.30216-1-rogerq@ti.com>
References: <20190322085807.30216-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per "Table 26-7. SATA PHY Subsystem Low-Level Programming Sequence"
in TRM [1] we need to turn on SATA_PHY_TX before SATA_PHY_RX.

[1] DRA75x, DRA74x TRM - http://www.ti.com/lit/ug/sprui30f/sprui30f.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index cdc994f153b2..71a7634c026d 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -56,14 +56,14 @@
 
 #define SATA_PLL_SOFT_RESET	BIT(18)
 
-#define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
+#define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	GENMASK(21, 14)
 #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
 
-#define PIPE3_PHY_PWRCTL_CLK_FREQ_MASK	0xFFC00000
+#define PIPE3_PHY_PWRCTL_CLK_FREQ_MASK	GENMASK(31, 22)
 #define PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT	22
 
-#define PIPE3_PHY_TX_RX_POWERON		0x3
-#define PIPE3_PHY_TX_RX_POWEROFF	0x0
+#define PIPE3_PHY_RX_POWERON       (0x1 << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT)
+#define PIPE3_PHY_TX_POWERON       (0x2 << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT)
 
 #define PCIE_PCS_MASK			0xFF0000
 #define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
@@ -328,7 +328,6 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy);
 
 static int ti_pipe3_power_off(struct phy *x)
 {
-	u32 val;
 	int ret;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
 
@@ -337,10 +336,8 @@ static int ti_pipe3_power_off(struct phy *x)
 		return 0;
 	}
 
-	val = PIPE3_PHY_TX_RX_POWEROFF << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
-
 	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
-				 PIPE3_PHY_PWRCTL_CLK_CMD_MASK, val);
+				 PIPE3_PHY_PWRCTL_CLK_CMD_MASK, 0);
 	return ret;
 }
 
@@ -351,6 +348,7 @@ static int ti_pipe3_power_on(struct phy *x)
 	int ret;
 	unsigned long rate;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
+	bool rx_pending = false;
 
 	if (!phy->phy_power_syscon) {
 		omap_control_phy_power(phy->control_dev, 1);
@@ -363,14 +361,32 @@ static int ti_pipe3_power_on(struct phy *x)
 		return -EINVAL;
 	}
 	rate = rate / 1000000;
-	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
-		  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
-	val = PIPE3_PHY_TX_RX_POWERON << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
-	val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
-
+	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
+	val = rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
 	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
 				 mask, val);
-	return ret;
+	/*
+	 * For PCIe, TX and RX must be powered on simultaneously.
+	 * For USB and SATA, TX must be powered on before RX
+	 */
+	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK;
+	if (phy->mode == PIPE3_MODE_SATA || phy->mode == PIPE3_MODE_USBSS) {
+		val = PIPE3_PHY_TX_POWERON;
+		rx_pending = true;
+	} else {
+		val = PIPE3_PHY_TX_POWERON | PIPE3_PHY_RX_POWERON;
+	}
+
+	regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+			   mask, val);
+
+	if (rx_pending) {
+		val = PIPE3_PHY_TX_POWERON | PIPE3_PHY_RX_POWERON;
+		regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+				   mask, val);
+	}
+
+	return 0;
 }
 
 static int ti_pipe3_dpll_wait_lock(struct ti_pipe3 *phy)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

