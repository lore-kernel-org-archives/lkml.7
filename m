Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07492C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D22084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="hirs8Fsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:52:27 -0400
Received: from mailout.micron.com ([137.201.242.129]:57008 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:52:26 -0400
Received: from mail.micron.com (bowex36b.micron.com [137.201.84.100])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x2QApoHR021824;
        Tue, 26 Mar 2019 04:51:50 -0600
Received: from bowex36d.micron.com (137.201.85.223) by bowex36b.micron.com
 (137.201.84.100) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 04:51:50 -0600
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36d.micron.com (137.201.85.223) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 04:51:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiN1Dgwtw6MvKqOMBFtfOjSaig0xzF+X2BfaWcYsT5Q=;
 b=hirs8Fsh0VOQGpYv8kvHGkccfXo+789+dJQY0nnfNnTs+yXDv0OL2UEgakGqQvrW/dbvE12rBpCTz75yIXLo4Hh8Z45n1vQZj7vqO4rvrBKVzLOO/6by+z37aPK/++MIjZx+ntvq+ARUp//fBRvcTq0Aom5hKx80LZ2C6ev8KDE=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5838.namprd08.prod.outlook.com (20.179.87.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 10:51:47 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 10:51:47 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 1/4] mtd: rawnand: Turn the ONFI support to generic
Thread-Topic: [PATCH 1/4] mtd: rawnand: Turn the ONFI support to generic
Thread-Index: AdTjwBGl+eQMQxE9TGefSYYUoa3ZUw==
Date:   Tue, 26 Mar 2019 10:51:47 +0000
Message-ID: <MN2PR08MB5951BDBAC83D3D04B3B122A5B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 184b4d54-0026-411c-d9b3-08d6b1d90b7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5838;
x-ms-traffictypediagnostic: MN2PR08MB5838:|MN2PR08MB5838:
x-microsoft-antispam-prvs: <MN2PR08MB583818C93DF71FEA24C47778B85F0@MN2PR08MB5838.namprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(106356001)(71200400001)(14444005)(478600001)(7416002)(7696005)(71190400001)(53946003)(256004)(105586002)(5024004)(476003)(53936002)(25786009)(6436002)(97736004)(2501003)(9686003)(8936002)(186003)(33656002)(110136005)(81166006)(4326008)(8676002)(26005)(81156014)(102836004)(2201001)(305945005)(30864003)(6506007)(2906002)(3846002)(6116002)(55016002)(5660300002)(99286004)(14454004)(486006)(86362001)(7736002)(66066001)(54906003)(74316002)(316002)(52536014)(55236004)(68736007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5838;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMsdtNQSFCFQcl/rbLdNM0qRThNm5djPGsqtYpQZIe3ne/nGYAqn/ULC4OxRVlbA/kYfaD+GWlPgmNb+X6YT6qn9W0yMQejZ1rgw0/2Msa+/BxWQ3VWrH8FXVmhGJxX593F3fdTofhWz2J/R7JntNQjCNytUkZqbs3aGICg4GBhVKsoGPNERryTtkfgZKOV4zRdkYXKYA3H0Sl86q9Y/uLtIU64szGwK4Liyp45lA3v5SiHnKycVZmh+edzJu2eRdosCSwzWjoMXFXuDpHlaSarTpgT3jh/CBQFjiAG6gufzFoO4MIChiWu4+vGlaBqsig/T/iLxGeIVTs5tQCYnkELP6ECzviQUKjd6mMxvl8uDzkIhTW6JbZcnJFZtWqsEf0YjAQofy3TBuiO7vxKkXO8k2v6t8igxvCms7uWxO4M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 184b4d54-0026-411c-d9b3-08d6b1d90b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 10:51:47.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5838
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24512.005
X-TM-AS-Result: No--10.416200-0.000000-31
X-TM-AS-MatchedID: 150215-705178-706719-704421-700648-700016-188019-700398-7
        02762-851458-186027-709251-700264-702931-702737-105250-706290-700529-700324
        -106420-702113-707510-188199-700251-708712-700057-780016-701236-707451-7021
        43-700756-710989-708797-703523-700752-702358-709755-703399-700008-121270-70
        1220-701146-705461-705342-700059-702037-707663-106470-700038-711109-703529-
        105630-701698-700287-708733-702198-121119-700492-705450-702376-708104-70159
        4-121367-700133-105640-148004-148007-148020-148050-29997-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix headers to make way for adding helper functions.

Add onfi helper structure.

Add helper functions in raw NAND core, which later will be used during
ONFI detection.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/internals.h |   6 +-
 drivers/mtd/nand/raw/nand_base.c | 236 ++++++++++++++++++++++++++++---
 drivers/mtd/nand/raw/nand_onfi.c | 215 +++++-----------------------
 include/linux/mtd/nand.h         |  30 ++++
 include/linux/mtd/rawnand.h      |   5 +
 5 files changed, 289 insertions(+), 203 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/intern=
als.h
index a204f9d7e123..eb34dece4754 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -90,7 +90,7 @@ int nand_write_page_raw_notsupp(struct nand_chip *chip, c=
onst u8 *buf,
 				int oob_required, int page);
 int nand_exit_status_op(struct nand_chip *chip);
 int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
-			    unsigned int len);
+		unsigned int len);
 void nand_decode_ext_id(struct nand_chip *chip);
 void panic_nand_wait(struct nand_chip *chip, unsigned long timeo);
 void sanitize_string(uint8_t *s, size_t len);
