Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB69C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1808C2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RiCGjpci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1KfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:35:22 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9268 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfH1KfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:35:21 -0400
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
IronPort-SDR: bap3Z5+JViuosTgV+woFSqYaqXlR75JAZpx0xtJOzqEEuzFiu/gx7rz8i6JMxzl6skdIFMNLBd
 1YEj91QQxqeu8wffGLzm/U59uLzC0XtOxRc7nZtWGqO/17Btqa2MEOfWVyWekYk4FsmUC4S1ao
 KMjkcH0LL2QeRjN6RzGG7dBmhE4O0urnvotOauAIjOHHsIGok/wlqMDIvt7LkzIYTP6goeyVj1
 oLpl0zSCZEUM/dL43I7fhXnqXG/W/2d6U/qULzNt81TncZZNQrzyU6Tmh9OHCyg9spEsLx5H61
 Jyg=
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="43991246"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2019 03:35:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 03:35:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 28 Aug 2019 03:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILEFVrg4kWG3wQpUWvH4u05YMo1nkLSBkofZICruwk6XqzyO5I59SlWyRSoCm0Ng1xsJUOGTi0N38gMWmwWiTTvTbHTW4KQGMFnPmr6E/Jd99t4SfyoMIx6AQucp2MrzB5DNyx0N1oUMGhIt5OP7gxhpIQf9Qg7lfyikrqKe0o/Z51DdxvH5p5hiGpfKEtuO5RU2g/R2Z1I3B4kIk28C+IMR9HXjhrjkxzAcub02VvuaDQegM5erTIbJt62AbCt/wPm9ZGRnuRcbhfMnNYA73uMrWI4RX4w1oFj4U0cIQDd+dRDO/JJcMrClCPwr8/+txFjQlgHvXm3Nkhepkgw1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/tITCLgdK+8h8PCbWdZ60tSC6ptOCE/uUr+uAHlP5M=;
 b=leMw8eJQzBSiv88Ju82nvEhrP4LeUOyQVpI6fon+cBH3yfUeyXlxrWnuBrRrydCOkiF4sUGvLHM7dMbA3aJvNhHAAwd4PAbAxND54bwV5ctno2Yyo5+EJWwN4QFuoiGTL7Rz9QoDgqwC7qHD5aR5yc8u2+syYCE3Z8coMSQgcONxTMp2iLVncRKL3xZTrGjSY54WNc5ur0Dbm48aZkgyX6aaXTMZ38rBZZ521rPzriuUKS2FiZ0zkqGFy8wzQMOS2sDXC0UeCDeRFqCt1r9mAm09/v5y35ckNZozkSInUgNouAubHw4tFwwpr8OGR3xE3V/6v8jJIG+ZUv/WVwk05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/tITCLgdK+8h8PCbWdZ60tSC6ptOCE/uUr+uAHlP5M=;
 b=RiCGjpciRTEXgovCjQsFlOcEElLY6PV/d9FcFdVQlbJt7Tknyc4kI9O0PGSexJPSdnakYZjn+7KejgMfN8mVr3ogURpi+kNS+XkAqvZsxdW061ffvcQfH7OF7GP6t/wIB996r+ta+8kXj/4RvGB4txaNAbhUp9tfuSP/6yGcof8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4333.namprd11.prod.outlook.com (10.255.90.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 10:35:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 10:35:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: remove superfluous pass of
 nor->info->sector_size
Thread-Topic: [PATCH] mtd: spi-nor: remove superfluous pass of
 nor->info->sector_size
Thread-Index: AQHVXYxI0TEFgblBx06pcxDB5XcXng==
Date:   Wed, 28 Aug 2019 10:35:17 +0000
Message-ID: <20190828103423.8232-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0042.eurprd05.prod.outlook.com
 (2603:10a6:800:60::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ebab99-e779-4b87-021f-08d72ba36ae6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4333;
x-ms-traffictypediagnostic: MN2PR11MB4333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43331FB7F0F7FF270C0C8327F0A30@MN2PR11MB4333.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(36756003)(2501003)(6116002)(3846002)(50226002)(66556008)(64756008)(102836004)(2906002)(8676002)(110136005)(107886003)(2201001)(81156014)(8936002)(7736002)(305945005)(14454004)(66066001)(478600001)(26005)(81166006)(6486002)(99286004)(486006)(6506007)(71190400001)(71200400001)(53936002)(256004)(52116002)(6512007)(86362001)(386003)(4326008)(25786009)(66946007)(1076003)(186003)(6436002)(5660300002)(476003)(316002)(2616005)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4333;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a6GbMM/HNko2jGMhVOT+K+gpC/tacQPik1apbRQZGv1z1Yi17K87Hx4RE9GgHsKOn/7aR1ziQQ8YHX9ipfHsv2KNeFYA3tbVeWLXjCKu+pjml4Q9/x7nhyyvJRFc5oyzOQnnLbMh2EXNRReqfDR3iIVl4IRfhSY7fzq8sdRec/1T3vx3DuXS+DhZVaVDMMyO7nFYXkgqIoAXNMLbsAX0uPqgzvJ9gd3g6QQUACziY+3XxrP+twnQG0i2aWP09FpHXu+/4cHL9I7atb9fJgaHugKXdg8I2/we3URvBRodxGe65rPOi6gDW2f2DgIucoFyan2bO/ljziAajstrFgKoZZQ63qx6bZzyrTTauCdqHXFvgsdUHFdr0M5TOcOr9k0/+i4mYu+B9/rfe1Fd9PpuqcfW7CNFHE8G3DQTuCEICY4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ebab99-e779-4b87-021f-08d72ba36ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 10:35:17.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXj/95nFWPHStNSw7ZVyc8KBaD+C/tfrSkNzpjhec/H4Tkb8ViGdjbA9252YsFTm+/0D6tIQBfns67Z/MWN+r1pTWI4iblUfL6gGCust++Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

We already pass a pointer to nor, we can obtain the sector_size
by dereferencing it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 79c8f1dd8c6b..69532573dba9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4257,11 +4257,12 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_m=
ap *map,
 	return erase;
 }
=20
-static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
+static int spi_nor_select_erase(struct spi_nor *nor)
 {
 	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
 	const struct spi_nor_erase_type *erase =3D NULL;
 	struct mtd_info *mtd =3D &nor->mtd;
+	u32 wanted_size =3D nor->info->sector_size;
 	int i;
=20
 	/*
@@ -4355,7 +4356,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	}
=20
 	/* Select the Sector Erase command. */
-	err =3D spi_nor_select_erase(nor, nor->info->sector_size);
+	err =3D spi_nor_select_erase(nor);
 	if (err) {
 		dev_err(nor->dev,
 			"can't select erase settings supported by both the SPI controller and m=
emory.\n");
--=20
2.9.5

