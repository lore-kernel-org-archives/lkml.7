Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C04C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3602067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hp48qxJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfGaJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:12:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:6668 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:12:28 -0400
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
IronPort-SDR: crO96TOYWty804IaMGZQ1WTvqKJHaSONZ4lRBjr1B0HDT+WYl+7t6eVpWHMu3NkiX/7RoOe3NO
 1jrqS+sXm3ObLwhyFwatQ+8dCxpaTA5BiM6yRn8kGE0Gui6OJga/X9uJDv8Bd09EvFnLWG5UuX
 UQgVQ9CN0ZP+vCreuGC6mgSl+2909jbYZLRQsUS2+9LQyjetwjlM76H23IDMqR49rP/6n6SR+2
 tISuETEoyeLOmPYU4KeQuJFiRJ2A0voeFPu5rDxKeZTHzSArF9MxensdV3lQaZM0r32LPsl0MO
 bUc=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="42631452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:12:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:12:16 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTgDxX0Z34EZ8yYwFhGG9JOccm/JBayu3jbXlz51ZqN5ToDxcjZdJf5vjXQuOaAVcqgYomueotb9xrW4qux5Gkrhrp1qXz6EWg4BY1RZuCuTO0ZPmOptAz85B2csc08YjoSu6VPIA81+hF89EY8rukhkmEInUVC401PjsiY9ogxIRPHy/dnL5f6zl+6NFgBaHzHkzXack356V5lPl3DRWIwhUIMI5YWj1DTO0QbFoxmgqnWgZfm3SW42xDVCfZKqvtyUkWAQGpPHf8Z6Tip6JMjvGd2YyTG8JlYUlmdgutx64FtiXEvvBBnRkncSWttnX1OW0yXDvKGIHmUi7W2Psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bouHgjKw80mlzfltZmlpLotkRe8uUeR6fmKk+PoymJI=;
 b=LjUJAGLy1i31HTXUWJ4Xigc11c2plDoVSPP9v0oYlSQ01nUOr9PFr90T7qEeW01vBRYQDQZcywY4HgYywih+ndZ0erAJV8g4KtCAyCnqq4yN+6Z9njy7WFsJlB5ZhUDY2H2n0f4dQ5htVXcQI5c3dMTvU85pu1ts7oEQ9HxjDa0YvjEEHyTGNO5ErVZu2JyfU03I8vg83Fc28pzgCCMfTEcWzlr6zkeU/HxUjzxKqz8TqjqDt9P30SM+rdKN57/vJb1F13jYZor9pwaDvwQ2iOFXj2DZI/FOSq5185M1rgfYa+vOI2Y4+glQCU0WDTxyNHAm+3aDkHHBPMy7J+wOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bouHgjKw80mlzfltZmlpLotkRe8uUeR6fmKk+PoymJI=;
 b=hp48qxJm4pk7KERN0+8g2Kuq8QGW9Qa8M+Xga/QFHuY5BJDiA04vtkrx802qbX9vh9wfkEy09L5BI+U+uD795ifiGidQ9Zqa3RsTn+TrYcBP60JP3ZyAILHW9jakuLSBNVa8PcCQHOHDN592IbGVjpjvvPk8IUpsUKw0cwQR0C8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 09:12:14 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:12:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 4/6] mtd: spi_nor: Add nor->setup() method
