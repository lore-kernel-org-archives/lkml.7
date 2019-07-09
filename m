Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C15BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F22171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aYj/GOlB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aYj/GOlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGIH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:57:27 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:45794
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfGIH50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV9IoxJ7ddWRK+HAqdXme3VwFGlebhBmisAzraI/pqM=;
 b=aYj/GOlBWAlz1gqPsIZh544rvD6eXOvEOj8YM/Ml4fZz5aDMikzPfE4riVBjcNH2pCqAHgCPiauLj0svywjipC5KnUeQoxo/zIffwQhm9WjNieKyDg8wHTdJ9+YQueTN1wcLOilmOagp5TzaF29ve52e8/vr8f2BooA6hkoG7PA=
Received: from VI1PR08CA0187.eurprd08.prod.outlook.com (2603:10a6:800:d2::17)
 by DB6PR0801MB1847.eurprd08.prod.outlook.com (2603:10a6:4:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Tue, 9 Jul
 2019 07:57:18 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0187.outlook.office365.com
 (2603:10a6:800:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Tue, 9 Jul 2019 07:57:18 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 9 Jul 2019 07:57:16 +0000
Received: ("Tessian outbound 4988ae2fa87d:v23"); Tue, 09 Jul 2019 07:57:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2820ea00e32ee9bc
X-CR-MTA-TID: 64aa7808
Received: from 193ae1e554a6.1 (cr-mta-lb-1.cr-mta-net [104.47.14.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A110F030-A904-480F-9A8E-034CD3BEC591.1;
        Tue, 09 Jul 2019 07:57:11 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 193ae1e554a6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Jul 2019 07:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV9IoxJ7ddWRK+HAqdXme3VwFGlebhBmisAzraI/pqM=;
 b=aYj/GOlBWAlz1gqPsIZh544rvD6eXOvEOj8YM/Ml4fZz5aDMikzPfE4riVBjcNH2pCqAHgCPiauLj0svywjipC5KnUeQoxo/zIffwQhm9WjNieKyDg8wHTdJ9+YQueTN1wcLOilmOagp5TzaF29ve52e8/vr8f2BooA6hkoG7PA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4958.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 07:57:08 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Tue, 9 Jul 2019
 07:57:08 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 1/2] drm/komeda: Update the chip identify
Thread-Topic: [PATCH 1/2] drm/komeda: Update the chip identify
Thread-Index: AQHVNivobgJj65WOAkiCXqprcqpsKg==
Date:   Tue, 9 Jul 2019 07:57:08 +0000
Message-ID: <20190709075640.22012-2-james.qian.wang@arm.com>
References: <20190709075640.22012-1-james.qian.wang@arm.com>
In-Reply-To: <20190709075640.22012-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f3dd789a-0b9f-487c-3fbd-08d704430f8e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4958;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4958:|DB6PR0801MB1847:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1847228B9A0EE9C5239B95D8B3F10@DB6PR0801MB1847.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
x-forefront-prvs: 0093C80C01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(68736007)(66446008)(66476007)(66556008)(64756008)(1076003)(50226002)(71190400001)(486006)(2201001)(86362001)(316002)(5660300002)(2501003)(66946007)(73956011)(71200400001)(256004)(14444005)(36756003)(8936002)(15650500001)(476003)(110136005)(2616005)(81166006)(54906003)(6436002)(14454004)(81156014)(6116002)(99286004)(25786009)(305945005)(11346002)(446003)(7736002)(6486002)(478600001)(8676002)(55236004)(386003)(4326008)(6506007)(52116002)(103116003)(66066001)(76176011)(6512007)(102836004)(26005)(3846002)(53936002)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4958;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: nn1xxeuFX+iGbIhjzx8OUWhG+EUKf4KTFJRwLh6NmeLjNEzZUD/6uaF7Y33KqCmc+erEW1AFw3+ne6sRGHzQE+/a4p9BMc+4GFZFo9qyW+YAID1c2sqBEYDQy0hfVN2oLzY/EABjw+DLoQl15TX0ZFCjf6HTRG5zbpAxf6ptGTdbDkmomCj+5VzXGJMfqJplOGwFkKJrRIRzlvKVq+q6U15Wgl38gbZQM4wJ7UqBSObAqBOzp7tltryKBk2DlxtPQRbBc72C+a7vWx5c6vz1264/xLBSiffPmukt1+ARe7ZkgNPTF+OBShEULSRYRD4YORNAyUeF+FPcs32os3SqW3O0bnVOAf1yf7JTgpB7Rc1jNEZAxW3GLOhlZJNa6SeuHweBKf93S2RbP/EXKd3PH8JAaQio9PN1R7uDxsB/6xI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4958
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(50466002)(2616005)(63370400001)(26005)(81166006)(81156014)(446003)(6512007)(11346002)(50226002)(63350400001)(4326008)(15650500001)(2906002)(186003)(36756003)(14444005)(36906005)(25786009)(22756006)(305945005)(70586007)(70206006)(316002)(110136005)(478600001)(54906003)(8676002)(336012)(23756003)(8936002)(76176011)(2501003)(2201001)(7736002)(66066001)(103116003)(356004)(6116002)(86362001)(1076003)(6486002)(102836004)(3846002)(26826003)(47776003)(486006)(6506007)(14454004)(76130400001)(386003)(8746002)(126002)(5660300002)(99286004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1847;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a6365bb-ddd1-4034-6631-08d704430a83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0801MB1847;
NoDisclaimer: True
X-Forefront-PRVS: 0093C80C01
X-Microsoft-Antispam-Message-Info: HeU9w8DylUY9Z3gDu6ygtCf5U8BnUbBtGDD2n+tOnyPWeNobrvvxqryfm0BaaspsgG52YLOCdJnaB0JnMfeEZgi26bjpvFYwPbAbEY1SVlmTu6lqL5karaC0lFIRQCZs/hNwkNBi+gUdjMy+cLePcNCsl73PpaNDN/he7h/ttYsP8gpIbMTDGY5U8qBpcIYRx/tQ8UKcWXd2xnLWQCcmvrCvOda+mV0z14kSGGIjPN6luIB+P+aTTaE0vvXZuQF5qknwZDPbGgC8w2uSJZvy4+yVso7RBMWUje/7kS3pHoyDSYCyXvoEz2mIKImab0kASJFZRnTyl3b2Th7HOCFhSq+ZawTgUStHiFKtrIFuAhLkXOK7KZXfeR76Ri3TFs3sjL79pQggytQU+a0zKfyPBC0T34R4YUTNN364vTR+y3I=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2019 07:57:16.5759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dd789a-0b9f-487c-3fbd-08d704430f8e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Drop komeda-CORE product id comparison and put it into the d71_identify
2. Update pipeline node DT-binding:
   *. Skip the needless pipeline DT node.
   *. Return fail if the essential pipeline DT node was missing.

With these changes, for one family chips no need to change the DT.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 27 ++++++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 62 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +--
 4 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 7e7c9e935eaf..e383a781c9e9 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -578,10 +578,27 @@ static const struct komeda_dev_funcs d71_chip_funcs =
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
index 2aee735a683f..dd4a0ba1c37d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -125,23 +125,16 @@ static int to_color_format(const char *str)
 	return format;
 }

-static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
+static int komeda_parse_pipe_dt(struct komeda_pipeline *pipe)
 {
-	struct komeda_pipeline *pipe;
+	struct device_node *np =3D pipe->of_node;
 	struct clk *clk;
-	u32 pipe_id;
-	int ret =3D 0, color_format;
+	u32 color_format;
 	const char *str;

-	ret =3D of_property_read_u32(np, "reg", &pipe_id);
-	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
-		return -EINVAL;
-
-	pipe =3D mdev->pipelines[pipe_id];
-
 	clk =3D of_clk_get_by_name(np, "pxclk");
 	if (IS_ERR(clk)) {
-		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
+		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe->id);
 		return PTR_ERR(clk);
 	}
 	pipe->pxlclk =3D clk;
@@ -163,7 +156,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev=
, struct device_node *np)
 		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);

 	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1];
