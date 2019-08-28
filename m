Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFA1233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DJYJPj40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfH1GKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:10:39 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com ([40.107.70.62]:53216
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1GKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu4MJfj4mApX2ZCiaVxs0oirZ5GDgN8jaCmT2Jb5ZP2ooXmu1nsuo5MtL1C7Gz1m+3S9VcQDn45vlWGhm3lQdK9J8XBYC1pbkxYUqodlar/qs5oBlRd3bAAzLSbDq0+OiJuUfJ9plIEqki3ssBSDStg1eXVFIGHkjONdiEtpq0OeVNi+LZUvS4DjG+PZDKwAQG5q/eez2L1SSN8ymzkcHl3UiO2UCeWGA8Oo9afLaxTq7jrpgsEKYnE2urqWbL0KJ1ig0gzUMhR7+eg72JxN6Jt9vtB976HGcMU+8mjegseSIbRnm2dp4tr0SLhVzjfGg6HEXQ4KgJGR0H4QTG/pZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehXvUwIXHKMlZRj8U9SB0fmZmITIdCgvu26twelIE9U=;
 b=hyCro+NA18nmIVWQKBv2GO7d8Uv2JMOy9Q+8R9THYaEgc2/26VpjL1n4dm1lgqbHA4UWDFw4P+yHEwSucSoATmTq4ZMFgCJw2mkkfPzmiYhpx6w0o6w5q8j3EeoqSi4MiAZAYgQJyixpPdGAl4qPJywdfvABGT1LFKerAeh0rCgr2oJQQbeQiNBXE08ZQR/GgxFwvs1qdN8JYKBI1c9xX7zqpzqNEif184g7fslWdhmF2GGgjU6fG/eGrCVx/CLbBAjYtIPXMKyt4Yi86crGEDTVBTWi6Wz0tG34tg5iAeB02VnICnb2E8eRkSRoPCUIMx/oddtCTs7q5o81FPflJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehXvUwIXHKMlZRj8U9SB0fmZmITIdCgvu26twelIE9U=;
 b=DJYJPj40MLhwNw48+RDHaY+XxvWV2ZLq1vutR/VewbGjmPBrKumz9h13brLz1TJDgO3uFWODmZwJVIdZr8wLB1jYYTaH5Cl/J/ZJCApx8EIMxLxhEZW03/ybc9B1GvEERffokiKv9jLYznd4Ect2Alt+ZvzOfZ2LaRarQNIgLxg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:10:36 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:10:36 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/8] regulator: sy8824x: add SY8824E support
Thread-Topic: [PATCH v2 4/8] regulator: sy8824x: add SY8824E support
Thread-Index: AQHVXWdOTJduXwfbq0qUj9gBgS7iqA==
Date:   Wed, 28 Aug 2019 06:10:36 +0000
Message-ID: <20190828135920.536c9e1e@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:1::28) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7ce2dc-34c5-4f6b-f9e0-08d72b7e7143
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB4503062D455D443D1FDDC4B8EDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t151QPgJUjqZR9XML0RsO7oWNgEFXX6KX8xqxnBzhke9hdkxhnom28NcdIPn2UFzBldEPBxDC9RwMcpdv6GY5qa4Lp+UETYEHOsyBheFSXzJWCBYG29leU2mQLLHgaRxtwZTqPaLYRxt1ti696Qm/XuMXmSnxFxQyiDFe1vNSx/Ng2UMqrk9CBcFGl0E+mTYFU24gA0h9UzvycI7sAYpd6FttW/QQxtKsIbMZ09WXXORLECV0kRaWmGOXjEjYV/MzyWhbRgJsprcyM8vQvOgSfeR6piLCv7JSu4Nj82JxXPFGdnMikRPTbXmzTs0OmwGWoWGhaOUjhvfCe7bgkCBdSGgl+UF/S4/OefwGo5KqOuaPO7sRPc4uDyMjhl+NReRIyh3HmjqyBPPtq5iHtd4oO2yOe5NLsd5vOmiWE+Qv0k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02898B0919D5E449828C79C22BDEF91B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7ce2dc-34c5-4f6b-f9e0-08d72b7e7143
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:10:36.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBN/HygaN2anMILQ2CsfSIMzCwiWrrAIwwk3K5eNaEk1GDatWt1QzTtpwWlhcdIQ8e6NV6ueId9cvq87xSNF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only difference between SY8824E and SY8824C is the vsel_min.

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
index 335a2cc1fc4a..c93c49e64315 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// SY8824C regulator driver
+// SY8824C/SY8824E regulator driver
 //
 // Copyright (C) 2019 Synaptics Incorporated
 // Author: Jisheng Zhang <jszhang@kernel.org>
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

