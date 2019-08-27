Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0832C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0B1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="frLAIfII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfH0Ire (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:47:34 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:41954
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfH0Ird (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUhaXRK24xuJBd3Oyz66dRNQEhX7RxDMH6RTc9yN30yVNBwsBrM24PBYaDPFJwJ4UTRhi3SzbWaoqnaUzONgHu/cGO1Vv4xXqMvP3pHd0VIFSKL2M3eZUX3RFGn9Yt6QKrdUz2p4zkGZfyn4NpZyy9Jyif3Y7wo0ID4scW84Kw+GakCsNwS3ZsAn/NJVyihkMmlqo0bmNIf1Jev4oC/PBOTs1x9sOWGKbXH5Bx8yH1ij9B57Fq6pgQ/gc1u+udVx6574bd4JY52xWxh7pmBKIN8tCwgvVZQpamlXtAlbEIfv3ywJPkOBBztblOoLODatFwSskR9jTSRpRGIat4wPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwBPqwcqIg/2VLkPO1Z2qYGfceuSKiMtCfslhDeRedw=;
 b=K5P4pDhB0zn3cmaRksu6n8x8dHzxcgLhDfO4/8rW1fSlfWA3cStUvBtbfJhJFyjDZGvxKYRv0U9TRsKQ2BihDLnBsbjUY03IBqu9Hvk+2k1fZGMcxMn2TtA3SKUBAI1cE7MwnhPz6C4r7wGoCF1y2pyJiEKYYBLGTzLFvTpvXhBrbIj/MCD15mqoobByMIVJzuvp5fsxy+jWU0UuIXXoiMQEDYdT4Mfn/1LCXFdxi+vkusipDhOJm/zLiGr6s1YlP4QO2ZzuItuZwfLeRrDDYpPuBDdykd+U5931H95jGxHUYCJXAnXY87ZK65tyeS8ejkxUjcuyWyz/EozeWv5Vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwBPqwcqIg/2VLkPO1Z2qYGfceuSKiMtCfslhDeRedw=;
 b=frLAIfIIBWlRdJ9v8PE6VktQ0xwvz9NJprLTuppXD7E8EEXiTOQ13HQquKSSAs/0tpXy/XbbKpl9GgX0sfNf159WtRfBJIeFj8yr6zASatTbHlt+tkoGRNrDVxV/RvF7KL3qf+d7GP/BDnR9supMdoCv7E7oa1wAqF8sNSl8E40=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:47:30 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:47:30 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 4/8] regulator: sy8824x: add SY8824E support
Thread-Topic: [PATCH 4/8] regulator: sy8824x: add SY8824E support
Thread-Index: AQHVXLQPG+mNO+RooEm9mXFjMJi+0Q==
Date:   Tue, 27 Aug 2019 08:47:30 +0000
Message-ID: <20190827163537.52023c4e@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:3::13) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa110c90-56ad-47e6-672a-08d72acb31fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB426347A5AC4E08359A3D2FA6EDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p4JZvZhIOZr0jVIp6k804t+4jtghikvk9zMl0d+KbIgSau5J7lczGh0H2wqHRtdBKHJb/qXi4s6etEuCNGlNddqNaaR9zW+DCYiWqZCpqQPnZSlEsmfDNdQveXnU7ndbel1BB46Da2VjPX9ish1iQNYJ/yi99wWDKeIH+yb7olFA/vhGbykWtCS/iQFJOf0pwUWVteTW0s6awdS9BFIFeloX4qV9J3dqK+motIsDFm2/7FRLOJFimgtHnS5dPmkQzsVn2LKTH1nu6U+kk6VuMLxGsa2T+1JE/lRFXasuCOJwTruFrDpYC+Gl5r1x9gwePIcU+KKqvkgUqahj1lKFr8fYzDaerkLGE7HbmMYKxWs5+9n+Xp7nGcYt90AYhTpTKfpFDTLJnWbG3XdQ++WiwBYmYQ3oKPVes1xNSuN0UYw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85BD8752AA3C7F49B10F128239521DA7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa110c90-56ad-47e6-672a-08d72acb31fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:47:30.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gab6cNBfo3QqZVzALhXDxw/X8hOVzAAZGoKG+2HopWqTZkIBM3t2fCr8irG1tqJLHCyF8FfbqkPelFxYYEbFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only difference between SY8824E and SY8824C/D is the vsel_min.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/Kconfig   |  2 +-
 drivers/regulator/sy8824x.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e8093a909e85..b70a0a07795b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -907,7 +907,7 @@ config REGULATOR_SY8106A
 	  This driver supports SY8106A single output regulator.
=20
 config REGULATOR_SY8824X
-	tristate "Silergy SY8824C regulator"
+	tristate "Silergy SY8824C/SY8824E regulator"
 	depends on I2C && (OF || COMPILE_TEST)
 	select REGMAP_I2C
 	help
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 2d8a61ca6643..b1438d94eee2 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SY8824C regulator driver
+ * SY8824C/SY8824E regulator driver
  *
  * Copyright (C) 2019 Synaptics Incorporated
  *
@@ -162,11 +162,24 @@ static const struct sy8824_config sy8824c_cfg =3D {
 	.vsel_count =3D 64,
 };
=20
+static const struct sy8824_config sy8824e_cfg =3D {
+	.vol_reg =3D 0x00,
+	.mode_reg =3D 0x00,
+	.enable_reg =3D 0x00,
+	.vsel_min =3D 700000,
+	.vsel_step =3D 12500,
+	.vsel_count =3D 64,
+};
+
 static const struct of_device_id sy8824_dt_ids[] =3D {
 	{
 		.compatible =3D "silergy,sy8824c",
 		.data =3D &sy8824c_cfg
 	},
+	{
+		.compatible =3D "silergy,sy8824e",
+		.data =3D &sy8824e_cfg
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
@@ -188,5 +201,5 @@ static struct i2c_driver sy8824_regulator_driver =3D {
 module_i2c_driver(sy8824_regulator_driver);
=20
 MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
-MODULE_DESCRIPTION("SY8824C regulator driver");
+MODULE_DESCRIPTION("SY8824C/SY8824E regulator driver");
 MODULE_LICENSE("GPL v2");
--=20
2.23.0.rc1

