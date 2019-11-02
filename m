Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11289CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C725F217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="usFSkqSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKBLYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:07 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39961 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfKBLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:56 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rJa2Sr/T0c6RH5vAVrCRkdgn450idKu5XVG6XUY3hQ7EdbgaqDtWjfBW5t7vcA5fffZX3pObo0
 JcYKC84NWj2mi2RDEg0//Wa7RDvgStSCF+u0wSjFFNwT6DKMsDssOCuJrrx5dqA33YMEBvPTVS
 EX7Ptthj3hkohtngpJypbbVK38Yfpvbn6CUpQ9nDyRCyLl3RhQXaBKKFLM80kstwWcLsyxIdID
 /Cir6OrgsEgH9e7XKjQ7E4BpAKZk4RCZexMNthtqHTmaRV2vaqvWJRXti4grZVSDZ8BsuVyvtc
 5kM=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900889"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:55 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8Qo8nBQQ39o9fo9uX+zpR7S9p4qIHrW5RzC0YCZnCLoIBRuDLoI5HSVFUH7IA8jP1wzfT/MadTI4pVBDVjSGKpEEE5pkb6UiNWjFJbREc6pMK2D0P2hW9eOxeEysQl57wP4aYBzlhaBfdMd0Gw/Gh4R8HJqgWMIlREM3KOtWYv1fL65lfAXTS6CpncbL5pAcx9NndX2EKqk7K7xYNE4YuOC7IeVv0wnepQph6WuUH49QD0lQ4JMRb4YHC0ahYg2anpru56LlAFWQTJ3gy7tkN4rSKjfI5Bqs1yOWGRps66xUGvAuPufqeX1AvREFip1WFz3sCqbWrKx0w6gZImdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMOhyMBxtEwaY4/hi7OG+3s6BhwGQEvsl/TC9jlouKc=;
 b=IxbtMrAMqKPJ/8cKj/BX9rc8fDS4JjdBJbuZ1B4WMMU6ImTNJarbwKGJWBVFmD6ZGUKnw6EYUD0TeIsqkuHrQKm+haUP5SXG1x7oRz92mJDh0im7la+j6ih8mTifxxh7OvGVKJCHetTqdE+ivwIP7pH9E7Wt6LLgXJI2+BJa+2UgStMtroQYWKJphPDkV+zpJD7+4SfhnJVG8GfQAI6y5y+8VmelvT6OF7LYpNhDcDbYUXVyFoHA8y+soO9sO1AnK8788Bk0Xj8Bda5eaaAxsVB6QErFhFBdKACqcc3l2hOw7SGMdquRB2NH6Z6wN3y7pPg4LvXVFu58+dJhepJZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMOhyMBxtEwaY4/hi7OG+3s6BhwGQEvsl/TC9jlouKc=;
 b=usFSkqSEPlnSdqV4smZ1k7U8fHTC+D4ZVN/hbYeP1nspmSOuTkAyEtp5HWNAJbx5pWpVMazDrqXRvqfyt9oufoDQmeWwwF07tfIB8AiAyIplbggW/O3Fr4xQbgO94CHsatehUkSL1djO8TLeou7SYBrnP+4+I4ytN47JGb03z98=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:52 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 16/20] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Topic: [PATCH v4 16/20] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Index: AQHVkXABFg3WNTfgP0OsvbRpAkLphw==
Date:   Sat, 2 Nov 2019 11:23:52 +0000
Message-ID: <20191102112316.20715-17-tudor.ambarus@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3581e708-ac1f-48f1-d792-08d75f872409
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371156C80FD6DC988D34D0FAF07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsbKZzEiKT9sYWF4+qi0vMk5g4yNQJkPyNhJa6SaQApfjK2z2PCQcbnHKilCT4vqP0GYE582rPyoyhyepu33YtqN28WVpyGGVKUoa+PAUnMy1vg18SRHsBiQRrRImrEx6Pf25ujGzqmQgFWLD0eoFh+O4A5445+kGRx/w+h4e6BEWPLzEZATQHv07kNzI82CmVHnQPmpgFOtYhw5/G0NGOd0dDrJuQIispQ0moWQYPKK0V5QRUODTgNO/DJ33qYca4NktnyxQpysq7Kv98yQeg6lvMCOwsbV/pAjKLQG5zoS5Gv7pcGVkqnfmawa9Ql775Ac0CD3Lcg3uivbZTXODeFbVhRSJO1Wsq3csbrkVXTCp30LSOf9+Cxl/cwLiiKUdTRDMtk7+hRclwZ4eOwpg40j0NStxMl7qxjiap9rw9y6xjMrbLwI4D5ejxeG++2X
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3581e708-ac1f-48f1-d792-08d75f872409
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:52.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUPYw74cVIP/MWodCuy3XTGQCDgzTN3eHv5FbGyBkSQJi6AMRDkply9EGRHzsaspOyq+IHjzMtRi3ax2oIr8U+ucMVSruODBd6r344I2Tks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

JEDEC Basic Flash Parameter Table, 15th DWORD, bits 22:20,
refers to this bit as "bit 1 of the status register 2".
Rename the macro accordingly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++-----
 include/linux/mtd/spi-nor.h   |  4 +---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8f11c00e8ae5..e367a4862ec1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1026,7 +1026,7 @@ static int spi_nor_write_16bit_sr_and_check(struct sp=
i_nor *nor, u8 sr1)
 		 * Write Status (01h) command is available just for the cases
 		 * in which the QE bit is described in SR2 at BIT(1).
 		 */
-		sr_cr[1] =3D CR_QUAD_EN_SPAN;
+		sr_cr[1] =3D SR2_QUAD_EN_BIT1;
 	} else {
 		sr_cr[1] =3D 0;
 	}
@@ -2074,7 +2074,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	if (ret)
 		return ret;
=20
-	sr_cr[1] =3D CR_QUAD_EN_SPAN;
+	sr_cr[1] =3D SR2_QUAD_EN_BIT1;
=20
 	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
@@ -2118,10 +2118,10 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	if (ret)
 		return ret;
=20
-	if (sr_cr[1] & CR_QUAD_EN_SPAN)
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
 		return 0;
=20
-	sr_cr[1] |=3D CR_QUAD_EN_SPAN;
+	sr_cr[1] |=3D SR2_QUAD_EN_BIT1;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, sr_cr);
@@ -2256,7 +2256,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
 		ret =3D spi_nor_read_sr(nor, sr_cr);
 		if (ret)
 			return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d6ec55cc6d97..f626e0e52909 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -144,10 +144,8 @@
 #define FSR_P_ERR		BIT(4)	/* Program operation status */
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
=20
-/* Configuration Register bits. */
-#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
-
 /* Status Register 2 bits. */
+#define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
=20
 /* Supported SPI protocols */
--=20
2.9.5

