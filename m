Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4314C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661C621D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ruTzPl6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfKGImF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:42:05 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14992 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbfKGImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:03 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: JETvYhJ9X52u0Uxfaip5Ber8MH6K+fc+1YoJcSEEZ6jW0Ta4ubGf/nv60u2dqTMJNzxvfJGyvb
 GjVheQ73koFdVzLhic3xIBHKwkzLgXBUpxp0ZcbZk9QXzZfo1PNmxoUP1AjOfChHYPNMjgeMe8
 e9nGtXNKZHB8ZZk6MeWIozD2RZVcl6z0x3lA3ZprhtcwrOVt6WkdeWVbr4khFiKIHGhgfdgdTi
 /HsIKUWWagOVUd81jdxvw5/AshWEcotnlNnLyTiFPXyKIy0VsVMJN/FcFt1W9QeDJEpW+kDJcy
 X54=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="53270312"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 01:42:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 01:41:57 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 01:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDezqZ63qEFXYJL/mdHmxqFcu5Nl2llmfvKrBHMa0L/4kGMAMCJt9hdVjUrMdxCZz2Rs0YCUP1ErPIuvps6sqpAHWTU8IaCIyCHvUjcjsWTwWx46s8aKt7F82aNp85vEHnEeyvMk/5yLkIp9t4lXCGghJN+lDUO6Nvg5HybXyJSm3XBnytDpkjBou+WFZsS5ClRvGpmFHcqeBPp3hnGldDqfpu3vz1QsbCxUHc3As6aU3Dmzs6qQCqrs9r1UgMWMltmPj2hzTFp1PTc6xg6/MjU+uBUDDrvjdxa7+FRl4cYQSdE4HmqgRDSq1qmSKTgTq6H1EK0fCFDy9Z0ukb717Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyPjMw1hI+Xq6+5GfEqs/Mum8d2X4kqlM4sL30Z+Ayk=;
 b=WJPaaYNp+pwLavX0xDTJ7B14v57ryc8ManuYpqYnkMiBeHP1MLg0ywH7IeMSONC+JQMWtIR4kmOKBPYYln6w9YXfuYHqa+6U+HG46lSaslMwEITvFrYhOy9ThGKfn4BBhrAzh0F6lOF69B6HwWTA+pTlDnHaAhubIVXXiscUi5dzS1qTOdKCnhV/skSs5SVWxZRshvojLXqQCkgK08x9aczJ8sVMGCenQ0kcNZNmuD8wDleK39JoN0LJ8ntknHs7/RdOxDjL7fBm8Vms205CpiSbChWCq3Q/D3juc67XacB1NsGhbOogKhC9J4twDjO7zU1RPAb/Lyx6y9ScxagL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyPjMw1hI+Xq6+5GfEqs/Mum8d2X4kqlM4sL30Z+Ayk=;
 b=ruTzPl6hZZY66SjRX5tD2nfaWglDi+MvzTixDDv593jX7roo4vhv3aAZ6m1QSl4clsiEeJdQUWnYNVcCxUXokqQOuuz+I8n6OYHbCTpji/Ytoa0WsTx8vwhO/gbls/wUr+XthnMs4ekmXmyY7TAS9OnvKYyg3LyDlNsRGhTFlpU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3824.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:41:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 08:41:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 2/6] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Topic: [PATCH v5 2/6] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Index: AQHVlUc1dhCcYR6pN0e9n8RTBkaWkA==
Date:   Thu, 7 Nov 2019 08:41:55 +0000
Message-ID: <20191107084135.22122-3-tudor.ambarus@microchip.com>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191107084135.22122-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::40) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [109.166.128.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbc9ef3-0b74-487c-c2b4-08d7635e5769
x-ms-traffictypediagnostic: MN2PR11MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3824AFE8502018E7EB3A1958F0780@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(25786009)(6512007)(66476007)(6486002)(110136005)(66946007)(6116002)(66446008)(71200400001)(86362001)(54906003)(66556008)(64756008)(2906002)(6436002)(14444005)(256004)(36756003)(478600001)(66066001)(14454004)(8936002)(186003)(76176011)(52116002)(316002)(2616005)(99286004)(102836004)(71190400001)(107886003)(81156014)(81166006)(4326008)(2501003)(26005)(1076003)(11346002)(305945005)(7736002)(446003)(6506007)(5660300002)(486006)(476003)(386003)(8676002)(3846002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3824;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uVhj0TavnUKb0ucZniecjU6PQk0NcaMDEYB2p5okWIkaoSrM9KT9yEejJ9+FTwITEtSqAdaSPzEmVzqGUDNnMvRyeQDpzjIoJg6as0j22dRfedAEmeuu9j+QDRh1OlOqVDkLYt0WjPY7BlToIyeEHo5hNCTPVVCtOdIS1334LXf6Qedjxq55k69vhAtq1UssEsliDPVr2p6kmmdTHZO/NQmNB9WPfxp94f2pmjTjPazVLoLhFQtJC+WGP1F3MOC1SJq4TwbFpm+GqV7ETwh7MMnFZxyqS52TqnCb4FwkctujlRD5EzzgYeoTfF0j0Dj18bbCDfq7qFXM1ecYxetKDCpSTYtGjjUDsK6iASsmrVHoJhU8pqwdGYYePYVLu8GWJd+xbCdyQjD6WhgOhznBNwnYXKvcNqY65GymP/H47WZU0PgpsZfUkzggkfAfjQ/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc9ef3-0b74-487c-c2b4-08d7635e5769
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:41:55.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GrwI79XxO0x98Hgqzpujvy9LDH0aNuNRg7cKRPLdpSiIoNcT3Kupej9Zp1dKmOdpiv3iQAOief93tLYozBKkSPYYebz2k2HoahrzgnsnYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
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
index d696334f25f0..06aac894ee6d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2185,74 +2185,6 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
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
- * coupled with the spansion_read_cr_quad_enable() function. Both assume t=
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
-	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
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
@@ -4634,12 +4566,27 @@ static int spi_nor_setup(struct spi_nor *nor,
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
 	nor->params.quad_enable =3D macronix_quad_enable;
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
@@ -4661,6 +4608,14 @@ static void spi_nor_manufacturer_init_params(struct =
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
@@ -4670,6 +4625,10 @@ static void spi_nor_manufacturer_init_params(struct =
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
@@ -4930,21 +4889,26 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
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
-		if (nor->params.quad_enable =3D=3D spansion_read_cr_quad_enable)
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
@@ -4952,6 +4916,12 @@ static int spi_nor_init(struct spi_nor *nor)
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
@@ -5134,16 +5104,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
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
index d6ec55cc6d97..11daecc5a83d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -581,8 +581,6 @@ struct flash_info;
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
  * @controller_ops:	SPI NOR controller driver specific operations.
- * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
- *			the SPI NOR Status Register.
  * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
  *                      The structure includes legacy flash parameters and
  *                      settings that can be overwritten by the spi_nor_fi=
xups
@@ -611,7 +609,6 @@ struct spi_nor {
=20
 	const struct spi_nor_controller_ops *controller_ops;
=20
-	int (*clear_sr_bp)(struct spi_nor *nor);
 	struct spi_nor_flash_parameter params;
=20
 	void *priv;
--=20
2.9.5

