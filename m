Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A3CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZKCIUU/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfJ2LSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:00 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7476 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbfJ2LRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:46 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: mIOcg3E0Rf1aoa8p/uJ/B3OVD5I8GiTDxcw7703OCBCyTYDo6qripn0lRmEZxunVowwOtj8Wzy
 pMVPCAu092ReS6o59Z85IkYMIOr7kxvfwnDLaWPtYpeMNQnTjdn33umXWp5ICD9qL6gtMLVZW+
 ZqG/URSvxgvEYMSPR7mgN81ZSexk7uI+pHT8X1MWmNhQqWfDjc1rdGXxDP3aTMphLIh6wPeFj+
 EEHMa6nBE3NZAAxQDIzdD5dzKfUYGvOm9pWHbzLKjVhqHnazZNS5Ow60FFUUw2aWe+bU+g2SnW
 RU0=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="54794591"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:24 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:17:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNdXA8xfpnZKiWB7ZfXVJgLfn/twXgFpOtPOjjeT8RfRflxhKTEcPCllRUu0x2abQPh4RMY5wHsr9VkCqjemVYR6HyYIo1HKyyZ0ES9LfOr2NM9Zx/e2bE1KPjxXRSs71JusoacmmU4yrxKOVtR+iVo8wFA1ZjJDQYqSb9Jr1nKE0GGjndbjqsbtUNvSwIxrOyG/36GtKY1x5Xx/ungU3A7nKQ0GNLLgvx4KgWtl42UtcvGw7rxUdbPGhUJ7arGmcFwseTqYPAMsn6GoKv1f9NGjScNgbqHYkWgtSaCn5UCq6K8qiwH822QVYjodisuNdbBpEnC6Wog5eKtE3IoMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3XIE6Wce7mJd/u7lBC9Mxn7cam9jY/anHqppnudylA=;
 b=YvcRnFoG4eSwWNukubvzCJT9/hQtgx6ANapSYmaOjjV+s5CQthFnyLnkINSkge+k3eVOYsOkU6EPoU3tkPnuHOs5FylDbvlboir/8fLEMqDpnSndgxgZzcv3FA3DbQfJjAn/4seQzHW8foEgcuwBFUos+uLZO2ePJDXdvNrIHiKLm3GUSkYa5kiu1PtU/WmykbWpJs2NB8mIAwrgD5uxaiw0NAkG0ilrqDWfTREg1/elrN17Sfs6fk4AFlXvUzaSZiel0PcZJbe9TrBE/UwGAUYQI2Iu95gjTezqtjmxaV2v2qLv3iG8rC68xaXu1vk8FT8Xhf9/1zlpuZOQ+5FByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3XIE6Wce7mJd/u7lBC9Mxn7cam9jY/anHqppnudylA=;
 b=ZKCIUU/Az4efcg1dbp7SuYviesBZMcnF/fFuG+7DOhd524tle44io5mNSpy6u0f9++KhaZ7JwrGI2lm2a74JexfI1kxtmgq26XTIowr7WAWsh6fMAGkSrOvZ0WefU9Ht64x6ntpMwsHN3QAwdCH2q3+ZuL9oOB586MBz1e0J/kU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:22 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 21/32] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Topic: [PATCH v3 21/32] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Index: AQHVjkpv2LM73nqmLUmPeai8pIQe0Q==
Date:   Tue, 29 Oct 2019 11:17:22 +0000
Message-ID: <20191029111615.3706-22-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [83.166.207.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71c6fd1b-961b-4499-1192-08d75c61919b
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823DACC2E822298377492BDF0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtHYC/RmVfbtJ7nj7BEHeqIQSY3UzjcZCOgxXJRlReMSXOfDxz8fXD1fvpc3os2x5y25rdQI8K4+SllDWUvksS3SjjPjaZScX19UDbBney11QVf3X7c2yRdWCowvXu8Cl7RgffgOpyzzAGUWaltGSew09Drfy/OxfogoUlxIbuSnxoixNMKOOGzkysEJRGA1QwhXZAib/NmGSuUOTJi/LN7+MIlKxs4IMC7zmFlEW5nXTg1yhU45V4fEoD1FqK7J7IcLLttv1Abv9NVvyI607hKwlcLPz4rAxfO92qNYMlsLEm9I7tIZgENlMbddsgJSMCX1GXcKSiJduzh8hy/kG9DlqOQHRY2o6ZG0QOthvZfLiu8SNTacNo+HTyJJYYji56u1+gtt9eVd8eB5/mQWe2mnVkyHHdpRI5x6tqPQkZSc1PItCjKNXo/ZhEUekoT/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c6fd1b-961b-4499-1192-08d75c61919b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:22.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wiu7KHaHnU0dJSg0GVWyMtTWtlzLaZVEhpv065TR2xNV66HnBbdblhORP7h2lSaPaH/sL81kX/X3moF2AHsA5q+g5UnL2C2zBEoxq4lKBtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
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
index 6102318cfd03..721e5307fabf 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1971,54 +1971,6 @@ static int macronix_quad_enable(struct spi_nor *nor)
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
- * so leaves the MISO/IO1 line state unchanged, hence spi_nor_read_cr() re=
turns
- * 0xFF.
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
@@ -2170,9 +2122,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
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
@@ -4654,7 +4606,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
-	params->quad_enable =3D spansion_quad_enable;
+	params->quad_enable =3D spansion_read_cr_quad_enable;
 	params->set_4byte =3D spansion_set_4byte;
 	params->setup =3D spi_nor_default_setup;
=20
@@ -4869,7 +4821,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	int err;
=20
 	if (nor->clear_sr_bp) {
-		if (nor->params.quad_enable =3D=3D spansion_quad_enable)
+		if (nor->params.quad_enable =3D=3D spansion_read_cr_quad_enable)
 			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
=20
 		err =3D nor->clear_sr_bp(nor);
--=20
2.9.5

