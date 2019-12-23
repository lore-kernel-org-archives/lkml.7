Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F41C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D24E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Poyrp/o3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qEadLsJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLWPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:24:25 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfLWPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:24:25 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFOFaf018287;
        Mon, 23 Dec 2019 07:24:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=Poyrp/o38QUtoJo8e+ZymWrK8vGpcATN2eGL2ZEAoAWsyIpwEC1DyLZrBye1R2wB0oDK
 qbrjmXLOgg9bpsSLm6hgVZw+d+6ykScW0wdA9Q/+8opii6FNWQRSJRwciAS8x3F0y0Of
 G5wL+EDqeIgTSqdDAmsAG3pbtuCOL7jMCQmf5HSQIzMJt3W9+ZitYiSzQikXb89q6wU3
 hbfTeHSx2uQV7t7ApCiVOv1Q9skCXDBBVs4krYOPcGql9XjxpQIiqCLBSALmEoUuyB9i
 577ru1TMjQ8TxklUXl1R/051gShTCvr2Vt18KR0rSuGVrK5IHGsbxWcBpFdNRKBFxTa+ gQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wapb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpM6KflkqA/vZQJjZYeSeLb26qtHc9tap5O4vDIYIxH8ajK7E0TvoOcYf45g9Oz1lz+jRDVXgfcUEtV8P0cqou/QFuyPRDmg91bn2dOxwX6rdKH3fpkUyZwWeVMj6XwybxjAy9mtV9+8Zpikev3KTz3+7zkPnthB4VO6IuxcvQvdwGsN5w9af588KAjz8Dvz6fggq+RmQkiSfUjbVx952resipDtGWA8A/DAUp2t9uYhG/K77ZQzS028cXGAUryo6k3UPcxV1huVxW2ZhTdsMMi2ijG8JBfhUK8ZTmF6UY8V0Wmcr4l23VbUt974CpevxyU0VMQL+1oIGq6bdj/Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=TH9NYm6FDf3ArdgaZhQoPB0bkMIbbMP8XsdoDayD/JiBaUNpQCPwi0lzv82S52n4Cu5JOB0gPI0eMB2pEsscyF6yV2OW49pxA1vr6NL+Uza9c7D8JpRUQ4yCoPgEMarbBX1KOGRNSIqSgJzn2fZVppwX7nENGLFgG+RwoF1LvIS+oggAD1fhJBo+tsswVXNuPEDajgl2Rfs/DF4SwygJtUm8eLnr7HvMM0FOQNyYcQ9CaSMgojjUUa+kFAEr2PwmT2Xx/o41nqtPTMeGAq97muaz46CfFO6TYZ80WCIcrxRtgTdXb6pz7abFqZQ0U767WqlOdaHMi4DO4fXuHqeyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=qEadLsJJA0gdAfLWKdttPkwQS2+XS8F1qSNVP+wp2HFxMU+tI8YJDvwEtBKDrpqHoskCDtn4Dwaai47iIVmuQefkuONzd/bavfiTQRVI7uj0l+6aYQUAQlLEqZMaKp0bkZMXhtWdAAcGjyBXik6dR49aIlXahYUHJYjjrE8dLOw=
Received: from BYAPR07CA0100.namprd07.prod.outlook.com (2603:10b6:a03:12b::41)
 by BN6PR07MB3602.namprd07.prod.outlook.com (2603:10b6:405:62::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 15:15:50 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::200) by BYAPR07CA0100.outlook.office365.com
 (2603:10b6:a03:12b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVa093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:49 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFiFT015211;
        Mon, 23 Dec 2019 16:15:44 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFiWx015204;
        Mon, 23 Dec 2019 16:15:44 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 09/14] phy: cadence-torrent: Add PHY lane reset support
Date:   Mon, 23 Dec 2019 16:15:34 +0100
Message-ID: <1577114139-14984-10-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36092001)(199004)(189003)(6666004)(26005)(36906005)(86362001)(107886003)(356004)(110136005)(70206006)(186003)(316002)(42186006)(2906002)(478600001)(4326008)(70586007)(2616005)(54906003)(5660300002)(336012)(81166006)(81156014)(8936002)(8676002)(36756003)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3602;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc36aa3-40b6-4622-c5bf-08d787bafe65
X-MS-TrafficTypeDiagnostic: BN6PR07MB3602:
X-Microsoft-Antispam-PRVS: <BN6PR07MB36029E60E5C0C09C76416615D22E0@BN6PR07MB3602.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAy50sVWGkV7px1692sIrL1397FynpUBqVgn9WeonHAgDPebFSS9nQ68tcJNq6vhQ1dhnuP5MngMWGz6ySwaOEMFTnWy3x0u3naByZL2S4bcoUPBFwPWSkURcanQmHVk0NJ+pqHtcqo+HI3POvRb12IRQ3eWjBgUrjd2eKZ5jkAjyGZ1aRSZ5hjNOItlhyAzrvIazib3YgplXacQwNpgIun1RpYU6Bat889J+Q5gVCmcAPB4TBeS1Ww3qXvhCNGle5hXfldghF4FSl71H+GjChFNBSifn2zHwsxVP0RxVdAdXQJMK8RzjjDUuA9oy5K3kZJ8QaxxplYNnIhKy17a8gWwSuS1UZrqZ7/f8I7ibi1gfO1H9/k4DdwiXJC3MUPOC0FDEfEa7HP5vYoHptqTXYU/4oSWnRxZKsiZpb+1aOHH+iFeCi0cIq7pkWqwmTd95ecu5H5CPgO1wnriySbazIxdF75YPtTwzz/F2P8Qh05tE1ZudBSi0d7A1qRi4hS7
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:49.7413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc36aa3-40b6-4622-c5bf-08d787bafe65
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3602
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=914
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add reset support for PHY lane group.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6c3eaaa..ebc3b68 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #define REF_CLK_19_2MHz		19200000
 #define REF_CLK_25MHz		25000000
@@ -144,6 +145,7 @@ struct cdns_torrent_phy {
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 num_lanes; /* Number of lanes to use */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	struct reset_control *phy_rst;
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
@@ -182,9 +184,14 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned char num_bits,
 				    unsigned int val);
 
+static int cdns_torrent_phy_on(struct phy *phy);
+static int cdns_torrent_phy_off(struct phy *phy);
+
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_dp_init,
 	.exit		= cdns_torrent_dp_exit,
+	.power_on	= cdns_torrent_phy_on,
+	.power_off	= cdns_torrent_phy_off,
 	.owner		= THIS_MODULE,
 };
 
@@ -317,6 +324,9 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+
+	cdns_torrent_phy_on(phy);
+
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
@@ -945,6 +955,21 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 			      start_bit))));
 }
 
+static int cdns_torrent_phy_on(struct phy *phy)
+{
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+
+	/* Take the PHY lane group out of reset */
+	return reset_control_deassert(cdns_phy->phy_rst);
+}
+
+static int cdns_torrent_phy_off(struct phy *phy)
+{
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+
+	return reset_control_assert(cdns_phy->phy_rst);
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
@@ -976,6 +1001,8 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns_phy->sd_base))
 		return PTR_ERR(cdns_phy->sd_base);
 
+	cdns_phy->phy_rst = devm_reset_control_array_get_exclusive(dev);
+
 	err = device_property_read_u32(dev, "num_lanes",
 				       &cdns_phy->num_lanes);
 	if (err)
-- 
2.7.4

