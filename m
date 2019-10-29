Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E29CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68E920663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UYf5te93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbfJ2LRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:14 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16491 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbfJ2LRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:13 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pz6anp6jyDvDJAgzmRxIu2UkBHXo7DTUr3I/L0W4wQuXAr9wwJ8x3NRKIr2Ti2FNd/eaE5InK+
 djubMAra8tevy7QODB+ABcOll1IokRYa4d2jzzMA4hmIKFE9vXRlwJCge1MR6w0a1vyo4imojY
 Ut4nZl9l4Y65eI1keieyveIkxSPkMCjAHKPA84onM+X9Ap54KSn2jf7C34Uivbzm2tVA/bpf4A
 vD34ibjUcU3/fYyWa9OepYuKulW8ehU4PKiE3oToVVYM5oSLSOlHydj68FXXrvW5NjjoEpF81n
 IJw=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53323555"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:11 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmq6Ha1Vi4uxqy+ve9d55e4IBgPw+itQc87/KnSmDHT4B3eiPobhbdcOIdbpaxjIbhcAnbs41hbPxZyh+KkanQEh7XhOVZTdTOtABvw43K2deYi+UldaDSRGR5wTIBGfZqxkLExY2cr0WAD5y/dXJbybJAu+zzqFd+uj2KCGa2DbMLFf3/N7we9vSPEnqQg0g27yh6CaFct8TvvD+fCBiUaqulVFU2BIzyYEBnZkV9pIA9j5ZOIL1Y8w9FjBj7+5/EmXfHGZb9G7AUp82FNv4wEibQnUNDfh6Cf93VP26toVCrQeOpCBaZcr9Kmq30Nv6tV0LBqj+Dp0psWDudACqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5MFUJ2TkY+4rZG64KE1FHcba0M1RFOVQ0BwuKjMPyU=;
 b=QtqBXGuhd4XH8dDbN4/u1n0l3xc8snr4SVBI/TUKAoGrUSDh/OphLkPseO9ywDZWcuSmcbEyz5xGOWYWzUab64RiM/U3zqm1nHwPcxk1AFETyrg9LPk9vfJJRGAaKtPU92Yoe7I4SsAGn9XiMsgepwYftJPQlPv1+MHp4SAMGFo04Yn2Kfcni1NSnIE+hJXXAghsCZeAcT1Cjgjyli0ULEfNPpniDuUDNSa0kIlr+mGUHKlxCCc0Ii3G98cWmer7k6dqq/1I9emtlsUEw3TV7kNFB9oH/NCgUgq3uR7AroWzAX41WVdBzGgN6EEwXSZ1x1JBJXbvZYatnyL/84H9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5MFUJ2TkY+4rZG64KE1FHcba0M1RFOVQ0BwuKjMPyU=;
 b=UYf5te93IykduuLu3DzuCqm+gh6yxTW7cN08GDlt4pg8uGV4fsZdvohYj6hFliWUeFHdT2XGnZiCMUsGjIZaxe8jNriHgLOeNb5sZU3/T/qA9WUxgzAo9i+41YymRR1WpKFAgXFHPoDSar3qjhPOA9cJ3w4Vbu3GPhq3leMKkYo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 13/32] mtd: spi-nor: Print error messages inside Reg Ops
 methods
Thread-Topic: [PATCH v3 13/32] mtd: spi-nor: Print error messages inside Reg
 Ops methods
Thread-Index: AQHVjkpnjcYY5ylF10iDIRPzQ54Epg==
Date:   Tue, 29 Oct 2019 11:17:09 +0000
Message-ID: <20191029111615.3706-14-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: a4c72f2b-05b1-4df8-683f-08d75c6189cc
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823E17FFE34FE15A2CA0078F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(15650500001)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z35SCMQndr9glg0v9oL68lMHP62/sDwlgL5SYHUKFKCisEipXHiKnwt6VwurFWxbTs6wi7zsFKUb5IFopiWIyOqr0Gu8rWVu4S/bDb1UKtrpAKsG55+jKWx8NSJIJ0njW+1nnkUBlv7SFba9A+mnYqDrXg1Y0QZ+ljtnYk5a5ctpwB5gUWT0RsK7kdwzrkkIalvnKTwKtQXLkBpYbJuSdKkJCryAE4GfacrVLgjlwiqmLAlKWreZDykBaeChRbGSuxKpGVnpt0OKlojjtDkLnPx+2ZADTkKP4BuUw+C2ySefcjwGgyACcPApxh8yv4TxCY83jrMl4iNSEFMwBJmtjGlJrehHcfUcCfig0CSPdRYSX1Iskd1ErLWqBY9zaNpVpUmJ07sF84OjIN2EBLttPCRXN3eodxmSBrlteK7cqL5ZO1ONl8kgLIyXrMqExMgP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c72f2b-05b1-4df8-683f-08d75c6189cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:09.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTpqSoH0eVYsF9MztAYOeU4pWsxmO1B3+vCj/XpqYdAOT39jr5nRZINmXnzr5s8zxeawg5SZ7AuWEaOK3+O9CeeXFpapkVY7Z3T8CnuUHRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Spare the callers of printing error messages by themselves.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 165 +++++++++++++++++++++++++++++++-------=
----
 1 file changed, 123 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e5ed9012cd50..bc46b946ac77 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -394,6 +394,8 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, =
