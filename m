Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01372464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Gh3/rtGQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="32S4XgEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfLKNKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:10 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44568 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729542AbfLKNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:54 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD7a5O010252;
        Wed, 11 Dec 2019 05:09:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=Gh3/rtGQsTqv4kYgWWb7rYP7kVLAbnkYWdtkXjS9senr+oZL3mPzIURo+QaeFGAqRLjR
 pIAbkhUuSqfAgn6c8AH3LPz0rqS1AlXrDRkpAysZ4VoSWxnzL6oxr/kcfG2t3gpXT9tX
 inkys9SVfA9zraARFRMh+zC23O9B2GqYk9UvZDj5xHl4GJIa2o5e1P394Tb+OACxZR5S
 bkPD7YxzxqyIje25B9j0qFFxGwmRV/3O0vlVeDOrAkvixL85vZtIZXa2TZN1hB7MBvIb
 1Jj+7uIXXEdU94efeH25WOOCeh3YRnfWvWgjRazCQS5eaGyLa2IZ5aZSjQvETUi2s9mL lA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2wra70e3wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXiZJYihrOkJ6IYyu+0TnQNtS5/+2Y23xI+Il1+nypvik2/gU5g4dBLmNDvbr3Khzmk5vSM5fcfluiYlyfyvsAQE+cYCh30u/g/bdUBKU1m71C6StvbSsGso4P6gMjJQ/0ii95XY8+NbOSM0HcjDAU7DD0O7VgH1RWw4pPbwboJ4IIkr/D6vPlMX9VorwaP2puSMyT9Yil3pBHnrbZ/1227GYuI+69HbdqgzHhKDcHnhWuDggT0HVP7TT/uEwTN9AlpF4y9VRlqjPlUwodlZQo5JRfts+Ax9Rjj5y82+rKtlF0EVYJOQggz5V6rE9g1TrZZEGXn9Ff1y94k6KqUnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=k6QIbkm6M16Tot94sIwHxRzjllavkVP8CWTuycnLGW0I+6h960LlmbRmkmcnwCPutFzu2iX4cu6toj/xk3zl6ZjIIqXux9gUnIXf94BmqyRN8nLmEZUhoYM0WzxpX6rn9BttI0UL3p5RVowN0JAsLVxOztn/D0ByUZXHWmq12NK6/TB6v6FOQurEAUFPVvfVfkVk/Ry5VnuvVziBOtshRnOST9qZnr136hQIAunbSqP47+8QCjzjOCmnetSO/pS1Uoa2Ao9yPit82WYUgLTuxiYTxa1JOugvjC5QYWk7OY81jPpDwUtNBwwaC0SBUhc/LDJkOHXqFiA6lD1xLV1ZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=32S4XgELlouhl31n3fdFiM41COp2z6cZvxeuwJHBqVENfsaMfDTDtSlduY3nVzzydgqkTVuVbM9YBwbNFa/uyO3ZSEJ1VuumONToCY1+6kW+LTQealkRuVJUN+2ANwAGrCuKh6DeeuyCn1Uj8l2/LzrXox0FddXsTTxv0q3kn24=
