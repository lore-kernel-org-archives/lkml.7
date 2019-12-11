Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F9C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB277222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="I7bvxv8/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dTkvLD9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfLKNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:06 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:10272 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729512AbfLKNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:52 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD4Beg020469;
        Wed, 11 Dec 2019 05:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=I7bvxv8/NT97hneB0WGm7ei5JamAQO5+8iqGkolcx3xmLF2RdqHcUs0kD9E5OcwDMzHD
 7kycVFnd35UI5UG4l6ZGQnb9jimEN1AHdppZ6QeeU5T8HarbHRCSnOi6nvmH0D6/cxU6
 9rAY2mN2sF7T0bkxdTPT2uVxLBmUpH8OedFqpatRU6OoU4amrE0r8KzZlhac62K6Ea/o
 d83ehNjvYyaiTVM3m0AFRJUPkZTbGimhQWT0bTy7W8rPPbz458/eCtqzkWISxXuWEbo6
 8X2ga4w8T6Y3JJpTcJ4UCC6uFmFJ3qPN/YKjE/QVZ3QX912SPp8CILxeHkeJ15oX4TLs Lg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkfF8Qfme/hqtQjqVFuEffU1zDluNBBRuQNauYd7sBDUdRsdrY73URk2S7SGIFZH1n33oiP1hTzMIG2h7fvEoGfmcm1SWh6nZoHPUYgUhlqeRwTHK+mrR+BEXu2o7DhO2RLuCaKfBhP5yB8eB1wF9HP2P35F2C9ceiWNWm5BE6GhLAdjYnZk+pn+0d2L9Wo97z/2qAe7nKNPCvLLCNr1uOIKME++dj4S+YGlxmxLL6Yj8F7jT34SXVQ+nPFPwvvH5KC1awMwK/vqeRzsEogBZ1GeWX5o7z+dpBtCUjsCRI4fEDENFz/6JBdX3Watn0mhLpr6l5B1cGeoYTDGTfiukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=Vxp4y67K9CsIbZxiDo7MtCE6S2r8e3ef4nVa1bfPY8u/yG42cZbetonkxqiFlS7BVD7eVgtt3reIzo0pjKQDZSnvET23QqFETkerPICDnaJ7jQhSd43UYR1DUja+KqDiwoFqljjjSf32Q2ggoxuGkZmP3OxShVjJHSkCPgc9lNgXKMBbvkYgF8bSl/zxUhbR5cAv6614eE7YFPBXaDMyRfJiJw4JlmX2ztv9LWT03/jkvRAanYool+qmtLgxLN8KqPkr7rSbNdE6m/p/ckbpachFGXTcQHArDpVI2iP2Uxv9G2BRTdtba1thQibzTH1L0P/OW572w88bJ568CBsEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGZBOpx9VdEuLgi+i7b8K5P7xYohB7N/Pz9HLRmkho=;
 b=dTkvLD9f9yNj57tVxyBTjXW/ZgEqaDStMXc1DkBaXJ3qYJeUokR5/GKKFb4Jf6csRpnXtkJASdE0GW3F5RzJt+hPmtqHJ3G1ihUn1U1yqtrwbgrRRXwxH+AJi1EbTxHa7832WXfdUEmXrmVUY5geeGLV+jjM5eytKVK7MtSWbPc=
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 BN6PR07MB3012.namprd07.prod.outlook.com (2603:10b6:404:a7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 13:09:40 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::203) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:40 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5m006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:37 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9OfO011709;
        Wed, 11 Dec 2019 14:09:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9OBI011708;
        Wed, 11 Dec 2019 14:09:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 13/15] phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
Date:   Wed, 11 Dec 2019 14:09:18 +0100
Message-ID: <1576069760-11473-14-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(36092001)(76130400001)(54906003)(478600001)(336012)(2906002)(42186006)(81156014)(81166006)(8936002)(8676002)(2616005)(26826003)(110136005)(86362001)(30864003)(36756003)(6666004)(186003)(356004)(70586007)(26005)(70206006)(316002)(426003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3012;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d903b519-d4fe-43e0-f4ba-08d77e3b616a
X-MS-TrafficTypeDiagnostic: BN6PR07MB3012:
X-Microsoft-Antispam-PRVS: <BN6PR07MB3012E578EF1C899A3EDB0FBDD25A0@BN6PR07MB3012.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvdQ9jigpJdEHwFGmduMAJSCnGWkaBSaKucgdVXc0SFzDAqKxY2JIk8J85wusNo7vFgCLcJ5N2g03Uayo+S2TmcbdsBflprQVadIqKiNE+FZknkaRrFAk7KV9iYmNzn0OxxRu6nC/li+jVb+Ghokj14cGy0Rw+/1ER6hRhqLO1RjJ4MAxSlnrNK6nyO19BUwSKDXEDsAjkTgvjxZ/X5KCjISrRqto4PLiTJfJ7KGuCTw6e8nYgDc6pMBF/aRvL6AfSiWmKSp7/cfld9CX9bJZ6MSXK9Lr3XNJWAcYdzi8sBE2kA2Jskza9SCnjMbmJ9zNWSTDksq0Ya4ZVANcYmpwqvVzSR4dL7mFcIMDlqfuB/zeRhfgvU+wDjqEZ2W8XjxBVPAHQM0O2tIR5JP61QzMS/neA93rHiOMaYVkt3KIdm/KwePadMSwzBJmKKiVs0LdOhNPOLFEVg4fRxMDFgvKtr+4MPNoh+DjRlLBijqE4zOqmHF8HSo8UJNeClc3hrL
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:39.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d903b519-d4fe-43e0-f4ba-08d77e3b616a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3012
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=932
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
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

