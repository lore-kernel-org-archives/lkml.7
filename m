Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B292070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="o/Q4Dz6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfHZL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:58:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32105 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbfHZL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:48 -0400
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
IronPort-SDR: Oy4nrTqHTqGuukxyf01VG3FB6YlTUwCQdHRcOHKTPGHMkGJkSlBcvrChx7/TdBPFXc/AX9/PfR
 BMFCNAfs/H6o8xBn+oel5AaGS2haBivj9o45Rl7+4MZUn5Ea7Lei5mcNOmh1tbVs+FPBW3k4pU
 YCRYEoqPwLf8SJdLL8tR4RHoy7EXti4Vb4Teju3WRszO4JMqZPjPbKRlWc580TKrlFqpDXQ9lE
 ICkF9lzsCnIddaPfBWDdKKIYYp5unAy5ct8gXbB+RL2N1fM0btX8zaZdpuvyXN82zRbpTNdZGG
 IrY=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46518693"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:46 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 04:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8mVu9kbzmY2udz+f/AvDmVGyBJP4ny8K3KbETF46RrUGSSYsHclUNOtqLPD9jgBGfFv+yPozRnmRmnxNaWiO6NSZKkGA7y/7YwLf+A1zl01WuXeTKXp1TaNs2Sax6CT3liN0eH+5mbDLMdRRK3px/DGwBx5QN1Q/Wb02bKmP8RpkRX98oMQsWgRlchnxFSh6Y5eYloze3Hrrni+5co6LS9aPUFo2PeDUYpehlGRMnI1iXzZlG2DFSnQtdkx3nnHWSTjTx1lv4l19SUa4WkB+lINs6wKSSApOCOkG5mIf6a0PRYAzhhVhY8JWOaR3L873Q3Uc1nyW7cBLIy95ZubgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq93V070zUXIi/6zi0b4fz3mqqDGUW+oVUd3XOm/RXU=;
 b=dq+tIuUpuWrV0tj4N9YGR2OonK+3mSzby5GioiSQDMpVpSncORWuYNT1xwydTHnQJlQ3Txlz9VMoZsElvCnG8jefQpZjDiVEKkfAZA9ht74oTWU/OPahXde530peip5sj58rJwaDtu7jdxIaEL4b1dYooEZ5+kN9ku6zXazXcr3ZuJRE1JM4xZvBt/00JayugjZdYu/X+klfhUMrMlBWCotNL00pJPzlYHYnwO+IQoThmNNUVPIdyxt0ZFuSwwyrxKVQPewr09mGUtwM+PI3tu3LL9OHTAEtfjzAlfL8fE9WWm+Vh9UrqgdhdURElQTzd36ugyD9etFKkLWhxgaH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq93V070zUXIi/6zi0b4fz3mqqDGUW+oVUd3XOm/RXU=;
 b=o/Q4Dz6zcHUBdwwkOzagW1lHFNWERmkjNZPKhxGe2/FaRcIue2C6+K9J7dWpaH2h0mBlnVT5FzqMsUFrhj36g84XLJYKQqwacJszR3P1439RW9pDC/qNexQpFFFSBeQdGrS1s3TAYJIw/DcY8g9XctGU2Cf96XyBb5myApNTMn8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 02/20] mtd: spi-nor: Use nor->params
