Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9145214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HLq1VxZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfIQPzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:52 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:47183 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbfIQPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:48 -0400
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
IronPort-SDR: Va9BnOOGfjfaYo5P3ii0iU0a8hRfhcCz6worcyGpFqDWWAKaHeiqOzeWAraEfIv6DrlG5tsnZG
 VwIxklI/5nmBXrcJ6qnnbrfe3pJK7SoHeGuiSUwn36Sn2Kjev9xGEm+SbhToKFbh0/5i/4sAJ4
 vy4zrAnH3RckkLivR1m1U39ZiE3GOW65fVa7RhiGw13ODwQkJszaApBevMCI5pNakrH4J+WjXO
 x6brGQrkN9l4U1gi/GeL5oJPk3FOSD4mX8IiI6+zfh4UrI/lTJS+KKRjDIme+uBqsi7QR0BMBm
 Zm4=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="49243092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:46 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Sep 2019 08:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EadyAmk6LBZMdqkW/tAEHUAbimU6gPBJllFgzS11u5Hm0Z3WWJPa/XtC1OfABiDTe24QDDEM+3gcMu4gTgk7TvHTgaeu7IGeyrvyjRiT9CExosSQsikGUw2TDuszR1jN244WCIdOPmg3CVTUTxUX5nLpOWNllBeUPugqcV+vLK2pRSNv2XFfUwL+1df8tOiKFmpJTQfEY6kqXrKFA9zh0He9u5tVDG3gNyJgh4Q899TJWVpmC356xNDoK8EnNU0ABbdymKjVMKXUphYoxsLFbi2BJVSSTdK1iRn8zRZ4I6cAwfqYPukBrwFZUMRASq+U4gVHthFLcbWxpmGJQuQpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8ZMyk+kYEAol0HDDHE66QDG60dnjfVgAyQ9mr3qM0I=;
 b=CMI3rGJjNRHITBOpC5xMVgx/FxNaLwLZzbyxVSYY81XznSHaFyMwoSO53t4KIchVzExzwdvzIF2Iec6T2yjzUr3PmizPn/rDn9ansk7lCP7qxtSGAWvideWp9K1qTLiLhUUbvK93sx5L5HQ6DZ5J5l18vuL1d0gfJamXjIyzy+XYsAD/749gMj1c2YC//qi8SWXPHPJsKidkY18sItLrIJSQCQTjVQT7qP30/tTBehON3rMEsiBKHgB05MSAm0oKzeVnYFnxrKRsCBomYlLa3uw7M0UV0mYg6AahX7JxMD1UICun/stcg5XDZ6qfIbZbz/EZGPuiG1qz25TuOF2b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8ZMyk+kYEAol0HDDHE66QDG60dnjfVgAyQ9mr3qM0I=;
 b=HLq1VxZbKe7AcpsyENB/06EIYwKwl4CgW56OIYTOu0EzEUeuFPhBZjkLM/Y3SgjNswj01ZoTBDucBLMeLT4HeTE9x3SgDuh4x8tsWbo0654vYOflzZvimkpzFGhXs7UQuGpGASkkIT16Byfr06zjJprdXVkOdB5qtywSteDhSkg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3725.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 20/23] mtd: spi-nor: Update sr2_bit7_quad_enable()
Thread-Topic: [PATCH 20/23] mtd: spi-nor: Update sr2_bit7_quad_enable()
Thread-Index: AQHVbXBdQKqFCEhfJk6GjF8offODhQ==
Date:   Tue, 17 Sep 2019 15:55:45 +0000
Message-ID: <20190917155426.7432-21-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ad8ddeb-bd52-4c24-e894-08d73b877fe1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3725;
x-ms-traffictypediagnostic: MN2PR11MB3725:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37255AF0088887760C2DBEB4F08F0@MN2PR11MB3725.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(76176011)(52116002)(5660300002)(71190400001)(2616005)(6486002)(6512007)(476003)(11346002)(81166006)(6436002)(66556008)(386003)(6506007)(26005)(66446008)(66946007)(64756008)(186003)(66476007)(102836004)(316002)(446003)(2201001)(110136005)(54906003)(8936002)(107886003)(478600001)(50226002)(25786009)(2906002)(86362001)(81156014)(2501003)(6116002)(3846002)(256004)(305945005)(7736002)(7416002)(99286004)(36756003)(66066001)(14454004)(8676002)(71200400001)(4326008)(1076003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3725;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jAofMaD55D6ZXcEJtTQVrREo2F3jJcTJYt+hHAZUGXGyJFT7VCr+tTwX9X1yeQzpN/uf+5PCc2uSNJNTcOVGNshsZVGvLY8vxSV3e80zTu57MAaJnYC88DQP++02PRgeWxasMV4R+bXV8k+19rXYGFSPpK6XMZaYbCrrh9xrveMvcUcc5z4Qu5BYV7iunKM6TumO8lmitH7AbRK7E2M7KY9N3OvqeKadvRSgvcwohtughJGbGeM8il4cD7M+Ei3tSPoPYNY115esvsqf2284s1DVDFwGGnzRAeb5BhFT6j8ZSTf0aajSBTelnfEhN+D5z2ve/0cvpnL6fpLLsEVQS20o7LuiT+TRhXsswbem2C32H6k741RkT2QNT/PHfeULCGaHr9OUSzA7kggt0igiQGjXkRkEoMT5RU3ZV8SDqsE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad8ddeb-bd52-4c24-e894-08d73b877fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:45.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKSnW3rzr6dbPTQPL8TjCcw2dNo1i6OLXd7VItTfrZmLCBuFkpXatsoG9pNXgL1PMU8HJY5mG04P5c19/SendsaghdkpkOp+cj50fcdgcLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename the method to spi_nor_sr2_bit7_quad_enable(). Do the
read back test on all the eight bits of the Status Register,
not just the QE one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8648666fb9bd..a9cdb6dbc25c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1994,7 +1994,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_no=
r *nor)
 }
=20
 /**
- * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
+ * spi_nor_sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Set the Quad Enable (QE) bit in the Status Register 2.
@@ -2005,10 +2005,11 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_=
nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int sr2_bit7_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 {
 	u8 *sr2 =3D nor->bouncebuf;
 	int ret;
+	u8 sr2_written;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
@@ -2025,13 +2026,15 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
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
-		dev_err(nor->dev, "SR2 Quad bit not set\n");
+	if (*sr2 !=3D sr2_written) {
+		dev_err(nor->dev, "Read back test failed\n");
 		return -EIO;
 	}
=20
@@ -3605,7 +3608,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
 		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-		flash->quad_enable =3D sr2_bit7_quad_enable;
+		flash->quad_enable =3D spi_nor_sr2_bit7_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1:
--=20
2.9.5

