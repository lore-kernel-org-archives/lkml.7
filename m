Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDB2217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PRPkNsMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfHZMIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:08:46 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33232 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbfHZMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:08:45 -0400
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
IronPort-SDR: MiJUaPtqCyqy/Bgci7pOFSQRa4ycFmBJM+ro+AE4QjLAT2nE7gWggpecmP9cBiFSjkRrje2WOS
 HW8B27hFkpayYNgKdCbz3zji9OuDK8TfkN+gvLqs0VXyEt9i1Ek3hsUdZB3R91QG0RyNrcIHL9
 zx/TXx+YuersvV2WzDYTMzEnj+QwZsCo21yCsnhRmb91F7b+Ytl93ca4xDMbg/JmwyUTt5r0pI
 6nZKi1+CqhIGpRpk//Njbh/BTWaaVuH7gKSjKkrez2AeL3n7fKXSiAcWvvSPI2DpqhoQiIE9IE
 v+M=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46520711"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:08:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:08:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYa9Q7gdVqJBWIKYVxRea269WF2bO7WyCE9SkLBFdhTG7m1JvNqYB+0SOdEBHcAR/8Y/00tHYinzAP1sar7QejyqEZV6DyryMdT+DZN1IllbCUJCKz5z8mf05my5/pFNnAAB7dAfezQxZD5r2dfvWZhxMu5eFHar3j2tdM2j5Wd5auXFKufIxG4YnvwEoScbk02RxuvWCtAnu6hE1oqqFfeIFFlaFbAAzy9XIGDuAoo8U8N4AtmRPwDzcXzw7jgCSohp0Wnn1863Vw1fFLjpe9uj1D4lFClnDFykvl4nZpS+Z37b74ktNIYm/kaP5oAJz/InyDKw524QVRYlx6lozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31wWWhbWl8hBRHBnpLkx7R3DQXQ7fzcZ+VuDBHkNBEQ=;
 b=PClOvmhUoazt1LEVSF5zff+id8AxsZtRg/t+FEywJqPzT+2J5S4R0fJGCtyQwDCEl76hqEudcPcJwCdRNeMSsJMX/bwuJlxcjLoYsRFtBIyDJtH85k8AIqw8lA35rE0cxM/RucZ/DlNat4niq/55JwvHtLaxgWprgq2r7UutbLbrMLIfbxTH0NnRZKK2klnnsWcWkgsVWiAtD5KOg9czF/wnj4rQbKqjWHBiHz0gKCuRe0r5sTEDqAit5FmPMByTmqmIZ9jaXmdNeejG+XU/H+l9GVIkRy/JLp4wsrDr1pwkYLMsq9+XtNUDho8Cv+djgVzo3XoCEcwkqVHRiRBQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31wWWhbWl8hBRHBnpLkx7R3DQXQ7fzcZ+VuDBHkNBEQ=;
 b=PRPkNsMG0881HCLl78I/vjbRotxoAxLyNFPBqRbFM+VniFJa53Xzjjxs+/2VMSw2ocwioTOowyqOgOkBXllvU0N92pm9BwFaP5uZwCiL/QSE4UkV1lIiOUDF4TP3MO2O+wXikXTeM7UstezrrdQ+w2B3KVgVgHSYQwj6I7fedU8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:08:42 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:08:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 06/20] mtd: spi-nor: Add a default_init() fixup hook
 for gd25q256
Thread-Topic: [RESEND PATCH v3 06/20] mtd: spi-nor: Add a default_init() fixup
 hook for gd25q256
