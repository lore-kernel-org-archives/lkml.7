Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB152C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A02146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dQMfEDF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfHXMT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:19:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28713 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHXMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:19:25 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: qMb1AvBDN3KDCDdaPmvo8TwJbYGr3dISVC+BT8DZMF44QvGfDhgWUEKvu1O8/KQKROzq6Z7QQf
 sxzRFvqGR4b24umIajHoIggoZaB2WHh8Nps1VzTlh4bJ0ZgoJ1NuPpnhDAm0Ko4VYo3U61zsjY
 HJT9E5NvzkM7j3mOjxEz6G6MYNH5b9C32yXAxQ0dunnAxX67YrvkpcA5Kw6Hl3PtsWMED2229J
 Nu+MvD+gTLz8qRyJstyIXLvmeZI47+NCrbBnYLpXgmRR31YvfDHMVguRJMGv0fS8yVvMKp7nl5
 Bwk=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="47840267"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:19:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:19:24 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGOjV0sgijjRTXBtqGuSncgeYeaVfJQHlOUVAxUoQgXN0rfKhU4wQdFdzvdfr6KVF0yvBP4nyM7FvJcFYd8PQBfYUDtQTdG9Jr51wL/SDrCi0sq0++K5fRd1TQuDpVKxqBetk2nd5auSTUwF4YOFkEvOjqF+dfddbURyBOSV3a/ZQR4LkdLE7EYrn/g1dcs30xK5mGrbTbUdqsTsjRki50OYSeGiqtFPWDzS442cZiB/q9bwqLEgRHOjayiTzjIt8+Ly7/WoW4Hvxna4Fjky1gB6JH65EeZ9wRShseCNpgZVNhpi2+xDmt9uP2liwZzqzqqbO8oNCD0Aj2K94Pmwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbfW1AhOxTVXIfbLXw3bsQX1FLpSQntD/nyPJEIgrak=;
 b=WKNu5BEXsrRVIOeHCPrS2hDxT7hS4PyYAW2SJ55gWxl0sgXzaKc+LxAJlN45doFG5bUyoR51Tsci1OqmGdcqBT36SRrC1Jp6rpJ+mECozrfU0PSbebXjHGpTKZmDC3Unj98sHUOTmrNo+Q1ZmZCfpURGD184DDEFyMv6J+QkmKpEmX2aTUb5S6BlGVLo/uuY8yBwGerwhkFGzIaNypwoIO83Tv3wmBis+KNAs2Tjws/Ljri9bKV1Akuvlq+JStQg11K6XhxqVGaQYp4P/s56YBQ51Tn4T2amx3wi/99/E2Lws/5MlgEU56CNvKTpwsRPYQd7sv23HU95MmgngRUbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbfW1AhOxTVXIfbLXw3bsQX1FLpSQntD/nyPJEIgrak=;
 b=dQMfEDF8DtoYU1X/RwUbXHoOfG+DTRqkrM6BUmNyWARx9XFntmTxxUYOBhiTHnYQiP5O/eEKQTnBViMfT9zDqnCRe9Vc89i2fGx/viaWQ3eKr8tchAbo0EAREwefUeUC3CsbScRnAq8cbQzT4zYNwEo/Ak1jnlMvkei7gG5Qzkk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4317.namprd11.prod.outlook.com (52.135.36.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:19:22 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:19:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/3] mtd: spi_nor: Introduce spi_nor_set_addr_width()
Thread-Topic: [PATCH v2 2/3] mtd: spi_nor: Introduce spi_nor_set_addr_width()
Thread-Index: AQHVWnYpCXaYA1wrpUiuBSyQuqGvRA==
Date:   Sat, 24 Aug 2019 12:19:22 +0000
Message-ID: <20190824121910.15267-3-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 58c9f3fe-cd2a-4711-1079-08d7288d4bc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4317;
x-ms-traffictypediagnostic: MN2PR11MB4317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4317C1029CD85F5953BA4F7DF0A70@MN2PR11MB4317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(189003)(199004)(81156014)(110136005)(6436002)(3846002)(8936002)(8676002)(6512007)(50226002)(305945005)(25786009)(7736002)(478600001)(53936002)(2906002)(316002)(66066001)(81166006)(99286004)(36756003)(6486002)(107886003)(386003)(6506007)(102836004)(476003)(2616005)(52116002)(76176011)(446003)(486006)(26005)(186003)(6116002)(2501003)(4326008)(11346002)(71190400001)(71200400001)(2201001)(66946007)(66476007)(66556008)(64756008)(14454004)(1076003)(256004)(66446008)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4317;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /nbsl4YHp2HPIsccwDjenFMtarCxGVJugRnGGP2wWgC1YQn5VpVWYcbILMVEYAC+fgCWj+PMVg/tY36yI3s0E+e2cjlYcVjE7EaiZ+45N7GMN1or7Yo1t5Z7Xo+GeW2XGiKqe33qwgo45MFnl5X5QB/KT8MjnEXL5F/o6u/fOH20vL3I/+qSdfUm9eZ3ZL4ShhT/eDBJ3kwagNp3nHMR4mTRtHFFjP+lSvid1uJEFdwW1RgP/Bj3cGtms9qGMjCa269yexxQdzbAE8OIm6aoHGwjgK5AvEDeglHQFuLpTkugAyGHtX2TklMthkUmUSndX4RVSlSzkauMpgiNJG/BdCxdbTXgy/HWHRA719Gw+4uRQJTRPtTDaUpYoyoRECd8DrynmpjFkpmRhyK45ngYit+kpVaLFFSqByHP6AlL/DU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c9f3fe-cd2a-4711-1079-08d7288d4bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:19:22.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ALHhEW1FYHnxJh96CGOIrYmDOYW1HJaKvrd2lP0cZMHF/CNAUrvsErtfUNaoxkjg9dJafo3T3KYWPAOA0vPWjHPMLnWc1VQmOm6bcKRkiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Parsing of flash parameters were interleaved with setting of the
nor addr width. Dedicate a function for setting nor addr width.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7e6da0ace2c7..449d2c4918ca 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4780,6 +4780,33 @@ static const struct flash_info *spi_nor_match_id(con=
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
@@ -4918,29 +4945,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
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

