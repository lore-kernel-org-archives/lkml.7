Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57700C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5AF20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JrYaVlb3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JrYaVlb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUISJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:18:09 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:32570
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfKUISH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lAQlM/MhNbuQGxmnX34Fv0G6hKdyUmVSxsfm5aa6sQ=;
 b=JrYaVlb30A3DB7aIw/Lsie1WuLiMOtsgwv6m7e2h8XRuZSk0LJa5t5SgYaZrZFKGEDKLQ1tgp3S9+hAR1a87tSx9UzWzymOWQmDf6DPo0kss7NW2SfbNHqW0kX9uR3EE0NND58KpV2bxPO1Ku5awfHhGiSBZKBVHRU7FAcjVnkA=
Received: from VI1PR08CA0132.eurprd08.prod.outlook.com (2603:10a6:800:d4::34)
 by VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27; Thu, 21 Nov
 2019 08:17:48 +0000
Received: from DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR08CA0132.outlook.office365.com
 (2603:10a6:800:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19 via Frontend
 Transport; Thu, 21 Nov 2019 08:17:48 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT036.mail.protection.outlook.com (10.152.20.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 08:17:48 +0000
Received: ("Tessian outbound 512f710540da:v33"); Thu, 21 Nov 2019 08:17:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 68236fe4c5645d19
X-CR-MTA-TID: 64aa7808
Received: from e6ad9d4a2a70.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 86D7F68A-C55A-474C-88CB-635C05D0CFF2.1;
        Thu, 21 Nov 2019 08:17:41 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e6ad9d4a2a70.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 08:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtaMiEmbtDMEnGnekvsOvGTX5TOC8RYd2ih69tEdCfoiZQH0/5G9Z8OQk0ZmtXGdZjWDjjP0QKuXXo0L+KdJYqn4Qvlbf3I22/zApWjtd8TcfKHaiaMPhHB++F/hb6FJKsJVSYASFp3G+ahoHkUjrT2kABUhjsSB/GtIHlWnPDnwIP7OA/wdMufB6BEXXBPLbsFNwJA27N2T/nBbiaVAfqA1vw5DwoQWiLXkRwnQkWO+Xw/vtrSjzDOQ/YrfV/ftYVCfVSJjJVW3aBrFjixGQO6EOJGR/3hE1bkBrqHFGriyFqg+V/Fr6noG1qPiLl8jpLDIbXBS1icP/hFGeNe9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lAQlM/MhNbuQGxmnX34Fv0G6hKdyUmVSxsfm5aa6sQ=;
 b=Re5/4Iz3D0p7YPWsHI925hZGnYbxYf/OD5bwk8s4XHV7U6IN1I2DROiWHO1qCw8dkGnyY+FQjQj7PSJ45VN+quBeb0bss10IABUmdnfu8FWX3HqGLKD+K3UL2ChrVwuwAHbxMBo9aI9iiOd1Fq0mI6DFZ2eM8sm+c6iFtnD3TIy9yfu8aJ23c1SM2iZ4mIPR9LwUy3Bm/pbB5W3s0pfnYHifJXQB0jufO2ZOU9PeSWDExhV+hGOqskXDpYPq8dWRk9WWbM5C+PBo4CGPPv+uWd2dSWzvY1JKvswC7uc5NR6W/uZuftwGjRxA+RfAOlc8fwGGnunBp0A6qUTmRU2hVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lAQlM/MhNbuQGxmnX34Fv0G6hKdyUmVSxsfm5aa6sQ=;
 b=JrYaVlb30A3DB7aIw/Lsie1WuLiMOtsgwv6m7e2h8XRuZSk0LJa5t5SgYaZrZFKGEDKLQ1tgp3S9+hAR1a87tSx9UzWzymOWQmDf6DPo0kss7NW2SfbNHqW0kX9uR3EE0NND58KpV2bxPO1Ku5awfHhGiSBZKBVHRU7FAcjVnkA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4910.eurprd08.prod.outlook.com (10.255.114.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 08:17:39 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:17:39 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Topic: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Index: AQHVoEQj/p8RiR47xEOSjyW11KmivQ==
Date:   Thu, 21 Nov 2019 08:17:39 +0000
Message-ID: <20191121081717.29518-2-james.qian.wang@arm.com>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
In-Reply-To: <20191121081717.29518-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a74fb3c-183a-423b-4ce8-08d76e5b4b57
X-MS-TrafficTypeDiagnostic: VE1PR08MB4910:|VE1PR08MB4910:|VI1PR08MB4078:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4078E864976F89F1FEFDD497B34E0@VI1PR08MB4078.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(189003)(199004)(6116002)(3846002)(2616005)(6486002)(478600001)(86362001)(4326008)(446003)(102836004)(6636002)(71190400001)(26005)(71200400001)(54906003)(110136005)(14454004)(186003)(2501003)(11346002)(6436002)(316002)(6512007)(99286004)(25786009)(2906002)(66946007)(64756008)(7736002)(66556008)(66066001)(305945005)(15650500001)(1076003)(66476007)(256004)(14444005)(36756003)(52116002)(76176011)(386003)(6506007)(55236004)(81166006)(81156014)(8676002)(50226002)(103116003)(66446008)(8936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4910;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5uuTMF1hHNDz2ddxeirpR7kF1Oh3TFLuKeoa6inyNwO8o+M9w9dSvnQ3ij4Qt4PPxgo6sgxhMwFj/xi+VjyaCdORIve7wGD1u+T26njUW3c3repc4SC2Iyf+7rgSFABibvoxi4k3iWfbGekjrVDJ8PNaCn+eUGopk3uNcKTW4lZoJnsfAt+ydhZDJvBsx94Vkp0lPE+eoontqyn/uVMOxsbbxz4vueRpBAfecfneNEYDqde3Jd1/AhSThOy2Tq3Jn1SBWXqNx8NQNyWnXY1OeERsYhr7Y+RebMzVWU4xnjyDoMGCpQVLo9+pUVp/0UpECfRIWJDgYsIGTM9ipAXoSaakBP+zP7l6VhZ35iOxgs7LbVkdwlUKS8vD21yD82ooyNoOsZwTHmNG9wva/r0ROlWlKPjfBeFYm5rVdE9ASUXgph0TW+YQCED0Fu1fgzHA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39850400004)(1110001)(339900001)(199004)(189003)(2501003)(8936002)(2906002)(386003)(3846002)(26826003)(14454004)(25786009)(15650500001)(336012)(6116002)(26005)(54906003)(316002)(110136005)(36756003)(50466002)(103116003)(76130400001)(2616005)(11346002)(446003)(23756003)(76176011)(1076003)(66066001)(70586007)(6506007)(70206006)(102836004)(50226002)(186003)(8676002)(7736002)(105606002)(478600001)(99286004)(22756006)(47776003)(356004)(81166006)(14444005)(81156014)(6486002)(5660300002)(6636002)(4326008)(86362001)(6512007)(8746002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4078;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: db5bdc58-c6cb-42cd-9cb9-08d76e5b462a
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r++7OrdE5IbLjLXGWuTx3IC7GbLMqRIRpv5LFC39oj7N57uhpO7IVzhh1mdRMWDt3Be3X6b/PzvBV8qsZAiHJlxs6o7AdPuZ9dN3UdR5V61k0Kas4EsBkOdG5jp/R9SYYkq82j/Ffo3Pk++BNVopSjzH4l7Qt5l6LjtP01T1d9H3zQAoxPgGFbxCub02h1qwe0E7jx2dQkzMg1uOuCqyFEq3SFdnod4dicuXc0BG+KwGAOEXIGggbRda9lPMqn/SSd+jZyiVXKba6fpSgkYch7rhNlgoCM4OzXfz73+v+ljmTJTC6NCg5K9jkBi7Xbkq2EE7qvazH+nwIcErYuZgas4TJEciiI0ViM5kxsjGbAPHd8SYbH9m92K8M91DtKMmM+kPL+1fZb2oZfT7d6g0JCY86WZH0uLzmPjPp1kDU1xV9ddtASoz1lcL1LGyrbF/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 08:17:48.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a74fb3c-183a-423b-4ce8-08d76e5b4b57
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Drop komeda-CORE product id comparison and put it into the d71_identify
2. Update pipeline node DT-binding:
   (a). Skip the needless pipeline DT node.
   (b). Return fail if the essential pipeline DT node is missing.

With these changes, for one family chips no need to change the DT.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 27 +++++++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 60 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +--
 4 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 822b23a1ce75..9b3bf353b6cc 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -594,10 +594,27 @@ static const struct komeda_dev_funcs d71_chip_funcs =
=3D {
 const struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
 {
-	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
-	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
-	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
-	chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
+	const struct komeda_dev_funcs *funcs;
+	u32 product_id;
=20
-	return &d71_chip_funcs;
+	chip->core_id =3D malidp_read32(reg_base, GLB_CORE_ID);
+
+	product_id =3D MALIDP_CORE_ID_PRODUCT_ID(chip->core_id);
+
+	switch (product_id) {
+	case MALIDP_D71_PRODUCT_ID:
+		funcs =3D &d71_chip_funcs;
+		break;
+	default:
+		funcs =3D NULL;
+		DRM_ERROR("Unsupported product: 0x%x\n", product_id);
+	}
+
+	if (funcs) {
+		chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
+		chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
+		chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
+	}
+
+	return funcs;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 4dd4699d4e3d..8e0bce46555b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -116,22 +116,14 @@ static struct attribute_group komeda_sysfs_attr_group=
 =3D {
 	.attrs =3D komeda_sysfs_entries,
 };
=20
-static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
+static int komeda_parse_pipe_dt(struct komeda_pipeline *pipe)
 {
-	struct komeda_pipeline *pipe;
+	struct device_node *np =3D pipe->of_node;
 	struct clk *clk;
-	u32 pipe_id;
-	int ret =3D 0;
-
-	ret =3D of_property_read_u32(np, "reg", &pipe_id);
-	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
-		return -EINVAL;
-
-	pipe =3D mdev->pipelines[pipe_id];
=20
 	clk =3D of_clk_get_by_name(np, "pxclk");
 	if (IS_ERR(clk)) {
-		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
+		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe->id);
 		return PTR_ERR(clk);
 	}
 	pipe->pxlclk =3D clk;
@@ -145,7 +137,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev=
, struct device_node *np)
 		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
=20
 	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1];
-	pipe->of_node =3D of_node_get(np);
=20
 	return 0;
 }
@@ -154,7 +145,9 @@ static int komeda_parse_dt(struct device *dev, struct k=
omeda_dev *mdev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct device_node *child, *np =3D dev->of_node;
-	int ret;
+	struct komeda_pipeline *pipe;
+	u32 pipe_id =3D U32_MAX;
+	int ret =3D -1;
=20
 	mdev->irq  =3D platform_get_irq(pdev, 0);
 	if (mdev->irq < 0) {
@@ -169,31 +162,44 @@ static int komeda_parse_dt(struct device *dev, struct=
 komeda_dev *mdev)
 	ret =3D 0;
=20
 	for_each_available_child_of_node(np, child) {
-		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
-			ret =3D komeda_parse_pipe_dt(mdev, child);
-			if (ret) {
-				DRM_ERROR("parse pipeline dt error!\n");
-				of_node_put(child);
-				break;
+		if (of_node_name_eq(child, "pipeline")) {
+			of_property_read_u32(child, "reg", &pipe_id);
+			if (pipe_id >=3D mdev->n_pipelines) {
+				DRM_WARN("Skip the redundant DT node: pipeline-%u.\n",
+					 pipe_id);
+				continue;
 			}
+			mdev->pipelines[pipe_id]->of_node =3D of_node_get(child);
 		}
 	}
=20
+	for (pipe_id =3D 0; pipe_id < mdev->n_pipelines; pipe_id++) {
+		pipe =3D mdev->pipelines[pipe_id];
+
+		if (!pipe->of_node) {
+			DRM_ERROR("Omit DT node for pipeline-%d.\n", pipe->id);
+			return -EINVAL;
+		}
+		ret =3D komeda_parse_pipe_dt(pipe);
+		if (ret)
+			return ret;
+	}
+
 	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
 						   &mdev->side_by_side_master);
=20
-	return ret;
+	return 0;
 }
=20
 struct komeda_dev *komeda_dev_create(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
-	const struct komeda_product_data *product;
+	komeda_identify_func komeda_identify;
 	struct komeda_dev *mdev;
 	int err =3D 0;
=20
-	product =3D of_device_get_match_data(dev);
-	if (!product)
+	komeda_identify =3D of_device_get_match_data(dev);
+	if (!komeda_identify)
 		return ERR_PTR(-ENODEV);
=20
 	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
@@ -221,11 +227,9 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
=20
 	clk_prepare_enable(mdev->aclk);
=20
-	mdev->funcs =3D product->identify(mdev->reg_base, &mdev->chip);
-	if (!komeda_product_match(mdev, product->product_id)) {
-		DRM_ERROR("DT configured %x mismatch with real HW %x.\n",
-			  product->product_id,
-			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
+	mdev->funcs =3D komeda_identify(mdev->reg_base, &mdev->chip);
+	if (!mdev->funcs) {
+		DRM_ERROR("Failed to identify the HW.\n");
 		err =3D -ENODEV;
 		goto disable_clk;
 	}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 471604b42431..dacdb00153e9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -58,11 +58,6 @@
 			    | KOMEDA_EVENT_MODE \
 			    )
=20
-/* malidp device id */
-enum {
-	MALI_D71 =3D 0,
-};
-
 /* pipeline DT ports */
 enum {
 	KOMEDA_OF_PORT_OUTPUT		=3D 0,
@@ -76,12 +71,6 @@ struct komeda_chip_info {
 	u32 bus_width;
 };
=20
-struct komeda_product_data {
-	u32 product_id;
-	const struct komeda_dev_funcs *(*identify)(u32 __iomem *reg,
-					     struct komeda_chip_info *info);
-};
-
 struct komeda_dev;
=20
 struct komeda_events {
@@ -243,6 +232,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 targe=
t)
 	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) =3D=3D target;
 }
=20
+typedef const struct komeda_dev_funcs *
+(*komeda_identify_func)(u32 __iomem *reg, struct komeda_chip_info *chip);
+
 const struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index d6c2222c5d33..b7a1097c45c4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -123,15 +123,8 @@ static int komeda_platform_remove(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
-static const struct komeda_product_data komeda_products[] =3D {
-	[MALI_D71] =3D {
-		.product_id =3D MALIDP_D71_PRODUCT_ID,
-		.identify =3D d71_identify,
-	},
-};
-
 static const struct of_device_id komeda_of_match[] =3D {
-	{ .compatible =3D "arm,mali-d71", .data =3D &komeda_products[MALI_D71], }=
,
+	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
 	{},
 };
=20
--=20
2.20.1

