Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D61621670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nX2vQPK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfHXMAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:00:54 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26836 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfHXMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:00:48 -0400
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
IronPort-SDR: W/+GXEIza1wQWQ0YIu3evWHKGDAqu35weO6b8VQQcC49uY72K+BmYj/IZPgjRSTcfeS949XY7E
 A0kaCMkISXAlgkg5XcrJAVc7Hi5KXRd9c53Qtus722geDJj1OFztP9Y+oMOeFufhc67O+LzZOk
 cpUMTBSXJdnX5KRLlRfhr0jUq7SvB843Bi36Mw7v39qhNPbVUnoffkx9KYAEOwXZLoo8CdYYG4
 PQ16KpK09Ql4/8qEym9t+L9BwrL+XhJ7mNRxjKV1iaX/aksFYV1aTdhInhKxWndQ4VcA940VJC
 SZE=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="43547618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:00:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:00:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMSaBQRYS7fwoiwimD/DnYO7SUVVRZ0qtkRwrwqdPNKjy/N+yHY8n5uUpt+lAc1h06hJ2CirLU+t0j6f+8tfq9/oN7gxcy0RF5vBJdc1ZyQ12oGReUhPhkZi/PWKLMErzgmVIqGya5LCr7a2yao1jZ5TlCarXwZLAskJPJx+jxcmDcyj7j8fDjV0hOMyFszgZXysVY4Akrr6c9H1Eg6aixOBeYKl6ceAOMhxr2L/F02MmxtfBnurCx8T8oW07GRFT41dtM9r+Y7snSmUxVdgFySj5OJugslFVHK7uNwSWAIqRcsuXpTle51ErC4XdaQDhLt7fkiVRW/+SqDpjSsUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzHRS73cdgHcpQi1l2XR5C0QxBNYK15VCVPKJbgLFkE=;
 b=akPnlMqusHWGk6tsUc6QCRYuh1ZdW23M9hUHgRw/ywdq+0beDaQ2u3Q0G8xtG3Xgf8dmYoPC3VqOsjqQSgWVUpNZoDjZkUiCEDUn46ak1s9HtqHUkfMm1AztkZwmC/pvKlOQPJ152/rsQL59sEXqovu4EGX9J335bWBy/Ti7tzgQLDtHJO5xQl1apCrEikMIb2z1N2GWuZ98N10Z5qNZy7tO4MfQG1OSWJgusXKHgvCF2xj8noohfLXI4JDq15qughMIBtL1jp/avW3V3ZaDHDaKG9m6X+lAsPltyU/V2b3+UlwbYDj0BUYCsy8zw4lVzaGuJB+art5tB9ivoQxkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzHRS73cdgHcpQi1l2XR5C0QxBNYK15VCVPKJbgLFkE=;
 b=nX2vQPK4mnludV7z/29GnYoD3XJdQiKYR6IuWiBWbLPXlFOnZVYT2QPc6w9o9eN/k0Bv48K85U7gNBBqLPDHBl7xSOcJm42cJufR2biHV+ZzOgDcUMpium1cr4hh6cQ7Kvdg0xqQkHqWG0xaa8tNk0KM+BYsIqYX44QDBbDa2YM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:00:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:00:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 5/7] mtd: spi-nor: Create a ->set_4byte() method
Thread-Topic: [PATCH v2 5/7] mtd: spi-nor: Create a ->set_4byte() method
Thread-Index: AQHVWnOP59CjVg8FSkOG/7b87ZQTgA==
Date:   Sat, 24 Aug 2019 12:00:45 +0000
Message-ID: <20190824120027.14452-6-tudor.ambarus@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824120027.14452-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0194.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f36924fb-37c9-49ed-390c-08d7288ab1e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984F3D2325B1A0793120EECF0A70@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(110136005)(25786009)(26005)(446003)(4326008)(1076003)(256004)(316002)(386003)(2501003)(81156014)(6506007)(8936002)(14444005)(64756008)(66556008)(66476007)(66946007)(6436002)(81166006)(66446008)(8676002)(2201001)(54906003)(53936002)(76176011)(5660300002)(86362001)(6512007)(52116002)(71200400001)(14454004)(11346002)(66066001)(476003)(305945005)(6486002)(36756003)(7736002)(186003)(71190400001)(478600001)(2906002)(102836004)(99286004)(50226002)(6116002)(3846002)(107886003)(486006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TIV+cwLUQJ7B0RdDpnsy0Am5FjLv4yvAygrgNMzmO9rnUvBzER/7kKvmHnA0nDVjZG/NKiHK+mnFXceJZ/jArwaPKC2pN2L8PbZ/5vbYzB6+SUvPKy4ClnLHNp1ezAWykAw36tgg9SvFIRF0L2XhWL2eQiZe0d88gv8tUsQIxPS8FlZ+D7+3D7169Tue9wtSJHAeefXAzNjtYfhlI6TfiFoG9APoTm4Tzbfb9phm19haWK3jy+rEJGKKVInypaZATuUY27Bh5s2ouPQ/1CucPyYlX0Ltjt5JL2UEoCxyI+QIN9OwX7xODvzPLcP2rgVM6RLKKLxXlk5cQ/gdUkIFfinewq9mqyBDO+pzqNfeuBNye15743Ua+ObiJ8R40hzDocr+G1L4MwnBs2vPzjCEFvGQEYKWFHkOYuqO2BZwFW8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f36924fb-37c9-49ed-390c-08d7288ab1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:00:45.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLNMRB3zllFUtg4fvybEA7PjSQ2/vEzocKbUqwQYuWIeYVICFRwUMA0vIN9O8eO5BnWYTam9AdP//ntRqdjJuHXqEdLYReXpm2fH+4sgns4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The procedure used to enable 4 byte addressing mode depends on the NOR
device, so let's provide a hook so that manufacturer specific handling
can be implemented in a sane way.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[tudor.ambarus@microchip.com: use nor->params.set_4byte() instead of
nor->set_4byte()]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 76 ++++++++++++++++++++++-----------------=
----
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 93424f914159..1629584be30e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -633,6 +633,17 @@ static int macronix_set_4byte(struct spi_nor *nor, boo=
l enable)
 			      NULL, 0);
 }
