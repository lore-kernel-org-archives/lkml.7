Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C3DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0625F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0jbeVs4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGaJDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:03:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3350 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:03:41 -0400
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
IronPort-SDR: NziBjMqNgZx4/WOPaty0WJhSAw6LYYpWeVXWg1BPOlze7JW0qx2qAkcukV7z1jE3WuILkzTija
 cB7rx1P0o9x+OV1MlWJF9BhifNnTArwAwi3F6gx2FXSZJJK9wqagvV1vdY7h80f/yj+G3aii9D
 sIVr8oQUHs+IDMr9aHaCsjs1yWfyRc9CWi/XHr8nOJeQyiPTIxrq2YBxATHA/zHpS8qi/juGv8
 8hveksnluuko76UFWR1FHiUmbl0g9jkdjk7yOJRWd5cvMS19DjLaVmeAK6dOK44XrOAhm0k1Cj
 +js=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="43382571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:03:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:03:38 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h67NmcZ+MzS9b/ACiDorUbrX7yKSzILRxvhlLKdIff06kSpDRc/IxK81duSZBSHHk2wv2490tdBUYlaRWslfgwf9v+kXPgb8TmQo4PN5F7vGF6+pwbCm7LF4iNxYacyzIS6HFP0pf2LH3dOjSTqGg+MtxeQt+OtdbPo+cyJY+mDVoylhFIHkerBqqfVOKtKQCTEXg/jnlUPHJmnAmw7Sbx3AhweMV4a5iUV56cOcS0L8awuLybtViXbakJ+JvUZ7yqfTxG+HOu9mZPT1aAQUw/2LPXqbWutjRATLFyB/UAtADp+hTz+Gszd17QWkAROaVIBNGabMHSLOuY55IuFhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5cCPolmXgvGFmkQ0AA2m2XDnjaSw4DzepMc/tVjg+o=;
 b=YnxE0BijgpGnWfQM4ADUdGeqyrG9joAmy4ofMy3HWQvbY2aaIz3avJH+ldUWdfU5EzJ20p2sAR7q5pVpaG1Hhm63AL0Uy8LhXrMowkWGRc/s90uyZYaKW7QCPUEh+8NOlC1mWVvIdw8MshOIjTh2QQmqgU1xj2t1qB2hPpxCzfggG7YEtIBfrHfoIVvSVvVvoiUXy4Hup0F+YmMgN8tVtiN1sEfWXO2/K1PC16ivPs+0NEuln/1BqNhbsD2PdI4TdaUskL0OcXUoQ0C5L4INcC98F2TCjfAb1P3C8CxVA5pwVWYH8EmbNyzlsVP0kVr8aK0llSrKiQKf8sWfFvRhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5cCPolmXgvGFmkQ0AA2m2XDnjaSw4DzepMc/tVjg+o=;
 b=0jbeVs4wqFXlwoz9OjgUZWgI90Sp/2+++05d6BScbuajrAOBDgLHeytl9WkKHob0G350o+uhIa50Hu6LWMDcLbOUa8YMw1E/iRpqUq7M71OpTXqMP8q5EAlOcJtGRbnvhHIpWqfZrFwoTd15Iw6ET0p5WCzXVXJIAgvHQmijOeE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2SPR01MB0050.namprd11.prod.outlook.com (10.255.239.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 09:03:35 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:03:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 5/7] mtd: spi-nor: Create a ->set_4byte() method
Thread-Topic: [PATCH 5/7] mtd: spi-nor: Create a ->set_4byte() method
Thread-Index: AQHVR37V+qfQ27uWy0qv2gn21v57wg==
Date:   Wed, 31 Jul 2019 09:03:35 +0000
Message-ID: <20190731090315.26798-6-tudor.ambarus@microchip.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731090315.26798-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb4b4fb4-7490-4de8-301b-08d71595f823
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2SPR01MB0050;
x-ms-traffictypediagnostic: MN2SPR01MB0050:
x-microsoft-antispam-prvs: <MN2SPR01MB005010571BAE71E19279C024F0DF0@MN2SPR01MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(50226002)(53936002)(36756003)(54906003)(7416002)(305945005)(8676002)(81166006)(107886003)(2906002)(81156014)(6436002)(316002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(6486002)(68736007)(8936002)(6512007)(86362001)(5660300002)(25786009)(1076003)(110136005)(7736002)(186003)(4326008)(11346002)(446003)(102836004)(386003)(6506007)(256004)(2616005)(476003)(52116002)(99286004)(76176011)(478600001)(2501003)(66066001)(14454004)(14444005)(486006)(71190400001)(71200400001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0050;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9PBj7OA0/JIfmBDUPeOrZyR0j1k1Nup/gm+bsswNmI+kM18H48HxsML+UzmHPXtORjaczA7ZZRWiyYxfu03/y+8hXXJAxelOMIF1fYF8A08PV8idPT0V5RJE26RwIYgpd3gYOFFHKPv9iJ6d9gMZs+IEG9XQb6DNWJun9VlmPc4Hn6sQbbBIV9LIk8D43CknkjW96nNAYgRpi7WDcmHjP78GLigVESeBJxm0RlFwPkhjTBi40asZcWK8PXhJMmuMqQc9D5mZPkvXGESfwbTuzvQlBx9ScGOWU7t4LMD1E1hDm1fOoaft1plsVTEv76ZjBeMIzLq17lo6dzvl950PS/Hixh8YwvGo+O+X5NVrYEG+goBC7yIMY2VHiCxUmGqr0N3h9W+/3aaBh7177KgcPpDDL9V//7R+tyYRLfAtBoo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b4fb4-7490-4de8-301b-08d71595f823
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:03:35.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The procedure used to enable 4 byte addressing mode depends on the NOR
device, so let's provide a hook so that manufacturer specific handling
can be implemented in a sane way.

set_4byte methods can be amended when parsing BFPT.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 119 ++++++++++++++++++++++----------------=
----
 include/linux/mtd/spi-nor.h   |   3 ++
 2 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b2e72668e7ab..e35aae88d38b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -758,6 +758,21 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *=
nor)
 	}
 }
