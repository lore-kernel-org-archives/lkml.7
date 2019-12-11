Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200E2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Mv+8Ay9s";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rJHSb6XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfLKNKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:38 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12210 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728912AbfLKNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD4Bee020469;
        Wed, 11 Dec 2019 05:09:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=A71GnE9au1Zk8JhbrK/vkGU/jJdQUGIGvVnNNAp1d+Y=;
 b=Mv+8Ay9sMEpOYeFyWwy/LFZtFdooFQu6GuJLmHv1wutQZJMQGuaoAszWmMME7Lt71Wyj
 yEj+6Z4ppwcvykYByfQFfErtz8tKG9bOiWpiDs3U+MTKLmUzw/8EYuav1T+YW4i+O0be
 6He2hPuDLlgUukB0OiJ5yWt3DOINMdO9/6NwrOnjDEbGw+YY0pt9MWz6zjhOZA/ADFIP
 GFz1IUrsjvtVPCZPax7TQRwqIbeUr2CAszOiT4grez/i8FmvA1c9hMBM0sw5Gx5xveYO
 qX0wvhCVvJ00/IA39J/5qZ2jxuYgkORty+B0dBJ4SnGVAMPnCp+s2t4MXJPdgRQL1rD9 WA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp688-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBDN8uWHytzOT6w8/OmPVwQMQm9XcN5VpGhR2Wr1sOAyIaoTLj8EdzxCozM/9Buni3FkeN27UH5LsR86JFGBXZo3L3Q65eNwqRSYFm3GVbM6T2iXEe4/7nsUuKu63crd14d57ajOWocCYbN1lDo/Igl2KzP/OJ3inb4twWEuLgZQ/7fBKZw3IrHG5FGSVyXPvY38RHqFrVTmp7lb8CQeqz7LvSnz7IJ4wG3sYsBntbrakTXaOG5jbeU54n3uvzJNbQhlMGcpsBuZeRH9ByoGqXDHto6NuE+Tk7S1RwkAJhwS7LwNxCOObsXtpa1osIvGkIONbMGiM3aDBoS6SxD9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A71GnE9au1Zk8JhbrK/vkGU/jJdQUGIGvVnNNAp1d+Y=;
 b=NUqB2F1WllpjSOugoEDJx7ccFZYeB4W87OA7QN8F8I08vDtxSTndTg7xHqO6mmfiCMsZULAiTvGUp5pu/6S3V0S/s0L17Lw64H7TaHy/puUfgw2/SumXP4tr7WRoxOl2aiVO2iz09gyVma1kMi58N2s7xb01hIVuyKEYNxSffxNqwInM+Ch32le8VGnKlS5Sf5yq+IuccNsJGbH3gdmtnyWi7oTq4sLn+rlWQJfmwrBDVptlXsOJRBMpgsRvFTgK19mSjIaiGwEo5vqdeogzW8XHCQC0/Ug0MhmQa9p4F3H48dnuR5CByUp6Jy3Wo3z+kytB2VM0GEDL6mXrWcttYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A71GnE9au1Zk8JhbrK/vkGU/jJdQUGIGvVnNNAp1d+Y=;
 b=rJHSb6XLQ/P4snm581A20nhB+fih+28wHZ0kkyXfJwIH5OXLj/7XLMGwG3+LzsvDIRosZzSy9JnHE0UGINBk3NB5empYaY0t/zTllFOWngsNgkFlpNiSyn6wj894JLa4lxEBY2o/Yjvl5mBvF2UivrHsyirLev4l8gNi/mvGj88=
