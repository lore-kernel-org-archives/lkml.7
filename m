Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C6C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151D5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RZw0H2kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405693AbfIXHqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:09 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:28011 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408088AbfIXHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:08 -0400
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
IronPort-SDR: OJpRs2viNkSNlvl7kUEF9H7hA39oEDDyPqmKDREy1/c+rUax+IdjoBbS6KnSEAYl3HauimmPvT
 TyMnqDExKNe7DcWLwtMNXSYXJM7RL6tvOv8qIZWQPN09UWK6A0Q2Nx+OKaTObfqsU30urrhj4e
 He7HS+aNWJJ0/2g2qy5tZWp9oTCinPRPRPrKQOz1OWWfXoLMGYfvMLi4rXu9wxkE18loS5cA7E
 wOG+c3wQhoBeu2eHJw63vaJwvWavFJp2yQzqma6fbZcElbxPBJsaBlRc0rGifjS9UvFijDXxLv
 TcI=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="50281737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:05 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDyHDVK1Xvm9d1oYWNg39NY1HtxgujJjTtImKD6WqIq7VDIwUPxfVawyNLpaa3gfo2zAnRnnMMMkPwGtqhAHVr9oKHx3V6EE9RmenpKwr+5A6vdDPMtNsOm0peYB667Bw2y/y5YQ6yI5mKAyTS0lIOqNczp0iy97FRXdOpPuE0YiRrmSNDIi1+67oN6CJgJR6Ru0uXt3+i1udcjM6vrfwo9u4r/CBoJxrGD1hh0dLatNZrxpusOoZUPgI6s28sp8XXh8/Whd6m366idUz0EY0sAmBuY59RuQKPFesDiFlQ4PNkxjAzi9N0K70zhJgPjQh1TmIlrCJEp7YrI03oHo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdQW3ZK2q3HvpbebtekZEnLNBc52w5XBKk3JADV4DdM=;
 b=VLsWErlcuSTQ8ITUu/vdk5DPLKjx2qWmBKUbas0Wki/hhb3eyW/8lob+E7U3uNNKxVmrKVu+onRPkH+cvN9msnBpRS8l9TGSbjfUAv6ROq90G4xRGX4Tgr7jkhpCgSuzKsuGouvdt98TwzJ9tiJBIErYRwSyJsC0IHp8nSu+yTPLgG9JhqTALE+0UFc0RWFglZ4A47vNcF2CEAK9glJB0KPe9ZNwTSyYqxQU4oDRwWm9NlJccEhSc6sSS4NEjf8lzZ7OxVWoMwKnetPkVtXZPeFpXZ4fTsT+p0vKXtJPONutRgUJjDD2xLeVkgUWKZ106uztAs746rxSaIT+xOqiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdQW3ZK2q3HvpbebtekZEnLNBc52w5XBKk3JADV4DdM=;
 b=RZw0H2kBUXj8l6df7m8XbeeS/+Wue/Drn73Dz5y5NN8SdOdt0rmAOm9EaGoMeJJ0Lf9HMG85t+PixQNjkBCeY73fpgMkOfWa7S9siYN1fWy2mzePJmbidl2XQhM2W7LNRNcOwb+yYLbe8yXrqlbvIFyGZ5zsUv23JEyMDXaBMhQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:03 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 04/22] mtd: spi-nor: Rename nor->params to nor->flash
Thread-Topic: [PATCH v2 04/22] mtd: spi-nor: Rename nor->params to nor->flash
Thread-Index: AQHVcqwd6l0dKwpZgkWeyuipcOeMgQ==
Date:   Tue, 24 Sep 2019 07:46:03 +0000
Message-ID: <20190924074533.6618-5-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9510b2b-68e7-44d8-0487-08d740c33fc1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4319BDD8CF9E63C23D1850B7F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(52314003)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001)(30864003)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccCn7LTeL4MDC/M1ykI3fmJgDipyBlHJYES2TGHerXEyzRXUZuVuVmBkpzqBbzz9Z3uQ+fHolLcbx4gs1gfvrTePCrvYQf5OyQmGnn/LvGUApKtadb5dfMNQnjSKMI0waQoHhgKnyDE03hemlkZ1HGaSVhn6Dhd0zH4vx1X6glHDdMg7944auiNulvFsiCvw2s4fdjepTiUsRD6AymPLH9zMS5LukyZZxLm6kkBZwZzVEVLiBT2kE6TF5lGaeq9govxog8a3lSggf4FRbLlupdPYTTiDz0bg/stX17c6VfyGsZ/ewC10RsMQLUvQbCCoVzw/s7vd4AHFSaDqxMx8JmMjjBi6mi1KP1AIOqcLvdxPgyRVsSOtC8DovR27xpxOuAQJI01bYHpZ385dWz0yg7txsrpUhf4SGKWFTDFal3M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f9510b2b-68e7-44d8-0487-08d740c33fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:03.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zlixXSOczN4z8YFbar0lERxF9ytl1gKCQmdw/ISefo/tY0o2WF8BbREYsVtJ7gYw6cMxbFGLFwfun3ILl0PxuA8u9swA8zu1Fc6Z8S5CJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename nor->params to nor->flash for a clearer separation
between the controller and flash operations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 286 +++++++++++++++++++++-----------------=
----
 include/linux/mtd/spi-nor.h   |  12 +-
 2 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b8c7ded0f145..7d0c1b598250 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -172,7 +172,7 @@ struct spi_nor_fixups {
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
-			 struct spi_nor_flash_parameter *params);
+			 struct spi_nor_flash_parameter *flash);
 	void (*post_sfdp)(struct spi_nor *nor);
 };
