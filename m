Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB3C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E75120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ojdG4ITi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfGaJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:03:32 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61131 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:03:31 -0400
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
IronPort-SDR: QegnquWj1lBJyeuOHK45F2UOpBYZsvZe1JxKrk3tFnR3NMg7bzTR6yysuQbveHoSkggVgafKqN
 wIFAzgULnfgptpgt4QPkrcu18+6wIxWd6Ifq3ws1uOQtLfCDjo+sgBBt3KtRq1VhAtY78/rmdf
 lNpbspOz/KwNDimoxPVd/NQ9JsewTxbRUk3POePcYvwdZBkat5TJnp2lllgFxEWsBDi2qb8RIP
 5UtGxXbT0KCwtKAIbJsqzU9CevgWdWIxBp+y/pVF+G7KZ9svBfIbm5QDlA78yqo3tTrFxETda/
 oIM=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="41823048"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:03:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:03:28 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ2rDfFjm/FSt/2VhagkOHekuuMCIW9PtjV5EmN0qOJRUdQMgntVT6t30wLDOF3yATfIf9WlragAJ3R5+crQKqepDCfiTnLi4KpWwkTseDs54BXQsHOAuhymdt/eX0vd/pjs/EXLUITP4lhQg+LOelgcAkRql5NtjDPN77L4f+pfkn4dk7b4JbTEpeHCjtRv2aocAHHm0tmn7cxhNN+HX4ILiKoBZeJrnD5GxEQbKMWPKPdlcTUg0QEG6oLt4h17L271VE58idKJxWfPLi5SO47ta5XEWaCsDHqd01jG/QZtoC3219h+MqVAJXmsQS5HsPrDzn+kM1fJywbuDBzoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shk7mTPLAIKzeDt+kvfUgbyT9Xkn4EQEtH453ue+R44=;
 b=AQdm5vUu1S9Tvx6Sp4rcx+zyTbGvGPhBDw1dnHetEB2djiv4GaoH69UI88VkLsCUvFpLelQ64G2KgfC0w+uTudgFbOEtSvoQDnluFRMpYenTPfhC8QtISAdWyIB6VzwDD3YCD8Pd/TwlLcVBz6GcsTVdZZiZn6swdsMR/srzXbcQMdFSD1E3zf7FnvErpG1+GdYwEEcq6/Rw3YrgPAUSptC4gM+XkLfL99iVR1QEOL2EdozLSVj3x5VE4Q9NrOcrLD6VcxxOeBg1z0ZG2FIithvYc2XnO/9X0YPYQFNNBzjYrpnVnt1e6ohioFtpdFpd6KFANh+v5wuQGdoYKi1glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shk7mTPLAIKzeDt+kvfUgbyT9Xkn4EQEtH453ue+R44=;
 b=ojdG4ITi042bbJ3GmdT2rSg6FX/NsBSbBDvsjHJxvNgaIuuc/vaJD5K9DcwqS+nOTLlabOzWQMdVPMvHU6/054GJHSk9Ti1NN2aXpDvmfWE8CtS7+qEJkhU9Nj2bVQr6lP2G/01z6ji8vhOuUL9bMXLd11Eg7LEwXZ/OeFvH1Mo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2SPR01MB0050.namprd11.prod.outlook.com (10.255.239.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 09:03:27 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:03:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/7] mtd: spi-nor: Add default_init() hook to tweak flash
 parameters
Thread-Topic: [PATCH 1/7] mtd: spi-nor: Add default_init() hook to tweak flash
 parameters
