Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D1C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA422067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zI+tMzvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfGaJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:12:21 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61897 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:12:21 -0400
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
IronPort-SDR: c+lnhLMbdLj76S8e0GzQcR1cd8cc8qddTQIXo30HzhtSFNeIMWSWtLGaNg8UwC+3WtVj7XVk1T
 GSclZ5yNAngROEeg8JP6s8BqM5GNWHC/4zPepCmvU04OgqVsOgzjjdmOYzekAe9k8ITM7xarMp
 j3nDuevxyIsUD615SRSo2NJqvd3wtcBX9q2IhU4FH2O1HRcJCPx+DAX6z1iIesFvzum+Toieb7
 lKRIBJwSg/oVLVKLsPG+3KTC5A9Uyl59exSBHM1ysCoxLWeFpgVRzfiTkTA2GZiHothsRSzqU/
 MbY=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41824407"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:12:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:12:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 02:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb4b2q5I5PaHTgR/1JnNLEpHcMfGjJ6uaYZSI77oGp/nG7oczmzIDM166d3AT09cZAukZnl9HBWGDhaQ4liQMQ/65jsUC08VoWyngLqYjtoJFlHmslsUydANi3mhYm9MvZQkmynGwkmpFa3e0WFloTDoa8ixeL1mNgmc4KEFwvdL1xtvasEAGT4d00nN/Hwl+t+DJY8I5cgLG7Ll8QmYeeuSA7EuK4s9oDKdzIaIvWPd9qN7O4lbuaZhdIO1CVS4ASM3zBvsjUuWBriIWh2/clcPDPusU8+/wUdDXtAMyZWS7CF9UISq50wkBuXMYAEVpQSPQsUrfRpm653Dk2Hnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cbhfzN6sFL/a+vSk+BFw1atN6TIeYzNqMdw+uI+SZA=;
 b=YjvVzCDEQ+lGICB5dvXwQESU6I0I01Cp3pp0UcFuThxBAraKq/iOZozi/hVwEgEVuDADAMxSB79ZF3w41JtCosSo02gx3mmnnotq5YBunu/j+BZOkuMOZ+EvqZdOQY7CVsPLWjCHsqmmeATHuNHml9taFP1y5VeAiunXvWu5r3NLuGk4HoaV55j1zag8e8Hyfmo8EW4dnV37ONUBm5bDBS1NE84p+z/YiYwUDY6mqTcDKDToXzdsblwbWL6vkIdobSRs+7s+zxq7HAX5XYc+YsXZyfF3n7vJn7qwfY2khLgKZbNOMLu4NR+SnEbF1eOAr6MWOzv4VNVjpmqAB4oxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cbhfzN6sFL/a+vSk+BFw1atN6TIeYzNqMdw+uI+SZA=;
 b=zI+tMzvBcw1aKd7Xv/uMoFMS5MsPQFOxoHgbI/etJDgDAs19eJupu4Js6E578UlJHbHraIgt6SR5LjbEkl7/nozrAQYnU1+VxPPNN9mnYNMgOz9YBW1+VUP/rGIXzeK5WIAfFn4hWmLurgfU+fmLGhBkVvHFli7X3DQGfvPgRG4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 09:12:10 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:12:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/6] mtd: spi-nor: Add spansion_post_sfdp_fixups()
