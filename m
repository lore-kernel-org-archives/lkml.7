Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBEB217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pbrkeAJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfHZMJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:35 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33278 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbfHZMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:09 -0400
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
IronPort-SDR: CiHVrJUU7cmxvsry7h+JLLHsAxpeYzDctQZzi3sXW135Go7GVploil062P6UaKXtGGmZPJXKND
 /FObsI7rA1+bdaxLvi/0J5UxmKTNAmFXTwgUPnaFRuLHIfucLFeeF1Tomhh5aJKlehCL5dGUrx
 D3rzvAmqfuB9pyph2CxT296UJmRLIWBE0ja8Zt4MnsXsqFHZAxpS+qinCjknOpyOkIrk42Q0y5
 gi3MbzMEOJEr67LTbOIr5hOSdoSf7MdLJi99ZjXDRgxp07UYBrT2qoDXS8vd6UeoAImm7Ul5hh
 Qqs=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46520791"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbUR453aNfUAxxAKhUGKLXninp46uOvs1raOgD0Vr4Qbs6R1G6bJoGAIEz2xFDKwbs3xLjTzVcsR8yBuS9nY0syLJQxfZ8qSfC31cdUUNWQIqfDigNrLg6Txt5aDJdXuC7RQ8W6afrvvzmbRMZecbP1JoKfzDLTLleA1UYoB+WKX93oqkIcPJ9cW6dFj5bqGE0D2RRkdFdy5BZGo6qb/fbFD5FFcMYt1g7HIhheQrNuqI9XAuf9wzwHiWlIG/ugecExxpWYTr7D5fM9YKO0jvZbx4BTqXWHwiHVoH1MPJoZpPW1JSiyNwVNxrBEEzZyp7gvI3Ic3Nrc3vPwswK3CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baMNcFxemh30UesYLRpSxjInG+neJNL1UAEyj/OjFCA=;
 b=Z8Jp7cK+BobPe6U0jTUFozume/uPCn/+eYWYSczW38T1fXQVXis0vpdsSQSM0ypn2Zt+n129hdZfH10P1KoMBGhtfsGGz5S162IQsfb3cbV74r7moU+epts1vGcp3aPnKBI+CFwYP4gyO/VqwrAyrecI7usQgjdFeH4eUZyciU3++IecgS9UMKOflY0OjJ1CWkDJZ6NZ7SrrSo7shsx8D88MVtKkLe1fJcVGC/yfFjwuei4Y5XLdc2upyuUn+cNs4VnZvD5Lxcm/3dmt0IVHajkXZ0KPcxaVcboASHfHAIxvBweIB+itv1kxe1xragRtsFWj+ZFkkwBDohfG43+zzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baMNcFxemh30UesYLRpSxjInG+neJNL1UAEyj/OjFCA=;
 b=pbrkeAJ7JLFFzAV0+026hEBYck+H1KlcmqVcpuvw68Ezys+zvpSDYpmjkGQoClGKsLCcUhxRjzQTK4se0VR/IcEulfUGPNGO96CUU3LdprfmNNq/5mtKAWrUEGt0wVlk82XbZV76uuRHe9pRD7NCfL51LJKRysFwS1ZWIbMFvtg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:07 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 17/20] mtd: spi-nor: Bring flash params init
 together
Thread-Topic: [RESEND PATCH v3 17/20] mtd: spi-nor: Bring flash params init
 together
Thread-Index: AQHVXAcNKsgtTQvdf0Gwo9nlZWqAKQ==
Date:   Mon, 26 Aug 2019 12:09:03 +0000
Message-ID: <20190826120821.16351-18-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 56300c36-a8f7-407d-318d-08d72a1e2fdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3678067AA33DB673E43D5CB7F0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(52116002)(6666004)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vdjyBlXYN05ssVtaHf7fJ6rne5xDKiLDvw5KjzhOeHN+hE+BUCcaqain4H96o5gzV4989Fg4rYYQRWJts/REmOvigyjNsIYoyWBK59PNhlAiOzkjJLCo9qLhti87Z71he9QbBF9PF4wEkcrbPP0wrTNpmpU4re7ahf1S8Ko3d7vojJidV7tkjHYyjlChz3jReByqQB2m1KtUifSO3Vq0Bhm4R8WcqGN4/DYRFY42oucxS37XHJOL8mj6Ju6oofXj0GHUOfGTXD7tvV8yjbLYBBW6R799UTzx38paf9Oki3GqFJEZXiBK2FUjORP2R3zU6gpZ3xEPce3Pg+/M0JMX4MSBmsenhIR+H/V8dlclTIrqB6PhCsUop6qPXaEmLLcyb0V81juNejwxKB/o7kxjd8ShP0eCeamLfB8KYrwt1rg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56300c36-a8f7-407d-318d-08d72a1e2fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:09:03.8845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1wgnCGFe+PsrVaPL2V4AwI+UaV5ZxIt3qxFsKLe52hsydSSh2GpSePY83sfRjz+KntNaSTxT0xoFN/m1pB/dI5YTFd/XS/UsaZqjOIYFJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Bring all flash parameters default initialization in
spi_nor_legacy_params_init().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: collect R-b

 drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2699e999d21a..dcda96a20f6c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4453,6 +4453,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	struct spi_nor_flash_parameter *params =3D &nor->params;
 	struct spi_nor_erase_map *map =3D &params->erase_map;
 	const struct flash_info *info =3D nor->info;
+	struct device_node *np =3D spi_nor_get_flash_node(nor);
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
@@ -4464,18 +4465,25 @@ static void spi_nor_info_init_params(struct spi_nor=
 *nor)
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
@@ -4864,24 +4872,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
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