@@ -138,10 +138,6 @@ void nand_legacy_set_defaults(struct nand_chip *chip);
 void nand_legacy_adjust_cmdfunc(struct nand_chip *chip);
 int nand_legacy_check_hooks(struct nand_chip *chip);
=20
-/* ONFI functions */
-u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
-int nand_onfi_detect(struct nand_chip *chip);
-
 /* JEDEC functions */
 int nand_jedec_detect(struct nand_chip *chip);
=20
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 0bc898bdb6e1..fc2c7d6ea4f2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4194,24 +4194,6 @@ static void nand_set_defaults(struct nand_chip *chip=
)
 		chip->buf_align =3D 1;
 }
=20
-/* Sanitize ONFI strings so we can safely print them */
-void sanitize_string(uint8_t *s, size_t len)
-{
-	ssize_t i;
-
-	/* Null terminate */
-	s[len - 1] =3D 0;
-
-	/* Remove non printable chars */
-	for (i =3D 0; i < len - 1; i++) {
-		if (s[i] < ' ' || s[i] > 127)
-			s[i] =3D '?';
-	}
-
-	/* Remove trailing spaces */
-	strim(s);
-}
-
 /*
  * nand_id_has_period - Check if an ID string has a given wraparound perio=
d
  * @id_data: the ID string
@@ -4461,6 +4443,222 @@ nand_manufacturer_name(const struct nand_manufactur=
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
+		return 0;
+
+	for (i =3D 0; i < 3; i++) {
+		ret =3D nand_read_data_op(chip, &p[i], sizeof(*p), true);
+		if (ret)
+			return 0;
+	}
+
+	return 1;
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
+	chip->base.ecc.requirements.strength =3D ecc->ecc_bits;
+	chip->base.ecc.requirements.step_size =3D 1 << ecc->codeword_size;
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
+		return 0;
+	}
+
+	return 1;
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
+	return 1;
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
@@ -4556,7 +4754,7 @@ static int nand_detect(struct nand_chip *chip, struct=
 nand_flash_dev *type)
=20
 	if (!type->name || !type->pagesize) {
 		/* Check if the chip is ONFI compliant */
-		ret =3D nand_onfi_detect(chip);
+		ret =3D rawnand_onfi_detect(chip);
 		if (ret < 0)
 			return ret;
 		else if (ret)
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_o=
nfi.c
index 9d21b47ebef1..61fcb6994b45 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -13,8 +13,7 @@
  */
=20
 #include <linux/slab.h>
