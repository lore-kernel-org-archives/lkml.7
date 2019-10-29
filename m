Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5243DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0856F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YsE9xVbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfJ2LQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:16:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36056 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2LQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:16:56 -0400
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
IronPort-SDR: piga0Mge8f0luwl/cM6q1V3OhI9rDQqHoisUNqowpmUFo9GNVtGysYulgS2xEuvxN2/021YuW7
 2qtKYhZUriFUOdMeglDybRp7oh0GsEot3EQtkvEV/A5o3QYunFKI0X+3WPAY7nnTE2N4MHDTzY
 VGDNJUNQSPMCLfZCXm8RtwIm2OvdRF820Mq/3gnaIWGoVWuzmQiEPnjaTBhZpkKru93FpXKNiv
 zbhoXl6ny860t6y0pI+Zw7oaS1xpANqdsTyW2OPtLS/KpUVc9txzs+uecC3g4+S6f6RWdQu61a
 iu4=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53291990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:16:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:16:55 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:16:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVkQWEoBbpUFxWgxRKvspX0aqiOZ7/UUKgWKUdQ5oeY9vZ/+fzv6fN/uDJiThwNxkZ6dIGFCLNxCrYNSbN7HySvzU/gi+FSAYIFzLdrcH+NsD2OxUEwlI5tiCPerxkOez6vuTqXhWBuQ3+5cvrIxsvjgO85P4lgioad+r3GgJ6ssLmn1QzMJMQmVB0i1KSRemDcy+oqrsNSG63PBXCGUwMWEZzcZQJEuPcxbalPycceQXPsNufkwYD69usjTGxWIUVn6yh+NUWFd2TgkhLnx/yIv5PNAizcEfM8hwe3o4jlR37wJovGmxI2akFWqtQewSwAgOdD0tZ/7xZDDxxuxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQYeEPuYNvng5VoVoZbOLjxNBObKCqW15Iqvkkk7z+I=;
 b=nEWXawMTiimVN9oVPlL2dJM/eaZaths5/ltp54qcgKxPFrhiK9XiCDqBED7tCLa6tEuIa8bki8j+7c+UKAeOQNTZlyPuEGqdDRmWLFbuLuT7PQjBTqew9WWrtzRboWHyC1mfHQl2LeyoKs19I/dnAYqSEzWTH1rRU3UiZnOhYH+fQYNONU2cfAwajQkILmFvdFbxSjI3GfR6qpyQL3skAjs3SUTzRwQ7mRK3LSVTbt+7xBVGDFLfPuwM/sFXWR78VH9uiJaKl9oGs96usuz9UxmgwdaNwlmM9fSs/1tQvk+Oc8aaeSYiwOVY2xxWVAgl/GDxBD/EEQrMPAxgNbkg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQYeEPuYNvng5VoVoZbOLjxNBObKCqW15Iqvkkk7z+I=;
 b=YsE9xVbRUVyiNMCtBaA36quHZeLsNAGh3KPAexhgt7mjgEP58dPgToqVgYo/T9P8gFz8JbREjpO4eB+frJdXqqj25M6SOo0Tbl51L8TwYQJew5i83ZbAFr7UYWGb+UewkWNvpt6BpAsnYz9BA0kAyJj2qUiUOSORKlYvjY7P28M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:52 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 03/32] mtd: spi-nor: Group all Reg Ops to avoid forward
 declarations
Thread-Topic: [PATCH v3 03/32] mtd: spi-nor: Group all Reg Ops to avoid
 forward declarations
Thread-Index: AQHVjkpdkNtd6IPjcUKd2iRAW4iR8Q==
Date:   Tue, 29 Oct 2019 11:16:52 +0000
Message-ID: <20191029111615.3706-4-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 4bfa7023-045f-4d2f-c966-08d75c617fff
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823006F07219C692B60AC4CF0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(30864003)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(14444005)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hdq2fjj5620N7mGHdgjgBhZfyeUG0FJXevFdiGMwH6LPwHxeeMMcRSiSvaGG5oa1TB/he+hlJfDahLbOqLDl9DPqeOMmrG6GdbVCIBPCtvc+cZoPYkyRqFXCD8GFLXDDPxOB9VFRQl38+k2JLmf5SGsisfl89yreVU1F2ESLXbVq7SGQhIZ4Ipchek9wgfzX/N/MDnjpg3BtciLHMp29hxpQHsKs7t3wIQwlFwuHFN3Mrq37LN9yJ2xRKWlpErW8pmnPmmp74GMlzn6md03djn4tbC3/uwcT6prKq78KfY2HaO1infjWt17Pk4MAflMbe0raZOECL9MhK0j4Q/T+Pf9aB4vl4IdiHkeI9qPUhPYWYsCFpRcddL8llkCiQYIjkOtZOFSBNAZrWw59NfATIfHZRy07SiqBT3tKFC2izOqUsbLDYi1iHsmi3laZftFT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfa7023-045f-4d2f-c966-08d75c617fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:52.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPVRTEwAZP8dXwbsEM/AP6je2DGVJcEbxEm3NV9OGSjbNmCwalBoGvnBwqC95SDSHtmCw2b6ia6m/HjpQ41njPSxnFL30wBnkuLZ+JhK8/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Group all register methods up in the file, to avoid forward
declarations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 426 +++++++++++++++++++++-----------------=
----
 1 file changed, 213 insertions(+), 213 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e82df577eed..24378d65fa2e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -389,6 +389,43 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor,=
 loff_t to, size_t len,
 }
