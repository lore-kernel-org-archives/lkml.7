Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1884AC41514
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27572173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="M+yzxgth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfHXM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:27:16 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:2102 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHXM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:27:15 -0400
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
IronPort-SDR: Dg1WOZYr+rZv4fuZq7E2Sz8hYjq2k0EBut6lOkVOeIljrkICYhbytzyrjEsSyuHjcrG3vEaP8K
 W30EKCqxp9g+7vXGvDi2t1VWaYKwzDdup0uVTuCiyNH64VvJiRUcxCXwQu1L6J0Cscmavvki/q
 f/AKR2mDEJh187vhayq3TruL1A3TRvF5M3F+tfkjxmZoOV0ElKG6HsFEurgJMQaSvMAokugV1+
 kIgjIxE4xAogg9CdyXNnCVo+qhh2PcmxNqqtz0UzKj5AnwSH7LS17qoIQswK0neolwGMV5Y5fN
 SRI=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="44864839"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:27:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:27:14 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYOo/kJdL50PEKDDCD7ngkYx3mdmNG2jWQTAEGwlLm7T7TqAU3NTWtJcJZRPOJs1PhyJg2xorz7AvyfVSSzvKALQHGowB6jYrVE3Z9qVLV0L+DxGkceNX/nVSsAliJ92/07rFaYNedbPa75jVWGTJvLjgsqFozN24m689HB2abyxRsKzxfa5+9Or9geyJ4bSxmayMa/VOWRrBUAIcD+HKbI1JsIyscOsawdcy/1/hh/rD4BB/NZ4qcPmNAyRYwSPzzkzDOcx4rfuQvxGJFhVDJO50X0YoPPN3K+nOPW5eRzW+fG4jolMAsM+pFItcCakWtrRdiLPLfZC1L5kV4zMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uywpy+3RW28nC/OMSt1ItOvew47wP4CO7a8BONJg5Y=;
 b=SNpL0zfcpHUmgMW+bcYFoU2AXbeWraql89cK+bm8o5+Wtx8vIwvAa8vAZX3jewV/P0evRR67+gVbgDbUsnFB9zVBfEgWiLhXGhT0Nn0hupyhk10B3Cl8GFIAyuXgOpc1bTuzE8+Y9Gv9CwS2787JlfwTmeJlnQDUVH0/mX54Oh0O5n0UqacjIh8x0ZS+shHEIQIFlga6AV+5R2egI+bEN1UbSpDRb223Qy7vmOYQ9XsUs1UK0LXAV1pfhXd6jjlL9qADJYeNp6661jYipI4EZCeHm90thyHutFuBICsPZ0udd9epNdc2gy84g2ZBkyfbe/RfFUFQ7RFFWoEMiOBBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uywpy+3RW28nC/OMSt1ItOvew47wP4CO7a8BONJg5Y=;
 b=M+yzxgthTpWtSEbhjanvpER6RgQyAK9aH2mPDyaN7A7VV3kj0YcCy39agPDqSB6S7m5mwwZHTnxV+gQ1HSLRxKMDwY4WfOaCsZ4DD3RnSqkQV8K0afxx32ahV/Nj2h/L85B+sbX44EQr9UtWDLRHtB2Oq5Gub4ySctuzNMCk/Kk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3854.namprd11.prod.outlook.com (20.178.252.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:27:12 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:27:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHVWndBGiXUgYKWckGGG7tH1Lap/Q==
Date:   Sat, 24 Aug 2019 12:27:12 +0000
Message-ID: <20190824122700.23558-2-tudor.ambarus@microchip.com>
References: <20190824122700.23558-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824122700.23558-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 630f97a2-3f71-40db-3405-08d7288e63e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3854;
x-ms-traffictypediagnostic: MN2PR11MB3854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38541B62FB316A809868D19AF0A70@MN2PR11MB3854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(256004)(66946007)(81156014)(81166006)(186003)(2201001)(64756008)(66446008)(66556008)(26005)(478600001)(486006)(50226002)(2616005)(6512007)(386003)(102836004)(8676002)(86362001)(2501003)(6506007)(1076003)(14454004)(316002)(476003)(11346002)(6116002)(66476007)(99286004)(110136005)(6486002)(305945005)(6436002)(7736002)(71200400001)(76176011)(2906002)(8936002)(446003)(25786009)(53936002)(66066001)(107886003)(3846002)(71190400001)(4326008)(5660300002)(52116002)(36756003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3854;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sLTEy/smCUftu1iXeh3sQpocqmkD0cVZ5hEguX26tcUZv+YgUlKUFgzKE6oyJ087VM3vZd7m5SayEcA/8+tsiUU3/Md/FQnmUVu++M+/Z6Qn5NkgWIeJjdpiBPXCWCxyXw+AyrnUSWWpfz3bqPWtM6ssb/lUPHwlPl2IurFr31UgyNtKY3f9aJJwwiNsQ+iInGtcFWEfJfKLx747+yQ4S+V98zCjWjHosEoCCQ1tFoVHKYIMHCFa8wpwqdMRJcUir908hs9VnsvnQPuNlWQq+8yvk9uiostgtTMBpbTMbbOZgoOh1oPkQlpEikb9x3NKdhHdjGdfxgAp/Tst8aTxhZeZZgUjKkmqm8Ojgn4zH70ODWZut/ePPP4FapR8Oyzjoe0EwS647CtEre89ureOqRDbjhNbtXTr8XqSA44ap1I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 630f97a2-3f71-40db-3405-08d7288e63e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:27:12.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3/YDXOVshUOpMnvSsLXGrFK+bO0pa7gVnFy/H8GxPx7j2XcmHKk5A0YHei6jav1iJTQHahivuOtN4P0GCvW1oR24qnP9Kf5UT9MfMIDI7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3854
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
v2: the check for UNLOCK_GLOBAL_BLOCK should be done the first
thing in spi_nor_disable_block_protection(). We use it for a faster
throughput, a single command cycle that unlocks the entire memory
array. Fix it.

 drivers/mtd/spi-nor/spi-nor.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1896d36a7d11..c0ba6fe62461 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -196,7 +196,7 @@ struct flash_info {
 	u16		page_size;
 	u16		addr_width;
=20
-	u16		flags;
+	u32		flags;
 #define SECT_4K			BIT(0)	/* SPINOR_OP_BE_4K works uniformly */
 #define SPI_NOR_NO_ERASE	BIT(1)	/* No erase command needed */
 #define SST_WRITE		BIT(2)	/* use SST byte programming */
@@ -233,6 +233,7 @@ struct flash_info {
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
 #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
+#define UNLOCK_GLOBAL_BLOCK	BIT(16)	/* Unlock global block protection */
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -2031,6 +2032,41 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_n=
or *nor)
 	return spi_nor_clear_sr_bp(nor);
 }
=20
+/**
+ * spi_nor_unlock_global_block_protection() - Unlock the Global Block Prot=
ection
+ * @nor:        pointer to a 'struct spi_nor'
+ *
+ * The Global Block-Protection Unlock command offers a single command cycl=
e
+ * that unlocks the entire memory array.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
+{
+	int ret;
+
+	write_enable(nor);
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ULBPR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->write_reg(nor, SPINOR_OP_ULBPR, NULL, 0);
+	}
+
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d on ULBPR\n", ret);
+		return ret;
+	}
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 /* Used when the "_ext_id" is two bytes at most */
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
 		.id =3D {							\
@@ -4697,6 +4733,14 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
  */
 static int spi_nor_disable_block_protection(struct spi_nor *nor)
 {
+	/*
+	 * If the flash supports the Global Block-Protection Unlock command,
+	 * use it for faster throughput: a single command cycle that unlocks
+	 * the entire memory array.
+	 */
+	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK)
+		return spi_nor_unlock_global_block_protection(nor);
+
 	if (!nor->params.disable_block_protection)
 		return 0;
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4752d08e9a3e..31b99a7743fc 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -66,6 +66,7 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_ULBPR		0x98	/* Global Block Unlock Protection */
=20
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
--=20
2.9.5

