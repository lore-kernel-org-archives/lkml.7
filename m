Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4598C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771362089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XDJVCw5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfGaJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:18:55 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:7128 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfGaJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:18:50 -0400
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
IronPort-SDR: KcnNm5AHJ1n8oPHcMcTgeZeaqCrJpDSMKqJdJAzdDBYReHw2IwXY3Y0n8I/Bd+IMQyB1CPF0aa
 5LBHa3R8rs8YYSsI7KRkvdNJF2GLkvizz/CQishIYU5O9hl3S+O7WUuo2gdej3ekroLGMg6pku
 oa9+tawhEfyNw3gh9ielGAgezStJAgLmIFkNiK6D5HjjFC2qu7MVmmmn14wIyx6V8u8265Dphz
 Pjo714ZI+9A74trnrHfA2sp8suUG4gfnkSfVGb/QwsliggBgHi8baRcnAHBbt9JEymBNJlOg76
 35M=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="42632137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:18:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:18:47 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 02:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct2eKPb4Kg/+oviPCy+qMqsc6nAFVKbiSckGWb2L/aZahAmX51coipAdlhcPS4EEts556mxGI5dAU6fGi5xnggNyDSQjDnjvs+pwOF6XOD9QPDJTCsI3zv5Zw4NJYP4NO2Hyaun9dKeYHTHX3wbohXesSYO/ezfVGJ9pNTzdKYs9TjliuIn0OyCOwNEYAtzeMwjSBKJc8xFbkDUNULXOIhS5u449H+ZJYzoODD9L9QqAs5/DK6Ipe7jUtXW3+fuv5rwy18d9Ymcqd2jlOMnzr77YRtLI/tmY9OsuuKE0z22fH3M6pD0+yqZ9bUYhem0GAWW3XodhN0kmAMf9XmJQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPfgwzHDJqRsHk7WCmq552rS8TbxTVnH++Y33LrGews=;
 b=V4M/KQZHYvZEY+O9QfckRAM1hR93+GpQMF559YMJkMFuighPT2FmrM0zKFanqVbrIoI6K9sDe1PP15VDocwohPxcunQDS22DVXd30tESPO5x2slIgmbGZ7QA0ZQkUQwCRh4hbXBtWv4HdC5STUpRg+fFarq71A7zWe1WMMKoai15JcFK1gLtOsplJ6+paEsXf9baWt8Q7eR1MT3Qt2ggO8CSbwnetyBw5lbZWw0vF0/0no4jMsV1wbQ5WWxWWYlF1+WAc8dz2206G4jnu7d1SK2+j3pcoDz0zh4KGjlkU4e9wAE4B8SINtCaPs0Lb2vQr1BDYn3gV0/urB2pwykeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPfgwzHDJqRsHk7WCmq552rS8TbxTVnH++Y33LrGews=;
 b=XDJVCw5PW3UwaapxUqdg+GAkpbq9RrgFzTAoMm3ubSUz/iWjay1ndSmGXnvxpX1brkX2JR7mf2ub/eHKhb7dc5lCBIKj+cnqXDjtDqyG4Eduv4Hv+/fWxmMcoF0BwY7L27D52qxs+C6RO3xKk4eDmvxIuE3jHCKqCSfy3o69Uvs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3680.namprd11.prod.outlook.com (20.178.252.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 09:18:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:18:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/3] mtd: spi_nor: Introduce spi_nor_set_addr_width()
