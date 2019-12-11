Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998D020836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WaUimAx5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wooNDKFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfLKNJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:52 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:65436 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729500AbfLKNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:49 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD47Ha020442;
        Wed, 11 Dec 2019 05:09:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=WaUimAx52JvWEIY7HqPEP8knaPrwqwNvlR7VbxehZdjwLArOHxGk0Hg6E6Geg/XEGsVH
 XDC8PjOjSIaFkwIT7Eopl9JHKteGEdoKDn/0DcXYTVNHfwcsaF0W5X6Xa14Ixr6sICyg
 U/HCoaaS1vruX714ywITCts5YBRWPw01/jWhlKsNWJKb5dHCkFqNJlylyRg4xavyLuo+
 cuKMzQq5f6CCTIelh/Hp1YaE690zl7ddhpW1TM6Fd9ZtNCRCo4Prj7auvH2LyUt+vc1N
 Py+Xb4GvkFCcKcz9NomQd/pS0hzpgoq4wn2UTqmmq97v9ELxDrEVpiBWiyoh3vuWIiI/ hg== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCeT0ChUqk1A4he1igIWFbFMIYROJq+WqlsjR7FISgk/QLD4VkEAf2wBr5l0+p6fTDDrBgsh8x4VZD9gHkWcCleehYaqy2VjeFXXvJ7C78D26ef9PMYd+L69S2r2ZEd/nvtuRkBiRGDJHmg+BUbg7jYY9RwP5iRr+0Y75l6bwEnS7oSNQIBLbsSS/f9WI/OEqR+8yGYV1WtJNyXbI3if6LbzLBOL6dfXeofWLng5gUht380SaC9EZvq+mKJ2ZIbwpqhIzoc/tXKEITb9WtGFi/HbmpNEfY4GyJfeFI+Ut49N5l9au+DQlBuBipRWEYc0I37tn7/799ww7FJk0uxFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=ZKfzqln88yBx13l8k1Lm647wLi7E9e49KkE9xH5d5hi/9B/x0bLqILECZSFOFSHEnAFHTy+ZsFDxMs+F09RyUtMMJn3Mg4gYVJ+gVsZHSJZP4+olZJ7+hL7rfdr7QJ4LSe4oiRpXp93gs0EC9JGoNt6v2pNYDbJP+3+mCAwizkCWf3HZXVX00Y3pKmSG6E37GTEp/C3mRPEl5bnJ3UFrvunkbkHt/iMZtqQ8CnRogMVdmZJ9WAq8kSeCnCB6UQkVkxfrOWgxGWbjXIln973T+08VdKIjrRnt8bMhhb3gvg+ESJbmGyS1cW77S2SZAm4pDMscm1Reoj5F3SNd8hyM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=wooNDKFv3ZzpBdwLK2/WBvFgjNzBcpdOYs6L8ZAJX14XCLgSqjl1tbzgUzn9TeuvGxowWCvRkNFr+4II/wlH7COHbWoH2Ru+LQqM6aYOaYNGj4JU8JCCQqbEmlUsKH5hzRKkvmxr1nlGbuCZuzyIoovYIPRo0rsPn9pR+7UDg5o=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by DM6PR07MB7324.namprd07.prod.outlook.com (2603:10b6:5:215::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 13:09:38 +0000
Received: from MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::208) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT042.mail.protection.outlook.com (10.13.180.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5k006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:35 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9NgJ011701;
        Wed, 11 Dec 2019 14:09:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9Nlu011700;
        Wed, 11 Dec 2019 14:09:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 11/15] phy: cadence-torrent: Implement PHY configure APIs
