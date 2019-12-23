Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F60206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LGz++31p";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jpoqeB3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLWPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35836 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfLWPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:03 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDxWV032710;
        Mon, 23 Dec 2019 07:15:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Or2HLZG7SGeAjwX7scXV8uf2gLhqeTLKPCQgMvVmjlU=;
 b=LGz++31p0c9v4KbquUW22Do3I7/g/tH4r93/bBwYKU7QcaEEC6H/h1OE6aYwk8++W3hC
 0wswp5OcBK9oqtjkR4EuW2WIP3RdQhf2cVMfh0kIJ3n8qNZcHZm+YclW/lrZxvJoLMow
 lnjSx+sv/G3ln+29r2tflMu3dPwQ7yiJlylbzGvSb7HtgFOHIjUph8LngoD8OxEP1HUO
 l1HBp13OrR8Ikc/X00i/OD1PasYnbWpxAWpr76gpa8or8dgonieqTa8qNg/osZMx4AiA
 Q3HcSd7MTx7uwNWS7/jdyWWgRuhrPBfDf5HQVvGUgTIok+OTsF3BXeMvAv3WqlSs9M+M ZA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wapa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs/VpIVuA9rLVKSWpoKzVneDzU5f33u0SbkMGWfGglLflB32NAlZINPkcO/JZ8ZqylEwv6HVYn/wJ5jpZJfoMLX4p76E7PtsJ6oC+L87nFq3HIoU/Tj5v0hRuZHxfGIvYNhfkixsibtka2C99R19VjdohowZsY3CZnip2Y9ybSaw/cA1rtA99iM/1U/4IpW5ZIY3GUhs+mOTWaR/Fvc0ONiwrw2nfQUBEWD53sJWiikIIU/J/Uq7peRcvCYgZaMzdINlJE8cfMaJxJfsDZuBiQ/vEmw+4nMgFx6C4ppu32Np20K51KlksPNvjEkpKG6zksIWIUer/yWJuVnfPpWN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or2HLZG7SGeAjwX7scXV8uf2gLhqeTLKPCQgMvVmjlU=;
 b=MT5q8O74FcCloxw8FN9I/vNMujmHJ68Ly5GLI+k57EQTs1sbPhGOb6/r65IgecNehAyqfiyrGAJS1wWm+lsG4EdvByBWpZs58t4DXsg1pSrXLwnGPkLBlKSdikODFuYARh8QukSXaoyzvonoUzzjbNSsNcR+3xzhUHNMlZMo7/cbD/MMTlInPDZkXLoubbzoXSIcexVPwZbt9mnM2k6vO/42zEOZ0L/16NHJVkkbPaIli5U9CEa9i1Lqs/amQwysoO13JbaI/gObicqoBBzTzHnCaTsDY8b3dMo/PRhmq5Lu9yQEPuGzvbVcTNl12LnMoW5rpOxLxLE12BklxgpdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or2HLZG7SGeAjwX7scXV8uf2gLhqeTLKPCQgMvVmjlU=;
 b=jpoqeB3an2NEhTHia3Zc6j9jxCLbzT4yzpZhwo0PtOyt+tMC/uikxMOwsTMBdxsKqvCYyabFc3lcbILVTbNmiZ10JFwTklOQF5nr+hdGKusR7uvG0MISbwVjvAcq5hCmoLV8+kYeamriuCxBhIh8JKa+u3Sz9Cj0ffm22drDiik=