=20
+static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	write_enable(nor);
+	ret =3D macronix_set_4byte(nor, enable);
+	write_disable(nor);
+
+	return ret;
+}
+
 static int spansion_set_4byte(struct spi_nor *nor, bool enable)
 {
 	nor->bouncebuf[0] =3D enable << 7;
@@ -667,45 +678,24 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 =
ear)
 	return nor->write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
 }
=20
-/* Enable/disable 4-byte addressing mode. */
-static int set_4byte(struct spi_nor *nor, bool enable)
+static int winbond_set_4byte(struct spi_nor *nor, bool enable)
 {
-	int status;
-	bool need_wren =3D false;
-
-	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_ST:
-	case SNOR_MFR_MICRON:
-		/* Some Micron need WREN command; all will accept it */
-		need_wren =3D true;
-		/* fall through */
-	case SNOR_MFR_MACRONIX:
-	case SNOR_MFR_WINBOND:
-		if (need_wren)
-			write_enable(nor);
+	int ret;
=20
-		status =3D macronix_set_4byte(nor, enable);
-		if (need_wren)
-			write_disable(nor);
+	ret =3D macronix_set_4byte(nor, enable);
+	if (ret || enable)
+		return ret;
=20
-		if (!status && !enable &&
-		    JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_WINBOND) {
-			/*
-			 * On Winbond W25Q256FV, leaving 4byte mode causes
-			 * the Extended Address Register to be set to 1, so all
-			 * 3-byte-address reads come from the second 16M.
-			 * We must clear the register to enable normal behavior.
-			 */
-			write_enable(nor);
-			spi_nor_write_ear(nor, 0);
-			write_disable(nor);
-		}
+	/*
+	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
+	 * Register to be set to 1, so all 3-byte-address reads come from the
+	 * second 16M. We must clear the register to enable normal behavior.
+	 */
+	write_enable(nor);
+	ret =3D spi_nor_write_ear(nor, 0);
+	write_disable(nor);
=20
-		return status;
-	default:
-		/* Spansion style */
-		return spansion_set_4byte(nor, enable);
-	}
+	return ret;
 }
=20
 static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
@@ -4153,11 +4143,18 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 static void macronix_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.set_4byte =3D macronix_set_4byte;
 }
=20
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D NULL;
+	nor->params.set_4byte =3D st_micron_set_4byte;
+}
+
+static void winbond_set_default_init(struct spi_nor *nor)
+{
+	nor->params.set_4byte =3D winbond_set_4byte;
 }
=20
 /**
@@ -4178,6 +4175,10 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 		st_micron_set_default_init(nor);
 		break;
=20
+	case SNOR_MFR_WINBOND:
+		winbond_set_default_init(nor);
+		break;
+
 	default:
 		break;
 	}
@@ -4222,6 +4223,7 @@ static void spi_nor_legacy_init_params(struct spi_nor=
 *nor)
=20
 	/* Initialize legacy flash parameters and settings. */
 	params->quad_enable =3D spansion_quad_enable;
+	params->set_4byte =3D spansion_set_4byte;
=20
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
@@ -4610,7 +4612,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		set_4byte(nor, true);
+		nor->params.set_4byte(nor, true);
 	}
=20
 	return 0;
@@ -4634,7 +4636,7 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		set_4byte(nor, false);
+		nor->params.set_4byte(nor, false);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a3a765c21edc..012731ad339f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -482,6 +482,7 @@ struct spi_nor;
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
  * @quad_enable:	enables SPI NOR quad mode.
+ * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
  * @disable_block_protection: disables block protection during power-up.
  */
 struct spi_nor_flash_parameter {
@@ -495,6 +496,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_erase_map        erase_map;
=20
 	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	int (*disable_block_protection)(struct spi_nor *nor);
 };
=20
--=20
2.9.5

