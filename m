Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB515C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7D22184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="V0CCKfaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfHZMIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:08:43 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:21522 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbfHZMIm (ORCPT
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
IronPort-SDR: 4iuDsoMwAHW5V1FMMDQnp/g6KPy6xqRhZQSps6TOR4sQiH+eVP+YZkPjnqEjc1qkS1UGdIdfC/
 nCarbZ50lCUaD9DVKnfaJLfVUzLAlA39+gadHfW8zG77aTFWC66qHBclFvJKUjERWolAgQX/ye
 Pn5ikpmZkxPw1Wr45zAa012ncBr1FT1bLKeqSav1M7IvKTVn9XL3KI/XwJjeoQ0iH4DfJbrMAS
 pVV/e+/IvECYmZA2hMxiy5WyfhJZq7hIl0UfygRjF0C8jOXzMB2QSfvraND5SBNfPVrEvmSpoG
 kno=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46588662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:08:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:08:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 05:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3ero/EGkIU1OqP/TFUYuRDpXnmMYnMD2L9RIoX3Z+vSzvuoB/QFm2UV6q5u+15Y6fvMy2exs4lPShYCw+NAmtt27yGdSvkdM2mcTotnz5rny0KkmenpmTjZde1M6gA1qiMP3UDRtVXki8hXFWh5EsTt2lRE2VQSD82w6bRzJdaIirhUJQxXNKs3cxJN4tfKs2ry6Ye/t7JdjcT7nSEfsaK7Aqc8WNzLbvzuzqd7MI4/paihdq5Ajr3ZTVri1OdQSLkrHZITnyPQQI85Se/oYBWxYgio++7ETOn89afc6suI02zJWt/1I+YPVq0BK92yKq+DIj8IAb9//MLZan8xBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwKSHrY1sL5NFIU0YsLoNrhAdYjjSkmwTlWfEaXcz98=;
 b=bL6Ch0ZfRFnG+KARjul2QvNIjsyYcVGTq3ubMkRZmyNzpe8fXZzUQLgnMiwDfyKcm9Pz1gO3GWPYCBykCUTrYQB6E2AS5BpVOArLAAWuyP5E/V8O1pSX+iR7MK3dItI41ukjYktfZJOZu6L32kXQlMPrijhPKrvroWkealaB2mTi3m9htuWD2SSpXyBHkJ6tHsrpQQ60Gphk9vts9fqltDR1Qk3e8t8HhQXevAS/z6/I9uUOyBwrj/RTdls1sZgwUCJtL5WjanSxVLG1WKhwmEnN27TjMh9Z9Zc0Vc8Z9ygig/amHjj5qNNDnIKAwQTWhqyCrcgKjNaV5x39iyrE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwKSHrY1sL5NFIU0YsLoNrhAdYjjSkmwTlWfEaXcz98=;
 b=V0CCKfajpDWf6jYEsOeQgI3swLv8gZlk0YyBQbuSNKEW15VlaNGDGnOooJ+l+BjrBBqIfqSbP6NxHsZVOazWms1Wzq6VH+U7ud9Jen83JX6FTgegtluINLMg32OB72NF1g4FxYRWDuQ4oDxJre0aWq250Q6vcvi5ruWK4X9qvcw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:08:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:08:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 05/20] mtd: spi-nor: Add default_init() hook to
 tweak flash parameters
Thread-Topic: [RESEND PATCH v3 05/20] mtd: spi-nor: Add default_init() hook to
 tweak flash parameters
