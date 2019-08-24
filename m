Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55159C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1656D21874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sbDYE4wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfHXMHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:07:23 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5337 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfHXMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:07:21 -0400
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
IronPort-SDR: fM13biLARWAaRuUCu6lYI4urlhM/oz2lwQSLlEFk3+P+6Ohi9P5L0iE6BEavZwnz6Hut410TWY
 fjSjLCbSzsWtpiuGJ/MVQiMTX4EpibdJVch1ejChcQNdgxCuLV2czAQqM3SM8JvyFrZu+oN6p4
 UQZE0IFsTQSlemLw4fn2LUq9Kv2AFu7HgGW3p/N9nrDcTNRS6btAPrGPgrBQ75TDWf4Ec04mbX
 Vy6tyZkaJedfjR41SRwMWEmHLrY/3yIGdbDLRmkZ9mtQzRWvuibaB3kvdf6RTWZvZsSBwh+LOR
 EDs=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="43548190"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:07:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:07:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCLjNuVTUdL+YFeKDQKF4qynqe4ygfyIIkj3lBi4fiiX8/UCEG0LpFhRwequbRcLH/iszl/Zk2J1Nz3Qpsb7B2p36qnTU4Em9YdMeil15ypGpS+1sWWykThSAXrKKKqmiETffZwAf3175yyg3pCQa7B6AsylwCMzTKgaOXEp8JlS5d0Tf4eRF08sbnkY08ZmU2Lb826AgIjWJmC6D4/wRuw51fkbyS7P92zG1A9ZGXLja0kG4etYU0C0er0R37ZeIhaYxq9/4XQpE5OBQb//ElA3cmOPwiWoqvLjtO4xYFxultKM/HgDmu/rEUaQVBsu39dmTS94HfY5KAn1PIYMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN03e2ZX2tBYJp3MUQsvMjrmME0dhoHr9CSoIzb42r8=;
 b=IIb4pD6rwJJsAuLNkgMop78V2RZ59eUPrXLYlD6wsg285WUVV15WhHruJENAtLvw1QNNvBEILpAIoziWLBKOrCDzLr8Wo7hCFLjWmy9vapyTKw6/b3c5HTs7U3tLukMyp9DFYZQWBi3w/YQv2M0wI3uO2U2RsrZdZqUvpVE60+oodFoakAnjgxS2dO8/xTDP9tDHNVsJkGbUqfpMiQy9s9PFTFpH0SqmFaGDWjb0XazZ55iYWVO/7fTtTqStwBPS3r0prr1f/Tw4ZqwHyWggrozyXJUidAVybpBYadKoCLz9MZLv6w96tL93WKWqO16JN/4i05HSAuaw4hob92bnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN03e2ZX2tBYJp3MUQsvMjrmME0dhoHr9CSoIzb42r8=;
 b=sbDYE4wXX/RUeDEfGCHsuyGOSPXsaNjg+++Q3AowbtYJQfTMs/FzRPGoG0UjNAKDFEWlqlaJmgKJcrPTmG3wEpy99gKP0PdecO8d//JpwFLWp2/JwP1wtq1LR+BhZZaD8s9q2zOp2CBiq0OXH9MrkxLShiYjUOF2Pf+hHz2x64Q=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4301.namprd11.prod.outlook.com (52.135.36.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:07:11 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:07:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/6] mtd: spi-nor: Add spansion_post_sfdp_fixups()
Thread-Topic: [PATCH v2 2/6] mtd: spi-nor: Add spansion_post_sfdp_fixups()
Thread-Index: AQHVWnR1RnJ5JLuKx0KhRn2osCuprA==
Date:   Sat, 24 Aug 2019 12:07:11 +0000
Message-ID: <20190824120650.14752-3-tudor.ambarus@microchip.com>
References: <20190824120650.14752-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824120650.14752-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c9335d-88b0-431a-6581-08d7288b9807
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4301;
x-ms-traffictypediagnostic: MN2PR11MB4301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43012440F15A69F2B9127C3FF0A70@MN2PR11MB4301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(305945005)(99286004)(71190400001)(1076003)(71200400001)(7736002)(3846002)(6116002)(2501003)(52116002)(76176011)(4326008)(478600001)(2906002)(316002)(14454004)(53936002)(25786009)(110136005)(54906003)(107886003)(5660300002)(386003)(102836004)(6506007)(6436002)(8676002)(186003)(66946007)(26005)(50226002)(6486002)(36756003)(8936002)(66556008)(64756008)(66446008)(66476007)(486006)(476003)(2616005)(6512007)(446003)(81166006)(81156014)(11346002)(2201001)(86362001)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4301;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4U3jf+BRFII1jAa/luZJ8ca68kvydH3d6Qf+514YM/dl8SPREGc6iCtSMznQLCyjgBDkk/kiCwEDkeQjiZVbkUm6DSn4V6UxvhnMmIB+75ojwz30KaJJJs3l7WBLxvIPFGZDMgTQLp3y1xukgkM1yMa0HlKfSkTusq+SkR09CMdq0hve5i4zPS0liecgcX+QZUSKitNRl5GUFLVYbcSlaI+t0lDoHIoi3YxIEQYTX8zlPMhsTZqBVsX4pcDTXQJurI3+n3HQYXeJL7gTUx9BUaRu2bc1zJrF6k9GwsLqsQwN7sv5jR1VjkBulxlQYkDgZOBcXdMiNpEHw5C5UYyWJ2sowWlzmh4QdvD2vnUeamWzNz4MxQqvCFWn3vQ9c0vAvvzI1seaUbZevTFrlKCckz1JaxlHkH8lc6H8ZYq1ZrE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c9335d-88b0-431a-6581-08d7288b9807
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:07:11.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4yODxevp8osvtATK+bAJWqKbzce9eHflZaGWQUAs2A3GSSFun9SEjyHEgQUjpWmcmjalQj3P869B4XAZ6qXVQJaFQAE8psNodT26MNRuLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
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
 drivers/mtd/spi-nor/spi-nor.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 41dc95415260..bd31d6529892 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -591,18 +591,6 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
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
@@ -4322,6 +4310,19 @@ static void spi_nor_legacy_init_params(struct spi_no=
r *nor)
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
 /**
  * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and setting=
s
  * after SFDP has been parsed (is also called for SPI NORs that do not
@@ -4334,6 +4335,15 @@ static void spi_nor_legacy_init_params(struct spi_no=
r *nor)
  */
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
 {
+	switch (JEDEC_MFR(nor->info)) {
+	case SNOR_MFR_SPANSION:
+		spansion_post_sfdp_fixups(nor);
+		break;
+
+	default:
+		break;
+	}
+
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
 		nor->info->fixups->post_sfdp(nor);
 }
@@ -4895,8 +4905,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
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

