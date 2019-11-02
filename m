Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC7CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C2D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mFPya88U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKBLY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:29 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48498 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfKBLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:24:02 -0400
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
IronPort-SDR: vAkjdt2NsG350Fhdf2TTyOMx3/8hgUs5aqNvbytbUQ7CNx5O1pQruTgtvFNiC7daXJpVBAWkIS
 cXZDDZfuV0CoNSjDuqVXc6EdZbXKn6TR2nc2Bh1inkUZ7+dOVtZiouWC1hjRxWG31RchMtp6JE
 2k52j48na8psBxYvOr9QCWOoFteXrH53i0JnN0lK/kPNf7HloRALEcr+7S3bhu7Bp/8Bt0wmqZ
 D7iupRSUWPuQiOfEy7fbxH9oVVBh9k2S8E4+A6hioIER4acjjzam2nYt79TtUq9iIL5mzffrFn
 rsE=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55072005"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:24:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:24:02 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZnzDtFSV/9hqM3XXzuZwxy9FO/Psh4NHlKsItPWAIpDdBog2YlKnbUzISzgFZgJME9Nbr0WgCCClkhsir9Q3+neD5MxaE1genLjs4N3WRtLy1IxjVJurDKmRM/DfQSREE4UgcHEbB0rFFkA1nkQ9AhBAyYINGRtvf7U7Cf4dV5geNeWnmzGbBrm/0++JEQ38d+B7lbjPCHuV25yhnLDGn/GQsmSt5+vC3r1EcfQlufvt/aFl/GuqbaZPBC2liy5+VF1jjGf4r+k0aECxHwQXfPjLwzeVkaMM7j4TDBJMz7Z+RtD4kIJP8xH12uCMl+mdoWQgsqpq6cJ/swCAKhtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHZHMBgvuxUuX4goyGcOEkOyZiuNWOcgfvgx9PmSXKk=;
 b=ZAyk2dQn9OEDZQ8sck682/BqhpDgKfTTJtZj67/CIZaggrA/PjUS/Lz6ZDUnxBomj+UpjpVxiFLUIcD1ezmxpgdlcnPfNTHHKGXQJbZ3b2CC45JjW4TcT64xmILGgxW3Aey92JLGXFABno07a+pRkOYUbhq5SlgSWMMLfS2WaLsCdyGrbJdwF5Rjol1uzW332boh3T29DCQt2d97NzeVx4//0tEWA2nMkqF5+YUTpQA/xxgb8p6TlrnlLiSu/ZgIHgPuMjrV3zxU63m+3PiEpA+JPmBWyMTF1nl79XMYrWR6472DclNNACgetSWukHmgnXvmtI6QXhjwIjq9CLuFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHZHMBgvuxUuX4goyGcOEkOyZiuNWOcgfvgx9PmSXKk=;
 b=mFPya88U0tc/jV2QCwrJ3YJTwSMhjePps/LWlStWhyNh0d9A1KezogfKTBBP8wq7IsXq06Z66CVCINOjeWI5MGZ4WZO4lxKQ0C/ieWIf84d7R1CLjtvR506i6eb2kkSOxKVMH4ad8UypHsBA2Z6SmdUrGu5q/or1EB9sNrV+ILI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:24:00 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:24:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 20/20] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Topic: [PATCH v4 20/20] mtd: spi-nor: Rework the disabling of block
 write protection
Thread-Index: AQHVkXAGrjVq0uA8NkCyGU63GFJpsw==
Date:   Sat, 2 Nov 2019 11:24:00 +0000
Message-ID: <20191102112316.20715-21-tudor.ambarus@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccefaedd-5782-41f5-b1de-08d75f87287e
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371145D458260ADB336F1C67F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjSrQWhHaVMIuJLYMdoaXvtEq/HnapVnw4qHu5qhIAqyBaFvj6xOXiYEhxyJkRQlh/Z+C5BIw4FWcjTbd7w7iTbzIrBSRsAVgTU+aD6M96iLC4V+V1aMtKvWnQQhCBEbGCE2DeiC8nQl9+g7ImysIj2dVL1yYMp4lAOoLJEqL6FvE4wmiwHKq7L6zI+NMfRDIIOFoRHRPVrfP1EhJIfw+dJEBAUTvP3GXheQ7P7uRpMUwaZdGhLX4wyBfQlVMWHpnzwY0i83PXFeYR0159KIMh0Dnqsdy4q8MV80SzVfHhcey2DcqHrF5Ymu0oMK7T1JQy3Bem0PrgSDeSrLonJereEwDXTsr3adbO5HPvyX0o52rwq2ZvkuehyTMcxPQXXDfdYSaL0NUydzHeZDuHUV6qTCj8j9W3kU4AjnvYILgEthhrVWFR78qE+MxhXJ9M9h
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccefaedd-5782-41f5-b1de-08d75f87287e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:24:00.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwPFZS1OvTTGqOe3pN8C1ji1XLUUkiRgiL/yo4m1vrg37QE4pxf3O34AuKyWuEH9XR7nxexPWabUdh7h7vwE4naHeRfqMY+3zzYUjWiq5dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

