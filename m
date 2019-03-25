Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB137207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pRVzIg+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfCYLRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:17:44 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:65522 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:17:44 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549954800"; 
   d="scan'208";a="26043518"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Mar 2019 04:17:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Mar 2019 04:17:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1UwYxD+sNKf+NPMWKxUZt+GKhbWVAbOmJ+9sSNN9QI=;
 b=pRVzIg+uI57XZuM2poRJlQWpRkK6w1IFydt5kTRN7mfj6Hanyd/mfl23cTt7lOjEflVQ3dd+RulXCSKQZS7Trnv3ZOwBpmleddMhVVXd4YIebb0U8kBMA8sq0xnl8hetjbMAI04xi2V7HDQP7SmB4qc1+62XxjcdqhcxUojZjC8=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB4054.namprd11.prod.outlook.com (10.255.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 11:17:39 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 11:17:39 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>
CC:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>, <quentin.schulz@bootlin.com>
Subject: [PATCH 0/1] net: phy: mscc: add support for VSC8514 PHY
Thread-Topic: [PATCH 0/1] net: phy: mscc: add support for VSC8514 PHY
Thread-Index: AQHU4vxbVn4pQGkED0aPRO2BVqvTqQ==
Date:   Mon, 25 Mar 2019 11:17:38 +0000
Message-ID: <20190325111548.25789-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c46b73f1-56b5-48e6-c6ba-08d6b1137d30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB4054;
x-ms-traffictypediagnostic: BY5PR11MB4054:
x-microsoft-antispam-prvs: <BY5PR11MB4054AF86A45FDC2B6BAE2D36925E0@BY5PR11MB4054.namprd11.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(376002)(346002)(43544003)(199004)(189003)(6512007)(102836004)(6116002)(66066001)(3846002)(486006)(97736004)(72206003)(6486002)(14454004)(6506007)(386003)(26005)(78486014)(2616005)(52116002)(53946003)(476003)(6436002)(55236004)(106356001)(305945005)(256004)(2501003)(14444005)(30864003)(68736007)(36756003)(186003)(316002)(8936002)(71190400001)(54906003)(81156014)(81166006)(105586002)(110136005)(8676002)(5660300002)(50226002)(1076003)(71200400001)(99286004)(25786009)(86362001)(478600001)(7736002)(2906002)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4054;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VWWjS45SwfrjkjxJ3QT8HDCSPqO8QWB1fchFAnv8Y2j5gWicEBSN44ZuxJrnaJssVA0BMEKpSuKxmDHwL3VRIERN4COnJ4BgH5UwlBYzM0tb550eE7oKkhdeWaWIj5RewQHb3jd4+qF+Rf8qQEi5WuTFfMTyr3M+Z5LgxtEJjXeISRWtUz3xYdk0eszW0l7vI4z8yAZTTBGnDziBa+g4I34qE4aqwy880LTKnF+OptqDRn/WXIaJMPkrrFLi75QBeXJrKNDc+vDR8r6VGAXPbQcKId0IVHHxan6ji34wkrbsfJHIDBsOyQE7VrQVsRrecUpBJqDdrF+nUTSyscJZ54gF2hDG9q+JioUNuL2mGcy/gwwjjaVaWcVoFfqi67JSFodD93scfnqYDo1aCcZNRpOSUaOKFDJnGTAKSqHMlMo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b73f1-56b5-48e6-c6ba-08d6b1137d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 11:17:39.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4054
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>

The VSC8514 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
1000BASE-X, can communicate with the MAC via QSGMII.
The MAC interface protocol for each port within QSGMII can
be either 1000BASE-X or SGMII, if the QSGMII MAC that the VSC8514 is
connecting to supports this functionality.
VSC8514 also supports SGMII MAC-side autonegotiation on each individual
port, downshifting, can set the blinking pattern of each of its 4 LEDs,
SyncE, 1000BASE-T Ring Resiliency as well as HP Auto-MDIX detection.

This adds support for 10BASE-T, 100BASE-TX, and 1000BASE-T,
QSGMII link with the MAC, downshifting, HP Auto-MDIX detection
and blinking pattern for its 4 LEDs.

The GPIO register bank is a set of registers that are common to all PHYs
in the package. So any modification in any register of this bank affects
all PHYs of the package.

If the PHYs haven't been reset before booting the Linux kernel and were
configured to use interrupts for e.g. link status updates, it is
required to clear the interrupts mask register of all PHYs before being
able to use interrupts with any PHY. The first PHY of the package that
will be init will take care of clearing all PHYs interrupts mask
registers. Thus, we need to keep track of the init sequence in the
package, if it's already been done or if it's to be done.

Most of the init sequence of a PHY of the package is common to all PHYs
in the package, thus we use the SMI broadcast feature which enables us
to propagate a write in one register of one PHY to all PHYs in the same
package.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Co-developed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/Kconfig |   2 +-
 drivers/net/phy/mscc.c  | 381 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 382 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3d187cd50eb0..17d022e5d8f6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -382,7 +382,7 @@ config MICROCHIP_T1_PHY
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
 	---help---
-	  Currently supports VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
+	  Currently supports VSC8514, VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
=20
 config NATIONAL_PHY
 	tristate "National Semiconductor PHYs"
diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index db50efb30df5..43141e6833c1 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -85,12 +85,29 @@ enum rgmii_rx_clock_delay {
 #define LED_MODE_SEL_MASK(x)		  (GENMASK(3, 0) << LED_MODE_SEL_POS(x))
 #define LED_MODE_SEL(x, mode)		  (((mode) << LED_MODE_SEL_POS(x)) & LED_MO=
DE_SEL_MASK(x))
=20
+#define MSCC_EXT_PAGE_CSR_CNTL_17           17
+#define MSCC_EXT_PAGE_CSR_CNTL_18           18
+
+#define MSCC_EXT_PAGE_CSR_CNTL_19           19
+#define MSCC_PHY_CSR_CNTL_19_REG_ADDR(x)    (x)
+#define MSCC_PHY_CSR_CNTL_19_TARGET(x)      ((x) << 12)
+#define MSCC_PHY_CSR_CNTL_19_READ           BIT(14)
+#define MSCC_PHY_CSR_CNTL_19_CMD            BIT(15)
+
+#define MSCC_EXT_PAGE_CSR_CNTL_20           20
+#define MSCC_PHY_CSR_CNTL_20_TARGET(x)      (x)
+
+#define PHY_MCB_TARGET                    0x07
+#define PHY_MCB_S6G_WRITE                 0x80000000
+#define PHY_MCB_S6G_READ                  0x40000000
+
 #define MSCC_EXT_PAGE_ACCESS		  31
 #define MSCC_PHY_PAGE_STANDARD		  0x0000 /* Standard registers */
 #define MSCC_PHY_PAGE_EXTENDED		  0x0001 /* Extended registers */
 #define MSCC_PHY_PAGE_EXTENDED_2	  0x0002 /* Extended reg - page 2 */
 #define MSCC_PHY_PAGE_EXTENDED_3	  0x0003 /* Extended reg - page 3 */
 #define MSCC_PHY_PAGE_EXTENDED_4	  0x0004 /* Extended reg - page 4 */
+#define MSCC_PHY_PAGE_CSR_CNTL		  MSCC_PHY_PAGE_EXTENDED_4
 /* Extended reg - GPIO; this is a bank of registers that are shared for al=
l PHYs
  * in the same package.
  */
@@ -216,6 +233,7 @@ enum rgmii_rx_clock_delay {
 #define MSCC_PHY_TR_MSB			  18
=20
 /* Microsemi PHY ID's */
+#define PHY_ID_VSC8514			  0x00070670
 #define PHY_ID_VSC8530			  0x00070560
 #define PHY_ID_VSC8531			  0x00070570
 #define PHY_ID_VSC8540			  0x00070760
@@ -1742,6 +1760,319 @@ static int vsc8584_did_interrupt(struct phy_device =
*phydev)
 	return (rc < 0) ? 0 : rc & MII_VSC85XX_INT_MASK_MASK;
 }
=20
+static int vsc8514_config_pre_init(struct phy_device *phydev)
+{
+	unsigned int i;
+	u16 reg;
+	const struct reg_val pre_init1[] =3D {
+		{0x0f90, 0x00688980},
+		{0x0786, 0x00000003},
+		{0x07fa, 0x0050100f},
+		{0x0f82, 0x0012b002},
+		{0x1686, 0x00000004},
+		{0x168c, 0x00d2c46f},
+		{0x17a2, 0x00000620},
+		{0x16a0, 0x00eeffdd},
+		{0x16a6, 0x00071448},
+		{0x16a4, 0x0013132f},
+		{0x16a8, 0x00000000},
+		{0x0ffc, 0x00c0a028},
+		{0x0fe8, 0x0091b06c},
+		{0x0fea, 0x00041600},
+		{0x0f80, 0x00fffaff},
+		{0x0fec, 0x00901809},
+		{0x0ffe, 0x00b01007},
+		{0x16b0, 0x00eeff00},
+		{0x16b2, 0x00007000},
+		{0x16b4, 0x00000814},
+	};
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	/* all writes below are broadcasted to all PHYs in the same package */
+	reg =3D phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
+	reg |=3D SMI_BROADCAST_WR_EN;
+	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	reg =3D phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
+	reg |=3D 0x8000;
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
+
+	for (i =3D 0; i < ARRAY_SIZE(pre_init1); i++)
+		vsc8584_csr_write(phydev, pre_init1[i].reg, pre_init1[i].val);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	reg =3D phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
+	reg &=3D ~0x8000;
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	reg =3D phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
+	reg &=3D ~SMI_BROADCAST_WR_EN;
+	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	return 0;
+}
+
+static u32 vsc85xx_csr_ctrl_phy_read(struct phy_device *phydev,
+				     u32 target, u32 reg)
+{
+	u32 val, val_l, val_h;
+	unsigned long deadline;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_CSR_CNTL);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_20,
+		       MSCC_PHY_CSR_CNTL_20_TARGET(target >> 2));
+
+	if (target >> 2 =3D=3D 0x1)
+		/* non-MACsec access */
+		target &=3D 0x3;
+	else
+		target =3D 0;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_19,
+		       MSCC_PHY_CSR_CNTL_19_CMD | MSCC_PHY_CSR_CNTL_19_READ |
+		       MSCC_PHY_CSR_CNTL_19_REG_ADDR(reg) |
+		       MSCC_PHY_CSR_CNTL_19_TARGET(target));
+
+	deadline =3D jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		val =3D phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_19);
+	} while (time_before(jiffies, deadline) &&
+		!(val & MSCC_PHY_CSR_CNTL_19_CMD));
+
+	val_l =3D phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_17);
+	val_h =3D phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_18);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		       MSCC_PHY_PAGE_STANDARD);
+
+	return (val_h << 16) | val_l;
+}
+
+static void vsc85xx_csr_ctrl_phy_write(struct phy_device *phydev,
+				       u32 target, u32 reg, u32 val)
+{
+	unsigned long deadline;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_CSR_CNTL);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_20,
+		       MSCC_PHY_CSR_CNTL_20_TARGET(target >> 2));
+
+	if ((target >> 2 =3D=3D 0x1) || (target >> 2 =3D=3D 0x3))
+		target &=3D 0x3;
+	else
+		/* MACsec access */
+		target =3D 0;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_17, (u16)val);
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_18, (u16)(val >> 16));
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_19,
+		       MSCC_PHY_CSR_CNTL_19_CMD |
+		       MSCC_PHY_CSR_CNTL_19_REG_ADDR(reg) |
+		       MSCC_PHY_CSR_CNTL_19_TARGET(target));
+
+	deadline =3D jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		val =3D phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_19);
+	} while (time_before(jiffies, deadline) &&
+		 !(val & MSCC_PHY_CSR_CNTL_19_CMD));
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		       MSCC_PHY_PAGE_STANDARD);
+}
+
+static int __phy_write_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb,
+			       u32 op)
+{
+	unsigned long deadline;
+	u32 val;
+
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, reg, op |
+				   (1 << mcb));
+
+	deadline =3D jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		val =3D vsc85xx_csr_ctrl_phy_read(phydev, PHY_MCB_TARGET, reg);
+	} while (time_before(jiffies, deadline) && (val & op));
+
+	if (val & op)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+/* vtss_phy_mcb_rd_trig_private */
+static int phy_update_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb)
+{
+	return __phy_write_mcb_s6g(phydev, reg, mcb, PHY_MCB_S6G_READ);
+}
+
+/* vtss_phy_mcb_wr_trig_private */
+static int phy_commit_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb)
+{
+	return __phy_write_mcb_s6g(phydev, reg, mcb, PHY_MCB_S6G_WRITE);
+}
+
+static int vsc8514_config_init(struct phy_device *phydev)
+{
+	int ret, i;
+	u16 val, addr;
+	u32 reg;
+	unsigned long deadline;
+	struct vsc8531_private *vsc8531 =3D phydev->priv;
+
+	phydev->mdix_ctrl =3D ETH_TP_MDI_AUTO;
+
+	mutex_lock(&phydev->mdio.bus->mdio_lock);
+
+	__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
+			MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_EXTENDED);
+	addr =3D __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
+			      MSCC_PHY_EXT_PHY_CNTL_4);
+	addr >>=3D PHY_CNTL_4_ADDR_POS;
+
+	val =3D __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
+			     MSCC_PHY_ACTIPHY_CNTL);
+
+	if (val & PHY_ADDR_REVERSED)
+		vsc8531->base_addr =3D phydev->mdio.addr + addr;
+	else
+		vsc8531->base_addr =3D phydev->mdio.addr - addr;
+
+	/* Some parts of the init sequence are identical for every PHY in the
+	 * package. Some parts are modifying the GPIO register bank which is a
+	 * set of registers that are affecting all PHYs, a few resetting the
+	 * microprocessor common to all PHYs.
+	 * All PHYs' interrupts mask register has to be zeroed before enabling
+	 * any PHY's interrupt in this register.
+	 * For all these reasons, we need to do the init sequence once and only
+	 * once whatever is the first PHY in the package that is initialized and
+	 * do the correct init sequence for all PHYs that are package-critical
+	 * in this pre-init function.
+	 */
+	if (!vsc8584_is_pkg_init(phydev, val & PHY_ADDR_REVERSED ? 1 : 0)) {
+		if ((phydev->phy_id & phydev->drv->phy_id_mask) =3D=3D
+		    (PHY_ID_VSC8514 & phydev->drv->phy_id_mask))
+			ret =3D vsc8514_config_pre_init(phydev);
+		else
+			ret =3D -EINVAL;
+
+		if (ret)
+			goto err;
+	}
+
+	vsc8531->pkg_init =3D true;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		       MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	val =3D phy_base_read(phydev, MSCC_PHY_MAC_CFG_FASTLINK);
+
+	val &=3D ~MAC_CFG_MASK;
+	val |=3D MAC_CFG_QSGMII;
+	ret =3D phy_base_write(phydev, MSCC_PHY_MAC_CFG_FASTLINK, val);
+
+	if (ret)
+		goto err;
+
+	ret =3D vsc8584_cmd(phydev,
+			  PROC_CMD_MCB_ACCESS_MAC_CONF |
+			  PROC_CMD_RST_CONF_PORT |
+			  PROC_CMD_READ_MOD_WRITE_PORT | PROC_CMD_QSGMII_MAC);
+	if (ret)
+		goto err;
+
+	usleep_range(10000, 20000);
+
+	/* 6g mcb */
+	phy_update_mcb_s6g(phydev, 0x3f, 0);
+	/* lcpll mcb */
+	phy_update_mcb_s6g(phydev, 0x11, 0);
+	/* pll5gcfg0 */
+	vsc85xx_csr_ctrl_phy_write(phydev,
+				   PHY_MCB_TARGET, 0x06, 0x7036f145);
+	phy_commit_mcb_s6g(phydev, 0x11, 0);
+	/* pllcfg */
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET,
+				   0x2b, (3 << 21) | (120 << 8) | (0 << 7));
+	/* commoncfg */
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET,
+				   0x2c, (0 << 31) | (0 << 18) | (0 << 8)
+				   | (0 << 6) | (3 << 4));
+	/* misccfg */
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x3b, 1);
+
+	/* gpcfg */
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x2e, 768);
+
+	phy_commit_mcb_s6g(phydev, 0x3e, 0);
+
+	deadline =3D jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		phy_update_mcb_s6g(phydev, 0x3f, 0);
+		reg =3D vsc85xx_csr_ctrl_phy_read(phydev,
+						PHY_MCB_TARGET, 0x31);
+	} while (time_before(jiffies, deadline) && (reg & BIT(12)));
+	if (reg & BIT(12)) {
+		mutex_unlock(&phydev->mdio.bus->mdio_lock);
+		return -ETIMEDOUT;
+	}
+
+	/* misccfg */
+	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x3b, 0);
+
+	phy_commit_mcb_s6g(phydev, 0x3f, 0);
+
+	deadline =3D jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		phy_update_mcb_s6g(phydev, 0x3f, 0);
+		reg =3D vsc85xx_csr_ctrl_phy_read(phydev,
+						PHY_MCB_TARGET, 0x2f);
+	} while (time_before(jiffies, deadline) && !(reg & BIT(8)));
+
+	if (!(reg & BIT(8))) {
+		mutex_unlock(&phydev->mdio.bus->mdio_lock);
+		return -ETIMEDOUT;
+	}
+
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
+
+	phy_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		  MSCC_PHY_PAGE_STANDARD);
+
+	val =3D phy_read(phydev, MSCC_PHY_EXT_PHY_CNTL_1);
+	val &=3D ~MEDIA_OP_MODE_MASK;
+	val |=3D MEDIA_OP_MODE_COPPER;
+	ret =3D phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, val);
+
+	ret =3D genphy_soft_reset(phydev);
+
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < vsc8531->nleds; i++) {
+		ret =3D vsc85xx_led_cntl_set(phydev, i, vsc8531->leds_mode[i]);
+		if (ret)
+			return ret;
+	}
+
+	return genphy_config_init(phydev);
+
+err:
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
+	return ret;
+}
+
 static int vsc85xx_ack_interrupt(struct phy_device *phydev)
 {
 	int rc =3D 0;
@@ -1791,6 +2122,30 @@ static int vsc85xx_read_status(struct phy_device *ph=
ydev)
 	return genphy_read_status(phydev);
 }