=20
+static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, &ear, 1);
+	}
+
+	return nor->write_reg(nor, SPINOR_OP_WREAR, &ear, 1);
+}
+
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
 	if (nor->spimem) {
@@ -777,6 +792,39 @@ static int macronix_set_4byte(struct spi_nor *nor, boo=
l enable)
 			      NULL, 0);
 }
=20
+static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	write_enable(nor);
+	ret =3D macronix_set_4byte(nor, enable);
+	write_disable(nor);
+
+	return ret;
+}
+
+static int winbond_set_4byte(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	ret =3D macronix_set_4byte(nor, enable);
+	if (ret || enable)
+		return ret;
+
+	/*
+	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
+	 * Register to be set to 1, so all 3-byte-address reads come from the
+	 * second 16M.
+	 * We must clear the register to enable normal behavior.
+	 */
+	write_enable(nor);
+	nor->cmd_buf[0] =3D 0;
+	ret =3D spi_nor_write_ear(nor, nor->cmd_buf[0]);
+	write_disable(nor);
+
+	return ret;
+}
+
 static int spansion_set_4byte(struct spi_nor *nor, bool enable)
 {
 	u8 quad_en =3D enable << 7;
@@ -794,62 +842,6 @@ static int spansion_set_4byte(struct spi_nor *nor, boo=
l enable)
 	return nor->write_reg(nor, SPINOR_OP_BRWR, &quad_en, 1);
 }
=20
-static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(0, NULL, 1));
-
-		return spi_nor_data_op(nor, &op, &ear, 1);
-	}
-
-	return nor->write_reg(nor, SPINOR_OP_WREAR, &ear, 1);
-}
-
-/* Enable/disable 4-byte addressing mode. */
-static int set_4byte(struct spi_nor *nor, bool enable)
-{
-	int status;
-	bool need_wren =3D false;
-
-	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_ST:
-	case SNOR_MFR_MICRON:
-		/* Some Micron need WREN command; all will accept it */
-		need_wren =3D true;
-		/* fall through */
-	case SNOR_MFR_MACRONIX:
-	case SNOR_MFR_WINBOND:
-		if (need_wren)
-			write_enable(nor);
-
-		status =3D macronix_set_4byte(nor, enable);
-		if (need_wren)
-			write_disable(nor);
-
-		if (!status && !enable &&
-		    JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_WINBOND) {
-			/*
-			 * On Winbond W25Q256FV, leaving 4byte mode causes
-			 * the Extended Address Register to be set to 1, so all
-			 * 3-byte-address reads come from the second 16M.
-			 * We must clear the register to enable normal behavior.
-			 */
-			write_enable(nor);
-			spi_nor_write_ear(nor, 0);
-			write_disable(nor);
-		}
-
-		return status;
-	default:
-		/* Spansion style */
-		return spansion_set_4byte(nor, enable);
-	}
-}
-
 static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 {
 	if (nor->spimem) {
@@ -4287,11 +4279,18 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 static void macronix_set_default_init(struct spi_nor *nor)
 {
 	nor->quad_enable =3D macronix_quad_enable;
+	nor->set_4byte =3D macronix_set_4byte;
 }
=20
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
 	nor->quad_enable =3D NULL;
+	nor->set_4byte =3D st_micron_set_4byte;
+}
+
+static void winbond_set_default_init(struct spi_nor *nor)
+{
+	nor->set_4byte =3D winbond_set_4byte;
 }
=20
 static void spi_nor_mfr_init_params(struct spi_nor *nor,
@@ -4307,6 +4306,9 @@ static void spi_nor_mfr_init_params(struct spi_nor *n=
or,
 		st_micron_set_default_init(nor);
 		break;
=20
+	case SNOR_MFR_WINBOND:
+		winbond_set_default_init(nor);
+		break;
 	default:
 		break;
 	}
@@ -4685,7 +4687,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		set_4byte(nor, true);
+		nor->set_4byte(nor, true);
 	}
=20
 	return 0;
@@ -4709,7 +4711,7 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		set_4byte(nor, false);
+		nor->set_4byte(nor, false);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
@@ -4801,6 +4803,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
=20
 	/* Kept only for backward compatibility purpose. */
 	nor->quad_enable =3D spansion_quad_enable;
+	nor->set_4byte =3D spansion_set_4byte;
=20
 	/* Init flash parameters based on flash_info struct and SFDP */
 	spi_nor_init_params(nor, &params);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4521a38452d6..a434ab7a53e6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -378,6 +378,8 @@ struct flash_info;
  * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
  * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
  * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
+ * @set_4byte:		[FLASH-SPECIFIC] puts the SPI NOR in 4 byte addressing
+ *                      mode
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
  *			completely locked
@@ -420,6 +422,7 @@ struct spi_nor {
 	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	int (*clear_sr_bp)(struct spi_nor *nor);
=20
 	void *priv;
--=20
2.9.5

