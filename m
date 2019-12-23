Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21AC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200A222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GW+WGQur";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WlA4ISQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLWPQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:25140 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfLWPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:03 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDfRL032649;
        Mon, 23 Dec 2019 07:15:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=GW+WGQurcSrXI7dEZ7o4wDuKZj9bpxz1enAVpn9NrJWf9JMgSKGEgWnZymbtm2xYPn1T
 glZfmQU7aa2SKpgPrWY4eHmZLMUcntZis9kzkm5+iDczBdGhCbLFn6nUXaTVVYT7PrSG
 ZpNeQnEb+JCwPAmMM+nxlhlhodmtuWbGSrfcg02AuXpdIj3ESAatBIdLCrKkpOOzvti4
 7gwBD/YCTGzI025gbxF2lb4Gm6wvG/k/kh5naQIsNgb8HweBKQQOn41FW6KmywESNqF6
 uXXsETsVJa1+4ou7d+GAVbNw/xQm1B2bVyxOHs38Xmwu/9uIvBHZUGt1ce1vpA8EsbkV zQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wap8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqYFwi5DvZUk0hOOWb4QAfjJWaZVKllN/Q2WQCkwc3bEGWmT3xqASbnilE+SCNlKP+oIF3dKE7CN9ruBXMrmwrwrP44Kv2QiCAR751J+uB57xxmBMZSdYHScqVa847tf02aSQL0Mwk9ptG5M4lImAyVCTKadgnq32U0/P8DHLIfcbun1o30pYXV0jO5kdparXbtWAnomrV381luCJPUBpJRHYWya1OUJH1Z2cNTK57osqRFq6q5ZWhbm93sZacuKuX0V/vEYzcAZqd97DFc76V6EEJcM5ceQQfvXotpeITVEddTOXIj99LbqVzfKRDRNOZWvYdPolrVYdW9y5LSrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=eC7V3JdtWEDv1q/K9R61ahQsLVoKX4ipWGnvnfvcxyRreUMfNPiVAwVRX1q2seLKybSFKUGZxUKeF4dWCVaJKwRNlxPYyZ42KuAbZmgn+GENGLeEanQviiHDCFnX2jSSPhOIVzQO1pvj0EvQpqjz/5wdKq6C1wBuVksm4vOLMqRo6nqBz6l5Kl8rp/SvNW6Jy4CGktXB+/BmhEcT69VQhayFS8/Qo3F3rp7Rpode3BsjoMcmGxEIUx/Lsd3p9AVMsb7H4CYwcAVLUKzJihJqzMYSBmzrEFS4VuuKykwRF2n7VcaP5TYom47DAvHhUi30BCnThol3pDGYzLyvbvmEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=WlA4ISQr/W9F6Q78cBsmqSGFTeasATbKqClkq5KrcpdecSKG5Zqj4SNJM9VFRNVl9/tfaWS6IcZdMz8BuAfs+NYxqttkhm34xQQcWqEPhmYCnoX46Z96ONDC3gV9Sirm+8GJeBpRs4IpZHyEVeXOZyUIf9Ir8ecIiibuooSDVjk=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 DM6PR07MB4796.namprd07.prod.outlook.com (2603:10b6:5:a1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Mon, 23 Dec 2019 15:15:48 +0000
Received: from MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::207) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT060.mail.protection.outlook.com (10.13.181.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVW093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:46 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:43 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:43 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFhbh015171;
        Mon, 23 Dec 2019 16:15:43 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFhUp015168;
        Mon, 23 Dec 2019 16:15:43 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 05/14] phy: cadence-torrent: Add wrapper for DPTX register access
