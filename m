Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D8CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1FF21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="m/3Lro9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKBLXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32692 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfKBLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:37 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: mini2WaJmq+0p1djoGYzvsWhIkwTu7y4LJ2LCxabp1teRkwm0RpWNUALw6O6VqFBo+YuoJ4Qce
 juI+BI5dmYT4fgyOVLRGvHXyTlWUWc3q85bnNRrIeQwu2o1zPMWH3q6k+t5z3Jtw1OWxXBWrz/
 qEhGL3ajcBsM2DRqpcxqP3AOer1DDlzCFtT2WIwjWB7YXhLccNNIWyN9jcnbsf/FP9s5cEAIU9
 YhoVYekQNCIXhC17wHNtJKjOUkEMlxw5BvCyI2a+lsLBzx9YKvjijKk39CdlIHIvMMwJeuKvJY
 aqI=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="56751551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:35 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyUp/3PTqFqwtP2b3i3K12JMWJbv9dND4VsnzDOsZQQMs+uE99PQQYSYEgCpRBcMWwkMn9EnMuktjiCk3DeV4urpyvgIyISmYZFMtqaMABYFVxkB+9AKI/L15yojf0+rJQHiF4udJdMjWB2FeazHKNQE5SPEgYpMXCrqT7NGTUoDupk6QzHlvPh30jOQ1RQ8KVwYvJZUr4vK0dJirpbtlB3EgNjyNGRORGYF5xsPKkeuWSZzzih33cic8B8jG4vUJGjWQJOvg25fz3Zq2nojploPKnfMyygBMI1LccWeMeokTNgtG6PGJvKbWEwyKN97lefGnUjG+8In7rQ8mqGYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YR+ufMgVnRyLZqmE9kOSPxIGqd/PC1wkOJNeKyjGw0=;
 b=S5birT1tmsj8KCIo+ThL/l6xjseadEgnZDiuotn67Gn+t0Y3fQFRe/JXxtW1B7FyVnxk9F6Wtu172cjTlHcCtWtH6EDpI0BxZeGOZ3ZdBDKKwyqAJpORJ8nphmLHvuANoSX0Qrre+68KHgKqww94Bg1eX5MvfumtS1h4H4KKEU6th69g4/GB6pl66vnTPmGZgyz2SgEXxT61uIgZ5htyWWkIrFDu+oEsFz6AZOSDEMOtFRxao1t8B4cVqMvVVJ1nDyXK5A3INmH2P8pVEyN3MIwlqgw0TyWDkCOVg867UN0WSagRdhEDHK+oGa0s8HWwHNe8fTkBu3TGf7cNCTA2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YR+ufMgVnRyLZqmE9kOSPxIGqd/PC1wkOJNeKyjGw0=;
 b=m/3Lro9mvKkBlDnzSXOv9lYAqlGjcXZKP1/2X0Dz3bXHiERksV4oSyyucj9dPUAKZ6dpIGrF1LAJ+SP+O2eyj1UB/IR7Dy615Mi4uEihar6NmuQdVTs1LWToV046HbUJFtd/hyaX4l26R3dSwYBNFleFU/CJzxpFw1OPP5VgDd0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 06/20] mtd: spi-nor: Move the WE and wait calls inside
 Write SR methods
Thread-Topic: [PATCH v4 06/20] mtd: spi-nor: Move the WE and wait calls inside
 Write SR methods
Thread-Index: AQHVkW/2V8L+Cxt040i9lyDqz7xpVw==
Date:   Sat, 2 Nov 2019 11:23:34 +0000
Message-ID: <20191102112316.20715-7-tudor.ambarus@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a669b688-fac8-4578-53a1-08d75f8718ee
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711709B808D62A20AE83CC1F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5DANSlkH4XTOpzgpvqv0sJJyThjFaJaLTbGKxecdMurB7T7mZgXDZ4as9DmOIxqNitbShfgxOsy0IFJcyodhkPSxUtdvU7cvES2/mvnh5szcjFU7DMDY0ts55ZUCsqtQ2j4H5U25ja6ml6tjVg/9CH+6vHvuAJlTqMUqNy7++c3MiC9ZeZj43aobNCXpKAjG/olyCkC6jTmFS3R4xW17u/QuZ9bA3hWHXRv+D9D983oErWSFoU1HEEDoaRvKqlxC8sF5z4dBtbd4vX4kCt4eKpdoBpdLxFo+EyU0UukEkXYLBBPatWf9KcRsHshGt+6OSjt0uxpXkVPWhFHQ5q40+e9f0UEzRPre8AJH/UpKAgUngdw9l2ciI8C84830d1XBTerkgH3yA312oT+a5lsen/p7aiCN8+PGznyxgmRfHlRuGb31hnZpctqWJmZJ2rE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a669b688-fac8-4578-53a1-08d75f8718ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:34.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orJnipJ14DdcY0qLW+7R8yhBSE7a8PbGMYnZt3ZR4IaLm4VSfc+omAij3r+lfUmL7jQrtq4YLiCXBLNnJI7/Ri5qMsS+5UoYPa2qBGD3zxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Avoid duplicating code by moving the calls to spi_nor_write_enable() and
spi_nor_wait_till_ready() inside the Write Status Register methods.

Move spi_nor_write_sr() to avoid forward declaration of
spi_nor_wait_till_ready().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 108 +++++++++++++++++---------------------=
----
 1 file changed, 44 insertions(+), 64 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index db1bb2b536ee..ce32b84f050a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -534,35 +534,6 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr=
)
 	return ret;
 }
=20
-/*
- * Write status register 1 byte
- * Returns negative if error occurred.
- */
-static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
-{
-	int ret;
-
-	nor->bouncebuf[0] =3D val;
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
-
-		ret =3D spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     nor->bouncebuf, 1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d writing SR\n", ret);
-
-	return ret;
-
-}
-
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -854,6 +825,41 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor=
)
 }
=20
 /*
+ * Write status register 1 byte
+ * Returns negative if error occurred.
+ */
+static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
+{
+	int ret;
+
+	nor->bouncebuf[0] =3D val;
+
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     nor->bouncebuf, 1);
+	}
+
+	if (ret) {
+		dev_dbg(nor->dev, "error %d writing SR\n", ret);
+		return ret;
+	}
+
+	return spi_nor_wait_till_ready(nor);
+}
+
+/*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
  * second byte will be written to the configuration register.
@@ -895,18 +901,10 @@ static int spi_nor_write_sr_and_check(struct spi_nor =
*nor, u8 status_new,
 {
 	int ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr(nor, status_new);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
@@ -918,6 +916,10 @@ static int spi_nor_write_sr2(struct spi_nor *nor, cons=
t u8 *sr2)
 {
 	int ret;
=20
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
@@ -931,10 +933,12 @@ static int spi_nor_write_sr2(struct spi_nor *nor, con=
st u8 *sr2)
 						     sr2, 1);
 	}
=20
-	if (ret)
+	if (ret) {
 		dev_dbg(nor->dev, "error %d writing SR2\n", ret);
+		return ret;
+	}
=20
-	return ret;
+	return spi_nor_wait_till_ready(nor);
 }
=20
 static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
@@ -1864,18 +1868,10 @@ static int macronix_quad_enable(struct spi_nor *nor=
)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
@@ -2041,18 +2037,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	/* Update the Quad Enable bit. */
 	*sr2 |=3D SR2_QUAD_EN_BIT7;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
 	if (ret)
@@ -2084,15 +2072,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
-	if (ret)
-		return ret;
-
-	return spi_nor_wait_till_ready(nor);
+	return spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
 }
=20
 /**
--=20
2.9.5

