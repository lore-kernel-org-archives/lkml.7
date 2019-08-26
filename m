Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DB22184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="q1aRHd0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfHZMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:06 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:21588 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbfHZMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:04 -0400
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
IronPort-SDR: Iarav34xptW4JFpQenE3EXwJt2WwPZkVK5YJ4Qa4G0lH81gie1s25wcCML6zca2bCRr73htLQF
 h2cQn+12kJgjpIe6fRM6SwULvdGL/hOF2gLI5GhfeJGRbFcVzXh5A3L/lTc4BAmY0l054wzeO4
 mlu/pF5VRxg+uek0V2fF7Oux6MtYCVVrnwHetiV7hBwLzxr5W6EgEVRfxJ8otpPrdxJlwRSPic
 pyTkZPbGIa98JhdZyqC9c9aqTMGaFyN9R/DVRyT3j9uarQPN6Slz1+vcxWZyR6dLTfet+fYpdn
 az0=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46588849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:02 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 05:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B66UkkE5HO9+DlWMM5dVK//PdN9Z8S8iGi85eC2YqcQ7hm5HElGEEsdq9Bmt9zrD6bI821jgEkavi2yzSdkb4C4SYGD5/VqlXcURJ+bp/1GOcjimrOQqug9nU8Jw1OFfsihC40UfKsTohNPFjsMYut/7IROX77e6d+GjzQmmvAwDsDMu4eikutktr2xA7XmeT7RCEGFgh+mw5GcFJylFkA1kYRpmpiY9T3UUFgGpFQxQ5CKta3rk+NQ+wKjwYCAtIg61Jm/QhiUUge3Jesj64SLhsaFU0q6ncdvBWszNl8jp6b1A8dF6/oB9AXdJmTGSXfh7f8PKpD6+b/jPyxEp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr6WprtHHL/51al8o4FDNLNd4upljb84M2qM0FgfKmY=;
 b=W2j+6WDHO3e22V4XGXCSSXA7zcyxZaQwwFwv+Wh1c9XRglKqU9Z+htU2T7wvaPGRIviM75iJPeUBdhMaAJClENTzsoXW+cnk9Yd/bq2M4bHZJBRwc+QhVaskX9tcHzvxj8T63Xdd2O3VnNe3EjamlwAeczlWkB1nFilQmwVSR1RJjEUtdV9bEdTxgT3pynznCq3WTmp9k20Bs2iLncBsDOqSQqNB0s4wHzKyTRQUih6T0S21Hmv2Ao+PAiNjNwv44WPCMV0LNEtZyxYRfbSH1iu6s3VN8IA9uSIE9d6W2wLPN3PM/Xt2WyjX1fnMopb0qmoJ0s9g0HKBZpjD6NV5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr6WprtHHL/51al8o4FDNLNd4upljb84M2qM0FgfKmY=;
 b=q1aRHd0eZFs+5WNF4R0bAb6U9DtZBIXufmcDDbbFCb9MP0rC58Roa/+t+Te/WkNh2mvmWDjKOlJqOnSp6rJb0/lu2ST6IsVDjb3JImYqo9/4BsBEuUb7UyajrHwkR/Xa2196FPpGReelP6WB7BS6nJlawDNMu8vBqatWbE/kmbI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:08:53 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:08:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 08/20] mtd: spi-nor: Split spi_nor_init_params()
Thread-Topic: [RESEND PATCH v3 08/20] mtd: spi-nor: Split
 spi_nor_init_params()
Thread-Index: AQHVXAcDwaG7sE2Oh0OnT95bpkTmoQ==
Date:   Mon, 26 Aug 2019 12:08:46 +0000
Message-ID: <20190826120821.16351-9-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: d57e02a6-458e-45c2-05d2-08d72a1e2565
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36781B15C6E1D62E89D5EB33F0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(486006)(2616005)(476003)(6666004)(107886003)(316002)(14454004)(386003)(6506007)(76176011)(99286004)(52116002)(110136005)(478600001)(102836004)(4326008)(25786009)(36756003)(446003)(26005)(11346002)(50226002)(81156014)(66066001)(8676002)(53936002)(81166006)(8936002)(6512007)(6486002)(6436002)(3846002)(6116002)(186003)(86362001)(305945005)(2201001)(7736002)(2906002)(64756008)(66446008)(1076003)(71190400001)(5660300002)(71200400001)(256004)(14444005)(66946007)(66556008)(66476007)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rY5PNLCWeJcOFhF6su8Y3lT1tEQv9I/7IE9pd77o7DTdWFZyITSN1GXVfKUEli+aGJwfR25Oip1HBKWNJ1nnOCd+gI8fV/g9ELpAW7cctpYulzW1nGiEgQJ+QPGJonolGrd1cRkbgZ4eM1cQJJNgcg2OSXd+3C2CIe2ZotQJ51z/GRwudkcR5PITEehLuWPrv7fJybEu3iqNfmRwwSWQQmLlL03LzP/i4bYvKA3b2fBV9eAbxeYTZqV0U/4oDj7+HRP7Qq2ueWT3FWrpZSy7dqPawos1qhMr1sidt4qyPmV7kG/9jDKFgiC66Zi9NxLinMNPRlNWmUDRifDXpOvlNUGMGv34+by9l6PvOcAy9XxU7/uL3XQQK/Ajm0opDNrWPrnMM7eon8GEOA7eNT8N4Np87y/WFRhjSA/Kfr2nUrY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d57e02a6-458e-45c2-05d2-08d72a1e2565
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:46.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eMVKl6tXZsE7+5Mdfx+MHk9t9EJFdFNGRkgHrS8+fM5z9+ibav7nFtgTP9/Z5Hpr3o4F7NQ0jvrkZOLvmnaB8qZjWvrjHCqKQezaUf5kik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Add functions to delimit what the chunks of code do:

