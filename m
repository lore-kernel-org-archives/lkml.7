Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100B3C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B5A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kC/pNPrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfIQPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:15 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7994 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbfIQPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:11 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VqI5gCWCb+EpMZCko32/34CPWGMKY49niamTZgFsDDgHSOqnG60QkBXfrkeyNdrwm7Fpf2JpLI
 l5A2t3hCyWLykmpEuJ2/FwkyHUHdTo+vC6thPXVVBF1VxohZyeKVZKpd4QBM1fFs2lQqz70Ka/
 XUG31Ej00v3bHTRlw/uSlIZF2p7iqXcKtq2lIIRC27ob4KD02SHgVJdfN6LtfdWdK7JdiU94yr
 a0iWOewUVTMDK/e0sSOYTPG5M/diVVLhCjzkP93TUJwQu+trU3L2wC8BrjzHQTFlUdP1D7okCX
 PSI=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="46517662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRPaKBUCyH22e0ZMYZ81etooLJF+DAGJtxRIRGgoMqHavpCJudbEeGXZp7nqOpw2+bXGWWugtIs61MWMqtCZFiRPlwAH6dJDYaOnDT3hOAk5nLHVcabuTX9TM6toNOvPl4AGR2vtIStSrc70QKdjdvXLXq3FJCY2JZrrwAZhHdQAjRrxWmQqdr3RpzinMYRJOmsu5UpZNrmbi9tl52dxei6VJI+qacyHqT6qmT9I+RFu+44DAxtGtLiTrrt3Sw6+oC6WrLZ38hQFXi93L2MVpC7Cg+M+CEc+xpw/2EnLAqi0X1GIX2BPShG1ZZqsbOWRi3KoDyIaYBC1riscE5p36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBKhUz7wCD4+xga3q7ImeAcsWiyA8JLz2CJsngeUTIE=;
 b=bE4AmCmNOcso8AoZ30GIDD4NWAkHU64C+VGYwSi6JG1jV3fa/6pz/GX4goe9+1IFGxC3luftgLrQYX/cnhSE+YXg7gNVUj8BohUg+IGtRX7LyjSOzd+qgkCoiAXUZa/i9v2awzMfQOMtvCVEE2A2eTnhjeQwY0Tx9r3fOFZlbeV9J3Fo0P3AOv6xPnZbYDT9+h/cv+xkFxLoM3z/ACxgHKKpOLOMZbhxIyzFqU5PWsIcWnd9QkgFMoEXD5InLEbQJSmR6oteMQcFB7brAtrrDR4FgrnsZjUCUoJBm+zGP/vK1e+I2NrrPJtn5REfySpTGE2uSYRFQfatZEbRBUSsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBKhUz7wCD4+xga3q7ImeAcsWiyA8JLz2CJsngeUTIE=;
 b=kC/pNPrqdi3BqiJ9xg8ore/xp8bk4+4eddsjeG6cemvO9SNZ1QQbC0oi7HuquzTB/MTR6R8kmpEtm7fAhcnq4U6Y1SPyooqqq/1KcHtp3OAu5sooC4deIqLDxX4Z1gbxmjnOxj4LY9UxiOVIqsVGE1277WYCgOueU/KBpnJ2a34=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:03 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 07/23] mtd: spi-nor: Rework read_cr()
Thread-Topic: [PATCH 07/23] mtd: spi-nor: Rework read_cr()
Thread-Index: AQHVbXBEW9QaD53790O90YS1lx9Xog==
Date:   Tue, 17 Sep 2019 15:55:03 +0000
Message-ID: <20190917155426.7432-8-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: dc2c6571-838e-47a9-ee72-08d73b8766f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB398486D7482EEA11955FFE3BF08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 71KEGZ62Tga/h0Wuo9nVRUGsTofImqScKCGTQL1wEerrL1hTh63u+KVBHOWz2c49gWGwTON/TtUTD/S0QN/DZsB5Ak49CFEXBBgNlHkkwAlQkt79oKYyGHkHVr/RGI4+JnODGiLNY9LbfInMTiZfqXVg2hmV2ftolUAzEQQgHiVDEkeilOc55I+3nQ9s0oOoJgbvhq2lBqcD1WnbGEicUBtxTns4Sjq0D/DxPg4hzbOudj8TdqL7NXN29sKI8x1IsTbKpfodlzc09vmF1FdRKhQSVSyMRDvzexeVlwSGxDuAW64DG6aLv8kIDJjg+3aDOBp4Ki0O+gXi3Gvd4dnze41EGMnwL94fK6v83S9DyA7zncDDkAykViRznGaDP9ACG5xEHCn1bfk8LAW0CLEQg/tIMFcZrz/4++vgfMe0daA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2c6571-838e-47a9-ee72-08d73b8766f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:03.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfUG+3+ZAo30mtEF2Tf+LnndtTUvUvlAttLO2fYM4h3sgEAL7fl6u4mhY6PeR/kENtj90uTsyktKz/kCA++oULgASicwt/XhXrhcokzuk+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

