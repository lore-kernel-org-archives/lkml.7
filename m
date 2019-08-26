Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99B2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jCKHxUUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfHZMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:43 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24951 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfHZMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:08 -0400
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
IronPort-SDR: sDJok/3uqsMZnne0GVUOb9XShFwVtQDJNhmqh1qkOkjh3ZLiaAAIj5KeyBCRQJye3NZr3vZ4gT
 FoXd5hJ/2G2zPDxo2WNXr0KqCoU1Qal+bj28uMNzIyC6lJr5HdX10cV07IaGcCi0LbLTCsdFh3
 8ItZ6Z4rCk4q/bHkrw54wsNsDRt7xHGU3LUynTtGI4TAiw0+D4UYkis1q+s8+mycRzkW2QO94X
 DNMu2PLpOG2GsFSfgPSRkRie+jgJTmYiMKLbnfMbqmFw9J60tkdKI1XAIrol5LmVrnknGhhU8w
 o+4=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="43686996"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeKKyKIw/O9MzFSLe3jgs7wt/Zx7/CHg3/hSih2EW9VmYnyO5kfIY6RfdNwSzlbJSznxvl3A6I8Da3FcuAI7+DvKej4rrmwjSlb+Vakv9k+PuShrTN+l02yFNJhNC9B9SBldDK6rR47MQMxCTTAH9k/MAdgRTrw1EFzQul9K9yyu5pAgtRN+pGpiaxJmOElDLt7NlHOZpT8yDt2eob06iRiJTHdTFRNZ8i/rY+ehyhBo2unXw9yon89GYQj3SwVDhpcxvIbc/bCGgOoWjocd333XYqAMTzQN3ZmZ1Eh4rSJtfsH9fP2SF2qirpUwgdvwOrxjqQ/GpJc8tTR/w11u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7rmJye5KszaQWOnckHJL0FB/ydlh5fs3DtNq501OvM=;
 b=TOPq6B5jgxmB950EYAuCt/RntBWR0TYluMsjnJvMchhK8Vqxdm3sWv8c8NY5LdmtJ0jUf5uHXm8RY4obJ3LKkng9X6U08Fxy0jZx9nXIn599CCZTe7XylUQutFZm8bXNwSPP5M6gDCzGB9cmLeSqWrb0wUdIHIVZHxp1L3/yCxJgKMB9PasnFCfoSVJmC58gSK0KBnQcwBtoAHpXWqp2fw85E+adjwM/xOkZ/cE8WyYrKemsoyuWAUlVMShijCKVg+0SpNg3AIlY5rhotc9wCgQByXkTdRnFfxoCYeXlXSJQcEoz9xYAcwGvKNRYCbsK5bkqWlMwLRkeT3OYcTsFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7rmJye5KszaQWOnckHJL0FB/ydlh5fs3DtNq501OvM=;
 b=jCKHxUUta51IY/vRuc5b8ugoGpaYY58JIcvCS3EASPsGY8r33NLx687H9NGwqO+EIJA/+tpcVv1F76j3BZjp4lMWeXVvmRm+WLn1+t9dvs1wsYDhm+eGIBqOCmoZerUmjDig6vLgRY/xfQ69QqNeKsrL8H071UD2+AwsWmgxOk0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:06 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Topic: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Index: AQHVXAcK8Rt7PKQLZkm3wHDUbT1nTg==
Date:   Mon, 26 Aug 2019 12:08:58 +0000
Message-ID: <20190826120821.16351-15-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: df336aad-c362-41f8-55fa-08d72a1e2c70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB367885082ECA983EA15E95FCF0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(30864003)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(14444005)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(52116002)(6666004)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(53946003)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8IwD/Ky3cug+zuyGXlUJg2m0r3gP+O5PSEkNWBpNN+4T0F4U/dR2j3ve+NN/ScAnXV3x7Y9Luu+t06mZeFCjnIZJWk9Y+Z1voDcoiWjxtxKmZs23aF/dVYXYDJmIbI5cURaHX1fvdiCMuT6FKYNLOIvr0Weq2GAgfM5NDecvG+KEGXiHyQWGYCW8/0XieXDDlPUjj999fbEFQyyyBEyHZ1uVPJm4Hr0VGzpq+XpplXvSPMWc7QNu7sXm169EQRcNOZxjgigxp1p+QaW4sjvnCUlKarW6VjP2EHSUNFCiU0gLoyeF4Jlq1M4FU1xKRBomAA4K1bqnuLKT20exjce09wFHSQEGoOd3KhGre4eUIAibfu0O9sFwobWBIZpIuJnuohvd56QC2318ABjcYlq9fyo/Vy6kKgFJFt2ium7I4E4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df336aad-c362-41f8-55fa-08d72a1e2c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:58.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5pIGFdjH6+8NWBp9ChuvqUGvuK6nNAf1Y2G0YIt98klqtpSWxSfY+lJ/HLi8+IcE5xYzS1rpK/Gw2TNIg/I3Vilsiv0YdyvEMynmPL+/zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