Received: from CH2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:20::41)
 by BYAPR07MB4709.namprd07.prod.outlook.com (2603:10b6:a02:f1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 15:15:48 +0000
Received: from MW2NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::207) by CH2PR07CA0028.outlook.office365.com
 (2603:10b6:610:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT011.mail.protection.outlook.com (10.13.180.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVX093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:47 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:43 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:43 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFh0n015179;
        Mon, 23 Dec 2019 16:15:43 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFhMT015178;
        Mon, 23 Dec 2019 16:15:43 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 06/14] phy: cadence-torrent: Refactor code for reusability
Date:   Mon, 23 Dec 2019 16:15:31 +0100
Message-ID: <1577114139-14984-7-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36092001)(199004)(189003)(356004)(5660300002)(2616005)(110136005)(54906003)(107886003)(70206006)(70586007)(86362001)(26005)(42186006)(316002)(6666004)(186003)(426003)(36756003)(4326008)(8676002)(81156014)(478600001)(2906002)(36906005)(81166006)(336012)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4709;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd92d4ba-43a7-4ad8-dd89-08d787bafd5b
X-MS-TrafficTypeDiagnostic: BYAPR07MB4709:
X-Microsoft-Antispam-PRVS: <BYAPR07MB470958D29CD3F2B073692B48D22E0@BYAPR07MB4709.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTRY2Lmab0iLNimmzefFELuyzpf2QAtstizzr7XekE5qDGmbEy4V3Xz4pxg/P2URj0+oXzAKZfVTDMOFbb6C1RiEcnhLKLKzjIpsiD2SaqK2M4gvHLqDSKbf4x4oPXfIrFXTEUae4FQgLd2yJONdNTpfTLYY/u7E6cmVJRxdgPpGIb8jYqBP7BaDk8ZIQ7ggtAHOzIjj+TVxhSKrJi+xZfqfiyAntTaiZGVBYMgdXrnnVm3YPqYgimIeNqY3npgFhW2YYmtfTOIHcuQ5R4OwT7iVuSmcXiMWvRR5Qb2Z9FRr7ZHTVgyaAEepHa2oi3gmbM6SxtVmaq9f4PNKIdCsb9htwFHE5J5PEuim0LlPKkvfPp1VNGY8OuQ4fSRx8sUtGC3sLg6G4H6H4adGjQrOzl3R9ZgePw15xrqwkITee4Vp9AlETCr6vPGrO8dI5kL/PnNb3EmIjlfaemGw0XhD20OyDyOiuUPqGO0o2bWwRr0JLh8oMGLGzmBJn4vbjExz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:47.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd92d4ba-43a7-4ad8-dd89-08d787bafd5b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4709
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

Add a separate function to set different power state values.
Use uniform polling timeout value. Also check return values
of functions for proper error handling.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 230 ++++++++++++++++++------------
 1 file changed, 137 insertions(+), 93 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5c7c185..b180fba 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -22,7 +22,7 @@
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
-#define POLL_TIMEOUT_US		2000
+#define POLL_TIMEOUT_US		5000
 #define LANE_MASK		0x7
 
 /*
@@ -39,6 +39,7 @@
 #define PHY_POWER_STATE_LN_1	0x0008
 #define PHY_POWER_STATE_LN_2	0x0010
 #define PHY_POWER_STATE_LN_3	0x0018
+#define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
 #define PHY_PMA_XCVR_TX_VMARGIN		0x38
@@ -109,10 +110,17 @@ struct cdns_torrent_phy {
 	struct device *dev;
 };
 
+enum phy_powerstate {
+	POWERSTATE_A0 = 0,
+	/* Powerstate A1 is unused */
+	POWERSTATE_A2 = 2,
+	POWERSTATE_A3 = 3,
+};
+
 static int cdns_torrent_dp_init(struct phy *phy);
-static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
 static
-void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
+int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
 static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
@@ -158,9 +166,46 @@ static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
 	readl_poll_timeout((cdns_phy)->base + (offset), \
 			   val, cond, delay_us, timeout_us)
 
