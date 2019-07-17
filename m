Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A51C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2356217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wh+FnQu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfGQIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:48:17 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:60369 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGQIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:48:15 -0400
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
IronPort-SDR: a2uXCPweg0St7evJ7wOb2DkKQC/c7QDdCr1AladgDT4KVRaK/u9J6H4ddyBYGC7AsEc631n7l+
 YvjXJpj3cyh6hz1JGQtsD9eytnCl5iBm8DmjhaS3p3Y+w9lF6skf57tiSFdov9r7LldcunGOqe
 GxfLIbxZuwqx3wIsSU+CLxoGbEYMrlDYFxvhSUlPWLKPfTzVFq+tyaEH5NaFb1h2Gj5+RHPHEh
 j/gKl0zILCmRH30r635Bzp0FFJewL4VTyHhtFf/gTawiRZLS+fNtBCpwys8EOxt2xHOOmOE+8w
 7r8=
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="41583079"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 01:48:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jul 2019 01:48:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 17 Jul 2019 01:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/6c34Sg+mjuuxmbq3XAptMFVf1lEHRy4dvixtwjZATGF7a+KZD3YN/lnqyjYTa3M2kagVbrSm5JXOxwiqONtfJRkeFoZ8ULUAORmF+0QZQKOy4v6d63O/d47QI6+mx/PczvO0gRDgZC+TxIfGtLw1Quob9+HpbMX54aOyqnjjQvzhnbl5oie02nc8pY75vKEjYRF+H2qjkaYQkqR0ciV0RYk5TSBIxJIGctHq8/StXvoVChhXbxO59z9ByTJqlMVheYCcxBniLbZ8qtcgHNjWswiZPzdTcdMEW7zx1CnrLRgxfKqyM1t2NIDWVq4PTpITY8JwS5YNk19uP8V1nXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crZyCNc3WLHXJwyzBAOIha+riRt5BtIHZgtjBu6WjXM=;
 b=RG1lT0v/cqrajMx3zbH4hwZ+LXX4uH7k2OJ+0eaLQPE6p2XbxDlkyyC/vAW8tbnvDTwBndbGXevu2RtpcIZoaryrapFZ3TXRkpqKUHIVUOApB/LjvPzkDI1w8hmlVQLrGczk2SENDKhCJYtO9CiZ97EXpipVItzzrk4ByTJ+6NUEYt5rYBN7I5eHgbQ/b64z33CI5RcmKLPy0O7DT0a56bMVkc66jMOhEufw3PC1kMt45jQ9uY+4HRgzw7G2uVgBI/ioxkUNX7L/q0HCaIi8BkhdF3zp7dLYs2OPqOTobprk1ya6vYhHu4ngoAK5QqF3mEfzysFJcyoDq4DKNh3L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crZyCNc3WLHXJwyzBAOIha+riRt5BtIHZgtjBu6WjXM=;
 b=wh+FnQu7MzlSkNhYp0yqRIVPUXF6hYk+HRojHldNaczchFybGT0bscAc3AGqBlf/KJdsmynfz95WIapi4RTbxcaZ2OwIAAJyFQsNfQW0dBVNjwpUkQjexLf5Jlthhlz9EUx1aBRpWZxC0wua/bRRFvYVvK2S4jBlWGvC5cxAN4Q=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6SPR00MB254.namprd11.prod.outlook.com (10.173.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 08:48:11 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102%12]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 08:48:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 3/5] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH 3/5] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHVPHxdqQl/GMdi9ECDdSKG+lyMoQ==