Date:   Wed, 11 Dec 2019 14:09:16 +0100
Message-ID: <1576069760-11473-12-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(36092001)(42186006)(107886003)(4326008)(316002)(86362001)(54906003)(110136005)(26005)(186003)(76130400001)(26826003)(478600001)(70206006)(70586007)(8936002)(2906002)(36756003)(30864003)(356004)(6666004)(336012)(426003)(8676002)(81156014)(81166006)(5660300002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB7324;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582aa252-c812-4542-ef98-08d77e3b5ff5
X-MS-TrafficTypeDiagnostic: DM6PR07MB7324:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7324B1F0D95F65F0D39BA671D25A0@DM6PR07MB7324.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 756PmCaeweW28pFVfDsKkD9YvZhVydtqZOD2wLR5eM4y6Psgr/Z/vcTzHMvBzQ1V7EMB/v8DH6lBxAAyKb5dM1i+FETUFzAWXtTF2pzaRXVWqHKfMxsSwrz/9YYdKhNrB3e+AL/I2be0VxqTTPnnFLV8Y9o20sm/+59PFe24wcJJPWyRGKGBPakYjjImsh+2LKDQQt5vjuhP7li7S8nbuCYcqiBlGTxZOw3KGdP9Bc1mtoaA1CkhAdIkYJj23e6SMPPnjivKgMOZptlGRqGyVRp3s/KH+x/2E3Fb245UEdq0Vmxt0jFGhYdG2xtxfWPa2z2rtoIfYZ4LY1PPPZiAWxvHteIAx6iaO7M1Z0/ft1H8xYb7J0R7+ua07mnAix1HPvk1+8iH6yJvlJA2zxcScvlGVcaMyHnT4nweIjfrwASjLUaZfhMS5ApDJqZQfzdD2IXBlbHch0hNUNJAOr2z8/6D9+w66qAXijEPeArXj70xCBio1Yq7Y2sV1d5YmHOn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:37.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582aa252-c812-4542-ef98-08d77e3b5ff5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7324
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add support for PHY configuration APIs. These will mainly reconfigure
link rate, number of lanes, voltage swing and pre-emphasis values.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 424 ++++++++++++++++++++++++++++++
 1 file changed, 424 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ebc3b68..006e786 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -37,6 +37,9 @@
 #define PHY_AUX_CONFIG			0x00
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
+#define PMA_TX_ELEC_IDLE_MASK		0xF0U
+#define PMA_TX_ELEC_IDLE_SHIFT		4
+#define PHY_L00_RESET_N_MASK		0x01U
 #define PHY_PMA_XCVR_PLLCLK_EN		0x24
 #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
 #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
@@ -120,6 +123,10 @@
 #define CMN_PDIAG_PLL1_CP_IADJ_M0	0x00714
 #define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x00718
 
+#define TX_TXCC_CTRL			0x10100
+#define TX_TXCC_CPOST_MULT_00		0x10130
+#define TX_TXCC_MGNFS_MULT_000		0x10140
+#define DRV_DIAG_TX_DRV			0x10318
 #define XCVR_DIAG_PLLDRC_CTRL		0x10394
 #define XCVR_DIAG_HSCLK_SEL		0x10398
 #define XCVR_DIAG_HSCLK_DIV		0x1039c
@@ -129,6 +136,8 @@
 #define TX_PSC_A2			0x10408
 #define TX_PSC_A3			0x1040c
 #define TX_RCVDET_ST_TMR		0x1048c
+#define TX_DIAG_ACYA			0x1079c
+#define TX_DIAG_ACYA_HBDC_MASK		0x0001U
 #define RX_PSC_A0			0x20000
 #define RX_PSC_A1			0x20004
 #define RX_PSC_A2			0x20008
@@ -140,6 +149,9 @@
 
 #define PHY_PLL_CFG			0x30038
 
+#define PHY_PMA_CMN_CTRL2		0x38004
+#define PHY_PMA_PLL_RAW_CTRL		0x3800c
+
 struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
@@ -184,12 +196,18 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned char num_bits,
 				    unsigned int val);
 
+static int cdns_torrent_dp_configure(struct phy *phy,
+				     union phy_configure_opts *opts);
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate);
 static int cdns_torrent_phy_on(struct phy *phy);
 static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_dp_init,
 	.exit		= cdns_torrent_dp_exit,
+	.configure	= cdns_torrent_dp_configure,
 	.power_on	= cdns_torrent_phy_on,
 	.power_off	= cdns_torrent_phy_off,
 	.owner		= THIS_MODULE,
@@ -203,6 +221,16 @@ static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
 	writel(val, cdns_phy->sd_base + offset);
 }
 
