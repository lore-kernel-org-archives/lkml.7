Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2326C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE32173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YvpZXPo6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="llt2f1cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfLKNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:45 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56504 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729370AbfLKNJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD7a3e010249;
        Wed, 11 Dec 2019 05:09:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=YvpZXPo66qMwI7BG+45rZnxyQJ1WTyRojGRqZftUM52H/yM2YhyOzHt1OtqTitEqy4Hc
 FNyYT91dHXzRMm2h9ul+zOMsZi8OFekNQk2OP88Ifz7huZFQVQYaS15xtUiiZR73q5kD
 yInNA8G/1rPla/80zbXjs1sA2C/jvDFg+dNaFACF/H048LZAjMpXy6lZVT4lLJC3dEdY
 6oppgpdXpeQtmy8KYwJOOnqy7YlIEoFb3PslqpILdWRxQ4dIMkcvKr3g7nt8Lk4LphYl
 3h0A96nPpR/nW/CTxqwBiOMsmbZdTsDGL4goBYDWh0hsoeNcW2GJGp6zN08K3B5NjAqL +w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2wra70e3wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4e035f2T8AnUmE8RPj1x4XaOmN+gYIH2pPuz9yXRVL7WAatWKBPe1RK7nWuNp/hUw49+5G0WenZ1AKqgQBc08fExbrW59H+Y8gh+ZIlqMy1kuZik6QFNMBW5TgK8Gx/HLrvyMk/tuwhr0u/kPshs9E09wyYn1bB/Z9OgR2bhkGflG162gKT5XFkPXKIQn5wEevJJy3pshkHgx+IIGJg8ifOwOKD2y0YT+oNFy1hUMXBbL7wivo55KmilxWC98uOpqx0mqyTEsNgITWgqquKFvsJtd+EfPAD2K/5lRFv+RU7//BF4jARWzFIAnG+ismhNWjrcgK1dzX8xGRUZ6LCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=R77eAkFiExh7HW5ZnDhUIrAdsri2VgscXhTIW+09koPTtjFMk2tmbmAtZZmb4kmCBtGQfn0h+ySrLbAEmfP339W548IMmJHMNejOH3gEq2wvg/hhKZXSUJR44M4O2GfX76O/XlLZBhQ9HP3gN3F9P2RBd/wsK2g8oENWsJaMr67Lh9PNiQ15E7vMGBtMihVmPCUrCnd8FAu+nhffAWiOJ8kDfHYHwTAEkYuet9+yTUjiHUtq6cMO4Tg2YjweOeNbc9PT+Jcr5onzYf0lvUBDddZae84uhLJlaYpTEIPqOb8thA+EMjYefcp+a5rtvb0pV5gH4Ok7IuwQrEVgrtLUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=llt2f1cRBe6XI+sxVKHkVRObarTqULbDwIV8MLGJDhkMb/3niVLrY+Z8qgbL0JanEtkiUjrt+A8bNrOQXVJ6HV1t8bqbifX1aIb4UDuuqp6b/+XegnO/qxtPgXpE6VXFwgNIJAt5+5TflsC4ouIxhPgEiVwlZNztY8d6qyGw2Zs=