spi_nor_unlock() unlocks blocks of memory or the entire flash memory
array, if requested. clear_sr_bp() unlocks the entire flash memory
array at boot time. This calls for some unification, clear_sr_bp() is
just an optimization for the case when the unlock request covers the
entire flash size.

Get rid of clear_sr_bp() and introduce spi_nor_unlock_all(), which is
just a call to spi_nor_unlock() for the entire flash memory array.
This fixes a bug that was present in spi_nor_spansion_clear_sr_bp().
When the QE bit was zero, we used the Write Status (01h) command with
one data byte, which might cleared the Status Register 2. We now always
use the Write Status (01h) command with two data bytes when
SNOR_F_HAS_16BIT_SR is set, to avoid clearing the Status Register 2.

The SNOR_F_NO_READ_CR case is treated as well. When the flash doesn't
support the CR Read command, we make an assumption about the value of
the QE bit. In spi_nor_init(), call spi_nor_quad_enable() first, then
spi_nor_unlock_all(), so that at the spi_nor_unlock_all() time we can
be sure the QE bit has value one, because of the previous call to
spi_nor_quad_enable().

Get rid of the MFR handling and implement specific manufacturer
default_init() fixup hooks.

Note that this changes a bit the logic for the SNOR_MFR_ATMEL,
SNOR_MFR_INTEL and SNOR_MFR_SST cases. Before this patch, the Atmel,
Intel and SST chips did not set the locking ops, but unlocked the entire
flash at boot time, while now they are setting the locking ops to
stm_locking_ops. This should work, since the the disable of the block
protection at the boot time used the same Status Register bits to unlock
the flash, as in the stm_locking_ops case.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 140 +++++++++++++++-----------------------=
----
 include/linux/mtd/spi-nor.h   |   3 -
 2 files changed, 50 insertions(+), 93 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 09b1af2cf0d4..05bf4003c9e7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2175,74 +2175,6 @@ static int spi_nor_sr2_bit7_quad_enable(struct spi_n=
or *nor)
 	return 0;
 }
=20
-/**
- * spi_nor_clear_sr_bp() - clear the Status Register Block Protection bits=
.
- * @nor:        pointer to a 'struct spi_nor'
- *
- * Read-modify-write function that clears the Block Protection bits from t=
he
- * Status Register without affecting other bits.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spi_nor_clear_sr_bp(struct spi_nor *nor)
-{
-	int ret;
-	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
-
-	ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	nor->bouncebuf[0] &=3D ~mask;
-
-	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
-}
-
-/**
- * spi_nor_spansion_clear_sr_bp() - clear the Status Register Block Protec=
tion
- * bits on spansion flashes.
- * @nor:        pointer to a 'struct spi_nor'
- *
- * Read-modify-write function that clears the Block Protection bits from t=
he
- * Status Register without affecting other bits. The function is tightly
- * coupled with the spi_nor_sr2_bit1_quad_enable() function. Both assume t=
hat
- * the Write Register with 16 bits, together with the Read Configuration
- * Register (35h) instructions are supported.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
-{
-	int ret;
-	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
-	u8 *sr_cr =3D  nor->bouncebuf;
-
-	/* Check current Quad Enable bit value. */
-	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
-	if (ret)
-		return ret;
-
-	/*
-	 * When the configuration register Quad Enable bit is one, only the
-	 * Write Status (01h) command with two data bytes may be used.
-	 */
-	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
-		ret =3D spi_nor_read_sr(nor, sr_cr);
-		if (ret)
-			return ret;
-
-		sr_cr[0] &=3D ~mask;
-
-		return spi_nor_write_sr(nor, sr_cr, 2);
-	}
-
-	/*
-	 * If the Quad Enable bit is zero, use the Write Status (01h) command
-	 * with one data byte.
-	 */
-	return spi_nor_clear_sr_bp(nor);
-}
-
 /* Used when the "_ext_id" is two bytes at most */
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
 		.id =3D {							\
@@ -4624,12 +4556,27 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
=20
+static void atmel_set_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
+static void intel_set_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
 static void macronix_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 	nor->params.set_4byte =3D macronix_set_4byte;
 }