loff_t to, size_t len,
  */
 static int spi_nor_write_enable(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
@@ -401,10 +403,16 @@ static int spi_nor_write_enable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d on Write Enable\n", ret);
+
+	return ret;
 }
=20
 /*
@@ -412,6 +420,8 @@ static int spi_nor_write_enable(struct spi_nor *nor)
  */
 static int spi_nor_write_disable(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
@@ -419,10 +429,16 @@ static int spi_nor_write_disable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d on Write Disable\n", ret);
+
+	return ret;
 }
=20
 /**
@@ -524,6 +540,8 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
  */
 static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
 {
+	int ret;
+
 	nor->bouncebuf[0] =3D val;
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -532,15 +550,23 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     nor->bouncebuf, 1);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-					      nor->bouncebuf, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d writing SR\n", ret);
+
+	return ret;
+
 }
=20
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
@@ -551,12 +577,18 @@ static int macronix_set_4byte(struct spi_nor *nor, bo=
ol enable)
 				  SPI_MEM_OP_NO_DUMMY,
 				  SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor,
+						     enable ? SPINOR_OP_EN4B :
+							      SPINOR_OP_EX4B,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, enable ? SPINOR_OP_EN4B :
-							    SPINOR_OP_EX4B,
-					      NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
 }
=20
 static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
@@ -572,6 +604,8 @@ static int st_micron_set_4byte(struct spi_nor *nor, boo=
l enable)
=20
 static int spansion_set_4byte(struct spi_nor *nor, bool enable)
 {
+	int ret;
+
 	nor->bouncebuf[0] =3D enable << 7;
=20
 	if (nor->spimem) {
@@ -581,15 +615,22 @@ static int spansion_set_4byte(struct spi_nor *nor, bo=
ol enable)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
+						     nor->bouncebuf, 1);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-					      nor->bouncebuf, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
 }
=20
 static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 {
+	int ret;
+
 	nor->bouncebuf[0] =3D ear;
=20
 	if (nor->spimem) {
@@ -599,11 +640,16 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 =
ear)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
+						     nor->bouncebuf, 1);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-					      nor->bouncebuf, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d writing EAR\n", ret);
+
+	return ret;
 }
=20
 static int winbond_set_4byte(struct spi_nor *nor, bool enable)
@@ -628,6 +674,8 @@ static int winbond_set_4byte(struct spi_nor *nor, bool =
enable)
=20
 static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
@@ -635,10 +683,16 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *=
sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
+						    sr, 1);
 	}
=20
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
+
+	return ret;
 }
=20
 static int s3an_sr_ready(struct spi_nor *nor)
@@ -646,16 +700,16 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	int ret;
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
+	if (ret)
 		return ret;
-	}
=20
 	return !!(nor->bouncebuf[0] & XSR_RDY);
 }
=20
 static void spi_nor_clear_sr(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
@@ -663,10 +717,14 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d clearing SR\n", ret);
 }
=20
 static int spi_nor_sr_ready(struct spi_nor *nor)
@@ -692,6 +750,8 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
=20
 static void spi_nor_clear_fsr(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
@@ -699,10 +759,14 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d clearing FSR\n", ret);
 }
=20
 static int spi_nor_fsr_ready(struct spi_nor *nor)
@@ -839,6 +903,8 @@ static int spi_nor_write_sr_and_check(struct spi_nor *n=
or, u8 status_new,
=20
 static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
@@ -846,14 +912,22 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 =
*sr2)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
+						     sr2, 1);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d writing SR2\n", ret);
+
+	return ret;
 }
=20
 static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
@@ -861,10 +935,16 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *=
sr2)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
+						    sr2, 1);
 	}
=20
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
+	if (ret)
+		dev_err(nor->dev, "error %d reading SR2\n", ret);
+
+	return ret;
 }
=20
 /*
@@ -874,6 +954,8 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr=
2)
  */
 static int spi_nor_erase_chip(struct spi_nor *nor)
 {
+	int ret;
+
 	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
=20
 	if (nor->spimem) {
@@ -883,11 +965,16 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
+						     NULL, 0);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-					      NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d erasing chip\n", ret);
+
+	return ret;
 }
=20
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
@@ -1934,10 +2021,8 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	spi_nor_write_enable(nor);
=20
 	ret =3D spi_nor_write_sr2(nor, sr2);
-	if (ret) {
-		dev_err(nor->dev, "error while writing status register 2\n");
+	if (ret)
 		return ret;
-	}
=20
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
@@ -1977,10 +2062,8 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	spi_nor_write_enable(nor);
=20
 	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
-	if (ret) {
-		dev_err(nor->dev, "write to status register failed\n");
+	if (ret)
 		return ret;
-	}
=20
 	return spi_nor_wait_till_ready(nor);
 }
@@ -2738,10 +2821,8 @@ static int s3an_nor_setup(struct spi_nor *nor,
 	int ret;
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
+	if (ret)
 		return ret;
-	}
=20
 	nor->erase_opcode =3D SPINOR_OP_XSE;
 	nor->program_opcode =3D SPINOR_OP_XPP;
--=20
2.9.5

