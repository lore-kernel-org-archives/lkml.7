Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52502C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ADE214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="A2ygFBxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfIQPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:54:57 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23052 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfIQPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:54:56 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pd4p5YoAICsj1LHhDqwIvCbShaXWdeuV9/cvkVzCZZ/Wd8WwlIajEVa8FtFaQLBZQTyv2IRImg
 PJLTzbWDMMEEDaAlDKxT/kPu9+AK1ySWFHJZke1yDvtih8PoKFc0llSui6b8ALNRjS371y4mvv
 DSZnND9YR89pLe041LBGzsxaSAsNp8n1ATrg9ogVqSyzkZBLpEGvAE8oM5FKnpm1hx8aK17UoV
 lw4fkYKCjq7KHbuIIHI5GGKjTWd/efQDPkpFOJwGiQU+QJW6irpOOF4uQbXOVdomneBtMhijXw
 qyU=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="49417037"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:54:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:54:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Sep 2019 08:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOOMw5ylFtAAZh4kd2JmXhcIB7PQUgs7GbLtHdnzZo+lr7jwup2z4WU1wS1jymsrnGwTVAIxisKOXQQgUeZ242a+QOPreCKYTS+1OFgWpv39UILPW7vhfdZq/qStyQIQlHrl8y/oO7DA5gVDpe9g5GXVYETxg1EL1bU/5HfolsxK2rS33HyUfoZ9ecPS/chykLSn3vRt2ZYZFkoR9/kPIqVipgFizAjWs2rPEt1UlZJT4R2gO22Q2PI7ng8NAEGOIFLwGt3332cPWhqCCvC33PuSfiC/TnykLx4gHOdSHuUZUkJlGlEtGhEHz23NNk3PCcU822cRh/Thg64Hkq12FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX7QLQOz/p1Yx0WDeQlhyU6NDR1qB0ng5ZogcAsBO6w=;
 b=BoUVYmKRisSalpZu16ILf8khaKe92GvhBO5NCML6M7JQbPX++gmwNsVQ1QVVvC7and65ITJmq84pRDY1rcwqWYhdILNBbzyLwiI4TT8fzHE6yNNVCxx4nzHTCRvXn86evm5WYt2mq9H7K3YEpjo2VVi5TuvJXjPvZqyJ9Pf3Wnm9CsPncdBB/VElx9wL6cgazX8/xSC7ov+vAzhavd1OVYo3iBd3c/BRxZzyWW0E5byLiNVo7pmJ/OeWzGCEfMm8I4lQM6Y/mXlwvwuudFzJBvzatt0exGGvZOrS6mE41kP7tC19pgdwlB4TWkMza0xsRtohzvgT/XiaEFZk3DOexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX7QLQOz/p1Yx0WDeQlhyU6NDR1qB0ng5ZogcAsBO6w=;
 b=A2ygFBxkjr5/Xiiq95JzcZpNnxpfXXYT0gZ4KoAZzF76Irl/f8BB97n9iHA52DA4gq753N2y7fsrsmuyKSryhsqPkIkbMtmYEDA6WeFq4Be2jjA3xmF37vsMcFjeMvND2T65/vhYJI3LGkKQmgwrU8xcA6cYdy/B5HUhpzsay1U=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:54:44 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:54:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 01/23] mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
Thread-Topic: [PATCH 01/23] mtd: spi-nor: hisi-sfc: Drop nor->erase NULL
 assignment
Thread-Index: AQHVbXA5Ho5yneiBdU61SqVbpzgJYA==
Date:   Tue, 17 Sep 2019 15:54:43 +0000
Message-ID: <20190917155426.7432-2-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 079e1b6a-1568-45aa-b203-08d73b875b61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB398429CDBE503EC78A64C595F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ExlxoHL7/qlbiTzSx/k4J9FUTRePNdcGc5OxNqLlu3msxE83TTApIziMh8R3tF5UAifMbZPWdXvY0QncItqwFC51te3LbWuNjGJ7OXyQaaTcAFkGhpKjdG06tHbcIRwDlmR+73gQLbSuGROWoA/Jx3E88zQDQZXFBaZ8lUGznZUbXRTVck5Q1tSNmGqj99etcm5KVVpdyZqRqTECcUkHxe635XBfn/Rmbrfj1ny6+BXjlP7G1bCbjJwLFt8KPhmmH4Vc53xYpgZJQsk5TCphsEeX5Rfd0uofIFqhxe0dGJeGN2CPJDe4MgNXoYUqvUmP4gcXRwuPpFZFwFf76uh+W4z0kKuuzYBdBGulqH36tlCaotuo4/TaojOdOeK9BNPiFfQIuhbLp3rdAQsTrynzdB5Dxm7t0CRnERhcIeCnTh0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 079e1b6a-1568-45aa-b203-08d73b875b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:54:44.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kw52zqPhl5/2wltx/ihGOylsIRmlU/sk46VPfzTmGEzaMF9huQdAAqKTM4Q51DM8ApQAqLLX4mfRPxrPNw051OTh0c82i3DRD2Hmvuz/XS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The pointer to 'struct spi_nor' is kzalloc'ed above in the code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/hisi-sfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.=
c
index 6dac9dd8bf42..c99ed9cdbf9c 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -364,7 +364,6 @@ static int hisi_spi_nor_register(struct device_node *np=
,
 	nor->write_reg =3D hisi_spi_nor_write_reg;
 	nor->read =3D hisi_spi_nor_read;
 	nor->write =3D hisi_spi_nor_write;
-	nor->erase =3D NULL;
 	ret =3D spi_nor_scan(nor, NULL, &hwcaps);
 	if (ret)
 		return ret;
--=20
2.9.5