static void spi_nor_init_params()
{
	spi_nor_info_init_params()
	spi_nor_manufacturer_init_params()
	spi_nor_sfdp_init_params()
}

Add descriptions to all methods.

spi_nor_init_params() becomes of type void, as all its children
return void.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: rename spi_nor_legacy_init_params() to spi_nor_info_init_params()

 drivers/mtd/spi-nor/spi-nor.c | 83 ++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2a239531704a..1e7f8dc3457d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4186,7 +4186,34 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 		nor->info->fixups->default_init(nor);
 }
=20
-static int spi_nor_init_params(struct spi_nor *nor)
+/**
+ * spi_nor_sfdp_init_params() - Initialize the flash's parameters and sett=
ings
+ * based on JESD216 SFDP standard.
+ * @nor:	pointer to a 'struct spi-nor'.
+ *
+ * The method has a roll-back mechanism: in case the SFDP parsing fails, t=
he
+ * legacy flash parameters and settings will be restored.
+ */
+static void spi_nor_sfdp_init_params(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter sfdp_params;
+
+	memcpy(&sfdp_params, &nor->params, sizeof(sfdp_params));
+
+	if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
+		nor->addr_width =3D 0;
+		nor->flags &=3D ~SNOR_F_4B_OPCODES;
+	} else {
+		memcpy(&nor->params, &sfdp_params, sizeof(nor->params));
+	}
+}
+
+/**
+ * spi_nor_info_init_params() - Initialize the flash's parameters and sett=
ings
+ * based on nor->info data.
+ * @nor:	pointer to a 'struct spi-nor'.
+ */
+static void spi_nor_info_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params =3D &nor->params;
 	struct spi_nor_erase_map *map =3D &params->erase_map;
@@ -4260,25 +4287,43 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+}
=20
+/**
+ * spi_nor_init_params() - Initialize the flash's parameters and settings.
+ * @nor:	pointer to a 'struct spi-nor'.
+ *
+ * The flash parameters and settings are initialized based on a sequence o=
f
+ * calls that are ordered by priority:
+ *
+ * 1/ Default flash parameters initialization. The initializations are don=
e
+ *    based on nor->info data:
+ *		spi_nor_info_init_params()
+ *
+ * which can be overwritten by:
+ * 2/ Manufacturer flash parameters initialization. The initializations ar=
e
+ *    done based on MFR register, or when the decisions can not be done so=
lely
+ *    based on MFR, by using specific flash_info tweeks, ->default_init():
+ *		spi_nor_manufacturer_init_params()
+ *
+ * which can be overwritten by:
+ * 3/ SFDP flash parameters initialization. JESD216 SFDP is a standard and
+ *    should be more accurate that the above.
+ *		spi_nor_sfdp_init_params()
+ *
+ *    Please not that there is a ->post_bfpt() fixup hook that can overwri=
te the
+ *    flash parameters and settings imediately after parsing the Basic Fla=
sh
+ *    Parameter Table.
+ */
+static void spi_nor_init_params(struct spi_nor *nor)
+{
+	spi_nor_info_init_params(nor);
=20
 	spi_nor_manufacturer_init_params(nor);
=20
-	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
-	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
-		struct spi_nor_flash_parameter sfdp_params;
-
-		memcpy(&sfdp_params, params, sizeof(sfdp_params));
-
-		if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
-			nor->addr_width =3D 0;
-			nor->flags &=3D ~SNOR_F_4B_OPCODES;
-		} else {
-			memcpy(params, &sfdp_params, sizeof(*params));
-		}
-	}
-
-	return 0;
+	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
+	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
+		spi_nor_sfdp_init_params(nor);
 }
=20
 static int spi_nor_select_read(struct spi_nor *nor,
@@ -4670,10 +4715,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	    nor->info->flags & SPI_NOR_HAS_LOCK)
 		nor->clear_sr_bp =3D spi_nor_clear_sr_bp;
=20
-	/* Parse the Serial Flash Discoverable Parameters table. */
-	ret =3D spi_nor_init_params(nor);
-	if (ret)
-		return ret;
+	/* Init flash parameters based on flash_info struct and SFDP */
+	spi_nor_init_params(nor);
=20
 	if (!mtd->name)
 		mtd->name =3D dev_name(dev);
--=20
2.9.5

