Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A927621883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="nVlNASqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfH0Isi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:48:38 -0400
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:3025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0Isi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3fj6zqD6YwZ2mh2JWuf9lwj2aazqBLftxS7tjc9SDwFfYr6VBjX6GkuysiQfSNH0jDlfVuV5YwIc4SJuoW8gnGNWs0OfHrsWK27PD8uAt9QwFG7SJq2VE8HFZbehlzFJeHPmceKdWhYCUVi9JwvHat7q7LzNCjbdbVAZlH2TguWJzYrQ/Bwj7g8nCerwnVbZjgrSE/aSGZE4eyGx6pyBzfRft/IZwW1pyUh0sfQmubdKm33utNudygXquxG5a4lf3yTNAGA6zQ0izJ1KHqoa8DKanI7pNvAOKUk9g2CnfKEd43087PB7Khh/Nlo8tZ0AnsumBFM72R4bFBS1g4EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvHjGAqPYTHrBaGpgWGtgoA8mcV03Wriz8VGBPF270A=;
 b=nxapNbrk1YKa81Zx0LBkkWo/ohBBiCEIob4L8V/OJrbZs+hs4W3btWDFFvcTmTnzBad7LSWN1PtGgMkd7p6HbrXFyV7gXguTjCDSbIl8fJIJ+Yk8J5B/FFPwF6PQhGPqEefiYofD2U3/RyqbeTrrOq0yDufVtjnFc0MxXpczUuzjTREjX3p5L016ycGKfXpWrapiPr1yvOqAn3BukDPmpGNFOPjH4TdmoX+JQOfznKIf9ABzIpNorr9cf0xcNb65xKON7+tFug1cBUgOfgtW4L0/L0W371GkM5ZBSzGhrL+GhO1pUcVS7v4De1NTyKMrLtysomvshcZR0AYTKLfgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvHjGAqPYTHrBaGpgWGtgoA8mcV03Wriz8VGBPF270A=;
 b=nVlNASqbifx0pHXGTayBKcoXH35NzEbPDi+yHm/oKY7UgovJKFc2KcDmMLlwBzFRDn1XmyBJGcibDxlqExzbGQjp2mT8mwSPFEUKTGAyQheTOA07b8Hoj1y4589YB3P0wOz+IubjjsOsKUyoKzNSLA64p8IdxFKUVYHO9Q5b1UQ=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:48:36 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:48:36 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 6/8] regulator: sy8824x: add SY20276 support
Thread-Topic: [PATCH 6/8] regulator: sy8824x: add SY20276 support
Thread-Index: AQHVXLQ2Azjj4BAnr0iA+Jp7uyzR7g==
Date:   Tue, 27 Aug 2019 08:48:36 +0000
Message-ID: <20190827163721.1947f7a0@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:404::31)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a9bcc8c-8928-43ff-e9ae-08d72acb5921
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB42630C28D062BA64E57BA179EDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wr2GPaytOBTLBWTf46oczyV39rSVlwwMsfGaBkdOYZ0f6p3ZVwV5x/jr6CZAheVolmHWVi45YMq/4vDvwJBMIEaGeJY3ivC+gAe455Jyz7bi2xQmo4TQVWYcWWHpOCGPPuLIDYObBpFxiHlh5A7V7PfTFUAIpovZNJWLU686pRI5Tsg7uyBD3gbErRMZy09j4538RWfQB5kAglCRy4HWX7GCGKmmUufECh9EFfqPC2YZnpoU+oqr8m7+QWvHS+KYxCzQLtuND9flPfQqEAPwpWJseo+ysrx/AZs6JW4qusABIpeWOrPgWeo/oWwkGiNF9eZJes7xJ9L3sPAFt7xaXJSd2EbWIqmv6Bq3ioIy3eLJpEp3V6bookAB2e34GoFNQrKK2sGSqWtzyQWTN1p6ztO3e/QXsuDuq9yIw46EkSg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCABB9BF95F12146BC850B1594DBD8FD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9bcc8c-8928-43ff-e9ae-08d72acb5921
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:48:36.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CZk/YzzoSCtxP85Mqvx5i95Rw/acxiBJe/AF0mSKiAehSdygMj0+u3AM9VDJUd0EGmsQHfWUB2H36+xhz442g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
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
index b1438d94eee2..9410c3470870 100644
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

