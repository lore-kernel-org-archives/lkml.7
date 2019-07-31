Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E8A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nrZc8b1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfGaJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:12:32 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61927 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfGaJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:12:29 -0400
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
IronPort-SDR: e0Eb0HDcDbKHA3Ezz7jIKWXl4mfaOAVP1aAYQPny5OAGqAk9eWSdmWvOqz/2aEvypqZVAWZ+7S
 +ITpT+kbKFoGIUDXyPGz3GQeJcXZW5/KP/RFLZReL6RfmyjWoHPvKZnx439Uf0zi674nNKkG/m
 e1vLBsIi/nWLUZRKHk4NH8i9PkWgV4yBjvEBKAghqZPvnTyouduEh8mo9qJthz2gxJIO5p6kcE
 FVX6eQ1NyvxV+efyIBXlE+I6mZBrVEpz6p+1hexpkscsN4eQ8kPiSyOdpm/jg/UZgRvn8lZWRO
 Ehk=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41824445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:12:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:12:17 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyRHAJNxvzhxcSfuMLm3Y5MXcHKjp7jbJCewYL+0tSiCf9N4bQcExxaNNmWGgQXZu5nUgOt256g5U83VXOFE1ilrRx/u/sgOB5Lc8Ql2uo8Td7uuGqN7OrL9RrhJfOJelW7QDCH32p/4UQ3PcpT32POELVvF9lIx7VStwTk4MflWq18+Ib0jEzK2WlTxVBOBOakEO+D7r8orQ0Z7SK2f0xjMshrr1XF2qKNOiQCDnKUD5ye2unIE4T/tnHJE7j23+Phoea3FiCF9n6Nk18hAt2qLNnDU/84buAx6BeAGnptKi8XvDADRIz5S7BrvUmiLRuCjqWNMkQ1YKgucQj8xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gk6QzncRI15wXDwNjTCM0w8SffwWWKRB5Fx81DLl0U=;
 b=hias/zB0/P5j/gH1SQB6GGqbXAW11RJTVuCGBbdKtXKnW9PsDR3tI6E1Kr8rtVTRvgHH0G1CZpudsxptwsVoQud2jSukDXMIaijviWTJ5v70luHKKqBGSMa61NDs9r6EeGvD5A/vwYBorM5BPo/+gPHMgzABgB1Ga/TzS4xi9huBTEUTlaWMd9ki8YjunJnVYuyZYmHGiLQB2Iy74RC/qII5/NxD7NS2z8LC2hH1b2cGFrR+6LIrQnqhPkmxGaBTbAlpu2fVhXnkkhXo5tS10fUTFqR0SClIH5H7EF4qdOD5s9mgj56TMSGs0aX5C21VnFxxhb4vjPF3F97T7TE/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gk6QzncRI15wXDwNjTCM0w8SffwWWKRB5Fx81DLl0U=;
 b=nrZc8b1lLuVWXP41wu3PZ7Gvc8UJqeuS35uY2QZBnL9yYOXM+gwwCbJJvSMUCl5rD0YEspM0+Ew4OsaqgMeZK3wC6KPkWUatbkjurt3Ox61R2vJkorBoBal+/jxluAR7PLDo4v3T3Q4m7VzZ5iLgVhL05K57Q0OW7O2iQQuQaqs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 09:12:16 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:12:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AMaH6Ddp0nkEGsW9FcCZCHsw==
