Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E1C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1402120882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KthXG+4a";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="xd40nBPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLWPRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:17:05 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28228 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbfLWPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:17:03 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFEpQZ001038;
        Mon, 23 Dec 2019 07:15:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=KthXG+4awAxWebYjXk252JDX00IQQ2lK4j2GjLkBHobinhwvZvLblaygQuTXcWFQsOJV
 gDdaeBSjWdWiOT6D3xXpNzrBRLYOigyJPVpJMUQ0zIXAy65/IQPe+KmamtS3IInPyu4y
 avcHGAM7P72vBa4xiKANEw7ULbZdFJWsXe4GcfLdFgG6OZPzfxn8WM4yKzNELaYfxPMo
 pyQgYch9UKkpyQjRvUNk+URaCJGxNYf3rgo9ZJ5NVOF6+mdGQN7VYFo90mes6xVcZjFA
 3T1CsS8cpUTbArMgTMuX3JSaycTmKBxa2BqGlrzJwbrkIYE8dAXOBlqtCFRT5dJXTy5X /g== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wapc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrRhVtxDaANMNk+aLFayWugHyEOdKyZ1qgnZCqDypUQn6avIekG500uaxQHxdinKVjM1dP5snTwpWtTzyr6mwMcYnK98R5/JIe99d8WJ3FXF+zU0nO4Y3Ykt9FbcsGLr0pojSErw8RdfGk/hLL32ZAn3depQunXLfUz7r3GphCcuKtbkcuIe83pZaXelhNxCYY3kCNVOAKnU+djGwmX4UNte7S5/4+BjyJ90r5RQysafB+N1AMvDJLdBQTCtBr4ZZijCkl7L7UvpMzXGNSldfW91UeE/iThIEE9q5J0jPbtfWXvxeXEgeh7/Dd2VGI//PsTijLMbxwku2SMq/N34qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=C8xXsVqczIbhRHgweA4R4qAOHF5ZJLMHuVb0mzZI6hGlfCbs66fHSp60m7d3qeWLg+ggMwDXDX1Cw0TA7qFEEGaRche2A9x8kZQC6LqI5r+dLFus6g8HLsvXpxUrPTY/7Kgvn6IK8EcUCypOrgbB8l+usHgvJifRJ0C37zPY3ktIWwoOcUSEOENrjSl/9qa3yshVwJUF2SaG8A2HAkNHnjOAb1M1nsMnUDHHJRXRAe0neZsMmjwO1G0qwcKIFCuDEav/2/ENBUiEvJW3v0loRkGuCBlon/m5AJ6QRisEOkhMuh5U+1WRV3Zqq8kzInpPJTouVorMTYTWXYNE0VkRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBIE2pS6cvbg1o7lFCtP9qw29ta40wLK903mmKbrRcE=;
 b=xd40nBPrzmFKKIhYqpQnxlnH7lWsXl6brgAR9zgsx6pwHZHUAYDZQmuSHbX48tzsnWUlYyZDmSk6XoJGjNy1XB8r4ZR5Expjm1HvLqznNfrKvGhHXeL54yCd8s+Rk5RQ/m41iHpLb9oTuMjgbZC2NEUqROCysdxEj3hhfUapIe4=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 SN6PR07MB5309.namprd07.prod.outlook.com (2603:10b6:805:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 15:15:49 +0000
Received: from MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::207) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT060.mail.protection.outlook.com (10.13.181.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVZ093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:48 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFiAi015197;
        Mon, 23 Dec 2019 16:15:44 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFijD015192;
        Mon, 23 Dec 2019 16:15:44 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 08/14] phy: cadence-torrent: Add 19.2 MHz reference clock support
Date:   Mon, 23 Dec 2019 16:15:33 +0100
Message-ID: <1577114139-14984-9-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36092001)(199004)(189003)(2906002)(478600001)(70206006)(356004)(70586007)(6666004)(86362001)(107886003)(186003)(36906005)(30864003)(36756003)(26005)(5660300002)(81156014)(8936002)(4326008)(316002)(54906003)(8676002)(2616005)(42186006)(336012)(426003)(81166006)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5309;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada4c801-cd8b-4150-07d0-08d787bafe17
X-MS-TrafficTypeDiagnostic: SN6PR07MB5309:
X-Microsoft-Antispam-PRVS: <SN6PR07MB53091E480A2DE6B3B1B0BA2ED22E0@SN6PR07MB5309.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3VvI2KLULDbGyqjwMXqeBcknrli4yH5smNSkCaiwPpbKHJs+NgYwwMg8WnZHjm4zHPIrX93OYgqBmirmgIPT7k5LQqNBL7Vcv1ib55I/yxu8YQYuqbtCFzb3L1ux7fCz3fq5+NABGi7rsvKMn78Cq65AzHeKgvBRdH5B+OUREHSviSNiHidIOO437l4CjBJ7jdTSjQSjGJwfs5cbiY6YIPrnk/zhg72lxHm4BmseIfHrKmqJpyIlrcbHtPE+HGOkGxUkevONptKZ2lUjOFFC1cLKnNS7NDP3rV6NNo0Znv7p05V81GVyUrBXXu9ZoPXLMS8QEz4j9YatXRPCVF1hzzPi6TtcODQ5PLAoi8RLfY3yYtN9fx+95zETwWgztvgUARUusA7dtLhWVUgOR7ziC/9EECza/Vda8idHgorP+UCR8uN5NKv+aulmT2sCYglo67zAuaiX3/dY8lrdLebQ3DzpqpbTEP2bfec3ct+f6GELpeFvn3TipjfwEwMQven
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:49.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada4c801-cd8b-4150-07d0-08d787bafe17
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5309
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

