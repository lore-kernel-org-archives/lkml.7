Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8821CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45644214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="J/UN8K0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfJ2LRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:24 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36137 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733081AbfJ2LRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:21 -0400
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
IronPort-SDR: lhI0e4ncpYAboTngZ9vo4M6NcQYVeUbrL56V+Y7i6BRqZsbuo7WeRei6+PRok74GPjYAdAxgzo
 JKDeWLP88k0Yb92uSSaHR3tNBxEnbUUd0Hu3osjpvo4wPLEioGVSLM1Reanjqn9yC+Sv3MoXrJ
 1s1OkphbFmmmOuFvb+7kgrqhdkt+/YmMev9TPVqD8tBNT7xPudddtUQcTP5imzmdLQstdodaWJ
 yVBAJBp1nLsSZ5VYxdaB+7FAZgdlsrPGQ44NxAKWQRSnvowEbr0jwLKB3P96CM7LFHh87baL7G
 pIw=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292101"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:20 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUD7augFhrBacQ8PTwKhtKW3aMk4YkohK6tYC+SENDEjk81zPXmcshwbAiD5D4mCt4tEkRZ+XWweZqFTZ7SKsnsBnESVCb5NDk+snqzXVtXm33X2VjWCo4ALvRLJ+dSC7alripbqlFr/OOJortKgQoFH+0cMn1eZ3aYuL8QYTG8YgRQ6RrjqRqeZe553DLVR0nS3xPsZi4XlGdSUTxdQjmvhQo/gmKy5f1HgCcf0NlnjBjD/tKJB5Myo/ohdOttsU4vVO7SJZNrklkMIy5duKI7+5uXZXPWjzrbl9ZxJ3nxsTJ/exn6qNbT6vM/F73dNPPaYMRdfVFMJpOzaDBJN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbYYjGJ4IUN6LacUPnQz8lhjoyN8a7X75YIB2M7Z/ko=;
 b=nDxePfLbkGkhVIzqg4mfaVC15sgcF8nGn1FPKoWwI3jrRyka9bzX7fR//hBrLL9rRT7/fu1E35m/q2qPQhuicB84bjG8G2P/xnqmtZXPgz48VK3Uecnx7BoKhsbkzxd0PO2yXLvc/QGVTGZhl1WJHVFeIFnSHs4KLO8Hzde2v4j7O+urmrvN5ymiAxTc3EZV0p9cyMoUebuxk16qvq6LuR4miHyd5UyQysNN9058ZIpyHbYs0evY6mcUP7qXg/oVWlCkktnETrUy9mtZizMZD2dbv5rlZ7greetHZD4dsLKgEOyPr/U+9DSXtIivKY14qmwYCNvGV2g1Jc9RU1sf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbYYjGJ4IUN6LacUPnQz8lhjoyN8a7X75YIB2M7Z/ko=;
 b=J/UN8K0novqdc94g9F9B41gjLLBPT0KR/7p4MiLttxrVPGE/bBCHkDFeqYn8SYFmxn1fbwvl51jGI0NisPydVYeE06rmpbne/DL7k/HXpfFQU1yPEEMOKbE2jUVmZe7A2t3dQiFytLDIM1v5z3fatMkVSKPRJGv+OkZV1skqbfM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:19 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 19/32] mtd: spi-nor: Merge spi_nor_write_sr() and
 spi_nor_write_sr_cr()
Thread-Topic: [PATCH v3 19/32] mtd: spi-nor: Merge spi_nor_write_sr() and
 spi_nor_write_sr_cr()
Thread-Index: AQHVjkpt+w8BcBOce0G19NmViwpvNg==
Date:   Tue, 29 Oct 2019 11:17:18 +0000
Message-ID: <20191029111615.3706-20-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: deae9254-a131-4dea-ddf9-08d75c618faf
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3712CFD126F088B50181F244F0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fnc7thCqWBIIS8e89j/vFIC+ibMf39xeOL9fhs7HAqdtxgSdcRoN25rRhjrAqf03MTXvz2GWiBcDtP6d1K9t1h3WwHbsBT/vWRRsCWGjitooX4f3SH95Dpo3+tjz3JJSaCijW3MkA87eQLkHOv9aF+sJ9Wh8MBlL5A8a09St5yGU2arvhovcn69kbvzZX55Bf6dS7rPiYwSkU61mBL/Vb3Mw3835i7yziLoil0N5z8rq+q7Qw3kp0KSA5x6nSOzRA0/3wtSwOYiHL6fxIOadAPKPDGKEZNeR6jZmUnftAfqExJype9PKgqDfnPYCskL2vvQTtUNK6u/GZmZTNrtz5r23Z9H8/uUMVC7oTuzm4CyFiW331G+Qa4JouG+TpzSADQZosTyyAj0H7MTZ+ATcHmE+QGwvZxCSUF1aDHihhgTJiMK6mpZL1xyKuDnieKmo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: deae9254-a131-4dea-ddf9-08d75c618faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:19.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xC1ycu6YJMJ1txR8VqJ6ZKSn4hUOOFfmN3EcZVm5fzEP9GYLHPybpAv+pVC/y5mkg4bguxDT0LM5uGvmm244VUqIpdtaLXxwjs9J5djwgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Merge
static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
into
static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)

The Status Register can be written with one or two bytes. Merge
the two functions to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 74 ++++++++++++++-------------------------=
----
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 274786e1988f..823b9b06d34d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -824,16 +824,18 @@ static int spi_nor_wait_till_ready(struct spi_nor *no=
r)
 						    DEFAULT_READY_WAIT_JIFFIES);
 }
=20
-/*
- * Write status register 1 byte
- * Returns negative if error occurred.
+/**
+ * spi_nor_write_sr() - Write the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		pointer to DMA-able buffer to write to the Status Register.
+ * @len:	number of bytes to write to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
+static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
 	int ret;
=20
-	nor->bouncebuf[0] =3D val;
-
 	ret =3D spi_nor_write_enable(nor);
 	if (ret)
 		return ret;
@@ -843,12 +845,12 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     nor->bouncebuf, 1);
+						     sr, len);
 	}
=20
 	if (ret) {
@@ -859,49 +861,15 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 	return spi_nor_wait_till_ready(nor);
 }
=20
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
-{
-	int ret;
-
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
-
-		ret =3D spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr_cr, 2);
-	}
-
-	if (ret) {
-		dev_err(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	return spi_nor_wait_till_ready(nor);
-}
-
 /* Write status register and ensure bits in mask match written values */
 static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
 				      u8 mask)
 {
 	int ret;
=20
-	ret =3D spi_nor_write_sr(nor, status_new);
+	nor->bouncebuf[0] =3D status_new;
+
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
=20
@@ -1868,7 +1836,9 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
+	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
+
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
=20
@@ -1915,7 +1885,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
=20
 	sr_cr[0] =3D 0;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
-	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -1957,7 +1927,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
=20
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
-	return spi_nor_write_sr_cr(nor, sr_cr);
+	return spi_nor_write_sr(nor, sr_cr, 2);
 }
=20
 /**
@@ -1993,7 +1963,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -2072,7 +2042,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	return spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
+	nor->bouncebuf[0] &=3D ~mask;
+
+	return spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 }
=20
 /**
@@ -2110,7 +2082,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
=20
 		sr_cr[0] &=3D ~mask;
=20
-		return spi_nor_write_sr_cr(nor, sr_cr);
+		return spi_nor_write_sr(nor, sr_cr, 2);
 	}
=20
 	/*
--=20
2.9.5

