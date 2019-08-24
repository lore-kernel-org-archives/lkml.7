Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B2DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F45A21670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="twisf6WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfHXMAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:00:46 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26836 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfHXMAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:00:42 -0400
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
IronPort-SDR: sF7LT+VeOgFcoqxHl5EiMaceEGV7a04E2ZlWSBwD9NFODDxfkCA55iMCYixdfJvyGW2ZRvGe4N
 1XhdxlIKi2UUvxA+mSaPs+WN+bC/iS/v0LEafEEtmfVi3lhplhAHa6XZ/jAfQKesA4NN370NSR
 pU0MIIR3lkPb1N16BqUJpEDbyEN7MJ2Egja6QxeUKv4v91r1c3w/A8TBIu8p5bIgPfz3HEWHgs
 xqzQzuFFA55NlFmCJ7QoSF3Yw6xzZS8BvGh28i2Rzd8QSN9lYioR+ajos072etUhVyplQOhhuf
 OZs=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="43547600"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:00:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:00:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SanOM13blwytsNHV0RuFfdwOkCG8dnFnichIijGbILIA3lu7gs4cukYV9vcdDStWhMTBH7qDaYRD+A+6ax5No4Cvh1Kr4BTzaIwQ8TQghbVTGbML0lnju4lVkG7lIpfgrHVbDeaZZMvP8si2m7v2J9PMIkHy2Y3FiQKnLctaME3kHX93Y0Bzf5S1OTGdghXClM2+kyDsgbqbLI9z0Bz6wX8L1SN3y8fAO6SZrd6qvZ0qIqBqTketJQmCCUOAIBgj/L/tvlMi5f4TLIITh+UcvLHigmb+1cxWTx8mo59ZNHibjgS7kVLvYPK9XV47hwBIW6EuGa0+kJoqwNrGF2dFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+wVsZJum0MgjumBsmRzL8S+Ti+AGbUZTlYcuZ9VtkE=;
 b=HANLO76SY3uVHEIeAu3lo7DAoa+yqXZzOHUa8UifIONR/vwK9MUifL1DidDkXgE/XJzI8w6VJ1CcnzoG2k/8Jv/w3uojWA7qbZSgD1XsEt/lEPYSqxX+V5AWOYqAkDCQ74kN6Zs6nwX4yqerg22L8OnYmHkJjTeIEPDExW3VMXcv+vz/KOtnCr1OAPcrgxN9k8SAd4uFT/oHmrpJcXwY4W+fIPVUsj4n2f+5rArenJmoG3G++CUBKiHJjR7DbSMWX6MGlipTtRml6/dmrDHAwVnsbLa4U4yHslXkRzZ47sqdqUGO1+OdxOmedLT4KmmsSJuWN9nAQ76y8/vnRK6oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+wVsZJum0MgjumBsmRzL8S+Ti+AGbUZTlYcuZ9VtkE=;
 b=twisf6WS8ef+ED4zUOcN6zeVFw92Lni5cNDdiiZG1sFZSSgjMKTRSkM7IjhsZpZhwpP/RDZA+1pRVFzqYZOPwfvm49STy7SKsmj0jpAGGVcaQmbFTbonJ5THFOgXEiJ1gqyf/Q3T+1r0cTkfh/hPKrslWrtE/L5ywORavrEgofU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:00:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:00:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/7] mtd: spi-nor: Add a default_init() fixup hook for
 gd25q256
Thread-Topic: [PATCH v2 2/7] mtd: spi-nor: Add a default_init() fixup hook for
 gd25q256
Thread-Index: AQHVWnOMw/3GdNILR0+rd21CR5EHpQ==
Date:   Sat, 24 Aug 2019 12:00:39 +0000
Message-ID: <20190824120027.14452-3-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: c56fe2ea-68cd-42b8-f38c-08d7288aae8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB398431AF9E0C4D6C72BC4DCEF0A70@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(110136005)(25786009)(26005)(446003)(4326008)(1076003)(256004)(316002)(386003)(2501003)(81156014)(6506007)(8936002)(14444005)(64756008)(66556008)(66476007)(66946007)(6436002)(81166006)(66446008)(8676002)(2201001)(54906003)(53936002)(76176011)(5660300002)(86362001)(6512007)(52116002)(71200400001)(14454004)(11346002)(66066001)(476003)(305945005)(6486002)(36756003)(7736002)(186003)(71190400001)(478600001)(2906002)(102836004)(99286004)(50226002)(6116002)(3846002)(107886003)(486006)(2616005)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6TzciohBQRqKKHAKdkYTUvG1pp8F/qo+jw3OcRm5KfCtlmpd7KHBagmOHch4jZm4hlGyUFAsciS/X17njfRcO396QF8GaR4OQyE2qnCMNLu687/5hLXUTeMT2lzylKvVHy8scL0ljYBIlN1xVA097cRw7MlmGseTeajFXtBPLedw4QrQuNwp+YZTfXtqIwzZgVSN4PBOEgAiZE57SHXYFOam4aOIRT8hdVUJ2gaIDgYXbd4r2H7uZDD2KE3QSp0nqkKVRdxy9M89GtdLPIItI3eHbj0AcuIYmIAY/UST2YqjQbKU5mVNmZXH+Edvm/UoP5/KtIuyj0+YW5ikRVDoRec3aXRkyd+Gpp8x12MLsvwl1c0JsJG36lkIJxlhzu2dyquq4HyfKMMKl1eA2ZUP2+un9Ks/Jf7E2r+oQgF5qU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c56fe2ea-68cd-42b8-f38c-08d7288aae8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:00:39.7450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOUwUGIsDjKwslqkjBIuu//h66MA7eZEt2shlygyfV0XvVJTdF/lvsaaqnNuuNqeC3PASNjwKCjtbpZIbFeuMhNMJk6iZD36VRRCNt3Ocbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
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
 drivers/mtd/spi-nor/spi-nor.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 016bfe2fb592..27951e5a01e2 100644
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