-	pipe->of_node =3D np;

 	return 0;
 }
@@ -172,7 +164,9 @@ static int komeda_parse_dt(struct device *dev, struct k=
omeda_dev *mdev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct device_node *child, *np =3D dev->of_node;
-	int ret;
+	struct komeda_pipeline *pipe;
+	u32 pipe_id =3D U32_MAX;
+	int ret =3D -1;

 	mdev->irq  =3D platform_get_irq(pdev, 0);
 	if (mdev->irq < 0) {
@@ -181,32 +175,46 @@ static int komeda_parse_dt(struct device *dev, struct=
 komeda_dev *mdev)
 	}

 	for_each_available_child_of_node(np, child) {
-		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
-			ret =3D komeda_parse_pipe_dt(mdev, child);
-			if (ret) {
-				DRM_ERROR("parse pipeline dt error!\n");
+		if (of_node_name_eq(child, "pipeline")) {
+			ret =3D of_property_read_u32(child, "reg", &pipe_id);
+			if (pipe_id >=3D mdev->n_pipelines) {
+				DRM_WARN("Skip the redandunt DT node: pipeline-%u.\n",
+					 pipe_id);
 				of_node_put(child);
-				break;
+				continue;
 			}
+			mdev->pipelines[pipe_id]->of_node =3D child;
+		}
+	}
+
+	for (pipe_id =3D 0; pipe_id < mdev->n_pipelines; pipe_id++) {
+		pipe =3D mdev->pipelines[pipe_id];
+
+		if (!pipe->of_node) {
+			DRM_ERROR("Omit DT node for pipeline-%d.\n", pipe->id);
+			return -EINVAL;
 		}
+		ret =3D komeda_parse_pipe_dt(pipe);
+		if (ret)
+			return ret;
 	}

 	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
-					&mdev->side_by_side_master);
+						   &mdev->side_by_side_master);