Thread-Index: AQHVXAcAicnY5H8dpUCDa+wa3xawzQ==
Date:   Mon, 26 Aug 2019 12:08:42 +0000
Message-ID: <20190826120821.16351-7-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 118c30ca-ab4b-4b46-daee-08d72a1e22fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3776;
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37762D88F05E86ABE7F4E11BF0A10@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(8676002)(1076003)(2201001)(2501003)(14444005)(256004)(26005)(7736002)(99286004)(66066001)(2906002)(54906003)(76176011)(52116002)(316002)(186003)(50226002)(8936002)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(53936002)(2616005)(36756003)(25786009)(5660300002)(386003)(305945005)(6506007)(102836004)(3846002)(6116002)(446003)(11346002)(478600001)(4326008)(86362001)(6436002)(6486002)(6512007)(14454004)(71200400001)(71190400001)(107886003)(476003)(486006)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bADtocYw8siqpkOtqgQUXExk165xzwBpGAcwLulkEfhgnKp9brNCGxj078f2mJSXLrMfmrI9rYV7HDOWluQRaZmYuwckHpxD2y6pU0gSrA7s3xD98HGft2H0G9ttu5ANvJJzd52N73sPyGCvGciDMRQun8/qxUUDCLRDUhhibSgKVjNw6APPRQDhjZe2Zg/ThrWDhqnoGVCXsBKzOzZ5Uy7G2S/jNJQDQ9UpylFqMATaVqItpLEemZIXBnWHmVzHKkCxlfEXokRfxe7IJ9P6oXeAlgkhpuG9hBR8sdxpgAP/dbRDcqU1kegv6oYX8Q0W68KkWwOuaBlkQ+pNx/d2g6qB8lhAwBxPWl/o0Io0cF83RvnSzEBc1hSpsZixhLRWlCdNqArH8vmtnrejYLbpcJBYFrEkIRLGE5gSOBlDh18=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 118c30ca-ab4b-4b46-daee-08d72a1e22fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:42.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vAQ6Hx1XnTm+IZ+mYyeQCFEKR0qnCdMSq200B6ph7Y8c6dMVzxAebFVHH/8u9PYdczNJ6TEuM645nn+jchYqJA7TYFvMuf3UU0ZBCCmBTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

gd25q256 needs to tweak the ->quad_enable() implementation and the
->default_init() fixup hook is the perfect place to do that. This way,
if we ever need to tweak more things for this flash, we won't have to
add new fields in flash_info.

We can get rid of the flash_info->quad_enable field as gd25q256 was
the only user.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[tudor.ambarus@microchip.com: use ->default_init() hook instead of
->post_sfdp()]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: no changes

 drivers/mtd/spi-nor/spi-nor.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8fd60e1eebd2..3dbbfe34d1d2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -222,8 +222,6 @@ struct flash_info {
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
-
-	int	(*quad_enable)(struct spi_nor *nor);
 };
=20
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -2126,6 +2124,21 @@ static struct spi_nor_fixups mx25l25635_fixups =3D {
 	.post_bfpt =3D mx25l25635_post_bfpt_fixups,
 };
=20
+static void gd25q256_default_init(struct spi_nor *nor)
+{
+	/*
+	 * Some manufacturer like GigaDevice may use different
+	 * bit to set QE on different memories, so the MFR can't
+	 * indicate the quad_enable method for this case, we need
+	 * to set it in the default_init fixup hook.
+	 */
+	nor->params.quad_enable =3D macronix_quad_enable;
+}
+
+static struct spi_nor_fixups gd25q256_fixups =3D {
+	.default_init =3D gd25q256_default_init,
+};
+
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
@@ -2218,7 +2231,7 @@ static const struct flash_info spi_nor_ids[] =3D {
 		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-			.quad_enable =3D macronix_quad_enable,
+			.fixups =3D &gd25q256_fixups,
 	},
=20
 	/* Intel/Numonyx -- xxxs33b */
@@ -4237,15 +4250,6 @@ static int spi_nor_init_params(struct spi_nor *nor)
 			params->quad_enable =3D spansion_quad_enable;
 			break;
 		}
-
-		/*
-		 * Some manufacturer like GigaDevice may use different
-		 * bit to set QE on different memories, so the MFR can't
-		 * indicate the quad_enable method for this case, we need
-		 * set it in flash info list.
-		 */
-		if (info->quad_enable)
-			params->quad_enable =3D info->quad_enable;
 	}
=20
 	spi_nor_manufacturer_init_params(nor);
--=20
2.9.5

