Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Rn1OuK/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKBLXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:45 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31059 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfKBLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:42 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RNVMIOujbi/VynEw2teRWBKVU2xECO7wjMT2RIif2COWDOHPa25dl2v/i8scsLCtWElCLrEH5Y
 uNfeJ/kXGacdywggj++5GTZidRuZRm7tBDgNZoQLG6rWyPpjXLxru++CF8n+L9yfK0fRFALSG1
 jiP35j8AoTJF7kOJkii7qP+KjsX4E7zEdOSMyZFaltkGXu518Xw9ksFR4LLsKeS7SU+9c9hH2x
 27+n51WjmLriz6SnjqanJlpdBk/NxFVorV2f/izCKk6LljJRFATIpgn3kBb+XpkGhu6MSeXWmz
 TiQ=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53870306"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:40 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaq0jes2dvfHMeFC94KrsOo6F22vHdGPdttqQnyxAq0Vdjc7r8xzWdU74gTIJ1hzXnh1gXOmltDXOVa5ADymf1h9ZOPb2GiHgGIFgDsyTgcZBdaG66wbIZBZiQ1LVoVCU29VY7kvEpOgydqiAdwjw0e/WcWD6dwdeXetdCQEv40u+Mq0Y8kZA2zROkk/uauFHaIrOwFCM24uDph2nsF5gb7+P5p1S6rN8k7EPOSDcq2v2Kxh/KQKUHkX19cILKJlISZRJsXjmILs4GoeFi1fusEU1WB/2dyZDv5nZUG1e9uu4yLhhC/F7TcwfWSacnlCUCWZ8V01TveZR6UV2qvIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU1gVLscW8cUt5ZFDLWUy6ThTg2+ENSg4fxK3XHSIv4=;
 b=UMkEP8EEixfevJ/SOiDP9kNfwgI5QrcoueH/Hzrnz5UljMqTgcrw6Y6LXdXKeI7FR4kOQlX/KSorbrgEX7ILX/cBmni2Dm8nId1hzBiI8szKFvzEhPLhx0EsE/RInHFs4jR+y+h4jZWWX+zhyG1QZCDdKx3S19kPcTMPVdMseyuXOfypDDNFxxKQxnZEy3ikh/ooIDhLEwDfH/sExWvcVc/DmIn23sZ8IXRKZcPo6tOtNG+aLYAdzpAeDcj1UeFtyaxDMTiQoDWL2uLp4lfibL6w48ImiJL7L0KpVBidPgeLxYbAGl8X77OLSjQ9FaR0z/9JQFjGd6LCpwKoeOzkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU1gVLscW8cUt5ZFDLWUy6ThTg2+ENSg4fxK3XHSIv4=;
 b=Rn1OuK/VnuHL8YFc61UwwAJyHUcE4rw2DK98FpyA/PJwXItYidz7ar7WS1YIUobpUC9qBj5kidS+uh0GrYlC0pTwpyC7zcSjfaOaVmgXMA3meeCKsSGio+Pmooh/7o+i7cTA1ed1Nozw516BMDixZmCg2/CydZzktXVUZmsMJpo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 09/20] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Topic: [PATCH v4 09/20] mtd: spi-nor: Drop spansion_quad_enable()
Thread-Index: AQHVkW/5Ftew1U8fT02D5+RP5z+bOw==
Date:   Sat, 2 Nov 2019 11:23:39 +0000
Message-ID: <20191102112316.20715-10-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0ec7a733-5f32-45ef-31b3-08d75f871bfc
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371151AB84C91A58D87C3363F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nm2rFs+QwCg09VGnOGE2Dkli0TEN4YrVAhIA5++pnHvCDzCo2WieeiDwUX14j5cFX0Yprk03QXC0q14AIvr5Wvtp05HhyOwpvz3GsAAPrS8UsFUtYa1YvYKFhnfbL6EJ5Cc8SITfzEJHlo/gWouqRmqnq5ZGT0v+I/uQhSemWljWzIBw4stI/sZ9Na/gzpg2DF6lEpYpkyxdAZivPdLzEbK7Vwzju/D9LXc9S50BCrc4JnjKTpqroYD/altz0XKMn9cvEa2hMmxw8FCtPgVY7BAM/T1jRWIbft1vkflRa7sIz2oW672xPWE9mPsRcrpnHZVdiQhK/zrYrrOHzMbtmiZnQTm5Yy149pXeYmVnYj7F/3/FQYyDSvbHRRnudmAVaw1unX9KQJaIPfhwUQk/Jv9ShmEy+A8LsDTexs9Sls3e+mbz+/aWmdptr006ABV5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7a733-5f32-45ef-31b3-08d75f871bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:39.3799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGKdYB3iSRrXcqg3x0VfwuS5tXeXnL+qi1GdbJp+E7E2AH6Gk1yDOOI8R3YwDvY7WRQqPKWwYNM8lVNgF+EVyBhqJZdlYUZuPJuguKEDirA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
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
index 99a9a6aba41d..f5193733a0f6 100644
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
-	ret =3D spi_nor_read_cr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
-		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
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

