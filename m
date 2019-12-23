Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305DC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7684206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="giOnfw8k";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="24uflIik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLWPQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45138 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfLWPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:02 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDxWU032710;
        Mon, 23 Dec 2019 07:15:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rrEoZt9P0iVqY8fz6x9H93EeMBE9Np3wJgeqiSL2ktE=;
 b=giOnfw8kyT0S6T2WugiOPadtxPwEPgdEgP6cNu99eaWh4F3skyFjcDqKWIHz4pyRe2NN
 +JptPxZ92uOCNYUYamDAW238ZFmoAf5U74dec/dwuaxXaQxuho4SExKl8Oqi+UU/Hmlu
 qo0WLxWcrxywLevCZVJTdOVBB32ADq+tqYv3GnoZGi1rQmsWVfvPsXJA0mSc2wbi0UV0
 jA8U0JrFnsIhWjZhesqhNB6o7rIPE12ItbjF1sT5ZH92JMkiGNo6CeYOFqcruVD+PlTa
 9BktYoYQByc2NFwvpF3RkrmG2GbfX7gJdN8FOm6BOo/M57Ea8NrpqItDtp72ekGHov9w nQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6vrR8ST2eUgdlBlOlXHs7Is5R3e8yD95VkSqhsTKS17CImO7zw4Tv83krJQugZZ7d2iywIdnqGRTMkKNuDhujvAVhTyHV2kJG1GH10I61/GfbrAl0f3rah7+YwdqsBEI0WySSAp9/A6uk+ibSX0rQtc2JFfRQzi3RytZpPhEBXq2WbpnRsmKQEx3mzYbYcCUzwfnKC0gYBGkwaIlwTtH6wdQGeehNB9pN3fYeOZShHUtBI4/q4J89rIZtnmEeBSiscIFo/mnXhkCkbJBQnDgnHbyyqz74ijiT1yRocEX69izhvv06I+x++snsAcMlrxLaLkbpKzhe/dnazFiYR6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrEoZt9P0iVqY8fz6x9H93EeMBE9Np3wJgeqiSL2ktE=;
 b=Xwg2zKLCyfYQdp/NGHry0JgYfGFexREQ2YQifYFk3jfJxcH2An/KhWqiVU/BJOY8A8qxnZ8H6GxtLiKJtwUwMXETrCs+j18Mx5kWejXGbuv2qDUbAdftPVBoWw4EolhwlxClBcE/2mAwackDM/uFX3Qqn/oYOyEgO0S6hn9Pc//Pu1E8Stv8nPSWsGdZhKt2aiqbAf6ADx4P3V8xW5ppcOr19/WTFi1daTEQ6x49D0Qwlz+yAfs4i8JMwY9sSCZPrsydQCB5KmB1a2fQwjY/tRPfPOHHjlvu7NI6vfAeP4N3Fk9zg43DVftKaG8+i/FD2iPbfah3GMNBDoJoq/KJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrEoZt9P0iVqY8fz6x9H93EeMBE9Np3wJgeqiSL2ktE=;
 b=24uflIiknmhvM7rAEq7mTwhGwXQ+7sZHfwAxyCk4OEjoWaz5vgj784ibNNwQOJ4w6H9HMnAqSuxtbI8IsH9vy+SJsKYfU8kVW/roOa5pbmhlf0KbttHgu+GDZ1juQ9Xi3J75mUJ8slzPq7tz4I5hmEY9DRA0qYzRBITbOUh4yug=
Received: from CH2PR07CA0036.namprd07.prod.outlook.com (2603:10b6:610:20::49)
 by BYAPR07MB4165.namprd07.prod.outlook.com (2603:10b6:a02:c4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.17; Mon, 23 Dec
 2019 15:15:46 +0000
Received: from MW2NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::200) by CH2PR07CA0036.outlook.office365.com
 (2603:10b6:610:20::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT011.mail.protection.outlook.com (10.13.180.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVT093771
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFgLO015151;
        Mon, 23 Dec 2019 16:15:42 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFgCe015147;
        Mon, 23 Dec 2019 16:15:42 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 02/14] phy: cadence-dp: Rename to phy-cadence-torrent
Date:   Mon, 23 Dec 2019 16:15:27 +0100
Message-ID: <1577114139-14984-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36092001)(189003)(199004)(54906003)(186003)(110136005)(478600001)(2616005)(356004)(5660300002)(426003)(336012)(6666004)(8936002)(2906002)(26005)(8676002)(70206006)(81166006)(81156014)(107886003)(86362001)(36756003)(42186006)(36906005)(4326008)(316002)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4165;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb5f219-9e2d-4143-c536-08d787bafc0d
X-MS-TrafficTypeDiagnostic: BYAPR07MB4165:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4165B7657B1BCF6382842CA5D22E0@BYAPR07MB4165.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHvUovhBg7q6ZLecHkRIKmK4pqUDNdzeUXOpk38k4X6npStKDOI2qPfsxYb5uP5XXiyY06NqXS1+tZnBAEEeEZTKT8qGOwQZOfC3PceHMC/GlTutRmj9mFTR1agnmcfuDuWr5D9SClADYwJcEJGShiGqN5J+SWgtOp2pG608/EqzdPy1p1LGU+zWmB3FvbWcoCa8FZ0bYEea7Qdif9r7d8oXSxKic0TV2IhXYP/+R3RAbNIcFt6nDMKknOQNhWZwiZPx6N5Ytuy2blcNoFBRTrRbFr/+yMn2Im2er27F8dTJ1EYrSiomNW1IfOhvzeD/VAinrTiyPpqYGg1eRzDSnuSJc2dVxV02yG/MS8dJVMf1nh8KSfup5Gsa56DITIvWfn5jGarsoxhvdgSBthazm8QWgJfUcjs36+v4ifNG8m+s1Kp15MRqurXZMTdc6R+cmSHupKqH3MnWByqAlnmzMxj3icVU5ByHvnhJ5J5s1LlqcrMWxaxCq4XcxCJcgNQU
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:45.8081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5f219-9e2d-4143-c536-08d787bafc0d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4165
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

Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
to make it more generic for future use. Modifiy Makefile and Kconfig
accordingly. Also, change driver compatible from "cdns,dp-phy" to
"cdns,torrent-phy".This will not affect ABI as the driver has never
been functional, and therefore do not exist in any active use case.

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

