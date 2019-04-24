Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630C0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3953320656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfDXJRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:17:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfDXJQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260869"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:34 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 2/7] net: stmmac: enable clause 45 mdio support
Date:   Thu, 25 Apr 2019 01:17:16 +0800
Message-Id: <1556126241-2774-3-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kweh Hock Leong <hock.leong.kweh@intel.com>

DWMAC4 is capable to support clause 45 mdio communication.
This patch enable the feature on stmmac_mdio_write() and
stmmac_mdio_read() by following phy_write_mmd() and
phy_read_mmd() mdiobus read write implementation format.

Reviewed-by: Li, Yifan <yifan2.li@intel.com>
Signed-off-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 36 +++++++++++++++++++----
 include/linux/phy.h                               |  2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index bdd3515..149efa6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -34,11 +34,27 @@
 
 #define MII_BUSY 0x00000001
 #define MII_WRITE 0x00000002
+#define MII_DATA_MASK GENMASK(15, 0)
 
 /* GMAC4 defines */
 #define MII_GMAC4_GOC_SHIFT		2
+#define MII_GMAC4_REG_ADDR_SHIFT	16
 #define MII_GMAC4_WRITE			(1 << MII_GMAC4_GOC_SHIFT)
 #define MII_GMAC4_READ			(3 << MII_GMAC4_GOC_SHIFT)
+#define MII_GMAC4_C45E			BIT(1)
+
+static void stmmac_mdio_c45_setup(struct stmmac_priv *priv, int phyreg,
+				  u32 *val, u32 *data)
+{
+	unsigned int reg_mask = priv->hw->mii.reg_mask;
+	unsigned int reg_shift = priv->hw->mii.reg_shift;
+
+	*val |= MII_GMAC4_C45E;
+	*val &= ~reg_mask;
+	*val |= ((phyreg >> MII_DEVADDR_C45_SHIFT) << reg_shift) & reg_mask;
+
+	*data |= (phyreg & MII_REGADDR_C45_MASK) << MII_GMAC4_REG_ADDR_SHIFT;
+}
 
 /* XGMAC defines */
 #define MII_XGMAC_SADDR			BIT(18)
@@ -166,21 +182,25 @@ static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
 	u32 v;
-	int data;
 	u32 value = MII_BUSY;
+	int data = 0;
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
 	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
-	if (priv->plat->has_gmac4)
+	if (priv->plat->has_gmac4) {
 		value |= MII_GMAC4_READ;
+		if (phyreg & MII_ADDR_C45)
+			stmmac_mdio_c45_setup(priv, phyreg, &value, &data);
+	}
 
 	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
 			       100, 10000))
 		return -EBUSY;
 
+	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
 	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
@@ -188,7 +208,7 @@ static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 		return -EBUSY;
 
 	/* Read the data from the MII data register */
-	data = (int)readl(priv->ioaddr + mii_data);
+	data = (int)readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
 
 	return data;
 }
@@ -210,6 +230,7 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
 	unsigned int mii_data = priv->hw->mii.data;
 	u32 v;
 	u32 value = MII_BUSY;
+	int data = phydata;
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
@@ -217,10 +238,13 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
-	if (priv->plat->has_gmac4)
+	if (priv->plat->has_gmac4) {
 		value |= MII_GMAC4_WRITE;
-	else
+		if (phyreg & MII_ADDR_C45)
+			stmmac_mdio_c45_setup(priv, phyreg, &value, &data);
+	} else {
 		value |= MII_WRITE;
+	}
 
 	/* Wait until any existing MII operation is complete */
 	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
@@ -228,7 +252,7 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
 		return -EBUSY;
 
 	/* Set the MII address register to write */
-	writel(phydata, priv->ioaddr + mii_data);
+	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
 	/* Wait until any existing MII operation is complete */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 0f9552b1..6710e66 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -198,6 +198,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 /* Or MII_ADDR_C45 into regnum for read/write on mii_bus to enable the 21 bit
    IEEE 802.3ae clause 45 addressing mode used by 10GIGE phy chips. */
 #define MII_ADDR_C45 (1<<30)
+#define MII_DEVADDR_C45_SHIFT	16
+#define MII_REGADDR_C45_MASK	GENMASK(15, 0)
 
 struct device;
 struct phylink;
-- 
1.9.1

