Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99522C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5412168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fkoTieaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409373AbfIXHqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:30 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29453 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409336AbfIXHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:22 -0400
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
IronPort-SDR: ij/cBcC3nrhFXU6QH0SKP/u1cWiCPsYiI1/1BuB9KdJ6B6swPG673JS1MG9Wd5aY08t76XW4fA
 ZimR81Orbe1V1TPa409mKhYU792xApkRBUxlkAczXfE6CHtZN65QaLjROhU8Shms9pHD+u4QD0
 87MzngOeHLWrITPc/8MzQfgqwXyBvs5kVaabUSeofODhzr3DamOnev1ONpvqvg2riEHBjiMNcB
 aOi1jQNG+jMzaJmyd3Lr8FZq+SxBgEKjRcVhw2KF9m4XJlId26cLRUZvLv22jx5gl56qrwqudb
 qJU=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="47374710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 00:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz6wug6vAgzbN4QKrDJ77NqC2hf5yZkeJFS+pAfvmmw54a0DMDONVhjwq61svcNfYsfOroNtsXzOFJxMIe6IDo6Rz07nyIoJ/JVUk7wtrQL1Di2KZg3tT07gyO47Hs4n2wJLzVN5WBnD5F/EelzwwLCTj4c2GfvEsOc9MA3tSqZU3/4YrlZAJxFZ3GjoD2s6BA1I5hnx/eJ/UPv9eoJgkLSGGzdeFJucKIp7kzWWy0L0I7SwnLDzTOpTnxLNjw4Jw/ztbuLSIgtzwScGath+vNuMciDY7IHStrnD5eY7D7NRucgaaKVSg/okk7zFM8mpJ7RQEC44dV66f5tXXRzgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgNYDQ07Bp3JUOwbUfM+5F44GdodnP8PvxrloxpbJAs=;
 b=ckm5zwW+U/W8n8wDOE5xliP7qTlyaoXo73drHs9yk/21phiBK3/d/WidBlzbN2svrDoKkDwTj1I3T+tEoIwTZwbk3mDFWy0iTfEKEf+M1kkWhKT/Nzl4TefBO6VAoPhsuqKYbtEPgjxxaN4HXT6oxAXvlLqId4ubNvCfi294nkDg85ohzM8Y7t173TlF4xTaAk9BxdYt6JafIUaREmi5oW9G9xpfPXxn0V3lHXT0Bf4P3jPjdD/7vTtnm4+PO9Hk+HFdgup0etwYZ5Q37Lk3v4jivPlWaLtI2QbZrNJWcD4bzpJxO6nyXOgJ9V1AZ1J0dbge0R7zVUi7hqlTczN81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgNYDQ07Bp3JUOwbUfM+5F44GdodnP8PvxrloxpbJAs=;
 b=fkoTieaZrHIbRh/8b0KuHwamk/oTLNRM7bC2fNBtHfMWSrCdTfU5/Kph6E0Gv9/iegRSnjh2NMUSZXmy/c8fZS5ncCMheJxzahLs5gTWnPkh6QX2bcpIzi1MUmHce5poG67Jzrbp3TB7RH2gv8K2d8mjTHhyn1M8Egqehke8k7Q=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:18 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:18 +0000
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
Subject: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Topic: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Index: AQHVcqwmGxayarzEFkyHj/sWgnNJNg==
Date:   Tue, 24 Sep 2019 07:46:18 +0000
Message-ID: <20190924074533.6618-9-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: fe1bc4f1-191c-446b-829b-08d740c348fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43198688E2EDA3062F9557AFF0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6UQc0O3Ob48ImuQo8PqZxeQwUUYW5W+esSRLlro9VxaBMyneHJwyqK+A58lRAX3Z0XNH0sRsfJ73ooXUJT1Bih/JYWjHdwHiTV/Lzp3KxlY5vZrJKYqPcEdJuN0eRe8zfLk2MDLkl4b0tZ2qIrWLMLBR+IXbEw5YkqFyZRuvfZQA5O6/wZPMFkaW4oeMQ8pI+vVDuAhnzJFyO0OoePrNakRqDyjrFwlYEdVZMhcZW9X7j0T5d2Wb+bFFymKYrT+1Vpt/tqz6rQqUDB35HfesYRhRf2bHetpbpO1JeteSJ0lqkgnr7tjswTPAeRjZrbd20GlF8/KpAdjOgiM1xTHQ7vlYBd7oSWK5ivD2/bjFofVX22L0L4GQ5cp2uNccmdULFx8HzYzy8PSazhFEKaEtgsNsiNrPHzBO5Dtp32aYy4A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1bc4f1-191c-446b-829b-08d740c348fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:18.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APKNyq7MaovMYI0/TLIEdYplpoYKXV0h6cATBXJFgZeyf/SEbTpayYEKnpyjH+hr2XT+UvRPNJQDU5oc0S5ybzP8dc3WqKn0c19RI+6je9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

static int write_enable(struct spi_nor *nor)
static int write_disable(struct spi_nor *nor)
become
static int spi_nor_write_enable(struct spi_nor *nor)
static int spi_nor_write_disable(struct spi_nor *nor)

Check for errors after each call to them. Move them up in the
file as the first SPI NOR Register Operations, to avoid further
forward declarations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 175 +++++++++++++++++++++++++++++---------=
----
 1 file changed, 120 insertions(+), 55 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0fb124bd2e77..0aee068a5835 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -389,6 +389,64 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor,=
 loff_t to, size_t len,
 }
