Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F15C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D322808B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="wPSy3R92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfFCMnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:52 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:2273
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727954AbfFCMnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceEg2Cu+TtkgwAu5gnOJH72jT2tkLxZkbe0TP39b7qY=;
 b=wPSy3R92swnQJg5ommpIzzJ/w2bC0zZ73yaK3IpeyfVTIjQDFft2OUBLdtlNiMY3P/n6eoJJcmUnJgCd1zYbl3r63K25O4yBfZfFirjRcVdyKgURxCpm/2Ooe8e9myR/hfMWWS6AKeQmTcExdWqSGpZg4Fr+tJt8VwDjnfTaOFs=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5854.namprd08.prod.outlook.com (20.179.98.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 12:43:38 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:38 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/12] mtd: spinand: micron: prepare for generalizing
 driver
Thread-Topic: [PATCH v3 09/12] mtd: spinand: micron: prepare for generalizing
 driver
Thread-Index: AdUaBiMix19KY2jqS2qrkB9UmPjl7g==
Date:   Mon, 3 Jun 2019 12:43:38 +0000
Message-ID: <MN2PR08MB5951A62F8BE7AC5A125F1949B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ffc65b4-4f50-43ca-8584-08d6e82119f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB5854;
x-ms-traffictypediagnostic: MN2PR08MB5854:|MN2PR08MB5854:
x-microsoft-antispam-prvs: <MN2PR08MB5854B512C2D7B1F78C760109B8140@MN2PR08MB5854.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(5660300002)(81166006)(8936002)(7696005)(14444005)(7736002)(8676002)(305945005)(55016002)(256004)(2501003)(81156014)(102836004)(2906002)(110136005)(53546011)(6506007)(25786009)(55236004)(33656002)(76116006)(476003)(73956011)(66066001)(66556008)(66946007)(26005)(99286004)(64756008)(486006)(66446008)(186003)(66476007)(52536014)(6436002)(74316002)(9686003)(6116002)(3846002)(2201001)(14454004)(7416002)(86362001)(316002)(53936002)(71190400001)(71200400001)(68736007)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5854;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AF+l9W2C39jPSeRoqKul7jeoVnEjumdeCK2i2y2BWI8b/mwt8zp3rV9jfdEq1Mn0sXDd5ZEOuMG0bDvC+hnPgc8JOsTTYuGpCdnvXYXP6BeCrgZ1kV5lFS7rOxm8P1fFVudYOEePXxGrs+uWP41uWF4kGVk0D+TpPdtJPuwHCgsl7Nn81jk0tZhbHy9HracgiHGdrvE+LOMaLBt6O0AemUSuM2dWh1mdYAudy0SjUZ2brprFaxTT1S5aUU02IOb56H3/NABp6EMGg/o8kQsid8v8pgJ3SqpMNNI88xzaeIZNqoKRqPzi4VXOEeBaT1D2NP4FOEaZ9SW9F1umN8b4ThF4fO6HSq6zCOXeNmRcatOHqq8GEQjekwGV8NFMcCKGjjchtG9xVDWCHDW825SGyWMlAankMef+dGssFkwt2Vs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffc65b4-4f50-43ca-8584-08d6e82119f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:38.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 654f8acf5d0724fda54c352cc91b0ab576dff928 Mon Sep 17 00:00:00 2001
From: Shivamurthy Shastri <sshivamurthy@micron.com>
Date: Tue, 7 May 2019 15:19:22 +0200
Subject: [PATCH 09/12] mtd: spinand: micron: prepare for generalizing drive=
r

Generalize OOB layout structure and function names.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..95bc5264ebc1 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
=20
-static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
+static int micron_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
=20
-	region->offset =3D 64;
-	region->length =3D 64;
+	region->offset =3D mtd->oobsize / 2;
+	region->length =3D mtd->oobsize / 2;
=20
 	return 0;
 }
=20
-static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section=
,
-					 struct mtd_oob_region *region)
+static int micron_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
=20
 	/* Reserve 2 bytes for the BBM. */
 	region->offset =3D 2;
-	region->length =3D 62;
+	region->length =3D (mtd->oobsize / 2) - 2;
=20
 	return 0;
 }
=20
-static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout =3D {
-	.ecc =3D mt29f2g01abagd_ooblayout_ecc,
-	.free =3D mt29f2g01abagd_ooblayout_free,
+static const struct mtd_ooblayout_ops micron_ooblayout_ops =3D {
+	.ecc =3D micron_ooblayout_ecc,
+	.free =3D micron_ooblayout_free,
 };
=20
-static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
-					 u8 status)
+static int micron_ecc_get_status(struct spinand_device *spinand,
+				 u8 status)
 {
 	switch (status & MICRON_STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] =
=3D {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
+		     SPINAND_ECCINFO(&micron_ooblayout_ops,
+				     micron_ecc_get_status)),
 };
=20
 static int micron_spinand_detect(struct spinand_device *spinand)
--=20
2.17.1

