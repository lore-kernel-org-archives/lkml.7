Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A7F27EBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="QPs+4FQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFCMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:28 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:46545
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfFCMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqWGWMZVHJyu/kVx4LtSNU+8fq4JT/Mr6ztQHwBfY4Q=;
 b=QPs+4FQdzPVzaT75oUXgr3jZ18LIkm0ZmSzgkm5NL+hFUQ/VIMO8donkiLFq8kFGiG5p8FJmI3hQUjEYa0JPd/8PR5m8sIX4dByo1SDaW6n++RYudexDp0KMmAAkMjc2uv8TNW1ePK0vPF6ht6/ySDZO9GTMhZlKHUMXzhOJ4SY=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:23 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:23 +0000
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
Subject: [PATCH v3 01/12] mtd: rawnand: turn nand_onfi_detect to use
 nand_device
Thread-Topic: [PATCH v3 01/12] mtd: rawnand: turn nand_onfi_detect to use
 nand_device
Thread-Index: AdUaAy8RvNFH7myfRde2bNfDQJf8+g==
Date:   Mon, 3 Jun 2019 12:43:23 +0000
Message-ID: <MN2PR08MB5951A1DDC80445E917EAA32DB8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e48ea67-2274-4a22-3377-08d6e8211108
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872705FCE1ABCA3C4655F5CB8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R97Kp5fG+znziDSus+uMBjixBdzBXGoL8dgz4yydPXkDaF0CpgEe1x5J3J80F+WXZSGKme490v03GiILzHAwSPxpqW3vSa6jOs6gwPtY/xAbdzQxoOcHXmkY6nWG/AIs3ykDdjKM2o7r0Be7I1ofFk5+JcV6LKdzjhs1DkiDWftfhNTk90OIFGEnMGwHaSD0XdTHB07izT/yUlQY7orjsxab4Y7KQLcs2ynHROqxQvC3K99aImhpEDeJp6NC0V5SMSDV1SVdALBYGvfzZstq2Nu72a61ubbJw91kU2/TPGl/t9inf4Jj9tVOJyLduR77WL3Wet82hmWwgg5V7sTXOGwYjQOHNfuiDzpel8hoOLRNn3q5Rg6KL0586nLTV0u3JAGsx0O/T+fXQ/yO9mD4r+SE6ylQGVHP1aeSFYaCxK4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e48ea67-2274-4a22-3377-08d6e8211108
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:23.3910
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

It is necessary to turn nand_onfi_detect to use nand_device structure,
to make ONFI related codes generic for all NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/internals.h | 2 +-
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 drivers/mtd/nand/raw/nand_onfi.c | 8 +++++---
 include/linux/mtd/rawnand.h      | 5 +++++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/intern=
als.h
index cba6fe7dd8c4..4dc9ae108fa1 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -141,7 +141,7 @@ int nand_legacy_check_hooks(struct nand_chip *chip);
=20
 /* ONFI functions */
 u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
-int nand_onfi_detect(struct nand_chip *chip);
+int nand_onfi_detect(struct nand_device *base);
=20
 /* JEDEC functions */
 int nand_jedec_detect(struct nand_chip *chip);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 6ecd1c496ce3..96a93481420f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4737,7 +4737,7 @@ static int nand_detect(struct nand_chip *chip, struct=
 nand_flash_dev *type)
=20
 	if (!type->name || !type->pagesize) {
 		/* Check if the chip is ONFI compliant */
-		ret =3D nand_onfi_detect(chip);
+		ret =3D nand_onfi_detect(&chip->base);
 		if (ret < 0)
 			return ret;
 		else if (ret)
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_o=
nfi.c
index 0b879bd0a68c..e20b60b8dd93 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -13,6 +13,7 @@
  */
=20
 #include <linux/slab.h>
+#include <linux/mtd/nand.h>
=20
 #include "internals.h"
=20
@@ -137,9 +138,10 @@ static void nand_bit_wise_majority(const void **srcbuf=
s,
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwi=
se.
  */
-int nand_onfi_detect(struct nand_chip *chip)
+int nand_onfi_detect(struct nand_device *base)
 {
-	struct mtd_info *mtd =3D nand_to_mtd(chip);
+	struct nand_chip *chip =3D device_to_nand(base);
+	struct mtd_info *mtd =3D &base->mtd;
 	struct nand_memory_organization *memorg;
 	struct nand_onfi_params *p;
 	struct onfi_params *onfi;
@@ -147,7 +149,7 @@ int nand_onfi_detect(struct nand_chip *chip)
 	char id[4];
 	int i, ret, val;
=20
-	memorg =3D nanddev_get_memorg(&chip->base);
+	memorg =3D nanddev_get_memorg(base);
=20
 	/* Try ONFI for unknown chip or LP */
 	ret =3D nand_readid_op(chip, 0x20, id, sizeof(id));
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f5bb6f11c36b..87282beee008 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1154,6 +1154,11 @@ static inline struct mtd_info *nand_to_mtd(struct na=
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

