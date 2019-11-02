Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499BBCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05056217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="l4hqc1o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKBLYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39936 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKBLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:37 -0400
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
IronPort-SDR: 1Cz8CabsJB5aPNdZgR8rUafYslFX9UX6hu+l1CLUe+3+Z0SpdOpzG9znyqoKZIzO/jeqJys5Ps
 RhL4j34ymRaqTu3bgNqwCv18XPRdejiD4GE9au5rhFgUy/kneNC25UzfgPMWK+IU+2oixs98bY
 IeATTZGq44E91MylvhId51WFodbT394IyarhfJIkWFVQIsZqEaXcHMaZpt3SyAACku1TQS5xRf
 tawIbOUAVEie+q8dcV9mcZt3a4z3y851UDKVe/jmXz4sZsVeCUez9phaZ4clLM2J1pSozxeGuw
 0Rg=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900859"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:37 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtKYPj4qiin1DdFG/5GezUMAg7hRy5tlHlBOCB8OVlIvdGM0AWx1tQYKnK3t3XV7l6wLHuWMTBVcr6Y31ffHN/5IKX3jNxegUIGG3JvQ8Gxdcdl7Lj85e9Keq+6RcwxzV1fhUm4TNjMkTEszqI0XHbsitydhJx9RGmvace36hhHIwd3GjcpGHVszPoPnY8+a4zKoQ1gO+dbo47SwzPYplLYQ2jKsecU6fO8iEyoRN+fHoWqCrVlwhndCJ+C6ZLk0JkzjUlNpPqJXko89kB3zeGrnDkfX9LNq4gw4wCrxFoV6FUHuD55h67kvNzvfLPtVX5DbBzH2UAgZmZaXC34CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV9ZV+dpdOeqmzMaATrQcgtGBfietAn50Y/nOlQ5QLI=;
 b=oMIttQC0Fy8zxXqcDZ00CEY1ZiaeMx5uO7mGku/yk4swh338ci4JH2dCmeGNkrgI9QSNuIkzEImiRlLwkTBq2eIqwhCtTia+kaeRLT6oK6gBZ66wYBSe8Ied+8iQqJWxECl36xDD1eTQsQUSvUJmGegkhSBQblmkRx+IqkOeAPbTwKtZyYhm5f5YlOXAOzMks8D1bMP9EeXE+Opg3XjeNU1R9BuOe13J1ERcNaSclRj5ZYhbe/t/yhiY+bzqSlT5tfppzrerOydn5G0w6Gsjn8ptd0/g+ewK51mNqC/Y74ITAbygub10hgC8jNwvOHK6To1xwFTZJ6z9DyQW9i+jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV9ZV+dpdOeqmzMaATrQcgtGBfietAn50Y/nOlQ5QLI=;
 b=l4hqc1o/evm8Xt8aALeZvgb/xkGl2PCddEnkDw6lPbw82rCquLd8RqIx+3/5Orhlsohw5MkLQEesz075a4dOqvaS5HkqUx5PEzKbsEOSKiE+KrOKsS/0eTYcdqLR1WHgrAM1VrwCcQg+MKMi961yY3yBEK8UfkfNuZ0HWTNKMpg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:35 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 07/20] mtd: spi-nor: Merge spi_nor_write_sr() and
 spi_nor_write_sr_cr()
Thread-Topic: [PATCH v4 07/20] mtd: spi-nor: Merge spi_nor_write_sr() and
 spi_nor_write_sr_cr()