Thread-Topic: [PATCH 4/6] mtd: spi_nor: Add nor->setup() method
Thread-Index: AQHVR4ALK9UubUwcZ0C4sWQF3dBcIw==
Date:   Wed, 31 Jul 2019 09:12:14 +0000
Message-ID: <20190731091145.27374-5-tudor.ambarus@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731091145.27374-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0130.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8b128d6-a118-4946-a23f-08d715972d6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4414;
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB44143A76C7E3A224EE2C6801F0DF0@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(14454004)(26005)(81166006)(6116002)(50226002)(76176011)(5660300002)(66066001)(2501003)(6512007)(25786009)(486006)(102836004)(107886003)(2201001)(110136005)(305945005)(3846002)(7736002)(68736007)(53936002)(6486002)(478600001)(86362001)(71200400001)(71190400001)(14444005)(186003)(476003)(256004)(8936002)(6436002)(386003)(52116002)(54906003)(316002)(66946007)(81156014)(11346002)(2616005)(2906002)(64756008)(4326008)(446003)(99286004)(36756003)(66556008)(8676002)(66476007)(66446008)(1076003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dmz+WttIpFvAMnRDthf+EMz+Nxt2o4wMMD+p64aTMiuWZEG/ffykcLAlQOwOCieatK81RPwfoeAzcLssvehQWITO00qLLjE6mr8vcyZC3EJ6F9hv4odHo1GnZGdcNSTvRNpG+ODj0+mtZZPX3jckHep5uQbu/wXxjl0px1hCU4uoZnJJXNr0Ff+Ldt9zJEvELIrKnmdvqakQmnSy3RjQngn0OT8ClT/ohsNdUJqqGE7o2oVKxRXFVtWUD65IQ0qccXaX1WqFJRvGlkqsSmNBur/C7EPxE96Q3s8h8wz0x36Rv04O6WdEgF9kDaJ3mYBa6yGyzDAsCTwRZCl9Ed0K/8tQykQjXTdfauqqypkSkOZAnfJZSoJggFMueTgggk/ZD5gv2RrkHifsosWU7FgOv1Y31LKFWQichMq9YTDOBss=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b128d6-a118-4946-a23f-08d715972d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:12:14.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

To be used by some manufacturers to configure the spi-nor flash
memory. Right now the only user will be the S3AN chips, but other
manufacturers can implement it if needed.

Move spi_nor_flash_parameter and spi_nor_hwcaps related code
to avoid forward declarations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c |  63 ------------
 include/linux/mtd/spi-nor.h   | 217 +++++++++++++++++++++++++++-----------=
----
 2 files changed, 142 insertions(+), 138 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3b6810d76a79..0ff474e5e4f5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -40,69 +40,6 @@
 #define SPI_NOR_MAX_ID_LEN	6
 #define SPI_NOR_MAX_ADDR_WIDTH	4
=20
-struct spi_nor_read_command {
-	u8			num_mode_clocks;
-	u8			num_wait_states;
-	u8			opcode;
-	enum spi_nor_protocol	proto;
-};
-
-struct spi_nor_pp_command {
-	u8			opcode;
-	enum spi_nor_protocol	proto;
-};
-
-enum spi_nor_read_command_index {
-	SNOR_CMD_READ,
-	SNOR_CMD_READ_FAST,
-	SNOR_CMD_READ_1_1_1_DTR,
-
-	/* Dual SPI */
-	SNOR_CMD_READ_1_1_2,
-	SNOR_CMD_READ_1_2_2,
-	SNOR_CMD_READ_2_2_2,
-	SNOR_CMD_READ_1_2_2_DTR,
-
-	/* Quad SPI */
-	SNOR_CMD_READ_1_1_4,
-	SNOR_CMD_READ_1_4_4,
-	SNOR_CMD_READ_4_4_4,
-	SNOR_CMD_READ_1_4_4_DTR,
-
-	/* Octal SPI */
-	SNOR_CMD_READ_1_1_8,
-	SNOR_CMD_READ_1_8_8,
-	SNOR_CMD_READ_8_8_8,
-	SNOR_CMD_READ_1_8_8_DTR,
-
-	SNOR_CMD_READ_MAX
-};
-
-enum spi_nor_pp_command_index {
-	SNOR_CMD_PP,
-
-	/* Quad SPI */
-	SNOR_CMD_PP_1_1_4,
-	SNOR_CMD_PP_1_4_4,
-	SNOR_CMD_PP_4_4_4,
-
-	/* Octal SPI */
-	SNOR_CMD_PP_1_1_8,
-	SNOR_CMD_PP_1_8_8,
-	SNOR_CMD_PP_8_8_8,
-
-	SNOR_CMD_PP_MAX
-};
-
-struct spi_nor_flash_parameter {
-	u64				size;
-	u32				page_size;
-
-	struct spi_nor_hwcaps		hwcaps;
-	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
-	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
-};
-
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index af04d3117188..c47f25d9c10f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -197,6 +197,144 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_8_8_DTR =3D SNOR_PROTO_DTR(1, 8, 8),
 };