=20
@@ -608,7 +608,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *n=
or)
 	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
=20
 	if (!spi_nor_has_uniform_erase(nor)) {
-		struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+		struct spi_nor_erase_map *map =3D &nor->flash.erase_map;
 		struct spi_nor_erase_type *erase;
 		int i;
=20
@@ -927,10 +927,10 @@ static u32 s3an_convert_addr(struct spi_nor *nor, u32=
 addr)
=20
 static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
 {
-	if (!nor->params.convert_addr)
+	if (!nor->flash.convert_addr)
 		return addr;
=20
-	return nor->params.convert_addr(nor, addr);
+	return nor->flash.convert_addr(nor, addr);
 }
=20
 /*
@@ -1140,7 +1140,7 @@ static int spi_nor_init_erase_cmd_list(struct spi_nor=
 *nor,
 				       struct list_head *erase_list,
 				       u64 addr, u32 len)
 {
-	const struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+	const struct spi_nor_erase_map *map =3D &nor->flash.erase_map;
 	const struct spi_nor_erase_type *erase, *prev_erase =3D NULL;
 	struct spi_nor_erase_region *region;
 	struct spi_nor_erase_command *cmd =3D NULL;
@@ -1628,7 +1628,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->lock(nor, ofs, len);
+	ret =3D nor->flash.locking_ops->lock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
 	return ret;
@@ -1643,7 +1643,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->unlock(nor, ofs, len);
+	ret =3D nor->flash.locking_ops->unlock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
@@ -1658,7 +1658,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, lo=
ff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->is_locked(nor, ofs, len);
+	ret =3D nor->flash.locking_ops->is_locked(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
@@ -2093,7 +2093,7 @@ static int
 is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
 			   const struct sfdp_bfpt *bfpt,
-			   struct spi_nor_flash_parameter *params)
+			   struct spi_nor_flash_parameter *flash)
 {
 	/*
 	 * IS25LP256 supports 4B opcodes, but the BFPT advertises a
@@ -2115,7 +2115,7 @@ static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
 			    const struct sfdp_bfpt *bfpt,
-			    struct spi_nor_flash_parameter *params)
+			    struct spi_nor_flash_parameter *flash)
 {
 	/*
 	 * MX25L25635F supports 4B opcodes but MX25L25635E does not.
@@ -2144,7 +2144,7 @@ static void gd25q256_default_init(struct spi_nor *nor=
)
 	 * indicate the quad_enable method for this case, we need
 	 * to set it in the default_init fixup hook.
 	 */
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->flash.quad_enable =3D macronix_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
@@ -2777,7 +2777,7 @@ static int s3an_nor_setup(struct spi_nor *nor,
 		nor->mtd.erasesize =3D 8 * nor->page_size;
 	} else {
 		/* Flash in Default addressing mode */
-		nor->params.convert_addr =3D s3an_convert_addr;
+		nor->flash.convert_addr =3D s3an_convert_addr;
 		nor->mtd.erasesize =3D nor->info->sector_size;
 	}
=20
@@ -3017,7 +3017,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *no=
r,
 static void
 spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 {
-	struct spi_nor_flash_parameter *params =3D  &nor->params;
+	struct spi_nor_flash_parameter *flash =3D  &nor->flash;
 	unsigned int cap;
=20
 	/* DTR modes are not supported yet, mask them all. */
@@ -3034,7 +3034,7 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32=
 *hwcaps)
=20
 		rdidx =3D spi_nor_hwcaps_read2cmd(BIT(cap));
 		if (rdidx >=3D 0 &&
-		    spi_nor_spimem_check_readop(nor, &params->reads[rdidx]))
+		    spi_nor_spimem_check_readop(nor, &flash->reads[rdidx]))
 			*hwcaps &=3D ~BIT(cap);
=20
 		ppidx =3D spi_nor_hwcaps_pp2cmd(BIT(cap));
@@ -3042,7 +3042,7 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32=
 *hwcaps)
 			continue;
=20
 		if (spi_nor_spimem_check_pp(nor,
-					    &params->page_programs[ppidx]))
+					    &flash->page_programs[ppidx]))
 			*hwcaps &=3D ~BIT(cap);
 	}
 }
@@ -3091,7 +3091,7 @@ spi_nor_set_read_settings_from_bfpt(struct spi_nor_re=
ad_command *read,
 }
