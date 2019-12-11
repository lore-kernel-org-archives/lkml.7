Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3202C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D7E222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gIgZor1I";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GiCNe4fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfLKNKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:03 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36666 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729475AbfLKNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:48 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD47HZ020442;
        Wed, 11 Dec 2019 05:09:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=gIgZor1I3UYQDhbJJveI0sINZ+W2KXPxOvDEvBG5VdS5u9zNzPs3JpPNKU328v3Iyh/4
 IXH2TwJYUKXmbrrGrQgdSkX1otuoKbVCw9a3RJHRsQ7Xya+IMtuGly2kiT8gKazJlPLP
 qzCin9s90qIHJR8jWwMyTzTlBFtbFIpJPCjfVoAMKjz7CWpsWo8IJ30WSrpk5BjmIJ7J
 V8XCaAB/gDTAmrdE1B4LS7D6Lo6icX5Ofa+WjagVt8P7bpTTPDlmoJD958OCyBIatbjW
 K+nzB8+lO6Q80yEZBD5r7Jo0MVDpGX5K27NjL7nPYTpLQzH7jGS1b40IBPWU/rEeQUAi zQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2PTAauqhfKkVPMyd8qcH0sEIU+oMcqdjZuVur4Qg0y+8IRWlfxlJaz8GCPD5mQruHUelym2olOUXG6sFd9Trfq0DkLNIryShWeZeK2cbkM1aAkwuVWt8A0hgpiowmlX8FDXZfk0o8C/sjuIoLs4OT6AmzYgxAhHUjZ5MhWPQBJCxwOo6p9vK2L5f3E59iOUWcF8LjNKM46tX189SB+2lTsRaLQFOk8cWkBfwguKLBR/3KSEerCJ/DwjL5LU2FAEOJoaYYyPzizLxi2ypwcfIc47tC2mw4NIpkleRrZ42VrGYWXL96xEAxO+lzXzhW5jQr5CZF6HQ3s/bEutvlgNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=oQ1lKbNOKm+xtg4CWDrND5GRpEhZPv/dAz1mlzusR4l37CIwClUxEG1nd/JE8vFWXSbzmFDxQQKjcOc4y/f5hzo5G7le0SSckn/6jUQFP8HMlsd9+HUxLCkJx/BL3kDtfWAxq4cOGAy/ooDSIaVXLBu7GByVyraWf1p4CvhjsMAPYBFFGyqmeldmtbFT0QNLHaJUiUhAM+atVpNnVn91RTWg425U09iLpKx0VG2oD3KZJRTygcdu9dGCoHVHi2aRKu9A3a6lkEe+ATH3jpDjszITqkgaYfRghl88RxnKwpThc2z1VPi9F/78bLQihAAVS5P43PZON0tpVHEIEJL12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g54xKtoJV14khXf/vBUA6XNpaY5MoJ7kXjO1Wv7+06E=;
 b=GiCNe4fqMZXMYaJpmoBNhYgsMhaS+VTj+Nyvvm0JKyRL0BmEj8COoxZVM1sFVmeniUbKF+G/+MBTAC8z3MHYeKQ0TLcEsavVjmgT1dpIaOpSpLk/M7Z7egOLzevSzpCRqvr5a7zRFRt6wc8ELTNPSHscxs8fMjMzhEDR330yXfw=
Received: from SN4PR0701CA0015.namprd07.prod.outlook.com
 (2603:10b6:803:28::25) by DM6PR07MB5098.namprd07.prod.outlook.com
 (2603:10b6:5:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 11 Dec
 2019 13:09:31 +0000
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::206) by SN4PR0701CA0015.outlook.office365.com
 (2603:10b6:803:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT056.mail.protection.outlook.com (10.13.179.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5f006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:29 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9MJj011677;
        Wed, 11 Dec 2019 14:09:22 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9MbE011676;
        Wed, 11 Dec 2019 14:09:22 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 06/15] phy: cadence-torrent: Add wrapper for DPTX register access
Date:   Wed, 11 Dec 2019 14:09:11 +0100
Message-ID: <1576069760-11473-7-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(199004)(189003)(70586007)(478600001)(54906003)(70206006)(107886003)(42186006)(26826003)(4326008)(8676002)(5660300002)(110136005)(36756003)(426003)(2616005)(316002)(186003)(2906002)(81156014)(86362001)(8936002)(26005)(6666004)(356004)(336012)(76130400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5098;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24c7a2c9-0149-46f3-5786-08d77e3b5c52
X-MS-TrafficTypeDiagnostic: DM6PR07MB5098:
X-Microsoft-Antispam-PRVS: <DM6PR07MB50988C736A6825679729B211D25A0@DM6PR07MB5098.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+Kt2wkQIUrefEGTWvSiuUIr8UbYIjDIP+25ndfpF/evv1ILtl3Yt43oQ6VfU7kwp/sZffcY/50xYM5f6zCjxFuhLSYS/e08P8MhEYtkcwxG0SbbCFq8oSPS0+ZiHiNh3vZsXRQ5N52jRH3LUA9ELe7/eBUeyfPwfEuR879k5GTaB2ZDlUe5FQXdpb8pToy3QivVpv61vtV/2zszQ1k4GmvXWfHHDis8poufcGtK4ZxQS2dFI1F9w/NdiFb2ANjpFtpFhz3uvtRChtrkM9K0zO5OFRH5qto/oUTzmqZ+01hCn98jUqg9vB9JgYyk7YCTBbWVIq9JAxCwzWW/edznNq/j2bV6g1lgAOmuerZ16c2Zm+Xen+SdRbM1l7KbVTNTb+16fifze4JDee8EQVo7pQUbzUx13A3+NrdhstqpkQ3q4KLxvcXtR24BkNR6UGODnjKGrnHGcdPO9IVl4f6VZChozVb2Z1SPPNINAw1u3bkjXDYMzDREaxQ7nh+sp5dj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:31.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c7a2c9-0149-46f3-5786-08d77e3b5c52
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5098
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=964
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
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