=20
 /*
+ * Set write enable latch with Write Enable command.
+ * Returns negative if error occurred.
+ */
+static int spi_nor_write_enable(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+}
+
+/*
+ * Send write disable instruction to the chip.
+ */
+static int spi_nor_write_disable(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
+}
+
+/*
  * Read the status register, returning its value in the location
  * Return the status register value.
  * Returns negative if error occurred.
@@ -499,126 +536,6 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 v=
al)
 					      nor->bouncebuf, 1);
 }
=20
-/*
- * Set write enable latch with Write Enable command.
- * Returns negative if error occurred.
- */
-static int spi_nor_write_enable(struct spi_nor *nor)
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
-static int spi_nor_write_disable(struct spi_nor *nor)
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
-static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
-{
-	return mtd->priv;
-}
-
-static u8 spi_nor_convert_opcode(u8 opcode, const u8 table[][2], size_t si=
ze)
-{
-	size_t i;
-
-	for (i =3D 0; i < size; i++)
-		if (table[i][0] =3D=3D opcode)
-			return table[i][1];
-
-	/* No conversion found, keep input op code. */
-	return opcode;
-}
-
-static u8 spi_nor_convert_3to4_read(u8 opcode)
-{
-	static const u8 spi_nor_3to4_read[][2] =3D {
-		{ SPINOR_OP_READ,	SPINOR_OP_READ_4B },
-		{ SPINOR_OP_READ_FAST,	SPINOR_OP_READ_FAST_4B },
-		{ SPINOR_OP_READ_1_1_2,	SPINOR_OP_READ_1_1_2_4B },
-		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
-		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
-		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
-		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
-		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
-
-		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
-		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
-		{ SPINOR_OP_READ_1_4_4_DTR,	SPINOR_OP_READ_1_4_4_DTR_4B },
-	};
-
-	return spi_nor_convert_opcode(opcode, spi_nor_3to4_read,
-				      ARRAY_SIZE(spi_nor_3to4_read));
-}
-
-static u8 spi_nor_convert_3to4_program(u8 opcode)
-{
-	static const u8 spi_nor_3to4_program[][2] =3D {
-		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
-		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
-		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
-		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
-		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
-	};
-
-	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
-				      ARRAY_SIZE(spi_nor_3to4_program));
-}
-
-static u8 spi_nor_convert_3to4_erase(u8 opcode)
-{
-	static const u8 spi_nor_3to4_erase[][2] =3D {
-		{ SPINOR_OP_BE_4K,	SPINOR_OP_BE_4K_4B },
-		{ SPINOR_OP_BE_32K,	SPINOR_OP_BE_32K_4B },
-		{ SPINOR_OP_SE,		SPINOR_OP_SE_4B },
-	};
-
-	return spi_nor_convert_opcode(opcode, spi_nor_3to4_erase,
-				      ARRAY_SIZE(spi_nor_3to4_erase));
-}
-
-static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
-{
-	nor->read_opcode =3D spi_nor_convert_3to4_read(nor->read_opcode);
-	nor->program_opcode =3D spi_nor_convert_3to4_program(nor->program_opcode)=
;
-	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
-
-	if (!spi_nor_has_uniform_erase(nor)) {
-		struct spi_nor_erase_map *map =3D &nor->params.erase_map;
-		struct spi_nor_erase_type *erase;
-		int i;
-
-		for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++) {
-			erase =3D &map->erase_type[i];
-			erase->opcode =3D
-				spi_nor_convert_3to4_erase(erase->opcode);
-		}
-	}
-}
-
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
 	if (nor->spimem) {
@@ -859,6 +776,99 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor=
)
 }
