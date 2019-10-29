Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8384FCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4432521734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tMdFByFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbfJ2LS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:29 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36120 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733014AbfJ2LRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:20 -0400
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
IronPort-SDR: 5EKVjONTwhOxbZ4jf5kmRLi7PhVnyn6rkSv7Fwx5hT0b7wsl9+F2kGGKb0De9vTTMH2Q4DNoRj
 ExW12yjtS/0kULYaVOyyjBklF4rZagRtxij/re3KPqfcy/invlJNb/PmbVBA3H3VUQlFZEHDrc
 H/PENOo7kw9OulWBgN0f4BzqfDlwFwqgcYIi/uHjPe1EqnLe2VkwzKihDKn106ERnccOFM04hj
 dgXycd43iILVVkfwNWSS+L7Heao6eKxF+MirtWnvuW+V/9F+y+7MAXEvFkBnTy83SRvez3f7Kd
 T5I=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:17 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL6V1/Kz6l47NVDvcxpFCjPK/gz3hb/pkxru0pollgYJ0onxofUu97mGGsb8wvd1G466qXWRN1PCPbdlncgOskuTKYWQKPCPxZTiIHHH3VnTbkP/A53dxohXJ2Wy/GD4bVfmCwpNEjPiaW7nr7D9vRUo18r8sus8AfOD6quJyZpgE0MzSfR9TtRYfV5cX+IKHOm/TyD3XIoRn2qnR5S1EBVUGM0YX+YJph0wNyK4Y1qdJFIakiTHytU9OQyb5/6NmX4VcgrX9MMg5wmEZrqyp/NwnzCQ9jPdBpeY23KC/eogoTOMVNWvXf9aait1NGTRSgsSUDlzqV9fgl64dliY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iccC/jzXnQ44RXQzCjL+CYvlBrrBZhIvr5B2dcrv5vg=;
 b=Ar+C08WWGNmF09kMJiG6amEvq7GILs3CjpzFYrqVHpgmWfzEohH05c9wHVBZTQsZbP3DC0PfhdvK96mzJyShum2/8cLVvzW+E80afmTEcpLH+YL69EcfPGP70W661oTZsJwVQQK8lH3LKEEYerBTBThmVt/ier1Y6kKMbyUXthiblrgHwhNsYg5rhIVyuUGKjaOJn5sdU3BHL8YDYNCbRa9IMhTItK/SDBrYJvfYJF3awAVY8Cxii1YP5F7BMUb2LUPPU3ZcvmU/26C90WsTucluB1PMtZGMAAUvu5L8cROLNpbxvGY1gpJRJhZoHWNmu8fngzEKL5LqPJOrVLqTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iccC/jzXnQ44RXQzCjL+CYvlBrrBZhIvr5B2dcrv5vg=;
 b=tMdFByFL04ekcgRdep/3LPJoGkyjeKhrGW1/MEQY3Xi6nrC1zQ4S51PV6WlMLHIqoDE/c/wehsF77QhD+jGr0B+0jzw2T7VdYCzXm+uKy1I40vH3IB9yzI91QXb13sCxnoRiSxeToj/FxeZZaPSRhRYpEz1s1UYc60x7sXKCnc4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:15 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 17/32] mtd: spi-nor: Move the WE and wait calls inside
 Write SR methods
Thread-Topic: [PATCH v3 17/32] mtd: spi-nor: Move the WE and wait calls inside
 Write SR methods