Thread-Index: AQHVXAb/LlGxn5ixREWid4Y05AigaA==
Date:   Mon, 26 Aug 2019 12:08:40 +0000
Message-ID: <20190826120821.16351-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3996191c-cce0-4e42-9f61-08d72a1e21b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3776;
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37764AE1BA01326AA525FB12F0A10@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(8676002)(1076003)(2201001)(2501003)(256004)(26005)(7736002)(99286004)(66066001)(2906002)(76176011)(52116002)(316002)(186003)(50226002)(8936002)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(53936002)(2616005)(36756003)(25786009)(5660300002)(386003)(305945005)(6506007)(102836004)(3846002)(6116002)(446003)(11346002)(478600001)(4326008)(86362001)(6436002)(6486002)(6512007)(14454004)(71200400001)(71190400001)(107886003)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O549OfiRIUjjwCuH3lt0MB+oeJeAC+FQqb9OWfw47Qls+a+W5ljY5PgX/bMS4LGLPuVQGbuR/5dhsaKyJpmRvZAZkFBuQPlQym9mxEt9D0yJeR3ytmHf+VaMPlxMXHglNjMICFHfLVTeEz8XQnMGmW2s7ugr4kMiExFPdol20EgjF/U8veQmTWCN95MK/G1DPuBuhXoOBquKqnUJ5rs/PR2SEqJSy1cloyQiNEIWxsU6f57vZV8gWWfggclLfZtPMB7zLECFnb23C25Ygv7jvsJaxRH7wDnGH4D/batVRYtfte2x4q3XLr83mLg/fgzVbPMTpSxXPoCREx5UrL89mMH7ZEtAktetQ/h3Ct/Vx1wRZRvOlDwZCClcU0tQ9hvHuT4vB+YHKcimXq0V2qXhXMBOraEMIozOlYqMHCTlL5A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3996191c-cce0-4e42-9f61-08d72a1e21b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:40.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leMllG/GNTFP/sS8u4RehwV1KAhRBqBWI6WjDJJ5iQiVXTp5AKUDzNHHYyH7WsKguiv+wOS3v8p54eMJcqmoRfxYoq5hQDDP5zV0NwkpAD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

As of now, the flash parameters initialization logic is as following:

a/ default flash parameters init in spi_nor_init_params()
b/ manufacturer specific flash parameters updates, split across entire
   spi-nor core code
c/ flash parameters updates based on SFDP tables
d/ post BFPT flash parameter updates

In the quest of removing the manufacturer specific code from the spi-nor
core, we want to impose a timeline/priority on how the flash parameters
are updated. The following sequence of calls is pursued:

1/ spi-nor core parameters init based on 'flash_info' struct:
	spi_nor_info_init_params()

which can be overwritten by:
2/ MFR-based manufacturer flash parameters init:
	nor->manufacturer->fixups->default_init()

which can be overwritten by:
3/ specific flash_info tweeks done when decisions can not be done just on
   MFR:
	nor->info->fixups->default_init()

which can be overwritten by:
4/ SFDP tables flash parameters init - SFDP knows better:
	spi_nor_sfdp_init_params()

which can be overwritten by:
5/ post SFDP tables flash parameters updates - in case manufacturers get
   the serial flash tables wrong or incomplete.
	nor->info->fixups->post_sfdp()
   The later can be extended to nor->manufacturer->fixups->post_sfdp() if
   needed.

This patch opens doors for steps 2/ and 3/.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: reword description

 drivers/mtd/spi-nor/spi-nor.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9dd6cd8cd13c..8fd60e1eebd2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -154,12 +154,16 @@ struct sfdp_bfpt {
=20
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
+ * @default_init: called after default flash parameters init. Used to twea=
k
+ *                flash parameters when information provided by the flash_=
info
+ *                table is incomplete or wrong.
  * @post_bfpt: called after the BFPT table has been parsed
  *
  * Those hooks can be used to tweak the SPI NOR configuration when the SFD=
P
  * table is broken or not available.
  */
 struct spi_nor_fixups {
+	void (*default_init)(struct spi_nor *nor);
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
@@ -4133,6 +4137,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
+/**
+ * spi_nor_manufacturer_init_params() - Initialize the flash's parameters =
and
+ * settings based on ->default_init() hook.
+ * @nor:	pointer to a 'struct spi-nor'.
+ */
+static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
+{
+	if (nor->info->fixups && nor->info->fixups->default_init)
+		nor->info->fixups->default_init(nor);
+}
+
 static int spi_nor_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params =3D &nor->params;
@@ -4233,6 +4248,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
 			params->quad_enable =3D info->quad_enable;
 	}
=20
+	spi_nor_manufacturer_init_params(nor);
+
 	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
 		struct spi_nor_flash_parameter sfdp_params;
--=20
2.9.5

