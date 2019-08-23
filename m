Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D052EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9900B2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y1FqR6/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfHWQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:05:10 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:50402 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbfHWQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:05:07 -0400
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
IronPort-SDR: bg3oNjODo+kL5RmLVS9iKCUaG4lQ7INAzuFyRJmaarKUboaRMXrDok5Mvbg4dNL+WZfhNJC0uN
 MDe7e49d8onU+X2LddCzJp/rAbW5Z6YxhOG7Ij280dFsdleWTEqaAlRSYlGf4ECAnYZobE4b7D
 LjkFVTDzzN1i+qlv/luR4dk477ellmjcBf7Vafd6RbT87Yf+PfCrIVqiFGm3Co+9G2H7TARHnM
 F6O4cCDmD8Ff0eKYITK6EvlWg9veVnPClcC7S4/zrsWOYbTB9A3279v1SqgbrhutOPfTx70UR4
 TYI=
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="45399011"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 09:05:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 09:05:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 23 Aug 2019 09:05:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+/GJkFdjCcyHeMZG+6AxWdlexYwV0QVNnmtetzfM6PmA5m1vdTHOfX0NUOLovnAO5GCQ5mw2rmz8Ma+Pus/gLncRJCy8sKWA2KCRfOTuvKUJ98MBZyF2P9xyXjJqkd7aqVcDDWMheR1f0UzOu6IkzduKHzOAN/6oxY3oawaffC6JLOI/zYgSPCtEdNLj0RxiHDoouwS2LHTwdY1uTwjNlp62v08MvZL0maU+9FNAdY8R0uJi3Zf6f1YkqKlWAmnEuyrVn6g8ZQ518Z9cfSzv0DXQalbko2BflDk5BkzKOtG6hvFnXHhE46SG9hUOjKIZ6wDTQNH8VwKGd39F5Gy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKijxF2lJCf5zJ0A3ZZWwTS7CwKQ94QVBsOC23vqurk=;
 b=VYrFHg9C3pZ1jvXSzcyAqdRbdvlXJNMQE5zYu+Q9uZ61mW0zTk0KKIUoXAs2DuIsG+sYWVkVVAxdsDYuCiStqlPK7mNvcGG7hWsfQUbYMVeEuNzBgcs9KWs29bW3fbMqDtnasI+P32eO0hoDJqLq+V/yeF2zBjU+QsYOS74XqVaGzemjLgo7O829ljEX7RVdZ1h01NcKb9mwUbDwVJRgFeS0T/OMKUz1kwMr7J8eWbGkcK9k/BGqZ8BlJlPnPLeR3zhsZePEQisf0gOBhZkKZ1fZGbgeUZNr5AUC+B0vKbuBg8qLiQ3uaW9wdf9jfILJI/jbfvfJsa074M5XnijD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKijxF2lJCf5zJ0A3ZZWwTS7CwKQ94QVBsOC23vqurk=;
 b=Y1FqR6/Pj17OBqMupif/oj0jiwx0wFo2IhXJSZO0cHVesuxg7dZqTAri1gqPvSZbYa9Vt/VUdQvrCY9dm84Yopt2zdfGsIFQ3sBqES/3P+qNCKE4eEk5eYvKi0TzYcGbSAsfX5EsDZlqvynYXHi1QbyN8ChxD9P9ecxFFq9Ej7w=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3789.namprd11.prod.outlook.com (20.178.252.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Fri, 23 Aug 2019 16:05:04 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 16:05:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: unlock global block protection on
 sst26vf064b
Thread-Topic: [PATCH 2/2] mtd: spi-nor: unlock global block protection on
 sst26vf064b
Thread-Index: AQHVWcyGlZtna2CbFEaZw6TMbrOfRw==
Date:   Fri, 23 Aug 2019 16:05:04 +0000
Message-ID: <20190823160452.14905-3-tudor.ambarus@microchip.com>
References: <20190823160452.14905-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190823160452.14905-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0077.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66cc1732-22e2-43e6-4bbf-08d727e3a92e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3789;
x-ms-traffictypediagnostic: MN2PR11MB3789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37897133A592E90758C4EB39F0A40@MN2PR11MB3789.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(52116002)(110136005)(66066001)(316002)(2906002)(8676002)(81166006)(76176011)(81156014)(5660300002)(25786009)(102836004)(2501003)(6436002)(6512007)(14454004)(50226002)(8936002)(6506007)(386003)(478600001)(99286004)(4326008)(36756003)(486006)(66446008)(64756008)(66556008)(11346002)(446003)(107886003)(186003)(305945005)(66476007)(26005)(66946007)(53936002)(6486002)(7736002)(3846002)(86362001)(6116002)(2201001)(2616005)(476003)(71200400001)(1076003)(256004)(14444005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3789;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PMBmyzNw0jHnluof769IU7cxRvYdvBrHdBR42cF+mDkN2wqZ03HGwtB6JN162xEAuFVbf15geHdBnKqX8xK/K5zZYZWSeicxm6+lLri4Q3ExlaNJWfmj0/V4stIeuYZt+5pSbaYK3k6w7ZXg1vc17oQDQ12u6phP48zmQvOXlte9atA9dm6+qxGvqxDM1lhpl78uMOUvws7IsJJt0caVJvu33PGGA+7ed3MKnWlZHU2atYXYHOvGdLPZHaRsAMnX7hzVYabyNCMlHH+a2snC7xcRsvBE8OAXmtScYldqLnIwBaLUZMjknO8C8wWqtfIobOiuFnVJPEBXWvI58GBzkmri6EzkQ1xBJFFu1SzJgkBH5xfkFMVeznA4768GfiaJotdOLKi9O/IXat563bAdZ0COFbzkx4yuRCHHbKr8MZk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cc1732-22e2-43e6-4bbf-08d727e3a92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 16:05:04.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2Se/zG+NKQRifBLP8dCwOJr6U4vNMiA5t9vTNE8Z+SSRMEoQkiODqOeF4SqiDBjOQTRRCO7jIzCo6vD6GDMsHAskkmyTwt91/+8n6HBte8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

To avoid inadvertent writes during power-up, sst26vf064b is
write-protected by default after a power-on reset cycle.
Unlock the serial flash memory by using the Global Block Protection
Unlock command - it offers a single command cycle that unlocks
the entire memory array.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 08ae45fdc44a..5c18fd0c7fd2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2398,7 +2398,9 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K |
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL=
_READ | SPI_NOR_QUAD_READ) },
+	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      UNLOCK_GLOBAL_BLOCK) },
=20
 	/* ST Microelectronics -- newer production may have feature updates */
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
--=20
2.9.5

