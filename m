Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06316C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD8B2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ax7PbIKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfHZL64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:58:56 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:20359 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbfHZL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:53 -0400
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
IronPort-SDR: ui8CHeqcwF7FaPpq8Qm8FSpjXSXP4qRaKztIT5p2FGvBt3EHEcnP3VjAYVP8BsFxk/dykXbDGD
 UkWbvlfcs7BhF4I6NmKrITv18iuYJMBbOr6EjI530KGF9TOlaxrSVCkiMx3bjRzsrhntnTOouP
 dCxmWis/bcvMqc4DwmvZbp0PNWSxRgi24lri+DtydolhgO1GuY995gaEAImdSYYdaqkO3TVTOE
 Y3ivLfQXvjLSazpgI3MCIq77OO3XiE2RZqLkTrGxucDuXhKJLoAyao9QZ6nebynT6ByEml90A/
 qWE=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46586537"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:52 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 04:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkGHdGMHugpPc1eH4yhZUvt3scUqGH6ndfczDOqv/kzc4bBnpCF+08e9tY5GFz7/0fvCVq+I9c+JOkGOPzuJgH2RTDuGMml9eMCCS09TPGhtuooS9Si5kgJcHmnNBi5MfQKBwlbojkabBbXgmUsWuozVo8kutrmbKVNaVk+ZYb48y1Qmv51+01kS0jy2FO9vefGAl1VNdjaJ7wlZFv+aAMHXKp75aB7VrLKuh0TTMYq2Tdjr0RAulkGL/KAN/IFufG7ZE2Gm8XggMq03lTbTq7l8884W07uka9aVqCj6r96oDz2DRZnf015eLLdL6oNP8Sg6SHNVDiyH9k+09VG8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwKSHrY1sL5NFIU0YsLoNrhAdYjjSkmwTlWfEaXcz98=;
 b=WTR8iYFb9YUDJKuSemzz9Zb8bo0hvfhmpEILfpMQ9eyWnXxbjdylpPJKJ8qQ004CHxEYCISeeONWawNlwqr7I2MPOXk/cR3xoKBTu/rFQhn9DieHvhiJaHCyB4K3N1rwJXbv2MU10iGHZwyP1uQYrcSDDgBFFr0VeQdaFWTOh6CpsaHQxXfYdY2z6tbXol7uk8yKeOkPac37GlxyornyffzAy0LzhproX9/9/E2lmch311GCt5eV20Ef8FQNzajZM1inokbFH5z4/xI/bUw7PYrASydLAmWiOah2hv7Qe7EPMtsgPu9XtG+7jD5+XqDR1OoLttUyH4QcgkHBEstbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwKSHrY1sL5NFIU0YsLoNrhAdYjjSkmwTlWfEaXcz98=;
 b=Ax7PbIKMzifyJOyW6OaovV1PAFkcYni5JHTF9V7zGVLMafKl92GNZMidYkGIuDXQrXdqedgeezrgOayKNxY9AvjJ7DXpwwu4szVAUJ7mc4jMHxvbwxjwQu1nGkN3JwFF5Z9bzTO28LFW6l6VQYar1+bHi145OBVeZbTYhQTYueU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:51 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 05/20] mtd: spi-nor: Add default_init() hook to tweak flash
 parameters
Thread-Topic: [PATCH v3 05/20] mtd: spi-nor: Add default_init() hook to tweak
 flash parameters
Thread-Index: AQHVXAWgiVceGs+Wz0iN35bOjE2aMQ==
Date:   Mon, 26 Aug 2019 11:58:51 +0000
Message-ID: <20190826115833.14913-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: dcc58d37-5f91-4bc3-e6d3-08d72a1cc2a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43504F236285FF8BA587C52EF0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(76176011)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(446003)(11346002)(14454004)(2906002)(110136005)(2201001)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w06gz9kun33S+aoENW7xL00///4CYSstaRqr5ST/th+ueHn5Drm2Qzuz+6neG4W3D6Yj2+yFF2toXkAOP2UH2qtYiV0n6cdVmhURfEqhIM5f4PipLul9a36M0qYIMzP3v0NWol5IBExw4BeWmKnV0fh3lEvM+XX5Vl4vbuCPEaSxMNFASg3XIkAXtR4W8kYDTTREsy3zmAXPfn0QSG85vo+6VLNqcAxyhPIwwXBCPsMiMrZxh5Zpya09tia3sAdRaHDmiHkTaJ5P7E2LWj1W0cOcyumlWXc4yX+294M+dM5vPgjSSoa//BuhqWwehUpymXDojh723uk6ozcrI/GDqGX1/hUwwzk8+oQ4bY1lvwy53pAUU5aRI4vdrhTCSaXaKMMwxjULuItiJFNmoT85w7f093oU9nI2gtOGVsAW+zw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc58d37-5f91-4bc3-e6d3-08d72a1cc2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:51.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFpXX4NewtXLq051D64jdH8F58pUGfsVQNZMjqYjw55fYBCykJQ/rLcUZvxsOctujl816RxvdncEMfSw+uLBcRoWg8iQ51/A79rcco7ZZsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
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