-
-#include "internals.h"
+#include <linux/mtd/nand.h>
=20
 u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
 {
@@ -28,88 +27,13 @@ u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
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
-	chip->base.ecc.requirements.strength =3D ecc->ecc_bits;
-	chip->base.ecc.requirements.step_size =3D 1 << ecc->codeword_size;
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
-static void nand_bit_wise_majority(const void **srcbufs,
-				   unsigned int nsrcbufs,
-				   void *dstbuf,
-				   unsigned int bufsize)
+void nand_bit_wise_majority(const void **srcbufs,
+			    unsigned int nsrcbufs,
+			    void *dstbuf,
+			    unsigned int bufsize)
 {
 	int i, j, k;
=20
@@ -134,44 +58,49 @@ static void nand_bit_wise_majority(const void **srcbuf=
s,
 	}
 }
=20
+/* Sanitize ONFI strings so we can safely print them */
+void sanitize_string(u8 *s, size_t len)
+{
+	ssize_t i;
+
+	/* Null terminate */
+	s[len - 1] =3D 0;
+
+	/* Remove non printable chars */
+	for (i =3D 0; i < len - 1; i++) {
+		if (s[i] < ' ' || s[i] > 127)
+			s[i] =3D '?';
+	}
+
+	/* Remove trailing spaces */
+	strim(s);
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwi=
se.
  */
-int nand_onfi_detect(struct nand_chip *chip)
+int nand_onfi_detect(struct nand_device *base)
 {
-	struct mtd_info *mtd =3D nand_to_mtd(chip);
+	struct mtd_info *mtd =3D &base->mtd;
 	struct nand_memory_organization *memorg;
 	struct nand_onfi_params *p;
-	struct onfi_params *onfi;
 	int onfi_version =3D 0;
-	char id[4];
-	int i, ret, val;
-
-	memorg =3D nanddev_get_memorg(&chip->base);
+	int i, ret;
=20
-	/* Try ONFI for unknown chip or LP */
-	ret =3D nand_readid_op(chip, 0x20, id, sizeof(id));
-	if (ret || strncmp(id, "ONFI", 4))
-		return 0;
+	memorg =3D nanddev_get_memorg(base);
=20
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p =3D kzalloc((sizeof(*p) * 3), GFP_KERNEL);
+	p =3D kzalloc(sizeof(*p) * 3, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
=20
-	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
-	if (ret) {
-		ret =3D 0;
+	ret =3D base->helper.parameter_page_read(base, base->helper.page,
+						p, sizeof(*p) * 3);
+	if (!ret) {
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
@@ -194,35 +123,12 @@ int nand_onfi_detect(struct nand_chip *chip)
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
+	if (!ret)
 		goto free_onfi_param_page;
-	}
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
@@ -248,63 +154,14 @@ int nand_onfi_detect(struct nand_chip *chip)
 	memorg->max_bad_eraseblocks_per_lun =3D le32_to_cpu(p->blocks_per_lun);
 	memorg->bits_per_cell =3D p->bits_per_cell;
=20
-	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
-		chip->options |=3D NAND_BUSWIDTH_16;
-
 	if (p->ecc_bits !=3D 0xff) {
-		chip->base.ecc.requirements.strength =3D p->ecc_bits;
-		chip->base.ecc.requirements.step_size =3D 512;
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
+		base->ecc.requirements.strength =3D p->ecc_bits;
+		base->ecc.requirements.step_size =3D 512;
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
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index b3a5506a891b..3f7e2b495e93 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -13,6 +13,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand-ecc-sw-hamming.h>
 #include <linux/mtd/nand-ecc-sw-bch.h>
+#include <linux/mtd/onfi.h>
=20
 struct nand_device;
=20
@@ -269,6 +270,24 @@ struct nand_ecc {
 	struct nand_ecc_engine *engine;
 };
=20
+/**
+ * struct onfi_helper - ONFI helper functions that should be implemented b=
y
+ * specialized layers (raw NAND, SPI NAND, etc.)
+ * @page: Page number for ONFI parameter table
+ * @check_revision: Check ONFI revision number
+ * @parameter_page_read: Function to read parameter pages
+ * @init_intf_data: Initialize interface specific data or fixups
+ */
+struct onfi_helper {
+	u8 page;
+	int (*check_revision)(struct nand_device *base,
+			      struct nand_onfi_params *p, int *onfi_version);
+	int (*parameter_page_read)(struct nand_device *base, u8 page,
+				   void *buf, unsigned int len);
+	int (*init_intf_data)(struct nand_device *base,
+			      struct nand_onfi_params *p);
+};
+
 /**
  * struct nand_device - NAND device
  * @mtd: MTD instance attached to the NAND device
@@ -276,6 +295,7 @@ struct nand_ecc {
  * @rowconv: position to row address converter
  * @bbt: bad block table info
  * @ops: NAND operations attached to the NAND device
+ * @helper: Helper functions to detect and initialize ONFI NAND
  *
  * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNA=
ND)
  * should declare their own NAND object embedding a nand_device struct (th=
at's
@@ -294,6 +314,7 @@ struct nand_device {
 	struct nand_row_converter rowconv;
 	struct nand_bbt bbt;
 	const struct nand_ops *ops;
+	struct onfi_helper helper;
 };
=20
 /**
@@ -888,4 +909,13 @@ static inline bool nanddev_bbt_is_initialized(struct n=
and_device *nand)
 int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
 int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t l=
en);
=20
+/* ONFI functions */
+u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
+void nand_bit_wise_majority(const void **srcbufs,
+			    unsigned int nsrcbufs,
+					void *dstbuf,
+					unsigned int bufsize);
+void sanitize_string(u8 *s, size_t len);
+int nand_onfi_detect(struct nand_device *base);
+
 #endif /* __LINUX_MTD_NAND_H */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 174d2d27200f..bcb18cade2e8 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1079,6 +1079,11 @@ static inline struct mtd_info *nand_to_mtd(struct na=
nd_chip *chip)
 	return &chip->base.mtd;
 }
=20
+static inline struct nand_chip *device_to_nand(struct nand_device *base)
+{
+	return container_of(base, struct nand_chip, base);
+}
+
 static inline void *nand_get_controller_data(struct nand_chip *chip)
 {
 	return chip->priv;
--=20
2.17.1

