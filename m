Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50047C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B3B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iPNEdgIm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rD1NwTcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLWPQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:11 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:65050 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbfLWPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:05 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDgoI032656;
        Mon, 23 Dec 2019 07:15:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=iPNEdgIm2SlOXMBEzNbqVuXoklpYXDrSlMZ3SbGjYkukoOlnkXQKYPSATxvCqhGYHSjl
 4J9HV0vMSQM+mKNo5Jt4bCyn++Jquy8/ETvL/uaUfr94/QJ8oO2D57St9z3y8e9o3FmW
 ba752NAMmWKimNhHKYncKrFON7XLPdTAASGDhTAa6qQBAkx/LHMAZ7tGLOHHHfW++3AX
 QdP2h0WFildjOhNnZttIhDFPHuSeV6pFgOqH1T/s9wNge+FeiBgsaVvONubPrb7FLHiv
 VTAbYr1C9mCyQ9LT6x/j+tyOIf+muVRFtciOz53I0NNuNkuAxmIeVmRjiZ7eRZzekgxn yA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wapn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdgCkJUOd0dsZz9Pa6z/J2/2lJ2cIOxnsmKbHKEsqbGh+281Ol8DDHmUBBrSDK2cusp8Th9oiGJP6pbRdgsTf/2NGRs/Pv5qIGaKk6/98jH9SAUlE9r/cgYhndEJ35bFxM90af6kb/obPBm9sRxbH75dz76GKaiRilIF8BKsMVssWjM0TNqEOML6JpLLKRagqW6SiEvKkWcswDdmyDuESle8rsSTZLHwmt3oQ60B9u5JO/Yg59+mSP8nlGjfn/oCsJ2QJkktzGLvgjqI9eUEvB6K8oJdmCDzmgR/70eNLe4jhQ6MsaI5OMLVa7bJKNWxktjguZCyIPl+ckK1SY7WYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=fIcB92GYVut0zzOOiLGpPBRqel6qmazjv9Yd5+P+1YUfmsATSqnFt0qCVES1vOo3iz/2QGOkeeWvU7VJ/ZgR/MFOf5+GxxvsNzEVPQBbcVHD/YWwnAZCXY4iM8BYo/9Xy05aAULk+6VdB5kz/P8tKD4Zh33XHGvfyG/AQ0GqkKOAp5EfEoFTS5vcGDM80UjbaFycplcB3siLRxIxC29HQ4e6c6iyyL8OvPWUzEbkNLasSZMfDSO6FfttnzgRci1zPsVrYJK+ETobYDeHmlUJ06jP+n9699ryuPh7mS60hWbqwWwnCttl8zxBm51PDGhxFJhQGMUfzaUQ8AfpCK6xxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=rD1NwTcGLBOxYbPceZCnu8MBvqvMIAh2hQ4J/Ix+fZO/6BorT/JId57mlkpfmxTGYJ+hScKxfS4jkzJ+pdPB/ruHH1G/PImKVrMn7FSF/NfKk/YPZ0sauZSfPQck1xC1I1tWowgKDtAaYJ9iRPZAPpm0Qy1W127khUD5vuZY0Gc=
