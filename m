Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540ECC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2CE214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OfEpwMbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502918AbfIXHqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:49 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18442 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409426AbfIXHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:46 -0400
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
IronPort-SDR: lcXwKEPoKAnDCFCzNkzoGOtylOV/oiJR8NoLtcNQQWoHcqMVczI0k2fBo0iESnFfnqBAwGx1TM
 XceqslJxSEyGKs5Fo0fek5Wk6D5wj5PZqxzBXHXhw2eNg/Iiey/5jdMQCF8gJM5XjLkq8j9MMO
 ZgfL0dA+qSIOZLHTEbEt8yOhiK/5HlKgZja9ClZhn9AHMMa7Vvetulp/nUHHrmeHYPM5bmUDbl
 wsrF7SxVupR0Z14bPkBlZwe/Tj0APbiLTsYMRysi4o3kQ2l7NgGFoxESX46lzGR5T7HfibdQKR
 EbI=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="49066182"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:43 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYr+sZ6FUJw0HfKaVHcQhyt7MvOCmdUKwhR9vVGOts0cNkottBKjZeQxp7jSK4KIECPZsbiIs+saZFfrMROaDelRfJnx3dqjdgl3YWbs6POYCxs+/vaDYFs17xIABwRhpvtyGm60w6wdD5MczACix3rmaOAUz554Fsv8muP/cULKYtj94YNNdQenQgjhv3fH9U8Y0eiSAjsLav//GmgWTdqGhg2PBy4VtlDAWuc64t43gT2ji6bH5MDA8M1f6SQX/wDzKndDitfdmaYsmvnFvI8amZiC/35up6hFgo3qhekcNZxWP3zNqg6QgPUD6nPRjUq91KFHq8QB2X6Wa2Bvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1dAOPK136RfXjG64CR3YRJTj1gmNkkRGBCZ16701yc=;
 b=JczaWa38dUADlFdNh8bfv0Mafq0QJoUm6rwikd/9NGkc4ukI+1ouFUP45qZinPtRN6X30v0sVjfw7mzFX9XrN7/TATRS9/h5I9AX3J6G/vMKyIdAC5IxqZ9oKUoSQB0nPUbCdKkPpG4r+jLttwuoN4poXSMaIOHH6JcV+gnGPJMwzbNCkPset1cutsZWDr8l8DhGohIe1pz7M6YAxAq2q10+7VjbhYOONzWJAC+CZ5nj8eTb5kL/aQF+JXc9WXB4IMS7ZF6uEXA5DucBRA2NJXr5Tb8Pm6mzgGangSrX80lu3BR7kb2NVoEviVUrwOBZryQ4x5YTQLIgKCyE7e0zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1dAOPK136RfXjG64CR3YRJTj1gmNkkRGBCZ16701yc=;
 b=OfEpwMbAKXCZV9mOhZyelpWVAotPqN+1yZOQF8OKkMhjtYUIJ4NVnwK2AGUjCt5Q/izfYow8Mu1GY2tEuLL1GyJX1NWHDqFxFhM6GhvJPOQBG5JJy2TZZQ1awafQVnVBwPAhKOr1P7/8gfSLqD1Z88n2HohMTSXAVALjTlSJRbY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:41 +0000
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
Subject: [PATCH v2 15/22] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Topic: [PATCH v2 15/22] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Index: AQHVcqw0rTwdPSINzEqLofiTPWzT3g==
Date:   Tue, 24 Sep 2019 07:46:41 +0000
Message-ID: <20190924074533.6618-16-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 72065e81-89bf-45a3-5090-08d740c3568b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4319709EDB62E0CED095C440F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hogk0Fm8KMi6Gm8VDNWXePPMcEGZA8En4kiNQHUMZRCxRQHVcmK6xXJCXW67mYIlvGD5yxuC8alICDMReCRevKQym+tvU0sByEVUcyJx0LtE7J/hGGMbX7H75AJp4uzVsWIoJ1mpQ+/KjjPWlFFcm1Haev3R7w8GJ4TOLW31VWlyPQJp8ZL1vXwM/xFXAqYf5UWIccgcNDbIjY/N793PI6ekDyMMEqV4+fp48FYx4B2QM6JLvjqMk2iorVJXP4OJCZSk1A88DRlK0mlJFiKQHpWOeC3qMK91N+sLoJKZN7ci0UVCzy9SaihCRFVjfUStL0kMUinrW47SBBfQTA3TWJ9/qvDOhlTLAf5srXiIGJ1/xc48F+Y8CFFjwB5Ic/HK47Vtl47xeLEcMYmdB1gT8syUs6+DQUmT1SzpLD3NtcI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72065e81-89bf-45a3-5090-08d740c3568b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:41.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ah3Qr5TuC6ktDmrY693eqvIJBHABCOEdo4bzeITxHxxECo8zGlzpZWGdvjkXLlbLrBua20RW4H8nxudmSxT/ZR+eIBj6T7NZpjPCm3jz3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Drop the default spansion_quad_enable() method and replace it with
spansion_read_cr_quad_enable().