=20
 struct sfdp_bfpt_read {
-	/* The Fast Read x-y-z hardware capability in params->hwcaps.mask. */
+	/* The Fast Read x-y-z hardware capability in flash->hwcaps.mask. */
 	u32			hwcaps;
=20
 	/*
@@ -3322,11 +3322,11 @@ static int
 spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
-			 struct spi_nor_flash_parameter *params)
+			 struct spi_nor_flash_parameter *flash)
 {
 	if (nor->info->fixups && nor->info->fixups->post_bfpt)
 		return nor->info->fixups->post_bfpt(nor, bfpt_header, bfpt,
-						    params);
+						    flash);
=20
 	return 0;
 }
@@ -3336,7 +3336,7 @@ spi_nor_post_bfpt_fixups(struct spi_nor *nor,
  * @nor:		pointer to a 'struct spi_nor'
  * @bfpt_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the Basic Flash Parameter Table length and version
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
+ * @flash:		pointer to the 'struct spi_nor_flash_parameter' to be
  *			filled
  *
  * The Basic Flash Parameter Table is the main and only mandatory table as
@@ -3363,9 +3363,9 @@ spi_nor_post_bfpt_fixups(struct spi_nor *nor,
  */
 static int spi_nor_parse_bfpt(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *bfpt_header,
-			      struct spi_nor_flash_parameter *params)
+			      struct spi_nor_flash_parameter *flash)
 {
-	struct spi_nor_erase_map *map =3D &params->erase_map;
+	struct spi_nor_erase_map *map =3D &flash->erase_map;
 	struct spi_nor_erase_type *erase_type =3D map->erase_type;
 	struct sfdp_bfpt bfpt;
 	size_t len;
@@ -3406,23 +3406,23 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	}
=20
 	/* Flash Memory Density (in bits). */
-	params->size =3D bfpt.dwords[BFPT_DWORD(2)];
-	if (params->size & BIT(31)) {
-		params->size &=3D ~BIT(31);
+	flash->size =3D bfpt.dwords[BFPT_DWORD(2)];
+	if (flash->size & BIT(31)) {
+		flash->size &=3D ~BIT(31);
=20
 		/*
-		 * Prevent overflows on params->size. Anyway, a NOR of 2^64
+		 * Prevent overflows on flash->size. Anyway, a NOR of 2^64
 		 * bits is unlikely to exist so this error probably means
 		 * the BFPT we are reading is corrupted/wrong.
 		 */
-		if (params->size > 63)
+		if (flash->size > 63)
 			return -EINVAL;
=20
-		params->size =3D 1ULL << params->size;
+		flash->size =3D 1ULL << flash->size;
 	} else {
-		params->size++;
+		flash->size++;
 	}
-	params->size >>=3D 3; /* Convert to bytes. */
+	flash->size >>=3D 3; /* Convert to bytes. */
=20
 	/* Fast Read settings. */
 	for (i =3D 0; i < ARRAY_SIZE(sfdp_bfpt_reads); i++) {
@@ -3430,13 +3430,13 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		struct spi_nor_read_command *read;
=20
 		if (!(bfpt.dwords[rd->supported_dword] & rd->supported_bit)) {
-			params->hwcaps.mask &=3D ~rd->hwcaps;
+			flash->hwcaps.mask &=3D ~rd->hwcaps;
 			continue;
 		}
=20
-		params->hwcaps.mask |=3D rd->hwcaps;
+		flash->hwcaps.mask |=3D rd->hwcaps;
 		cmd =3D spi_nor_hwcaps_read2cmd(rd->hwcaps);
-		read =3D &params->reads[cmd];
+		read =3D &flash->reads[cmd];
 		half =3D bfpt.dwords[rd->settings_dword] >> rd->settings_shift;
 		spi_nor_set_read_settings_from_bfpt(read, half, rd->proto);
 	}
@@ -3446,7 +3446,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	 * Erase Types defined in the bfpt table.
 	 */
 	erase_mask =3D 0;
-	memset(&params->erase_map, 0, sizeof(params->erase_map));
+	memset(&flash->erase_map, 0, sizeof(flash->erase_map));
 	for (i =3D 0; i < ARRAY_SIZE(sfdp_bfpt_erases); i++) {
 		const struct sfdp_bfpt_erase *er =3D &sfdp_bfpt_erases[i];
 		u32 erasesize;
@@ -3465,7 +3465,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		spi_nor_set_erase_settings_from_bfpt(&erase_type[i], erasesize,
 						     opcode, i);
 	}
-	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+	spi_nor_init_uniform_erase_map(map, erase_mask, flash->size);
 	/*
 	 * Sort all the map's Erase Types in ascending order with the smallest
 	 * erase size being the first member in the erase_type array.
@@ -3483,43 +3483,42 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
=20
 	/* Stop here if not JESD216 rev A or later. */
 	if (bfpt_header->length < BFPT_DWORD_MAX)
-		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
-						params);
+		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, flash);
=20
 	/* Page size: this field specifies 'N' so the page size =3D 2^N bytes. */
-	params->page_size =3D bfpt.dwords[BFPT_DWORD(11)];
-	params->page_size &=3D BFPT_DWORD11_PAGE_SIZE_MASK;
-	params->page_size >>=3D BFPT_DWORD11_PAGE_SIZE_SHIFT;
-	params->page_size =3D 1U << params->page_size;
+	flash->page_size =3D bfpt.dwords[BFPT_DWORD(11)];
+	flash->page_size &=3D BFPT_DWORD11_PAGE_SIZE_MASK;
+	flash->page_size >>=3D BFPT_DWORD11_PAGE_SIZE_SHIFT;
+	flash->page_size =3D 1U << flash->page_size;
=20
 	/* Quad Enable Requirements. */
 	switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
 	case BFPT_DWORD15_QER_NONE:
