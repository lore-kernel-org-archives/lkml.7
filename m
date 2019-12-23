Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13752C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AA920709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lV9hk/5T";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jZFvRV3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLWPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:17:04 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:27132 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfLWPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:17:02 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGaen027203;
        Mon, 23 Dec 2019 07:16:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=lV9hk/5Tgzu5kox+4aKP9Ff2nHZLNiL5NnE00vgVsrjqbI3tNCzeIpvNbEXWFA2Svp9L
 KSULliOZtiyQbPD3t8QF+AZ5eWj/Kerg6YI30QhheRdqQsi5sKs+h4ncorW+gStl5s/u
 7rdZDBo+q2X7u3Di3Y+4GnxhmHXD5plvA8Aes3PRGXqGzS3s82iEVm/WfElU+13HUqfb
 l0lP+OXpvKpcMxjsStAQIfbJWEAH/pjQjMedgRiYai8mEp8Eyuenook9tWCqMApzuoE9
 pmnkkL3hkaETOY6PR9ljDNRvhFxmnaSjtot2LXlXbm/q9wSKrRWdTOTPK/zkKp+njfar Sw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+3RAUifgIm8dBt3Vfpb4Ghaq5ASi5Ffuj7UffI3j7igk0unSmLbHLAsAbImzyJRhWouB8MzJRKILnqndwSq0P/QT/pCDlpe2dkKbmQVTtVmfYFpDaN52pjgO+MaGs0PcN/YugDK3sjZ9V/7S8TXLgL52EASHDjpuZG35hGrX0BZiiYy03MKwZs/gcchwSIxhebPNwsyYNk/6YUtoO12rsT2KQ5LIrhtTosd1FSNEixDwlwNiXYgrzvL/3+ZPLvfxcq/KEmS7Pm+fjAL6cvOfqbdvAoEg7cSYuPhm0p+g+D9Rw0ax6ljpr0OTeQM+gLdkol6Tg/0+Hjxx7M3G0oq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=MftxaA+RquBUvwakgtYlxnGAggWkCUUbzGEDcze9c9VLW4BQdNdK5TSrctlG39vbOo34/8IM7rPFvCd18qwZci0rUowOUVxK0I2vOTgpesN+4h7CZ198nVng2GLtlIUjQi9b7FOfrEuxDPccSPGtphBWnTwHcDV1vMN4abiP6HkFpdM5JOalBy8JeuXq6ctyOPdcPxSOKIgpdEfnQ0Kxz1dbKxiVPmkUJTIaDBmds1HSei5EbocygtgrojatDfXT8cwY28CIOhwIXyK9LqAeAARTYGvKkpz1ehoHoAzO5eqc1rAEMO4aAVIl3AFFgwzmJDBzIUgaP3RfAxVWJJVn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=jZFvRV3cvhsufA7GnKtpSOYwytRA6wGCngPrbuGb07OYJ30bHGgAYsjuGG+PGxZRiqHjtbb664OoWdc9PLP4dHYpaagspN2/BW+g42xwm2RX2T5llrPNsBxSEdFPwWyEhPShMXVqgRWgADPmqDzM3dHHrdz1EafUQzq/9MRZvbs=
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by BY5PR07MB6690.namprd07.prod.outlook.com (2603:10b6:a03:1a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 15:15:47 +0000
Received: from MW2NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT004.mail.protection.outlook.com (10.13.180.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:46 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVU093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:45 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFgtt015158;
        Mon, 23 Dec 2019 16:15:42 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFgc1015156;
        Mon, 23 Dec 2019 16:15:42 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 03/14] phy: cadence-torrent: Adopt Torrent nomenclature
Date:   Mon, 23 Dec 2019 16:15:28 +0100
Message-ID: <1577114139-14984-4-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(36092001)(54906003)(8936002)(81156014)(81166006)(478600001)(356004)(336012)(316002)(2616005)(42186006)(110136005)(6666004)(2906002)(36906005)(186003)(26005)(86362001)(107886003)(8676002)(426003)(70586007)(4326008)(36756003)(5660300002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6690;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e91e6ef-e9ac-449d-ef1e-08d787bafc7c
X-MS-TrafficTypeDiagnostic: BY5PR07MB6690:
X-Microsoft-Antispam-PRVS: <BY5PR07MB66902583CDC19E3C66B96913D22E0@BY5PR07MB6690.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1QCiy88j6AILN3nMJ6m0jrDbzxqluqcr+ry9oNmvn1H318aHTZkOnkIJ/uqhAdCCEC/lI4PwJfOJB0zqVo0yVt6oE8yRRiuA2LAWFfM/BBFW3JKCsHb8yr2vM8HueiN0cCjsiwQTjHLRaoCZCEyOkz7uEi8SPbA1aWecPi8nlOAA566eOIamjKtnLR7bM8GoNKOcVnxYKD9PiWwOPoQ4Dq/E82OKrut+xsYOh4HtMVV6sBMck14Cz5tdhmTL3FUF9rQv2cEapcQJW2uonL17abujs+RwOmUfad54DQFkLhu0eKwfOo9/B0GYvPfO1qcEPO32O47j9DTdqdJFFPQrOvo7sNvw9cz9x1i012tDAz7qDB2ddl6XC7AA9l4DodH2alUs3tNEhoxejf7unQTuY8N98EUAhcg+siHVO9wLY0fOaD9lprOdWz7kUN0HQvYJGFM08hLM9aLM8cHrfc6AW68UByGxDLWwB8HNUTRs7cDWYCccgzVrFfjT7o0wUGo
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:46.5367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91e6ef-e9ac-449d-ef1e-08d787bafc7c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6690
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

- Change private data struct cdns_dp_phy to cdns_torrent_phy
- Change module description and registration accordingly
- Generic torrent functions have prefix cdns_torrent_phy_*
- Functions specific to Torrent phy for DisplayPort are prefixed as
  cdns_torrent_dp_*

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 111 ++++++++++++++++--------------
 1 file changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index beb80f7..eb61005 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Cadence MHDP DisplayPort SD0801 PHY driver.
+ * Cadence Torrent SD0801 PHY driver.
  *
  * Copyright 2018 Cadence Design Systems, Inc.
  *
@@ -101,7 +101,7 @@
 #define RX_PSC_A3			0x2000c
 #define PHY_PLL_CFG			0x30038
 
-struct cdns_dp_phy {
+struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 num_lanes; /* Number of lanes to use */
@@ -109,36 +109,39 @@ struct cdns_dp_phy {
 	struct device *dev;
 };
 
-static int cdns_dp_phy_init(struct phy *phy);
-static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+static int cdns_torrent_dp_init(struct phy *phy);
+static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
-static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
-					unsigned int offset,
-					unsigned char start_bit,
-					unsigned char num_bits,
-					unsigned int val);
-
-static const struct phy_ops cdns_dp_phy_ops = {
-	.init		= cdns_dp_phy_init,
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy);
+static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
+				    unsigned int offset,
+				    unsigned char start_bit,
+				    unsigned char num_bits,
+				    unsigned int val);
+
+static const struct phy_ops cdns_torrent_phy_ops = {
+	.init		= cdns_torrent_dp_init,
 	.owner		= THIS_MODULE,
 };
 
-static int cdns_dp_phy_init(struct phy *phy)
+static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
 
-	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
 	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
-	cdns_dp_phy_pma_cfg(cdns_phy);
+	cdns_torrent_dp_pma_cfg(cdns_phy);
 
 	/*
 	 * Set lines power state to A0
@@ -185,24 +188,25 @@ static int cdns_dp_phy_init(struct phy *phy)
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
 	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
-		   cdns_phy->base + PHY_RESET);
+	       cdns_phy->base + PHY_RESET);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
 	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
 
 	/* PHY PMA registers configuration functions */
-	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
-	cdns_dp_phy_pma_cmn_rate(cdns_phy);
+	cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy);
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
-	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
-	cdns_dp_phy_run(cdns_phy);
+	cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	cdns_torrent_dp_run(cdns_phy);
 
 	return 0;
 }
 
