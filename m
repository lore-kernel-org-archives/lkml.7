Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aAYI6xPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfIQP4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:56:05 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:44005 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbfIQPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:51 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Apf1B9GJCiZDw+jQA31CcWj4oz26+t/0yIeReSUuM2R2wMhjHYi1J9pdTuTWAmAsjzM00P1lqG
 ZiQc5vnDQtG5QazFYZz/Jjb5IO6LuV4ck42EUq4LwGRK4wBf1z3/pfa9C0JYY6TTafppIl+LiV
 hrioTakKWdcSZr2idnYhGGpj7fnmrEftluHlGSZTTrCeMhh0W8ReohdxCjsaXOxdd1JTtD8cal
 StB0n47SUtlefexD5YOjEW3yh52fZ9NKNaazSY0m7y57QOW4leO7Mq4PxHCxG6Jg2ysYYDB/ju
 8C8=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="48252547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:50 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8JbjJl5zACw/hJt+IO7AQJF7DwgD0/MmCruhfNDM08k+w2dBJI5GDwmEavMyHdorQwTdXEe7A/C5u4jkHMY4KBKL5W2bl/1irgJQpWHyKvIdLygGa2Qj+EVx48yO+nO4CxFly7LbyjlCVtAzD22QJLmzPA3kH0u/DPMXcUbLOPQwY6gUneoXg1837YMhmJLexF15Axw6V0PJp8ZGQ4mRhzzL+jecWRdvrEa0S4yoJf3UrP+OZK+zzj9FjIBotTr4VRjLPGgMOb6IlwwTykwLTLbO9gG8qxH2ztHxpSr1cGpeDKLlmdgx7OMNvqDPGznmq3h+81Nok8Q8s4vcmzXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYQcNrzAE6sZu8knUk88f5RkdGT4W8F0yTAM/RLgr64=;
 b=PB4AFlzdxcS4etnf3E85UHoHOpN4n1atr0VBR0hswZaPX56auBin8Cg47GONykv1Ehgy9XnSZi6nH/CCjDzwY6DqgGRooNO9qod6ik+YOaVabMQn0A+6hPiMNwMIowSJ9byP5D8kPFSXIz+Gu3IlEx0QEO35G6giQcy7JeoOa04PDfvWIlodHgd+o6B5j6QFu3VzTnDk1r9KUyn2/2AzpeZYqQzOW143q+S1Yqf6M5noj0pSoAdXpqFjzXO06gfUCdGPphRJ8gInBoRNCt0Pl2SEvM9UlscxOzMOQSJEKkDQbE0ar+X6zkHLzq8xGWaskho1on8Lkz7cs0pFsv+w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYQcNrzAE6sZu8knUk88f5RkdGT4W8F0yTAM/RLgr64=;
 b=aAYI6xPPsisV/+a1CXvzQPineF0ISd4FzPct8TrCMQxhfkC3NOXRbxBGUhdId8eRarQyNNU1zDDiPN0ljyQ/+R/mQGbLPl7TCTDpeLZQTRm81kWDLlTvoX0eut/egQ9Y5O9enBPfctonmyCxapXFY/nFarbUNfSPbvWFM1tindQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3725.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:48 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 21/23] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Topic: [PATCH 21/23] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Index: AQHVbXBftJMrp6jhCUKqN9qjMF7NVA==
Date:   Tue, 17 Sep 2019 15:55:48 +0000
Message-ID: <20190917155426.7432-22-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab42252-9c6d-45d0-8853-08d73b8781c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3725;
x-ms-traffictypediagnostic: MN2PR11MB3725:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB372577DF75E32EAF9E616C99F08F0@MN2PR11MB3725.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(76176011)(52116002)(5660300002)(71190400001)(2616005)(6486002)(6512007)(476003)(11346002)(81166006)(6436002)(66556008)(386003)(6506007)(26005)(66446008)(66946007)(64756008)(186003)(66476007)(102836004)(316002)(446003)(2201001)(110136005)(54906003)(8936002)(107886003)(478600001)(50226002)(25786009)(2906002)(86362001)(81156014)(2501003)(6116002)(3846002)(256004)(305945005)(7736002)(7416002)(99286004)(36756003)(66066001)(14454004)(8676002)(71200400001)(4326008)(14444005)(1076003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3725;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BGjqiiaH8L5zq8jYmTJ58eIaSv4m4g1wNav9T3B4eN97IdkoHAy8DQfOjBH5OywIZii+8dtsbMlDO084xF66piy/Hj5S+HgVIJzOf5E1GdYXCx5fVr/JrUTxBq9+fDqpn/cycSKufJ3IMdfuQM/Rfl2Nyl+HDyuSx2lJnm4oCxfueTTOf9pEX0h/qluoeXa26JCpjdBPOkaZ00PsapbtsQBihWslrrzN41vFZnn2egAZm2xasGsNm1DumwwOAHmQ1pj3imKH63V4/5/pE5JZDHaD4PyPygNyzMIEYHO/nyaTWL6GlvLLLGby0nD9XrcvJXTsVKeaf4dXpI5MRQdoXeqs7usc0YJe5Dksp1kweTyio3yrzJ/Y9PLdTwrNIj/Wi+JRgtN43o05oxD/83zW2UVycLCW6H0ze4MRz8hgP4M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fab42252-9c6d-45d0-8853-08d73b8781c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:48.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJDxHIyNi2cQHtrfufxc5nOzD2TKf+K4CSgQYQxZoNUHQ2wEUEmhoA8fWKHZRnHhLKGP9orkJoEZNKwKgZxhQn4x+V+xjifdO6KK52rEX4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3725
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
 drivers/mtd/spi-nor/spi-nor.c | 142 +++++++++++++++-----------------------=
----
 include/linux/mtd/spi-nor.h   |   3 -
 2 files changed, 49 insertions(+), 96 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a9cdb6dbc25c..700b1700a7a1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2041,79 +2041,6 @@ static int spi_nor_sr2_bit7_quad_enable(struct spi_n=
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
@@ -4498,6 +4425,16 @@ static int spi_nor_setup(struct spi_nor *nor,
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
@@ -4511,6 +4448,11 @@ static void st_micron_set_default_init(struct spi_no=
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
@@ -4525,6 +4467,14 @@ static void spi_nor_manufacturer_init_flash_params(s=
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
@@ -4534,6 +4484,10 @@ static void spi_nor_manufacturer_init_flash_params(s=
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
@@ -4795,20 +4749,32 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->flash.quad_enable(nor);
 }
=20
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
+{
+	if (nor->flags & SNOR_F_HAS_LOCK)
+		return spi_nor_unlock(&nor->mtd, 0, nor->flash.size);
+
+	return 0;
+}
+
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
=20
-	if (nor->clear_sr_bp) {
-		if (nor->flash.quad_enable =3D=3D spi_nor_sr2_bit1_quad_enable)
-			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
-
-		err =3D nor->clear_sr_bp(nor);
-		if (err) {
-			dev_err(nor->dev,
-				"fail to clear block protection bits\n");
-			return err;
-		}
+	err =3D spi_nor_unlock_all(nor);
+	if (err) {
+		dev_err(nor->dev,
+			"Failed to unlock the entire flash memory array\n");
+		return err;
 	}
=20
 	err =3D spi_nor_quad_enable(nor);
@@ -4999,16 +4965,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
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