-		params->quad_enable =3D NULL;
+		flash->quad_enable =3D NULL;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
-		params->quad_enable =3D spansion_no_read_cr_quad_enable;
+		flash->quad_enable =3D spansion_no_read_cr_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
-		params->quad_enable =3D macronix_quad_enable;
+		flash->quad_enable =3D macronix_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
-		params->quad_enable =3D sr2_bit7_quad_enable;
+		flash->quad_enable =3D sr2_bit7_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1:
-		params->quad_enable =3D spansion_read_cr_quad_enable;
+		flash->quad_enable =3D spansion_read_cr_quad_enable;
 		break;
=20
 	default:
 		return -EINVAL;
 	}
=20
-	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
+	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, flash);
 }
=20
 #define SMPT_CMD_ADDRESS_LEN_MASK		GENMASK(23, 22)
@@ -3721,7 +3720,7 @@ spi_nor_region_check_overlay(struct spi_nor_erase_reg=
ion *region,
 /**
  * spi_nor_init_non_uniform_erase_map() - initialize the non-uniform erase=
 map
  * @nor:	pointer to a 'struct spi_nor'
- * @params:     pointer to a duplicate 'struct spi_nor_flash_parameter' th=
at is
+ * @flash:	pointer to a duplicate 'struct spi_nor_flash_parameter' that is
  *              used for storing SFDP parsed data
  * @smpt:	pointer to the sector map parameter table
  *
@@ -3729,10 +3728,10 @@ spi_nor_region_check_overlay(struct spi_nor_erase_r=
egion *region,
  */
 static int
 spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
-				   struct spi_nor_flash_parameter *params,
+				   struct spi_nor_flash_parameter *flash,
 				   const u32 *smpt)
 {
-	struct spi_nor_erase_map *map =3D &params->erase_map;
+	struct spi_nor_erase_map *map =3D &flash->erase_map;
 	struct spi_nor_erase_type *erase =3D map->erase_type;
 	struct spi_nor_erase_region *region;
 	u64 offset;
@@ -3811,7 +3810,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *no=
r,
  * spi_nor_parse_smpt() - parse Sector Map Parameter Table
  * @nor:		pointer to a 'struct spi_nor'
  * @smpt_header:	sector map parameter table header
- * @params:		pointer to a duplicate 'struct spi_nor_flash_parameter'
+ * @flash:		pointer to a duplicate 'struct spi_nor_flash_parameter'
  *                      that is used for storing SFDP parsed data
  *
  * This table is optional, but when available, we parse it to identify the
@@ -3822,7 +3821,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *no=
r,
  */
 static int spi_nor_parse_smpt(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *smpt_header,
-			      struct spi_nor_flash_parameter *params)
+			      struct spi_nor_flash_parameter *flash)
 {
 	const u32 *sector_map;
 	u32 *smpt;
@@ -3851,11 +3850,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 		goto out;
 	}
=20
-	ret =3D spi_nor_init_non_uniform_erase_map(nor, params, sector_map);
+	ret =3D spi_nor_init_non_uniform_erase_map(nor, flash, sector_map);
 	if (ret)
 		goto out;
=20
-	spi_nor_regions_sort_erase_types(&params->erase_map);
+	spi_nor_regions_sort_erase_types(&flash->erase_map);
 	/* fall through */
 out:
 	kfree(smpt);
@@ -3880,13 +3879,13 @@ struct sfdp_4bait {
  * @nor:		pointer to a 'struct spi_nor'.
  * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the 4-Byte Address Instruction Table length and version.
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ * @flash:		pointer to the 'struct spi_nor_flash_parameter' to be.
  *
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_4bait(struct spi_nor *nor,
 			       const struct sfdp_parameter_header *param_header,
-			       struct spi_nor_flash_parameter *params)
+			       struct spi_nor_flash_parameter *flash)
 {
 	static const struct sfdp_4bait reads[] =3D {
 		{ SNOR_HWCAPS_READ,		BIT(0) },
@@ -3910,8 +3909,8 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ 0u /* not used */,		BIT(11) },
 		{ 0u /* not used */,		BIT(12) },
 	};
-	struct spi_nor_pp_command *params_pp =3D params->page_programs;
-	struct spi_nor_erase_map *map =3D &params->erase_map;
+	struct spi_nor_pp_command *flash_pp =3D flash->page_programs;
+	struct spi_nor_erase_map *map =3D &flash->erase_map;
 	struct spi_nor_erase_type *erase_type =3D map->erase_type;
 	u32 *dwords;
 	size_t len;
@@ -3949,7 +3948,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		const struct sfdp_4bait *read =3D &reads[i];
=20
 		discard_hwcaps |=3D read->hwcaps;
