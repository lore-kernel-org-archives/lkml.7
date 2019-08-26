Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCEB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cd/2cwsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfHZL6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:58:48 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32105 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfHZL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:46 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: fsIDbCwB5BH+XCdjhVZLxbkZHeK1wDeGgX0IsAeiwjKc5pJvmnmNFrQzLXbr34fN0sOpxCkFXF
 mlEDG78elr0geklatJdY/lTq+1DA7IVTOKXvkT+tBSwbIaZx360uNZDQNVd6H3O6ERJLZPn5k2
 E33ds2t0uh4aY0vegGODemxfL07kTb27mSCejX2ytgkyiTLe21jZdJJ/Qfg9Y3b5ZSZWxNOnZQ
 i0Vl8n0dGeDU0EUwzxZq/tt1t+WVMLOPVLv8XHJFgQI2eGYGOd8q2ZnFzLvR4jiptqzFzBnzYQ
 9hM=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46518688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:44 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 04:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgnZOv3Kh0ewBe0yl3iOpeNMxN8OvcYsft/vtAL2+BjjuOZZmwFVNQKRZLjYZeGscFjiw7TiYZlZI4iegImYQIpT04jFgky1+j48oo1TIi0+n6h/KrjeNtX5QL+5wT4f9TI4pebiw81XKwm8ExGM7TSgFL/H04TA5Yzm1swDtfKJ/1hdYxbgEf42iRDQE/5cOOAZuaKfNUhhNBkeLClmZ3OWr0aOyxmtUMkCyDcTkCHLnaSKG63nDNqtKdMGn+y3+6MIXSaZhLfYVBSUcm4C03fqJNbTp4MV/2G5ZRmw18gjf477EYSWQdAJtXYk0bScgSqj8geCSw7dSjswOmCzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNJWgqpt+XlI34xYN7jthxW+soDIOhBBBwQX2gs00SI=;
 b=XsTMl3als95Ib8lJpp+AaxJH3LHnCQo1tJ5qmIEUlf7SWq4f8LNMk4VkBaOEx6UEX7KX0y7m12qTsryiEQToZoeubjpXoz9SXglkC0rPh2RHaOBAcJ5BTBi2GyuW1HYizF8vvZtLy8nPoAvcbl0fzUDtSuVobIzcTDYUD/kTkkvGymJTpAjc/c0GvSRg7TXu0KLeV1uuIhZVOc16xXKcmHg70/IOvURAPHWPUbqDjTmp4Ujpfa+5kSZLndpbzFZBKCfX1orj8U6qcYoFUwKdEnjO8RY2i7h6nCloKIP9WIgktciu7WWg6XjoZeYkyZ09Rp5hJz2s3OMRe/BSSHAs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNJWgqpt+XlI34xYN7jthxW+soDIOhBBBwQX2gs00SI=;
 b=cd/2cwsm6IT/kwStaepn+MZoZOfIgOkfXDyccoStviewtIBizOooYrdAISlkJU+wnxItRapIuSygtIwQAVe4PI51fBaaPeZhztLkMGai505DN9wY6pFhLv6wrdM11FKEm5cBIJURoBUdrr1Pp/CmF8/7MTOpAMfZziWZCLekfOU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:44 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 01/20] mtd: spi-nor: Regroup flash parameter and settings
Thread-Topic: [PATCH v3 01/20] mtd: spi-nor: Regroup flash parameter and
 settings