=20
+static int vsc8514_probe(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531;
+	u32 default_mode[4] =3D {VSC8531_LINK_1000_ACTIVITY,
+	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
+	   VSC8531_DUPLEX_COLLISION};
+
+	vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL)=
;
+	if (!vsc8531)
+		return -ENOMEM;
+
+	phydev->priv =3D vsc8531;
+
+	vsc8531->nleds =3D 4;
+	vsc8531->supp_led_modes =3D VSC85XX_SUPP_LED_MODES;
+	vsc8531->hw_stats =3D vsc85xx_hw_stats;
+	vsc8531->nstats =3D ARRAY_SIZE(vsc85xx_hw_stats);
+	vsc8531->stats =3D devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
+					    sizeof(u64), GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
+	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+}
+
 static int vsc8574_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
@@ -1878,6 +2233,31 @@ static int vsc85xx_probe(struct phy_device *phydev)
=20
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] =3D {
+{
+	.phy_id		=3D PHY_ID_VSC8514,
+	.name		=3D "Microsemi GE VSC8514 SyncE",
+	.phy_id_mask	=3D 0xfffffff0,
+	.features	=3D PHY_GBIT_FEATURES,
+	.soft_reset	=3D &genphy_soft_reset,
+	.config_init    =3D &vsc8514_config_init,
+	.config_aneg    =3D &vsc85xx_config_aneg,
+	.aneg_done	=3D &genphy_aneg_done,
+	.read_status	=3D &vsc85xx_read_status,
+	.ack_interrupt  =3D &vsc85xx_ack_interrupt,
+	.config_intr    =3D &vsc85xx_config_intr,
+	.suspend	=3D &genphy_suspend,
+	.resume		=3D &genphy_resume,
+	.probe		=3D &vsc8514_probe,
+	.set_wol	=3D &vsc85xx_wol_set,
+	.get_wol	=3D &vsc85xx_wol_get,
+	.get_tunable	=3D &vsc85xx_get_tunable,
+	.set_tunable	=3D &vsc85xx_set_tunable,
+	.read_page      =3D &vsc85xx_phy_read_page,
+	.write_page     =3D &vsc85xx_phy_write_page,
+	.get_sset_count =3D &vsc85xx_get_sset_count,
+	.get_strings    =3D &vsc85xx_get_strings,
+	.get_stats      =3D &vsc85xx_get_stats,
+},
 {
 	.phy_id		=3D PHY_ID_VSC8530,
 	.name		=3D "Microsemi FE VSC8530",
@@ -2034,6 +2414,7 @@ static struct phy_driver vsc85xx_driver[] =3D {
 module_phy_driver(vsc85xx_driver);
=20
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] =3D {
+	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },
 	{ PHY_ID_VSC8531, 0xfffffff0, },
 	{ PHY_ID_VSC8540, 0xfffffff0, },
--=20
2.17.1

