Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407BECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D13214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sHNuYaMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfJ2LRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36152 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733120AbfJ2LR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:28 -0400
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
IronPort-SDR: fAD8nx1o1uN79GuSyGQTgU4D34mLvnZSrvM0ruXef5249hfGaiqvCCozI+3xYquSqqpKrBy/c0
 ytUM7AlzHXag0FAiOGaQWOIMphx9/wJpHo4I43HxId71x5+TKAqbvlk7VlQ+1XYkwcaWq82g0q
 fzQ/OVobaWIScrHyV8/C2UbzTTxVds1IqduABF/wOlyyi6PJa3obuaAJUUvddNUghwHiUZo6la
 hOOteHBZnA7CT4Krp43jBRJhajie9dYtFcSGi5xCUV4Lil+Qg7nV7ngQEFH5lrN1z4/+W47e46
 DTs=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292124"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfcThFf754Dp9vRJ70xJLs8GvCpAbXjrQ+boBAxS8eDB24zvTMRKMVm0aa/VL7884ZrTN4RSN3JNNJT93s1QAMB7ZMLocO0QQXN45l1m1ljW7p2KNsV6uNOdUVDvRZubSmpfMnHgGtITFJe7VYUXsx4CyYkOkA09N3aOHJtZZ/3SXjWk2wkKzsmL4S2Aydf6p9IuBUbSPzDvtSb1MZywfr1AmAzpahtUvPNcbvp4vBekISv1Axo+2q7nOJ+xlbohwv7NM0RymErKayJ4z+bOzElcOLMxBerCgK43/eQsYwCDTdmqnwCS50dMWo8IKucdk2Wm1CPWf9jV9B+BG4SmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbOmAw99AAsvhPySsv2SDCjCV/q2cG4sH6npCUjkG1c=;
 b=mGOIUikya1vhFFG4gaa5bmg7yK9aDJO8PzqZc70zT7SimrEkPGtiGg8nlX0quOuW9VrZZSRygnDcId0C2S04UoTD5R5TwFLMU3zrGR4CFecZfePoSz2P1Ta8pmoSNpLp43oW9zUadbUkwHIWi7nomE8ltTEPhVzRs/caC1LsCsrE4GyJWqrk34CoJ/JRTmHvSPL9lNgi2vVcdDuHWN1yf6t7McZb3Mwxy6QkER78ictE3FIGdAiyagOVAK2FoQpACuYJLMPKwm89e9gnGiK1ebdEamMDQKSjwGkm6GSL9mw1TkbAEMGncktaLewL56p11DZt129mJM6oyUgVS4YPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbOmAw99AAsvhPySsv2SDCjCV/q2cG4sH6npCUjkG1c=;
 b=sHNuYaMf+NJLTfDCcd4zFtDZrmxbpM2GjnU5BJvaNj8auG7d6/Jc20GTQbHkVY30S4uzjamMudEgmUkJImV4+R1zrrNpCA52c0g46YOVt8sg9aMIsnvOW0qCszbtOAlugCiVISVsJ/mOCN0YdkTz7s7okwQy45ijHxcTiyNQ7SI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 23/32] mtd: spi-nor: Check all the bits written, not just
 the BP ones
Thread-Topic: [PATCH v3 23/32] mtd: spi-nor: Check all the bits written, not
 just the BP ones
Thread-Index: AQHVjkpx863xm7AhdUG2gmkUJjOvGg==
Date:   Tue, 29 Oct 2019 11:17:25 +0000
Message-ID: <20191029111615.3706-24-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [83.166.207.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de62ffc1-2b02-4eb5-aecc-08d75c6193ae
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823E7463321F96E1C48ED41F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(14444005)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTS1oBQ5oFRH551HTvUT4Ra7KtsIOyLCxrWpNbQwIhOu9CiISwUvIGpN+SHlWxW0curQniHLNvIIWjg8ciUUMIMDq3/sXMX0TGRld6N5aYfYseNzBbd9/K1f/TLTvwyIhZI476BtyOiWUdJP3GxBo5iZJDYY2CYX3v1ibRAQGGUrnFv4WJXnCt5qArcit3levVRE2n5sMLgSP4KINjH4lELkIubVxY2gqMqJctLt38W4AtSnA1EyjtToEuXBuRD4AgEnGgKN3folXSBtB5L9NL/8a0hMIUW17vEy0eiOLKIAjIcbTW1nGiFRUwquA2Mbi1JH63ixlfZO+VMmdwp+1/H9YcZcuntqS2O98ZDi9qN0wPbsm49cs6iRqhzrPJS6a4xFSn7BpGavAGckHh2dRtMMldmRG5cqNfXi5g2AYSHKQpOHBTaDXVy70MTbL171
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de62ffc1-2b02-4eb5-aecc-08d75c6193ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:25.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omwbmU6RYQYVzWOuKW1jtXeXP/6OOT0keKiJho3e7eklTXesEIPnkhhgeiKZsnDA2k/G43BtBco6/ojGnqBrQyZm0iZGX9etvOcbeLkWRbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Check that all the bits written in the write_sr_and_check() method
match the status_new received value. Failing to write the other bits
is dangerous too, extend the check.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 21a974b88c3b..5b30fc73fdba 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -960,8 +960,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const =
u8 *sr, size_t len)
 }
=20
 /* Write status register and ensure bits in mask match written values */
-static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
-				      u8 mask)
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new)
 {
 	int ret;
=20
@@ -975,7 +974,7 @@ static int spi_nor_write_sr_and_check(struct spi_nor *n=
or, u8 status_new,
 	if (ret)
 		return ret;
=20
-	return ((nor->bouncebuf[0] & mask) !=3D (status_new & mask)) ? -EIO : 0;
+	return (nor->bouncebuf[0] !=3D status_new) ? -EIO : 0;
 }
=20
 /**
@@ -1774,7 +1773,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, =
uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
=20
-	return spi_nor_write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
@@ -1859,7 +1858,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
=20
-	return spi_nor_write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
--=20
2.9.5

