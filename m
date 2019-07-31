Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A08C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916022089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="uH0E9XUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfGaJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:12:51 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36103 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfGaJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:12:51 -0400
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
IronPort-SDR: 2VToodoYeA4ELyFkqytApnqFDE5AFd6jOWhZ2KdXBvwCKKC3A3Kx4FoGnYe9W8UpRpm5A7jkIx
 I64f3InapddNAHA14M0YswCWkN/vRB6WhqtiSdIG6KWWFcK/wZL5H2JkOnv+aDI73E26oqneb5
 c9n8/EUC5yco96QaahZDVc/nqRNtDHPHpa10WrJIRxZxD87ZjZgZwUsBBMWceXBbJcDg9nTLfK
 CsXJ9PvAfqDxo4t289lwX5ONXDDOwnUqdAxK1wlsPgd3LmF2krT0OrtEOAj9IT2Lm5M7v0qMQl
 MSQ=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="40401035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:12:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:12:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXEXc/93HiONigmj6c3oKsZIbX4p/FEGzP52Oy1P+fI3ReRJrTD4u5G3CRkXmqqH/8mQdAj4ldtsGK4HYsQFz5ZdvDm5PYF1jzJDdImCKQz88dS+19cxGNDAQCRF97PVzBAEe8qx3HRglQ3xrIVsU3d/sLvepmgcsfb8LjH1HsvYzwU7bCkrgXAak10NCNoM+o/RbdOzuOcetggd7gwomE95sRsb/UOQrJP1po3Kv8qxr3jmkgYPU6PqQbbffuDkFiHaOsbI+BzJ6ImTIWezsmmnSZiT9lUJkmD3Ij7tR0sOXGDfiVytbSCiGEJVXH4GPvh8xL6RXMq4FvAf0gOlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg1WU0iRP+9iGB8K1aX6SAI4fd/RmXUOoHnvhLMOtVE=;
 b=nlctdB19WUmndgsmpcDOWyPBrvgsE+bQEYJPbdJDr3gljcXUXBCfCUZGBZoWkW3pxtp7No3J1+gX7pMpmHpGQ3bwPduMqiOIWPbKl4uKivA0QsU4zA6GsFaWl39oOgLvAkc6uU4zku34LoE27f7xqT6HfyHlGgpTCSI9p0uzDG3J4lQ/msF4SBLqlDUmlqu5kq1HuABNn8d31Al5XqrocVbiGAVpng6BrAR2QIzuo7Zs13wdHvdnydHf0qKYvST11/QKOKcEnRudjbZUqIp7VBaNpxWB6ik35Ab2pNm8Y54p33iPPYyFDjsZzw/DrnP/yX5Dvge8turifNF2NW3Srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg1WU0iRP+9iGB8K1aX6SAI4fd/RmXUOoHnvhLMOtVE=;
 b=uH0E9XUuNbQ8Z460IUvLFutaKmVq7MTxqmcxZO4EyIBi/REMwKE20PAntlr1u/nAZ32bgn5icrWfNsN0OTFUGQVKgvnaB5xZ8DuOvPvPxHVhWdB0IRMORbyyIEbU9Hn5H/ZJQu0sz9O6gqo8B+w9WOJjF7CHpvAi36NXelKNsLQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 09:12:18 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:12:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Topic: [PATCH 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Index: AQHVR4ANBFbmyZuDXEi4qln0HD1tDQ==
Date:   Wed, 31 Jul 2019 09:12:18 +0000
Message-ID: <20190731091145.27374-7-tudor.ambarus@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731091145.27374-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0130.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ff4768-7759-4998-4b61-08d715972fd5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4414;
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB4414B1F1FE955C056F684631F0DF0@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(14454004)(26005)(81166006)(6116002)(50226002)(76176011)(5660300002)(66066001)(2501003)(6512007)(25786009)(486006)(102836004)(107886003)(2201001)(110136005)(305945005)(3846002)(7736002)(68736007)(53936002)(6486002)(478600001)(86362001)(71200400001)(71190400001)(14444005)(186003)(476003)(256004)(8936002)(6436002)(7416002)(386003)(52116002)(54906003)(316002)(66946007)(81156014)(11346002)(2616005)(2906002)(64756008)(4326008)(446003)(99286004)(36756003)(66556008)(8676002)(66476007)(66446008)(1076003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z+1cTLumtkQnvZJJIVvBDlJGGhMzeErIFZVQ/jwYR7aQEzeVVZqs//EEyNl02BfcesksKU8/TXN8wrqniCE5tGPUs1SVwjizq8JOARNBbyyYgMbMNzD0DSLGBqXeiNe14MoDxOwLMu8F350+rrsGT5s3IgKul3ExOdo8fPEGggoPLVApuqwTdIT+uc1eOUMinMzCufywUPqoNoJ1ml0AI/9pKwT6dDQfTKbFHwObgghFRfgSDwT2IJSEQvmqt107CV9uMbhOdR/glZsCxePe3H5lIwaJwKZ0QYrmbZ4hSmtuqUVu2//9wK/XUJ19CcKxL3Ib0WpVNtGPQKU4vAz9SXNkUZv6sXXzY0O2nShmd90eb3Tn6kEQZ6gLNsmdK7wesg94n74k3nFczvJ/7CstyJ5EWM6wFgEcnXOwtxAkAvI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff4768-7759-4998-4b61-08d715972fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:12:18.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

S3AN flashes use a specific opcode to read the status register.
We currently use the SPI_S3AN flag to decide whether this specific
SR read opcode should be used, but SPI_S3AN is about to disappear, so
let's add a new flag.

Note that we use the same bit as SPI_S3AN implies SPI_NOR_XSR_RDY and
vice versa.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5fea5d7ce2cb..01be6d49ce3b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -213,6 +213,14 @@ struct flash_info {
 					 * bit. Must be used with
 					 * SPI_NOR_HAS_LOCK.
 					 */
+#define SPI_NOR_XSR_RDY		BIT(10)	/*
+					 * S3AN flashes have specific opcode to
+					 * read the status register.
+					 * Flags SPI_NOR_XSR_RDY and SPI_S3AN
+					 * use the same bit as one implies the
+					 * other, but we will get rid of
+					 * SPI_S3AN soon.
+					 */
 #define	SPI_S3AN		BIT(10)	/*
 					 * Xilinx Spartan 3AN In-System Flash
 					 * (MFR cannot be used for probing
@@ -4818,7 +4826,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	 * spi_nor_wait_till_ready(). Xilinx S3AN share MFR
 	 * with Atmel spi-nor
 	 */
-	if (info->flags & SPI_S3AN)
+	if (info->flags & SPI_NOR_XSR_RDY)
 		nor->flags |=3D  SNOR_F_READY_XSR_RDY;
=20
 	/* Kept only for backward compatibility purpose. */
--=20
2.9.5

