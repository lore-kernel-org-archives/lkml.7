Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B6BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2482808B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="iJuROvXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfFCMnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:49 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:2273
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbfFCMnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skVTVpmyDnVjmY+AO91/mTt7RRgqvjAvvDf9aafyZT8=;
 b=iJuROvXCXXG3zB+loxW53+pcmv0B3tiVdWGLscDsCQ4dM1yX817EM5mfqiwSoYPu8svsJ/uIO9zwfD4RhFSU1atR6MqzhNuJ2KAN7RjG1q9/zlfz7BIGYgb9U9RgdvSz0qlWg7HFOxWim0J90YZGOdF+6aCvNX0ntg4J56rMLAE=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5854.namprd08.prod.outlook.com (20.179.98.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 12:43:41 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:41 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/12] mtd: spinand: micron: Turn driver implementation
 generic
Thread-Topic: [PATCH v3 10/12] mtd: spinand: micron: Turn driver
 implementation generic
Thread-Index: AdUaBqb+3XDXliAWScaae8Cx8G5hOQ==
Date:   Mon, 3 Jun 2019 12:43:40 +0000
Message-ID: <MN2PR08MB5951DE2283DE0E9A0F9918F1B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cabcd10-5ade-4215-db7c-08d6e8211b6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB5854;
x-ms-traffictypediagnostic: MN2PR08MB5854:|MN2PR08MB5854:
x-microsoft-antispam-prvs: <MN2PR08MB5854315DE618FB8B73CC88DBB8140@MN2PR08MB5854.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(5660300002)(81166006)(8936002)(7696005)(14444005)(7736002)(8676002)(305945005)(55016002)(256004)(2501003)(81156014)(102836004)(2906002)(110136005)(6506007)(25786009)(55236004)(33656002)(76116006)(476003)(73956011)(66066001)(66556008)(66946007)(26005)(99286004)(64756008)(486006)(66446008)(186003)(66476007)(52536014)(6436002)(74316002)(9686003)(6116002)(3846002)(2201001)(14454004)(7416002)(86362001)(316002)(53936002)(71190400001)(71200400001)(68736007)(478600001)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5854;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bb8TCnH2V5EEWWHEYbYlwExqWMjvEeyNksM3nM6jjwXCGmRk7X+tXsC1l4bHoiaR06YfYqL2fFyhd+uL8txvo86kWYrvWGCVt0TFWbnNo+sT5vZ75OTEVtsfR8ChaGjju79ftrBG3JUl1JwifOOS2OvNc7v+6CM20hVKfKXwM0fnd78ZcVlQRrjHIgYR5NAIuLNME1O0JjLUybXNSX5Y0h8aOXAu2zxjapLZFiZE/l4iypnk4cAM+JDNMlnDKubk6NBBkR2mE2AANvYmrKzHG+WDdvmsJwgSUwxAehjH/5ixhXNUpQQ1nOzPyjgKX8UKmrzuZjujxnDCWFO6S9AoySRvfJPM25zb/xvhS2Sa6r0YsgQlvox4EEs1fXH0oQ1uXCLUr7vY3dKanfOCeFjGNRbTgAlU3hsDREwiec8O3yg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cabcd10-5ade-4215-db7c-08d6e8211b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:40.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver is redesigned using parameter page to support Micron SPI NAND
flashes.
The reason why spinand_select_op_variant globalized is that the Micron
driver no longer calling spinand_match_and_init.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/core.c   |  2 +-
 drivers/mtd/nand/spi/micron.c | 61 +++++++++++++++++++++++++----------
 include/linux/mtd/spinand.h   |  4 +++
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index cdf578c45c08..68cc52bff389 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -894,7 +894,7 @@ static void spinand_manufacturer_cleanup(struct spinand=
_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
=20
-static const struct spi_mem_op *
+const struct spi_mem_op *
 spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 95bc5264ebc1..6fde93ec23a1 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -90,22 +90,10 @@ static int micron_ecc_get_status(struct spinand_device =
*spinand,
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
-		     SPINAND_ECCINFO(&micron_ooblayout_ops,
-				     micron_ecc_get_status)),
-};
-
 static int micron_spinand_detect(struct spinand_device *spinand)
 {
+	const struct spi_mem_op *op;
 	u8 *id =3D spinand->id.data;
-	int ret;
=20
 	/*
 	 * Micron SPI NAND read ID need a dummy byte,
@@ -114,16 +102,55 @@ static int micron_spinand_detect(struct spinand_devic=
e *spinand)
 	if (id[1] !=3D SPINAND_MFR_MICRON)
 		return 0;
=20
-	ret =3D spinand_match_and_init(spinand, micron_spinand_table,
-				     ARRAY_SIZE(micron_spinand_table), id[2]);
-	if (ret)
-		return ret;
+	spinand->flags =3D 0;
+	spinand->eccinfo.get_status =3D micron_ecc_get_status;
+	spinand->eccinfo.ooblayout =3D &micron_ooblayout_ops;
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
+static void micron_fixup_param_page(struct spinand_device *spinand,
+				    struct nand_onfi_params *p)
+{
+	/*
+	 * As per Micron datasheets vendor[83] is defined as
+	 * die_select_feature
+	 */
+	if (p->vendor[83] && !p->interleaved_bits)
+		spinand->base.memorg.planes_per_lun =3D 1 << p->vendor[0];
+
+	spinand->base.memorg.ntargets =3D p->lun_count;
+	spinand->base.memorg.luns_per_target =3D 1;
+
+	/*
+	 * As per Micron datasheets,
+	 * vendor[82] is ECC maximum correctability
+	 */
+	spinand->base.eccreq.strength =3D p->vendor[82];
+	spinand->base.eccreq.step_size =3D 512;
+}
+
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops =3D =
{
 	.detect =3D micron_spinand_detect,
+	.fixup_param_page =3D micron_fixup_param_page,
 };
=20
 const struct spinand_manufacturer micron_spinand_manufacturer =3D {
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 41a03d59f003..d945db0cd3ca 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -429,4 +429,8 @@ int spinand_match_and_init(struct spinand_device *dev,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int tar=
get);
=20
+const struct spi_mem_op *
+spinand_select_op_variant(struct spinand_device *spinand,
+			  const struct spinand_op_variants *variants);
+
 #endif /* __LINUX_MTD_SPINAND_H */
--=20
2.17.1

