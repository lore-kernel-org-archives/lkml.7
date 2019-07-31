Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05753C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8FA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QG/sPboq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfGaJDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:03:35 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61131 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfGaJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:03:32 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RIu+WhYM7EolzeEm1amKvSdREtxRJhIdxRl2EmGlv2tSFS3GzIUfKLjgjCO16+EVzkv3+Ek2Qt
 G3m/79TEzMpl8jVq6xciQpqNKOQ+pCaQzCZvXHtGkJna5Wwl1hmW2aqygRiGljyPLExXFacJnn
 BiXTKdkRnWGg6drwWlJ1D2PpwZaI8HJWpxJkXs7URUmB749l3u5vImW0CqEGPKrw9MpwHmMeVl
 6U2cI2ecVE5RmbYbmfHh9v8dQgBjb3mwCiD2IyPyZce7/ESNljc5j2OINHD4wyshrbIM80Yh+y
 n3c=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41823055"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:03:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:03:29 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYz0yGTvWlNnApnP2Ca5eefeV/xVn+bImgrAjVk3lMV5iXP/+TXdRFBolnHe3hr9H747lBJ17zPfL2fMcsRQZirmKpxwVibUwvwS4lEzJ5Iw5kB8Lwld5VbpZOYvW2fUbMFVdcTcJRMdmdJwWSaK4+sUtVuzNPBc9MimDLCjKSpGhsLRkCKFdHgs+dC+YDpTmMjgINb42JmGXoQDwjR1IWMhE9tZboggUckEa2dEoo0RlDptwVi9Ay9C8s/91Bvk9BkOByNJsN6ZLhVb47vEXpSk2Mk+pODHhww/qopEiurs6oFrQ07IR0KBK77Bc7FChNWpJosViQ0Xxo6rkZ4nnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8yIcMHMq6Er6vAjwuUn5TbieUcB74FCHRHEw8tljbw=;
 b=JhrAj9T5arv7QHACaTOQUWv0x3yzcMoSyC2BiMhS7EbG2G4eRbq2SKzPYMXBbRU8FeJQKowcSO9S5pMpJNbGpt6YrJaOYzUNpWvX/A3peQxi52XUPes2ZKWkxYLO+2BUlMGA9g08lzT1z6qEynklgWOkFa78cQhukGsRUihcjm9EbMtFfevFXi+jWDCF7NwtrSJRacZLYVT+AsNzy0bDcqoMQjrYivFrC6RIkBn7pN0GZi/JtjeOX8Mn5QwS2Q5aKBmNeTA8DljWs5mMvumr8y6QuZd+rl7i/7K/lZWKtO5r+TuQ41b5sRfWgDQgC52FDpv3Hn2e9UsGjNpNJwHdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8yIcMHMq6Er6vAjwuUn5TbieUcB74FCHRHEw8tljbw=;
 b=QG/sPboqzSiy0ROP23Ajm2AWwUg2MMzIFxE7CZz2nT57zuvlI2YN18LcqNfIuBSQtrK+nsdBoTPX8sw2sjDNs6ePTFT3OLQen78jpVUBdALaPjO+BarshT1CCTQaPz9jUPIeLfcagiQFa/K1cyHnlbOW23mI1lJcRdPfcHnjyns=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2SPR01MB0050.namprd11.prod.outlook.com (10.255.239.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 09:03:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:03:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/7] mtd: spi-nor: Add a default_init() fixup hook for
 gd25q256
Thread-Topic: [PATCH 2/7] mtd: spi-nor: Add a default_init() fixup hook for
 gd25q256
Thread-Index: AQHVR37SzJUb6rePcEWKq1Ud1rngjw==
Date:   Wed, 31 Jul 2019 09:03:29 +0000
Message-ID: <20190731090315.26798-3-tudor.ambarus@microchip.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731090315.26798-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e07a43d7-f741-43ff-4a61-08d71595f47f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2SPR01MB0050;
x-ms-traffictypediagnostic: MN2SPR01MB0050:
x-microsoft-antispam-prvs: <MN2SPR01MB0050868659E7C0A0C12BAEB9F0DF0@MN2SPR01MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(50226002)(53936002)(36756003)(54906003)(7416002)(305945005)(8676002)(81166006)(107886003)(2906002)(81156014)(6436002)(316002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(6486002)(68736007)(8936002)(6512007)(86362001)(5660300002)(25786009)(1076003)(110136005)(7736002)(186003)(4326008)(11346002)(446003)(102836004)(386003)(6506007)(256004)(2616005)(476003)(52116002)(99286004)(76176011)(478600001)(2501003)(66066001)(14454004)(14444005)(486006)(71190400001)(71200400001)(2201001)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0050;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zROeRrD3PoYeuqunA33zfpT4HFF33eixWWmg0TBizrSkB4hsiSmCUXzQx1lAvkhKbwgVIJGZ7LCB8USOUAM75FYLMTm+17Dtvp3csq2K6UZgrFeJxokJ3iWjJ/S2GfOty7bexOxJEp5tBxIp22hBn70yJY2Fku0mnOiQ/53zANTfoFZyVFPMUIMyUQXUUiCsFlfGvDWCU87rNtGXka6l8I29/I0EIC2XfnaQACl0NhxO7aBrc+Rust9wp48DAtRuthI4XbIfZ4AVtu1+7m/8Qd/I4LbP+EfuMHqBROgb1YxuoVXOQv4OxULDAKXBrlGr6D9XU3ZG+eRcEGQZBSNRONm9FXm8+OG3sS6A/WYrK93+hVZ9KK19wmeElbM9o5a2XLVjnHpF0K3MV/EfC5dm8lmaLsmrnj3tvbFJonwRqB0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a43d7-f741-43ff-4a61-08d71595f47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:03:29.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0050
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
 drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ac00f90ebaa9..94aba5ce1462 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -288,8 +288,6 @@ struct flash_info {
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
-
-	int	(*quad_enable)(struct spi_nor *nor);
 };
=20
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -2268,6 +2266,22 @@ static struct spi_nor_fixups mx25l25635_fixups =3D {
 	.post_bfpt =3D mx25l25635_post_bfpt_fixups,
 };
=20
+static void gd25q256_default_init(struct spi_nor *nor,
+				  struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * Some manufacturer like GigaDevice may use different
+	 * bit to set QE on different memories, so the MFR can't
+	 * indicate the quad_enable method for this case, we need
+	 * set it in the default_init fixup hook.
+	 */
+	params->quad_enable =3D macronix_quad_enable;
+}
+
+static struct spi_nor_fixups gd25q256_fixups =3D {
+	.default_init =3D gd25q256_default_init,
+};
+
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
@@ -2360,7 +2374,7 @@ static const struct flash_info spi_nor_ids[] =3D {
 		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-			.quad_enable =3D macronix_quad_enable,
+			.fixups =3D &gd25q256_fixups,
 	},
=20
 	/* Intel/Numonyx -- xxxs33b */
@@ -4372,15 +4386,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
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
 	spi_nor_manufacturer_init_params(nor, params);
--=20
2.9.5