Received: from BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40)
 by SN2PR07MB2542.namprd07.prod.outlook.com (2603:10b6:804:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 11 Dec
 2019 13:09:31 +0000
Received: from DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::200) by BYAPR07CA0063.outlook.office365.com
 (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT046.mail.protection.outlook.com (10.13.178.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5e006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:28 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9MOg011669;
        Wed, 11 Dec 2019 14:09:22 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9MW1011667;
        Wed, 11 Dec 2019 14:09:22 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 05/15] phy: cadence-torrent: Add wrapper for PHY register access
Date:   Wed, 11 Dec 2019 14:09:10 +0100
Message-ID: <1576069760-11473-6-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(36092001)(2616005)(26005)(426003)(316002)(70586007)(186003)(70206006)(336012)(478600001)(107886003)(26826003)(4326008)(8676002)(86362001)(356004)(81156014)(81166006)(76130400001)(5660300002)(42186006)(2906002)(6666004)(110136005)(30864003)(36756003)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2542;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd07d194-000d-435a-a3d2-08d77e3b5be0
X-MS-TrafficTypeDiagnostic: SN2PR07MB2542:
X-Microsoft-Antispam-PRVS: <SN2PR07MB254204E378B0A2097D781B5BD25A0@SN2PR07MB2542.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6CGUsbZpXbqaq5odabTvQnN7nrsKg2N9cXxnIVNQCcmfhMq/yeSkz1K8+QCcBvskSlY9HMBLgA9kuQbR0IJ50XCDSW4KgYccNLs2vpzlctdfmF3xMq/Qr8cLKRMTrcrUwrzCa0bQmPk3KxU7KfF/X4XJwpSiy4axMlxG55w3fqfkX5QRng+m8B0yH5HhbR3G4C0xD9fVmuYxyRYFSwyx9tOo4T98o84uCqzlsPn40Uho113lOuGLR2o5s3TOokQu63E2xYOvJSqiLBMl8kv2MKuwuyVOYX7JeThvHkxDclyidtQbMjjXnquME1ktO4E7NlnsFFD0qcdz1ZvQFPK3VRRZI1TQTBRAsf87JRtBlDEdFEySvr2N2m6G1WDaqpvBHvdnqqSz9qRWrbGceCUpIWVWDyQhOpei7n7MI8Oez1aqi3zE/CQuj5y3iGSwbxMR2SmqrhMlM003gAVt0k3AxpbGmvNmgzAQIRSDXA04ID0f9tcbUeqx/pbNmr6rCE8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:30.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd07d194-000d-435a-a3d2-08d77e3b5be0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2542
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

Add a wrapper function to write Torrent PHY registers to improve
code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 142 ++++++++++++++++--------------
 1 file changed, 77 insertions(+), 65 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index eb61005..59c85d8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -132,6 +132,14 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+/* PHY mmr access functions */
+
+static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
+				   u32 offset, u32 val)
+{
+	writel(val, cdns_phy->sd_base + offset);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
@@ -234,34 +242,35 @@ static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
-	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
-	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
-	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
-	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
-	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
+
 	/* PLL registers */
-	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
-	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
-	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0409);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x1001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0318);
 }
 
 static
@@ -269,41 +278,41 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* Assumes 25 MHz refclock */
 	switch (cdns_phy->max_bit_rate) {
-		/* Setting VCO for 10.8GHz */
+	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
 		break;
-		/* Setting VCO for 9.72GHz */
+	/* Setting VCO for 9.72GHz */
 	case 2430:
 	case 3240:
-		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
 		break;
-		/* Setting VCO for 8.64GHz */
+	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
 		break;
-		/* Setting VCO for 8.1GHz */
+	/* Setting VCO for 8.1GHz */
 	case 8100:
-		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
 		break;
 	}
 
-	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0318);
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
@@ -313,7 +322,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	unsigned int i;
 
 	/* 16'h0000 for single DP link configuration */
-	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
 
 	switch (cdns_phy->max_bit_rate) {
 	case 1620:
@@ -324,7 +333,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	case 2430:
 	case 2700:
 		clk_sel_val = 0x0701;
-		 hsclk_div_val = 1;
+		hsclk_div_val = 1;
 		break;
 	case 3240:
 		clk_sel_val = 0x0b00;
@@ -341,13 +350,14 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 		break;
 	}
 
-	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+	cdns_torrent_phy_write(cdns_phy,
+			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < cdns_phy->num_lanes; i++) {
-		writel(hsclk_div_val,
-		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i << 11)));
-	}
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_torrent_phy_write(cdns_phy,
+				       (XCVR_DIAG_HSCLK_DIV | (i << 11)),
+				       hsclk_div_val);
 }
 
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
@@ -356,15 +366,17 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
 	/* Writing Tx/Rx Power State Controllers registers */
-	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | lane_bits));
-
-	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A3 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A0 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
 }
 
 static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
-- 
2.7.4

