Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A9C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDE214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oZ9ffEDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfIQPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23614 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfIQPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:33 -0400
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
IronPort-SDR: V635VAapn86RWzgJFirnhBhzoeC53ADoj4zZvwshLM0ziZmsDTTOQEEaZZ1/25w76LMoyTgsRJ
 ROFyli7JjwIAEC3LJ/ICA/sv5JVdLEzeq3ynkGW0t2/DAxR3DQe1syiqaAdvDPkobph3zGZIbn
 9pw9us6ddGEoB8rGgeVesJqq/riyDVxaiIUCb79P4gprHTXd7EncmmoDjS/HyjV3sjkEp0wjJH
 t5hQfbIlPtJpT1ptmYxZWKmvDvqnsJjRQSv+SiqenyzQYhCnhAqxNUGZM1aUtSAg0eOuoAXIx0
 roE=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="50797902"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:28 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icVwCYGyUmVVphb+WxWUvsJPvEK8swDaV5mchKgLs/taiggCVbokSfnx43g+CrAZeG4DwsIxvAQoDHrfuiMWS3sEjiBlR0pTkgWcshySgQI/KDwIrB7fZXP+FJN3FMCv/5vXoye6vPxGRoXsNdmxL/bqM6sq89C0QlH86mRm7ELtkcRxEdNctEpc6lvDZNU4bZIEkpXoClmMcqEFwncgKJGWf8bNxHYcnowFVo5m/RXX/dvSZ5G2m+eCNo0XkZizadE2FBbkDkDsf0EfThHfq0nrwYBX9A3B0RXSTnp92qujDlOpImh6SONVvsuJSyOp4eWi1fpfhNuOo90758H+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JzIz15MQ9vdHd2NwVY1HrpfTldHjrl66+T2PZZcLCE=;
 b=XDQn28/PqquUYvkp9urEC2typjVXIX4E2YznAZNgUwrdSwzC6Gix0lmPpNZrRFcTP0lswM43Q1racMn28w1k8rAFsn3HYJ5z748g2UD07MUiIvoW/R8A8B9jiI8tmXxaYnSQb9G6GcWiKO4+8rtaBRmeMtuEUmtwDf04uD42BO4fkRn4tgdtRfuptsOm0/xPcV50b6JsOnelqLxYC6Rvf6QTv54G9xF9Fb+BmyFRePXryi36GoGFvhGIqlluFHmgMigQwwCC01rmEqifpP50etlXLiXeSRy5ebhvQsy+bmQsvOnBal8kKs2bTQkz3rBXalx9gFvPC/qqq8nK9t2wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JzIz15MQ9vdHd2NwVY1HrpfTldHjrl66+T2PZZcLCE=;
 b=oZ9ffEDsvQRSiAbiIIu32JbOB3gM4ltFmq1rRddNoWVovpCRsEPtvI/VAQNR1rSy/P1OJB3Rw0T5CyxV3lNsQDFbnf1cnvNsXOGu5tDMWd7ehx3oykarf4l7mxcl0IBPeHsN4DS13XfG+5gakwi7WDz5YX0FaaG0JLzVViZ+M6c=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:19 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 12/23] mtd: spi-nor: Report error in spi_nor_xread_sr()
Thread-Topic: [PATCH 12/23] mtd: spi-nor: Report error in spi_nor_xread_sr()
Thread-Index: AQHVbXBOn4bEa8IcTUGlZMo/2pu78w==
Date:   Tue, 17 Sep 2019 15:55:19 +0000
Message-ID: <20190917155426.7432-13-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3cd80f63-23e1-45cb-cc2d-08d73b877074
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984282CDFAA1E67617C7A05F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qlGX1dM3L1Dwmk3fJ86KlfFRrHpd3Tx3FHVNAYnb6YXofbowXr9vO8PZzOwOCxnXO4LKCOTXfc5Kzdx76O9pZOdmwOFlyplgKlUYnRX7ls0UrQJsi+unZ/N94eEBkKveOuqYtwSY5eOfavamPqoPegW2PaR2frzmbBFlBOF0+SJB13xur9syZvqqrHjSqDr1/J7WAnhLGtCglSfpjYG0c7C7R07C5cJl2m0Uy0F/1OHWsBieknJ7jm77s4QJwvIKI9gFeUsRK3NIrM8LokUY+4IP2YLYUwyIdm1T4sSh6S6k+oLOfc3m+bd+zsZh7uOyU6suHk6SBiIP3XXU4XeStSru+SiqQ3lxAhKPSG/zybEb1Tvr4dVaxMmyCHbuHP4Aoe7oVeOyhmN5qQjnKFmFEi+b6XCCq9UDYuK0chVBLFM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd80f63-23e1-45cb-cc2d-08d73b877074
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:19.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1QYb2RAf3TK2/z2m92GWjrDsJ9nKKfjV4QweAn+hMxbAXApE2Br+wuvA3N1MgLfobgvmRTc2z/Lr8V1nxBXa4vV6iLkC7NY5igRADfrgqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Report error inside spi_nor_xread_sr(), to spare the callers of
duplicating the error message.

Add method description. Drop unnecessary cast to int when reporting
the error. Comparing the return code with zero is enough, drop the
checking for negative return values.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c06de7ad6434..a34614753d7b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -537,8 +537,17 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr=
)
 	return ret;
 }
=20
+/**
+ * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
+ * @nor:	pointer to 'struct spi_nor'
+ * @sr:		buffer where the value of the Status Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
@@ -546,10 +555,16 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *=
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
@@ -557,10 +572,8 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	int ret;
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+	if (ret)
 		return ret;
-	}
=20
 	return !!(nor->bouncebuf[0] & XSR_RDY);
 }
@@ -2800,10 +2813,8 @@ static int s3an_nor_setup(struct spi_nor *nor,
 	int ret;
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+	if (ret)
 		return ret;
-	}
=20
 	nor->erase_opcode =3D SPINOR_OP_XSE;
 	nor->program_opcode =3D SPINOR_OP_XPP;
--=20
2.9.5