Thread-Topic: [PATCH v3 02/20] mtd: spi-nor: Use nor->params
Thread-Index: AQHVXAWdFmiGe/+EPUWdynB8W5OYxQ==
Date:   Mon, 26 Aug 2019 11:58:45 +0000
Message-ID: <20190826115833.14913-3-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: d33026e4-164c-4869-981c-08d72a1cbf60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB435021D03FEC0D8E0F816AF5F0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(76176011)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(446003)(11346002)(14454004)(2906002)(110136005)(2201001)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WESfgAN/6nPFsZAarTbOR4RuWJx7NBTPbpUyAvST9sOA7l6jVV5yMz/Dv4IMAZPNhrKRt70Jx7kS+u4O0v89X9AnNkfTB825c4B8Gf4vVCa1E9JulKjkdeIYBxu1nOOG5PVnhm5u/B0+0sCswZB5zM4X/WbNCt1BRrn00KwYh6lTX3kgdlMsmnFbKQLm/votGrYmqW198Akdxv8lJ0gODSgLFXEKOV5IOAMt0jvM1bDHq4Wa+FM8jteO7HoYhbY+RJr1FiAwcWOVU+6L26EckRIyWxtC6laiQbxeI2ekPpd0msSnj38QI0zm/TtaCr/Cu4mANtVQg8hdP8HS/MwSxJW3khm3MD/UHJ/MemyGygzc9WbfNJ9qgXHQ7FnMGoSw2NcJXCCNYt9JPgbP2MmYnLRq1R3VyQuiqsgPnY2Y7ic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d33026e4-164c-4869-981c-08d72a1cbf60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:45.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3/Dbsc/gUrwZTDf3r2jIKoHggBnbrGxyFoMWEQnV58iDy4LJ8e+wqpQwSgVgpEoVJNEd6r+2tP+I87yjRsacR0Vx+l+wfqSLRmQSPCcJ+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Flash parameters and settings are now stored in 'struct spi_nor'.
Use this instead of the stack allocated params.

Few functions stop passing pointer to params, as they can get it from
'struct spi_nor'. spi_nor_parse_sfdp() and children will keep passing
pointer to params because of the roll-back mechanism: in case the
parsing of SFDP fails, the legacy flash parameter and settings will be
restored.

Zeroing params is no longer needed because all SPI NOR users kzalloc
'struct spi_nor'.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: collect R-b

 drivers/mtd/spi-nor/spi-nor.c | 46 ++++++++++++++++++---------------------=