-		if ((params->hwcaps.mask & read->hwcaps) &&
+		if ((flash->hwcaps.mask & read->hwcaps) &&
 		    (dwords[0] & read->supported_bit))
 			read_hwcaps |=3D read->hwcaps;
 	}
@@ -3965,7 +3964,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		/*
 		 * The 4 Byte Address Instruction (Optional) Table is the only
 		 * SFDP table that indicates support for Page Program Commands.
-		 * Bypass the params->hwcaps.mask and consider 4BAIT the biggest
+		 * Bypass the flash->hwcaps.mask and consider 4BAIT the biggest
 		 * authority for specifying Page Program support.
 		 */
 		discard_hwcaps |=3D program->hwcaps;
@@ -4000,26 +3999,26 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	 * Discard all operations from the 4-byte instruction set which are
 	 * not supported by this memory.
 	 */
-	params->hwcaps.mask &=3D ~discard_hwcaps;
-	params->hwcaps.mask |=3D (read_hwcaps | pp_hwcaps);
+	flash->hwcaps.mask &=3D ~discard_hwcaps;
+	flash->hwcaps.mask |=3D (read_hwcaps | pp_hwcaps);
=20
 	/* Use the 4-byte address instruction set. */
 	for (i =3D 0; i < SNOR_CMD_READ_MAX; i++) {
-		struct spi_nor_read_command *read_cmd =3D &params->reads[i];
+		struct spi_nor_read_command *read_cmd =3D &flash->reads[i];
=20
 		read_cmd->opcode =3D spi_nor_convert_3to4_read(read_cmd->opcode);
 	}
=20
 	/* 4BAIT is the only SFDP table that indicates page program support. */
 	if (pp_hwcaps & SNOR_HWCAPS_PP)
-		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP],
+		spi_nor_set_pp_settings(&flash_pp[SNOR_CMD_PP],
 					SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
 	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_4)
-		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_4],
+		spi_nor_set_pp_settings(&flash_pp[SNOR_CMD_PP_1_1_4],
 					SPINOR_OP_PP_1_1_4_4B,
 					SNOR_PROTO_1_1_4);
 	if (pp_hwcaps & SNOR_HWCAPS_PP_1_4_4)
-		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
+		spi_nor_set_pp_settings(&flash_pp[SNOR_CMD_PP_1_4_4],
 					SPINOR_OP_PP_1_4_4_4B,
 					SNOR_PROTO_1_4_4);
=20
@@ -4050,7 +4049,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
+ * @flash:		pointer to the 'struct spi_nor_flash_parameter' to be
  *			filled
  *
  * The Serial Flash Discoverable Parameters are described by the JEDEC JES=
D216
@@ -4062,7 +4061,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_sfdp(struct spi_nor *nor,
-			      struct spi_nor_flash_parameter *params)
+			      struct spi_nor_flash_parameter *flash)
 {
 	const struct sfdp_parameter_header *param_header, *bfpt_header;
 	struct sfdp_parameter_header *param_headers =3D NULL;
@@ -4131,7 +4130,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 			bfpt_header =3D param_header;
 	}
=20
-	err =3D spi_nor_parse_bfpt(nor, bfpt_header, params);
+	err =3D spi_nor_parse_bfpt(nor, bfpt_header, flash);
 	if (err)
 		goto exit;
=20
@@ -4141,11 +4140,11 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
=20
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
-			err =3D spi_nor_parse_smpt(nor, param_header, params);
+			err =3D spi_nor_parse_smpt(nor, param_header, flash);
 			break;
=20
 		case SFDP_4BAIT_ID:
-			err =3D spi_nor_parse_4bait(nor, param_header, params);
+			err =3D spi_nor_parse_4bait(nor, param_header, flash);
 			break;
=20
 		default:
@@ -4183,7 +4182,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	read =3D &nor->params.reads[cmd];
+	read =3D &nor->flash.reads[cmd];
 	nor->read_opcode =3D read->opcode;
 	nor->read_proto =3D read->proto;
=20
@@ -4214,7 +4213,7 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	pp =3D &nor->params.page_programs[cmd];
+	pp =3D &nor->flash.page_programs[cmd];
 	nor->program_opcode =3D pp->opcode;
 	nor->write_proto =3D pp->proto;
 	return 0;
@@ -4275,7 +4274,7 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map=
 *map,