Received: from CY1PR07CA0028.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::38) by BY5PR07MB6531.namprd07.prod.outlook.com
 (2603:10b6:a03:1ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Wed, 11 Dec
 2019 13:09:36 +0000
Received: from DM6NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::207) by CY1PR07CA0028.outlook.office365.com
 (2a01:111:e400:c60a::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT060.mail.protection.outlook.com (10.13.179.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5i006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:32 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Nam011693;
        Wed, 11 Dec 2019 14:09:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9N9q011691;
        Wed, 11 Dec 2019 14:09:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 09/15] phy: cadence-torrent: Add 19.2 MHz reference clock support
Date:   Wed, 11 Dec 2019 14:09:14 +0100
Message-ID: <1576069760-11473-10-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(36092001)(110136005)(336012)(81166006)(8936002)(70206006)(70586007)(76130400001)(107886003)(26005)(36756003)(8676002)(54906003)(81156014)(4326008)(426003)(356004)(42186006)(478600001)(6666004)(30864003)(316002)(2906002)(2616005)(5660300002)(86362001)(186003)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6531;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738b8442-d599-4329-3745-08d77e3b5e9e
X-MS-TrafficTypeDiagnostic: BY5PR07MB6531:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6531560C718009B6115B3970D25A0@BY5PR07MB6531.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLdA8cj0xhtE5w8pmPmrfGLXUZR0lyUI0ZeTpHZeok/XXrZ+faZIzPAMriF4+KV4x4OysSmPfG8pAi3OlY3+L+Wgj6rhg0TNYMNTT4/+Cnf2QfGlWZY51/5JI6sk4yF0S14Ici7ZFplXXBgHEhuAYAjggE1JiIvS8f6qnPAqE2flfIMwgK0JvsuQdd7YcEC2ks9YuB8bQPkkXlO6zSAKiXwLLX32P7nCTGyj9ZkmncLBIzveo6+Kb2mVqaTYq4zdnkAjmSV4cM61/xkOfaa89fg5ArtbvFQ5CPAAs0ZkauwYvtD0/NKs5PrGVg5ZtCVJfX5SGwF4/Fdcy8Yw526XdT1ioZ4tbJjyVLgvc986+LtSy3XfRkyW0J5LeilfK4B08OvZ5CvWkgt9shSKuPzb3O3qrDScO3jneQUvz8/5ZdYb8LsoHLbXX5RHlchuMSez+6noEP1yVB56x+cWYqihBj6GCps+NUvqlerxFSmMcuffFmwInsbRpofBZ5JqJ6Bj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:35.1151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738b8442-d599-4329-3745-08d77e3b5e9e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6531
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add configuration functions for 19.2 MHz refclock support.
Add register configurations for SSC support.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 456 ++++++++++++++++++++++++++++--
 1 file changed, 440 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index b180fba..6c3eaaa 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -18,7 +19,10 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
-#define DEFAULT_NUM_LANES	2
+#define REF_CLK_19_2MHz		19200000
+#define REF_CLK_25MHz		25000000
+
+#define DEFAULT_NUM_LANES	4
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
@@ -58,6 +62,7 @@
 #define CMN_BGCAL_INIT_TMR		0x00190
 #define CMN_BGCAL_ITER_TMR		0x00194
 #define CMN_IBCAL_INIT_TMR		0x001d0
+#define CMN_PLL0_VCOCAL_TCTRL		0x00208
 #define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
 #define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
 #define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
@@ -67,10 +72,30 @@
 #define CMN_PLL0_FRACDIVH_M0		0x00248
 #define CMN_PLL0_HIGH_THR_M0		0x0024c
 #define CMN_PLL0_DSM_DIAG_M0		0x00250
+#define CMN_PLL0_SS_CTRL1_M0		0x00260
+#define CMN_PLL0_SS_CTRL2_M0            0x00264
+#define CMN_PLL0_SS_CTRL3_M0            0x00268
+#define CMN_PLL0_SS_CTRL4_M0            0x0026C
+#define CMN_PLL0_LOCK_REFCNT_START      0x00270
 #define CMN_PLL0_LOCK_PLLCNT_START	0x00278
+#define CMN_PLL0_LOCK_PLLCNT_THR        0x0027C
+#define CMN_PLL1_VCOCAL_TCTRL		0x00308
 #define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
 #define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
+#define CMN_PLL1_VCOCAL_REFTIM_START	0x00318
+#define CMN_PLL1_VCOCAL_PLLCNT_START	0x00320
+#define CMN_PLL1_INTDIV_M0		0x00340
+#define CMN_PLL1_FRACDIVL_M0		0x00344
+#define CMN_PLL1_FRACDIVH_M0		0x00348
+#define CMN_PLL1_HIGH_THR_M0		0x0034c
 #define CMN_PLL1_DSM_DIAG_M0		0x00350
+#define CMN_PLL1_SS_CTRL1_M0		0x00360
+#define CMN_PLL1_SS_CTRL2_M0            0x00364
+#define CMN_PLL1_SS_CTRL3_M0            0x00368
+#define CMN_PLL1_SS_CTRL4_M0            0x0036C
+#define CMN_PLL1_LOCK_REFCNT_START      0x00370
+#define CMN_PLL1_LOCK_PLLCNT_START	0x00378
+#define CMN_PLL1_LOCK_PLLCNT_THR        0x0037C
 #define CMN_TXPUCAL_INIT_TMR		0x00410
 #define CMN_TXPUCAL_ITER_TMR		0x00414
 #define CMN_TXPDCAL_INIT_TMR		0x00430
@@ -88,18 +113,30 @@
 #define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
 #define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
 #define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
+#define CMN_PDIAG_PLL1_CTRL_M0		0x00700
 #define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
+#define CMN_PDIAG_PLL1_CP_PADJ_M0	0x00710
+#define CMN_PDIAG_PLL1_CP_IADJ_M0	0x00714
+#define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x00718
+
 #define XCVR_DIAG_PLLDRC_CTRL		0x10394
 #define XCVR_DIAG_HSCLK_SEL		0x10398
 #define XCVR_DIAG_HSCLK_DIV		0x1039c
+#define XCVR_DIAG_BIDI_CTRL		0x103a8
 #define TX_PSC_A0			0x10400
 #define TX_PSC_A1			0x10404
 #define TX_PSC_A2			0x10408
 #define TX_PSC_A3			0x1040c
+#define TX_RCVDET_ST_TMR		0x1048c
 #define RX_PSC_A0			0x20000
 #define RX_PSC_A1			0x20004
 #define RX_PSC_A2			0x20008
 #define RX_PSC_A3			0x2000c
+#define RX_PSC_CAL			0x20018
+#define RX_REE_GCSM1_CTRL		0x20420
+#define RX_REE_GCSM2_CTRL		0x20440
+#define RX_REE_PERGCSM_CTRL		0x20460
+
 #define PHY_PLL_CFG			0x30038
 
 struct cdns_torrent_phy {
@@ -108,6 +145,8 @@ struct cdns_torrent_phy {
 	u32 num_lanes; /* Number of lanes to use */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
 	struct device *dev;
+	struct clk *clk;
+	unsigned long ref_clk_rate;
 };
 
 enum phy_powerstate {
@@ -118,17 +157,25 @@ enum phy_powerstate {
 };
 
 static int cdns_torrent_dp_init(struct phy *phy);
+static int cdns_torrent_dp_exit(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
 static
+void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 rate, bool ssc);
+static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
+					   u32 rate, bool ssc);
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
-static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 u32 rate, u32 lanes);
 static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned int offset,
 				    unsigned char start_bit,
@@ -137,6 +184,7 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_dp_init,
+	.exit		= cdns_torrent_dp_exit,
 	.owner		= THIS_MODULE,
 };
 