Thread-Index: AQHVkW/3OZyxksCAp0Kn0MTvLY6iFw==
Date:   Sat, 2 Nov 2019 11:23:35 +0000
Message-ID: <20191102112316.20715-8-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8a638383-481e-416d-7587-08d75f8719ed
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371177B8A5E28E183960EEA0F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyyB1a4btWokEtaiXgr9mp7HvZSVZdUwrbqXQoOQboY5eRZ6g8fimfHpIoDsXwer7T17yNQwQ+jcqrwZTd7KB07NA0aCijuARmUCf8nEDd2BuzCotMsUEDkuPKD1w6YsE4l58FFRh5bH4oI58OvB3+7Uv0we505pcXh3/4zU+worH9XUrIiuqTMqePPGh8b0cjYDLbLgudHKeRo+jvl7qDiIkFYh5Lw/28wSgVTvNJdDsevBKZX3YgYuTP48DPiL6g2+lRDAb2brKKTr98021g1jn7DER3Z6iIKvnqQDeYTPr+EZgdVUCxAT9ZG4vxbhtFA2samjuJV9ay50lCEV05NLiZKRPxqNoxROxhndN+jXryq26AsGxHP9WqhdpT4kY8rRu+kGiA82IBwh7rIlAzCYuKwAeb6uPRc5SYhGMZhXPyLXKzkRu2REYK9ZJCG8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a638383-481e-416d-7587-08d75f8719ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:35.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6y4ovCrVOPLCjtSjPSLaf7+BziKVeeJd95pMHTmWL4SDYqXtXOtveCwNboSZi/YWp0GLX6b34QirNdU0DGRQLmBXZ2pKBdS+b9AX6x06EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Merge
static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
into
static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)

The Status Register can be written with one or two bytes. Merge
the two functions to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 74 ++++++++++++++-------------------------=
----
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ce32b84f050a..857675a4e329 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -824,16 +824,18 @@ static int spi_nor_wait_till_ready(struct spi_nor *no=
r)
 						    DEFAULT_READY_WAIT_JIFFIES);
 }
=20
-/*
- * Write status register 1 byte
- * Returns negative if error occurred.
+/**
+ * spi_nor_write_sr() - Write the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		pointer to DMA-able buffer to write to the Status Register.
+ * @len:	number of bytes to write to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
+static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
 	int ret;
=20
-	nor->bouncebuf[0] =3D val;
-
 	ret =3D spi_nor_write_enable(nor);
 	if (ret)
 		return ret;
@@ -843,12 +845,12 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     nor->bouncebuf, 1);
+						     sr, len);
 	}
=20
 	if (ret) {
@@ -859,49 +861,15 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 	return spi_nor_wait_till_ready(nor);
 }
=20
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
-{
-	int ret;
-
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
-
-		ret =3D spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr_cr, 2);
-	}
-
-	if (ret) {
-		dev_dbg(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	return spi_nor_wait_till_ready(nor);
-}
-
 /* Write status register and ensure bits in mask match written values */
 static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
 				      u8 mask)
 {
 	int ret;
=20
-	ret =3D spi_nor_write_sr(nor, status_new);
+	nor->bouncebuf[0] =3D status_new;
+
+	ret =3D spi_nor_write_sr(nor, nor->bouncebuf, 1);
 	if (ret)
 		return ret;
=20
@@ -1868,7 +1836,9 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
+	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
+
+	ret =3D spi_nor_write_sr(nor, nor->bouncebuf, 1);
 	if (ret)
 		return ret;
=20
@@ -1915,7 +1885,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
=20
 	sr_cr[0] =3D 0;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
-	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -1957,7 +1927,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
=20
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
-	return spi_nor_write_sr_cr(nor, sr_cr);
+	return spi_nor_write_sr(nor, sr_cr, 2);
 }
=20
 /**
@@ -1993,7 +1963,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -2072,7 +2042,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	return spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
+	nor->bouncebuf[0] &=3D ~mask;
+
+	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
 }
=20
 /**
@@ -2110,7 +2082,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
=20
 		sr_cr[0] &=3D ~mask;
=20
-		return spi_nor_write_sr_cr(nor, sr_cr);
+		return spi_nor_write_sr(nor, sr_cr, 2);
 	}
=20
 	/*
--=20
2.9.5

