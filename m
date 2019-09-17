Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DAC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C26214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kCrRmMP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfIQPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:28 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:8081 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfIQPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:26 -0400
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
IronPort-SDR: RmRHi3caIAIgEO/lUR05uA+BO9RMSlGeO9K6WpnOCPEIU8Zl//np9bgsG6wyWNNU/8zxRiicbq
 WWh2ch0ShKXDJe/3zQv1GoZybtHgCO5nADSEErYnfb62M4wEkuJgaCNDR3uqgFRS54nsH6Bx+n
 o5GR8fBmbcnVrayAUrgIkPyDPNtLQf+5nPzCGpJJBxcjgnNe1Kuk37CUJnMZsBGKp2hibI3wka
 eodtoaJfdjbTfrNXnniAc7hWfvuOP0umm++moKVt+3QxqqNmS5CHw+bdKuxyS44qHiAGCog2ZR
 Lig=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="46517742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:15 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex8NE5Eh+t9Q2bcHfXX+cYAC26aQVisrVlD5hKUF+OjgFHKCND9Xk6sIOcCTxHHtk46paj/Hg1zlxb0/ZS6sDL3swpk7hS5vQF7qKGzVT4KNG3GXn8ftNNs8TVeRMs6+HF8WmnmgBCqDVz9NY6nG83EIYjedgIuAs/rtA0FTFhuqEDu3rm1OrlIDDDG1+u6b6lDGQSFIdfQR2NPuh83wohf1yXXSLMin1FhE1VNxmb0Bv/DCscLaPzAVqVNWTVgPpxmUVtOYkzXiiUDXO3AK4+fuLSkY6mrz/6uqYuhx62etKcqYzQ5m36MxvA+yffX8rWwjl1lRc0/H1aJrGtMctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfNIlmP+zexOyiZQZZDTj5QUb3ATwRtXvE2VJWmSigo=;
 b=DgG8qJIbjhrYQK3M/uimH8QOwJSzAVyRmLy/9JfyCN10+wY3uXSYgnmjUzbiwZ1w7e+fzCXwjypDUtBdnnHyqgOVsCIlCUllVyR5P6nBDH50ryWAvynmYvsesc8Qv/R9pLFXK+Fpm/gM3ROa2vDz76HEZm5fdubyTgDlVT7Qoh6dr+azuh0pzXQ3w6a9lYJfhDja3QIacToUyq2bxwY75t6iGJz/p9BcOwa6il5oPWRhcRW67w84qZtLlfsFgD3u+u4W42iVG5Zu1XiHG54zCfEPnIQYrbfTPSIceM0QGuH9Rc2vVZXZDUUVab0ErXiDZTAKA1UcjbyFkoMloGnU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfNIlmP+zexOyiZQZZDTj5QUb3ATwRtXvE2VJWmSigo=;
 b=kCrRmMP641rzEtME99X3CmD82iptAuQ61uSmBhtwOHuaSsgRho8CXYTvoh9lQ/wYmXiYq9slHsYnJLlYf6kHQHf3f6RLvQjxGOFW/cGaXUHoXESWbbFn7Ytt32azkCasXfk7WdNdaaprBNQUNmQhQKtz0PgBMCbL0HpjhBwfBe8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 09/23] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Topic: [PATCH 09/23] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Index: AQHVbXBIyC+efO45bES0NItE97wYMw==
Date:   Tue, 17 Sep 2019 15:55:09 +0000
Message-ID: <20190917155426.7432-10-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7be4ab58-10c8-4d45-5dc4-08d73b876ac3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984DD4DE72D5B8452F00D10F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5xaQsUJmwxm42EZQf0PXNo6tpN1yZ/9fRTniQe9KxM5VdKgM3t9kRoM2L8fz02OyMCvu8xr8Sje50q2PxybLn0XmoiCgc8eLVyu1i5lYneSS3x6dn9SdlEvNg8YkostX1QHrBU0WgJd0IPAL9l01tnRdBbNcai4OTGChOKiQSNY5n6tftV4VNlPaHCBHKQWSNGNi6mIF6sY1oVLxhqisMcVZFh7VjN3j3qfhVQZ0VhUZefgT56Sk4DlJMEal4YIX3zN471AZtjRKvelPAqL7TtdC9XYxvLKo6cdBlpatrR+SCBvbYMEfn5mChlQ5Mpfh8q0I3zWTp56t6f8+GU8TOcrzyrcEOTKSA+S8AiNHXM4DQPPcZHrdRMNNAA5jxob5kkEZcQlDAxZFeBqeSiVfucc9LMFfAddypaWIag4g+ec=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be4ab58-10c8-4d45-5dc4-08d73b876ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:09.7384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX7DwB9J79gXoI9mUBG3lhplNs4h036VlzpanIkvcJ+HuMm7S0hwW+8npjbfDrrZ8uHCn7K/sOua5asVlRmVLw7pkPNw7/95KcG+ukKBjNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

In case the write of the first byte failed, retlen was incorrectly
incremented to *retlen +=3D actual; on the exit path. retlen should be
incremented when actual data was written to the flash.

Rename 'sst_write_err' label to 'out' as it is no longer generic for
all the write errors in the sst_write() method, and may introduce
confusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 271c2b465038..151db98f7d49 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2665,12 +2665,12 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write one byte. */
 		ret =3D spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 	}
 	to +=3D actual;
=20
@@ -2681,12 +2681,12 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write two bytes. */
 		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 		to +=3D 2;
 		nor->sst_write_second =3D true;
 	}
@@ -2694,35 +2694,35 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
=20
 	ret =3D spi_nor_write_disable(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	/* Write out trailing byte if it exists. */
 	if (actual !=3D len) {
 		ret =3D spi_nor_write_enable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		nor->program_opcode =3D SPINOR_OP_BP;
 		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		ret =3D spi_nor_write_disable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		actual +=3D 1;
 	}
-sst_write_err:
+out:
 	*retlen +=3D actual;
 unlock_and_unprep:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
--=20
2.9.5