=20
 static int spi_nor_select_erase(struct spi_nor *nor)
 {
-	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+	struct spi_nor_erase_map *map =3D &nor->flash.erase_map;
 	const struct spi_nor_erase_type *erase =3D NULL;
 	struct mtd_info *mtd =3D &nor->mtd;
 	u32 wanted_size =3D nor->info->sector_size;
@@ -4324,7 +4323,7 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 static int spi_nor_default_setup(struct spi_nor *nor,
 				 const struct spi_nor_hwcaps *hwcaps)
 {
-	struct spi_nor_flash_parameter *params =3D &nor->params;
+	struct spi_nor_flash_parameter *flash =3D &nor->flash;
 	u32 ignored_mask, shared_mask;
 	int err;
=20
@@ -4332,7 +4331,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	 * Keep only the hardware capabilities supported by both the SPI
 	 * controller and the SPI flash memory.
 	 */
-	shared_mask =3D hwcaps->mask & params->hwcaps.mask;
+	shared_mask =3D hwcaps->mask & flash->hwcaps.mask;
=20
 	if (nor->spimem) {
 		/*
@@ -4385,36 +4384,36 @@ static int spi_nor_default_setup(struct spi_nor *no=
r,
 static int spi_nor_setup(struct spi_nor *nor,
 			 const struct spi_nor_hwcaps *hwcaps)
 {
-	if (!nor->params.setup)
+	if (!nor->flash.setup)
 		return 0;
=20
-	return nor->params.setup(nor, hwcaps);
+	return nor->flash.setup(nor, hwcaps);
 }
=20
 static void macronix_set_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D macronix_quad_enable;
-	nor->params.set_4byte =3D macronix_set_4byte;
+	nor->flash.quad_enable =3D macronix_quad_enable;
+	nor->flash.set_4byte =3D macronix_set_4byte;
 }
=20
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
 	nor->flags |=3D SNOR_F_HAS_LOCK;
-	nor->params.quad_enable =3D NULL;
-	nor->params.set_4byte =3D st_micron_set_4byte;
+	nor->flash.quad_enable =3D NULL;
+	nor->flash.set_4byte =3D st_micron_set_4byte;
 }
=20
 static void winbond_set_default_init(struct spi_nor *nor)
 {
-	nor->params.set_4byte =3D winbond_set_4byte;
+	nor->flash.set_4byte =3D winbond_set_4byte;
 }
=20
 /**
- * spi_nor_manufacturer_init_params() - Initialize the flash's parameters =
and
- * settings based on MFR register and ->default_init() hook.
+ * spi_nor_manufacturer_init_flash_params() - Initialize the flash's
+ * parameters and settings based on MFR register and ->default_init() hook=
.
  * @nor:	pointer to a 'struct spi-nor'.
  */
-static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
+static void spi_nor_manufacturer_init_flash_params(struct spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
@@ -4440,93 +4439,93 @@ static void spi_nor_manufacturer_init_params(struct=
 spi_nor *nor)
 }
=20
 /**
- * spi_nor_sfdp_init_params() - Initialize the flash's parameters and sett=
ings
- * based on JESD216 SFDP standard.
+ * spi_nor_sfdp_init_flash_params() - Initialize the flash's parameters an=
d
+ * settings based on JESD216 SFDP standard.
  * @nor:	pointer to a 'struct spi-nor'.
  *
  * The method has a roll-back mechanism: in case the SFDP parsing fails, t=
he
  * legacy flash parameters and settings will be restored.
  */
-static void spi_nor_sfdp_init_params(struct spi_nor *nor)
+static void spi_nor_sfdp_init_flash_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter sfdp_params;
+	struct spi_nor_flash_parameter sfdp_flash;
=20
-	memcpy(&sfdp_params, &nor->params, sizeof(sfdp_params));
+	memcpy(&sfdp_flash, &nor->flash, sizeof(sfdp_flash));
=20
-	if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
+	if (spi_nor_parse_sfdp(nor, &sfdp_flash)) {
 		nor->addr_width =3D 0;
 		nor->flags &=3D ~SNOR_F_4B_OPCODES;
 	} else {
-		memcpy(&nor->params, &sfdp_params, sizeof(nor->params));
+		memcpy(&nor->flash, &sfdp_flash, sizeof(nor->flash));
 	}
 }
=20
 /**
- * spi_nor_info_init_params() - Initialize the flash's parameters and sett=
ings
- * based on nor->info data.
+ * spi_nor_info_init_flash_params() - Initialize the flash's parameters an=
d
+ * settings based on nor->info data.
  * @nor:	pointer to a 'struct spi-nor'.
  */
-static void spi_nor_info_init_params(struct spi_nor *nor)
+static void spi_nor_info_init_flash_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params =3D &nor->params;
-	struct spi_nor_erase_map *map =3D &params->erase_map;
+	struct spi_nor_flash_parameter *flash =3D &nor->flash;
+	struct spi_nor_erase_map *map =3D &flash->erase_map;
 	const struct flash_info *info =3D nor->info;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
-	params->quad_enable =3D spansion_quad_enable;
-	params->set_4byte =3D spansion_set_4byte;
-	params->setup =3D spi_nor_default_setup;
+	flash->quad_enable =3D spansion_quad_enable;
+	flash->set_4byte =3D spansion_set_4byte;
+	flash->setup =3D spi_nor_default_setup;
=20
 	/* Set SPI NOR sizes. */
-	params->size =3D (u64)info->sector_size * info->n_sectors;
-	params->page_size =3D info->page_size;
+	flash->size =3D (u64)info->sector_size * info->n_sectors;
+	flash->page_size =3D info->page_size;
=20
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
+		flash->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
=20
 		/* Mask out Fast Read if not requested at DT instantiation. */
 		if (np && !of_property_read_bool(np, "m25p,fast-read"))
-			params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
+			flash->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
 	}
=20
 	/* (Fast) Read settings. */
-	params->hwcaps.mask |=3D SNOR_HWCAPS_READ;
-	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ],
+	flash->hwcaps.mask |=3D SNOR_HWCAPS_READ;
+	spi_nor_set_read_settings(&flash->reads[SNOR_CMD_READ],
 				  0, 0, SPINOR_OP_READ,
 				  SNOR_PROTO_1_1_1);
