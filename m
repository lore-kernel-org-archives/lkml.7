Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A065C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CB92089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ELgSkKiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfGaJDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:03:45 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35407 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfGaJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:03:43 -0400
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
IronPort-SDR: uJHz4fm3AsTDX46X8fztln0oL43ENtjI4F4bxXUjyL4Y998Tu4qA0W6+dAm3v1CPg7yltL6aM6
 6/0GG/oME5Ak2OL1fsConYvpPuHzmY87QM0+ipNqDTBkYDNqLfcUDb19SsardehkhR+xnM/YrD
 naOolTmsU5cgaHGdNCV9Cy/KrcGAUr2WZs7DYzjT+lWyi9G1M8h45Z8n3grcvX2poiZC3iONhI
 xHfDnDoNRQDmoGw9cCbeytldcBwnTYEHuRGYIq9YxLpZ91fjcA8ABuHp7T1a9M1w3dq6Podomt
 8jc=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="40399778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:03:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:03:27 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mru1zlZ3lw7VW1p0G3AGKSTwzKvox/GAlNsO82/DFN3CgV3KI8voSnGtkuG4U7ZNjcQG7fgYFx2WTMhDdHwrnxihzDsxR0ZzoP0+noIfK7HUAulEKZihBiL2OYWe8xycTcuYHY5HT1dokQr27Xlp2TfkQTJa0IchNcSL4O0frDm3nxnFKf2LYbiTMGbESiq9EM4AXsfNSZUKCh1fWC9vF0BVJrHwFpXw+l2YOL3Ro9xJoBgZwOblMOqpOTHV6hoYen0g8WDA6NAbtKbAOz12n4/ibs/in+tS5kS1onGF2vFaWNU6Xp82vonLVSqZSV2rvm4Gtfe+M5uoh3IkCeghHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gdrOpMeJ2+2GnPJJ6uZri4WrSWQYchyZ+V62DlyjA=;
 b=dvjGE+BRk+8RhUU6eFsVbHVozZPlrCqU11kkQRQ+0cws3eWBR6HOW/PEJxPaYolv79kf8+vY3P7GcUmLoQFrTITVue0V06uuaczni+LFTP6OG3OQAKgtxWiPtXBZuR3X1StqXbnbgmPIhyNvjCYJGyYyQjXR1DSsumC8Bp7GAuVs+3Kntd5OiAgyjkRQD6JgeTjy/5qf1OpMz0Y4zFKu73MrJU3s3VO/Uz5h+DXa/xHdZ08bJw8pIv8cmNpnfXNTxm/R1oaiFc0/S6fgr4RQiTk9fvgHIil5jCt2nxvI93cXCo86yx38A31WaIpH5ND8ASzM/AOoBDcSmrfkEEU+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gdrOpMeJ2+2GnPJJ6uZri4WrSWQYchyZ+V62DlyjA=;
 b=ELgSkKiI4sv2DPgQpsPG44grY66TMnFTFMxj5ZFNu5p9nyjaR0LOPgsc/eXyR1yPXZMqYIT6Fr+s9qfvYAxQIa2tgKBPq//jZTH0seLe+omWN0idWEz8ehahC+OCoTgTq7/pAqANjVcZqyl7w2jEp06EFNbZxDGDUgI6D1cyIwg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2SPR01MB0050.namprd11.prod.outlook.com (10.255.239.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 09:03:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:03:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/7] mtd: spi-nor: move manuf out of the core - batch 1
