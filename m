Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76554C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376392146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hXYkgRtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfHXMT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:19:26 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56602 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfHXMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:19:26 -0400
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
IronPort-SDR: suB42bOmdYgWUmXPa5YB/8saMsCRGhHHCcaDT2owBLBUi0xELHoJQI/N4q3UW6HIC7YpelPb80
 38mNUbVpB/LDDsBihlsx1NGBuGVdwpDviQZsVQKDksa4nqoh3Kwlku39bYrMCoX5Hq4eP9Gc3a
 2SlvdrZ3xA8410qI2sEanTsVUNp1o743cPfGGkb6x70rNAdeIlTDGt0in97k285HI1pHPP956z
 JtILnFf1IyTCC+aePaixxTIYi9zdIDJxUig1/6sUb7/DCOKTe3+d+1TsAx+d0oc8ZBfLYr1gr9
 fKo=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="46393051"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:19:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:19:24 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoU5W3TH6cw1LOGqUlneLnTOL7H19gQxEnrP188N3RVrJnIVfcPKlWze9ZirLGA4XcCM6+DB/9iGDA/9BFnP0E+lGPccTVf0LwCx8S5snc79gPKRE07xmMpRWdtzJ4kRdR1ehqoWu4T5Bhr/TvPUXOGGSpCfhPO3WyBfA06GAsoQ1Q68BfVQSOJqs8OpY0JRaK00hKomNYJ3PeLHNThB3NRbtBT1+O5lMbrR56DeTt3SPI6if5R8fgWI6XDf0Z10Shcx1IxafV+j2RugzvDfuG+3JOn7Wdi58ULf5CAugS/WJhgYlk6dOMdjwK+XZ85JJuYcZFQGkilmD9XEPqeq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKyxN7zvmePKJTQAY6hLYJ+qUTy3y4CZ5b5vr40nKg8=;
 b=OaCGd3yBpoDEAJNdg/xavZhq5HDTnwmEWqlsY4A8u+ux/XYb0zir91HaWev4N3M4/x3kbAzoT6tXm7jvM126SO79vWkzfm91esX2RyV+kQRK+BkyRbjaPrDHWNoos1ln6fbKxorFyg6q/0wOo9gI/tUCWGGhydk112IG0GqNFHOv6tO2pGWjbGVsbI1/pBID4Zygkmd67FkUMv0SBPm5UnUpENgcwEyrNKHndkr94gWR5Z+5LHu66z5NxZXrPJAljvSaGXY+CDfXwVwhJlz1PRa78KSTW8ENP0eVk6pz0ARJ2cOhuS5p8COu2XAmDc2srMpoXY1k7OJbWWUQl16ggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKyxN7zvmePKJTQAY6hLYJ+qUTy3y4CZ5b5vr40nKg8=;
 b=hXYkgRtDH1dx8RYZeni+4QRdiyFE8+jWNXDKJk8bS7fjRjcvGDRNR3yaQK1SYWumPhXlEBjSC7dKpBVS5bAjCNM2Tb8UOdCSvhzR/EHNZ3Wtpo6Kpzje2Lcfj4hupMKXRWvJjcmZe2j7WVg9bSCfQ1fqzXxGd+JXK6dCcH8ps+U=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4317.namprd11.prod.outlook.com (52.135.36.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:19:20 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:19:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: Bring flash params init together
Thread-Topic: [PATCH v2 1/3] mtd: spi-nor: Bring flash params init together
Thread-Index: AQHVWnYoKN2C4GgKNEas4QOeFP8sRA==
Date:   Sat, 24 Aug 2019 12:19:20 +0000
Message-ID: <20190824121910.15267-2-tudor.ambarus@microchip.com>
References: <20190824121910.15267-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824121910.15267-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6329ace6-429c-4d98-0521-08d7288d4ab7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4317;
x-ms-traffictypediagnostic: MN2PR11MB4317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4317D031D9CF8BFC829CE040F0A70@MN2PR11MB4317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(189003)(199004)(81156014)(110136005)(6436002)(3846002)(8936002)(8676002)(6512007)(50226002)(305945005)(25786009)(7736002)(478600001)(53936002)(2906002)(316002)(66066001)(81166006)(99286004)(36756003)(6486002)(107886003)(386003)(6506007)(102836004)(476003)(2616005)(52116002)(76176011)(446003)(486006)(26005)(186003)(6116002)(2501003)(4326008)(11346002)(71190400001)(71200400001)(2201001)(66946007)(66476007)(66556008)(64756008)(14454004)(1076003)(256004)(66446008)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4317;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NmTPWFESWvm07RiUp/F7Jyw7W3Utr6WjgwrNnFHmpUyoYMFlUWrlViKdt/8UD1MzC62EYhP9gyM3j+jLMMsKA1TwEEP61kS4y6/BkWhFw9noZNPsyKybM1hIo86p8XA3yP2a8YZtvjBprXQ8w3e81bIRIpycYhBHqixcIzDLqcWFES2HF/daP/hHMN17Lp2S4sQZW7HJylHnw73ZnkeAV5kcjDI+z/E421PNVCVuIx9/jcwCGKyB3WqHNn64BamcPBuoh2qITqfCdGtXSZWCENu8XYr1kqY0uGhxQ74sm6khPqUcTdo3DCgbcS1llTCK2UT9eA7shKEKwh7BrFjwoLqnklZE6Z6ABvmoTz4+FxKA7YVoXsS/XwSyjpKL/X4pDhC4gKoKLgA8277PVmDOew4ZlclfbRg4u0lEG233zdc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6329ace6-429c-4d98-0521-08d7288d4ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:19:20.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahdWu/cv7jpLgr8imZ7C1hB+2BxnLi4Q04AFvFgmPVnL8Mw1RSRMVw/A0hYISAPDzEetzRXpVYCO00I9zW2EdOc3WQ5cRbwvmMkeoUoeP5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Bring all flash parameters default initialization in
spi_nor_legacy_params_init().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e76c23d1c54a..7e6da0ace2c7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4469,6 +4469,7 @@ static void spi_nor_legacy_init_params(struct spi_nor=
 *nor)
 	struct spi_nor_flash_parameter *params =3D &nor->params;
 	struct spi_nor_erase_map *map =3D &params->erase_map;
 	const struct flash_info *info =3D nor->info;
+	struct device_node *np =3D spi_nor_get_flash_node(nor);
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
@@ -4480,18 +4481,25 @@ static void spi_nor_legacy_init_params(struct spi_n=
or *nor)
 	params->size =3D (u64)info->sector_size * info->n_sectors;
 	params->page_size =3D info->page_size;
=20
+	if (!(info->flags & SPI_NOR_NO_FR)) {
+		/* Default to Fast Read for DT and non-DT platform devices. */
+		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
+
+		/* Mask out Fast Read if not requested at DT instantiation. */
+		if (np && !of_property_read_bool(np, "m25p,fast-read"))
+			params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
+	}
+
 	/* (Fast) Read settings. */
 	params->hwcaps.mask |=3D SNOR_HWCAPS_READ;
 	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ],
 				  0, 0, SPINOR_OP_READ,
 				  SNOR_PROTO_1_1_1);
=20
-	if (!(info->flags & SPI_NOR_NO_FR)) {
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
+	if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
 		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_FAST],
 					  0, 8, SPINOR_OP_READ_FAST,
 					  SNOR_PROTO_1_1_1);
-	}
=20
 	if (info->flags & SPI_NOR_DUAL_READ) {
 		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_2;
@@ -4897,24 +4905,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	nor->page_size =3D params->page_size;
 	mtd->writebufsize =3D nor->page_size;
=20
-	if (np) {
-		/* If we were instantiated by DT, use it */
-		if (of_property_read_bool(np, "m25p,fast-read"))
-			params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
-		else
-			params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
-	} else {
-		/* If we weren't instantiated by DT, default to fast-read */
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
-	}
-
 	if (of_property_read_bool(np, "broken-flash-reset"))
 		nor->flags |=3D SNOR_F_BROKEN_RESET;
=20
-	/* Some devices cannot do fast-read, no matter what DT tells us */
-	if (info->flags & SPI_NOR_NO_FR)
-		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
-
 	/*
 	 * Configure the SPI memory:
 	 * - select op codes for (Fast) Read, Page Program and Sector Erase.
--=20
2.9.5