+static u32 cdns_torrent_phy_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+{
+	return readl(cdns_phy->sd_base + offset);
+}
+
+#define cdns_torrent_phy_read_poll_timeout(cdns_phy, offset, val, cond, \
+					   delay_us, timeout_us) \
+	readl_poll_timeout((cdns_phy)->sd_base + (offset), \
+			   val, cond, delay_us, timeout_us)
+
 /* DPTX mmr access functions */
 
 static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
@@ -221,6 +249,237 @@ static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
 	readl_poll_timeout((cdns_phy)->base + (offset), \
 			   val, cond, delay_us, timeout_us)
 
+/*
+ * Structure used to store values of PHY registers for voltage-related
+ * coefficients, for particular voltage swing and pre-emphasis level. Values
+ * are shared across all physical lanes.
+ */
+struct coefficients {
+	/* Value of DRV_DIAG_TX_DRV register to use */
+	u16 diag_tx_drv;
+	/* Value of TX_TXCC_MGNFS_MULT_000 register to use */
+	u16 mgnfs_mult;
+	/* Value of TX_TXCC_CPOST_MULT_00 register to use */
+	u16 cpost_mult;
+};
+
+/*
+ * Array consists of values of voltage-related registers for sd0801 PHY. A value
+ * of 0xFFFF is a placeholder for invalid combination, and will never be used.
+ */
+static const struct coefficients vltg_coeff[4][4] = {
+	/* voltage swing 0, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x002A,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x001F,
+		 .cpost_mult = 0x0014},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0012,
+		 .cpost_mult = 0x0020},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x002A}
+	},
+
+	/* voltage swing 1, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x001F,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0013,
+		 .cpost_mult = 0x0012},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x001F},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	},
+
+	/* voltage swing 2, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0013,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x0013},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	},
+
+	/* voltage swing 3, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	}
+};
+
+/*
+ * Enable or disable PLL for selected lanes.
+ */
+static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
+				      struct phy_configure_opts_dp *dp,
+				      bool enable)
+{
+	u32 rd_val;
+	u32 ret;
+	/*
+	 * Used to determine, which bits to check for or enable in
+	 * PHY_PMA_XCVR_PLLCLK_EN register.
+	 */
+	u32 pll_bits;
+	/* Used to enable or disable lanes. */
+	u32 pll_val;
+
+	/* Select values of registers and mask, depending on enabled lane
+	 * count.
+	 */
+	switch (dp->lanes) {
+	/* lane 0 */
+	case (1):
+		pll_bits = 0x00000001;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		pll_bits = 0x00000003;
+		break;
+	/* lanes 0-3, all */
+	default:
+		pll_bits = 0x0000000F;
+		break;
+	}
+
+	if (enable)
+		pll_val = pll_bits;
+	else
+		pll_val = 0x00000000;
+
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
+
+	/* Wait for acknowledgment from PHY. */
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN_ACK,
+						rd_val,
+						(rd_val & pll_bits) == pll_val,
+						0, POLL_TIMEOUT_US);
+	ndelay(100);
+	return ret;
+}
+
+/*
+ * Perform register operations related to setting link rate, once powerstate is
+ * set and PLL disable request was processed.
+ */
+static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
+					  struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+	u32 read_val;
+
+	/* Disable the cmn_pll0_en before re-programming the new data rate. */
+	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0);
+
+	/*
+	 * Wait for PLL ready de-assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
+	 */
+	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
+						 read_val,
+						 ((read_val >> 2) & 0x01) != 0,
+						 0, POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	/* DP Rate Change - VCO Output settings. */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz) {
+		/* PMA common configuration 19.2MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
+							dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
+	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz) {
+		/* PMA common configuration 25MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
+						      dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
+	}
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
+
+	/* Enable the cmn_pll0_en. */
+	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0x3);
+
+	/*
+	 * Wait for PLL ready assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
+	 */
+	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
+						 read_val,
+						 (read_val & 0x01) != 0,
+						 0, POLL_TIMEOUT_US);
+	return ret;
+}
+
+/*
+ * Verify, that parameters to configure PHY with are correct.
+ */
+static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
+					 struct phy_configure_opts_dp *dp)
+{
+	u8 i;
+
+	/* If changing link rate was required, verify it's supported. */
+	if (dp->set_rate) {
+		switch (dp->link_rate) {
+		case 1620:
+		case 2160:
+		case 2430:
+		case 2700:
+		case 3240:
+		case 4320:
+		case 5400:
+		case 8100:
+			/* valid bit rate */
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* Verify lane count. */
+	switch (dp->lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid lane count. */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check against actual number of PHY's lanes. */
+	if (dp->lanes > cdns_phy->num_lanes)
+		return -EINVAL;
+
+	/*
+	 * If changing voltages is required, check swing and pre-emphasis
+	 * levels, per-lane.
+	 */
+	if (dp->set_voltages) {
+		/* Lane count verified previously. */
+		for (i = 0; i < dp->lanes; i++) {
+			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+				return -EINVAL;
+
+			/* Sum of voltage swing and pre-emphasis levels cannot
+			 * exceed 3.
+			 */
+			if (dp->voltage[i] + dp->pre[i] > 3)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 				       u32 num_lanes)
@@ -257,6 +516,171 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
 }
 
+/* Configure lane count as required. */
+static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
+				     struct phy_configure_opts_dp *dp)
+{
+	u32 value;
+	u32 ret;
+	u8 lane_mask = (1 << dp->lanes) - 1;
+
+	value = cdns_torrent_dp_read(cdns_phy, PHY_RESET);
+	/* clear pma_tx_elec_idle_ln_* bits. */
+	value &= ~PMA_TX_ELEC_IDLE_MASK;
+	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
+	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
+		 PMA_TX_ELEC_IDLE_MASK;
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	/* reset the link by asserting phy_l00_reset_n low */
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+			      value & (~PHY_L00_RESET_N_MASK));
+
+	/*
+	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
+	 * and powered down when re-enabling the link
+	 */
+	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+
+	/* release phy_l0*_reset_n based on used laneCount */
+	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	/* Wait, until PHY gets ready after releasing PHY reset signal. */
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	if (ret)
+		return ret;
+
+	ndelay(100);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+
+	ret = cdns_torrent_dp_run(cdns_phy);
+
+	return ret;
+}
+
+/* Configure link rate as required. */
+static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
+				    struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A3);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A0);
+	if (ret)
+		return ret;
+	ndelay(900);
+
+	return ret;
+}
+
+/* Configure voltage swing and pre-emphasis for all enabled lanes. */
+static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
+					 struct phy_configure_opts_dp *dp)
+{
+	u8 lane;
+	u16 val;
+	unsigned int lane_bits;
+
+	for (lane = 0; lane < dp->lanes; lane++) {
+		lane_bits = (lane & LANE_MASK) << 11;
+
+		val = cdns_torrent_phy_read(cdns_phy,
+					    (TX_DIAG_ACYA | lane_bits));
+		/*
+		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
+		 * current state of the analog TX driver.
+		 */
+		val |= TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_DIAG_ACYA | lane_bits), val);
+
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_CTRL | lane_bits), 0x08A4);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
+		cdns_torrent_phy_write(cdns_phy,
+				       (DRV_DIAG_TX_DRV | lane_bits), val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_MGNFS_MULT_000 | lane_bits),
+				       val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_CPOST_MULT_00 | lane_bits),
+				       val);
+
+		val = cdns_torrent_phy_read(cdns_phy,
+					    (TX_DIAG_ACYA | lane_bits));
+		/*
+		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
+		 * analog TX driver to reflect the new programmed one.
+		 */
+		val &= ~TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_DIAG_ACYA | lane_bits), val);
+	}
+};
+
+static int cdns_torrent_dp_configure(struct phy *phy,
+				     union phy_configure_opts *opts)
+{
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = cdns_torrent_dp_verify_config(cdns_phy, &opts->dp);
+	if (ret) {
+		dev_err(&phy->dev, "invalid params for phy configure\n");
+		return ret;
+	}
+
+	if (opts->dp.set_lanes) {
+		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
+			return ret;
+		}
+	}
+
+	if (opts->dp.set_rate) {
+		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
+			return ret;
+		}
+	}
+
+	if (opts->dp.set_voltages)
+		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+
+	return ret;
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
-- 
2.7.4

