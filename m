Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B072A205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="roBPlY4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440654AbfIXHp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:45:57 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29393 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408152AbfIXHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:45:56 -0400
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
IronPort-SDR: /xOFlMX1/v3DgyJAgzQJPGeJ0NsfBQC2oZ9Q+7YxSbOK+GfX8ND6PEq4bs30U02NAR6yQoVrY0
 K0exKHBBHrLfdLFy03im069FBHRuMOu5udlETrR+Yy/gD/NFCGdWEgS98VGajY4HxVQAq1TUEu
 eflnIOcAGDWl21078R2bns9kPAg87yOdu6OkcuGLmJSRaIww7XbeP6r7k50NAaFIlGEm8aMCrD
 Whf6lctUl5Q+Frr1GFeiDfbivqQHjLcHYJV0rnsLB7+XNnYpbEsVGbvGfCUw2gisEqO1mdRMuf
 mbw=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="47374674"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:45:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:45:54 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7YfLJusmfyIO6nKIGLriugBMRV/3aIUFIti+5U1xy58Cxv7RYTy8zTHFTa08vTyBsWeDFRZvw7cCSVjM0BhVhYIOV5QFLvYLwOcMm84o0AC3fIWYkw0ZoUwS2hrbFlEGCkbVTfal1J6Drfsai/nPWwhYnKmoSvACYKhlsBX1kJtv8crlJZwjGlbx4izRxQTTfHxd9aQxvZgeXi5CKo64zXq1UtEAOt71pqvhCwRxMiwNBVgaTHRS9U3gna6oOYSnBn08kGEjitoah3JM8H9EIK9cGFbUO2p2unMb8fPVkk5FwnClC3zdxlwyXGF0Or7Kb/KGQ0j2nulN+orBp3p9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX7QLQOz/p1Yx0WDeQlhyU6NDR1qB0ng5ZogcAsBO6w=;
 b=DlARDsgPLHOxR/zU3aRXguCI8In+8/bP1b+NMeU+tuHJmqK0dWfbTFroYpLR8SU5Y/wRMumAsSKN9GS+jWogkV05lANL1SsCFA32RCehJQt+nnYO4MjJZdodKqr1HRUwzbs3uRtDCv9NNPqeXkoZgdnRHfNWGA6oEbru0EwTOmBJI72anRhSFjqRUKMQQQW/68coXc6AMiOFDEbRyhaswkuiajdCuUj5xotwS8piD/pZKcithrLnKWhejKRB/JJ0UC0vE4N6+qw/1C98Y8FHuBLKGiEuKWOI8sIERTfGw0Nj8x8peoeQUeZyv4ury6OPdYTzeX61/IpLLGRNhoEpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX7QLQOz/p1Yx0WDeQlhyU6NDR1qB0ng5ZogcAsBO6w=;
 b=roBPlY4ShbES+a/Dr1jnWxACwFJsf0yId8ULJbrOrjVK6oSut/VUc7P6GrsZf1DNfA16X79wjSijerAVxWYrpJdXF1IcegEhTe4rthAI2NQ25cIgz2D0rV8kzjR3P5Nb6pSUKkp4vvAATUxqZkWYEU/LG8vO9NG7nfvb87VQTYg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:45:50 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:45:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 01/22] mtd: spi-nor: hisi-sfc: Drop nor->erase NULL
 assignment
Thread-Topic: [PATCH v2 01/22] mtd: spi-nor: hisi-sfc: Drop nor->erase NULL
 assignment
Thread-Index: AQHVcqwVF5z/4vjY/Uups9rQY4HRbQ==
Date:   Tue, 24 Sep 2019 07:45:50 +0000
Message-ID: <20190924074533.6618-2-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1956a2e-7319-4dca-7862-08d740c337f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB431965A99AF9AD3F03CD1324F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(4744005)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7dOVYYXbkrpZ+fHhcHHaTWbnTMJ87zrknlSxv7RTAtOCuDcixfpEKdcoKssqPZ95VWcxKyYHZRGc0ZKo6c5WL0ejIQ6tgHvKOwIJlz275JGdMuphSfBljHbw9I9Fs80ZU60tqSd8vyVJNZhg1ff6vmahW+ZsNjzhD6IZmwHdqh+LCcKLJzzthNXFGAq4yD02AUqW1T6pH1pPSA/Hi9f3fHecw2lLGyS2VCVFns8ZGQvXRQeay1WjxzNxR91+ZYeM/AL9LHnZQp0qvTJkOX6rPnGTkpMaHvEAWAkkzSeDk8BzZyIxIMe4FrWj5KP6amERPLyupUdZcCRDgQ8gds42X1Phf/p+81kbLwmoxQUezzx6ja+w2l60LzGCLIcq5HGLO/raXMQHPxooWEQg6GB4cBFSTiUdz2vRmok3glENJrU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1956a2e-7319-4dca-7862-08d740c337f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:45:50.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVBzWiMz1WQk9Idl2mck2R9oKQyA267YSRp0DfgzoqensHokjUmuC2+5LyVk0uq2sqcgdN85bwCrhyPrMwO5KFVHFJgsAWwk98bUvBMRtEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The pointer to 'struct spi_nor' is kzalloc'ed above in the code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/hisi-sfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.=
c
index 6dac9dd8bf42..c99ed9cdbf9c 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -364,7 +364,6 @@ static int hisi_spi_nor_register(struct device_node *np=
,
 	nor->write_reg =3D hisi_spi_nor_write_reg;
 	nor->read =3D hisi_spi_nor_read;
 	nor->write =3D hisi_spi_nor_write;
-	nor->erase =3D NULL;
 	ret =3D spi_nor_scan(nor, NULL, &hwcaps);
 	if (ret)
 		return ret;
--=20
2.9.5