=20
 /**
+ * spi_nor_write_enable() - Set write enable latch with Write Enable comma=
nd.
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_enable(struct spi_nor *nor)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
+						     NULL, 0);
+	}
+
+	if (ret)
+		dev_err(nor->dev, "error %d on Write Enable\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_disable() - Send Write Disable instruction to the chip.
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_disable(struct spi_nor *nor)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
+						     NULL, 0);
+	}
+
+	if (ret)
+		dev_err(nor->dev, "error %d on Write Disable\n", ret);
+
+	return ret;
+}
+
+/**
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:        pointer to 'struct spi_nor'
  * @sr:		buffer where the value of the Status Register will be written.
@@ -500,43 +558,6 @@ static int write_sr(struct spi_nor *nor, u8 val)
 					      nor->bouncebuf, 1);
 }
=20
-/*
- * Set write enable latch with Write Enable command.
- * Returns negative if error occurred.
- */
-static int write_enable(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
-}
-
-/*
- * Send write disable instruction to the chip.
- */
-static int write_disable(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
-}
-
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -645,9 +666,15 @@ static int st_micron_set_4byte(struct spi_nor *nor, bo=
ol enable)
 {
 	int ret;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	ret =3D macronix_set_4byte(nor, enable);
-	write_disable(nor);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_write_disable(nor);
=20
 	return ret;
 }
@@ -701,9 +728,15 @@ static int winbond_set_4byte(struct spi_nor *nor, bool=
 enable)
 	 * Register to be set to 1, so all 3-byte-address reads come from the
 	 * second 16M. We must clear the register to enable normal behavior.
 	 */
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	ret =3D spi_nor_write_ear(nor, 0);
-	write_disable(nor);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_write_disable(nor);
=20
 	return ret;
 }
@@ -1219,7 +1252,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor=
 *nor, u64 addr, u32 len)
 	list_for_each_entry_safe(cmd, next, &erase_list, list) {
 		nor->erase_opcode =3D cmd->opcode;
 		while (cmd->count) {
-			write_enable(nor);
+			ret =3D spi_nor_write_enable(nor);
+			if (ret)
+				goto destroy_erase_cmd_list;
=20
 			ret =3D spi_nor_erase_sector(nor, addr);
 			if (ret)
@@ -1274,7 +1309,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 	if (len =3D=3D mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 		unsigned long timeout;
=20
-		write_enable(nor);
+		ret =3D spi_nor_write_enable(nor);
+		if (ret)
+			goto erase_err;
=20
 		if (erase_chip(nor)) {
 			ret =3D -EIO;
@@ -1302,7 +1339,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 	/* "sector"-at-a-time erase */
 	} else if (spi_nor_has_uniform_erase(nor)) {
 		while (len) {
-			write_enable(nor);
+			ret =3D spi_nor_write_enable(nor);
+			if (ret)
+				goto erase_err;
=20
 			ret =3D spi_nor_erase_sector(nor, addr);
 			if (ret)
@@ -1323,7 +1362,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 			goto erase_err;
 	}
=20
-	write_disable(nor);
+	ret =3D spi_nor_write_disable(nor);
=20
 erase_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
@@ -1336,7 +1375,10 @@ static int write_sr_and_check(struct spi_nor *nor, u=
8 status_new, u8 mask)
 {
 	int ret;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	ret =3D write_sr(nor, status_new);
 	if (ret)
 		return ret;
@@ -1681,7 +1723,9 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr=
)
 {
 	int ret;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
=20
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -1733,7 +1777,9 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
=20
 	write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
=20
@@ -1936,7 +1982,9 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	/* Update the Quad Enable bit. */
 	*sr2 |=3D SR2_QUAD_EN_BIT7;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
=20
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret < 0) {
@@ -1978,7 +2026,9 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
=20
 	ret =3D write_sr(nor, nor->bouncebuf[0] & ~mask);
 	if (ret) {
@@ -2601,7 +2651,9 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 	if (ret)
 		return ret;
=20
-	write_enable(nor);
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		goto unlock_and_unprep;
=20
 	nor->sst_write_second =3D false;
=20
@@ -2640,14 +2692,19 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 	}
 	nor->sst_write_second =3D false;
=20
-	write_disable(nor);
+	ret =3D spi_nor_write_disable(nor);
+	if (ret)
+		goto sst_write_err;
+
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
 		goto sst_write_err;
=20
 	/* Write out trailing byte if it exists. */
 	if (actual !=3D len) {
-		write_enable(nor);
+		ret =3D spi_nor_write_enable(nor);
+		if (ret)
+			goto sst_write_err;
=20
 		nor->program_opcode =3D SPINOR_OP_BP;
 		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
@@ -2658,11 +2715,16 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
-		write_disable(nor);
+
+		ret =3D spi_nor_write_disable(nor);
+		if (ret)
+			goto sst_write_err;
+
 		actual +=3D 1;
 	}
 sst_write_err:
 	*retlen +=3D actual;
+unlock_and_unprep:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
 }
@@ -2710,7 +2772,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_=
t to, size_t len,
=20
 		addr =3D spi_nor_convert_addr(nor, addr);
=20
-		write_enable(nor);
+		ret =3D spi_nor_write_enable(nor);
+		if (ret)
+			goto write_err;
+
 		ret =3D spi_nor_write_data(nor, addr, page_remain, buf + i);
 		if (ret < 0)
 			goto write_err;
--=20
2.9.5