Date:   Wed, 17 Jul 2019 08:48:11 +0000
Message-ID: <20190717084745.19322-4-tudor.ambarus@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190717084745.19322-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31001b2b-fce1-46e0-3107-08d70a937f8a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6SPR00MB254;
x-ms-traffictypediagnostic: BN6SPR00MB254:
x-microsoft-antispam-prvs: <BN6SPR00MB254456C89677112A213A48DF0C90@BN6SPR00MB254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(66066001)(102836004)(186003)(4326008)(99286004)(52116002)(76176011)(2616005)(486006)(386003)(6436002)(446003)(256004)(26005)(476003)(86362001)(53936002)(107886003)(6506007)(6486002)(66446008)(11346002)(14454004)(14444005)(6512007)(71190400001)(64756008)(71200400001)(25786009)(81156014)(110136005)(2501003)(478600001)(305945005)(7736002)(54906003)(1076003)(2906002)(5660300002)(36756003)(66476007)(81166006)(66556008)(6116002)(8676002)(50226002)(8936002)(316002)(3846002)(66946007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6SPR00MB254;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gaQ4s6r/SShibbUv6VUa9Y2fqTf/FABee5w3LGIRxyFitUbcC1A11ethHeKjbDH/mSFeSP5EdbCQxTP0UsteCm/FR0Mma+r6l+eEqz7WWmHy6AC8zbj35qQDYhjrpk1fJCQqYX8K+ickfLNQybo3fIgjnlZznzB3PplCsqIjlfcR/naXhjHDdzj+BbPUTE7FkOo440tjkaK86myUwNqHvowgjkpRGsfKQWzK6IM8Qsmq61l3/dCtG5jzIdt5AwGENyNEFX/whPorc/cIeqYo/9ZPBCH9C8N9mjvWsKEsDIyO6lzM3cP+7m7sazamnEwehGZrwoDbBmSP+fB01MXw+rbXZpaqRtqH/sqtt1i6mn2ZKvWaV/yKWKE0qaeAn9ZzIXLwSCKOXMYBdgOVlMVIHbv2/rM9rrUQy7845vPiNJc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31001b2b-fce1-46e0-3107-08d70a937f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:48:11.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

To avoid inadvertent writes during power-up, some flashes are
write-protected by default after a power-on reset cycle.
A Global Block-Protection Unlock command offers a single
command cycle that unlocks the entire memory array. This is
identical with what other nor flashes are doing by clearing
the block protection bits from the status register: disable
the write protection after a power-on reset cycle.

We can't determine this purely by manufacturer type and it's not
autodetectable by anything like SFDP, so make a new flag for it:
UNLOCK_GLOBAL_BLOCK.

Note that the Global Block Unlock command has different names
depending on the manufacturer, but always the same command value:
0x98. Macronix's MX25U12835F names it Gang Block Unlock,
Winbound's W25Q128FV names it Global Block Unlock and
Microchip's SST26VF064B names it Global Block Protection Unlock.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 21 ++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e9e441f91b68..767e2e6eb1b8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -250,7 +250,7 @@ struct flash_info {
 	u16		page_size;
 	u16		addr_width;
=20
-	u16		flags;
+	u32		flags;
 #define SECT_4K			BIT(0)	/* SPINOR_OP_BE_4K works uniformly */
 #define SPI_NOR_NO_ERASE	BIT(1)	/* No erase command needed */
 #define SST_WRITE		BIT(2)	/* use SST byte programming */
@@ -279,6 +279,7 @@ struct flash_info {
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
 #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
+#define UNLOCK_GLOBAL_BLOCK	BIT(16) /* Unlock global block protection */
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -1725,6 +1726,20 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_n=
or *nor)
 	return spi_nor_clear_sr_bp(nor);
 }
=20
+static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
+{
+	int ret;
+
+	write_enable(nor);
+
+	ret =3D nor->write_reg(nor, SPINOR_OP_ULBPR, NULL, 0);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d on ULBPR\n", ret);
+		return ret;
+	}
+	return spi_nor_wait_till_ready(nor);
+}
+
 /* Used when the "_ext_id" is two bytes at most */
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
 		.id =3D {							\
@@ -4053,6 +4068,10 @@ static int spi_nor_init(struct spi_nor *nor)
 				spi_nor_spansion_clear_sr_bp;
 	}
=20
+	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK)
+		nor->disable_write_protection =3D
+			spi_nor_unlock_global_block_protection;
+
 	if (nor->disable_write_protection) {
 		err =3D nor->disable_write_protection(nor);
 		if (err) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 6c3273760700..84d279fd287e 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -65,6 +65,7 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_ULBPR		0x98    /* Global Block Unlock Protection */
=20
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
--=20
2.9.5

