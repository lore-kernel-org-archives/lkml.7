Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C050DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797D4217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lMz8xcEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfHZMIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:08:54 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:21522 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHZMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:08:42 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RSMfY9MQO3VDtCKe3jt5S7R1olWevzeZq5ehzvGRj+VyflnUrdjclfi/h8ASXpfm0M2WgW7+8c
 MwAUS8d+u0j/h/QhNTTBAeGnP+lWjALTCs8GRlqheFZ1lUBUe0OMgr1Fg22R8H/ZAGpoMSTRCT
 zzRExPxdHkDLJyqrjjn8/wJ9lbPiS1X+nkIm9DhaJnvplU/kjRCUSm6ckw4FZrjErFK001hely
 YV6nxqQhliMejvM2ADgCya7jHrn/43b1vBIPddUKV3PQpSheDrBEXRSrixzxit+v1UbweuSXo9
 5kM=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46588652"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:08:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:08:39 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSbB9CwGQbh4c0OMxHLT3QhxhjeW1MNfYaGAc0DmYoM7FUHDoJsypQxrotuJd7RzMkW1ylimFC1QhXzIENF62BrzMqH06nlYjbaZfysuDVq434sFUPr4EYRCzNtF+O1WXa/ounAs/UVlG/mWEWubxZWAR15vRsOoNIWzyB57s//saTjHPnwYQmyNxdt60SA/6ShpKNa/M7ELZw5bbVfwIIEYls3L5JneD7DmSgySMkg1tzis9hBOOWqQ9IYettljkhO+8btL3WadK9J/xPq6uvJX3vqpKMIFL1P0qviI7Md2TO5k27C3XT5r6ZZ7XWBddAnSbYqdxUFSGVMwIlGvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+uGO1wnUc7VOBpwSlQm2Jwaf7rqoSKbN4C3jVfhH9Y=;
 b=UHLiRhJXGbDBkaZXkhSZAaKxk7x0Bo/Xd+gPcxU1Q8Soiu7ZQ0kxrOzDZddvTJo9xtP0hD+73T493DuVEG/xJy9GiyUJvWrF/4B+4lipPLJym1zngdIw8llke1Wd3DvNFo8065YOUn7TCw7guWTI0JRjppvw/oaqxZJGIKfzv7R+VwMFiwNQZFvpV2H7TnN/xS8oBjRvoKZDppp63aaiy+UqAf0veE2pyV297idhIAaL9l4kwab0p8CY0DJki27CHvoYa74dvYhTRpA4TiWYSULHLeO34W98WMxdyNX/B4fvwRyMkulv8sZ5nnb/jjwMMtb0G7HDwQlSDLyRBtDJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+uGO1wnUc7VOBpwSlQm2Jwaf7rqoSKbN4C3jVfhH9Y=;
 b=lMz8xcElED3nyhKQca+mXVHs4JFgA//owHmL/1/Sl56kvh4uGcQ1QCJqN1zhb0YLFSVXFF8A3zxcgBJcc+Cy8qYE22jI+wwxN3DC/RsV+i8wEHhoWqXQUJlCImu2K6apFWVDKIO+QbRVr9kyI/y9j8+FIhOcjz/ch+BCRyXUBb4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:08:38 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:08:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 04/20] mtd: spi-nor: Move erase_map to 'struct
 spi_nor_flash_parameter'
Thread-Topic: [RESEND PATCH v3 04/20] mtd: spi-nor: Move erase_map to 'struct
 spi_nor_flash_parameter'
Thread-Index: AQHVXAb+LyfB/XPAd0GskU8GfSPs9A==
Date:   Mon, 26 Aug 2019 12:08:38 +0000
Message-ID: <20190826120821.16351-5-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:28::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd8ecd2-fe80-4032-0998-08d72a1e20a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3776;
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3776447F1121E75034F1ABD1F0A10@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(8676002)(1076003)(2201001)(2501003)(14444005)(256004)(26005)(7736002)(99286004)(66066001)(2906002)(76176011)(52116002)(316002)(186003)(50226002)(8936002)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(53936002)(2616005)(36756003)(25786009)(5660300002)(386003)(305945005)(6506007)(102836004)(3846002)(6116002)(446003)(11346002)(478600001)(4326008)(86362001)(6436002)(6486002)(6512007)(14454004)(71200400001)(71190400001)(107886003)(476003)(486006)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I9CMYJZzEjJk+q0prDdStHQEesGBIu6mO7Z1v7iTERZxlnLPej/QuWHk3BNNn2NqMcATsa4lCu+TEUn4D0TfP6CdGbSZ35mOgYNG/rNuW7+jXXzEP90YMUjB1xZxi4BisHTsNwv7HLiNXS0KKFj5/5ScvSVPuvQmfJENkNZ/XhHV/bBPU2pZqCfz7xwxF8BqUk+sQ16AajHDTfLrbapIgot/zSQeUdTuPqdaljb3rheM700M140NL0tdxrJILqfGJiRtlDQ1bUAckULvrcszxH+g66C05TQ9OJn8nlOAX+mrTcPt7zz7ha1zFzTToWNaboaSrqFKsSAsrVb1zCdoZsBJXgYW/NC0oMh0tBzaZM8GJ6/RfuihlYZ32XcQ6YkwkAHQdCNAhXF3j5InMf/zOFIohGet4lCrI+qSxuRBUTw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8ecd2-fe80-4032-0998-08d72a1e20a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:38.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNWJh5P7z/Ax1o9CiW965mcdZdeboGzTnnhf+/Lmv6s+YOVyfkWLsCBxsxS2231LKhS+ks0wsPTL/plrE8eVQDWFd+O9YAp8AAzYvysZnkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