Received: from BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31)
 by SN1PR07MB4096.namprd07.prod.outlook.com (2603:10b6:802:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 15:15:51 +0000
Received: from MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::203) by BYAPR07CA0054.outlook.office365.com
 (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT019.mail.protection.outlook.com (10.13.180.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVd093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:50 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:45 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:45 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFjRH015231;
        Mon, 23 Dec 2019 16:15:45 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFjbW015227;
        Mon, 23 Dec 2019 16:15:45 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 12/14] phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
Date:   Mon, 23 Dec 2019 16:15:37 +0100
Message-ID: <1577114139-14984-13-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(189003)(199004)(36756003)(81166006)(81156014)(8676002)(107886003)(110136005)(2616005)(8936002)(478600001)(2906002)(86362001)(70586007)(70206006)(54906003)(26005)(30864003)(316002)(186003)(356004)(36906005)(42186006)(6666004)(426003)(5660300002)(336012)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB4096;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2587aba9-cafa-4689-4890-08d787baff66
X-MS-TrafficTypeDiagnostic: SN1PR07MB4096:
X-Microsoft-Antispam-PRVS: <SN1PR07MB40968F9DC8495202A185BA36D22E0@SN1PR07MB4096.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnxvugE4K3OWP6aiwlT9erFsURwVOQ5jqoAmeP8JLnMVXQWDHkHZa+2eKrtLnB6Pqs83wQUhmvScOEKWHe7hl7/AWF8KWA/30fQvDFh1w7zVY4YIq+mKZ4xZu9+zQVtAZzhzBTbpWb0Bt1fZHF/6RdgUsw2SgUssB8+G+uDJZfF9okcoz+UpjNsEW2Ff4nmo4sUn7lVCg2+9fGSsM7WlYswNkC/KjcjiycyLL2diVaLtEbo6mQHDh/CBqhfSwVSJX7dzg6d/nPcF1MWzl6Hz8eq/BfeIZvIC/fJL4RTAvIL3AoiD9+HfD7K78o65tcmTosoHJ1BfTB66GGljoTuaiZr2ANA2rGUdnAlLePsyhd2UKgyIMz99jk9hquAdYwHICvLp1+CwuuRNU3lqcoWq4RhEDW4+OS5ick4Ax1LnNLAif1TABIIACkDMlLOJyyCCTEt5EcbX6TkN/+RQZ8BJOkTWTJZoYznoQeD/v7OGSItzIQjmGJl2lB3S23LnsmWM
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:51.4214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2587aba9-cafa-4689-4890-08d787baff66
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4096
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Use regmap to read and write DPTX specific PHY registers.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 169 +++++++++++++++++-------------
 1 file changed, 99 insertions(+), 70 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 75b8a81..a64ed4b 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -46,11 +46,12 @@
 #define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				(0xE000 << (block_offset))
 
+#define TORRENT_DPTX_PHY_OFFSET		0x0
+
 /*
  * register offsets from DPTX PHY register block base (i.e MHDP
  * register base + 0x30a00)
  */
-#define PHY_AUX_CONFIG			0x00
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
 #define PMA_TX_ELEC_IDLE_MASK		0xF0U
@@ -66,8 +67,6 @@
 #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
-#define PHY_PMA_XCVR_TX_VMARGIN		0x38
-#define PHY_PMA_XCVR_TX_DEEMPH		0x3c
 
 /*
  * register offsets from SD0801 PHY register block base (i.e MHDP
@@ -180,6 +179,9 @@ static const struct reg_field phy_pma_cmn_ctrl_2 =
 static const struct reg_field phy_pma_pll_raw_ctrl =
 				REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
 
+static const struct reg_field phy_reset_ctrl =
+				REG_FIELD(PHY_RESET, 8, 8);
+
 static const struct of_device_id cdns_torrent_phy_of_match[];
 
 struct cdns_torrent_phy {
@@ -197,9 +199,11 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
+	struct regmap_field *phy_reset_ctrl;
 };
 
 enum phy_powerstate {
@@ -229,12 +233,6 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 					 u32 rate, u32 lanes);
-static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-				    unsigned int offset,
-				    unsigned char start_bit,
-				    unsigned char num_bits,
-				    unsigned int val);
-
 static int cdns_torrent_dp_configure(struct phy *phy,
 				     union phy_configure_opts *opts);
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
@@ -282,6 +280,27 @@ static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
+static int cdns_regmap_dptx_write(void *context, unsigned int reg,
+				  unsigned int val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg;
+
+	writel(val, ctx->base + offset);
+
+	return 0;
+}
+
+static int cdns_regmap_dptx_read(void *context, unsigned int reg,
+				 unsigned int *val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg;
+
+	*val = readl(ctx->base + offset);
+	return 0;
+}
+
 #define TORRENT_TX_LANE_CDB_REGMAP_CONF(n) \
 { \
 	.name = "torrent_tx_lane" n "_cdb", \
@@ -338,6 +357,14 @@ static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+static struct regmap_config cdns_torrent_dptx_phy_config = {
+	.name = "torrent_dptx_phy",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_dptx_write,
+	.reg_read = cdns_regmap_dptx_read,
+};
+
 /* PHY mmr access functions */
 
 static void cdns_torrent_phy_write(struct regmap *regmap, u32 offset, u32 val)
@@ -355,21 +382,18 @@ static u32 cdns_torrent_phy_read(struct regmap *regmap, u32 offset)
 
 /* DPTX mmr access functions */
 
-static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
-				  u32 offset, u32 val)
+static void cdns_torrent_dp_write(struct regmap *regmap, u32 offset, u32 val)
 {
-	writel(val, cdns_phy->base + offset);
+	regmap_write(regmap, offset, val);
 }
 
-static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+static u32 cdns_torrent_dp_read(struct regmap *regmap, u32 offset)
 {
-	return readl(cdns_phy->base + offset);
-}
+	u32 val;
 
-#define cdns_torrent_dp_read_poll_timeout(cdns_phy, offset, val, cond, \
-					  delay_us, timeout_us) \
-	readl_poll_timeout((cdns_phy)->base + (offset), \
-			   val, cond, delay_us, timeout_us)
+	regmap_read(regmap, offset, &val);
+	return val;
+}
 
 /*
  * Structure used to store values of PHY registers for voltage-related
@@ -444,6 +468,8 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 {
 	u32 rd_val;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+
 	/*
 	 * Used to determine, which bits to check for or enable in
 	 * PHY_PMA_XCVR_PLLCLK_EN register.
@@ -475,14 +501,14 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	else
 		pll_val = 0x00000000;
 
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
 
 	/* Wait for acknowledgment from PHY. */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN_ACK,
