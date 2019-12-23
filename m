Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6C72075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lhZlf2nS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6wsSlre0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLWPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21824 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbfLWPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:48 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGYK8027175;
        Mon, 23 Dec 2019 07:16:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=lhZlf2nSyQLNWEPhaNP4LNa/YxrYzZAd8NLzRNE9D/GpxX9qaYXavwrtQ09JR6TXHAeb
 OOJh8WnTWtuVSGvurwf1Mv/yedjjJf3xtLQBCRoMKQ4Sz34ZaoMRMwnFvyKSBIx4Y2lC
 O/CRhi2FdVRv1avG5H5z4hf7BSogNUnJqoqsr2CpH0hUUiFriBHX3TkRLB/+Y/M1He5M
 amX2HFhY18GCRXwz/y0iBo8LcjPDcEDGKlaPkxl8pgfB+/VdZHOm8WBtgWiFPiT9Ny5B
 u5GHlyZMUBXRtNJ/MPPh40nVCRV85TyMcnR/5zPZs1rsFxBS85f9kWI43DgSw6GsBFHZ Kg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA7YSEmpQoBKgD+zlgc4NDDYu8Nwhb92LvvH+P+bdoqEzNR0cFytObqOwHcGLtNarejYKYCNKxcEDEtq2SRHmIHQ6D98VO9J1rs+dajkptc+A2g73RXuSBmcHB+ucKeF4jPiFKaJsLwiLg6m3S2Mi2My5vC23L2DOI3NxOJqrdDFQvny4c8F6O30BhPSbc1oVXEEggSgnnwXsH4IUz+QQ3zHpgEx6+D7YeWkpf7MrBI0ClZ7Qeg0U05LSJAEBw0LT+vJvS978TWSzyRIJCQXk9xUAkj4NiUSBP9DxfbIykMWt7jNUIGyGc6eO31wdygToDPwEKeYmghciGsI3vA9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=GEG5p3gRzYQSEiS2Sf0XQlFZFozmBQFTNLT3zN7A03G2NXca3+onj4boHC3WnpURh624ChDBL57BlYyobPHHlKK4hsol7ya8EmLCHAnA46XDmuWSiw58ZThf7/Trq4y3SWpPVvAx909YN8sUUn5Lci8fF1utLl3M8J8s4GyaR7efY4XhEi4/bvexsyPjuvAxKaRe1ffwStEHT7zy/7J4Ws6A7rU1XLbD1teEVcYie5IzuxWEdOjwSRRbrMn8jkiU5R1z3FwHUZqMjETqXNE2p21+cg57FGqJRmLPnOWfrGhiDc8xu5xdGQu/bvgvsVg8cNnIsugRqLrfw80MXnUrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN0vULxSipmEzZd60jDacbkYUxrLO2+15/quWLxFwvQ=;
 b=6wsSlre04o7mnCEMt2zhUcvTwL+Z9sQwNIUAZHRazBmBRzOCVqKq7XC8Z3V7rRGK/97xUgmz3BY0rv+mE5J86UwgiqPC/0QbgTpTpqeV7IUhlZBM2GCvLhVKCfc8LhdYDTHnfdI5sEaQJfCmeDJ+0M1WfhtXntEFVqoNWqqoXQM=
Received: from BYAPR07CA0073.namprd07.prod.outlook.com (2603:10b6:a03:12b::14)
 by DM6PR07MB6601.namprd07.prod.outlook.com (2603:10b6:5:1c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Mon, 23 Dec
 2019 15:15:51 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::204) by BYAPR07CA0073.outlook.office365.com
 (2603:10b6:a03:12b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVb093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:49 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFiTX015215;
        Mon, 23 Dec 2019 16:15:44 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFiEV015214;
        Mon, 23 Dec 2019 16:15:44 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 10/14] phy: cadence-torrent: Implement PHY configure APIs
Date:   Mon, 23 Dec 2019 16:15:35 +0100
Message-ID: <1577114139-14984-11-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36092001)(189003)(199004)(36756003)(2906002)(6666004)(356004)(186003)(4326008)(107886003)(30864003)(26005)(336012)(2616005)(5660300002)(8676002)(42186006)(426003)(8936002)(110136005)(70206006)(54906003)(81166006)(81156014)(36906005)(86362001)(478600001)(316002)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6601;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21810e6c-dbcb-46d4-9df3-08d787bafeab
X-MS-TrafficTypeDiagnostic: DM6PR07MB6601:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6601B4E80DD5D51D78FFB693D22E0@DM6PR07MB6601.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaWTaTeWQjK2he0grATOuudjtcd6pJ80SQnoKLz72GCIly4KCeYYBVijgOWzYChcDVEOc+uzT0/3Qi140z28oQ19DOPLmU2ksqeqdwxJwNTe3om6hhXOttjOmGE7Si6eRVMLd+B1NTbVQyFngOKmhx8yeONqfl5Iu/oEIyYI4MI0etzO+PELHNskppj1HPsRGLLxWizHWs9U03outd/Ig259ePmJGNdRVtEyaFG7GXwhNrWoiDlmY2E3awx150iD+jRXQDltRM7d+X/veA+RzWLn5Ei290FSYZnS78smDqOQv8SjGcBY1LB0ZBv6YFTWMjNDRBdHTHuNyJKMYTQpNasmWumTpmLyWCd49KE/z/CdWvyASq5/fA6useq1rHdROZujlrOMCYj9XDFW//iusf6EOOcggJ+AiblUqEEyCFHCmH4Gc59L2DUdGdzwOeNexiw83fyEqigxKs5knWXwdU2TPkBbSm5vfF7T6VoDyhCLKvsOFyTgkwBQsBflJCg0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:50.1980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21810e6c-dbcb-46d4-9df3-08d787bafeab
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6601
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230129
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

