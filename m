Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728C5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B55214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="APOmOxqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503997AbfIXHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:47:09 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29843 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503956AbfIXHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:47:07 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 2n8fiQ5emTyMj5JDKQ4xsgr4+TuqBORD0EQxunfuoxyt0ZpZ321TCAUI9TTkiOEj0dnbPb6Tt3
 k1uS8PLnE+xWsDLwwFFGtf+5pwvtLiegebLYd/NwWWcxKrvXSsUi6lCjMxFakXDrGrEZI6qI8x
 9+tjCp2lO4g65j/MqoX9lh7E0WUGwPt6I3c369JVwYptjQPlssPwG33lHAur5IQB2v70Y8DTBL
 9uoNPKaUgQGNpg8iVTzJU2UBX1fWlLnPROgHNNloJaAejUrISkBKf+iTHJTOC2GAdDpAJdEc/Y
 RQg=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="51606632"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:47:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:47:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 00:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VneQyzS2o4mmEGatOGgWtQ3/fIaKtxfeVFaphNh7l3spGNGqsnJrAXUCn3pLYLmEjWs2nN+HMYcp+e9zMtcL4YLv3F+ek/m/zLU/twfdl2PyEiayoVFb207gHxP0HFWEGZsbV0GW6zvkHcYhiIvCUVbsa2rIxsPwpZAmDNV7UWKGLbMBeM0yyEKVXCKlTd3VxchgCLgslKICh4Vyv6TQETujLziiON9dt4hDLBFd2ThFesWtKMU7V1TtmpNWvSUJIWqiIk57+mGta+w/VClyy+ESEd+P7MECRjGaYXyi10Crb/y0hKEy5f6QxKzib03n7qFvNEhpUAIw/KkovTVstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSE1fOq/kdPKPQTHqi+CW+C5tcrir/SqLrGQhykOWio=;
 b=mc657M8FrPYd+pq2QTCWGzNjn66n1FBZSF6ktflsD/EYvNoFUmxjHsizSpLy2HpWnHxoSe6hlM11fJFR/QPFZNGkcwM4hOXg7yWpGQtD9p8WqD0rpvLFD4ypHIEFEoY/yCByaIj8jhCt9jrkd7RYWMSi8blJgg4aCrA2DynzbAArJ8TkwJlI+dnlsQMH7l4dyBISPk40/aMX8fraQk0WSPuE48hYrrOpSkwU44br998Mwdf9gakthUKUGTEIbZpnBieqU032YXYkbbcsTe0w/PYDGpqtP+u+zoRmNoZ252vrQ5bIM8VF1IPjjhQxNk+y6aWpvQbhbYjzb+0maF9GHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSE1fOq/kdPKPQTHqi+CW+C5tcrir/SqLrGQhykOWio=;
 b=APOmOxqGTPbyNIHaHCkxxS1CfZQKpVaZFqawKZcngfuvR3LMl4GKd2njbTM6n8T+JFVwfGcJOvscEJxLhLYHu+c4OaoLfnfS/8rG6Y51f1pX/r32ayEworrhOizVrtGNYWGVLodWLOy53+1HaZaZMuY9pUViSM/hOsVhU+12S6s=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:47:03 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:47:03 +0000
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
Subject: [PATCH v2 22/22] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Topic: [PATCH v2 22/22] mtd: spi-nor: Rework the disabling of block
 write protection
