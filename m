Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DDCC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560521670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ht5Jx/2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfHXMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:00:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58261 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfHXMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:00:44 -0400
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
IronPort-SDR: 1g5oRSSztCEo9Rvr8SFS92XStYUdDAHy60Q3MGI80VOxlcxtVQlsBJdHQjJPxQvH1usU+xtMS3
 8UV6iu7FkX2eJXoGbQ9NC8EmlbKhrRievkIuykpIDIWtIHNEV/i91MLtIR1arAtVCcBaDApZ6W
 H6AZlJK9OpzBkTxFD5Ta6xVwQbm7ctOp143mCPImseYf8n3sHV/YXm98WreQKuA6vFgnz/ERiI
 1QT+K/Epn1Jpf7o9wShKm0AGxfUDEc07fKDs/U3JP6fGST6VkGXX6m9y6FIBeJH6stkkxX3Zk/
 TQI=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="46464751"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:00:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:00:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVU44fflv5+hFiTLT0Pv3TM1Xaq+GFOgB757GcHj4kkKBhmDPNQera2R7qRgoO+iuZYx7N2IGgKwwqdJo0Po3klo5Sv5CUE8EGmoIwSE1vbMGj8fq2kysTkcVbtTcs5E44Y/cNXtC7UlLa+ydhB6YYfCX795plPoS1YVpG0OcEfDZ1j6wUz0C24p7NtENU8KmzLaEN3olw5FloDLVhCmbhR+7Jyrm1a15Y+ndZcmmSBHrVBr8rnSfwIgwLezMEUpQZNTniSkPMgorNq4MtsCh1x7PKq3CNYdsfERa5W/wfWQYzngQKyErbwXo2DW3m3SU0NjVEgs/RYH58SnoJfMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUQxNe3OAVO9rUQSyqf9kLDICbtbnGEhLBUguMYgUO8=;
 b=cC73qFXqbpFUpWrNST/iUyPhkR3WB5z1ExdPTKpClqkGzjU6v6IFddXlVEFepCpd5VaxKprXRiEA4nHOfcgCdioyVNcGtLjcvOi9/Ejnr7Zqw/rZT+/CJsGqmH9KJztEBrBM0XLPIXQmGwxmlsDzG30z350Hr3mLWaxPUfg9Pz5Bvu+W/5iMVbMvleBIfAVfF9qofv9oyEh0sVM1MLR6TjqLj2jxssYcDYb0BLiIamiJy2yVT9XLrW4GscE7qmSLEGGOLvfZkwjIMYJ4jFaJMR3UziPhJHX5048Y/mUlJp40gc+/TcTvbn1HlS6KcHBE9xB+KXwSPZNKZzANSjZfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUQxNe3OAVO9rUQSyqf9kLDICbtbnGEhLBUguMYgUO8=;
 b=Ht5Jx/2G7syofqiI2oJ1i6NxwfpNaCbIhoMIdoYZqPul7Jy3fMurTFLwD0x8EyOB8Cvrqjn7Wbee94UXwfld69FJ1/rbe5BEezoj/jl7NBZW40Tn3gESGcJKEQ2wqNggeayl7Be73XwQq15zqmnLcwZJhsmdlnv+5shfsXOQx70=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:00:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:00:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 3/7] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Thread-Topic: [PATCH v2 3/7] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Thread-Index: AQHVWnONChlfDI2lKEuSOGQMw5/1ew==