=20
 /*
+ * Write status Register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the
+ * second byte will be written to the configuration register.
+ * Return negative if error occurred.
+ */
+static int spi_nor_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
+{
+	int ret;
+
+	spi_nor_write_enable(nor);
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     sr_cr, 2);
+	}
+
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while writing configuration register\n");
+		return -EINVAL;
+	}
+
+	ret =3D spi_nor_wait_till_ready(nor);
+	if (ret) {
+		dev_err(nor->dev,
+			"timeout while writing configuration register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Write status register and ensure bits in mask match written values */
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
+				      u8 mask)
+{
+	int ret;
+
+	spi_nor_write_enable(nor);
+	ret =3D spi_nor_write_sr(nor, status_new);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_read_sr(nor);
+	if (ret < 0)
+		return ret;
+
+	return ((ret & mask) !=3D (status_new & mask)) ? -EIO : 0;
+}
+
+static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
+}
+
+static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
+}
+
+/*
  * Erase the whole flash memory
  *
  * Returns 0 if successful, non-zero otherwise.
@@ -881,6 +891,89 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 					      NULL, 0);
 }
=20
+static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
+{
+	return mtd->priv;
+}
+
+static u8 spi_nor_convert_opcode(u8 opcode, const u8 table[][2], size_t si=
ze)
+{
+	size_t i;
+
+	for (i =3D 0; i < size; i++)
+		if (table[i][0] =3D=3D opcode)
+			return table[i][1];
+
+	/* No conversion found, keep input op code. */
+	return opcode;
+}
+
+static u8 spi_nor_convert_3to4_read(u8 opcode)
+{
+	static const u8 spi_nor_3to4_read[][2] =3D {
+		{ SPINOR_OP_READ,	SPINOR_OP_READ_4B },
+		{ SPINOR_OP_READ_FAST,	SPINOR_OP_READ_FAST_4B },
+		{ SPINOR_OP_READ_1_1_2,	SPINOR_OP_READ_1_1_2_4B },
+		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
+		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
+		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
+		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
+		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
+
+		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
+		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
+		{ SPINOR_OP_READ_1_4_4_DTR,	SPINOR_OP_READ_1_4_4_DTR_4B },
+	};
+
+	return spi_nor_convert_opcode(opcode, spi_nor_3to4_read,
+				      ARRAY_SIZE(spi_nor_3to4_read));
+}
+
+static u8 spi_nor_convert_3to4_program(u8 opcode)
+{
+	static const u8 spi_nor_3to4_program[][2] =3D {
+		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
+		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
+		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
+		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
+		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
+	};
+
+	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
+				      ARRAY_SIZE(spi_nor_3to4_program));
+}
+
+static u8 spi_nor_convert_3to4_erase(u8 opcode)
+{
+	static const u8 spi_nor_3to4_erase[][2] =3D {
+		{ SPINOR_OP_BE_4K,	SPINOR_OP_BE_4K_4B },
+		{ SPINOR_OP_BE_32K,	SPINOR_OP_BE_32K_4B },
+		{ SPINOR_OP_SE,		SPINOR_OP_SE_4B },
+	};
+
+	return spi_nor_convert_opcode(opcode, spi_nor_3to4_erase,
+				      ARRAY_SIZE(spi_nor_3to4_erase));
+}
+
+static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
+{
+	nor->read_opcode =3D spi_nor_convert_3to4_read(nor->read_opcode);
+	nor->program_opcode =3D spi_nor_convert_3to4_program(nor->program_opcode)=
;
+	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
+
+	if (!spi_nor_has_uniform_erase(nor)) {
+		struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+		struct spi_nor_erase_type *erase;
+		int i;
+
+		for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+			erase =3D &map->erase_type[i];
+			erase->opcode =3D
+				spi_nor_convert_3to4_erase(erase->opcode);
+		}
+	}
+}
+
 static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops=
)
 {
 	int ret =3D 0;
@@ -1326,28 +1419,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struc=
t erase_info *instr)
 	return ret;
 }
=20
-/* Write status register and ensure bits in mask match written values */
-static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
-				      u8 mask)
-{
-	int ret;
-
-	spi_nor_write_enable(nor);
-	ret =3D spi_nor_write_sr(nor, status_new);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_read_sr(nor);
-	if (ret < 0)
-		return ret;
-
-	return ((ret & mask) !=3D (status_new & mask)) ? -EIO : 0;
-}
-
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 				 uint64_t *len)
 {
@@ -1664,47 +1735,6 @@ static int spi_nor_is_locked(struct mtd_info *mtd, l=
off_t ofs, uint64_t len)
 	return ret;
 }
=20
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int spi_nor_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
-{
-	int ret;
-
-	spi_nor_write_enable(nor);
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
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev,
-			"timeout while writing configuration register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1870,36 +1900,6 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 	return 0;
 }
=20
-static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
-}
-
-static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
-}
-
 /**
  * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
--=20
2.9.5

