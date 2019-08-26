Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC85C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4AB2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OlAp+5Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfHZL7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:59:15 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32137 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbfHZL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:58 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cZrCAp1Vn3kOvI/J80LNDHCXUHou7WErY2MzR/ITLkwV3KhDfZ91AwAI7nm0SJT7VJ7/3L3cMb
 8u7J6hJ0x81gmgtqcmG+M/UmnjFRSaQm1QUQIN8t4KhiD7e7LUEYRgAQNj/fL1UFyIPQq+op0c
 Ni/Xs5XCAYRcl/5yQJJWsEr1UypxrCHGJkB6tm1L2SqdAElP9Jwsw4uNB2YZ40+5Dbm2ESQGhh
 3lX/3vARlx9LCmTOJrMwVw4xLKBJ7OJnkp5kY58cPXIjcqD7OQ6K9ipSdYTKxgxBX38ox5Nh8z
 RR0=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46518717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:56 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 04:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQUSWv4oyBgV1lZiYt7pMyFxSKdK71Uo4ghiXYljldq+jEKx8LqKjx4QYlQsKbJJShLUQAXLRL8Zsx8hd0kWtg84ITCQtjzcT1SzQ5uD4ewuaP8wNC5LaqS5/r1pQ6ml9jcSXY9PJQkOcQZ2DeUiKvsVbMxtivHVkzsXZwxuKiTiIUv1n8GXGdVgmHmN1Rx8b16Vt8M6kRkXt9Spl1OF82Oaqs357KwSR6j+dFsFGg/SbMOZu9f100NrhqU2kwsBitTDDqgqx6nfCwbsm6xUJ4V1EcWucPW+NRAzGqthdwB/svdm84xM28QFvMRVE4Fy618GInLCRiClo8aeTtXvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpDlfTaWESJytOMjMrbaec6vmrndTL8P/WfJRbmZdk8=;
 b=kKEa+7AdjJ/j5AUu236yabexpZDV3CY6dmzXkNWTJ2d7va1z9hu5x2ezmHPpqQhSm2pkZzNWjt0LanCdBE5YwdNVC/ifbLmCS6ZI/ns1MnEDr4bu1PINr/W7ui9kjddQk/07psoVGvTpOfmsxXaPBsjV8xBMw3CMOTAqIjHP25r7fHMMpCzM/gmYsnPew71B5q/VXWyDQgjYJAAegfBOjZybbR4CvvLGmvEvWqBaqoSQYjK2c4o/6ogu1HxlgldR7zeuq3CtGd24g7bujF8Lmk0b7Xr6+s+s7m1SFpvYUv1w7TpbCBiRBHz9v1h/+Hndd2JCT9DyBi1pg4CYPzvegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpDlfTaWESJytOMjMrbaec6vmrndTL8P/WfJRbmZdk8=;
 b=OlAp+5Dkb/3qr+dVPy64GdmSAtiIG5r0/3qFulRvPZ25zYi8R+83uDPK15QhOnCFfAEiB+poEaIcZAjmUwatX4YRHQCC2wcQC4axGkteOJjTrFeJUokavWZAuXK0Iuj6999XvlMT5i2AH59jGpn2BhAe3NB6VKF+1IX4ywZQruk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 07/20] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Thread-Topic: [PATCH v3 07/20] mtd: spi_nor: Move manufacturer quad_enable()
 in ->default_init()
Thread-Index: AQHVXAWiKjvzaMNARUywvCP+Mc/bvg==
Date:   Mon, 26 Aug 2019 11:58:55 +0000
Message-ID: <20190826115833.14913-8-tudor.ambarus@microchip.com>
References: <20190826115833.14913-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826115833.14913-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90546502-cf69-4c1b-5ff6-08d72a1cc505
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4350D6A7210A11989C7A20EBF0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(76176011)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(446003)(11346002)(14454004)(2906002)(110136005)(2201001)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INNmD+pN9+8QI2SUcFpByjiVK4AASwEwD+GlPuX31DknZK7lLwULzEMjuTF+uzajcg4HXX5Gwsq0Ssp4CTEwPo4sAJNxyvXLDr5kuIMlib7YfexBl2tf06WYs2nrWQiamqD8sCYIE6/WHRmMWV8nTGlJ5yklfc8dq7mUvZlM6e4e+Av5nNqddFgi9pYNG5bSaargDwV/WjWKXhOXaNEttTroY3/Ft0J9maqkyIidfhzLGHZnUf5wl365gNqhI/HoJ3XRzNJ5WSLhDH9gAt68n3qn1hf2BP/xLKQPtjxBrBTKYDPxZCVoq2TUfOirVDbOl20PyJddj6pLq4KEuthiXfahg5OKeDgzkjEotaop0MBaaOkHun4SSQ+KYoZaZ2Gent3vOCvpGVxzTb5oiJlCASPgDwOn9CL3mVIB8W9qtvU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90546502-cf69-4c1b-5ff6-08d72a1cc505
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:55.1437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLI0MZbMT/TarmNY59cJc2rgCZ7GnF7nkEo6Gtq7MtAemkBMNpRtmVnmoMLoXGscez9oSoTkPfBGreFEJ0t4bCKhLpVT1J1NyK3B3znulBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: collect R-b

 drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3dbbfe34d1d2..2a239531704a 100644
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