Thread-Topic: [PATCH 2/6] mtd: spi-nor: Add spansion_post_sfdp_fixups()
Thread-Index: AQHVR4AIVmwq4cVSO06zdYjm0Oz0Gg==
Date:   Wed, 31 Jul 2019 09:12:10 +0000
Message-ID: <20190731091145.27374-3-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 44a35977-62a9-4212-1c5a-08d715972b08
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4414;
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB4414B5E8F1D73FD3414454E1F0DF0@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(14454004)(26005)(81166006)(6116002)(50226002)(76176011)(5660300002)(66066001)(2501003)(6512007)(25786009)(486006)(102836004)(107886003)(2201001)(110136005)(305945005)(3846002)(7736002)(68736007)(53936002)(6486002)(478600001)(86362001)(71200400001)(71190400001)(186003)(476003)(256004)(8936002)(6436002)(7416002)(386003)(52116002)(54906003)(316002)(66946007)(81156014)(11346002)(2616005)(2906002)(64756008)(4326008)(446003)(99286004)(36756003)(66556008)(8676002)(66476007)(66446008)(1076003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: goMPajPWxJdlPn0k4FmEIEzG6Ta0BhXEs2kxIIbwyrBpCM/BozlJwBwLX/nGh8uKJBlFwdyrd8MIclOn9Lmuoh62djruayZrsMUutsMj/Fq3RyMxvgdyz0fbBxmSOIJ2q2CtpMPUkhXtTTSqY8FMCO5bB8ZWMRM7ScVFkLu3YZB0eIBUKCRjieA5I7ALk8IeDtHoiP15xXzGF0UDVmbxveSG+GPskgc1DjNKMyPK4FL8gd4DJdqFHS4G6echHw7rXq8y7XDmdqqYIgO6frRoQQ1HkhCG1MNs6u82Bgp5cNAI8LRdjPftRAH24MQnQ4EK/iSljwzvxCdzUxQg9QbRa61wvsxlbmwO3q8oBUjc05+CdrzrIN5JUHy1OkWkqJv9tCyjvwH+rw6M/U5I0KHrUBsjYO934lZi4tumEI65PI0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a35977-62a9-4212-1c5a-08d715972b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:12:10.3712
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

Add a spansion_post_sfdp_fixups() function to fix the erase opcode,
erase sector size and set the SNOR_F_4B_OPCODES flag.
This way, all spansion related quirks are placed in the
spansion_post_sfdp_fixups() function.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 44 +++++++++++++++++++++++++++++----------=
----
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2c2d13060427..30f9d524e72f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -737,18 +737,6 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
=20
 static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
 {
-	/* Do some manufacturer fixups first */
-	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_SPANSION:
-		/* No small sector erase for 4-byte command set */
-		nor->erase_opcode =3D SPINOR_OP_SE;
-		nor->mtd.erasesize =3D nor->info->sector_size;
-		break;
-
-	default:
-		break;
-	}
-
 	nor->read_opcode =3D spi_nor_convert_3to4_read(nor->read_opcode);
 	nor->program_opcode =3D spi_nor_convert_3to4_program(nor->program_opcode)=
;
 	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
@@ -4451,9 +4439,38 @@ static void spi_nor_default_init_params(struct spi_n=
or *nor,
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
 }
=20
+static void spansion_post_sfdp_fixups(struct spi_nor *nor)
+{
+	struct mtd_info *mtd =3D &nor->mtd;
+
+	if (mtd->size <=3D SZ_16M)
+		return;
+
+	nor->flags |=3D SNOR_F_4B_OPCODES;
+	/* No small sector erase for 4-byte command set */
+	nor->erase_opcode =3D SPINOR_OP_SE;
+	nor->mtd.erasesize =3D nor->info->sector_size;
+}
+
+static void
+spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
+				      struct spi_nor_flash_parameter *params)
+{
+	switch (JEDEC_MFR(nor->info)) {
+	case SNOR_MFR_SPANSION:
+		spansion_post_sfdp_fixups(nor);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	spi_nor_manufacturer_post_sfdp_fixups(nor, params);
+
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
 		return nor->info->fixups->post_sfdp(nor, params);
 }
@@ -4934,8 +4951,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 		nor->addr_width =3D 3;
 	}
=20
-	if (info->flags & SPI_NOR_4B_OPCODES ||
-	    (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION && mtd->size > SZ_16M))
+	if (info->flags & SPI_NOR_4B_OPCODES)
 		nor->flags |=3D SNOR_F_4B_OPCODES;
=20
 	if (nor->addr_width =3D=3D 4 && nor->flags & SNOR_F_4B_OPCODES &&
--=20
2.9.5