-static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
@@ -214,19 +218,20 @@ static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
 			"timeout waiting for PMA common ready\n");
 }
 
-static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int i;
 
 	/* PMA common configuration */
-	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
+	cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++)
-		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
+		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
 }
 
-static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
 	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
@@ -259,7 +264,8 @@ static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
 	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
 }
 
-static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* Assumes 25 MHz refclock */
 	switch (cdns_phy->max_bit_rate) {
@@ -300,7 +306,7 @@ static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
 	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
 }
 
-static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int clk_sel_val = 0;
 	unsigned int hsclk_div_val = 0;
@@ -340,12 +346,12 @@ static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++) {
 		writel(hsclk_div_val,
-		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
+		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i << 11)));
 	}
 }
 
-static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
-				     unsigned int lane)
+static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
+					 unsigned int lane)
 {
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
@@ -361,7 +367,7 @@ static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
 	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
 }
 
-static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int read_val;
 	u32 write_val1 = 0;
@@ -382,7 +388,6 @@ static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
 	ndelay(100);
 
 	switch (cdns_phy->num_lanes) {
-
 	case 1:	/* lane 0 */
 		write_val1 = 0x00000004;
 		write_val2 = 0x00000001;
@@ -425,7 +430,7 @@ static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
 	ndelay(100);
 }
 