Thread-Index: AQHVXAWbUGQxfu4TdEmy8P7pangj8Q==
Date:   Mon, 26 Aug 2019 11:58:43 +0000
Message-ID: <20190826115833.14913-2-tudor.ambarus@microchip.com>
References: <20190826115833.14913-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826115833.14913-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43672f22-4e4a-42d9-933a-08d72a1cbe3a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4350DB6DDB12608B458F0F77F0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(14444005)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(30864003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(76176011)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(446003)(11346002)(14454004)(2906002)(110136005)(2201001)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xU1xk8jLA5mBu57h9hEEObwsLa3GrmPNIbjO3me6D2z6xyzyA3dnh+gAisyP6YnatPjCrfJf4MACXNYASwLLSh/vHJM0ogXenJwn8TCOruXKjUWwDevEQxlG4crAheUBV/PruVO56pJ8O0SCoAQC/5jUTfp6quG63d6txGMB/Ehe9Az8XWq+PTsypM3sl2We0mzf4VrA7Ykl0eBWzGEQyCv146yIx6ysoeyq8qoREGz6S3FE/35kLzaLuAy4B+0lrlcZKBk1tk5GSrGIvlhxmMNLf9ym/FcYdpizGM0KL9eXMGr78ODqpriwQipPk9G3RiezfjH3V0vBKHHemFYgkQPCtAO2YO841gZMd/zLaNIW9J7iW8DVyR5KoZ/6UdjBtmkM/pAJ2IcsLVmIyUec6ygDWNRVDJZa+JZRAdSAGqA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43672f22-4e4a-42d9-933a-08d72a1cbe3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:43.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWbxy7n9b10MhuMz0j8bknHSUssZgvJRbGHXZODYZMpxK9twsEz+0k15hidxeqHksD11WLKaKm1FpENvVCwABY5uV+8Y6XZG5uIEbuP/I08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The scope is to move all [FLASH-SPECIFIC] parameters and settings
from 'struct spi_nor' to 'struct spi_nor_flash_parameter'.

'struct spi_nor_flash_parameter' describes the hardware capabilities
and associated settings of the SPI NOR flash memory. It includes
legacy flash parameters and settings that can be overwritten by the
spi_nor_fixups hooks, or dynamically when parsing the JESD216
Serial Flash Discoverable Parameters (SFDP) tables. All SFDP params
and settings will fit inside 'struct spi_nor_flash_parameter'.

Move spi_nor_hwcaps related code to avoid forward declarations.
Add a forward declaration that we can't avoid: 'struct spi_nor' will
be used in 'struct spi_nor_flash_parameter'.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: collect R-b

 drivers/mtd/spi-nor/spi-nor.c |  65 ------------
 include/linux/mtd/spi-nor.h   | 239 +++++++++++++++++++++++++++++---------=
----
 2 files changed, 164 insertions(+), 140 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0597cb8257b0..d35dc6a97521 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -40,71 +40,6 @@
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
-
-	int (*quad_enable)(struct spi_nor *nor);
-};
-
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 3075ac73b171..77ba692d9348 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -334,6 +334,165 @@ struct spi_nor_erase_map {
 };
=20
 /**
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
+/* Forward declaration that will be used in 'struct spi_nor_flash_paramete=
r' */
+struct spi_nor;
+
+/**
+ * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
+ * Includes legacy flash parameters and settings that can be overwritten
+ * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
+ * Serial Flash Discoverable Parameters (SFDP) tables.
+ *
+ * @size:		the flash memory density in bytes.
+ * @page_size:		the page size of the SPI NOR flash memory.
+ * @hwcaps:		describes the read and page program hardware
+ *			capabilities.
+ * @reads:		read capabilities ordered by priority: the higher index
+ *                      in the array, the higher priority.
+ * @page_programs:	page program capabilities ordered by priority: the
+ *                      higher index in the array, the higher priority.
+ * @quad_enable:	enables SPI NOR quad mode.
+ */
+struct spi_nor_flash_parameter {
+	u64				size;
+	u32				page_size;
+
+	struct spi_nor_hwcaps		hwcaps;
+	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
+	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
+
+	int (*quad_enable)(struct spi_nor *nor);
+};
+
+/**
  * struct flash_info - Forward declaration of a structure used internally =
by
  *		       spi_nor_scan()
  */
@@ -379,6 +538,10 @@ struct flash_info;
  * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
+ * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
+ *                      The structure includes legacy flash parameters and
+ *                      settings that can be overwritten by the spi_nor_fi=
xups
+ *                      hooks, or dynamically when parsing the SFDP tables=
.
  * @priv:		the private data
  */
 struct spi_nor {
@@ -418,6 +581,7 @@ struct spi_nor {
 	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*clear_sr_bp)(struct spi_nor *nor);
+	struct spi_nor_flash_parameter params;
=20
 	void *priv;
 };
@@ -463,81 +627,6 @@ static inline struct device_node *spi_nor_get_flash_no=
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

