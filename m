Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E757AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C422805E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="MhNPkmXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfFCMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:43 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:39902
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbfFCMnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIPFrHTxmUPuG1bvZXDtslU6UPw695k6YHiee/BgFXY=;
 b=MhNPkmXvK1/brcBoqFYBncAk/6jq3NDiecimoPS0h4XZDdxLqPvGiP0pCdPeNt9eqBlnOHGNIKQdP1uZcjBrT1i28jFTZOM07d8BffwpQacVoqT/MliYvMA9UphusLODqPlyUOJ8LODLjzXAfhNWL9E7bSbepUqmaS3BJAbjRTE=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:31 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:31 +0000
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
Subject: [PATCH v3 05/12] mtd: rawnand: turn ONFI support to generic
Thread-Topic: [PATCH v3 05/12] mtd: rawnand: turn ONFI support to generic
Thread-Index: AdUaBLhXMxv827oyR52sOv4jypQQng==
Date:   Mon, 3 Jun 2019 12:43:30 +0000
Message-ID: <MN2PR08MB5951DFDBA5AB291ABBFB88C3B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c7698d-9b3b-4236-0faa-08d6e821156b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872B0C9E939FD3510F9F7D5B8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(30864003)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g3Bk4Rwq6HuG8vdcLjSTHyuq1UNICVfQ8TlNW3MOHrrzAbL3rEGS8CHVN/TgK0Xx9+VKoWMi1n6CsfWVIV2wTIy7lcHm+YqQREKfcT6Wv9TeTy1QUwuUiz8AHprbCYfC/m2W37ykrVAIjnd3FJbVouRI2aEahoXT9/0lGoZT/Toayg/LdTSCw3oXej2fm/1jpbDboJN9m/EWrYwywXVEl/4lMLotM2mw+XqN7IayffqsF8IbGEN1eWqOP8SkKXFlDuq5jkfKXJRK1xelXoW506n75RphguZ5LDzpu5GmCF0Q67iS2guSHXLVwFLUKEfTHdM+TIjUfgbgf5pyJv0bCqdddynjDXzLJIEROQSBhslGSSvGhxurquGJxevgLJWMdcJ1VLIROXKzlCuTs3taGltPL36YlCS5ZoMn7uc5Yto=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c7698d-9b3b-4236-0faa-08d6e821156b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:30.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate the onfi_helper object for raw NAND and turn ONFI support to
generic. Later this generic ONFI code will be used by SPI NAND as well.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 218 ++++++++++++++++++++++++++++++-
 drivers/mtd/nand/raw/nand_onfi.c | 183 +++-----------------------
 2 files changed, 232 insertions(+), 169 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index c28ed2da733a..f2f0d3cfa333 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4624,6 +4624,222 @@ nand_manufacturer_name(const struct nand_manufactur=
er *manufacturer)
 	return manufacturer ? manufacturer->name : "Unknown";
 }