Thread-Index: AQHVjkpr8F0rwzTvmE6TWCmKgh0hVg==
Date:   Tue, 29 Oct 2019 11:17:15 +0000
Message-ID: <20191029111615.3706-18-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 66ba775e-e377-4339-89b1-08d75c618da7
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3712C0F92CE35B8922D7AE83F0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(14444005)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAQXYRQRTcjBEiXvzi7tthGBs26CsH33OMHi9uWFz6R/Jm3i7V1K2xMEhGk3UoTEKOZhTVzFMODB3J735NYNTLPvdt6FzrsIAKz8+vu0WBescIWBU/iX2G2IbhaDgn1PFiJFQHknpYjTET7KKWaUYKz1W+C9kUEwkLAHaZbPJ1FbH21qez0hIYaLVRDTItPNhJWvUH0tab65mcDCQa6QlnavTE0OVpnsmwzDNhGJ7lohO4En51jgc8a2ZKc/jfZBAZK/iJK0FLCdxPMw7oZ+vqynx6/OMtRmtCVva/TPZC97Uz8noS8889oIJicN8anmH7aAaHnJHL3jW5ZTc05hFFSBGBybntWhP6hY0p9see9MY854c8IS7AshNYwg7FCA3Efl7uLONpT2UItcPzWSRsb2BpF3RY9KqobAzDe+RbvYlCKnUlb0FQYbJvBjfyhC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ba775e-e377-4339-89b1-08d75c618da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:15.6243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BIo1XAcol59MrTeKMhTzJN4fUY1IGG/eP6h1ZREJ8OHMi6c1z2Uj2n2W5exDcOeaZKaVNKIyLpRGxs2eqB/W1TJxgHnQ9ZUaUcq4LxyuZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Avoid duplicating code by moving the calls to spi_nor_write_enable() and
spi_nor_wait_till_ready() inside the Write Status Register methods.

Move spi_nor_write_sr() to avoid forward declaration of
spi_nor_wait_till_ready().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 108 +++++++++++++++++---------------------=
----
 1 file changed, 44 insertions(+), 64 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ed7c233a7208..5fb4d953b5c7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -534,35 +534,6 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr=
)
 	return ret;
 }
=20
-/*
- * Write status register 1 byte
- * Returns negative if error occurred.
- */
-static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
-{
-	int ret;
-
-	nor->bouncebuf[0] =3D val;
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
-
-		ret =3D spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     nor->bouncebuf, 1);
-	}
-
-	if (ret)
-		dev_err(nor->dev, "error %d writing SR\n", ret);
-
-	return ret;
-
-}
-
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -854,6 +825,41 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor=
)
 }
=20
 /*
+ * Write status register 1 byte
+ * Returns negative if error occurred.
+ */
+static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
+{
+	int ret;
+
+	nor->bouncebuf[0] =3D val;
+
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     nor->bouncebuf, 1);
+	}
+
+	if (ret) {
+		dev_err(nor->dev, "error %d writing SR\n", ret);
+		return ret;
+	}
+
+	return spi_nor_wait_till_ready(nor);
+}
+
+/*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
  * second byte will be written to the configuration register.
@@ -895,18 +901,10 @@ static int spi_nor_write_sr_and_check(struct spi_nor =
*nor, u8 status_new,
 {
 	int ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr(nor, status_new);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
 	if (ret)
 		return ret;
@@ -918,6 +916,10 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 *=
sr2)
 {
 	int ret;
=20
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
@@ -931,10 +933,12 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 =
*sr2)
 						     sr2, 1);
 	}
=20
-	if (ret)
+	if (ret) {
 		dev_err(nor->dev, "error %d writing SR2\n", ret);
+		return ret;
+	}
=20
-	return ret;
+	return spi_nor_wait_till_ready(nor);
 }
=20
 static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
@@ -1864,18 +1868,10 @@ static int macronix_quad_enable(struct spi_nor *nor=
)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
 	if (ret)
 		return ret;
@@ -2041,18 +2037,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	/* Update the Quad Enable bit. */
 	*sr2 |=3D SR2_QUAD_EN_BIT7;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
 	if (ret)
@@ -2084,15 +2072,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
-	if (ret)
-		return ret;
-
-	return spi_nor_wait_till_ready(nor);
+	return spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
 }
=20
 /**
--=20
2.9.5