Date:   Mon, 23 Dec 2019 16:15:30 +0100
Message-ID: <1577114139-14984-6-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(36092001)(70206006)(26005)(186003)(2616005)(6666004)(356004)(336012)(426003)(478600001)(4326008)(86362001)(70586007)(8676002)(81156014)(81166006)(8936002)(2906002)(316002)(42186006)(54906003)(107886003)(110136005)(36906005)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4796;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904b67d3-7c3c-473d-1c6c-08d787bafd3d
X-MS-TrafficTypeDiagnostic: DM6PR07MB4796:
X-Microsoft-Antispam-PRVS: <DM6PR07MB479690295203363EBD3981B8D22E0@DM6PR07MB4796.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnrEJhnefxbQaRuRnDnfR8U/cI72vCQLTwdW/fXgqAXYNHrGb0dY+qQNTufRMBgW7qI9P5zjU8BhK+iWxtfFqozacmK1Q5BgrDp2ipkyOU5KbB0lmatiVKbWXIJmo8Xn/+pJy2+2VS9/0kmhuaMoYvYSEox+x4NFw56UzUtnYBxix1atuwUyAwzuvwkOdQNfmGOe3LdQd7quAGXj4KGXhCu0Y4CqujXszUtQTCxNJ6Nnr90KrMRzUQqXvb4VRoIUwoh44+hcGvTgnz+xxtS2jTXAJiuLTSHbgTyB5sXALE3chcoEJRRL7OU65Cz3UFLp/kf8IE9QRdzkj2KECDm/70D9Kvn6HJ1pYoq/iGQB9FrqaIwl9eiBcsaf6Ye6QmFsHhn+4qSTuhhcq+P+4xXBhAmbAVVT24zzPApTmXs42qPWKdURuJ8nwMWLJLXbEOArJE9m6iNqx2VdxylCIft/Flg7OLSQtV5he7pD7O6uR3jFaZoTKE36pMLF71WurkJC
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:47.7961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904b67d3-7c3c-473d-1c6c-08d787bafd3d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=993
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add wrapper functions to read, write DisplayPort specific PHY registers to
improve code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 71 ++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 59c85d8..5c7c185 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -140,13 +140,31 @@ static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
 	writel(val, cdns_phy->sd_base + offset);
 }
 
+/* DPTX mmr access functions */
+
+static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
+				  u32 offset, u32 val)
+{
+	writel(val, cdns_phy->base + offset);
+}
+
+static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+{
+	return readl(cdns_phy->base + offset);
+}
+
+#define cdns_torrent_dp_read_poll_timeout(cdns_phy, offset, val, cond, \
+					  delay_us, timeout_us) \
+	readl_poll_timeout((cdns_phy)->base + (offset), \
+			   val, cond, delay_us, timeout_us)
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
-	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
+	cdns_torrent_dp_write(cdns_phy, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
 	cdns_torrent_dp_pma_cfg(cdns_phy);
@@ -195,11 +213,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * used lanes
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
-	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
-	       cdns_phy->base + PHY_RESET);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
 	/* PHY PMA registers configuration functions */
 	cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy);
@@ -219,8 +237,8 @@ void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 	unsigned int reg;
 	int ret;
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
-				 reg & 1, 0, 500);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
+						reg, reg & 1, 0, 500);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
@@ -391,8 +409,10 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
 	 * master lane
 	 */
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				 read_val, read_val & 1, 0, POLL_TIMEOUT_US);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN_ACK,
+						read_val, read_val & 1, 0,
+						POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
@@ -417,28 +437,35 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 		break;
 	}
 
-	writel(write_val1, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val1);
+
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == write_val1,
+						0, POLL_TIMEOUT_US);
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
-				 read_val, (read_val & mask) == write_val1, 0,
-				 POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link power state ack\n");
 
-	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 
-	writel(write_val2, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val2);
 
-	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
-				 read_val, (read_val & mask) == write_val2, 0,
-				 POLL_TIMEOUT_US);
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == write_val2,
+						0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link power state ack\n");
 
-	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 }
 
@@ -450,9 +477,11 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 {
 	unsigned int read_val;
 
-	read_val = readl(cdns_phy->base + offset);
-	writel(((val << start_bit) | (read_val & ~(((1 << num_bits) - 1) <<
-		start_bit))), cdns_phy->base + offset);
+	read_val = cdns_torrent_dp_read(cdns_phy, offset);
+	cdns_torrent_dp_write(cdns_phy, offset,
+			      ((val << start_bit) |
+			      (read_val & ~(((1 << num_bits) - 1) <<
+			      start_bit))));
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
-- 
2.7.4