=20
+static void sst_set_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
 	nor->flags |=3D SNOR_F_HAS_LOCK;
@@ -4651,6 +4598,14 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
+	case SNOR_MFR_ATMEL:
+		atmel_set_default_init(nor);
+		break;
+
+	case SNOR_MFR_INTEL:
+		intel_set_default_init(nor);
+		break;
+
 	case SNOR_MFR_MACRONIX:
 		macronix_set_default_init(nor);
 		break;
@@ -4660,6 +4615,10 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 		st_micron_set_default_init(nor);
 		break;
=20
+	case SNOR_MFR_SST:
+		sst_set_default_init(nor);
+		break;
+
 	case SNOR_MFR_WINBOND:
 		winbond_set_default_init(nor);
 		break;
@@ -4920,21 +4879,26 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->params.quad_enable(nor);
 }
=20
-static int spi_nor_init(struct spi_nor *nor)
+/**
+ * spi_nor_unlock_all() - Unlocks the entire flash memory array.
+ * @nor:	pointer to a 'struct spi_nor'.
+ *
+ * Some SPI NOR flashes are write protected by default after a power-on re=
set
+ * cycle, in order to avoid inadvertent writes during power-up. Backward
+ * compatibility imposes to unlock the entire flash memory array at power-=
up
+ * by default.
+ */
+static int spi_nor_unlock_all(struct spi_nor *nor)
 {
-	int err;
+	if (nor->flags & SNOR_F_HAS_LOCK)
+		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
=20
-	if (nor->clear_sr_bp) {
-		if (nor->params.quad_enable =3D=3D spi_nor_sr2_bit1_quad_enable)
-			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
+	return 0;
+}
=20
-		err =3D nor->clear_sr_bp(nor);
-		if (err) {
-			dev_dbg(nor->dev,
-				"fail to clear block protection bits\n");
-			return err;
-		}
-	}
+static int spi_nor_init(struct spi_nor *nor)
+{
+	int err;
=20
 	err =3D spi_nor_quad_enable(nor);
 	if (err) {
@@ -4942,6 +4906,12 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
=20
+	err =3D spi_nor_unlock_all(nor);
+	if (err) {
+		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
+		return err;
+	}
+
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
@@ -5124,16 +5094,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	if (info->flags & SPI_NOR_HAS_LOCK)
 		nor->flags |=3D SNOR_F_HAS_LOCK;
=20
-	/*
-	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
-	 * with the software protection bits set.
-	 */
-	if (JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_ATMEL ||
-	    JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_INTEL ||
-	    JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_SST ||
-	    nor->info->flags & SPI_NOR_HAS_LOCK)
-		nor->clear_sr_bp =3D spi_nor_clear_sr_bp;
-
 	/* Init flash parameters based on flash_info struct and SFDP */
 	spi_nor_init_params(nor);
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 6d703df97f13..9eae35c60bce 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -579,8 +579,6 @@ struct flash_info;
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
  * @controller_ops:	SPI NOR controller driver specific operations.
- * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
- *			the SPI NOR Status Register.
  * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
  *                      The structure includes legacy flash parameters and
  *                      settings that can be overwritten by the spi_nor_fi=
xups
@@ -609,7 +607,6 @@ struct spi_nor {
=20
 	const struct spi_nor_controller_ops *controller_ops;
=20
-	int (*clear_sr_bp)(struct spi_nor *nor);
 	struct spi_nor_flash_parameter params;
=20
 	void *priv;
--=20
2.9.5

