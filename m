Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46511C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0D8217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="p3Weck66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfHZMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:13 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:21588 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbfHZMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:07 -0400
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
IronPort-SDR: dsbXaXnPmw1YMfA3himaX5vdbvrj5JVGScoGN0hxPeBOL2LmmEplF8+0pVvd5VogICZ87EZW1P
 JO+4BGeTTWJ75i4PFwufFZF2aco8wl3lOeJwha8fvjjmCtJtQp6V2c26MexxDVfiBucsvtqHvw
 iQVPukzTaNBKPm+8Rx5nrYWvvaBV0KrG4GerVkcZbJJfnATrUeDq+ITYS1qJdgA15ucDdMmdi7
 a5u9CgANV8SwgauGsWUlkJbma9NkUfDhh2EjdkAU+NOutFf/J0ZnCFBD7LNIDtO4X4i37rxDK6
 8Co=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46588879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNK94SrAIOjcfGYOf/jRPm7ZFBdSoSFjlNAPs/e/QOIlMreyfqAAaL7DO6IceHLjkmiTwS92cZklvTxFLun7B8ratOeR0mi093s7h7I99GqJMR7X9VUwR/GZwJ+jkx7yO8mMjjJDAe14rJEqH4Yj3JNINKTBGIOHunh4nujXF+APCvhDqnCkqrrBJqcaNBERaeeAIib4EOr2E9mguSANDlK65TDZ8fHihzYRNLQzo6So32EtZkDgydue12adWKXAfuAeAUErQrZub4jQYWtJmopuCVy1Xis7wusQj1ctDRhyhYHDkEIMN4DGFTaQJJ9tVRhYpQfv6MWXY74ziDwqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEa3ZqPuW8cpxsoaY8eDsDepH+bxZ+OldsB82OwGtv8=;
 b=ki051PhbloEF/sXAivVIiZavi/DygGiH0RppeKbr85+tqvX7/sedpPt7MykAfGhCpiv2TgBMh+tDbOxW58VSH2pDPt0VkkLj8uE7FuKDZAskXxJib68XuR4YOq+MvpA73ADUAnu6ocl2CtDIIcpYRlXILEgWuYa/PaAnPt+ebjWgMu5+mGzMP73aObUzplY+7Pkw85VD9t10ao0B0/pTgkUOFGX2k5oseoi+5VoXIwHUCDYVoNDc6YC8BWJzjjBrY25o37lVHGyKKqBcq1BHCvU0XdWSzT5fnxJBhb4Dqmg/4U7z9ly3xk+CqedFXbW83fCPKQgfR2h2e7l28n7XNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEa3ZqPuW8cpxsoaY8eDsDepH+bxZ+OldsB82OwGtv8=;
 b=p3Weck66EsMsI8m7a3Em7l5ASR+nm81CXVGiKoMd7yrXLo+hprLnu0alnne9Qmr+DXk0riC9WdekXpJ/oLb4am4mvI/0wCyDLsXDmw9g+EqgXMLzQOimuvK6HilXhhuTRWng1D9wHPjGdHGlrIwEd9jnlEDKqW//Wu+Prr9c2G0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:05 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 13/20] mtd: spi-nor: Add a ->convert_addr() method
Thread-Topic: [RESEND PATCH v3 13/20] mtd: spi-nor: Add a ->convert_addr()
 method
Thread-Index: AQHVXAcI2bVIejaYCkq3RWETUNYd3Q==
Date:   Mon, 26 Aug 2019 12:08:56 +0000
Message-ID: <20190826120821.16351-14-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:28::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14e86f13-3029-4b26-20d2-08d72a1e2b4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3678129B2B5C30D2C651BDAFF0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(14444005)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(54906003)(52116002)(6666004)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 81hAESR8qciIz4XYi31ZHvqfPbi+LCWu20UMuaYCA2CSmqQDDKWhwK2vZ+pO5zuYDr19EoYSwSnNh1hWbbjuX4+20b0/PjSbVYFFomc65lKz8I1ymgpKSqcxrv6pCdv+yFIdw/YQ5kxsqaLF9lu+rl40oAsjT5g/nV9Eba4TS5e/JqhU2RqwO3loh+ACBRTNH/USf6QLDCgLs+E5atAReZf/JHRJ9WH5EZpgcAzV0DSeZ+xTy4jSzXyffuJDX7arY55wFFnrIqRISOMOEauBbaJiL0sQk2z34rN8bM43iVqxus3X66EzQpHUb3cqUilNZqQzDoBo35TWzvuj/8tCqEyxUEUmWImHasJn0740gZNuKNfv2BazTBxCX8CCs8xdsROloankFESjimRn7yHxgQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e86f13-3029-4b26-20d2-08d72a1e2b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:56.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNKfbgao3xShCIJMYW2wKarIIXI5XmILfVmZCD6gj3zZ0Z+u0bqziUNINnFFmq/QvP8fGXvzQz+uEzhlL3HeQAVW7tVtf/9zByweDXRBq7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
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
v3: no changes, rebase on previous commits

 drivers/mtd/spi-nor/spi-nor.c | 24 ++++++++++++++----------
 include/linux/mtd/spi-nor.h   | 17 ++++++++++-------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c862a59ce9df..b96a7066a36c 100644
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
index ea3bcac54dc2..35aad92a4ff8 100644
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
  * @locking_ops:	SPI NOR locking methods.
  */
 struct spi_nor_flash_parameter {
@@ -510,6 +512,7 @@ struct spi_nor_flash_parameter {
=20
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
+	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
=20
 	const struct spi_nor_locking_ops *locking_ops;
 };
--=20
2.9.5