-static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned int offset,
 				    unsigned char start_bit,
 				    unsigned char num_bits,
@@ -438,10 +443,10 @@ static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
 		start_bit))), cdns_phy->base + offset);
 }
 
-static int cdns_dp_phy_probe(struct platform_device *pdev)
+static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
-	struct cdns_dp_phy *cdns_phy;
+	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct phy *phy;
@@ -453,9 +458,9 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 
 	cdns_phy->dev = &pdev->dev;
 
-	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
+	phy = devm_phy_create(dev, NULL, &cdns_torrent_phy_ops);
 	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create DisplayPort PHY\n");
+		dev_err(dev, "failed to create Torrent PHY\n");
 		return PTR_ERR(phy);
 	}
 
@@ -470,7 +475,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->sd_base);
 
 	err = device_property_read_u32(dev, "num_lanes",
-				       &(cdns_phy->num_lanes));
+				       &cdns_phy->num_lanes);
 	if (err)
 		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
 
@@ -487,7 +492,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 	}
 
 	err = device_property_read_u32(dev, "max_bit_rate",
-		   &(cdns_phy->max_bit_rate));
+				       &cdns_phy->max_bit_rate);
 	if (err)
 		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
 
@@ -519,23 +524,23 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id cdns_dp_phy_of_match[] = {
+static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy"
 	},
 	{}
 };
-MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
+MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
 
-static struct platform_driver cdns_dp_phy_driver = {
-	.probe	= cdns_dp_phy_probe,
+static struct platform_driver cdns_torrent_phy_driver = {
+	.probe	= cdns_torrent_phy_probe,
 	.driver = {
-		.name	= "cdns-dp-phy",
-		.of_match_table	= cdns_dp_phy_of_match,
+		.name	= "cdns-torrent-phy",
+		.of_match_table	= cdns_torrent_phy_of_match,
 	}
 };
-module_platform_driver(cdns_dp_phy_driver);
+module_platform_driver(cdns_torrent_phy_driver);
 
 MODULE_AUTHOR("Cadence Design Systems, Inc.");
-MODULE_DESCRIPTION("Cadence MHDP PHY driver");
+MODULE_DESCRIPTION("Cadence Torrent PHY driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