Thread-Topic: [PATCH 0/7] mtd: spi-nor: move manuf out of the core - batch 1
Thread-Index: AQHVR37PJAqzdETGIU6iSDWkowmopQ==
Date:   Wed, 31 Jul 2019 09:03:25 +0000
Message-ID: <20190731090315.26798-1-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: ecc4a132-0016-4ca6-4181-08d71595f20b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2SPR01MB0050;
x-ms-traffictypediagnostic: MN2SPR01MB0050:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <MN2SPR01MB00507D46A92A4FC719FA6AD7F0DF0@MN2SPR01MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(50226002)(53936002)(36756003)(54906003)(305945005)(8676002)(81166006)(107886003)(2906002)(81156014)(6436002)(316002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(6486002)(68736007)(8936002)(6306002)(6512007)(86362001)(5660300002)(25786009)(1076003)(110136005)(7736002)(186003)(4326008)(102836004)(386003)(6506007)(966005)(256004)(2616005)(476003)(52116002)(99286004)(478600001)(2501003)(66066001)(14454004)(14444005)(486006)(71190400001)(71200400001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0050;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rUFAN7lXNTftq5yDWH7D2hcIPTfViDmuel5OFq4Ke0Bz2OcpNXzot0+3Sena1CHzIYY0Yf5otnDk4E5wAXe1jJ7KXRLOrS8YkKdARIHqsH03HBL2xJuBYGRT2Tbeqgi+VwRpXesTQhBSsaIE7PTetxp5dVhKOsSW6r5ya8wrFvBsEtJ3C8VngE/ZJZCn1w5l3yVsPtuk8gWXcck2BYnYNt2t0PkuvmoSVEDDmKoZv89wVzzvjocbK8udpUdOELWo35daQqzHplqESCVSz31qsRpg1DO+FdMQfYAYPwV1vrke/9o4X1vYVTy3/VuBFiEV6LY4z3uzEXp3UcET9wiZHOXJHzd+y1xtevYYaOajxKw/quotFseiFczCN/lsGNuUkzs1AV4zyhP8KphLuciUR8DILca94tezCPjHyknY0G4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc4a132-0016-4ca6-4181-08d71595f20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:03:25.2929
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

The scope of the "mtd: spi-nor: move manuf out of the core" batches,
is to move all manufacturer specific code out of the spi-nor core.

In the quest of removing the manufacturer specific code from the spi-nor
core, we want to impose a timeline/priority on how the flash parameters
are updated. As of now. the flash parameters initialization logic is as
following:

    a/ default flash parameters init in spi_nor_init_params()
    b/ manufacturer specific flash parameters updates, split across entire
       spi-nor core code
    c/ flash parameters updates based on SFDP tables
    d/ post BFPT flash parameter updates

With the "mtd: spi-nor: move manuf out of the core" batches, we want to
impose the following sequence of calls:

    1/ spi-nor core legacy flash parameters init:
            spi_nor_default_init_params()

    2/ MFR-based manufacturer flash parameters init:
            nor->manufacturer->fixups->default_init()

    3/ specific flash_info tweeks done when decisions can not be done just =
on
       MFR:
            nor->info->fixups->default_init()

    4/ SFDP tables flash parameters init - SFDP knows better:
            spi_nor_sfdp_init_params()

    5/ post SFDP tables flash parameters updates - in case manufacturers ge=
t
       the serial flash tables wrong or incomplete.
            nor->info->fixups->post_sfdp()
       The later can be extended to nor->manufacturer->fixups->post_sfdp() =
if
       needed.

Setting of flash paramters will no longer be spread interleaved accross
the spi-nor core, there will be a clear separation on who and when will upd=
ate
the flash parameters.

Tested on sst26vf064b with atmel-quadspi SPIMEM driver.

These batches are based of Boris Brezillon's work at:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D80353

These batches depend on m25p80 code move and a recent fix:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D120475
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D122416

You can find my developing branch (not stable) at:
https://github.com/ambarus/linux-0day/tree/spi-nor/manuf-drv

Boris Brezillon (3):
  mtd: spi-nor: Add a default_init() fixup hook for gd25q256
  mtd: spi-nor: Create a ->set_4byte() method
  mtd: spi-nor: Rework the SPI NOR lock/unlock logic

Tudor Ambarus (4):
  mtd: spi-nor: Add default_init() hook to tweak flash parameters
  mtd: spi_nor: Rework quad_enable()
  mtd: spi-nor: Split spi_nor_init_params()
  mtd: spi-nor: Rework the disabling of write protection at init

 drivers/mtd/spi-nor/spi-nor.c | 417 ++++++++++++++++++++++++--------------=
----
 include/linux/mtd/spi-nor.h   |  23 ++-
 2 files changed, 260 insertions(+), 180 deletions(-)

--=20
2.9.5

