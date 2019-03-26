Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72A720879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="Odh3Kpa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfCZKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:52:38 -0400
Received: from mailout.micron.com ([137.201.242.129]:55844 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:52:37 -0400
Received: from mail.micron.com (bowex17d.micron.com [137.201.21.212])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x2QAqAUg001299;
        Tue, 26 Mar 2019 04:52:10 -0600
Received: from BOWEX17F.micron.com (137.201.21.111) by bowex17d.micron.com
 (137.201.21.212) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 04:52:09 -0600
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (137.201.20.7) by
 BOWEX17F.micron.com (137.201.21.111) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 04:52:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY5W18TZmkfJWr1lJ+HQyxCnp1aZ2XQ9rYPMi/gIFdg=;
 b=Odh3Kpa9hVB50ypNVdnNajVTJKd9jY7U0PDCxGSTJWvRW0kStSlta0aPjzsa3XYbxuWP82F0r5pUJd/HK7eYsLof/STvbXfX3021w6Q4y4Bi4TGiQDSmf0zM6Ouzq8hLCtjLAqOnfcYiRI0hgqXMbnW/7BqD2rS0GC3x4MiC9os=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5856.namprd08.prod.outlook.com (20.179.87.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 26 Mar 2019 10:52:04 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 10:52:04 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 4/4] mtd: spinand: micron: Support for new Micron SPI NAND
 flashes
Thread-Topic: [PATCH 4/4] mtd: spinand: micron: Support for new Micron SPI
 NAND flashes
Thread-Index: AdTjwXc8rC1wT/iQTKuIUBd0ae2YRg==
Date:   Tue, 26 Mar 2019 10:52:04 +0000
Message-ID: <MN2PR08MB5951DEE6417F39426483CF45B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0981bff0-f0db-4445-94b8-08d6b1d91589
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5856;
x-ms-traffictypediagnostic: MN2PR08MB5856:|MN2PR08MB5856:
x-microsoft-antispam-prvs: <MN2PR08MB5856C4074F69CC0FC4ECA449B85F0@MN2PR08MB5856.namprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(486006)(476003)(186003)(52536014)(5660300002)(2501003)(26005)(53936002)(25786009)(102836004)(55236004)(66066001)(6436002)(97736004)(9686003)(478600001)(55016002)(2201001)(33656002)(86362001)(14454004)(2906002)(6116002)(3846002)(14444005)(305945005)(99286004)(71190400001)(71200400001)(8676002)(105586002)(81156014)(81166006)(106356001)(7736002)(68736007)(316002)(256004)(7696005)(74316002)(110136005)(54906003)(6506007)(8936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5856;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1MTM/ybiU+vbd8v7DKi3LOpAmbVyppR9mRz5+5I9yUG+eTwkBVjOteRxMrcgkQ6aiALGU16qcBEZgyKKjzJ8mJO9TXD/boEnm/0sgCyDm7KQ174EEjZZFUuSdeZmWoxVDsaNyHIS2ALc724R6j1sw+ZGB5HAe1kNOE9trxGOncjOgjP/A0s7XRtXZSUs+Huq3aBKBrJSbqZMcw39UWG+5Z/Zxq58+4L38u3Podglc+xO2sT/hmgi8Kt2QFx19zoZpXtYrN3Wc/USKuVoVsr0zGO1DGqfQwOIVNHLhn00f2OI1wsbfeJr8PXG9F/JUoBIGJec3Qe/z7OiWpIcHv4J/taKIu+N2TCMEJGLxJt1Ev+C1OM2zk/gWqR587nlSyQhtvtJirxv17N0N4l2KM6PF4YGzx0v9JDOLo4I65JBLa8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0981bff0-f0db-4445-94b8-08d6b1d91589
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 10:52:04.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5856
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24512.005
X-TM-AS-Result: No--7.629600-0.000000-31
X-TM-AS-MatchedID: 708060-105640-700038-188019-706290-702143-847298-701384-7
        00324-700057-105630-702033-708712-704473-703712-700398-702426-707663-700811
        -700264-702898-702609-709584-705694-704713-701698-703378-700251-148004-1480
        07-148020-148050-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver is redesigned using parameter page to support Micron SPI NAND
flashes.

Support for selecting die is enabled for multi-die flashes.
Turn OOB layout generic.

Fixup some of the parameter page data as per Micron datasheet.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 109 +++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..663bb2809036 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -14,7 +14,7 @@
=20
 #define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
-#define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
+#define MICRON_STATUS_ECC_1TO3_BITFLIPS	BIT(4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
=20
@@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
=20
-static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
+static int ooblayout_ecc(struct mtd_info *mtd, int section,
+			 struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
=20
-	region->offset =3D 64;
-	region->length =3D 64;
+	region->offset =3D mtd->oobsize / 2;
+	region->length =3D mtd->oobsize / 2;
=20
 	return 0;
 }
=20
-static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section=
,
-					 struct mtd_oob_region *region)
+static int ooblayout_free(struct mtd_info *mtd, int section,
+			  struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
=20
 	/* Reserve 2 bytes for the BBM. */
 	region->offset =3D 2;
-	region->length =3D 62;
+	region->length =3D (mtd->oobsize / 2) - 2;
=20
 	return 0;
 }
=20
-static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout =3D {
-	.ecc =3D mt29f2g01abagd_ooblayout_ecc,
-	.free =3D mt29f2g01abagd_ooblayout_free,
+static const struct mtd_ooblayout_ops ooblayout =3D {
+	.ecc =3D ooblayout_ecc,
+	.free =3D ooblayout_free,
 };
=20
-static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
-					 u8 status)
+static int ecc_get_status(struct spinand_device *spinand,
+			  u8 status)
 {
 	switch (status & MICRON_STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -90,22 +90,23 @@ static int mt29f2g01abagd_ecc_get_status(struct spinand=
_device *spinand,
 	return -EINVAL;
 }
=20
-static const struct spinand_info micron_spinand_table[] =3D {
-	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
-		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
-		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
-		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
-};
+static int mt29f8g_select_target(struct spinand_device *spinand,
+				 unsigned int target)
+{
+	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(0xd0,
+							spinand->scratchbuf);
+
+	if (target =3D=3D 1)
+		target =3D 0x40;
+
+	*spinand->scratchbuf =3D target;
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
=20
 static int micron_spinand_detect(struct spinand_device *spinand)
 {
+	const struct spi_mem_op *op;
 	u8 *id =3D spinand->id.data;
-	int ret;
=20
 	/*
 	 * Micron SPI NAND read ID need a dummy byte,
@@ -114,16 +115,66 @@ static int micron_spinand_detect(struct spinand_devic=
e *spinand)
 	if (id[1] !=3D SPINAND_MFR_MICRON)
 		return 0;
=20
-	ret =3D spinand_match_and_init(spinand, micron_spinand_table,
-				     ARRAY_SIZE(micron_spinand_table), id[2]);
-	if (ret)
-		return ret;
+	spinand->flags =3D 0;
+	spinand->eccinfo.get_status =3D ecc_get_status;
+	spinand->eccinfo.ooblayout =3D &ooblayout;
+	spinand->select_target =3D mt29f8g_select_target;
+
+	op =3D spinand_select_op_variant(spinand,
+				       &read_cache_variants);
+	if (!op)
+		return -ENOTSUPP;
+
+	spinand->op_templates.read_cache =3D op;
+
+	op =3D spinand_select_op_variant(spinand,
+				       &write_cache_variants);
+	if (!op)
+		return -ENOTSUPP;
+
+	spinand->op_templates.write_cache =3D op;
+
+	op =3D spinand_select_op_variant(spinand,
+				       &update_cache_variants);
+	spinand->op_templates.update_cache =3D op;
=20
 	return 1;
 }
=20
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * Some of the Micron flashes enable this BIT by default,
+	 * and there is a chance of read failure due to this.
+	 */
+	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
+}
+
+static void micron_fixup_param_page(struct spinand_device *spinand,
+				    struct nand_onfi_params *p)
+{
+	/**
+	 * As per Micron datasheets vendor[88] is defined as
+	 * die_select_feature
+	 */
+	if (p->vendor[83] && !p->interleaved_bits)
+		spinand->base.memorg.planes_per_lun =3D 1 << p->vendor[0];
+
+	spinand->base.memorg.ntargets =3D p->lun_count;
+	spinand->base.memorg.luns_per_target =3D 1;
+
+	/**
+	 * As per Micron datasheets,
+	 * vendor[82] is ECC maximum correctability
+	 */
+	spinand->base.ecc.requirements.strength =3D p->vendor[82];
+	spinand->base.ecc.requirements.step_size =3D 512;
+}
+
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops =3D =
{
 	.detect =3D micron_spinand_detect,
+	.init =3D micron_spinand_init,
+	.fixup_param_page =3D micron_fixup_param_page,
 };
=20
 const struct spinand_manufacturer micron_spinand_manufacturer =3D {
--=20
2.17.1