----
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d35dc6a97521..e9b9cd70a999 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2974,16 +2974,13 @@ static int spi_nor_spimem_check_pp(struct spi_nor *=
nor,
  * spi_nor_spimem_adjust_hwcaps - Find optimal Read/Write protocol
  *                                based on SPI controller capabilities
  * @nor:        pointer to a 'struct spi_nor'
- * @params:     pointer to the 'struct spi_nor_flash_parameter'
- *              representing SPI NOR flash capabilities
  * @hwcaps:     pointer to resulting capabilities after adjusting
  *              according to controller and flash's capability
  */
 static void
-spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor,
-			     const struct spi_nor_flash_parameter *params,
-			     u32 *hwcaps)
+spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 {
+	struct spi_nor_flash_parameter *params =3D  &nor->params;
 	unsigned int cap;
=20
 	/* DTR modes are not supported yet, mask them all. */
@@ -4129,16 +4126,13 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
-static int spi_nor_init_params(struct spi_nor *nor,
-			       struct spi_nor_flash_parameter *params)
+static int spi_nor_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params =3D &nor->params;
 	struct spi_nor_erase_map *map =3D &nor->erase_map;
 	const struct flash_info *info =3D nor->info;
 	u8 i, erase_mask;
=20
-	/* Set legacy flash parameters as default. */
-	memset(params, 0, sizeof(*params));
-
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
 	params->page_size =3D info->page_size;
@@ -4255,7 +4249,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 }
=20
 static int spi_nor_select_read(struct spi_nor *nor,
-			       const struct spi_nor_flash_parameter *params,
 			       u32 shared_hwcaps)
 {
 	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
@@ -4268,7 +4261,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	read =3D &params->reads[cmd];
+	read =3D &nor->params.reads[cmd];
 	nor->read_opcode =3D read->opcode;
 	nor->read_proto =3D read->proto;
=20
@@ -4287,7 +4280,6 @@ static int spi_nor_select_read(struct spi_nor *nor,
 }
=20
 static int spi_nor_select_pp(struct spi_nor *nor,
-			     const struct spi_nor_flash_parameter *params,
 			     u32 shared_hwcaps)
 {
 	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
@@ -4300,7 +4292,7 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	pp =3D &params->page_programs[cmd];
+	pp =3D &nor->params.page_programs[cmd];
 	nor->program_opcode =3D pp->opcode;
 	nor->write_proto =3D pp->proto;
 	return 0;
@@ -4407,9 +4399,9 @@ static int spi_nor_select_erase(struct spi_nor *nor, =
u32 wanted_size)
 }
=20
 static int spi_nor_setup(struct spi_nor *nor,
-			 const struct spi_nor_flash_parameter *params,
 			 const struct spi_nor_hwcaps *hwcaps)
 {
+	struct spi_nor_flash_parameter *params =3D &nor->params;
 	u32 ignored_mask, shared_mask;
 	bool enable_quad_io;
 	int err;
@@ -4426,7 +4418,7 @@ static int spi_nor_setup(struct spi_nor *nor,
 		 * need to discard some of them based on what the SPI
 		 * controller actually supports (using spi_mem_supports_op()).
 		 */
-		spi_nor_spimem_adjust_hwcaps(nor, params, &shared_mask);
+		spi_nor_spimem_adjust_hwcaps(nor, &shared_mask);
 	} else {
 		/*
 		 * SPI n-n-n protocols are not supported when the SPI
@@ -4442,7 +4434,7 @@ static int spi_nor_setup(struct spi_nor *nor,
 	}
=20
 	/* Select the (Fast) Read command. */
-	err =3D spi_nor_select_read(nor, params, shared_mask);
+	err =3D spi_nor_select_read(nor, shared_mask);
 	if (err) {
 		dev_err(nor->dev,
 			"can't select read settings supported by both the SPI controller and me=
mory.\n");
@@ -4450,7 +4442,7 @@ static int spi_nor_setup(struct spi_nor *nor,
 	}
=20
 	/* Select the Page Program command. */
-	err =3D spi_nor_select_pp(nor, params, shared_mask);
+	err =3D spi_nor_select_pp(nor, shared_mask);
 	if (err) {
 		dev_err(nor->dev,
 			"can't select write settings supported by both the SPI controller and m=
emory.\n");
@@ -4553,11 +4545,11 @@ static const struct flash_info *spi_nor_match_id(co=
nst char *name)
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
-	struct spi_nor_flash_parameter params;
 	const struct flash_info *info =3D NULL;
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D &nor->mtd;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
+	struct spi_nor_flash_parameter *params =3D &nor->params;
 	int ret;
 	int i;
=20
@@ -4639,7 +4631,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 		nor->clear_sr_bp =3D spi_nor_clear_sr_bp;
=20
 	/* Parse the Serial Flash Discoverable Parameters table. */
-	ret =3D spi_nor_init_params(nor, &params);
+	ret =3D spi_nor_init_params(nor);
 	if (ret)
 		return ret;
=20
@@ -4649,7 +4641,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	mtd->type =3D MTD_NORFLASH;
 	mtd->writesize =3D 1;
 	mtd->flags =3D MTD_CAP_NORFLASH;
-	mtd->size =3D params.size;
+	mtd->size =3D params->size;
 	mtd->_erase =3D spi_nor_erase;
 	mtd->_read =3D spi_nor_read;
 	mtd->_resume =3D spi_nor_resume;
@@ -4688,18 +4680,18 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 		mtd->flags |=3D MTD_NO_ERASE;
=20
 	mtd->dev.parent =3D dev;
-	nor->page_size =3D params.page_size;
+	nor->page_size =3D params->page_size;
 	mtd->writebufsize =3D nor->page_size;
=20
 	if (np) {
 		/* If we were instantiated by DT, use it */
 		if (of_property_read_bool(np, "m25p,fast-read"))
-			params.hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
+			params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
 		else
-			params.hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
+			params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
 	} else {
 		/* If we weren't instantiated by DT, default to fast-read */
-		params.hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
+		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_FAST;
 	}
=20
 	if (of_property_read_bool(np, "broken-flash-reset"))
@@ -4707,7 +4699,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
=20
 	/* Some devices cannot do fast-read, no matter what DT tells us */
 	if (info->flags & SPI_NOR_NO_FR)
-		params.hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
+		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_FAST;
=20
 	/*
 	 * Configure the SPI memory:
@@ -4716,7 +4708,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	 * - set the SPI protocols for register and memory accesses.
 	 * - set the Quad Enable bit if needed (required by SPI x-y-4 protos).
 	 */
-	ret =3D spi_nor_setup(nor, &params, hwcaps);
+	ret =3D spi_nor_setup(nor, hwcaps);
 	if (ret)
 		return ret;
=20
--=20
2.9.5

