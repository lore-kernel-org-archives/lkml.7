Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F41C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1344A21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XdMA+UCj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="4/cuWEFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfLKNJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50790 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728912AbfLKNJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:41 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48ZL020455;
        Wed, 11 Dec 2019 05:09:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=XdMA+UCjXn/NUlCzKe/FdPBccA/3j7+a7jUGfARyuigdXx170hEQMBb1mTg7vVDrJbMp
 QxRF+CzZEsR2RUycqKBr7dCfCxW4NAHqWIcm2SLDOWlprKaRnjwOp4dO/sOtquL3v8hg
 Gm44nsuhWxmB8KrdKL9npO7K+wezoDYDag7T99Hdi7KKiqxjuyd0+DiVV7w06g3sYWuQ
 iV6xi1LQYn+js9t2AxA+TGuwfH+Dm7GY0Cx7aD+QZ+VpxSv7YWYETJnGlUm9wBPCF86W
 NRq2N0ZduAg09TgXq8M2A9qbahXfMwesaA3lVa0zyVkjD588anyZAr5w6kZfuNkxmVgY sg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lkx1ZFPw/LxsGN1D9a8cR+xWSQ0eiAU5OC9jkEL+UmBCR99kQEKuz2RRNJWY8zwESDnt3gkuja41FJi2IngFAvRfPfGNexUG/sypl8y7Vz8Vy2qTdZg+WtBitXq8yhEinb/x0wzjESTLcE8/jdVgc/bmGS1L6bSmNcHIl0V7kNHEKuh+op5fH3/v+GhSIFWEyANIHFW1Bl/2p9+v9/UkTfk9UBv+AblJHCQXJcuLdWWZayqOx+Jx4KSBiIrV1AL8+ZfClfXaWLBg1GW30Tnp7KKHNqqv+c6Q5rMFBstoIvFlVFLx6hPdeP5Qae1dO7AErT1LcR+PUYYeM9vKdusBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=np3Xigza+AN4V7IjnRUYxvfpgAS5kGI1j87Es1rCou+plrE41cq6nIQQkUKV9IL/W4EJpz/CxmJJ2L13m2WmdVURvHLSIVsbQfu1kx/vTa5y7ZOLMiRaWMFrhg04z0oi4Md83IqhY4LmvGWZAcBoHkATzxiPQ19LYpapZrdQRsbUhOydV/MgoGFa8eiDUfooeS3Gg3JTaYoThwKciWL44bzFD12gpl4ag44HfEV77c9EAAtiE0DLEB78rSWj4Yv7SZnkXko4KMOd0hU6D24oB0evvi08iJwhx7oveFZ75FNAXJQeMWvTlBSFBi0w0QyBQqbTUq/UuhiNUrN1rRPhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfwN4Q14UDGS7CS0hz1k9/4jsySJrkl9ewwhvVIHmQc=;
 b=4/cuWEFqqlCvi9FylVp3CxjIF6c2oO3mC9YAPbhUd2yeHIz/afLLwEgxoC+xUYtw75mNT8mP53V96cRKsR8pLanc4Q2b9yRIgHqa7f0WEUlV5hhUXFN7Mxbu0AvKD4uhTPu2AyhBOfQOU9SwdBhvPAmqNGXlowPtvDKWYXDz/0c=
Received: from DM5PR07CA0105.namprd07.prod.outlook.com (2603:10b6:4:ae::34) by
 DM5PR0701MB3784.namprd07.prod.outlook.com (2603:10b6:4:7a::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 13:09:29 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::206) by DM5PR07CA0105.outlook.office365.com
 (2603:10b6:4:ae::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5d006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:27 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Mtu011651;
        Wed, 11 Dec 2019 14:09:22 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9MGt011632;
        Wed, 11 Dec 2019 14:09:22 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 04/15] phy: cadence-torrent: Adopt Torrent nomenclature
Date:   Wed, 11 Dec 2019 14:09:09 +0100
Message-ID: <1576069760-11473-5-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(189003)(199004)(86362001)(5660300002)(81156014)(76130400001)(2906002)(70586007)(8936002)(8676002)(356004)(81166006)(70206006)(316002)(26005)(6666004)(107886003)(36756003)(2616005)(426003)(336012)(110136005)(478600001)(26826003)(54906003)(186003)(42186006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3784;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ee5039-662a-4fca-0b1d-08d77e3b5b2a
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3784:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3784F1E109930AF724A0C79FD25A0@DM5PR0701MB3784.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKd4wZ5zbceh8XICqb5MTCAuJH0xkDwbhWeyKzuhI7fKG1ZKaPB0nY69J5Ig+rn4IJE+9MvCXdMPh+OHENHnY6TBfmN+Tu8h5RMPWkBNohoyARkDWpMjWYA0nvlBnNyqWpZCeQYhpH4T+DrGlSgsC8vp4YoROBAF9XI3PvPFklkKep8K+kUH/i9rCopWrciVTdVLjsBYgACTtAHt0aEhaXKsngseZNei4tftzBA4ASzqLz4KGnIm16YQZk0GPZQcorOMY9c8znN7Zfm9mr3g/cFdSODDMRmwbd3HFQXMaGfH/tAp6eCTnr1OfSHoq2tsHbhFoUtzGEPeJShNSums3aEW5TRKvKRNLbeLSzwdfzOmPKD7KQDJLJpzOQ2xg+gfrDEu2hx9wRevrmQPLoeyu2VgBOpCrPRz/UEZ6LkLGbr1KVgHdKjoMCexPgN5wGRKsBpgMwTiwEPRX5G+RSt9u6bjMxPnyos7fR2fPYXEW5XhpzshaxjZzE1+qe33eQ4Y
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:29.3196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ee5039-662a-4fca-0b1d-08d77e3b5b2a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3784
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