+/* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
+static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
+				       u32 num_lanes)
+{
+	u32 pwr_state = cdns_torrent_dp_read(cdns_phy,
+					     PHY_PMA_XCVR_POWER_STATE_REQ);
+	u32 pll_clk_en = cdns_torrent_dp_read(cdns_phy,
+					      PHY_PMA_XCVR_PLLCLK_EN);
+
+	/* Lane 0 is always enabled. */
+	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+		       PHY_POWER_STATE_LN_0);
+	pll_clk_en &= ~0x01U;
+
+	if (num_lanes > 1) {
+		/* lane 1 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_1);
+		pll_clk_en &= ~(0x01U << 1);
+	}
+
+	if (num_lanes > 2) {
+		/* lanes 2 and 3 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_2);
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_3);
+		pll_clk_en &= ~(0x01U << 2);
+		pll_clk_en &= ~(0x01U << 3);
+	}
+
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
+	int ret;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
@@ -173,40 +218,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
 	 */
-
-	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
-				PHY_POWER_STATE_LN_0, 6, 0x0000);
-
-	if (cdns_phy->num_lanes >= 2) {
-		cdns_dp_phy_write_field(cdns_phy,
-					PHY_PMA_XCVR_POWER_STATE_REQ,
-					PHY_POWER_STATE_LN_1, 6, 0x0000);
-
-		if (cdns_phy->num_lanes == 4) {
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_REQ,
-						PHY_POWER_STATE_LN_2, 6, 0);
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_REQ,
-						PHY_POWER_STATE_LN_3, 6, 0);
-		}
-	}
-
-	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
-				0, 1, 0x0000);
-
-	if (cdns_phy->num_lanes >= 2) {
-		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
-					1, 1, 0x0000);
-		if (cdns_phy->num_lanes == 4) {
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN,
-						2, 1, 0x0000);
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN,
-						3, 1, 0x0000);
-		}
-	}
+	cdns_torrent_dp_set_a0_pll(cdns_phy, cdns_phy->num_lanes);
 
 	/*
 	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
@@ -225,23 +237,31 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
-	cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
-	cdns_torrent_dp_run(cdns_phy);
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = cdns_torrent_dp_run(cdns_phy);
+
+	return ret;
 }
 
 static
-void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
+int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
 
 	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
-						reg, reg & 1, 0, 500);
-	if (ret == -ETIMEDOUT)
+						reg, reg & 1, 0,
+						POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
@@ -397,12 +417,73 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
 }
 
-static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate)
+{
+	/* Register value for power state for a single byte. */
+	u32 value_part;
+	u32 value;
+	u32 mask;
+	u32 read_val;
+	u32 ret;
+
+	switch (powerstate) {
+	case (POWERSTATE_A0):
+		value_part = 0x01U;
+		break;
+	case (POWERSTATE_A2):
+		value_part = 0x04U;
+		break;
+	default:
+		/* Powerstate A3 */
+		value_part = 0x08U;
+		break;
+	}
+
+	/* Select values of registers and mask, depending on enabled
+	 * lane count.
+	 */
+	switch (num_lanes) {
+	/* lane 0 */
+	case (1):
+		value = value_part;
+		mask = 0x0000003FU;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		value = (value_part
+			 | (value_part << 8));
+		mask = 0x00003F3FU;
+		break;
+	/* lanes 0-3, all */
+	default:
+		value = (value_part
+			 | (value_part << 8)
+			 | (value_part << 16)
+			 | (value_part << 24));
+		mask = 0x3F3F3F3FU;
+		break;
+	}
+
+	/* Set power state A<n>. */
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	/* Wait, until PHY acknowledges power state completion. */
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == value, 0,
+						POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ndelay(100);
+
+	return ret;
+}
+
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int read_val;
-	u32 write_val1 = 0;
-	u32 write_val2 = 0;
-	u32 mask = 0;
 	int ret;
 
 	/*
@@ -413,60 +494,23 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 						PHY_PMA_XCVR_PLLCLK_EN_ACK,
 						read_val, read_val & 1, 0,
 						POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT)
+	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
-
-	ndelay(100);
-
-	switch (cdns_phy->num_lanes) {
-	case 1:	/* lane 0 */
-		write_val1 = 0x00000004;
-		write_val2 = 0x00000001;
-		mask = 0x0000003f;
-		break;
-	case 2: /* lane 0-1 */
-		write_val1 = 0x00000404;
-		write_val2 = 0x00000101;
-		mask = 0x00003f3f;
-		break;
-	case 4: /* lane 0-3 */
-		write_val1 = 0x04040404;
-		write_val2 = 0x01010101;
-		mask = 0x3f3f3f3f;
-		break;
+		return ret;
 	}
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val1);
-
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == write_val1,
-						0, POLL_TIMEOUT_US);
-
-	if (ret == -ETIMEDOUT)
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link power state ack\n");
-
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val2);
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
 
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == write_val2,
-						0, POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT)
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link power state ack\n");
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+					      POWERSTATE_A0);
 
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
-	ndelay(100);
+	return ret;
 }
 
 static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-- 
2.7.4

