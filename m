Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24921C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FE82186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Spbtx3Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfHZL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:59:01 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:20359 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfHZL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:56 -0400
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
IronPort-SDR: uP8DUU414FrCclpsF8Wd7F75R/lcQYDBzlkmzS66D33QtBBS1yxQKfO+WN5ZG1bNSJEzsheGTC
 WCXS5NGBNvIFZkyXQviEeyeBn205+1TRdPrrLTXzURmjj8DDIoJ8cN+lrvctNrg5q8oX38eKhL
 1dfLsMOsxTNnyJlyJtdf5wCw6Z+TgHSNIwlSmO/+FGbR4bTx6Td7PlYEOAWoWFZBIMYWfMJuFG
 78INsSnMwMH/A5aXL9m5CRgZWpsMRoj473iSj7iaIBOmyCPIj9T6JrMmPPAhKwo6/WFsKdDDBn
 g6w=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46586545"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:54 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 04:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFD5EK8aqOG4rvIqegdvHP8xQZlumuVqKU7BPCaaOlaKaH1hj2Cjw5j0qSMmsS2nf322NNgB2GwVHEwOx3jXXiBw485NHXoy0zw81bLvcgZlyxsslehYfBRMV59CFNXwW1iVkFY8bHznPW9AIlMtxuqUC9IPOFr8v/tAM8zCMnI3Q9wHOngx20E5rWVThd+WxbG9l8SR1HBBA1vQgUJikj0pwNJ3tYfmfJkD/tcq9KflddnXwJrLa1fHftM/jNA/8NKa1Pt3hGLh9sMP1SaUd5SlO7TS9q2OxAzv8o7vVBQ029UE5oHe3H5EexEpf3x8MRUel1aTFaFoX6wh9Bw5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31wWWhbWl8hBRHBnpLkx7R3DQXQ7fzcZ+VuDBHkNBEQ=;
 b=m6/fv0OqOZ9yM9O680A/ggleniiab53BiVRkGQe+1FvAtTcpvCvnq4ppDH/SC7/v16a36OKm1tlpPgAYqvYBrq0c4T0OxRXgIp3s+TFfpTOvC0aiVtu02IVltJZzNrig+9ceiSxwV2VmIQkVSOeNbxGw1Lo/uwAwhRV2O4+AXQaHOKQn4dNAAvrejUGtUhdVZE6H2XbaJD5KDoUo2HHEAnRsPnKsV+tEYqRBkAaXJ+gFa7nGpMZ2k90UM6u/avueHJBqilpLgegxlPRpTock6G23C7332be8q0ezY9G4KefFGVh+4iDoFJD5vVLGupePbTilBd36AFG1iyhKGenzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31wWWhbWl8hBRHBnpLkx7R3DQXQ7fzcZ+VuDBHkNBEQ=;
 b=Spbtx3Aq1z+Mf+G6AzZEaw/BuJRlOkh2V1nsdlIB7yMS/szMTxR7tdY8o2aQD4Fjmy9htp9Jp1ivh4wEmWeXV58qs0Ktmtrg6OtukuU7Qp+/z26a6zS6cEzEaD2MHQYXXTU36q0BFgt+P8YOk3ejGcEBiMBN5qP4nNcM9JFtohw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:53 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 06/20] mtd: spi-nor: Add a default_init() fixup hook for
 gd25q256
Thread-Topic: [PATCH v3 06/20] mtd: spi-nor: Add a default_init() fixup hook
 for gd25q256
Thread-Index: AQHVXAWhygtCPBn5zk+oUG7sq31LIA==
Date:   Mon, 26 Aug 2019 11:58:53 +0000
Message-ID: <20190826115833.14913-7-tudor.ambarus@microchip.com>
References: <20190826115833.14913-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826115833.14913-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 217102fe-1c12-4611-d551-08d72a1cc3d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB435090C06E327AF4E39A064CF0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(14444005)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(76176011)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(446003)(11346002)(14454004)(2906002)(110136005)(2201001)(54906003)(316002)(26005)(102836004)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J+7G2x1ARq4TnxJ7WNbXdeMg3WmmqHsbSv8r/VTrds8k8v+Tztw8NkCjnbvDSkzeCkyjjXfREb0vH7OhykE6lP1LSujb2xVxUV8vQv6xY9nFCFvvJanrxNpgm9MV14B+9of4KiK2raX9IwuxE3QBLVUN0TeGwo5sQBt4QYIyVwNx79oePoMltXetg7ukCFmWPRemo3K1ltZ5oBIPiKqqIt5SBE0eLM6mrDv6zzwXcedTXPCirS18Q1YevfmevViTIMe0rdBQP+6NmAWvYhNae52mLkCJ8/tmF1KXxwAiI9OPHCuiGjEBetqHlJwF2iWmwgCd2T6yrAtsvF/vvntO8KANObAEV2cwzrGNrryv318ZRcPXr4h9WccAq7JGuwz4bjo2L9PLnCmyojUf76kN9a+R+MXuh5F1fNYv7rUTSgA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 217102fe-1c12-4611-d551-08d72a1cc3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:53.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGp5jxPkrJzGo2kJ/cBFRZxkwLLWO2G+VYSMz5iQtYKfdPb7BAbeqJ4OqrvzAblRfAnGBFPRITiKYwjygZV0H8bfdLLDLooBDZvTDDBka3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

gd25q256 needs to tweak the ->quad_enable() implementation and the
->default_init() fixup hook is the perfect place to do that. This way,
if we ever need to tweak more things for this flash, we won't have to
add new fields in flash_info.

We can get rid of the flash_info->quad_enable field as gd25q256 was
the only user.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[tudor.ambarus@microchip.com: use ->default_init() hook instead of
->post_sfdp()]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: no changes

 drivers/mtd/spi-nor/spi-nor.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8fd60e1eebd2..3dbbfe34d1d2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -222,8 +222,6 @@ struct flash_info {
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
-
-	int	(*quad_enable)(struct spi_nor *nor);
 };
=20
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -2126,6 +2124,21 @@ static struct spi_nor_fixups mx25l25635_fixups =3D {
 	.post_bfpt =3D mx25l25635_post_bfpt_fixups,
 };
=20
+static void gd25q256_default_init(struct spi_nor *nor)
+{
+	/*
+	 * Some manufacturer like GigaDevice may use different
+	 * bit to set QE on different memories, so the MFR can't
+	 * indicate the quad_enable method for this case, we need
+	 * to set it in the default_init fixup hook.
+	 */
+	nor->params.quad_enable =3D macronix_quad_enable;
+}
+
+static struct spi_nor_fixups gd25q256_fixups =3D {
+	.default_init =3D gd25q256_default_init,
+};
+
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
@@ -2218,7 +2231,7 @@ static const struct flash_info spi_nor_ids[] =3D {
 		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-			.quad_enable =3D macronix_quad_enable,
+			.fixups =3D &gd25q256_fixups,
 	},
=20
 	/* Intel/Numonyx -- xxxs33b */
@@ -4237,15 +4250,6 @@ static int spi_nor_init_params(struct spi_nor *nor)
 			params->quad_enable =3D spansion_quad_enable;
 			break;
 		}
-
-		/*
-		 * Some manufacturer like GigaDevice may use different
-		 * bit to set QE on different memories, so the MFR can't
-		 * indicate the quad_enable method for this case, we need
-		 * set it in flash info list.
-		 */
-		if (info->quad_enable)
-			params->quad_enable =3D info->quad_enable;
 	}
=20
 	spi_nor_manufacturer_init_params(nor);
--=20
2.9.5