Date:   Wed, 31 Jul 2019 09:12:16 +0000
Message-ID: <20190731091145.27374-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3b041976-7bf4-482e-d6a3-08d715972ea2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4414;
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB4414C909B016C03B3433F637F0DF0@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(14454004)(26005)(81166006)(6116002)(50226002)(76176011)(5660300002)(66066001)(2501003)(6512007)(25786009)(486006)(102836004)(107886003)(2201001)(110136005)(305945005)(3846002)(7736002)(68736007)(53936002)(6486002)(478600001)(86362001)(71200400001)(71190400001)(14444005)(186003)(476003)(256004)(8936002)(6436002)(386003)(52116002)(54906003)(316002)(66946007)(81156014)(11346002)(2616005)(2906002)(64756008)(4326008)(446003)(99286004)(36756003)(66556008)(8676002)(66476007)(66446008)(1076003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LzFhHjIdRNGsLt+v9Dx8Im/Acw/mewsyF4Ri7nW+v5TbsXWXXuA4BZpKkzZCYCOhfk1n2dO7K8qv/Sb9HuPpVzykNZhtxu3P74nO96XllhWCgeNHkEicTK+nnzqRapq+9o01cw55E9JHAhdV0cLNU5YOaVl1uIwev7+dSRmuHRPkzZUry4+MlKbehbQRIzwhsZrYUHhesRRGAPbSTqmUSW+wUneQzhVAQgiIBL5/Gz4uorDZ3AyVX4QNgzvpQVcEdST13vZ1no1uvL53WJXVZEfK8nVMiyJNLU3P0EjCHrHWZP6aDBmBjVx2HNqHQanIN88riSRRdOVIb3NKW0HY6WgMJOLTTUz9vPJPX5uypcdmG6LAOoW7/Pb/v8vWf8loqDeARm2fu4MeBfeyOccjBpKTInLkfL+iFwbAUHoYKhU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b041976-7bf4-482e-d6a3-08d715972ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:12:16.4044
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

s3an_nor_scan() was overriding the opcode selection done in
spi_nor_default_setup(). Set nor->setup() method in order to
avoid unnecessary call to spi_nor_default_setup().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0ff474e5e4f5..5fea5d7ce2cb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2795,7 +2795,9 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
=20
-static int s3an_nor_scan(struct spi_nor *nor)
+static int s3an_nor_setup(struct spi_nor *nor,
+			  const struct spi_nor_flash_parameter *params,
+			  const struct spi_nor_hwcaps *hwcaps)
 {
 	int ret;
 	u8 val;
@@ -4393,6 +4395,11 @@ static void spansion_post_sfdp_fixups(struct spi_nor=
 *nor)
 	nor->mtd.erasesize =3D nor->info->sector_size;
 }
=20
+static void s3an_post_sfdp_fixups(struct spi_nor *nor)
+{
+	nor->setup =3D s3an_nor_setup;
+}
+
 static void
 spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
 				      struct spi_nor_flash_parameter *params)
@@ -4405,6 +4412,9 @@ spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor =
*nor,
 	default:
 		break;
 	}
+
+	if (nor->info->flags & SPI_S3AN)
+		s3an_post_sfdp_fixups(nor);
 }
=20
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
@@ -4582,9 +4592,9 @@ static int spi_nor_select_erase(struct spi_nor *nor, =
u32 wanted_size)
 	return 0;
 }
=20
-static int spi_nor_setup(struct spi_nor *nor,
-			 const struct spi_nor_flash_parameter *params,
-			 const struct spi_nor_hwcaps *hwcaps)
+static int spi_nor_default_setup(struct spi_nor *nor,
+				 const struct spi_nor_flash_parameter *params,
+				 const struct spi_nor_hwcaps *hwcaps)
 {
 	u32 ignored_mask, shared_mask;
 	int err;
@@ -4641,6 +4651,16 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return err;
 }
=20
+static int spi_nor_setup(struct spi_nor *nor,
+			 const struct spi_nor_flash_parameter *params,
+			 const struct spi_nor_hwcaps *hwcaps)
+{
+	if (!nor->setup)
+		return 0;
+
+	return nor->setup(nor, params, hwcaps);
+}
+
 static int spi_nor_disable_write_protection(struct spi_nor *nor)
 {
 	if (!nor->disable_write_protection)
@@ -4804,6 +4824,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	/* Kept only for backward compatibility purpose. */
 	nor->quad_enable =3D spansion_quad_enable;
 	nor->set_4byte =3D spansion_set_4byte;
+	nor->setup =3D spi_nor_default_setup;
=20
 	/* Default locking operations. */
 	if (info->flags & SPI_NOR_HAS_LOCK) {
@@ -4905,12 +4926,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 		return -EINVAL;
 	}
=20
-	if (info->flags & SPI_S3AN) {
-		ret =3D s3an_nor_scan(nor);
-		if (ret)
-			return ret;
-	}
-
 	/* Send all the required SPI flash commands to initialize device */
 	ret =3D spi_nor_init(nor);
 	if (ret)
--=20
2.9.5

