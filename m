Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF373C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8F2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QfkkPQcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfHXMHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:07:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:27894 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfHXMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:07:18 -0400
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
IronPort-SDR: daTijQgZhshe+SbI07dwCYUYpagjlU8JhQpeoxmK8Uzjx+6n6Dcl41MJL0/+0UuyRZruxwEC0T
 kw3DMlxztfb/gKfBKhoP2SEeMufNof6Cpy+HS2V9rrrk5sH7yntcHTOq3p1fe04tVW3z6uHxcM
 J2HycoSEPABzNznEgYVLfNiC8GgxuzCY3hz9XX47AGpf8yka+yI0IgyOQDDektDErKB9LvFukI
 9mZAGGS7c6QKpvL4BQ8h/yJhxO0FkqheShtagIyklzbjabFK2YlCXIGnxyo+9T9qDT0SnuJGTD
 psA=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="47839899"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:07:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:07:14 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPRTKxRoB3SuFTi00M9FZYnjxyrXa1JiEkkkZXDyREnuiDtoSD+JHNZWEa/hYN95lnTKgUp3ReoHXJOGavLyMAwLIx+Zy3+YXse0OOCjDB4e4HVjGtx5s0+EYU/uqpcNIosGL7VsfRyy9ONj9zMAMHKDffReikvDLhQaiMCy0W4/7Sy3V3UTjPRrxgxtaCmA24ZBBgInZpZIASSuZ+6Hfa7EnEic4guLSrW5x+mLLXS3olRoO2QhtZEF74c8uRmpPfPShQp0yCljdsx/BtNLvVq6mz2XZppwrzUEhlUJOfmiAPNE6X5PLyvJn/XISGRu/2VGbBrBPPUz6jfagAteGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+2g9owQjFhqdlEo85cste8FN6vi3q9sk8ok5Lxtfak=;
 b=aJUxedw6+ZLA2sQUwStoISQwfo7tDgjDHSDhgtBCpVnoC7ohbdnea6CLPwK+0R71yD7OwhuLglm7psPZu6KBpCOXkKO/zxURp1p8pWaK86O+4D6Sotp9SEpWgZ88aYmkZElKt10dl/LRxU8E5t3T3CjIGfNleBA0M6Ep6HmEq0HSeaxmuw3inQSwSq9ZR04wqQnsllup/GHXhE+b6NrZCVzyNmryMZeiZ60cDMrQa+0wb6HvsWOTFhc7w8p9Z6kcB5CBeEfeDJIkgCliNcZqKMKq9XbodD181Q1tcFzcWibKdwnbAODnxYRN9I+Ewrc2cs/zeD6r3P7SnwrypuxusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+2g9owQjFhqdlEo85cste8FN6vi3q9sk8ok5Lxtfak=;
 b=QfkkPQcuJ4VgkykZ2kfbKHSnJ0IT0pn8L9otN/FHm1/vopwbbuG4M46TuDtsCRim3deYnm7crHanEqbuk3hjbEVLui+bhuorDayI/snzyYsOwI4W6EaWsNGskD6rnvhF6yOikAszYYICx2ocMZ2ITXKJjdymFvTF7cu9WxC5Uxs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4301.namprd11.prod.outlook.com (52.135.36.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:07:13 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:07:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 3/6] mtd: spi-nor: Add a ->convert_addr() method
Thread-Topic: [PATCH v2 3/6] mtd: spi-nor: Add a ->convert_addr() method
Thread-Index: AQHVWnR2zPE74NfEHECxgFFxQK1DPg==
Date:   Sat, 24 Aug 2019 12:07:13 +0000
Message-ID: <20190824120650.14752-4-tudor.ambarus@microchip.com>
References: <20190824120650.14752-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824120650.14752-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90a16a4-ce90-40f3-5614-08d7288b990a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4301;
x-ms-traffictypediagnostic: MN2PR11MB4301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB430112179EDAD343B0FA9D90F0A70@MN2PR11MB4301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(305945005)(99286004)(71190400001)(1076003)(71200400001)(7736002)(3846002)(6116002)(2501003)(52116002)(76176011)(4326008)(478600001)(2906002)(316002)(14454004)(53936002)(25786009)(110136005)(54906003)(107886003)(5660300002)(386003)(102836004)(6506007)(6436002)(8676002)(186003)(66946007)(26005)(50226002)(6486002)(36756003)(8936002)(66556008)(64756008)(66446008)(66476007)(486006)(476003)(2616005)(6512007)(446003)(81166006)(81156014)(11346002)(2201001)(86362001)(14444005)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4301;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A4GjT4cf3QKTvAyr2PwQdMP23qs/sctMaRR4nrL/KLJcWrMN5Y671xCni9EXdgcUdSoN6NimCiFnVxXRqhkLSZvu78rTrK4BgDJOdawzIKyuK46lL1yaUFQS0XDanqKhpveUbGPW6R7vFHIbA9vJPLdYQ6aJY0Ib27MySR2Nw24oJGsBaK9ubWloBuNcEmN06SuPfyTWDo7afy0eXqmGMTKfqWxunGZlOXyjHGNsJzi57SWkBdQAYaBWavaamBQbT+eIFp4Hrgwh67xa0URnjM9RhG41AwkhSp8ItwSANUluO7Mta2bCCfe5UnTsCvJaOnqisEl98+doMTLJ3mMh5jOIpeOsFRtY82q7eMfQ9tv3PfczyuRnrjt95v/1dZIwX60838EdPfZRHf1JqW2lf/mWcDs+tcqwK8vbvg6LKi8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a16a4-ce90-40f3-5614-08d7288b990a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:07:13.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XR6mjThbjYEORzbanqgsqPxjhdXH5SMQHZDzb2gfSvIGKJOb+4DHOvG1cVIOFxvl3zt6RVg9W9qXzPaTI/iLRnUIDYquYqZiehuxFzxOKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

