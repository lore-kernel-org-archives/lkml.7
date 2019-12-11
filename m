Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC334C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F7D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AeaObzsi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dq925cxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfLKNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33276 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729469AbfLKNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:46 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48ZN020455;
        Wed, 11 Dec 2019 05:09:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=AeaObzsiZOW4Kh8hrbftvm/Pjd2AOK3hLqkmetA23Y1TvqyksC1Ut3Aog67BqU6AWXVa
 hnh/Tqt1/rVxTue9zCZx0NCJSMknoc/tzbc7V+EaRoISHmrtxQ3Qu09n6JkF2/CbN+/U
 1LS5LjZKbW1CIMsuI3cuPO7beYbQJaipF7y72LNa/0U0rWSFzNP3FonGgQmVKZ+e1PhC
 CYdsQis+eMBa+2KEWfonwrrLuGL1v1FHWAhKwU5G549A1XORG7rrKpHPTysh80EBOpb+
 fY44OWHOKzAE/is5dQ1DmFt23x59Wq/DUu5xajHQcYVxrnXLqaFKv/o6cLW9EbQX6xAK 4A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajq4OLAx2gLWQSzOsaZPZvsMZOxaYuQ/777SvlXD1twl3y8F1brEQXdBBmZN+rjQn6zg9klqOiUi4+ipQfRc8smXtEPc4zV2QGlIPwcPmnalM99ILDPIy936Da9H5B7et/DG1NvQruBawZ82UbHkXDUPWBsduhgiESgtmuSIJiSJwtaClvJ9MCce1KomWeq+Vshb0kgkDQNAG73m1UClisOAikavpZkVr8uz3p9XN68i1D8oGHnHwTcyJY0YZhrQhnio6kW+EXzoyYYYqLQvP/ng+lPd+HBeJ6I212VzxIfP+aumR7ts3LHNs0XRbIXauROwqrXHInFgdDR5mkup6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=NC+rv95+us+IzUZc6iYSlhGMdreZ57q6KiMt1Qnd98v8ZlFrcus/WtvSgesj9X+gCJhK0xWF5eV5z6AiAldovxbD7Cy4EH14VpfB+CHJUFCRiVVKYkuJQz+vKAbKlEaDhbKa29hLncUxB+NDskjEQoACz5bYEi4bCHLaz2im97QbUpFzsC22ZON+/ZegwcPM851IzUCvwt2AGrsJnsJjlRI5tLoarlE3kcMiFwXsbrQfbVBLu2MN8cqBYOvF4BlcjPCfQbkGaYY0FnRfGkuKfvxz6ZJzzIQgpjQnh8VgZXpP4dsHBxHSjfflnOObB5blxe63wmKtVDLol+2UJNCkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMkbLO17azLuNd0Mml0yUUzSefeiNPLw9O43k2jMHSg=;
 b=dq925cxWzz0LFTcIvRDnS5a1AGekCH/2E5JScjm8/+16nBgEFqV+ZdBpx5h5ERlm6SArJFK44qlxBNNRQ0/5ArU3FoIpVORfYRACPonrJk9IA9nfcN2hwSnJBDNSqdCM2gVdoeqMxc+2MWCGrLcLYIUojo7Se0Vbst4601B5RGA=
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 CY4PR07MB3094.namprd07.prod.outlook.com (2603:10b6:903:ce::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 13:09:37 +0000
Received: from MW2NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT052.mail.protection.outlook.com (10.13.180.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5j006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:34 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9N9s011697;
        Wed, 11 Dec 2019 14:09:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9NXq011696;
        Wed, 11 Dec 2019 14:09:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 10/15] phy: cadence-torrent: Add PHY lane reset support
Date:   Wed, 11 Dec 2019 14:09:15 +0100
Message-ID: <1576069760-11473-11-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36092001)(189003)(199004)(76130400001)(5660300002)(54906003)(336012)(356004)(8676002)(4326008)(2616005)(426003)(81156014)(8936002)(81166006)(186003)(70586007)(70206006)(26826003)(36756003)(107886003)(6666004)(26005)(478600001)(2906002)(42186006)(316002)(110136005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3094;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89aecc47-351c-4118-b972-08d77e3b5f76
X-MS-TrafficTypeDiagnostic: CY4PR07MB3094:
X-Microsoft-Antispam-PRVS: <CY4PR07MB30943C13E192F302EB0AA5D1D25A0@CY4PR07MB3094.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2o+TgrzpieNeIUVFHOyzoGlLHkYyfeW9LFAwwyn1OxhN+di/7PGH6G8cwVQcTa9vrd4bGbdQali6V/CXXdgaTnsFyIqHc6re2y7pUGxx0+aIHzmq3p7U7oCBrZNEXQtHhqiG9qpGPh3ihU1bXW1b4qKZ39SQmNXPn0sg0cLfv7IsXru6hvKhmHouQxvsoS+r88EuZ9F6HSMWepO3162vyCTBV33pw6krJEop0aepwYu4OhfmUro3A/4mU1FAL1R/UzzK4NuKCDUfkxNrQPWCGdDm2EeotXrwJsawL2mHOokWqIlx5O6iLDhymeGQ51ZuxzysayFNmygf3h9q695rEExXC64zZVaWD9vBSYLItcm3P0GzOgYRBUb92NO/2vrLcbNv6Ur7fKxJygvE+/gTXXQMK8OfthjG3oygiBMskhPpZVE2fQ8+0W7pP0CDY0zNZ8GVOha1qd4XWy5Vje9iNdDyx3rYoi/o+WB+0J/nhK1E4SqVudscnSt1mBGXeNQ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:36.4519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aecc47-351c-4118-b972-08d77e3b5f76
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=871
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
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

