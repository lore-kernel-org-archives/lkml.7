Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793FC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9546B20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfD1Gay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:30:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65443 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726508AbfD1Gak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:30:40 -0400
X-UUID: dcc74ac275bd4a12b86771079e4aec76-20190428
X-UUID: dcc74ac275bd4a12b86771079e4aec76-20190428
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2145014212; Sun, 28 Apr 2019 14:30:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 28 Apr 2019 14:30:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 28 Apr 2019 14:30:30 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH 5/6] net: stmmac: add mdio clause 45 access from mac device for dwmac4
Date:   Sun, 28 Apr 2019 14:30:08 +0800
Message-ID: <1556433009-25759-6-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1556433009-25759-1-git-send-email-biao.huang@mediatek.com>
References: <1556433009-25759-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0696C1C6D5D7CC663239AAE30B5C44FCAA58EBB9799C653FC8830C4B66831C3A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add clause 45 mdio read and write from mac device for dwmac4.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h      |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  167 +++++++++++++++++++--
 3 files changed, 165 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 709dcec..06573b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -410,12 +410,15 @@ struct mac_link {
 struct mii_regs {
 	unsigned int addr;	/* MII Address */
 	unsigned int data;	/* MII Data */
-	unsigned int addr_shift;	/* MII address shift */
-	unsigned int reg_shift;		/* MII reg shift */
-	unsigned int addr_mask;		/* MII address mask */
-	unsigned int reg_mask;		/* MII reg mask */
+	unsigned int addr_shift;	/* PHY address shift */
+	unsigned int cl45_reg_shift;	/* CL45 reg address shift */
+	unsigned int reg_shift;		/* CL22 reg/CL45 dev shift */
+	unsigned int addr_mask;		/* PHY address mask */
+	unsigned int cl45_reg_mask;	/* CL45 reg mask */
+	unsigned int reg_mask;		/* CL22 reg/CL45 dev mask */
 	unsigned int clk_csr_shift;
 	unsigned int clk_csr_mask;
+	unsigned int cl45_en;	/* CL45 Enable*/
 };
 
 struct mac_device_info {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a60390b..b71342c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -837,6 +837,9 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(20, 16);
 	mac->mii.clk_csr_shift = 8;
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
+	mac->mii.cl45_reg_shift = 16;
+	mac->mii.cl45_reg_mask = GENMASK(31, 16);
+	mac->mii.cl45_en = BIT(1);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index bdd3515..f7f7d62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -150,16 +150,16 @@ static int stmmac_xgmac2_mdio_write(struct mii_bus *bus, int phyaddr,
 }
 
 /**
- * stmmac_mdio_read
+ * stmmac_c22_read
  * @bus: points to the mii_bus structure
- * @phyaddr: MII addr
- * @phyreg: MII reg
- * Description: it reads data from the MII register from within the phy device.
+ * @phyaddr: clause 22 phy address
+ * @phyreg: clause 22 phy register
+ * Description: it reads data from the MII register follow clause 22.
  * For the 7111 GMAC, we must set the bit 0 in the MII address register while
  * accessing the PHY registers.
  * Fortunately, it seems this has no drawback for the 7109 MAC.
  */
-static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+static int stmmac_c22_read(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -194,15 +194,15 @@ static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 }
 
 /**
- * stmmac_mdio_write
+ * stmmac_c22_write
  * @bus: points to the mii_bus structure
- * @phyaddr: MII addr
- * @phyreg: MII reg
- * @phydata: phy data
- * Description: it writes the data into the MII register from within the device.
+ * @phyaddr: clause-22 phy address
+ * @phyreg: clause-22 phy register
+ * @phydata: clause-22 phy data
+ * Description: it writes the data into the MII register follow clause 22.
  */
-static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
-			     u16 phydata)
+static int stmmac_c22_write(struct mii_bus *bus, int phyaddr, int phyreg,
+			    u16 phydata)
 {
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -237,6 +237,149 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
 }
 
 /**
+ * stmmac_c45_read
+ * @bus: points to the mii_bus structure
+ * @phyaddr: clause-45 phy address
+ * @devad: clause-45 device address
+ * @prtad: clause-45 register address
+ * @phydata: phy data
+ * Description: it reads the data from the  MII register follow clause 45.
+ */
+static int stmmac_c45_read(struct mii_bus *bus, int phyaddr,
+			   int devad, int prtad)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int mii_address = priv->hw->mii.addr;
+	unsigned int mii_data = priv->hw->mii.data;
+	u32 v, value;
+	int data;
+
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	value = 0;
+	value |= (prtad << priv->hw->mii.cl45_reg_shift)
+			& priv->hw->mii.cl45_reg_mask;
+	writel(value, priv->ioaddr + mii_data);
+
+	/* delay 2ms to avoid error value of get_phy_c45_devs_in_pkg */
+	mdelay(2);
+
+	value = MII_BUSY;
+	value |= (phyaddr << priv->hw->mii.addr_shift)
+		& priv->hw->mii.addr_mask;
+	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
+	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
+		& priv->hw->mii.clk_csr_mask;
+	if (priv->plat->has_gmac4) {
+		value |= MII_GMAC4_READ;
+		value |= priv->hw->mii.cl45_en;
+	}
+	writel(value, priv->ioaddr + mii_address);
+
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	/* Read the data from the MII data register */
+	data = (int)(readl(priv->ioaddr + mii_data) & 0xffff);
+
+	return data;
+}
+
+/**
+ * stmmac_c45_write
+ * @bus: points to the mii_bus structure
+ * @phyaddr: clause-45 phy address
+ * @devad: clause-45 device address
+ * @prtad: clause-45 register address
+ * @phydata: phy data
+ * Description: it writes the data into the MII register follow clause 45.
+ */
+static int stmmac_c45_write(struct mii_bus *bus, int phyaddr, int devad,
+			    int prtad, u16 phydata)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int mii_address = priv->hw->mii.addr;
+	unsigned int mii_data = priv->hw->mii.data;
+	u32 v, value;
+
+	/* Wait until any existing MII operation is complete */
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	value = phydata;
+	value |= (prtad << priv->hw->mii.cl45_reg_shift) &
+		 priv->hw->mii.cl45_reg_mask;
+	writel(value, priv->ioaddr + mii_data);
+
+	mdelay(2);
+
+	value = MII_BUSY;
+	value |= (phyaddr << priv->hw->mii.addr_shift) &
+		 priv->hw->mii.addr_mask;
+	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
+	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift) &
+		 priv->hw->mii.clk_csr_mask;
+
+	if (priv->plat->has_gmac4) {
+		value |= MII_GMAC4_WRITE;
+		value |= priv->hw->mii.cl45_en;
+	}
+	writel(value, priv->ioaddr + mii_address);
+
+	/* Wait until any existing MII operation is complete */
+	return readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+				  100, 10000);
+}
+
+/**
+ * stmmac_mdio_read
+ * @bus: points to the mii_bus structure
+ * @phyaddr: MII addr
+ * @phyreg: MII reg
+ * Description: it reads data from the MII register from within the phy device.
+ */
+static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+{
+	if (phyreg & MII_ADDR_C45) {
+		int devad, prtad;
+
+		devad = (phyreg >> 16) & 0x1f;
+		prtad = phyreg & 0xffff;
+		return stmmac_c45_read(bus, phyaddr, devad, prtad);
+	} else {
+		return stmmac_c22_read(bus, phyaddr, phyreg);
+	}
+}
+
+/**
+ * stmmac_mdio_write
+ * @bus: points to the mii_bus structure
+ * @phyaddr: MII addr
+ * @phyreg: MII reg
+ * @phydata: phy data
+ * Description: it writes the data into the MII register from within the device.
+ */
+static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
+			     u16 phydata)
+{
+	if (phyreg & MII_ADDR_C45) {
+		int devad, prtad;
+
+		devad = (phyreg >> 16) & 0x1f;
+		prtad = phyreg & 0xffff;
+		return stmmac_c45_write(bus, phyaddr, devad, prtad, phydata);
+	} else {
+		return stmmac_c22_write(bus, phyaddr, phyreg, phydata);
+	}
+}
+
+/**
  * stmmac_mdio_reset
  * @bus: points to the mii_bus structure
  * Description: reset the MII bus
-- 
1.7.9.5