@@ -209,6 +257,29 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
+	ret = clk_prepare_enable(cdns_phy->clk);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
+		return ret;
+	}
+
+	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
+	if (!(cdns_phy->ref_clk_rate)) {
+		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
+		clk_disable_unprepare(cdns_phy->clk);
+		return -EINVAL;
+	}
+
+	switch (cdns_phy->ref_clk_rate) {
+	case REF_CLK_19_2MHz:
+	case REF_CLK_25MHz:
+		/* Valid Ref Clock Rate */
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
+	}
+
 	cdns_torrent_dp_write(cdns_phy, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
@@ -232,8 +303,17 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	/* PHY PMA registers configuration functions */
-	cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy);
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy);
+	/* Initialize PHY with max supported link rate, without SSC. */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
+							cdns_phy->max_bit_rate,
+							false);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
+						      cdns_phy->max_bit_rate,
+						      false);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
+				     cdns_phy->num_lanes);
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
@@ -246,6 +326,14 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
+static int cdns_torrent_dp_exit(struct phy *phy)
+{
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(cdns_phy->clk);
+	return 0;
+}
+
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
@@ -268,8 +356,12 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int i;
 
-	/* PMA common configuration */
-	cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+		/* PMA common configuration 19.2MHz */
+		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+		/* PMA common configuration 25MHz */
+		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++)
@@ -277,6 +369,225 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 }
 
 static
