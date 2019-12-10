Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67471C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292DD206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0NT2mc3M";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0NT2mc3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfLJItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:49:06 -0500
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:45889
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfLJItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/d4jIzeQVWkCBWXx8R3XHSN3jQW91VW1gzlK5vWQXA=;
 b=0NT2mc3MDyVkZJl3sU5mSmS25Syp7XFd6puHbiqBKriAuozDDh1uNx+Ie3OyvmrzJDZ8KfAw672Ai38/KZkS+EcjOcKORQqRBnmrobh9bqxpNhdol/MvIYpeLAgRyoRaJfoZL7EY3PfgCyv1DT0leqzpbsTOTPre7MCXP4jSoj8=
Received: from VI1PR08CA0121.eurprd08.prod.outlook.com (2603:10a6:800:d4::23)
 by DBBPR08MB4314.eurprd08.prod.outlook.com (2603:10a6:10:ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Tue, 10 Dec
 2019 08:48:55 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR08CA0121.outlook.office365.com
 (2603:10a6:800:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Tue, 10 Dec 2019 08:48:55 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 08:48:54 +0000
Received: ("Tessian outbound d87d9aeb44be:v37"); Tue, 10 Dec 2019 08:48:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 33ba96f2eead3c02
X-CR-MTA-TID: 64aa7808
Received: from 0edf5832a06f.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CFB6E7E4-697A-47A6-89FB-09567E8C3C2A.1;
        Tue, 10 Dec 2019 08:48:49 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0edf5832a06f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 08:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfprypp5FvLmpwoU6cqVW1o5MX2FwOVtlfrj0dx8iHyAq6R/eIufblEEiq9ZPICNohKw12gsEz2UYUbjPrw5PylYuaYWZQ2VEhBkZ/tbzaiWYlSKQyABAK9F3XG+Z7DFfYQQRHzIJJJTbEFBlttAY39b1EyTCIRgty/Zdp1TK8q0dkzBKrMY7Q6ICDHMLeZRfguGLixswMuvQs+UQPUxeTeJpnwLkj92XBJIepfesFg6xPQEXm3lX8+KkHrqgTbNG+hkKvCqFh792VizvYbf/An7vuid7EDwIlmXDNLeX/kuCJ9G4dIYSVdEqVI0wyqoNAXpMhdX3XFZfLHW2HPoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/d4jIzeQVWkCBWXx8R3XHSN3jQW91VW1gzlK5vWQXA=;
 b=VFev+eiDh2LUGUEFJcIAGw6JhGlmnpHZgM6xoHfoDnTy4MUUpC0rqHIVeUrK3dNrHqZ5XNlBTOPcWe8jpu/NuNDEb87vTAHSBHRXS0Xy/XdOsPdvgYNz8Dpv0CiC5QjHTIGHSGbjBDaVeuSPWwC7dtko8pfRz2WGO6M8rS70P1hOvbm/ioI2e7NHfgBpE49zgbGpIJPWfP++rW755maRAabiH8JYNajLjZkwMBjNjLH0v2oXRjqVp7n/wBqJdL4I+y1fZ/THz4vEnj7Q+60VPCcIjOzy8tJ4viDRDkBWIdA8JLEGzyygYNIyIyrxQITJznVQDYU6lvpYu0G72FcRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/d4jIzeQVWkCBWXx8R3XHSN3jQW91VW1gzlK5vWQXA=;
 b=0NT2mc3MDyVkZJl3sU5mSmS25Syp7XFd6puHbiqBKriAuozDDh1uNx+Ie3OyvmrzJDZ8KfAw672Ai38/KZkS+EcjOcKORQqRBnmrobh9bqxpNhdol/MvIYpeLAgRyoRaJfoZL7EY3PfgCyv1DT0leqzpbsTOTPre7MCXP4jSoj8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 08:48:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:48:46 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 1/2] drm/komeda: Update the chip identify
Thread-Topic: [PATCH v3 1/2] drm/komeda: Update the chip identify
Thread-Index: AQHVrzaiCeAK5VTajE2NZYt9uO0vcg==
Date:   Tue, 10 Dec 2019 08:48:46 +0000
Message-ID: <20191210084828.19664-2-james.qian.wang@arm.com>
References: <20191210084828.19664-1-james.qian.wang@arm.com>
In-Reply-To: <20191210084828.19664-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 733b65f0-d246-4738-869f-08d77d4dc9ed
X-MS-TrafficTypeDiagnostic: VE1PR08MB5182:|VE1PR08MB5182:|DBBPR08MB4314:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4314AA4D4F4C3A64C6B4178FB35B0@DBBPR08MB4314.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(54906003)(4326008)(66446008)(26005)(1076003)(103116003)(66556008)(37006003)(186003)(66946007)(64756008)(8676002)(66476007)(36756003)(6862004)(305945005)(2616005)(2906002)(15650500001)(71200400001)(6486002)(86362001)(478600001)(6512007)(6636002)(316002)(71190400001)(5660300002)(55236004)(81156014)(81166006)(8936002)(52116002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5182;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hB+UJysy64OneczNQ5E9t3ObK8UyqRPapB2BqJd7Kx7UJsvgZ0q0lDGQMtCRKnaSo97FtsyxUi6gPeMiAt7FQjyspMm216s0aA0zhO9GU4QuUBf0kj3JOZN4rXxY/SE2D1L3oHu8AMMJswz/I4IUIXwOE+w+asvHLBKrwtaMm4U/7Aa3i9moGt0b7rAQ9bKkvyP22xFYreBsivvzC+rB6eBkNDvoMsFnoXw9svSUv1xhnMnOzhnwU+YKD62LpsySEUPqgKQqxpXZH96AMlAmzWcOdQE8k4e0MECbvWrVOwqlmoYSscjXagHkRxej90xSeQUGR/x8DgftH0Lmkv/guZlO+3Kcl5y8OvEVx1Oe5HJKi8f12RU4WPFNJBvgAJevKS0mfCNq+fVuw1rlnO/HBdibkrSh0HBdcMRThFDsZbxKeg0wa7yLA9a4eBXG5ab/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5182
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(86362001)(8936002)(6506007)(2906002)(2616005)(26005)(1076003)(356004)(76130400001)(70586007)(70206006)(186003)(15650500001)(4326008)(478600001)(305945005)(6862004)(336012)(26826003)(6512007)(5660300002)(103116003)(36756003)(6486002)(6636002)(37006003)(81166006)(81156014)(54906003)(8676002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4314;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 88c2a7d0-b516-4dfa-8767-08d77d4dc4cb
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdWcSG4yR92PRS2ZoHQE/2F/I1exKPaoGTYWVIt7wMjMo01y+FQIEJubANxo8T1qMeOOJgpFxqpBmmKsZ8tVJ50OFcUMX2BLhoOO40g2GMZQ+9ZT9d4D2cC6ta3iyKzAX1CjQ/zKpgctfkJnE09GAvn4VrVI1G8n1xCr8Jvwyq2r9Z8HT+55684720+NX3IFRzr1/jUi4YwWpjUHUjgtVBTHBYWZFANkqQhXN3eLkWCAcoDJVXciLNCOX6RpCB0EkeIB1aMdZF/AcCkV96mz8ByT4ESKVJvHo0TM2qJs0L+3pM5pS9RzWa8wrrbbILwzkKsZF/wTPqJ2kZ6zctPrHLsBrianTKR6mz3Rs1ArR+RC9IQaDCiKRNGyzqa2wXjTHCiSKJXwTU+hBpMFgjAr39RoHayRD2UBwrohaNboCEaGC+x40KGdrfhHflz1sR79
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 08:48:54.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733b65f0-d246-4738-869f-08d77d4dc9ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Drop komeda-CORE product id comparison and put it into the d71_identify
2. Update pipeline node DT-binding:
   (a). Skip the needless pipeline DT node.
   (b). Return fail if the essential pipeline DT node is missing.

With these changes, for chips in same family no need to change the DT.

v2: Rebase
v3: Address Mihail's comments.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 19 +++++-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 61 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +--
 4 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index d53f95dea0a1..7e79c2e88421 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -597,10 +597,25 @@ static const struct komeda_dev_funcs d71_chip_funcs =
=3D {
 const struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
 {
+	const struct komeda_dev_funcs *funcs;
+	u32 product_id;
+
+	chip->core_id =3D malidp_read32(reg_base, GLB_CORE_ID);
+
+	product_id =3D MALIDP_CORE_ID_PRODUCT_ID(chip->core_id);
+
+	switch (product_id) {
+	case MALIDP_D71_PRODUCT_ID:
+		funcs =3D &d71_chip_funcs;
+		break;
+	default:
+		DRM_ERROR("Unsupported product: 0x%x\n", product_id);
+		return NULL;
+	}
+
 	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
-	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
 	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
 	chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
=20
-	return &d71_chip_funcs;
+	return funcs;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 4e46f650fddf..38b832804bad 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -115,22 +115,14 @@ static struct attribute_group komeda_sysfs_attr_group=
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
@@ -144,7 +136,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev=
, struct device_node *np)
 		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
=20
 	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1];
-	pipe->of_node =3D of_node_get(np);
=20
 	return 0;
 }
@@ -153,7 +144,9 @@ static int komeda_parse_dt(struct device *dev, struct k=
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
@@ -168,28 +161,42 @@ static int komeda_parse_dt(struct device *dev, struct=
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
-	return ret;
+	for (pipe_id =3D 0; pipe_id < mdev->n_pipelines; pipe_id++) {
+		pipe =3D mdev->pipelines[pipe_id];
+
+		if (!pipe->of_node) {
+			DRM_ERROR("Pipeline-%d doesn't have a DT node.\n",
+				  pipe->id);
+			return -EINVAL;
+		}
+		ret =3D komeda_parse_pipe_dt(pipe);
+		if (ret)
+			return ret;
+	}
+
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
@@ -217,11 +224,9 @@ struct komeda_dev *komeda_dev_create(struct device *de=
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
index d406a4d83352..4a67a80d5fcf 100644
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
@@ -234,6 +223,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 targe=
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

