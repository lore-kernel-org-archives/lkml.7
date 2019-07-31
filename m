Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06540C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E8208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="GMqzotJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfGaJDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:03:37 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61131 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:03:34 -0400
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
IronPort-SDR: 2wbh8+NMPDqrGRN5JIQuQHGm/tAbhnipa2pQnwg8wL4FvchMECP2sUHOrIAEmYSmu+NmbedH52
 Mzn06pU+5RkhzKcvQXagf4nAGN0v/3w3AMtqrBctiJgmqEfWWUiTHvVPHhZzV9Q9ci9bxMvASo
 mmXaBTVoSlPuNwzBPpnnmD4o7czkWwzehponRwHcn3lESHs/ylOtWVJ5qFgH/GSB6FYftsrswu
 tRqGRIPQM5TUSBvtkNt5Frke45ew1HaZeP31RzECILKnH6wAjJEIYfXs/nBVzXEVoyFi0ifvTw
 AF0=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41823063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:03:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:03:32 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCL6+QkMPuTvweOFf5hQKdYvU+SC0NH1H973U475t6SRBbnF+rexVP2dMKY+6CcHwq5M/gV7xvcKpxAMZoS+qUKiFCg9VELMM0fI5PNGpP7isuGcG1rut9ZaW2mCbD9k7r7anScagc+yRnIdNxZedwXGY2MUkZlT65K0oHHQ7XXqBHB3ifKRH96W3Pnt7oCmJcEFKdZrV2mp358Tur2TA1bV/GV/IGEYyq59kkBgTu+uoQ8iv9CJ13J5l+75y5xH+Mciwrxg2LwMjtHEOV7D+555+SChTWxRwkumVBaSButHbAvZTsixVTGS3DAbBZqeBQiMewjOAXUVvbKXNaeiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJsakh3CadbqWwAgxWJiCc4UaJ+bQnKa07TCaRt3mSQ=;
 b=ST1NFXv8WjZE+lCcZ7f0yBsTbRLiI2SIyFkjGXq9hZq+iWm5Oiqfyri1IZbelGRpaEt1cXHabjA22AqN3aDYATCiicjpASVUCZW8BwDgy1nyJ6JyHSOzrEBv8OJpKwq81CF5N03eNetM3JROv2DkSKt6inl6WXdqZ49KJq1VL7su00UEYp0gHCJllV4/yk56aIZ6L8WoZbzebHuOZtnR6ouYSgS6kq15MdwbW91V1sQk2hRmZJ/BKe6eikUPAIXSfvvKGrvvbi6y69pUwpI9+wLj6OhpELspudCtJY8Sn8DA/P2gXFbRxhxb4aHIhMDcD3cvubN8WEs02swntMG8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJsakh3CadbqWwAgxWJiCc4UaJ+bQnKa07TCaRt3mSQ=;
 b=GMqzotJlcmrMit7r0zDGtZc6gE4ebqxdc4DsedMvMhyUfGVdbVYuuw9tKLNkrK7RvRqm5h2alyI0Ngr3VMQXY8pDjMhdU8Nn+P6VekKU7i1El8iP/LuVhxY38PXOJpz3uN3Btc6VPqt+qRMhf+zHjTCZY1Y9xRwlQwSFeZJydDg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2SPR01MB0050.namprd11.prod.outlook.com (10.255.239.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 09:03:31 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:03:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 3/7] mtd: spi_nor: Rework quad_enable()