-	return ret;
+	return 0;
 }

 struct komeda_dev *komeda_dev_create(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
-	const struct komeda_product_data *product;
+	komeda_identify_func komeda_identify;
 	struct komeda_dev *mdev;
 	struct resource *io_res;
 	int err =3D 0;

-	product =3D of_device_get_match_data(dev);
-	if (!product)
+	komeda_identify =3D of_device_get_match_data(dev);
+	if (!komeda_identify)
 		return ERR_PTR(-ENODEV);

 	io_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -240,11 +248,9 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)

 	clk_prepare_enable(mdev->aclk);

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
index c70cc25d246f..f91a113b0fde 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -51,11 +51,6 @@

 #define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE

-/* malidp device id */
-enum {
-	MALI_D71 =3D 0,
-};
-
 /* pipeline DT ports */
 enum {
 	KOMEDA_OF_PORT_OUTPUT		=3D 0,
@@ -69,12 +64,6 @@ struct komeda_chip_info {
 	u32 bus_width;
 };

-struct komeda_product_data {
-	u32 product_id;
-	const struct komeda_dev_funcs *(*identify)(u32 __iomem *reg,
-					     struct komeda_chip_info *info);
-};
-
 struct komeda_dev;

 struct komeda_events {
@@ -219,6 +208,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 targe=
t)
 	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) =3D=3D target;
 }

+typedef const struct komeda_dev_funcs *
+(*komeda_identify_func)(u32 __iomem *reg, struct komeda_chip_info *chip);
+
 const struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index d6c2222c5d33..b7a1097c45c4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -123,15 +123,8 @@ static int komeda_platform_remove(struct platform_devi=
ce *pdev)
 	return 0;
 }

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

--
2.20.1