+void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
+{
+	/* refclock registers - assumes 19.2 MHz refclock */
+	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0014);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x0060);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x0060);
+	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0014);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x0240);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000B);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x0137);
+
+	/* PLL registers */
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+}
+
+/*
+ * Set registers responsible for enabling and configuring SSC, with second and
+ * third register values provided by parameters.
+ */
+static
+void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					u32 ctrl2_val, u32 ctrl3_val)
+{
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+}
+
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 rate, bool ssc)
+{
+	/* Assumes 19.2 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
+							   0x006A);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
+							   0x0069);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
+							   0x0069);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
+							   0x006A);
+		break;
+	}
+
+	if (ssc) {
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
+		/* Set reset register values to disable SSC */
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	}
+
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
+}
+
+static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
@@ -300,22 +611,47 @@ void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
 
 	/* PLL registers */
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0409);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x1001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
 	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
 	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
 	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
 	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
 	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
 	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0318);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+}
+
+/*
+ * Set registers responsible for enabling and configuring SSC, with second
+ * register value provided by a parameter.
+ */
+static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 ctrl2_val)
+{
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
 static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
+					   u32 rate, bool ssc)
 {
 	/* Assumes 25 MHz refclock */
-	switch (cdns_phy->max_bit_rate) {
+	switch (rate) {
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
@@ -323,14 +659,27 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0120);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
 		break;
 	/* Setting VCO for 9.72GHz */
+	case 1620:
 	case 2430:
 	case 3240:
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0104);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
@@ -339,6 +688,12 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00E7);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
@@ -346,14 +701,55 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
 		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00D8);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
 		break;
 	}
 
 	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0318);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+
+	if (ssc) {
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
+		/* Set reset register values to disable SSC */
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	}
+
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
-static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 u32 rate, u32 lanes)
 {
 	unsigned int clk_sel_val = 0;
 	unsigned int hsclk_div_val = 0;
@@ -362,7 +758,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	/* 16'h0000 for single DP link configuration */
 	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
 
-	switch (cdns_phy->max_bit_rate) {
+	switch (rate) {
 	case 1620:
 		clk_sel_val = 0x0f01;
 		hsclk_div_val = 2;
@@ -390,6 +786,8 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 
 	cdns_torrent_phy_write(cdns_phy,
 			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
+	cdns_torrent_phy_write(cdns_phy,
+			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++)
@@ -403,6 +801,14 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 {
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
+	/* Per lane, refclock-dependent receiver detection setting */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_RCVDET_ST_TMR | lane_bits), 0x0780);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_RCVDET_ST_TMR | lane_bits), 0x09C4);
+
 	/* Writing Tx/Rx Power State Controllers registers */
 	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
 	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
@@ -411,6 +817,17 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
 	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
 
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_CAL | lane_bits), 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy,
+			       (RX_REE_GCSM1_CTRL | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy,
+			       (RX_REE_GCSM2_CTRL | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy,
+			       (RX_REE_PERGCSM_CTRL | lane_bits), 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_BIDI_CTRL | lane_bits), 0x000F);
 	cdns_torrent_phy_write(cdns_phy,
 			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
 	cdns_torrent_phy_write(cdns_phy,
@@ -582,6 +999,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
 
 	switch (cdns_phy->max_bit_rate) {
+	case 1620:
 	case 2160:
 	case 2430:
 	case 2700:
@@ -597,6 +1015,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	cdns_phy->clk = devm_clk_get(dev, "refclk");
+	if (IS_ERR(cdns_phy->clk)) {
+		dev_err(dev, "phy ref clock not found\n");
+		return PTR_ERR(cdns_phy->clk);
+	}
+
 	phy_set_drvdata(phy, cdns_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.7.4