static int read_cr(struct spi_nor *nor)
becomes
static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)

The new function returns 0 on success and -errno otherwise.
We let the callers pass the pointer to the buffer where the
value of the Configuration Register will be written. This way
we avoid the casts between int and u8, which can be confusing.

Prepend spi_nor_ to the function name, all functions should begin
with that.

Vendors are using both the "Configuration Register" and the
"Status Register 2" terminology when referring to the second byte
of the Status Register. Indicate in the description of the function
that we use the SPINOR_OP_RDCR (35h) command to interrogate the
Configuration Register.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 66 +++++++++++++++++++++------------------=
----
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8cd1cadcb8b1..04491885b9bb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -448,12 +448,16 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *=
fsr)
 	return ret;
 }
=20
-/*
- * Read configuration register, returning its value in the
- * location. Return the configuration register value.
- * Returns negative if error occurred.
+/**
+ * spi_nor_read_cr() - Read the Configuration Register using the
+ * SPINOR_OP_RDCR (35h) command.
+ * @nor:	pointer to 'struct spi_nor'
+ * @fsr:	buffer where the value of the Configuration Register
+ *		will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int read_cr(struct spi_nor *nor)
+static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 {
 	int ret;
=20
@@ -462,20 +466,17 @@ static int read_cr(struct spi_nor *nor)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_IN(1, cr, 1));
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR,
-						    nor->bouncebuf, 1);
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
 	}
=20
-	if (ret < 0) {
+	if (ret)
 		dev_err(nor->dev, "error %d reading CR\n", ret);
-		return ret;
-	}
=20
-	return nor->bouncebuf[0];
+	return ret;
 }
=20
 /*
@@ -1768,7 +1769,8 @@ static int macronix_quad_enable(struct spi_nor *nor)
  * some very old and few memories don't support this instruction. If a pul=
l-up
  * resistor is present on the MISO/IO1 line, we might still be able to pas=
s the
  * "read back" test because the QSPI memory doesn't recognize the command,
- * so leaves the MISO/IO1 line state unchanged, hence read_cr() returns 0x=
FF.
+ * so leaves the MISO/IO1 line state unchanged, hence spi_nor_read_cr(nor,=
 cr)
+ * gets the 0xFF value.
  *
  * bit 1 of the Configuration Register is the QE bit for Spansion like QSP=
I
  * memories.
@@ -1787,8 +1789,11 @@ static int spansion_quad_enable(struct spi_nor *nor)
 		return ret;
=20
 	/* read back and check it */
-	ret =3D read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret =3D spi_nor_read_cr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -1839,21 +1844,18 @@ static int spansion_no_read_cr_quad_enable(struct s=
pi_nor *nor)
  */
 static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 {
-	struct device *dev =3D nor->dev;
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D read_cr(nor);
-	if (ret < 0) {
-		dev_err(dev, "error while reading configuration register\n");
-		return -EINVAL;
-	}
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
=20
-	if (ret & CR_QUAD_EN_SPAN)
+	if (sr_cr[1] & CR_QUAD_EN_SPAN)
 		return 0;
=20
-	sr_cr[1] =3D ret | CR_QUAD_EN_SPAN;
+	sr_cr[1] |=3D CR_QUAD_EN_SPAN;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
@@ -1865,8 +1867,11 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 		return ret;
=20
 	/* Read back and check it. */
-	ret =3D read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -2007,20 +2012,15 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_=
nor *nor)
 	u8 *sr_cr =3D  nor->bouncebuf;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D read_cr(nor);
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while reading configuration register\n");
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
 		return ret;
-	}
=20
 	/*
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (ret & CR_QUAD_EN_SPAN) {
-		sr_cr[1] =3D ret;
-
+	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
 		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
 		if (ret)
 			return ret;
--=20
2.9.5