All flash parameters and settings should reside inside
'struct spi_nor_flash_parameter'. Move the SMPT parsed erase map
from 'struct spi_nor' to 'struct spi_nor_flash_parameter'.

Please note that there is a roll-back mechanism for the flash
parameter and settings, for cases when SFDP parser fails. The SFDP
parser receives a Stack allocated copy of nor->params, called
sfdp_params, and uses it to retrieve the serial flash discoverable
parameters. JESD216 SFDP is a standard and has a higher priority
than the default initialized flash parameters, so will overwrite the
sfdp_params data when needed. All SFDP code uses the local copy of
nor->params, that will overwrite it in the end, if the parser succeds.

Saving and restoring the nor->params.erase_map is no longer needed,
since the SFDP code does not touch it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: Collect R-b

 drivers/mtd/spi-nor/spi-nor.c | 40 +++++++++++++++++++++------------------=
-
 include/linux/mtd/spi-nor.h   |  8 +++++---
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index effda372cb33..9dd6cd8cd13c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -600,7 +600,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *n=
or)
 	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
=20
 	if (!spi_nor_has_uniform_erase(nor)) {
-		struct spi_nor_erase_map *map =3D &nor->erase_map;
+		struct spi_nor_erase_map *map =3D &nor->params.erase_map;
 		struct spi_nor_erase_type *erase;
 		int i;
=20
@@ -1133,7 +1133,7 @@ static int spi_nor_init_erase_cmd_list(struct spi_nor=
 *nor,
 				       struct list_head *erase_list,
 				       u64 addr, u32 len)
 {
-	const struct spi_nor_erase_map *map =3D &nor->erase_map;
+	const struct spi_nor_erase_map *map =3D &nor->params.erase_map;
 	const struct spi_nor_erase_type *erase, *prev_erase =3D NULL;
 	struct spi_nor_erase_region *region;
 	struct spi_nor_erase_command *cmd =3D NULL;
@@ -3328,7 +3328,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *bfpt_header,
 			      struct spi_nor_flash_parameter *params)
 {
-	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_map *map =3D &params->erase_map;
 	struct spi_nor_erase_type *erase_type =3D map->erase_type;
 	struct sfdp_bfpt bfpt;
 	size_t len;
@@ -3409,7 +3409,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	 * Erase Types defined in the bfpt table.
 	 */
 	erase_mask =3D 0;
-	memset(&nor->erase_map, 0, sizeof(nor->erase_map));
+	memset(&params->erase_map, 0, sizeof(params->erase_map));
 	for (i =3D 0; i < ARRAY_SIZE(sfdp_bfpt_erases); i++) {
 		const struct sfdp_bfpt_erase *er =3D &sfdp_bfpt_erases[i];
 		u32 erasesize;
@@ -3684,14 +3684,18 @@ spi_nor_region_check_overlay(struct spi_nor_erase_r=
egion *region,
 /**
  * spi_nor_init_non_uniform_erase_map() - initialize the non-uniform erase=
 map
  * @nor:	pointer to a 'struct spi_nor'
+ * @params:     pointer to a duplicate 'struct spi_nor_flash_parameter' th=
at is
+ *              used for storing SFDP parsed data
  * @smpt:	pointer to the sector map parameter table
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
-					      const u32 *smpt)
+static int
+spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
+				   struct spi_nor_flash_parameter *params,
+				   const u32 *smpt)
 {
-	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_map *map =3D &params->erase_map;
 	struct spi_nor_erase_type *erase =3D map->erase_type;
 	struct spi_nor_erase_region *region;
 	u64 offset;
@@ -3770,6 +3774,8 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
  * spi_nor_parse_smpt() - parse Sector Map Parameter Table
  * @nor:		pointer to a 'struct spi_nor'
  * @smpt_header:	sector map parameter table header
+ * @params:		pointer to a duplicate 'struct spi_nor_flash_parameter'
+ *                      that is used for storing SFDP parsed data
  *
  * This table is optional, but when available, we parse it to identify the
  * location and size of sectors within the main data array of the flash me=
mory
@@ -3778,7 +3784,8 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_smpt(struct spi_nor *nor,
-			      const struct sfdp_parameter_header *smpt_header)
+			      const struct sfdp_parameter_header *smpt_header,
+			      struct spi_nor_flash_parameter *params)
 {
 	const u32 *sector_map;
 	u32 *smpt;
@@ -3807,11 +3814,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 		goto out;
 	}
=20
-	ret =3D spi_nor_init_non_uniform_erase_map(nor, sector_map);
+	ret =3D spi_nor_init_non_uniform_erase_map(nor, params, sector_map);
 	if (ret)
 		goto out;
=20
-	spi_nor_regions_sort_erase_types(&nor->erase_map);
+	spi_nor_regions_sort_erase_types(&params->erase_map);
 	/* fall through */
 out:
 	kfree(smpt);
@@ -3867,7 +3874,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ 0u /* not used */,		BIT(12) },
 	};
 	struct spi_nor_pp_command *params_pp =3D params->page_programs;
-	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_map *map =3D &params->erase_map;
 	struct spi_nor_erase_type *erase_type =3D map->erase_type;
 	u32 *dwords;
 	size_t len;
@@ -4097,7 +4104,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
=20
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
-			err =3D spi_nor_parse_smpt(nor, param_header);
+			err =3D spi_nor_parse_smpt(nor, param_header, params);
 			break;
=20
 		case SFDP_4BAIT_ID:
@@ -4129,7 +4136,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 static int spi_nor_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params =3D &nor->params;
-	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_map *map =3D &params->erase_map;
 	const struct flash_info *info =3D nor->info;
 	u8 i, erase_mask;
=20
@@ -4229,17 +4236,12 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
 		struct spi_nor_flash_parameter sfdp_params;
-		struct spi_nor_erase_map prev_map;
=20
 		memcpy(&sfdp_params, params, sizeof(sfdp_params));
-		memcpy(&prev_map, &nor->erase_map, sizeof(prev_map));
=20
 		if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
 			nor->addr_width =3D 0;
 			nor->flags &=3D ~SNOR_F_4B_OPCODES;
-			/* restore previous erase map */
-			memcpy(&nor->erase_map, &prev_map,
-			       sizeof(nor->erase_map));
 		} else {
 			memcpy(params, &sfdp_params, sizeof(*params));
 		}
@@ -4353,7 +4355,7 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map=
 *map,
=20
 static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
 {
-	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
 	const struct spi_nor_erase_type *erase =3D NULL;
 	struct mtd_info *mtd =3D &nor->mtd;
 	int i;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 17787238f0e9..a86c0d9fb01d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -479,6 +479,8 @@ struct spi_nor;
  *                      in the array, the higher priority.
  * @page_programs:	page program capabilities ordered by priority: the
  *                      higher index in the array, the higher priority.
+ * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
+ *                      Table.
  * @quad_enable:	enables SPI NOR quad mode.
  */
 struct spi_nor_flash_parameter {
@@ -489,6 +491,8 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
=20
+	struct spi_nor_erase_map        erase_map;
+
 	int (*quad_enable)(struct spi_nor *nor);
 };
=20
@@ -519,7 +523,6 @@ struct flash_info;
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
- * @erase_map:		the erase map of the SPI NOR
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
  * @unprepare:		[OPTIONAL] do some post work after the
@@ -562,7 +565,6 @@ struct spi_nor {
 	enum spi_nor_protocol	reg_proto;
 	bool			sst_write_second;
 	u32			flags;
-	struct spi_nor_erase_map	erase_map;
=20
 	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
 	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
@@ -610,7 +612,7 @@ spi_nor_region_mark_overlay(struct spi_nor_erase_region=
 *region)
=20
 static bool __maybe_unused spi_nor_has_uniform_erase(const struct spi_nor =
*nor)
 {
-	return !!nor->erase_map.uniform_erase_type;
+	return !!nor->params.erase_map.uniform_erase_type;
 }
=20
 static inline void spi_nor_set_flash_node(struct spi_nor *nor,
--=20
2.9.5

