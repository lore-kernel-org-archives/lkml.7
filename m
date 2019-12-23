Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D21C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E82220882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LewyyF1H";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QQ12Ljt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLWPQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:50 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbfLWPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:48 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGaef027203;
        Mon, 23 Dec 2019 07:16:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=LewyyF1H/Mq6EihBSx0lhoMWRhZW/1mkcr0jzs5lXZ5Aa/f+FHVHUzJ0/7SJ8Z9Fao2/
 sjHGrE+Lxc5FyTFyitFNWddZiFk/mF6XixEylHMuLl1vfzsXQ7suKfLH44C3p6e7gNcg
 fRQNzuhpru1DP9GYv/m81IX+WDJaYyV3vefNXvHeFYibiMGRlsqeW1rFe1pOaRUFNKHX
 f8+VRRGP8dd3uGQeO6ig0XHZ0Ch0rWs+X6BkdA5dTxCnxyn3ThEQyyd73wd6xGorWZDG
 Je6cUE+zcrult+tZHQ9sDf9Ywt1+3h2iqQl/2rwwWNnASU0n9oLipxpJZqRMPaIIWb3T Vw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohms1TgNlbo1p6pQfGrG95M5JfrdwhgxjKcF+DO/vPa2Q++c2T5bnUYvjRsgP/q+lvRaAkQS3ifUIXZssjAisw6iT/pSUP54oKilpVOttm7p2ZTbbZcKs4yOW6pcp4huGxMUfOIE4pVBLVxIxJ0SvtLQt6tUEWHllsGXMuekbkhD0CFK6Y94cWzjpQMWKk9TYLEsqzocitEkIEtFv64kSIbvdNDHsNmspT0WMWoendP2om6hZlffzt6FzyeARtkTQDfx/G4OiUtF2RaSzfzwF8imhK6gKsjPcTu1yUCIUGglDcRX1TYatV60RMt1EKlPmDm/wSrcRXVQnUDyGLa0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=b88aecy5+GQy+mahV4sGwbdB5FQ8CuL7NwEPIghaKD1h8FzSGRZCO4Mp+f37NUJBHGmAAn7Vykk1sDTRPbhEQX7FW2WuBiUrTEy8Spe9zSv0ubglFrbHPwJ0XMNuj5sZqIQP85/7F2jsHdBu+Dr3SOSwbqA4BuSXOmOkw5SRtNwT5a+50lS913ZgtQFQVn70vXeGgRGDeNsJfiT9B9Q+32rIyMVXTUhu4qtIkNXdxwk1qqRj/wJYvDdxBcV27B3EBnJQE49HhgBkqxOZy/oREvbcWK1S7iGEFQPr83rPim34zJpdi2aFRcqWnf/fnAyqnFIL3zeAEo6hZ8y7iUV8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1s9SV8J28xt9xT3FU99IXHgJ/UsYBNBEhLvoNjc6rQ=;
 b=QQ12Ljt+6QLni3hMCWECuCg3R7aTJplrBhzp970o1rDak7pREz7mFvjMp3CrhCsEECcJx7L4dptSiinaQFPtn28qDEuivK6zYRwJ6DBD49jT/Ohh1kUHf97KLeTwTQph2SEBoWAFbZWFRj7B/ooEdS73amRTwsSx4JXadFVPIVY=
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by CH2PR07MB7207.namprd07.prod.outlook.com (2603:10b6:610:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.19; Mon, 23 Dec
 2019 15:15:47 +0000
Received: from MW2NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT022.mail.protection.outlook.com (10.13.180.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVV093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:46 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFg1q015164;
        Mon, 23 Dec 2019 16:15:42 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFgQ4015162;
        Mon, 23 Dec 2019 16:15:42 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 04/14] phy: cadence-torrent: Add wrapper for PHY register access
Date:   Mon, 23 Dec 2019 16:15:29 +0100
Message-ID: <1577114139-14984-5-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(36092001)(70586007)(336012)(478600001)(107886003)(110136005)(356004)(36756003)(6666004)(426003)(70206006)(4326008)(2616005)(54906003)(42186006)(316002)(36906005)(5660300002)(8676002)(8936002)(86362001)(81166006)(30864003)(81156014)(2906002)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR07MB7207;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e819548f-11eb-4357-ddf4-08d787bafce3
X-MS-TrafficTypeDiagnostic: CH2PR07MB7207:
X-Microsoft-Antispam-PRVS: <CH2PR07MB72070F5C0A056FD130552661D22E0@CH2PR07MB7207.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yh0aAxFrwd9ACdW0JFQrn5hXWUu3AdD7PRqvTtBN2cw5PlumHi+4nACYMf8CXTDmMk9+K79hme/rIG7+bqLwQYb9vhq0Cnc27AHCJ8S42JBSE2P2uu9QD0mKlXsErqJLUGyORNUeFPjHyVP4BDZVIF/2LCwQFAB1VjGiG1TGwXUX0gWuVcAoITCCHD17ObPZlYIgTy1z8uZuwt2CnNoENJaJjpWuYBnHuC/Y/smShJHNVRInJGv2799GK+M8w5VLEQ9pxC+AU0jp4PH/vJABGlfwEON2Vdn+TiEYeblW4wENlTQqFueXoZsC+q714rqtouAwv58/k2ltGAwyRGssXIEJqYJ3aVssTc+LrzmlOJxfPuMcR08cvDjA2ciIU/DX+frsk0xvbnLLCbA5M3OblFbgKuMsQQ4Wox+NZWYkVaoo6VT5O6zkb7JdDba13I9iJm7X0r13GgoYUjoXEOkpLsEjIwJiyRds+NNN5M/q0gDE80HUOGbTEp2lPVRv0W4w
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:47.2112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e819548f-11eb-4357-ddf4-08d787bafce3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7207
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

