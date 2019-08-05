Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A378C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DF92182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m1aXVE0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfHEJ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:56:30 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:55693
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHEJ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:56:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH8k9twMi6+Oz14N9HstgRNhtqyTnMRp5FY5jSuKtkTJYxZ+qcHEAAamXsndgLGPgsystwR7BAoz9ZAr3UOyJ+BX8eaR1GEYLSzv7/NICZGVdx8o+e3fCaoO3xVgCPf/G9s5fEN24HhGi3RA4x5f0THUI+MEFdzgaPWN85lZUFMGuzKMOnu2EpnJp3iRmBHH3/ol1zoXrNu5URKrpVJder/QBiQCLQflQEjDAnQ8itofg87tzHvHPZyM6oZHUYg++rCdslz8rpnO/0nnLz96nj1BmrCauqNwo38KwUsXJ2Za5ijwi18wpP2TA+djMgJb60gr+wy+xYlCLKSbbUgnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYmHpOdBnxlo8kd7/TxtexcAA5eNVC3SBvfBgi9kQ5k=;
 b=jlnendJmqSdTObL75mUYfkkdfzaMdrbAKSZHU9fh0dast9eXth47PUSjYmiDjMJ8PWB7pOim8DTk43H8Sc9KrR2KZDGsbGx7dYFi/nja3SMO8zNe8RKZCRPggooidTjErgXfAz0NteQGRkc0/HEdRw4cjD9X4Qxs097HIBuucEhGlU+FYLD/WmDdwN56kWVHnskn2JRSoVu/eb2Q0Fev/QKR/5l/PVqTBDgPah9TE8pk0z4NX8HdSwA7FvS8HLWDJ2nkf7loe+y2EaLv1ayvFXWA36chMkjjA1rSTA32gOXclHLMGQi8BJcdRRPmj2Yt3MndHwzg8oAFXHTg2E2UgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYmHpOdBnxlo8kd7/TxtexcAA5eNVC3SBvfBgi9kQ5k=;
 b=m1aXVE0BYUIRGBrzj2N8VQLQ9Vsaj7QK1e3Iaz8iuc97Go+I1pJZnaylNIXEzQs/OatxFDxhK1rwe7jm6vnJl5aF7Kelr8wPfc6QI9GAtoooTpqV9lj3vOUCO4YYkwDT2LbThx76pdMH7wK+V4Z56xFWmQarY1zomzLE00UjD5M=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3520.eurprd08.prod.outlook.com (20.177.61.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 09:56:26 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888%3]) with mapi id 15.20.2115.005; Mon, 5 Aug 2019
 09:56:26 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     nd <nd@arm.com>, Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Topic: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVS3QL8/BEL0aPM0GZk8WnOetY0A==
Date:   Mon, 5 Aug 2019 09:56:25 +0000
Message-ID: <20190805095408.21285-1-mihail.atanassov@arm.com>
References: <20190802143951.4436-1-mihail.atanassov@arm.com>
In-Reply-To: <20190802143951.4436-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.22.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb7521e-47f2-4a8e-6565-08d7198b2dda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3520;
x-ms-traffictypediagnostic: VI1PR08MB3520:
x-microsoft-antispam-prvs: <VI1PR08MB35207BB248A0BC66CDB86E9D8FDA0@VI1PR08MB3520.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(50226002)(71200400001)(8936002)(53936002)(478600001)(316002)(3846002)(6116002)(54906003)(6436002)(6486002)(25786009)(186003)(14454004)(66066001)(6512007)(26005)(4326008)(36756003)(2501003)(66476007)(66946007)(66446008)(64756008)(66556008)(446003)(11346002)(2616005)(81166006)(99286004)(81156014)(6916009)(5660300002)(5640700003)(2906002)(256004)(44832011)(68736007)(486006)(1076003)(7736002)(52116002)(102836004)(86362001)(71190400001)(305945005)(2351001)(76176011)(6506007)(386003)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3520;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RhN4YHyJmkcq/NQ9RoQvwuAhdsoJhKLPDlsrcka//lqCXtzoqfJr3v/cxxkt1L2Z310MgOkvzXRXT4x0B0SqP2ll0/Y+VdP3EqtAZ5Fki1/inrbBbgrSMPrKww32XnmT96KdzfiBO4u7SMUXWTxT8+f762+0evNRcnmcZmLnhOs5dBCx9WqkVi8g+SrvyawHLrsei0x9hSa5kCBLC5k3zgTx/VVG2qj/56KajnodfEg9rbQqQPCrJsrNH1BMPXUYwew9IPDu63qFTmNPGbxEC0NZDWUpcBMV2gJS5J2w2g1Q5JRyjLThzYMXJ+VjYRUIoBPVbcodEIEWh8Sc9AJnjUeUikwxqCdo7UTz8WFHOXIcuBuLbIb1L1MEzFHFS+tM7TuVkjUr25svBCr26eJqTaaNrw5oAnbI7LbwnSUmiGc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb7521e-47f2-4a8e-6565-08d7198b2dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:56:25.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Atanassov@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'memory-region' property of the komeda display driver DT binding
allows the use of a 'reserved-memory' node for buffer allocations. Add
the requisite of_reserved_mem_device_{init,release} calls to actually
make use of the memory if present.

Changes since v1:
 - Move handling inside komeda_parse_dt

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 1ff7f4b2c620..0142ee991957 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -8,6 +8,7 @@
 #include <linux/iommu.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #ifdef CONFIG_DEBUG_FS
@@ -146,6 +147,12 @@ static int komeda_parse_dt(struct device *dev, struct =
komeda_dev *mdev)
 		return mdev->irq;
 	}
=20
+	/* Get the optional framebuffer memory resource */
+	ret =3D of_reserved_mem_device_init(dev);
+	if (ret && ret !=3D -ENODEV)
+		return ret;
+	ret =3D 0;
+
 	for_each_available_child_of_node(np, child) {
 		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
 			ret =3D komeda_parse_pipe_dt(mdev, child);
@@ -292,6 +299,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
=20
 	mdev->n_pipelines =3D 0;
=20
+	of_reserved_mem_device_release(dev);
+
 	if (funcs && funcs->cleanup)
 		funcs->cleanup(mdev);
=20
--=20
2.22.0

