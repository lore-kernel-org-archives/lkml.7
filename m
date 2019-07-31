Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD4EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7572089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EeqUzJBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfGaJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:12:13 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61880 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:12:11 -0400
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
IronPort-SDR: zRx5EuQPhj9JfDz42jSimj9SqQNXc9Ob2Gi9btUlSZmPaK6naSJXP/kKrfk7KqXHN5oW04GRSI
 j3YFyfJN4YgS2dei+7xe0FFOlvmGAgESQUIcL1FinTZUHvlGrVOlw41hOJJMZEcoT+jvzXL4Ds
 NmbJ7GQwHCfXmG8U261V22+Kq77VPf5akS9CCVcZJJ438PSkaTsxNe3yI7gq5R+FePEgObjNsx
 YY17nUaj1vtXY8nqWEqGfD254Hinjfz456yXI1TY819UufxUVd1ssPMyHk3kZRVagyVgNwj8jj
 Zsk=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41824396"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:12:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:12:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 02:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf569aeLJH4UGq6h11pKWI9NJgxo469eWdplaM1N0WRuW6fVIBvQ1LdZze3/gRCQKA0v6u27b0rANDnvehkCuImJU+/By2uU9Z4OBOpE/HzZqERyMZJDScoc/nSu7gZ0Pa5sIAgzEAi+NT2ewA1DQNnRWrKv+6K1m4NmQXvaOWtUGXCNce1HRyNQmuxx7EEwqHlkEYLu9wkKanaWi/gL5DsPrXexJ3PbCd+apDgO2fdcFFd8L7GNhTmWxv1Sy+bqdFB44EfW4MwjljV43WcS0UqPGWMEv4m5URNmtb25l4istr+nuprVQAxOId8vFkKnQB5AZPOH7IsVPUcgIPx2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEQHSlecCAJjZ9NwC8f1ADL2pS4YNT8gGEk3FdG4FT8=;
 b=GIBlX17Tvnt/wn+cY609y1bgk1ikCwoBgGNfVDLabWh6TksbmW1nh/L7rD3iBDC/Kewzv2KlIg7Q0FEbaylC7In5VK9vT0MMs0RFHZMK/NzPwxhCYTr33shlAcVXNPFChIJEI03WzM70u9KHdgaYeHuhqHuoiYlynO0tngkOIgRa0DcE9WTTKWpnk60I4Df6uuWeJT8zhO/xTMI6po8DEd6vg1+kBuT9/lHBtzXR4YIEyXWE93jtXKlzOd32r4VNA7n5bbmkIZtbMYlf9ezgd8l33inFCQy5PQFJTPHE74ITojF82THvIsKu2POpeP13FSNneiQr2ObVDvtqbF0JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEQHSlecCAJjZ9NwC8f1ADL2pS4YNT8gGEk3FdG4FT8=;
 b=EeqUzJBvSNMyTMa/VWgg0KvfKJDwR0hL/a3AkcXN1mzUoux/NTS91VkYJtNXrNi1SQVVhO9zA3tlDoBl8on31YuNWAUMtQp5klJ1ycXWSx9Ll65QMweMruZbe8AOJBbdefEr2nKtyyHmD6P2ea5ciGyFMYnxQJjb//wzLnDPQUo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 09:12:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:12:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/6] mtd: spi-nor: Add post_sfdp() hook to tweak flash config
Thread-Topic: [PATCH 1/6] mtd: spi-nor: Add post_sfdp() hook to tweak flash
 config
Thread-Index: AQHVR4AHEj1fjWjkOU2mBlHhbksvPA==
Date:   Wed, 31 Jul 2019 09:12:08 +0000
Message-ID: <20190731091145.27374-2-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7ac62ca9-a150-4ce5-23c8-08d7159729be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4414;
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB441419A8779BD8E7D267174BF0DF0@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(14454004)(26005)(81166006)(6116002)(50226002)(76176011)(5660300002)(66066001)(2501003)(6512007)(25786009)(486006)(102836004)(107886003)(2201001)(110136005)(305945005)(3846002)(7736002)(68736007)(53936002)(6486002)(478600001)(86362001)(71200400001)(71190400001)(186003)(476003)(256004)(8936002)(6436002)(7416002)(386003)(52116002)(54906003)(316002)(66946007)(81156014)(11346002)(2616005)(2906002)(64756008)(4326008)(446003)(99286004)(36756003)(66556008)(8676002)(66476007)(66446008)(1076003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CWxd0op5kU95eOvKe3qSCGCSkcm2nBOU33aCz4+lUe8tAhruEQrJLNKV3fBon8NEuQK8o6shu8nB40UepC5vPzOk0TiWtCoTAygnd2oG91RngNd9q9zzVGigea98YYgN2Eatr4zFBEDxR0cvMiBFRolIxxMXlZ7vFFsS58PZwO6kJf69XKtmmo+vXqbMue3CXedKVWuVvduBlGi17TL5EszhsCHZlo8+in2fxAU2uX8r9FsPSbhrO4bkraFq2KRwN1yF5Dcylhb8FaZzY66dd5gRZjSH89zCFCy39IazXtcT6HzWRlcQhaTVX/As6ehKqkb7pFsGNpH0lzCNyZsxsIVgT0kTWokbejeDComwAbrVwI1/Mi3aem9zVCfMpEIC4OVVf8MUoY1jzglCGxXVeTKn7IX12qUc7XsO3SfM1Cc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac62ca9-a150-4ce5-23c8-08d7159729be
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:12:08.2677
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

SFDP tables are sometimes wrong and we need a way to override the
config chosen by the SFDP parsing logic without discarding all of it.

Add a new hook called after the SFDP parsing has taken place to deal
with such problems.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9b9f9b530207..2c2d13060427 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -221,6 +221,11 @@ struct sfdp_bfpt {
  *                flash parameters when information provided by the flash_=
info
  *                table is incomplete or wrong.
  * @post_bfpt: called after the BFPT table has been parsed
+ * @post_sfdp: called after SFDP has been parsed (is also called for SPI N=
ORs
+ *             that do not support RDSFDP). Typically used to tweak variou=
s
+ *             parameters that could not be extracted by other means (i.e.
+ *             when information provided by the SFDP/flash_info tables are
+ *             incomplete or wrong).
  *
  * Those hooks can be used to tweak the SPI NOR configuration when the SFD=
P
  * table is broken or not available.
@@ -232,6 +237,8 @@ struct spi_nor_fixups {
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
 			 struct spi_nor_flash_parameter *params);
+	void (*post_sfdp)(struct spi_nor *nor,
+			  struct spi_nor_flash_parameter *params);
 };
=20
 struct flash_info {
@@ -4444,6 +4451,13 @@ static void spi_nor_default_init_params(struct spi_n=
or *nor,
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
 }
=20
+static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
+				     struct spi_nor_flash_parameter *params)
+{
+	if (nor->info->fixups && nor->info->fixups->post_sfdp)
+		return nor->info->fixups->post_sfdp(nor, params);
+}
+
 static void spi_nor_init_params(struct spi_nor *nor,
 				struct spi_nor_flash_parameter *params)
 {
@@ -4454,6 +4468,8 @@ static void spi_nor_init_params(struct spi_nor *nor,
 	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
 		spi_nor_sfdp_init_params(nor, params);
+
+	spi_nor_post_sfdp_fixups(nor, params);
 }
=20
 static int spi_nor_select_read(struct spi_nor *nor,
--=20
2.9.5