The function was buggy, it didn't care about the previous values
of the Status and Configuration Registers. spansion_read_cr_quad_enable()
is a Read-Modify-Write-Check function that keeps track of what were
the previous values of the Status and Configuration Registers.

In terms of instruction types sent to the flash, the only difference
between the spansion_quad_enable() and spansion_read_cr_quad_enable()
is that the later calls spi_nor_read_sr(). We can safely assume that all
flashes support spi_nor_read_sr(), because all flashes call it in
spi_nor_sr_ready(). The transition from spansion_quad_enable() to
spansion_read_cr_quad_enable() will not affect anybody, drop the buggy
code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 58 ++++-----------------------------------=
----
 1 file changed, 5 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d971f5a4b11f..668afa9a8c87 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1869,54 +1869,6 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
=20
 /**
- * spansion_quad_enable() - set QE bit in Configuraiton Register.
- * @nor:	pointer to a 'struct spi_nor'
- *
- * Set the Quad Enable (QE) bit in the Configuration Register.
- * This function is kept for legacy purpose because it has been used for a
- * long time without anybody complaining but it should be considered as
- * deprecated and maybe buggy.
- * First, this function doesn't care about the previous values of the Stat=
us
- * and Configuration Registers when it sets the QE bit (bit 1) in the
- * Configuration Register: all other bits are cleared, which may have unwa=
nted
- * side effects like removing some block protections.
- * Secondly, it uses the Read Configuration Register (35h) instruction tho=
ugh
- * some very old and few memories don't support this instruction. If a pul=
l-up
- * resistor is present on the MISO/IO1 line, we might still be able to pas=
s the
- * "read back" test because the QSPI memory doesn't recognize the command,
- * so leaves the MISO/IO1 line state unchanged, hence spi_nor_read_cr(nor,=
 cr)
- * gets the 0xFF value.
- *
- * bit 1 of the Configuration Register is the QE bit for Spansion like QSP=
I
- * memories.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spansion_quad_enable(struct spi_nor *nor)
-{
-	u8 *sr_cr =3D nor->bouncebuf;
-	int ret;
-
-	sr_cr[0] =3D 0;
-	sr_cr[1] =3D CR_QUAD_EN_SPAN;
-	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
-	if (ret)
-		return ret;
-
-	/* read back and check it */
-	ret =3D spi_nor_read_cr(nor, &nor->bouncebuf[0]);
-	if (ret)
-		return ret;
-
-	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
-		dev_err(nor->dev, "Spansion Quad bit not set\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
  * spansion_no_read_cr_quad_enable() - set QE bit in Configuration Registe=
r.
  * @nor:	pointer to a 'struct spi_nor'
  *
@@ -2071,9 +2023,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
  *
  * Read-modify-write function that clears the Block Protection bits from t=
he
  * Status Register without affecting other bits. The function is tightly
- * coupled with the spansion_quad_enable() function. Both assume that the =
Write
- * Register with 16 bits, together with the Read Configuration Register (3=
5h)
- * instructions are supported.
+ * coupled with the spansion_read_cr_quad_enable() function. Both assume t=
hat
+ * the Write Register with 16 bits, together with the Read Configuration
+ * Register (35h) instructions are supported.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -4560,7 +4512,7 @@ static void spi_nor_info_init_flash_params(struct spi=
_nor *nor)
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
-	flash->quad_enable =3D spansion_quad_enable;
+	flash->quad_enable =3D spansion_read_cr_quad_enable;
 	flash->set_4byte =3D spansion_set_4byte;
 	flash->setup =3D spi_nor_default_setup;
=20
@@ -4776,7 +4728,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	int err;
=20
 	if (nor->clear_sr_bp) {
-		if (nor->flash.quad_enable =3D=3D spansion_quad_enable)
+		if (nor->flash.quad_enable =3D=3D spansion_read_cr_quad_enable)
 			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
=20
 		err =3D nor->clear_sr_bp(nor);
--=20
2.9.5