=20
+/**
+ * struct spi_nor_hwcaps - Structure for describing the hardware capabilie=
s
+ * supported by the SPI controller (bus master).
+ * @mask:		the bitmask listing all the supported hw capabilies
+ */
+struct spi_nor_hwcaps {
+	u32	mask;
+};
+
+/*
+ *(Fast) Read capabilities.
+ * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
+ * As a matter of performances, it is relevant to use Octal SPI protocols =
first,
+ * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
+ * (Slow) Read.
+ */
+#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ		BIT(0)
+#define SNOR_HWCAPS_READ_FAST		BIT(1)
+#define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
+
+#define SNOR_HWCAPS_READ_DUAL		GENMASK(6, 3)
+#define SNOR_HWCAPS_READ_1_1_2		BIT(3)
+#define SNOR_HWCAPS_READ_1_2_2		BIT(4)
+#define SNOR_HWCAPS_READ_2_2_2		BIT(5)
+#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(6)
+
+#define SNOR_HWCAPS_READ_QUAD		GENMASK(10, 7)
+#define SNOR_HWCAPS_READ_1_1_4		BIT(7)
+#define SNOR_HWCAPS_READ_1_4_4		BIT(8)
+#define SNOR_HWCAPS_READ_4_4_4		BIT(9)
+#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
+
+#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
+#define SNOR_HWCAPS_READ_1_1_8		BIT(11)
+#define SNOR_HWCAPS_READ_1_8_8		BIT(12)
+#define SNOR_HWCAPS_READ_8_8_8		BIT(13)
+#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
+
+/*
+ * Page Program capabilities.
+ * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
+ * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred t=
o the
+ * legacy SPI 1-1-1 protocol.
+ * Note that Dual Page Programs are not supported because there is no exis=
ting
+ * JEDEC/SFDP standard to define them. Also at this moment no SPI flash me=
mory
+ * implements such commands.
+ */
+#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
+#define SNOR_HWCAPS_PP		BIT(16)
+
+#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
+#define SNOR_HWCAPS_PP_1_1_4	BIT(17)
+#define SNOR_HWCAPS_PP_1_4_4	BIT(18)
+#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
+
+#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
+#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
+#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
+#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
+
+#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
+				 SNOR_HWCAPS_READ_4_4_4 |	\
+				 SNOR_HWCAPS_READ_8_8_8 |	\
+				 SNOR_HWCAPS_PP_4_4_4 |		\
+				 SNOR_HWCAPS_PP_8_8_8)
+
+#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
+				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
+				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
+				 SNOR_HWCAPS_READ_1_8_8_DTR)
+
+#define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
+				 SNOR_HWCAPS_PP_MASK)
+
+struct spi_nor_read_command {
+	u8			num_mode_clocks;
+	u8			num_wait_states;
+	u8			opcode;
+	enum spi_nor_protocol	proto;
+};
+
+struct spi_nor_pp_command {
+	u8			opcode;
+	enum spi_nor_protocol	proto;
+};
+
+enum spi_nor_read_command_index {
+	SNOR_CMD_READ,
+	SNOR_CMD_READ_FAST,
+	SNOR_CMD_READ_1_1_1_DTR,
+
+	/* Dual SPI */
+	SNOR_CMD_READ_1_1_2,
+	SNOR_CMD_READ_1_2_2,
+	SNOR_CMD_READ_2_2_2,
+	SNOR_CMD_READ_1_2_2_DTR,
+
+	/* Quad SPI */
+	SNOR_CMD_READ_1_1_4,
+	SNOR_CMD_READ_1_4_4,
+	SNOR_CMD_READ_4_4_4,
+	SNOR_CMD_READ_1_4_4_DTR,
+
+	/* Octal SPI */
+	SNOR_CMD_READ_1_1_8,
+	SNOR_CMD_READ_1_8_8,
+	SNOR_CMD_READ_8_8_8,
+	SNOR_CMD_READ_1_8_8_DTR,
+
+	SNOR_CMD_READ_MAX
+};
+
+enum spi_nor_pp_command_index {
+	SNOR_CMD_PP,
+
+	/* Quad SPI */
+	SNOR_CMD_PP_1_1_4,
+	SNOR_CMD_PP_1_4_4,
+	SNOR_CMD_PP_4_4_4,
+
+	/* Octal SPI */
+	SNOR_CMD_PP_1_1_8,
+	SNOR_CMD_PP_1_8_8,
+	SNOR_CMD_PP_8_8_8,
+
+	SNOR_CMD_PP_MAX
+};
+
+struct spi_nor_flash_parameter {
+	u64				size;
+	u32				page_size;
+
+	struct spi_nor_hwcaps		hwcaps;
+	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
+	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
+};
+
 static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
 {
 	return !!(proto & SNOR_PROTO_IS_DTR);
@@ -384,6 +522,7 @@ struct flash_info;
  *                      useful when pagesize is not a power-of-2
  * @disable_write_protection: [FLASH-SPECIFIC] disable write protection du=
ring
  *                            power-up
+ * @setup:		[FLASH-SPECIFIC] configure the spi-nor memory
  *			completely locked
  * @priv:		the private data
  */
@@ -427,6 +566,9 @@ struct spi_nor {
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
 	int (*disable_write_protection)(struct spi_nor *nor);
+	int (*setup)(struct spi_nor *nor,
+		     const struct spi_nor_flash_parameter *params,
+		     const struct spi_nor_hwcaps *hwcaps);
=20
 	const struct spi_nor_locking_ops *locking_ops;
=20
@@ -486,81 +628,6 @@ static inline struct device_node *spi_nor_get_flash_no=
de(struct spi_nor *nor)
 }
=20
 /**
- * struct spi_nor_hwcaps - Structure for describing the hardware capabilie=
s
- * supported by the SPI controller (bus master).
- * @mask:		the bitmask listing all the supported hw capabilies
- */
-struct spi_nor_hwcaps {
-	u32	mask;
-};
-
-/*
- *(Fast) Read capabilities.
- * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * As a matter of performances, it is relevant to use Octal SPI protocols =
first,
- * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
- * (Slow) Read.
- */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
-#define SNOR_HWCAPS_READ		BIT(0)
-#define SNOR_HWCAPS_READ_FAST		BIT(1)
-#define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
-
-#define SNOR_HWCAPS_READ_DUAL		GENMASK(6, 3)
-#define SNOR_HWCAPS_READ_1_1_2		BIT(3)
-#define SNOR_HWCAPS_READ_1_2_2		BIT(4)
-#define SNOR_HWCAPS_READ_2_2_2		BIT(5)
-#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(6)
-
-#define SNOR_HWCAPS_READ_QUAD		GENMASK(10, 7)
-#define SNOR_HWCAPS_READ_1_1_4		BIT(7)
-#define SNOR_HWCAPS_READ_1_4_4		BIT(8)
-#define SNOR_HWCAPS_READ_4_4_4		BIT(9)
-#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
-
-#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
-#define SNOR_HWCAPS_READ_1_1_8		BIT(11)
-#define SNOR_HWCAPS_READ_1_8_8		BIT(12)
-#define SNOR_HWCAPS_READ_8_8_8		BIT(13)
-#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
-
-/*
- * Page Program capabilities.
- * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred t=
o the
- * legacy SPI 1-1-1 protocol.
- * Note that Dual Page Programs are not supported because there is no exis=
ting
- * JEDEC/SFDP standard to define them. Also at this moment no SPI flash me=
mory
- * implements such commands.
- */
-#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
-#define SNOR_HWCAPS_PP		BIT(16)
-
-#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
-#define SNOR_HWCAPS_PP_1_1_4	BIT(17)
-#define SNOR_HWCAPS_PP_1_4_4	BIT(18)
-#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
-
-#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
-#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
-#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
-#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
-
-#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
-				 SNOR_HWCAPS_READ_4_4_4 |	\
-				 SNOR_HWCAPS_READ_8_8_8 |	\
-				 SNOR_HWCAPS_PP_4_4_4 |		\
-				 SNOR_HWCAPS_PP_8_8_8)
-
-#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
-				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
-				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
-
-#define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
-				 SNOR_HWCAPS_PP_MASK)
-
-/**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
  * @name:	the chip type name
--=20
2.9.5