Received: from DM5PR07CA0044.namprd07.prod.outlook.com (2603:10b6:3:16::30) by
 BN7PR07MB4849.namprd07.prod.outlook.com (2603:10b6:406:ef::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Wed, 11 Dec 2019 13:09:28 +0000
Received: from DM6NAM12FT057.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::208) by DM5PR07CA0044.outlook.office365.com
 (2603:10b6:3:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT057.mail.protection.outlook.com (10.13.178.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5c006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:26 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:22 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Mnr011616;
        Wed, 11 Dec 2019 14:09:22 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9LaD011610;
        Wed, 11 Dec 2019 14:09:21 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 03/15] phy: cadence-dp: Rename to phy-cadence-torrent
Date:   Wed, 11 Dec 2019 14:09:08 +0100
Message-ID: <1576069760-11473-4-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36092001)(189003)(199004)(81166006)(81156014)(478600001)(2616005)(8676002)(26005)(336012)(426003)(26826003)(186003)(8936002)(2906002)(6666004)(4326008)(42186006)(316002)(356004)(107886003)(54906003)(70586007)(70206006)(86362001)(36756003)(5660300002)(110136005)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4849;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b12433d4-b429-4865-b057-08d77e3b5a6d
X-MS-TrafficTypeDiagnostic: BN7PR07MB4849:
X-Microsoft-Antispam-PRVS: <BN7PR07MB484994C0B6E15562FA299E13D25A0@BN7PR07MB4849.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vowH8tU7U1byKLzyPtUtUGEEqEmmUiTo8YNjDbiK4BWeI5TbJSau16UrZhcjkbGVNavO+Qk/ZTEwKBfRDXynpjxRXVhfIIZ9+9kvy7AyWJwGdBB3DZM0dDHkizfw7rZTlBDV0SwlAAGnVAX4ULjtZtOMafsdsctv30ak5JVgat0op0wFH4Zx1CceTP4qeAIfj3mpPmQUR2faWmL3C0+jj7ht5W2QdZSGrRs9+oFovpB88guP0F8tgxHiD0U+QO2BkjkbjAZOcOL2tiWZ7CV9mES3mYSwy7l/A5k5H1mzhHm28D8x149Nf2yeRxyyObvqf99JBWHPJlU/TyXeTjLCqN1ydE+bdJ4LfyvckzROMTDaDdq38KtQyE5RDR9OQWmnM6MOFmcY8QWy9+Ed5TWr5QDiw5pKZ72pNYpQ+6ut9DpLwcVuyu2KsRLavQaCPS9WhGTEzY60bE3tk9LbntPcbA/8iLSABEPVYWQrkc6o2dRBoFKF1MnDkKI7V0HX6vXo
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:28.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12433d4-b429-4865-b057-08d77e3b5a6d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4849
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

Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
to make it more generic for future use. Modifiy Makefile and Kconfig
accordingly. Also, change driver compatible from "cdns,dp-phy" to
"cdns,torrent-phy".

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/Kconfig                                     | 6 +++---
 drivers/phy/cadence/Makefile                                    | 2 +-
 drivers/phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/phy/cadence/{phy-cadence-dp.c => phy-cadence-torrent.c} (99%)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index b2db916d..4595458 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -3,13 +3,13 @@
 # Phy drivers for Cadence PHYs
 #
 
-config PHY_CADENCE_DP
-	tristate "Cadence MHDP DisplayPort PHY driver"
+config PHY_CADENCE_TORRENT
+	tristate "Cadence Torrent PHY driver"
 	depends on OF
 	depends on HAS_IOMEM
 	select GENERIC_PHY
 	help
-	  Support for Cadence MHDP DisplayPort PHY.
+	  Support for Cadence Torrent PHY.
 
 config PHY_CADENCE_DPHY
 	tristate "Cadence D-PHY Support"
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
index 8f89560..6a7ffc6 100644
--- a/drivers/phy/cadence/Makefile
+++ b/drivers/phy/cadence/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
+obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
 obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
 obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-torrent.c
similarity index 99%
rename from drivers/phy/cadence/phy-cadence-dp.c
rename to drivers/phy/cadence/phy-cadence-torrent.c
index bc10cb2..beb80f7 100644
--- a/drivers/phy/cadence/phy-cadence-dp.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -521,7 +521,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 
 static const struct of_device_id cdns_dp_phy_of_match[] = {
 	{
-		.compatible = "cdns,dp-phy"
+		.compatible = "cdns,torrent-phy"
 	},
 	{}
 };
-- 
2.7.4