Thread-Index: AQHVR37QnctowS0O+U25R2UnwE0NUA==
Date:   Wed, 31 Jul 2019 09:03:27 +0000
Message-ID: <20190731090315.26798-2-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 597d8b42-3170-45ff-de10-08d71595f33d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2SPR01MB0050;
x-ms-traffictypediagnostic: MN2SPR01MB0050:
x-microsoft-antispam-prvs: <MN2SPR01MB0050663B1EECF4ECC2262A82F0DF0@MN2SPR01MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(50226002)(53936002)(36756003)(54906003)(305945005)(8676002)(81166006)(107886003)(2906002)(81156014)(6436002)(316002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(6486002)(68736007)(8936002)(6512007)(86362001)(5660300002)(25786009)(1076003)(110136005)(7736002)(186003)(4326008)(11346002)(446003)(102836004)(386003)(6506007)(256004)(2616005)(476003)(52116002)(99286004)(76176011)(478600001)(2501003)(66066001)(14454004)(486006)(71190400001)(71200400001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0050;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FDiZqmVYRM4pwogXhTdeDuH03DUY7B7iEadGqnWPKw5nP4vZxKaskz50Ve1RtT629xhVxyKORIWc5C82GgdNimdqrj7eU/rqwofHBOSur4nQiAMMXH0G+oA3y8rJHvRloOOXqHyVZzJHEmw6KWnD9oKlzN6NYlKDCtAA7HwzGrBWE/QPEAHHf3KF0mGS6AAhdf5odWuitqD0KEtyclh2c/P+SM5gpwjoKBWvVRZoFEx6+gG8Xk+Mj1suUd1PH/++US1TilLDaRc7u5BIPVzoWRnnXSMAxLvtPfcR5YCWoP6LovSOQJ6+KeWF3O3wQ59SkZSftA0vGhNx511oTVmfO91FLtJHwqm2hPKoDj9sSdPDR0etFjkqVx9yFzQY9MJ9FOmqOi9sseAmGGUnwWVPbz/PPasubSrpN6GKT2lresk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d8b42-3170-45ff-de10-08d71595f33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:03:27.3194
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

As of now, the flash parameters initialization logic is as following:

a/ default flash parameters init in spi_nor_init_params()
b/ manufacturer specific flash parameters updates, split across entire
   spi-nor core code
c/ flash parameters updates based on SFDP tables
d/ post BFPT flash parameter updates

In the quest of removing the manufacturer specific code from the spi-nor
core, we want to impose a timeline/priority on how the flash parameters
are updated. The following sequence of calls is pursued:

1/ spi-nor core legacy flash parameters init:
	spi_nor_default_init_params()

2/ MFR-based manufacturer flash parameters init:
	nor->manufacturer->fixups->default_init()

3/ specific flash_info tweeks done when decisions can not be done just on
   MFR:
	nor->info->fixups->default_init()

4/ SFDP tables flash parameters init - SFDP knows better:
	spi_nor_sfdp_init_params()

5/ post SFDP tables flash parameters updates - in case manufacturers get
   the serial flash tables wrong or incomplete.
	nor->info->fixups->post_sfdp()
   The later can be extended to nor->manufacturer->fixups->post_sfdp() if
   needed.

This patch opens doors for steps 2/ and 3/.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 28a64dbdaea9..ac00f90ebaa9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -219,12 +219,17 @@ struct sfdp_bfpt {
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
+	void (*default_init)(struct spi_nor *nor,
+			     struct spi_nor_flash_parameter *params);
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
@@ -4267,6 +4272,14 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	return err;
 }
=20
+static void
+spi_nor_manufacturer_init_params(struct spi_nor *nor,
+				 struct spi_nor_flash_parameter *params)
+{
+	if (nor->info->fixups && nor->info->fixups->default_init)
+		return nor->info->fixups->default_init(nor, params);
+}
+
 static int spi_nor_init_params(struct spi_nor *nor,
 			       struct spi_nor_flash_parameter *params)
 {
@@ -4370,6 +4383,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			params->quad_enable =3D info->quad_enable;
 	}
=20
+	spi_nor_manufacturer_init_params(nor, params);
+
 	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
 		struct spi_nor_flash_parameter sfdp_params;
--=20
2.9.5