nor->params.setup() configures the SPI NOR memory. Useful for SPI NOR
flashes that have peculiarities to the SPI NOR standard, e.g.
different opcodes, specific address calculation, page size, etc.
Right now the only user will be the S3AN chips, but other
manufacturers can implement it if needed.

Move spi_nor_setup() related code in order to avoid a forward
declaration to spi_nor_default_setup().

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: collect R-b, rebase on previous commits

 drivers/mtd/spi-nor/spi-nor.c | 432 +++++++++++++++++++++-----------------=
----
 include/linux/mtd/spi-nor.h   |   5 +
 2 files changed, 226 insertions(+), 211 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b96a7066a36c..2aca56e07341 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4144,6 +4144,226 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
+static int spi_nor_select_read(struct spi_nor *nor,
+			       u32 shared_hwcaps)
+{
+	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
+	const struct spi_nor_read_command *read;
+
+	if (best_match < 0)
+		return -EINVAL;
+
+	cmd =3D spi_nor_hwcaps_read2cmd(BIT(best_match));
+	if (cmd < 0)
+		return -EINVAL;
+
+	read =3D &nor->params.reads[cmd];
+	nor->read_opcode =3D read->opcode;
+	nor->read_proto =3D read->proto;
+
+	/*
+	 * In the spi-nor framework, we don't need to make the difference
+	 * between mode clock cycles and wait state clock cycles.
+	 * Indeed, the value of the mode clock cycles is used by a QSPI
+	 * flash memory to know whether it should enter or leave its 0-4-4
+	 * (Continuous Read / XIP) mode.
+	 * eXecution In Place is out of the scope of the mtd sub-system.
+	 * Hence we choose to merge both mode and wait state clock cycles
+	 * into the so called dummy clock cycles.
+	 */
+	nor->read_dummy =3D read->num_mode_clocks + read->num_wait_states;
+	return 0;
+}
+
+static int spi_nor_select_pp(struct spi_nor *nor,
+			     u32 shared_hwcaps)
+{
+	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
+	const struct spi_nor_pp_command *pp;
+
+	if (best_match < 0)
+		return -EINVAL;
+
+	cmd =3D spi_nor_hwcaps_pp2cmd(BIT(best_match));
+	if (cmd < 0)
+		return -EINVAL;
+
+	pp =3D &nor->params.page_programs[cmd];
+	nor->program_opcode =3D pp->opcode;
+	nor->write_proto =3D pp->proto;
+	return 0;
+}
+
+/**
+ * spi_nor_select_uniform_erase() - select optimum uniform erase type
+ * @map:		the erase map of the SPI NOR
+ * @wanted_size:	the erase type size to search for. Contains the value of
+ *			info->sector_size or of the "small sector" size in case
+ *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
+ *
+ * Once the optimum uniform sector erase command is found, disable all the
+ * other.
+ *
+ * Return: pointer to erase type on success, NULL otherwise.
+ */
+static const struct spi_nor_erase_type *
+spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
+			     const u32 wanted_size)
+{
+	const struct spi_nor_erase_type *tested_erase, *erase =3D NULL;
+	int i;
+	u8 uniform_erase_type =3D map->uniform_erase_type;
+
+	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
+		if (!(uniform_erase_type & BIT(i)))
+			continue;
+
+		tested_erase =3D &map->erase_type[i];
+
+		/*
+		 * If the current erase size is the one, stop here:
+		 * we have found the right uniform Sector Erase command.
+		 */
+		if (tested_erase->size =3D=3D wanted_size) {
+			erase =3D tested_erase;
+			break;
+		}
+
+		/*
+		 * Otherwise, the current erase size is still a valid canditate.
+		 * Select the biggest valid candidate.
+		 */
+		if (!erase && tested_erase->size)
+			erase =3D tested_erase;
+			/* keep iterating to find the wanted_size */
+	}
+
+	if (!erase)
+		return NULL;
+
+	/* Disable all other Sector Erase commands. */
+	map->uniform_erase_type &=3D ~SNOR_ERASE_TYPE_MASK;
+	map->uniform_erase_type |=3D BIT(erase - map->erase_type);
+	return erase;
+}
+
+static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
+{
+	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+	const struct spi_nor_erase_type *erase =3D NULL;
+	struct mtd_info *mtd =3D &nor->mtd;
+	int i;
+
+	/*
+	 * The previous implementation handling Sector Erase commands assumed
+	 * that the SPI flash memory has an uniform layout then used only one
+	 * of the supported erase sizes for all Sector Erase commands.
+	 * So to be backward compatible, the new implementation also tries to
+	 * manage the SPI flash memory as uniform with a single erase sector
+	 * size, when possible.
+	 */
+#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
+	/* prefer "small sector" erase if possible */
+	wanted_size =3D 4096u;
+#endif
+
+	if (spi_nor_has_uniform_erase(nor)) {
+		erase =3D spi_nor_select_uniform_erase(map, wanted_size);
+		if (!erase)
+			return -EINVAL;
+		nor->erase_opcode =3D erase->opcode;
+		mtd->erasesize =3D erase->size;
+		return 0;
+	}
+
+	/*
+	 * For non-uniform SPI flash memory, set mtd->erasesize to the
+	 * maximum erase sector size. No need to set nor->erase_opcode.
+	 */
+	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
+		if (map->erase_type[i].size) {
+			erase =3D &map->erase_type[i];
+			break;
+		}
+	}
+
+	if (!erase)
+		return -EINVAL;
+
+	mtd->erasesize =3D erase->size;
+	return 0;
+}
+
+static int spi_nor_default_setup(struct spi_nor *nor,
+				 const struct spi_nor_hwcaps *hwcaps)
+{
+	struct spi_nor_flash_parameter *params =3D &nor->params;
+	u32 ignored_mask, shared_mask;
+	int err;
+
+	/*
+	 * Keep only the hardware capabilities supported by both the SPI
+	 * controller and the SPI flash memory.
+	 */
+	shared_mask =3D hwcaps->mask & params->hwcaps.mask;
+
+	if (nor->spimem) {
+		/*
+		 * When called from spi_nor_probe(), all caps are set and we
+		 * need to discard some of them based on what the SPI
+		 * controller actually supports (using spi_mem_supports_op()).
+		 */
+		spi_nor_spimem_adjust_hwcaps(nor, &shared_mask);
+	} else {
+		/*
+		 * SPI n-n-n protocols are not supported when the SPI
+		 * controller directly implements the spi_nor interface.
+		 * Yet another reason to switch to spi-mem.
+		 */
+		ignored_mask =3D SNOR_HWCAPS_X_X_X;
+		if (shared_mask & ignored_mask) {
+			dev_dbg(nor->dev,
+				"SPI n-n-n protocols are not supported.\n");
+			shared_mask &=3D ~ignored_mask;
+		}
+	}
+
+	/* Select the (Fast) Read command. */
+	err =3D spi_nor_select_read(nor, shared_mask);
+	if (err) {
+		dev_err(nor->dev,
+			"can't select read settings supported by both the SPI controller and me=
mory.\n");
+		return err;
+	}
+
+	/* Select the Page Program command. */
+	err =3D spi_nor_select_pp(nor, shared_mask);
+	if (err) {
+		dev_err(nor->dev,
+			"can't select write settings supported by both the SPI controller and m=
emory.\n");
+		return err;
+	}
+
+	/* Select the Sector Erase command. */
+	err =3D spi_nor_select_erase(nor, nor->info->sector_size);
+	if (err) {
+		dev_err(nor->dev,
+			"can't select erase settings supported by both the SPI controller and m=
emory.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int spi_nor_setup(struct spi_nor *nor,
+			 const struct spi_nor_hwcaps *hwcaps)
+{
+	if (!nor->params.setup)
+		return 0;
+
+	return nor->params.setup(nor, hwcaps);
+}
+
 static void macronix_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D macronix_quad_enable;
@@ -4229,6 +4449,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	/* Initialize legacy flash parameters and settings. */
 	params->quad_enable =3D spansion_quad_enable;
 	params->set_4byte =3D spansion_set_4byte;
+	params->setup =3D spi_nor_default_setup;
=20
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
@@ -4403,217 +4624,6 @@ static void spi_nor_init_params(struct spi_nor *nor=
)
 	spi_nor_late_init_params(nor);
 }
=20
-static int spi_nor_select_read(struct spi_nor *nor,
-			       u32 shared_hwcaps)
-{
-	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
-	const struct spi_nor_read_command *read;
-
-	if (best_match < 0)
-		return -EINVAL;
-
-	cmd =3D spi_nor_hwcaps_read2cmd(BIT(best_match));
-	if (cmd < 0)
-		return -EINVAL;
-
-	read =3D &nor->params.reads[cmd];
-	nor->read_opcode =3D read->opcode;
-	nor->read_proto =3D read->proto;
-
-	/*
-	 * In the spi-nor framework, we don't need to make the difference
-	 * between mode clock cycles and wait state clock cycles.
-	 * Indeed, the value of the mode clock cycles is used by a QSPI
-	 * flash memory to know whether it should enter or leave its 0-4-4
-	 * (Continuous Read / XIP) mode.
-	 * eXecution In Place is out of the scope of the mtd sub-system.
-	 * Hence we choose to merge both mode and wait state clock cycles
-	 * into the so called dummy clock cycles.
-	 */
-	nor->read_dummy =3D read->num_mode_clocks + read->num_wait_states;
-	return 0;
-}
-
-static int spi_nor_select_pp(struct spi_nor *nor,
-			     u32 shared_hwcaps)
-{
-	int cmd, best_match =3D fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
-	const struct spi_nor_pp_command *pp;
-
-	if (best_match < 0)
-		return -EINVAL;
-
-	cmd =3D spi_nor_hwcaps_pp2cmd(BIT(best_match));
-	if (cmd < 0)
-		return -EINVAL;
-
-	pp =3D &nor->params.page_programs[cmd];
-	nor->program_opcode =3D pp->opcode;
-	nor->write_proto =3D pp->proto;
-	return 0;
-}
-
-/**
- * spi_nor_select_uniform_erase() - select optimum uniform erase type
- * @map:		the erase map of the SPI NOR
- * @wanted_size:	the erase type size to search for. Contains the value of
- *			info->sector_size or of the "small sector" size in case
- *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
- *
- * Once the optimum uniform sector erase command is found, disable all the
- * other.
- *
- * Return: pointer to erase type on success, NULL otherwise.
- */
-static const struct spi_nor_erase_type *
-spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
-			     const u32 wanted_size)
-{
-	const struct spi_nor_erase_type *tested_erase, *erase =3D NULL;
-	int i;
-	u8 uniform_erase_type =3D map->uniform_erase_type;
-
-	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
-		if (!(uniform_erase_type & BIT(i)))
-			continue;
-
-		tested_erase =3D &map->erase_type[i];
-
-		/*
-		 * If the current erase size is the one, stop here:
-		 * we have found the right uniform Sector Erase command.
-		 */
-		if (tested_erase->size =3D=3D wanted_size) {
-			erase =3D tested_erase;
-			break;
-		}
-
-		/*
-		 * Otherwise, the current erase size is still a valid canditate.
-		 * Select the biggest valid candidate.
-		 */
-		if (!erase && tested_erase->size)
-			erase =3D tested_erase;
-			/* keep iterating to find the wanted_size */
-	}
-
-	if (!erase)
-		return NULL;
-
-	/* Disable all other Sector Erase commands. */
-	map->uniform_erase_type &=3D ~SNOR_ERASE_TYPE_MASK;
-	map->uniform_erase_type |=3D BIT(erase - map->erase_type);
-	return erase;
-}
-
-static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
-{
-	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
-	const struct spi_nor_erase_type *erase =3D NULL;
-	struct mtd_info *mtd =3D &nor->mtd;
-	int i;
-
-	/*
-	 * The previous implementation handling Sector Erase commands assumed
-	 * that the SPI flash memory has an uniform layout then used only one
-	 * of the supported erase sizes for all Sector Erase commands.
-	 * So to be backward compatible, the new implementation also tries to
-	 * manage the SPI flash memory as uniform with a single erase sector
-	 * size, when possible.
-	 */
-#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
-	/* prefer "small sector" erase if possible */
-	wanted_size =3D 4096u;
-#endif
-
-	if (spi_nor_has_uniform_erase(nor)) {
-		erase =3D spi_nor_select_uniform_erase(map, wanted_size);
-		if (!erase)
-			return -EINVAL;
-		nor->erase_opcode =3D erase->opcode;
-		mtd->erasesize =3D erase->size;
-		return 0;
-	}
-
-	/*
-	 * For non-uniform SPI flash memory, set mtd->erasesize to the
-	 * maximum erase sector size. No need to set nor->erase_opcode.
-	 */
-	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
-		if (map->erase_type[i].size) {
-			erase =3D &map->erase_type[i];
-			break;
-		}
-	}
-
-	if (!erase)
-		return -EINVAL;
-
-	mtd->erasesize =3D erase->size;
-	return 0;
-}
-
-static int spi_nor_setup(struct spi_nor *nor,
-			 const struct spi_nor_hwcaps *hwcaps)
-{
-	struct spi_nor_flash_parameter *params =3D &nor->params;
-	u32 ignored_mask, shared_mask;
-	int err;
-
-	/*
-	 * Keep only the hardware capabilities supported by both the SPI
-	 * controller and the SPI flash memory.
-	 */
-	shared_mask =3D hwcaps->mask & params->hwcaps.mask;
-
-	if (nor->spimem) {
-		/*
-		 * When called from spi_nor_probe(), all caps are set and we
-		 * need to discard some of them based on what the SPI
-		 * controller actually supports (using spi_mem_supports_op()).
-		 */
-		spi_nor_spimem_adjust_hwcaps(nor, &shared_mask);
-	} else {
-		/*
-		 * SPI n-n-n protocols are not supported when the SPI
-		 * controller directly implements the spi_nor interface.
-		 * Yet another reason to switch to spi-mem.
-		 */
-		ignored_mask =3D SNOR_HWCAPS_X_X_X;
-		if (shared_mask & ignored_mask) {
-			dev_dbg(nor->dev,
-				"SPI n-n-n protocols are not supported.\n");
-			shared_mask &=3D ~ignored_mask;
-		}
-	}
-
-	/* Select the (Fast) Read command. */
-	err =3D spi_nor_select_read(nor, shared_mask);
-	if (err) {
-		dev_err(nor->dev,
-			"can't select read settings supported by both the SPI controller and me=
mory.\n");
-		return err;
-	}
-
-	/* Select the Page Program command. */
-	err =3D spi_nor_select_pp(nor, shared_mask);
-	if (err) {
-		dev_err(nor->dev,
-			"can't select write settings supported by both the SPI controller and m=
emory.\n");
-		return err;
-	}
-
-	/* Select the Sector Erase command. */
-	err =3D spi_nor_select_erase(nor, nor->info->sector_size);
-	if (err) {
-		dev_err(nor->dev,
-			"can't select erase settings supported by both the SPI controller and m=
emory.\n");
-		return err;
-	}
-
-	return 0;
-}
-
 /**
  * spi_nor_quad_enable() - enable Quad I/O if needed.
  * @nor:                pointer to a 'struct spi_nor'
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 35aad92a4ff8..fc0b4b19c900 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -498,6 +498,10 @@ struct spi_nor_locking_ops {
  * @convert_addr:	converts an absolute address into something the flash
  *                      will understand. Particularly useful when pagesize=
 is
  *                      not a power-of-2.
+ * @setup:              configures the SPI NOR memory. Useful for SPI NOR
+ *                      flashes that have peculiarities to the SPI NOR sta=
ndard
+ *                      e.g. different opcodes, specific address calculati=
on,
+ *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
  */
 struct spi_nor_flash_parameter {
@@ -513,6 +517,7 @@ struct spi_nor_flash_parameter {
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
+	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
=20
 	const struct spi_nor_locking_ops *locking_ops;
 };
--=20
2.9.5

