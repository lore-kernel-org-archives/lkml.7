Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3562C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Tegzo/8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfJ2LSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:40 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36095 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732736AbfJ2LRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:07 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: A09uAHhZuRPT5FX3WcedWPiWTfhBqPaltd+Z8zlo1YkBBCfA179F932wICVyxrxTTyFj5PNcoC
 i1WQQmhNH2lwvDB//ZglseRWqg4QcnvdrYqjpXZxdJ1sXUEEaUrzBZ6FLVsLfCDcgYTnZkYp8c
 ItjFTPOPqdcPXKvGnrXgS+r2zna/sd4ot/o+8cXdq3wUju0RKq1viq5LGoO5/TzbaHWcLrqZZD
 j3y+d7pio38EIqf0V+HBznL3L/+BLN73pwnSbwdqpLeXsqOCtedew1SwvvCAhlcuKrd8Jd6feR
 4tE=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292037"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:05 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9hEjlJcobdHri1PDQv1OLTOvz+HmmUUqNALaikZSqGbbu8vutlitaOPqV85/BFTUPkCEomQc1NDssa1c7D7UDd2sWK07vXVRsfbTo+necBzC8kqQTijbCpGteKxtrieXuMnET6vX4eEzGcG+uxX/621T4qF47pIYguQtGlPxl3Xc/jBl+Ni0alnRDGD0XXD92pkNtTZKW7PUy8VNMG/15cDQczg1AaBCrwpJxfTwgQiM7SrtwAICJYZ3iCMa5r+LXrMdwQ6T41/HL+McPz3C6Zyk2kg5wBFsKnJrXqEBqxFfRESeSA17okemT9C9rMU4fbntmwvs1DS4mvUKHvx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epZY1xhrE9lXiRFLHIxZMnRybYo6o5+OjHsSHvga2f4=;
 b=AStgiybI9upFcQxZj3T4lyDvQFS7vMDs1od9w7lIg4Zg3d3d6vaXtsdYxhZ5FODY0bZRE/nz3uiYm24AhzZP5IfQgLlaNq5I2Gmq+zuOp25B4gPk2vA98SC0cEAWIGO5TzchymBDKbWy94LILL8YZrZls/RNGN14falfUaHjOR0+TUyqzVXHyv17zQCvh18pYajAj0NKwmZygzCroBQghHRp8Ad3MSuPKUA0lLlkLw32bNazgeCLsg8n9cU/ff31W6YJVGLn7NBRd4gWOhp4+7gxzC3/n2Ij6CetMEIFJM5WIb1EmvwKQn/We5B2fMBJqXEL+huuH42J8u4SR5mksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epZY1xhrE9lXiRFLHIxZMnRybYo6o5+OjHsSHvga2f4=;
 b=Tegzo/8WBBPSInVGNdPQjpWHnm4Co7try6hvCvHCPyCtX4z1uPDLKIZ8XD/bmGaxtqZ9f0zL07w3A9YEMBkXclSYb5japHtHzBN7IGaF35mvXeu0SLezBMfC7o1GQvSdHErCeGPOg6zgf3IB33rAYMLzpu1pdv4CQiGqlpD2/30=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:04 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Topic: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Index: AQHVjkpkiF1slcDF2Ua4XfvPGlZW3A==
Date:   Tue, 29 Oct 2019 11:17:04 +0000
Message-ID: <20191029111615.3706-11-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [83.166.207.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92b74673-8c52-4f0a-956b-08d75c6186dc
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB382344269819C21BB0FC6916F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l78p0gXIY0df4czIrapXagIwOZK24UFEn5vQxCFQQBiMCzjHdzgCATuDkTKGSI9Jsb7qM0Fx9gaoUvfIl3wh1xuiSED2M+OzC6cNIOT14N1/IAyJ76ATBr2GOkF/GYe9w/qgU7hJjd4So6Crnd9HFiZwBuPoeWJd8JjoWTlA1ZaOw1GdHB4+FvtfcaSZoDWnUvwayPIoufcpynmRCDzX+1WjKraNNm+Sy7QattZ9bghXe7bPthoduaBE0gxDqxyyttupRNRnxgCgC7huO5LwrxMq1t6BKqwWPodsvNQxnS/mnRX/p2g2TxGu1s7aBoJUaA0ELy6r7Jb/YsmgiCsCw1yJ3Q4IMT7VDIuPlXlplb6giUsONd4xs5iv4IcdsOo96Azhh2Xp9f+sdCs5boIuhLlDjiAaZ2iYsOe65uwtg3h3PBRtM9Zmco/9tOukdxzb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b74673-8c52-4f0a-956b-08d75c6186dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:04.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI2dBaw3YtY5l87HL9fmEvM/7B70wyw7eHNwaHzvzbbznGaTUdYbNaznbbP7H8q1g5kyNIDwMraeB2PPE6eVw3FoiwZCtiqDY22wYn4m9lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Let the callers pass the pointer to the DMA-able buffer where
the value of the Configuration Register will be written. This way we
avoid the casts between int and u8, which can be confusing.

Callers stop compare the return value of spi_nor_read_cr() with negative,
spi_nor_read_cr() returns 0 on success and -errno otherwise.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 55 +++++++++++++++++++++++----------------=
----
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0d38aede4de7..ec179eac2069 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -487,12 +487,16 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *=
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
+ * @cr:		pointer to a DMA-able buffer where the value of the
+ *              Configuration Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_cr(struct spi_nor *nor)
+static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 {
 	int ret;
=20
@@ -501,20 +505,17 @@ static int spi_nor_read_cr(struct spi_nor *nor)
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
-	if (ret) {
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
@@ -1820,8 +1821,11 @@ static int spansion_quad_enable(struct spi_nor *nor)
 		return ret;
=20
 	/* read back and check it */
-	ret =3D spi_nor_read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret =3D spi_nor_read_cr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -1879,16 +1883,16 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	int ret;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D spi_nor_read_cr(nor);
-	if (ret < 0) {
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret) {
 		dev_err(dev, "error while reading configuration register\n");
 		return ret;
 	}
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
@@ -1902,8 +1906,11 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 		return ret;
=20
 	/* Read back and check it. */
-	ret =3D spi_nor_read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -2019,8 +2026,8 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	u8 *sr_cr =3D  nor->bouncebuf;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D spi_nor_read_cr(nor);
-	if (ret < 0) {
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret) {
 		dev_err(nor->dev,
 			"error while reading configuration register\n");
 		return ret;
@@ -2030,9 +2037,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (ret & CR_QUAD_EN_SPAN) {
-		sr_cr[1] =3D ret;
-
+	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
 		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
 		if (ret) {
 			dev_err(nor->dev,
--=20
2.9.5