=20
+/* Parse the ONFI parameter Page */
+int nand_onfi_read_op(struct nand_device *base, u8 page, void *buf,
+		      unsigned int len)
+{
+	struct nand_chip *chip =3D device_to_nand(base);
+	struct nand_onfi_params *p =3D buf;
+	int ret;
+	unsigned int i;
+
+	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < 3; i++) {
+		ret =3D nand_read_data_op(chip, &p[i], sizeof(*p), true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Parse the Extended Parameter Page. */
+static int nand_ext_param_page(struct nand_chip *chip,
+			       struct nand_onfi_params *p)
+{
+	struct onfi_ext_param_page *ep;
+	struct onfi_ext_section *s;
+	struct onfi_ext_ecc_info *ecc;
+	u8 *cursor;
+	int ret;
+	int len;
+	int i;
+
+	/*
+	 * The nand_flash_detect_ext_param_page() uses the
+	 * Change Read Column command which maybe not supported
+	 * by the chip->legacy.cmdfunc. So try to update the
+	 * chip->legacy.cmdfunc now. We do not replace user supplied
+	 * command function.
+	 */
+	nand_legacy_adjust_cmdfunc(chip);
+
+	len =3D le16_to_cpu(p->ext_param_page_length) * 16;
+	ep =3D kmalloc(len, GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	/* Send our own NAND_CMD_PARAM. */
+	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret)
+		goto ext_out;
+
+	/* Use the Change Read Column command to skip the ONFI param pages. */
+	ret =3D nand_change_read_column_op(chip,
+					 sizeof(*p) * p->num_of_param_pages,
+					 ep, len, true);
+	if (ret)
+		goto ext_out;
+
+	ret =3D -EINVAL;
+	if ((onfi_crc16(ONFI_CRC_BASE, ((uint8_t *)ep) + 2, len - 2)
+		!=3D le16_to_cpu(ep->crc))) {
+		pr_debug("fail in the CRC.\n");
+		goto ext_out;
+	}
+
+	/*
+	 * Check the signature.
+	 * Do not strictly follow the ONFI spec, maybe changed in future.
+	 */
+	if (strncmp(ep->sig, "EPPS", 4)) {
+		pr_debug("The signature is invalid.\n");
+		goto ext_out;
+	}
+
+	/* find the ECC section. */
+	cursor =3D (uint8_t *)(ep + 1);
+	for (i =3D 0; i < ONFI_EXT_SECTION_MAX; i++) {
+		s =3D ep->sections + i;
+		if (s->type =3D=3D ONFI_SECTION_TYPE_2)
+			break;
+		cursor +=3D s->length * 16;
+	}
+	if (i =3D=3D ONFI_EXT_SECTION_MAX) {
+		pr_debug("We can not find the ECC section.\n");
+		goto ext_out;
+	}
+
+	/* get the info we want. */
+	ecc =3D (struct onfi_ext_ecc_info *)cursor;
+
+	if (!ecc->codeword_size) {
+		pr_debug("Invalid codeword size\n");
+		goto ext_out;
+	}
+
+	chip->base.eccreq.strength =3D ecc->ecc_bits;
+	chip->base.eccreq.step_size =3D 1 << ecc->codeword_size;
+	ret =3D 0;
+
+ext_out:
+	kfree(ep);
+	return ret;
+}
+
+static int check_onfi_version(struct nand_device *base,
+			      struct nand_onfi_params *p, int *onfi_version)
+{
+	struct nand_chip *chip =3D device_to_nand(base);
+	int val;
+
+	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
+	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
+		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
+
+	/* Check version */
+	val =3D le16_to_cpu(p->revision);
+	if (val & ONFI_VERSION_2_3)
+		*onfi_version =3D 23;
+	else if (val & ONFI_VERSION_2_2)
+		*onfi_version =3D 22;
+	else if (val & ONFI_VERSION_2_1)
+		*onfi_version =3D 21;
+	else if (val & ONFI_VERSION_2_0)
+		*onfi_version =3D 20;
+	else if (val & ONFI_VERSION_1_0)
+		*onfi_version =3D 10;
+
+	if (!(*onfi_version)) {
+		pr_info("unsupported ONFI version: %d\n", val);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int nand_intf_data(struct nand_device *base, struct nand_onfi_param=
s *p)
+{
+	struct nand_chip *chip =3D device_to_nand(base);
+	struct onfi_params *onfi;
+	int onfi_version;
+	int ret;
+
+	check_onfi_version(base, p, &onfi_version);
+
+	/* The Extended Parameter Page is supported since ONFI 2.1. */
+	if (onfi_version >=3D 21 &&
+	    (le16_to_cpu(p->features) &
+			 ONFI_FEATURE_EXT_PARAM_PAGE)) {
+		if (nand_ext_param_page(chip, p))
+			pr_warn("Failed to detect ONFI extended param page\n");
+	}
+
+	chip->parameters.model =3D kstrdup(p->model, GFP_KERNEL);
+	if (!chip->parameters.model)
+		return -ENOMEM;
+
+	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
+		chip->options |=3D NAND_BUSWIDTH_16;
+
+	/* Save some parameters from the parameter page for future use */
+	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
+		chip->parameters.supports_set_get_features =3D true;
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+	}
+
+	onfi =3D kzalloc(sizeof(*onfi), GFP_KERNEL);
+	if (!onfi) {
+		return ret =3D -ENOMEM;
+		goto free_model;
+	}
+
+	check_onfi_version(base, p, &onfi_version);
+	onfi->version =3D onfi_version;
+	onfi->tPROG =3D le16_to_cpu(p->t_prog);
+	onfi->tBERS =3D le16_to_cpu(p->t_bers);
+	onfi->tR =3D le16_to_cpu(p->t_r);
+	onfi->tCCS =3D le16_to_cpu(p->t_ccs);
+	onfi->async_timing_mode =3D le16_to_cpu(p->async_timing_mode);
+	onfi->vendor_revision =3D le16_to_cpu(p->vendor_revision);
+	memcpy(onfi->vendor, p->vendor, sizeof(p->vendor));
+	chip->parameters.onfi =3D onfi;
+
+	return 0;
+
+free_model:
+	kfree(chip->parameters.model);
+
+	return ret;
+}
+
+/*
+ * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwi=
se.
+ */
+int rawnand_onfi_detect(struct nand_chip *chip)
+{
+	char id[4];
+	int ret;
+
+	/* Try ONFI for unknown chip or LP */
+	ret =3D nand_readid_op(chip, 0x20, id, sizeof(id));
+	if (ret || strncmp(id, "ONFI", 4))
+		return 0;
+
+	chip->base.helper.page =3D 0;
+	chip->base.helper.check_revision =3D check_onfi_version;
+	chip->base.helper.parameter_page_read =3D nand_onfi_read_op;
+	chip->base.helper.init_intf_data =3D nand_intf_data;
+
+	return nand_onfi_detect(&chip->base);
+}
+
 /*
  * Get the flash and manufacturer id and lookup if the type is supported.
  */
@@ -4719,7 +4935,7 @@ static int nand_detect(struct nand_chip *chip, struct=
 nand_flash_dev *type)
=20
 	if (!type->name || !type->pagesize) {
 		/* Check if the chip is ONFI compliant */
-		ret =3D nand_onfi_detect(&chip->base);
+		ret =3D rawnand_onfi_detect(chip);
 		if (ret < 0)
 			return ret;
 		else if (ret)
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_o=
nfi.c
index e5b9a27aa4e3..05592f815949 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -15,8 +15,6 @@
 #include <linux/slab.h>
 #include <linux/mtd/nand.h>
=20
-#include "internals.h"
-
 u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
 {
 	int i;
@@ -29,81 +27,6 @@ u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
 	return crc;
 }
=20
-/* Parse the Extended Parameter Page. */
-static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
-					    struct nand_onfi_params *p)
-{
-	struct onfi_ext_param_page *ep;
-	struct onfi_ext_section *s;
-	struct onfi_ext_ecc_info *ecc;
-	uint8_t *cursor;
-	int ret;
-	int len;
-	int i;
-
-	len =3D le16_to_cpu(p->ext_param_page_length) * 16;
-	ep =3D kmalloc(len, GFP_KERNEL);
-	if (!ep)
-		return -ENOMEM;
-
-	/* Send our own NAND_CMD_PARAM. */
-	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
-	if (ret)
-		goto ext_out;
-
-	/* Use the Change Read Column command to skip the ONFI param pages. */
-	ret =3D nand_change_read_column_op(chip,
-					 sizeof(*p) * p->num_of_param_pages,
-					 ep, len, true);
-	if (ret)
-		goto ext_out;
-
-	ret =3D -EINVAL;
-	if ((onfi_crc16(ONFI_CRC_BASE, ((uint8_t *)ep) + 2, len - 2)
-		!=3D le16_to_cpu(ep->crc))) {
-		pr_debug("fail in the CRC.\n");
-		goto ext_out;
-	}
-
-	/*
-	 * Check the signature.
-	 * Do not strictly follow the ONFI spec, maybe changed in future.
-	 */
-	if (strncmp(ep->sig, "EPPS", 4)) {
-		pr_debug("The signature is invalid.\n");
-		goto ext_out;
-	}
-
-	/* find the ECC section. */
-	cursor =3D (uint8_t *)(ep + 1);
-	for (i =3D 0; i < ONFI_EXT_SECTION_MAX; i++) {
-		s =3D ep->sections + i;
-		if (s->type =3D=3D ONFI_SECTION_TYPE_2)
-			break;
-		cursor +=3D s->length * 16;
-	}
-	if (i =3D=3D ONFI_EXT_SECTION_MAX) {
-		pr_debug("We can not find the ECC section.\n");
-		goto ext_out;
-	}
-
-	/* get the info we want. */
-	ecc =3D (struct onfi_ext_ecc_info *)cursor;
-
-	if (!ecc->codeword_size) {
-		pr_debug("Invalid codeword size\n");
-		goto ext_out;
-	}
-
-	chip->base.eccreq.strength =3D ecc->ecc_bits;
-	chip->base.eccreq.step_size =3D 1 << ecc->codeword_size;
-	ret =3D 0;
-
-ext_out:
-	kfree(ep);
-	return ret;
-}
-
 /*
  * Recover data with bit-wise majority
  */
@@ -158,40 +81,34 @@ void sanitize_string(u8 *s, size_t len)
  */
 int nand_onfi_detect(struct nand_device *base)
 {
-	struct nand_chip *chip =3D device_to_nand(base);
 	struct mtd_info *mtd =3D &base->mtd;
 	struct nand_memory_organization *memorg;
 	struct nand_onfi_params *p;
-	struct onfi_params *onfi;
 	int onfi_version =3D 0;
-	char id[4];
-	int i, ret, val;
+	int i, ret;
=20
 	memorg =3D nanddev_get_memorg(base);
=20
-	/* Try ONFI for unknown chip or LP */
-	ret =3D nand_readid_op(chip, 0x20, id, sizeof(id));
-	if (ret || strncmp(id, "ONFI", 4))
+	/* return 0, if ONFI helper functions are not defined */
+	if (!base->helper.parameter_page_read &&
+	    !base->helper.check_revision &&
+	    !base->helper.init_intf_data) {
 		return 0;
+	}
=20
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p =3D kzalloc((sizeof(*p) * 3), GFP_KERNEL);
+	p =3D kzalloc(sizeof(*p) * 3, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
=20
-	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
+	ret =3D base->helper.parameter_page_read(base, base->helper.page,
+					       p, sizeof(*p) * 3);
 	if (ret) {
 		ret =3D 0;
 		goto free_onfi_param_page;
 	}
=20
 	for (i =3D 0; i < 3; i++) {
-		ret =3D nand_read_data_op(chip, &p[i], sizeof(*p), true);
-		if (ret) {
-			ret =3D 0;
-			goto free_onfi_param_page;
-		}
-
 		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) =3D=3D
 				le16_to_cpu(p->crc)) {
 			if (i)
@@ -214,35 +131,14 @@ int nand_onfi_detect(struct nand_device *base)
 		}
 	}
=20
-	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
-	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
-		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
-
-	/* Check version */
-	val =3D le16_to_cpu(p->revision);
-	if (val & ONFI_VERSION_2_3)
-		onfi_version =3D 23;
-	else if (val & ONFI_VERSION_2_2)
-		onfi_version =3D 22;
-	else if (val & ONFI_VERSION_2_1)
-		onfi_version =3D 21;
-	else if (val & ONFI_VERSION_2_0)
-		onfi_version =3D 20;
-	else if (val & ONFI_VERSION_1_0)
-		onfi_version =3D 10;
-
-	if (!onfi_version) {
-		pr_info("unsupported ONFI version: %d\n", val);
+	ret =3D base->helper.check_revision(base, p, &onfi_version);
+	if (ret) {
+		ret =3D 0;
 		goto free_onfi_param_page;
 	}
=20
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	chip->parameters.model =3D kstrdup(p->model, GFP_KERNEL);
-	if (!chip->parameters.model) {
-		ret =3D -ENOMEM;
-		goto free_onfi_param_page;
-	}
=20
 	memorg->pagesize =3D le32_to_cpu(p->byte_per_page);
 	mtd->writesize =3D memorg->pagesize;
@@ -268,63 +164,14 @@ int nand_onfi_detect(struct nand_device *base)
 	memorg->max_bad_eraseblocks_per_lun =3D le32_to_cpu(p->blocks_per_lun);
 	memorg->bits_per_cell =3D p->bits_per_cell;
=20
-	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
-		chip->options |=3D NAND_BUSWIDTH_16;
-
 	if (p->ecc_bits !=3D 0xff) {
-		chip->base.eccreq.strength =3D p->ecc_bits;
-		chip->base.eccreq.step_size =3D 512;
-	} else if (onfi_version >=3D 21 &&
-		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
-
-		/*
-		 * The nand_flash_detect_ext_param_page() uses the
-		 * Change Read Column command which maybe not supported
-		 * by the chip->legacy.cmdfunc. So try to update the
-		 * chip->legacy.cmdfunc now. We do not replace user supplied
-		 * command function.
-		 */
-		nand_legacy_adjust_cmdfunc(chip);
-
-		/* The Extended Parameter Page is supported since ONFI 2.1. */
-		if (nand_flash_detect_ext_param_page(chip, p))
-			pr_warn("Failed to detect ONFI extended param page\n");
-	} else {
-		pr_warn("Could not retrieve ONFI ECC requirements\n");
+		base->eccreq.strength =3D p->ecc_bits;
+		base->eccreq.step_size =3D 512;
 	}
=20
-	/* Save some parameters from the parameter page for future use */
-	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
-		chip->parameters.supports_set_get_features =3D true;
-		bitmap_set(chip->parameters.get_feature_list,
-			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-		bitmap_set(chip->parameters.set_feature_list,
-			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-	}
-
-	onfi =3D kzalloc(sizeof(*onfi), GFP_KERNEL);
-	if (!onfi) {
-		ret =3D -ENOMEM;
-		goto free_model;
-	}
-
-	onfi->version =3D onfi_version;
-	onfi->tPROG =3D le16_to_cpu(p->t_prog);
-	onfi->tBERS =3D le16_to_cpu(p->t_bers);
-	onfi->tR =3D le16_to_cpu(p->t_r);
-	onfi->tCCS =3D le16_to_cpu(p->t_ccs);
-	onfi->async_timing_mode =3D le16_to_cpu(p->async_timing_mode);
-	onfi->vendor_revision =3D le16_to_cpu(p->vendor_revision);
-	memcpy(onfi->vendor, p->vendor, sizeof(p->vendor));
-	chip->parameters.onfi =3D onfi;
+	ret =3D base->helper.init_intf_data(base, p);
=20
 	/* Identification done, free the full ONFI parameter page and exit */
-	kfree(p);
-
-	return 1;
-
-free_model:
-	kfree(chip->parameters.model);
 free_onfi_param_page:
 	kfree(p);
=20
--=20
2.17.1