=20
-	if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
-		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_FAST],
+	if (flash->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
+		spi_nor_set_read_settings(&flash->reads[SNOR_CMD_READ_FAST],
 					  0, 8, SPINOR_OP_READ_FAST,
 					  SNOR_PROTO_1_1_1);
=20
 	if (info->flags & SPI_NOR_DUAL_READ) {
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_2;
-		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
+		flash->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_2;
+		spi_nor_set_read_settings(&flash->reads[SNOR_CMD_READ_1_1_2],
 					  0, 8, SPINOR_OP_READ_1_1_2,
 					  SNOR_PROTO_1_1_2);
 	}
=20
 	if (info->flags & SPI_NOR_QUAD_READ) {
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
-		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
+		flash->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
+		spi_nor_set_read_settings(&flash->reads[SNOR_CMD_READ_1_1_4],
 					  0, 8, SPINOR_OP_READ_1_1_4,
 					  SNOR_PROTO_1_1_4);
 	}
=20
 	if (info->flags & SPI_NOR_OCTAL_READ) {
-		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
-		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+		flash->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+		spi_nor_set_read_settings(&flash->reads[SNOR_CMD_READ_1_1_8],
 					  0, 8, SPINOR_OP_READ_1_1_8,
 					  SNOR_PROTO_1_1_8);
 	}
=20
 	/* Page Program settings. */
-	params->hwcaps.mask |=3D SNOR_HWCAPS_PP;
-	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
+	flash->hwcaps.mask |=3D SNOR_HWCAPS_PP;
+	spi_nor_set_pp_settings(&flash->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
=20
 	/*
@@ -4549,7 +4548,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	erase_mask |=3D BIT(i);
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
-	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+	spi_nor_init_uniform_erase_map(map, erase_mask, flash->size);
 }
=20
 static void spansion_post_sfdp_fixups(struct spi_nor *nor)
@@ -4567,7 +4566,7 @@ static void spansion_post_sfdp_fixups(struct spi_nor =
*nor)
=20
 static void s3an_post_sfdp_fixups(struct spi_nor *nor)
 {
-	nor->params.setup =3D s3an_nor_setup;
+	nor->flash.setup =3D s3an_nor_setup;
 }
=20
 /**
@@ -4599,24 +4598,25 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor=
 *nor)
 }
=20
 /**
- * spi_nor_late_init_params() - Late initialization of default flash param=
eters.
+ * spi_nor_late_init_flash_params() - Late initialization of default flash
+ * parameters.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Used to set default flash parameters and settings when the ->default_in=
it()
  * hook or the SFDP parser let voids.
  */
-static void spi_nor_late_init_params(struct spi_nor *nor)
+static void spi_nor_late_init_flash_params(struct spi_nor *nor)
 {
 	/*
 	 * NOR protection support. When locking_ops are not provided, we pick
 	 * the default ones.
 	 */
-	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params.locking_ops)
-		nor->params.locking_ops =3D &stm_locking_ops;
+	if (nor->flags & SNOR_F_HAS_LOCK && !nor->flash.locking_ops)
+		nor->flash.locking_ops =3D &stm_locking_ops;
 }
=20
 /**
- * spi_nor_init_params() - Initialize the flash's parameters and settings.
+ * spi_nor_init_flash_params() - Initialize the flash's parameters and set=
tings.
  * @nor:	pointer to a 'struct spi-nor'.
  *
  * The flash parameters and settings are initialized based on a sequence o=
f
@@ -4624,18 +4624,18 @@ static void spi_nor_late_init_params(struct spi_nor=
 *nor)
  *
  * 1/ Default flash parameters initialization. The initializations are don=
e
  *    based on nor->info data:
- *		spi_nor_info_init_params()
+ *		spi_nor_info_init_flash_params()
  *
  * which can be overwritten by:
  * 2/ Manufacturer flash parameters initialization. The initializations ar=
e
  *    done based on MFR register, or when the decisions can not be done so=
lely
  *    based on MFR, by using specific flash_info tweeks, ->default_init():
- *		spi_nor_manufacturer_init_params()
+ *		spi_nor_manufacturer_init_flash_params()
  *
  * which can be overwritten by:
  * 3/ SFDP flash parameters initialization. JESD216 SFDP is a standard and
  *    should be more accurate that the above.
- *		spi_nor_sfdp_init_params()
+ *		spi_nor_sfdp_init_flash_params()
  *
  *    Please note that there is a ->post_bfpt() fixup hook that can overwr=
ite
  *    the flash parameters and settings immediately after parsing the Basi=
c
@@ -4649,22 +4649,22 @@ static void spi_nor_late_init_params(struct spi_nor=
 *nor)
  *		spi_nor_post_sfdp_fixups()
  *
  * 5/ Late default flash parameters initialization, used when the
- * ->default_init() hook or the SFDP parser do not set specific params.
- *		spi_nor_late_init_params()
+ * ->default_init() hook or the SFDP parser do not set specific flash para=
ms.
+ *		spi_nor_late_init_flash_params()
  */
-static void spi_nor_init_params(struct spi_nor *nor)
+static void spi_nor_init_flash_params(struct spi_nor *nor)
 {
-	spi_nor_info_init_params(nor);
+	spi_nor_info_init_flash_params(nor);
=20
-	spi_nor_manufacturer_init_params(nor);
+	spi_nor_manufacturer_init_flash_params(nor);
=20
 	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
-		spi_nor_sfdp_init_params(nor);
+		spi_nor_sfdp_init_flash_params(nor);
=20
 	spi_nor_post_sfdp_fixups(nor);
=20
-	spi_nor_late_init_params(nor);
+	spi_nor_late_init_flash_params(nor);
 }
=20
 /**
@@ -4675,14 +4675,14 @@ static void spi_nor_init_params(struct spi_nor *nor=
)
  */
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
-	if (!nor->params.quad_enable)
+	if (!nor->flash.quad_enable)
 		return 0;
=20
 	if (!(spi_nor_get_protocol_width(nor->read_proto) =3D=3D 4 ||
 	      spi_nor_get_protocol_width(nor->write_proto) =3D=3D 4))
 		return 0;
=20
-	return nor->params.quad_enable(nor);
+	return nor->flash.quad_enable(nor);
 }