Thread-Topic: [PATCH 3/7] mtd: spi_nor: Rework quad_enable()
Thread-Index: AQHVR37TzKxNRrn8H0elIoBO1LpPuw==
Date:   Wed, 31 Jul 2019 09:03:31 +0000
Message-ID: <20190731090315.26798-4-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 77819efe-e257-460a-cf3d-08d71595f5a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2SPR01MB0050;
x-ms-traffictypediagnostic: MN2SPR01MB0050:
x-microsoft-antispam-prvs: <MN2SPR01MB0050F2B385EE60145B00C297F0DF0@MN2SPR01MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(50226002)(53936002)(36756003)(54906003)(305945005)(8676002)(81166006)(107886003)(2906002)(81156014)(6436002)(316002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(6486002)(68736007)(8936002)(6512007)(86362001)(5660300002)(25786009)(1076003)(110136005)(7736002)(186003)(4326008)(11346002)(446003)(102836004)(386003)(6506007)(256004)(2616005)(476003)(52116002)(99286004)(76176011)(478600001)(2501003)(66066001)(14454004)(14444005)(486006)(71190400001)(71200400001)(2201001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0050;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j97/i4OvYcafbIj8YablP/22Yday7zjJeFM1CdE8iiE5NlAsB/iE/qzqB1Pgrl/kRjuPZXY6Ye6fkH/c1Q6QJhVPdR7yNbVAi934fs0tLDenz76xwlLwrqMad2ZnENEqVOVzsyKTCJNTVY1GmYOFAYS2yUfho2giuc0dut7ab5alPNX6kdeIe+Gw44uDEc2vm4Yy6Au3N5vnyIkuK9CRxDgeEc0+YLVigT02/3Awy3wDT0H2J7xdG1abi7L9GNRk4Dm9beB57ucfZfm0s1yL+6gPvr8Tbci1sirGGmpoj2bx0ZOK4uLvM128RniQv3KJzdagFfZn3LeqFr1BYTGpRAlR2KyP73OtM0MbvyTchVoU0amEHFJ5qbKqW29MGkPgEKofNGnQJvvB9lcyU7e7Zx7LQqAryflxKnbDXMn8SAw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77819efe-e257-460a-cf3d-08d71595f5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:03:31.3852
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

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The goal is to move the quad_enable manufacturer specific init in the
nor->manufacturer->fixups->default_init()

The legacy/core quad_enable() implementation is spansion_quad_enable(),
select this method by default.

Set specific manufacturer fixups->default_init() hooks to overwrite
the default quad_enable() implementation when needed.

Get rid of the spi_nor_flash_parameter int (*quad_enable)() pointer to
function, as we always choose to overwrite the nor->quad_enable,
if needed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 103 +++++++++++++++++++++++---------------=
----
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 94aba5ce1462..a906c36260c8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -101,8 +101,6 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
-
-	int (*quad_enable)(struct spi_nor *nor);
 };
=20
 struct sfdp_parameter_header {
@@ -2275,7 +2273,7 @@ static void gd25q256_default_init(struct spi_nor *nor=
,
 	 * indicate the quad_enable method for this case, we need
 	 * set it in the default_init fixup hook.
 	 */
-	params->quad_enable =3D macronix_quad_enable;
+	nor->quad_enable =3D macronix_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
@@ -3618,24 +3616,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Quad Enable Requirements. */
 	switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
 	case BFPT_DWORD15_QER_NONE:
-		params->quad_enable =3D NULL;
+		nor->quad_enable =3D NULL;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
-		params->quad_enable =3D spansion_no_read_cr_quad_enable;
+		nor->quad_enable =3D spansion_no_read_cr_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
-		params->quad_enable =3D macronix_quad_enable;
+		nor->quad_enable =3D macronix_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
-		params->quad_enable =3D sr2_bit7_quad_enable;
+		nor->quad_enable =3D sr2_bit7_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1:
-		params->quad_enable =3D spansion_read_cr_quad_enable;
+		nor->quad_enable =3D spansion_read_cr_quad_enable;
 		break;
=20
 	default:
@@ -4286,10 +4284,41 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
+static void macronix_set_default_init(struct spi_nor *nor)
+{
+	nor->quad_enable =3D macronix_quad_enable;
+}
+
+static void st_micron_set_default_init(struct spi_nor *nor)
+{
+	nor->quad_enable =3D NULL;
+}
+
+static void spi_nor_mfr_init_params(struct spi_nor *nor,
+				    struct spi_nor_flash_parameter *params)
+{
+	switch (JEDEC_MFR(nor->info)) {
+	case SNOR_MFR_MACRONIX:
+		macronix_set_default_init(nor);
+		break;
+
+	case SNOR_MFR_ST:
+	case SNOR_MFR_MICRON:
+		st_micron_set_default_init(nor);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static void
 spi_nor_manufacturer_init_params(struct spi_nor *nor,
 				 struct spi_nor_flash_parameter *params)
 {
+	/* Init flash parameters based on MFR */
+	spi_nor_mfr_init_params(nor, params);
+
 	if (nor->info->fixups && nor->info->fixups->default_init)
 		return nor->info->fixups->default_init(nor, params);
 }
@@ -4369,25 +4398,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
=20
-	/* Select the procedure to set the Quad Enable bit. */
-	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
-				   SNOR_HWCAPS_PP_QUAD)) {
-		switch (JEDEC_MFR(info)) {
-		case SNOR_MFR_MACRONIX:
-			params->quad_enable =3D macronix_quad_enable;
-			break;
-
-		case SNOR_MFR_ST:
-		case SNOR_MFR_MICRON:
-			break;
-
-		default:
-			/* Kept only for backward compatibility purpose. */
-			params->quad_enable =3D spansion_quad_enable;
-			break;
-		}
-	}
-
 	spi_nor_manufacturer_init_params(nor, params);
=20
 	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
@@ -4569,7 +4579,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 			 const struct spi_nor_hwcaps *hwcaps)
 {
 	u32 ignored_mask, shared_mask;
-	bool enable_quad_io;
 	int err;
=20
 	/*
@@ -4617,21 +4626,23 @@ static int spi_nor_setup(struct spi_nor *nor,
=20
 	/* Select the Sector Erase command. */
 	err =3D spi_nor_select_erase(nor, nor->info->sector_size);
-	if (err) {
+	if (err)
 		dev_err(nor->dev,
 			"can't select erase settings supported by both the SPI controller and m=
emory.\n");
-		return err;
-	}
=20
-	/* Enable Quad I/O if needed. */
-	enable_quad_io =3D (spi_nor_get_protocol_width(nor->read_proto) =3D=3D 4 =
||
-			  spi_nor_get_protocol_width(nor->write_proto) =3D=3D 4);
-	if (enable_quad_io && params->quad_enable)
-		nor->quad_enable =3D params->quad_enable;
-	else
-		nor->quad_enable =3D NULL;
+	return err;
+}
=20
-	return 0;
+static int spi_nor_quad_enable(struct spi_nor *nor)
+{
+	if (!nor->quad_enable)
+		return 0;
+
+	if (!(spi_nor_get_protocol_width(nor->read_proto) =3D=3D 4 ||
+	      spi_nor_get_protocol_width(nor->write_proto) =3D=3D 4))
+		return 0;
+
+	return nor->quad_enable(nor);
 }
=20
 static int spi_nor_init(struct spi_nor *nor)
@@ -4650,12 +4661,10 @@ static int spi_nor_init(struct spi_nor *nor)
 		}
 	}
=20
-	if (nor->quad_enable) {
-		err =3D nor->quad_enable(nor);
-		if (err) {
-			dev_err(nor->dev, "quad mode not supported\n");
-			return err;
-		}
+	err =3D spi_nor_quad_enable(nor);
+	if (err) {
+		dev_err(nor->dev, "quad mode not supported\n");
+		return err;
 	}
=20
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
@@ -4782,6 +4791,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	    nor->info->flags & SPI_NOR_HAS_LOCK)
 		nor->clear_sr_bp =3D spi_nor_clear_sr_bp;
=20
+	/* Kept only for backward compatibility purpose. */
+	nor->quad_enable =3D spansion_quad_enable;
+
 	/* Parse the Serial Flash Discoverable Parameters table. */
 	ret =3D spi_nor_init_params(nor, &params);
 	if (ret)
@@ -4858,7 +4870,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	 * - select op codes for (Fast) Read, Page Program and Sector Erase.
 	 * - set the number of dummy cycles (mode cycles + wait states).
 	 * - set the SPI protocols for register and memory accesses.
-	 * - set the Quad Enable bit if needed (required by SPI x-y-4 protos).
 	 */
 	ret =3D spi_nor_setup(nor, &params, hwcaps);
 	if (ret)
--=20
2.9.5