Date:   Sat, 24 Aug 2019 12:00:41 +0000
Message-ID: <20190824120027.14452-4-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 4e849081-9b73-4bdf-62ce-08d7288aaf98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB39843883E342A645AC0E23F7F0A70@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(110136005)(25786009)(26005)(446003)(4326008)(1076003)(256004)(316002)(386003)(2501003)(81156014)(6506007)(8936002)(64756008)(66556008)(66476007)(66946007)(6436002)(81166006)(66446008)(8676002)(2201001)(53936002)(76176011)(5660300002)(86362001)(6512007)(52116002)(71200400001)(14454004)(11346002)(66066001)(476003)(305945005)(6486002)(36756003)(7736002)(186003)(71190400001)(478600001)(2906002)(102836004)(99286004)(50226002)(6116002)(3846002)(107886003)(486006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d0hN9q9tibo7Eh1g8hWLokCJjAOdV3jX20VgV3d0ElYDxtAZtNeO4Afev8E+u2fiNwd1iZoUfTZsbJC1MZBemBZ1AJnXR2qtQD+nktiKsGDkf3wBA18ib6QZjDPL35oqqz/xMpAC13SX9QKU2WCE+qiLD/aU5JVMDiruP6KlDEZPoq96NXQfmRA6mrQp3t4xk0i/YkNvkbJnySssgUN7YOzv66o3Q9jtDvfngUlBqVECEKB9yedzh5HA0jE0niriZC33w2BKzBMCz0ZauE/l9DBo704k7Wxn3XdHHw01g2Wfc6Zq0a1EYw7KkSml4LCL0C+JCVn57tGL+pQHZy6M5qRFgA6FnbS+dh5QxGTW0XSeC9pRkzqmgOV45/tfy6/DBsz3jLuVbxtAUXCmus6yOz6yWzLc/XGlxH2vGPy8/eA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e849081-9b73-4bdf-62ce-08d7288aaf98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:00:41.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9BHNjrBpOIxSmQdtpAAZVET95U6iFQ5PD7XZHLqg9vrQ1XZFRwMKP2XOY7Nm+9QviYVHXILvo7/k6y8bjGCrT+7r+uUK8hkCIqIqdjtBgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The goal is to move the quad_enable manufacturer specific init in the
nor->manufacturer->fixups->default_init()

The legacy quad_enable() implementation is spansion_quad_enable(),
select this method by default.

Set specific manufacturer fixups->default_init() hooks to overwrite
the default quad_enable() implementation when needed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 27951e5a01e2..c9514dfd7d6d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4150,13 +4150,38 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
+static void macronix_set_default_init(struct spi_nor *nor)
+{
+	nor->params.quad_enable =3D macronix_quad_enable;
+}
+
+static void st_micron_set_default_init(struct spi_nor *nor)
+{
+	nor->params.quad_enable =3D NULL;
+}
+
 /**
  * spi_nor_manufacturer_init_params() - Initialize the flash's parameters =
and
- * settings based on ->default_init() hook.
+ * settings based on MFR register and ->default_init() hook.
  * @nor:	pointer to a 'struct spi-nor'.
  */
 static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 {
+	/* Init flash parameters based on MFR */
+	switch (JEDEC_MFR(nor->info)) {
+	case SNOR_MFR_MACRONIX:
+		macronix_set_default_init(nor);
+		break;
+
+	case SNOR_MFR_ST:
+	case SNOR_MFR_MICRON:
+		st_micron_set_default_init(nor);
+		break;
+
+	default:
+		break;
+	}
+
 	if (nor->info->fixups && nor->info->fixups->default_init)
 		nor->info->fixups->default_init(nor);
 }
@@ -4168,6 +4193,9 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	const struct flash_info *info =3D nor->info;
 	u8 i, erase_mask;
=20
+	/* Initialize legacy flash parameters and settings. */
+	params->quad_enable =3D spansion_quad_enable;
+
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
 	params->page_size =3D info->page_size;
@@ -4233,24 +4261,6 @@ static int spi_nor_init_params(struct spi_nor *nor)
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
=20
-	/* Select the procedure to set the Quad Enable bit. */
-	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
-				   SNOR_HWCAPS_PP_QUAD)) {
-		switch (JEDEC_MFR(info)) {
-		case SNOR_MFR_MACRONIX:
-			params->quad_enable =3D macronix_quad_enable;
-			break;
-
-		case SNOR_MFR_ST:
-		case SNOR_MFR_MICRON:
-			break;
-
-		default:
-			/* Kept only for backward compatibility purpose. */
-			params->quad_enable =3D spansion_quad_enable;
-			break;
-		}
-	}
=20
 	spi_nor_manufacturer_init_params(nor);
=20
--=20
2.9.5

