Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F400C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499422805E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="bEaNcS4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfFCMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:50 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:30142
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbfFCMnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDI9X7fwjzc5oPf8aBzUA2Q5zcmT50zy8AWNrXSJAuc=;
 b=bEaNcS4RvRPaIW2MO9IysgAmxb/8WVeo/cUt78YiBybHFlLmIrz1YsyrPAF2/3+tIWdu68/w87pNPER3eCZyOKfdfkd4UR+BzS/hAcyU7rBLFu/ZV5FicIPbU1rmF0QvsWetkQYlZN7P5BFuT8+TPE9lJqcfSyeuWsCLkDSlEKs=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:44 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:44 +0000
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
Subject: [PATCH v3 12/12] mtd: spinand: micron: Enable micron flashes with
 multi-die
Thread-Topic: [PATCH v3 12/12] mtd: spinand: micron: Enable micron flashes
 with multi-die
Thread-Index: AdUaBuuDD5Zu6ZlIQOytGKfMP/706g==
Date:   Mon, 3 Jun 2019 12:43:44 +0000
Message-ID: <MN2PR08MB595106104C80B33816648BE6B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15f9ba9e-b346-4ba5-e571-08d6e8211d86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872AC54D61E5C63EA1FCA27B8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3nz4eYj1uWTdedVtxDU1IVvUhyGDbXSVB6nOf0BD5Kb8ZTqq5f09szA1q3qoDzm3aJbOHQ6AQe+JpNIruiNy8egKjJ5tHD0MQaM/VRzZbu8AoeDuidnJ0Thk2Knm+Degi5+4XU7JXQTB/u1IPo8xH53GBIQ3/SK3d/+hEYDz0Bk/Gz9M+Iv6vubjIKO/Lx8YmGQQBiRYkashNbfGDseQy+EGwTrgD+AIeCEjbays5+qainNcTiu2d87oMzj4MPm1pC9XM6fgEfZGP0SOc/Ert1ua1cGOL2Sm27ho++LOkeONDyqP55Xlg5jgrfPTnjFCzYg9aaNZMbtL+/qRae788G5EmCAYN6juculaZ5wbWIDp3JzimxzZQ2c18bSJAVgekkWGb5JYyk+keH28o+Y6jOGnSaRf9Ipn+SjN4MVc6VM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f9ba9e-b346-4ba5-e571-08d6e8211d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:44.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the Micron flashes has multi-die, and need to select the die
each time while accessing it.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 1e28ea3d1362..fa2b43caf39d 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -90,6 +90,19 @@ static int micron_ecc_get_status(struct spinand_device *=
spinand,
 	return -EINVAL;
 }
=20
+static int micron_select_target(struct spinand_device *spinand,
+				unsigned int target)
+{
+	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(0xd0,
+						      spinand->scratchbuf);
+
+	if (target =3D=3D 1)
+		target =3D 0x40;
+
+	*spinand->scratchbuf =3D target;
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static int micron_spinand_detect(struct spinand_device *spinand)
 {
 	const struct spi_mem_op *op;
@@ -105,6 +118,7 @@ static int micron_spinand_detect(struct spinand_device =
*spinand)
 	spinand->flags =3D 0;
 	spinand->eccinfo.get_status =3D micron_ecc_get_status;
 	spinand->eccinfo.ooblayout =3D &micron_ooblayout_ops;
+	spinand->select_target =3D micron_select_target;
=20
 	op =3D spinand_select_op_variant(spinand,
 				       &read_cache_variants);
--=20
2.17.1

