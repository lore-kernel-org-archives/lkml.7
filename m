Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BBD21906
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="clBMITLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKBLYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:06 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48468 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKBLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:51 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RG9Id0lzbjzdgTvjG//Tda6k1udj4KOXhzcA79xqTEfXL7q2JiyJ6ZP8+LcHiLbBp4dcsIXmDi
 a5Jf1Qf5iQc1SQwWy+zCgK93kfidwLSsFcB8RO4mtxFgW+MI29cCytxBB2eKyylXu4Gkt/Cgez
 S2AkpzOR/Ift5/xkPHh1g4Rcc4kNEbzCuuDPGUnq1gSp1WONaSY30vY8cEXpjj2nny1ldkMS9k
 jQLQi1MDlSZADVb1Q3MXpD/+211SUFWzTuM5TNuyjr8SP2U53SJPcyrW6yDdxy3STeB7vO23AU
 cDU=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55071990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHH849AFKozRkKp9U5JZ08e4kvoQMpXP3WgK/j7fow1mZh02pD0fFk37uCgV/94FY3mbDmGkLfWpPvsTmckqNbJnyH4e1GBxVrUyV/42QZ46SbKN3BmzwBEfyKW8fucrsLIqW1+cYqj2e1BvAvErcNpMvxVBvNyVOXq09TNjzsUdv5DL9Pa/AZ7rlQkBAGuCp4OrMKyRGqz7fsu7cokQEQeJQZwm/I3an7z88jRs69M5MM9H4mXL43o1Z6bnxneypZ6GRx4qYxhYxEvQ/gWvBdOuugXCTUK6ttL3QUunhkVGhuu8mNOF+cafsjhSX15UhSQvp1Y1HwFzGR99+0bjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDMfdl2pXzlKu7J21aq73yCFKu464pjjmFgr2XNK/WE=;
 b=fvsOFAFiO3g586EVybN48FAo7mgjhNjE7YQhPjnun9lfuvk55qXtrA+bCpDunhWq6i54Bq0w29l70i959jZpVde4+4t8ULJ7lRiR+0ZEhhVmPldKyuN4IIjN3WPU8ukACngHjDSBxq3G5DHE3hmnaGtm2ZEV7WF3ygex0w2URtz6E2z4BgWLqtts+EYeoAB9wfh00k+FZnOAMmQvRlicvZCD2KgPXQclxV9Q4lvQX0vGtMAH7cCBLf1H6/J4nJ1WomGtvDTj7uVQofLVPt9Y5NDU0pMRkPKsHU9cGo/67qoPTAESpAt0EeixTQP/rXL6dqcXfHtBJDH7y8cwUzrQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDMfdl2pXzlKu7J21aq73yCFKu464pjjmFgr2XNK/WE=;
 b=clBMITLgu0Phk5NUw7kDervxLuXM5GLwJdBqM4K99tlhpoPQW4PTTerfEyORKY5OeW9S1+S5avMC5fn4bhet9dv110AEsv7FoyS+BOr04s0pX76AbalmUmKm+puMhmi7z0wgKbAlR8hdZlK60MSt4XPqxnHCs5eE9URPbrCsBlg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:49 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 14/20] mtd: spi-nor: Extend the QE Read Back test to the
 entire SR byte
Thread-Topic: [PATCH v4 14/20] mtd: spi-nor: Extend the QE Read Back test to
 the entire SR byte
Thread-Index: AQHVkW//QyfPCP3BdUe22dyglJGg/w==
Date:   Sat, 2 Nov 2019 11:23:49 +0000
Message-ID: <20191102112316.20715-15-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: f8b62609-49c2-4ade-c30e-08d75f8721d3
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711B52623FD71868FE20945F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKVSv+HMgevSnhHX5uLJkff1dpL9x/nJ4JHGPNpDuBvIoMMXkR45vs1IyRW/3vZeubUGrhehNenjM9U0UNGUr5coNc5U9jlmHllvQzaKS+z4FxxUt6vr8XFrVHLi/AMjZM7tn31NJ9iSJj8NjwjCbJWXA2SvZPfg6Hkn0ZxWwKjOMTZCIGlu8Z0ICvAp1lFxu6uPXUHOHa4hirKaXITImaF+r8TcJwsSNgheFRGkEUgESBdPtwmN0Kf9LkpTdFIjuY1ho9LWPl+9RdBwYZUnm+gC4kEnpX2yTeAuU/YJ41GB/MgcY2sIMXBDymtTrdRlWrRPw2f5oln6XCqBh9lM0Hvwk3ixsOmr7oVYg/O9534Ti+zIMUzFaOuZg6talylhD1U4Nk/I1mL5CILuSOkisL0HiYfPvDy4jnJ0EdtFIojvIAT+yL+ZUplRYSG83+nR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b62609-49c2-4ade-c30e-08d75f8721d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:49.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHmg1CXNTQtY1zYb4jbuPADyJmlubpDu9XHCv4OroujQ4+3a5OFU4BTS22c6Wgl/JuZ6uDdZle68NEW1cflZXSIf5diarhUWFV6TyknmBNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Extend the Quad Enable Read Back test to the entire Status
Register byte. Make sure that other bits were not changed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f96bc80c0ed1..08fd2c97897d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2047,20 +2047,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
=20
 	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
=20
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf, 1);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
-		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
-		return -EIO;
-	}
-
-	return 0;
+	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
 }
=20
 /**
@@ -2108,6 +2095,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 {
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
+	u8 sr_written;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
@@ -2128,13 +2116,15 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	if (ret)
 		return ret;
=20
+	sr_written =3D sr_cr[1];
+
 	/* Read back and check it. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
 	if (ret)
 		return ret;
=20
-	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
-		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
+	if (sr_cr[1] !=3D sr_written) {
+		dev_dbg(nor->dev, "CR: Read back test failed\n");
 		return -EIO;
 	}
=20
@@ -2157,6 +2147,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 {
 	u8 *sr2 =3D nor->bouncebuf;
 	int ret;
+	u8 sr2_written;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
@@ -2172,13 +2163,15 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	if (ret)
 		return ret;
=20
+	sr2_written =3D *sr2;
+
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
 	if (ret)
 		return ret;
=20
-	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
-		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
+	if (*sr2 !=3D sr2_written) {
+		dev_dbg(nor->dev, "SR2: Read back test failed\n");
 		return -EIO;
 	}
=20
--=20
2.9.5

