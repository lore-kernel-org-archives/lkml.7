Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712712182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Qf+tRX8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfGQIsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:48:33 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48390 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfGQIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:48:16 -0400
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
IronPort-SDR: KOBIHJBALm3Xq8KyzMzIPyLFrHAP4JANjJIdWRjfBDD3Kr6CY7ImtBI99FSWJeCZO1NyKgchXM
 IIYHX6dK65HqKkL6YQUxu9yTOmqiARTUKqz8kBT1tJaY9mEWaV2NxsrhrsSzIC9u3xUdJyymYu
 aJLqOjSUV3oJIRfQoP0yShUf8AB70Y0xEB2eeXwuQO6O6Hd/azptShoetDQoRmgXvlTBGbpVCg
 5x12FKOkR1eafcQut4WTI8Uj+3mqDMQQDTgpfh7Jdaffeomb5ctmwIGY/CG5laxyggVUdbpHmJ
 0/I=
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="40862884"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 01:48:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jul 2019 01:48:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 17 Jul 2019 01:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHrkMvXZVj0MM+O5slKnRA+RDFfLLJstQRAsHQOuB4EMbOhGMoy77h2mRLX1F3w6+00lljDhHoVtk/By4h8enwzK0HaMet+64u4yrezd0Uuit7ICy58dkO6VOlLo8mkvu6GfcmnLaNuIEx+NsqaOcsUpxIFDd55IwLgpnudYhmd5VgLhTvrfghw2Xds9tzklv+MgkKHok3I6v0vNaBpIu+xn5Bv0VF3IqgQdmXxP8JPqRufPMqribPl1snpQwZ2XQw+hZV8FUuViQMpKDzQowY6FeHeJyPhtRw3fXeDI8YZuVX15qU3C788Acz/9iIpJIvdln4nPYZF5Rrroji75Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZBz6VUxxFW/YSX2R1lQo+OB/Pr8fL0yWuM0pVpTqHw=;
 b=oI6XpsTgTvAXCuT3rbZzG+aLvmevxnz92kYaKYyEIfto99gbc+CxYQIK8UKK2EBjHtS06gaqAjuJd14nzEQ56qYQyTMoC83CL+egwuCH9u9zvMX23dCD282jxmCB2oVJiC1wsV6fHKi4wvAPSZxtZaSwGykDn4eJHVDcRvT+30eMn20vMuL+zZsYdUEGdF0yzHNdn6hjpFUG2l29RLHeS19SI/utBcgvrWXDWh9aaLoRh2pDpL9ei/9YE23SWqAY/uQyqBQegxkLuz2qkL0Dfwu+yKo/kIvDupgvYvrWEdQFLYwXz7oAG0ymsUguIRPoXNFmKk948ORaSo34ryWFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZBz6VUxxFW/YSX2R1lQo+OB/Pr8fL0yWuM0pVpTqHw=;
 b=Qf+tRX8/JooqXYFrqXEdc4G24IZscdS4LZz85SG5+7FVjisjpaKS9fvA7tJKwH3f2J5kLktSRb9xaYVjM3Bo0rHrkk0ALSlVFcVeSJja05z7JhasmjsaRUCuDqYveaQSJEtSQLLeUj0q7DSMOxb9SdecPV/2IWj2jgfeSo8Zn9A=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6SPR00MB254.namprd11.prod.outlook.com (10.173.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 08:48:14 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102%12]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 08:48:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 4/5] mtd: spi-nor: unlock global block protection on
 sst26vf064b
Thread-Topic: [PATCH 4/5] mtd: spi-nor: unlock global block protection on
 sst26vf064b
Thread-Index: AQHVPHxeihfxjuggyEqOfqXDefj3kw==
Date:   Wed, 17 Jul 2019 08:48:13 +0000
Message-ID: <20190717084745.19322-5-tudor.ambarus@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190717084745.19322-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d20c345-0228-41c6-69ca-08d70a9380e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6SPR00MB254;
x-ms-traffictypediagnostic: BN6SPR00MB254:
x-microsoft-antispam-prvs: <BN6SPR00MB254F107D8F5795CC99B4104F0C90@BN6SPR00MB254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(66066001)(102836004)(186003)(4326008)(99286004)(52116002)(76176011)(2616005)(486006)(386003)(6436002)(446003)(256004)(26005)(476003)(86362001)(53936002)(107886003)(6506007)(6486002)(66446008)(11346002)(14454004)(14444005)(6512007)(71190400001)(64756008)(71200400001)(25786009)(81156014)(110136005)(2501003)(478600001)(305945005)(7736002)(54906003)(1076003)(2906002)(5660300002)(36756003)(66476007)(81166006)(66556008)(6116002)(8676002)(50226002)(8936002)(316002)(3846002)(66946007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6SPR00MB254;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHconHJMHrYiZDBDzlzQa4q3iBxJldEnvB5jEVLmLYfQXMcQdgUTaZitHGSuyNvYHvhEDGDKk172OXBL6EpTVKT2Zm7E8aJfgZT8R7Dtu4XVYP9AXXUOjgHsEB3ZOQRN6QStH7M94cIH/oFeNQCIHgXmxG2ctuagKOaD3Ifq4dteLj+PH24pzTjX+xaKdR0aUA0MM9SzWX6+LAwuQpSOJfWgMLvaheiWnPVN/ebTUxkw0dEkHJvIueHc/B0VXhZw+nX9RUYpsRUCep3aPIbfdFnM9Px/KeQjVtOHkE25ZTW+7VZT98FCCLWU9DvYjsv/HFH/gyAi7xPQFZt2/vVLWDtVOPJ6aLOyHHf2p0OHId5MR0MTIc/cNnocMjfSGgM4rWNBOkqm2En6HsmP8A7qVTjSn2qHmk4xFh8R7z3RsUU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d20c345-0228-41c6-69ca-08d70a9380e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:48:13.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

To avoid inadvertent writes during power-up, sst26vf064b is
write-protected by default after a power-on reset cycle.
Unlock the serial flash memory by using the Global Block Protection
Unlock command - it offers a single command cycle that unlocks
the entire memory array.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 767e2e6eb1b8..ffb53740031c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2075,7 +2075,9 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
-	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL=
_READ | SPI_NOR_QUAD_READ) },
+	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      UNLOCK_GLOBAL_BLOCK) },
=20
 	/* ST Microelectronics -- newer production may have feature updates */
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
--=20
2.9.5