=20
 static int spi_nor_init(struct spi_nor *nor)
@@ -4690,7 +4690,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	int err;
=20
 	if (nor->clear_sr_bp) {
-		if (nor->params.quad_enable =3D=3D spansion_quad_enable)
+		if (nor->flash.quad_enable =3D=3D spansion_quad_enable)
 			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
=20
 		err =3D nor->clear_sr_bp(nor);
@@ -4717,7 +4717,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		nor->params.set_4byte(nor, true);
+		nor->flash.set_4byte(nor, true);
 	}
=20
 	return 0;
@@ -4741,7 +4741,7 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		nor->params.set_4byte(nor, false);
+		nor->flash.set_4byte(nor, false);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
@@ -4841,7 +4841,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D &nor->mtd;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
-	struct spi_nor_flash_parameter *params =3D &nor->params;
+	struct spi_nor_flash_parameter *flash =3D &nor->flash;
 	int ret;
 	int i;
=20
@@ -4900,7 +4900,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 		nor->clear_sr_bp =3D spi_nor_clear_sr_bp;
=20
 	/* Init flash parameters based on flash_info struct and SFDP */
-	spi_nor_init_params(nor);
+	spi_nor_init_flash_params(nor);
=20
 	if (!mtd->name)
 		mtd->name =3D dev_name(dev);
@@ -4908,12 +4908,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 	mtd->type =3D MTD_NORFLASH;
 	mtd->writesize =3D 1;
 	mtd->flags =3D MTD_CAP_NORFLASH;
-	mtd->size =3D params->size;
+	mtd->size =3D flash->size;
 	mtd->_erase =3D spi_nor_erase;
 	mtd->_read =3D spi_nor_read;
 	mtd->_resume =3D spi_nor_resume;
=20
-	if (nor->params.locking_ops) {
+	if (nor->flash.locking_ops) {
 		mtd->_lock =3D spi_nor_lock;
 		mtd->_unlock =3D spi_nor_unlock;
 		mtd->_is_locked =3D spi_nor_is_locked;
@@ -4938,7 +4938,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 		mtd->flags |=3D MTD_NO_ERASE;
=20
 	mtd->dev.parent =3D dev;
-	nor->page_size =3D params->page_size;
+	nor->page_size =3D flash->page_size;
 	mtd->writebufsize =3D nor->page_size;
=20
 	if (of_property_read_bool(np, "broken-flash-reset"))
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1d736d3c8ab..12961b157743 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -580,10 +580,10 @@ struct flash_info;
  * @controller_ops:	SPI NOR controller driver specific operations.
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
- * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
- *                      The structure includes legacy flash parameters and
- *                      settings that can be overwritten by the spi_nor_fi=
xups
- *                      hooks, or dynamically when parsing the SFDP tables=
.
+ * @flash:		SPI-NOR flash parameters and settings. The structure
+ *			includes default flash parameters and settings that can
+ *			be overwritten by the spi_nor_fixups hooks, or
+ *			dynamically when parsing the SFDP tables.
  * @priv:		the private data
  */
 struct spi_nor {
@@ -609,7 +609,7 @@ struct spi_nor {
 	const struct spi_nor_controller_ops *controller_ops;
=20
 	int (*clear_sr_bp)(struct spi_nor *nor);
-	struct spi_nor_flash_parameter params;
+	struct spi_nor_flash_parameter flash;
=20
 	void *priv;
 };
@@ -640,7 +640,7 @@ spi_nor_region_mark_overlay(struct spi_nor_erase_region=
 *region)
=20
 static bool __maybe_unused spi_nor_has_uniform_erase(const struct spi_nor =
*nor)
 {
-	return !!nor->params.erase_map.uniform_erase_type;
+	return !!nor->flash.erase_map.uniform_erase_type;
 }
=20
 static inline void spi_nor_set_flash_node(struct spi_nor *nor,
--=20
2.9.5