-						rd_val,
-						(rd_val & pll_bits) == pll_val,
-						0, POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap,
+				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       rd_val,
+				       (rd_val & pll_bits) == pll_val,
+				       0, POLL_TIMEOUT_US);
 	ndelay(100);
 	return ret;
 }
@@ -606,9 +632,10 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 				       u32 num_lanes)
 {
-	u32 pwr_state = cdns_torrent_dp_read(cdns_phy,
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 pwr_state = cdns_torrent_dp_read(regmap,
 					     PHY_PMA_XCVR_POWER_STATE_REQ);
-	u32 pll_clk_en = cdns_torrent_dp_read(cdns_phy,
+	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
 					      PHY_PMA_XCVR_PLLCLK_EN);
 
 	/* Lane 0 is always enabled. */
@@ -633,9 +660,8 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 		pll_clk_en &= ~(0x01U << 3);
 	}
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
 }
 
 /* Configure lane count as required. */
@@ -644,18 +670,19 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 {
 	u32 value;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	u8 lane_mask = (1 << dp->lanes) - 1;
 
-	value = cdns_torrent_dp_read(cdns_phy, PHY_RESET);
+	value = cdns_torrent_dp_read(regmap, PHY_RESET);
 	/* clear pma_tx_elec_idle_ln_* bits. */
 	value &= ~PMA_TX_ELEC_IDLE_MASK;
 	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
 	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
 		 PMA_TX_ELEC_IDLE_MASK;
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* reset the link by asserting phy_l00_reset_n low */
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+	cdns_torrent_dp_write(regmap, PHY_RESET,
 			      value & (~PHY_L00_RESET_N_MASK));
 
 	/*
@@ -663,13 +690,13 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	 * and powered down when re-enabling the link
 	 */
 	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
 
 	/* release phy_l0*_reset_n based on used laneCount */
 	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* Wait, until PHY gets ready after releasing PHY reset signal. */
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
@@ -679,7 +706,7 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	ndelay(100);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	ret = cdns_torrent_dp_run(cdns_phy);
 
@@ -806,6 +833,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	int ret;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	ret = clk_prepare_enable(cdns_phy->clk);
 	if (ret) {
@@ -830,7 +858,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		return -EINVAL;
 	}
 
-	cdns_torrent_dp_write(cdns_phy, PHY_AUX_CTRL, 0x0003); /* enable AUX */
+	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
 	cdns_torrent_dp_pma_cfg(cdns_phy);
@@ -846,11 +874,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * used lanes
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
-	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+	cdns_torrent_dp_write(regmap, PHY_RESET,
 			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	/* PHY PMA registers configuration functions */
 	/* Initialize PHY with max supported link rate, without SSC. */
@@ -866,7 +894,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 				     cdns_phy->num_lanes);
 
 	/* take out of reset */
-	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
 
 	cdns_torrent_phy_on(phy);
 
@@ -892,10 +920,10 @@ int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
-						reg, reg & 1, 0,
-						POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_CMN_READY, reg,
+				       reg & 1, 0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
@@ -1413,6 +1441,7 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	u32 mask;
 	u32 read_val;
 	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (powerstate) {
 	case (POWERSTATE_A0):
@@ -1453,15 +1482,12 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	}
 
 	/* Set power state A<n>. */
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
 	/* Wait, until PHY acknowledges power state completion. */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == value, 0,
-						POLL_TIMEOUT_US);
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
+				       read_val, (read_val & mask) == value, 0,
+				       POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
 	ndelay(100);
 
 	return ret;
@@ -1471,15 +1497,15 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int read_val;
 	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	/*
 	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
 	 * master lane
 	 */
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN_ACK,
-						read_val, read_val & 1, 0,
-						POLL_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       read_val, read_val & 1,
+				       0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
@@ -1499,21 +1525,6 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 	return ret;
 }
 
-static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-				    unsigned int offset,
-				    unsigned char start_bit,
-				    unsigned char num_bits,
-				    unsigned int val)
-{
-	unsigned int read_val;
-
-	read_val = cdns_torrent_dp_read(cdns_phy, offset);
-	cdns_torrent_dp_write(cdns_phy, offset,
-			      ((val << start_bit) |
-			      (read_val & ~(((1 << num_bits) - 1) <<
-			      start_bit))));
-}
-
 static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
@@ -1577,6 +1588,14 @@ static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
+	regmap = cdns_phy->regmap_dptx_phy_reg;
+	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_RESET reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_reset_ctrl = field;
+
 	return 0;
 }
 
@@ -1645,6 +1664,16 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 	}
 	cdns_phy->regmap_phy_pma_common_cdb = regmap;
 
+	block_offset = TORRENT_DPTX_PHY_OFFSET;
+	regmap = cdns_regmap_init(dev, base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_dptx_phy_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init DPTX PHY regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_dptx_phy_reg = regmap;
+
 	return 0;
 }
 
-- 
2.7.4

