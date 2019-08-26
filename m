Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8594C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3942186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Nn3miboi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfHZL7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:59:04 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32137 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbfHZL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:59:01 -0400
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
IronPort-SDR: f/o7Ia/yx5YspsstVkp/pgHVXqU7BQ3AU9XyiRBPRFzh5tMKmDVJTvjbtIhzhdezqEt/oaeuym
 84aYW2DetTaAdTaNIveQJdBAIPvksk+Cewg8NDFKuHdxLKHvdLFCzd9UdNKochwud3DwoIAxe0
 Gjy/brZhLdLQZosQwNLIVSXBd/j6hagT2Ht0dQEMpBTzA89mOWiz9svQZOZEPvvpj1Hd/DYpbc
 Kk5P8QTW/P4D//AG4nlfUd/nklOcV56Y+Qr+sJ/YC93yWfqopyV2F4+bJLwCUCVwsPcwfjs2oO
 6Gg=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46518726"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:59:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 04:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDvFURMZPEVU0vrpSrikWF7QKOn0qeCPsY19NhzaS6DyiR2/aORkmtRHujaYfdH9Fxg/6379WWJ0ttMp05xW7oYToV4dOcd6j5lbS1F6+XA3zjZFoWB2YsHTFSWzQ2vM3Z+vpIjt2xNCqruhb50WDNylCfkRQVn4u5pcYoumthdER2LwkOUDw+pqaTOdexrE5SdCYyQIz/9LEUQIYILudN+k6UB+SUNiwayeT5RrqG9vCytiKodqjq4XfuL+jFy0Y5gWFqL6Oyn0mOlYXe404DhptEfYdzPTEsrV7tmgQ4+up7m55+97X8RYzFw4w0BeTIZibegPvZCkd0mLba5XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYkmIUFTQvRMJYvhZhq10CllljCgJS5yCXTvQ9exY1k=;
 b=U3m4wQIYBCklhNNFi0rJoXBXMBMhDf31D6yqygvI/M0U8mf1ql4Bcs3+FwCgTIX+IGEfWR2tgvI/BGlhDgLW8xhzXyZPYJSmJlRz1AHBa1YWT2BUFsbeXyRwUvf290kQaVd5jgclc9eglxuUT3IeDxeVIVYL4EgXEWZTaPR/s7kMYP9J5z39MfWqK3ACg6p4i/lKmR3mBJN9jNYunn4QgUylx/8E8mD2hTUhJ4XdCi27z+iQvnZuCr2jw2Z3EHqmmcmR7Sc+sJEi8QM6KJ57dseHglXi5iPOPnOAOO/pQl6S3ElEJVOEfa0Ariw+WsxK9vgzXpFkzjc6hvUua9cCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYkmIUFTQvRMJYvhZhq10CllljCgJS5yCXTvQ9exY1k=;
 b=Nn3miboiFjR+nIekW31g4y60YUsFEtpCY1SGk/4cpspoqnlOffH/lHACql/1ip/G9OuK6w4isw1dHR55CU9V05j2BxH5MyeFiHzLkqqQiqoNfiekw6W1oNtPU0caGbOG8rR04pT4wrV3iYDMARKlzNYiwrqDsX1MAnMpPjjEYUA=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:59 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 09/20] mtd: spi-nor: Create a ->set_4byte() method
Thread-Topic: [PATCH v3 09/20] mtd: spi-nor: Create a ->set_4byte() method
Thread-Index: AQHVXAWkR4ql5SNACkOvq8W6tJOwYg==
Date:   Mon, 26 Aug 2019 11:58:58 +0000
Message-ID: <20190826115833.14913-10-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: f8fc8810-a9c8-44a1-4737-08d72a1cc74f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3776;
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3776DC3BE4D2334BC978D741F0A10@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(8676002)(1076003)(2201001)(2501003)(14444005)(256004)(26005)(7736002)(99286004)(66066001)(2906002)(54906003)(76176011)(52116002)(316002)(186003)(50226002)(8936002)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(53936002)(2616005)(36756003)(25786009)(5660300002)(386003)(305945005)(6506007)(102836004)(3846002)(6116002)(446003)(11346002)(478600001)(4326008)(86362001)(6436002)(6486002)(6512007)(14454004)(71200400001)(71190400001)(107886003)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X8fGRDbXDuQw8ibxv7tUhasg0uEBBtSVd4vCQkAaq6QtI6dWcapMFVJbU3jvvlEr/9JPM1kWGRbxrJxZqw15PEapJakPaOT++eENdjP+B+NdtuK0SkZujgbP/HuZwWG6QBfMOrzgCAJWBjzOxWN4n5EPjtfh45pF743vQ8fuej2E+PXcsT0r8oZ+0pz2zm4B5kaD8cwlAtNny+WVvVm0i+W2lNbFIfCt0A2MjPms1Hj6OgI4lEJJU1V0km71etwlc3I5hQv6MKrE3CgeFfkX0cFwGEa4BdxUc3esKcoaswn3UR3BUJ0JeTb+8ExIp1li1GzKgCkkf8ZrzAZfDHUe3HeMLgDCWvQlafDKrGGz0ff0OcvyE9J2I0n4EWHkrm1vYeixmppcI8S8l7Le6Hwx5RTKW5wQdz/V3Npe2Lgnq54=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fc8810-a9c8-44a1-4737-08d72a1cc74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:58.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSqvHOWUo1RB9naC+O4s5qZZ50GfeGPYIDeEB4S3ADEprEaK6KOi2erwm3NLD896dzdJMvl7vfVBdIkgkEY4CMLnm0pAeRzXmz96Gm9tggk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
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
v3: no changes

 drivers/mtd/spi-nor/spi-nor.c | 76 ++++++++++++++++++++++-----------------=
----
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1e7f8dc3457d..235e82a121a1 100644
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
@@ -4222,6 +4223,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
=20
 	/* Initialize legacy flash parameters and settings. */
 	params->quad_enable =3D spansion_quad_enable;
+	params->set_4byte =3D spansion_set_4byte;
=20
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
@@ -4587,7 +4589,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		set_4byte(nor, true);
+		nor->params.set_4byte(nor, true);
 	}
=20
 	return 0;
@@ -4611,7 +4613,7 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		set_4byte(nor, false);
+		nor->params.set_4byte(nor, false);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a86c0d9fb01d..7da89dd483cb 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -482,6 +482,7 @@ struct spi_nor;
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
  * @quad_enable:	enables SPI NOR quad mode.
+ * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -494,6 +495,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_erase_map        erase_map;
=20
 	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte)(struct spi_nor *nor, bool enable);
 };
=20
 /**
--=20
2.9.5