In order to separate manufacturer quirks from the core we need to get
rid of all the manufacturer specific flags, like the
SNOR_F_S3AN_ADDR_DEFAULT one.

This can easily be replaced by a ->convert_addr() hook, which when
implemented will provide the core with an easy way to convert an
absolute address into something the flash understands.

Right now the only user are the S3AN chips, but other manufacturers
can implement it if needed.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 24 ++++++++++++++----------
 include/linux/mtd/spi-nor.h   | 17 ++++++++++-------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index bd31d6529892..0dc6a683719e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -899,10 +899,9 @@ static void spi_nor_unlock_and_unprep(struct spi_nor *=
nor, enum spi_nor_ops ops)
  * Addr can safely be unsigned int, the biggest S3AN device is smaller tha=
n
  * 4 MiB.
  */
-static loff_t spi_nor_s3an_addr_convert(struct spi_nor *nor, unsigned int =
addr)
+static u32 s3an_convert_addr(struct spi_nor *nor, u32 addr)
 {
-	unsigned int offset;
-	unsigned int page;
+	u32 offset, page;
=20
 	offset =3D addr % nor->page_size;
 	page =3D addr / nor->page_size;
@@ -911,6 +910,14 @@ static loff_t spi_nor_s3an_addr_convert(struct spi_nor=
 *nor, unsigned int addr)
 	return page | offset;
 }
=20
+static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
+{
+	if (!nor->params.convert_addr)
+		return addr;
+
+	return nor->params.convert_addr(nor, addr);
+}
+
 /*
  * Initiate the erasure of a single sector
  */
@@ -918,8 +925,7 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u3=
2 addr)
 {
 	int i;
=20
-	if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
-		addr =3D spi_nor_s3an_addr_convert(nor, addr);
+	addr =3D spi_nor_convert_addr(nor, addr);
=20
 	if (nor->erase)
 		return nor->erase(nor, addr);
@@ -2535,8 +2541,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t =
from, size_t len,
 	while (len) {
 		loff_t addr =3D from;
=20
-		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
-			addr =3D spi_nor_s3an_addr_convert(nor, addr);
+		addr =3D spi_nor_convert_addr(nor, addr);
=20
 		ret =3D spi_nor_read_data(nor, addr, len, buf);
 		if (ret =3D=3D 0) {
@@ -2680,8 +2685,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t=
 to, size_t len,
 		page_remain =3D min_t(size_t,
 				    nor->page_size - page_offset, len - i);
=20
-		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
-			addr =3D spi_nor_s3an_addr_convert(nor, addr);
+		addr =3D spi_nor_convert_addr(nor, addr);
=20
 		write_enable(nor);
 		ret =3D spi_nor_write_data(nor, addr, page_remain, buf + i);
@@ -2748,7 +2752,7 @@ static int s3an_nor_scan(struct spi_nor *nor)
 		nor->mtd.erasesize =3D 8 * nor->page_size;
 	} else {
 		/* Flash in Default addressing mode */
-		nor->flags |=3D SNOR_F_S3AN_ADDR_DEFAULT;
+		nor->params.convert_addr =3D s3an_convert_addr;
 	}
=20
 	return 0;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 6c5eaf607b50..f9f1947f7aeb 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -237,13 +237,12 @@ enum spi_nor_option_flags {
 	SNOR_F_USE_FSR		=3D BIT(0),
 	SNOR_F_HAS_SR_TB	=3D BIT(1),
 	SNOR_F_NO_OP_CHIP_ERASE	=3D BIT(2),
-	SNOR_F_S3AN_ADDR_DEFAULT =3D BIT(3),
-	SNOR_F_READY_XSR_RDY	=3D BIT(4),
-	SNOR_F_USE_CLSR		=3D BIT(5),
-	SNOR_F_BROKEN_RESET	=3D BIT(6),
-	SNOR_F_4B_OPCODES	=3D BIT(7),
-	SNOR_F_HAS_4BAIT	=3D BIT(8),
-	SNOR_F_HAS_LOCK		=3D BIT(9),
+	SNOR_F_READY_XSR_RDY	=3D BIT(3),
+	SNOR_F_USE_CLSR		=3D BIT(4),
+	SNOR_F_BROKEN_RESET	=3D BIT(5),
+	SNOR_F_4B_OPCODES	=3D BIT(6),
+	SNOR_F_HAS_4BAIT	=3D BIT(7),
+	SNOR_F_HAS_LOCK		=3D BIT(8),
 };
=20
 /**
@@ -496,6 +495,9 @@ struct spi_nor_locking_ops {
  *                      Table.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
+ * @convert_addr:	converts an absolute address into something the flash
+ *                      will understand. Particularly useful when pagesize=
 is
+ *                      not a power-of-2.
  * @disable_block_protection: disables block protection during power-up.
  * @locking_ops:	SPI NOR locking methods.
  */
@@ -511,6 +513,7 @@ struct spi_nor_flash_parameter {
=20
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
+	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
 	int (*disable_block_protection)(struct spi_nor *nor);
=20
 	const struct spi_nor_locking_ops *locking_ops;
--=20
2.9.5