Thread-Index: AQHVcqxByDKIwNPCUEeLfrkgumi1Aw==
Date:   Tue, 24 Sep 2019 07:47:03 +0000
Message-ID: <20190924074533.6618-23-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: dbd04d45-b3f4-4fee-9ddd-08d740c36392
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4319A962476946511D8ECA82F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NJMiDS1Vk6Ys0ah7oKbKhSvbfTyJLLFevFl/AU6Ei2svMLiAWx69lZVEoL9g8cwnAxS3xCtWRJiXIiXcrOm8fXl3i7cE+qyKb7FZtYmRZYOuCDLQHiLFWVa7rTV/1C/PL5+mdQuc8Ho4MbEkGcv2VGtNRPajQ7f6utLo2X83hFr47An41C0BVPra6PnXeHTubddkWIt8Ot4yxNQg/H5szOCEeoJolo3bKVHSDR+z644mip0izzCqw52lysWbXQIO1OlB6zoXrE4ko0AMCLL2mZgMtH0l/YxnNP1hbFLT7Z3SbGuWWr5l03WhTbDQqqWc4PgDHBHW2eLvpKj1ElkIK3ZgLuB/+VMRLCjd2JqEOCnkV3byhpe1o02DGRWXW1qytXXLOFeGDQXne7NnfbkIM6L6cmGhwcPRVYeslmD+How=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd04d45-b3f4-4fee-9ddd-08d740c36392
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:47:03.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRED9qSE2lcIhdOMW7nfpqfjKIRxDNzipAEuDTqk6QOF/gEk27CLmsAQFU9ThePeN2uSzGH7dwpDu0G7+6s/YlhvHTYlaxYuqwkQ4K5otMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
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
 drivers/mtd/spi-nor/spi-nor.c | 146 +++++++++++++++-----------------------=
----
 include/linux/mtd/spi-nor.h   |   3 -
 2 files changed, 51 insertions(+), 98 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a53e2cdc564c..7b61edf284a1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2085,79 +2085,6 @@ static int spi_nor_sr2_bit7_quad_enable(struct spi_n=
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
-	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-	if (ret)
-		return ret;
-
-	nor->bouncebuf[0] &=3D mask;
-
-	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
-
-	return ret;
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
-		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-		if (ret)
-			return ret;
-
-		sr_cr[0] &=3D ~mask;
-
-		ret =3D spi_nor_write_sr(nor, sr_cr, 2);
-		if (ret)
-			dev_err(nor->dev, "16-bit write register failed\n");
-		return ret;
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
@@ -4542,6 +4469,16 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->flash.setup(nor, hwcaps);
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
 	nor->flash.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
@@ -4555,6 +4492,11 @@ static void st_micron_set_default_init(struct spi_no=
r *nor)
 	nor->flash.set_4byte =3D st_micron_set_4byte;
 }
=20
+static void sst_set_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
 static void winbond_set_default_init(struct spi_nor *nor)
 {
 	nor->flash.set_4byte =3D winbond_set_4byte;
@@ -4569,6 +4511,14 @@ static void spi_nor_manufacturer_init_flash_params(s=
truct spi_nor *nor)
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
@@ -4578,6 +4528,10 @@ static void spi_nor_manufacturer_init_flash_params(s=
truct spi_nor *nor)
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
@@ -4839,21 +4793,26 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->flash.quad_enable(nor);
 }
=20
-static int spi_nor_init(struct spi_nor *nor)
+/**
+ * spi_nor_unlock_all() - Unlocks the entire flash memory array.
+ * @nor:		pointer to a 'struct spi_nor'
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
+		return spi_nor_unlock(&nor->mtd, 0, nor->flash.size);
=20
-	if (nor->clear_sr_bp) {
-		if (nor->flash.quad_enable =3D=3D spi_nor_sr2_bit1_quad_enable)
-			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
+	return 0;
+}
=20
-		err =3D nor->clear_sr_bp(nor);
-		if (err) {
-			dev_err(nor->dev,
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
@@ -4861,6 +4820,13 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
=20
+	err =3D spi_nor_unlock_all(nor);
+	if (err) {
+		dev_err(nor->dev,
+			"Failed to unlock the entire flash memory array\n");
+		return err;
+	}
+
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
@@ -5043,16 +5009,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
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
 	spi_nor_init_flash_params(nor);
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5590a36eb43e..ca650f895903 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -578,8 +578,6 @@ struct flash_info;
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
  * @controller_ops:	SPI NOR controller driver specific operations.
- * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
- *			the SPI NOR Status Register.
  * @flash:		SPI-NOR flash parameters and settings. The structure
  *			includes default flash parameters and settings that can
  *			be overwritten by the spi_nor_fixups hooks, or
@@ -608,7 +606,6 @@ struct spi_nor {
=20
 	const struct spi_nor_controller_ops *controller_ops;
=20
-	int (*clear_sr_bp)(struct spi_nor *nor);
 	struct spi_nor_flash_parameter flash;
=20
 	void *priv;
--=20
2.9.5