Thread-Topic: [PATCH 2/3] mtd: spi_nor: Introduce spi_nor_set_addr_width()
Thread-Index: AQHVR4D1RBgNHxMtYECno2oX6R9FXA==
Date:   Wed, 31 Jul 2019 09:18:47 +0000
Message-ID: <20190731091835.27766-3-tudor.ambarus@microchip.com>
References: <20190731091835.27766-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731091835.27766-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4063977b-01ad-4f1f-1d70-08d7159817c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3680;
x-ms-traffictypediagnostic: MN2PR11MB3680:
x-microsoft-antispam-prvs: <MN2PR11MB3680C47A8021F5F1CB5E9AECF0DF0@MN2PR11MB3680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(8676002)(81166006)(4326008)(81156014)(53936002)(7736002)(256004)(25786009)(68736007)(8936002)(50226002)(478600001)(6486002)(11346002)(2906002)(107886003)(14454004)(2501003)(102836004)(86362001)(6436002)(71190400001)(71200400001)(476003)(1076003)(305945005)(5660300002)(66556008)(66476007)(64756008)(66946007)(2201001)(66446008)(36756003)(486006)(3846002)(99286004)(76176011)(6512007)(6506007)(66066001)(386003)(446003)(316002)(6116002)(26005)(54906003)(186003)(110136005)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3680;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qqGYGA+cGBR6PfOF+nUpu7UOdUxdN4opyZ0ghBqEZBX51iP7NIVQSbo4n6bzzBbfSRWMKE58b4T3jfKH2sPrw05MwdrYkHibPUjgEL6qtl53jwxoirJ84CsjxkefWoH1VrZtTih65vx408rt0xbPPnClwuy/uuRHDTbI0gaZ0mPQi0pX0G91FGviSTuoZ1hDV0bY1N87QtH87t5LpbMe7mZQu8ekEVI36dIMDuQorDktP7HngZxAzP0FAc5lMM+cfL9Wp5r8V7HYPBXBDcNzol3UIbRKyHWGS1d4Kw5gvBTZZK6ByWV4nrCt4GPDe7UsOklO9qHTtMZ6SMo7Aa6SI5kUkHMiCB31QNzojg+WAPF7N1nIUMG7G5hDimXP7CU9WKe8HqgmXV3lTJRh5R/Vc8o1M9D66RZi39GqjDsjjTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4063977b-01ad-4f1f-1d70-08d7159817c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:18:47.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Parsing of flash parameters were interleaved with setting of the
nor addr width. Dedicate a function for setting nor addr width.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fba941a932cc..c322d7cd8216 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4773,6 +4773,33 @@ static const struct flash_info *spi_nor_match_id(con=
st char *name)
 	return NULL;
 }
=20
+static int spi_nor_set_addr_width(struct spi_nor *nor)
+{
+	if (nor->addr_width) {
+		/* already configured from SFDP */
+	} else if (nor->info->addr_width) {
+		nor->addr_width =3D nor->info->addr_width;
+	} else if (nor->mtd.size > 0x1000000) {
+		/* enable 4-byte addressing if the device exceeds 16MiB */
+		nor->addr_width =3D 4;
+	} else {
+		nor->addr_width =3D 3;
+	}
+
+	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
+		dev_err(nor->dev, "address width is too large: %u\n",
+			nor->addr_width);
+		return -EINVAL;
+	}
+
+	/* Set 4byte opcodes when possible. */
+	if (nor->addr_width =3D=3D 4 && nor->flags & SNOR_F_4B_OPCODES &&
+	    !(nor->flags & SNOR_F_HAS_4BAIT))
+		spi_nor_set_4byte_opcodes(nor);
+
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -4903,29 +4930,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 	if (ret)
 		return ret;
=20
-	if (nor->addr_width) {
-		/* already configured from SFDP */
-	} else if (info->addr_width) {
-		nor->addr_width =3D info->addr_width;
-	} else if (mtd->size > 0x1000000) {
-		/* enable 4-byte addressing if the device exceeds 16MiB */
-		nor->addr_width =3D 4;
-	} else {
-		nor->addr_width =3D 3;
-	}
-
 	if (info->flags & SPI_NOR_4B_OPCODES)
 		nor->flags |=3D SNOR_F_4B_OPCODES;
=20
-	if (nor->addr_width =3D=3D 4 && nor->flags & SNOR_F_4B_OPCODES &&
-	    !(nor->flags & SNOR_F_HAS_4BAIT))
-		spi_nor_set_4byte_opcodes(nor);
-
-	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
-		dev_err(dev, "address width is too large: %u\n",
-			nor->addr_width);
-		return -EINVAL;
-	}
+	ret =3D spi_nor_set_addr_width(nor);
+	if (ret)
+		return ret;
=20
 	/* Send all the required SPI flash commands to initialize device */
 	ret =3D spi_nor_init(nor);
--=20
2.9.5

