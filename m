Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E482173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="c3fMU24S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH1GMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:12:08 -0400
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:21408
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfH1GMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoPY3bAQQ1VkelbVeiLcaKdS9vN4lgPUTcuCHBVcjXIxLi/wXIKtrEzuuhhSw9ahcXSdDi5ULd0a5t7RH0kcSI48X1I8edck4y0qEWLRhVFOx1Cg0MsZ9oBaLJc3GbTev5xbDrZu05HI1Up5M36q8bwB0+F96qZJ26nVOI5ubEVi18nty8/ceUQNiXNZmLhwh8N79Nz7kUcxeC5T7b481hBvXexuS7dev7UIXee8uGf93R5OEaiP+T259QH/tt/l8A5d4iCvR5TDSetvMEcIrBlbujV9WmebWnpV93eufMX4zae9L2D13KeKbfoJE4P3JQWoMIAG7RzADNLpi738OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiOt2ZUhhjM6pGb/QWF7EM8K6dolCK1Z2IopG1lvDL4=;
 b=cG4lPCjwJS8QBJsrP+M51uwLtWJJR343PMOlCa6bfW8zotgVR8QL56ZKvicHOWVQbj2Ka8lmhETxvh5rQzpyx3BwqwPNzN2o6bFbX4EDvdTD/a2VFYo3ZfODD+aUcyM1+nClTl7I6GqDJI5G5W0E9YaRl+/3twpuWMTgV0fMg8X/1ZItsn4sox8B4YRJesoC8gDqgDwGdWEY9TCsVgIoyhAShmKt6es2QHK2+WRri7pzFW0syBTq4DwQQt8tm3FWg2E/lW9RpWA+gz6owpBWMTK+OdQZjuH8VNlxNqSL45dOvzSkro9sPnTyQc4QJ/eN1J6cJGv/u4Rp/B1aaEHR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiOt2ZUhhjM6pGb/QWF7EM8K6dolCK1Z2IopG1lvDL4=;
 b=c3fMU24SK1xot9XBfXdncWFgU3WeIjO9ecyPoufNLlpjRrSTIpbcnViCwW9zhWNSXKw78I2NfoM4lLVMe8PWe9K7gwl/FWnZaWXxOncA/MCLjOYfFMJ5b/pZMpcM179ixOOPVCzEnYnAhymQxaGTnPOKlrEnZ77BhuqgAVniccY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:12:05 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:12:05 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 6/8] regulator: sy8824x: add SY20276 support
Thread-Topic: [PATCH v2 6/8] regulator: sy8824x: add SY20276 support
Thread-Index: AQHVXWeEXfrkT8TpGEe0+ipQUU3D+g==
Date:   Wed, 28 Aug 2019 06:12:05 +0000
Message-ID: <20190828140048.71df2899@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6046b4d-f388-44da-42e2-08d72b7ea645
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB4503F0846D779B861F9E2A6BEDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2aUMdYnCeh1AbTuJcxH8gneUC5mXl5j66m9LXcJjq4R6cGzbknVdGs9pE1bzNNsYryTDA9fruMZqj8DKIooaAOEB7IA+JJEjiusEOqpwhsQ+x/TRfYMhrC1yhv8kCsnLszEm5zf1BMSwidtmYSDCokwwjdxqIyCkrcrne+fhy65dMXe+h7SnDuZh76bwa8+JnhdIhDJo30bLOFCtuOKPWrbAalXS3S/LUXeGaLPBuFAy9H1lnXJ44+bT7JWckE4s05P0JPmEAqZb2Ma1Js3x9PamTzgmBpQ+asOnxXqQPPQMxhSpGsLfRTxYPsAHM87qO5jhfWKFRMDBcJAKbjNfuovCgbiswyhGAPLfiV5/16ghaCxDdmFF6ApSjOXPIoaz0WpBWuQ20HThiwcceYhppD+27NgAI3nQNgIQLS4ou/w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA5BD6946FB20045B13B2AD032857C30@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6046b4d-f388-44da-42e2-08d72b7ea645
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:12:05.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JHNx011wT+2kt//NzCCZRJtIKJqCFS8LgdBJkT3xY/3M3SHw7H1wl38LAHwlIHtJbKcwF37tFtTIjY01lzOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The differences between SY8824C and SY20276 are different vsel_min,
vsel_step, vsel_count and regs for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index c93c49e64315..10d9180a0d77 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -171,6 +171,15 @@ static const struct sy8824_config sy8824e_cfg =3D {
 	.vsel_count =3D 64,
 };
=20
+static const struct sy8824_config sy20276_cfg =3D {
+	.vol_reg =3D 0x00,
+	.mode_reg =3D 0x01,
+	.enable_reg =3D 0x01,
+	.vsel_min =3D 600000,
+	.vsel_step =3D 10000,
+	.vsel_count =3D 128,
+};
+
 static const struct of_device_id sy8824_dt_ids[] =3D {
 	{
 		.compatible =3D "silergy,sy8824c",
@@ -180,6 +189,10 @@ static const struct of_device_id sy8824_dt_ids[] =3D {
 		.compatible =3D "silergy,sy8824e",
 		.data =3D &sy8824e_cfg
 	},
+	{
+		.compatible =3D "silergy,sy20276",
+		.data =3D &sy20276_cfg
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
--=20
2.23.0.rc1

