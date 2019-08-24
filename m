Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F821670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="e53YrNqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfHXMAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:00:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26836 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHXMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:00:39 -0400
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
IronPort-SDR: HisqCREbnoar8Gp3yx0YYGB2e+TnHeMQ6xceMhNNwT8bFJKoXJcFv+/9YlYeBoEkKKJpFOssrP
 6mAhIW7UWxDPD4bQput4pBcSEfYiDwylgWDcVFhPwX4B7Z0g0N4hSPFvq3HPykidFCkLxeU4ev
 XmKUY/YOchARNI/RB5np2pwEr7POw7U17yWJC2BnS/Fpn2vy+wiYFBvXkpVZ1S3Wod5DXjlUj1
 j/tz92W713nZLrYX8znCH6n/G0nFDBAMITZUC/Cfa+8stD/7lulxNXtRW4+1oQQiHnIxaooY/Y
 f/4=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="43547589"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:00:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:00:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXMNkfvCWPBUmOZJJ33zv/kq5V6aDeOmCkfTVp87IlGuf4Hioh0SLPEdpF+iGK9zxtIv6nfS4+3wut/67uDoOfHkYn8svWL1ZgPKTyKtHaYbDFdvPb27NQceXgqIddIZECc1Ei1qtfWkYSAUQPtJGBxY1SfVWDQN2hsxzJiOC0kvdGUi17gosuVZSBy1gzpQYLbLf1lxy2V+gMEVSAcXouE00/74av3IW1QHFBy+wRdBpeyyqPGrpl806VvnJcPlIMs19b3h0wp10kr2/4uSn9xplbnr5KMmt029oviyIqel6iZ5GRy5CALxMXCPbuPqbVe+iSN6nrjnTFIH3FWEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g57hejKdaLLXyQXxyLaiK2pDG279BFTxNVVdeCkjXbc=;
 b=Kzqynlj3/CeqIi4or4/HTgSiKim7gEbIL0pYbyVlLVxkjNp2Hi7hJJDbRFYpMJ6gcKdsWJpl5Bm3cnPysgIagjDHg+jxJSC3e5BIgY4nfkj3c5qzOLNj/KjwIPHBZq4S9oKF9yTe6qZOKL2YhJuCkOm7HZso/sefxxDC3OFSlrSHXnejwY73GB0SOmsaKlcdqX/GaazyQ/P9lKbSbv2EZGp4A0jzWNGOngSEpX2CVD+ZyZ+H6iP3Gm9IJkn1A6fkUmTnG6piXp0yIqOSBCijEzABAWmbg08U1NMw4cBy666HIZ5E+VXr8m9ugcO4nvanveQo6jTU4LinKFUFPcSbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g57hejKdaLLXyQXxyLaiK2pDG279BFTxNVVdeCkjXbc=;
 b=e53YrNqswiOAIZCHAjMJhGdmipVXRTg2nj6vzuewOF0Rla7hemLbFUVjzoUcIO+e6KoERslaC1ZPfCa/rB8SIsNEU48EMa6wtNjA2sijCRuLBfmOJrkQ0xh067iGQARhCJgrwJYEG12i9t5WtlnQlW727VFu4CWlCQOTX3uLJOo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:00:36 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:00:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 0/7] mtd: spi-nor: move manuf out of the core - batch 1
Thread-Topic: [PATCH v2 0/7] mtd: spi-nor: move manuf out of the core - batch
 1
Thread-Index: AQHVWnOJBVrYO4W3AUmhEF6UV5mzqQ==
Date:   Sat, 24 Aug 2019 12:00:35 +0000
Message-ID: <20190824120027.14452-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0194.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f2ce313-0bea-4494-6795-08d7288aac40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984CA98E948B79E341F6E9FF0A70@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(110136005)(25786009)(26005)(4326008)(1076003)(256004)(316002)(386003)(2501003)(81156014)(6506007)(8936002)(14444005)(64756008)(66556008)(66476007)(66946007)(6436002)(81166006)(66446008)(8676002)(2201001)(53936002)(5660300002)(86362001)(6306002)(6512007)(52116002)(71200400001)(966005)(14454004)(66066001)(476003)(305945005)(6486002)(36756003)(7736002)(186003)(71190400001)(478600001)(2906002)(102836004)(99286004)(50226002)(6116002)(3846002)(107886003)(486006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: omBokpKnyJD3uNayleYKvpOXsc1GZnjkuwY/X1t9pXJHnmuNeutd67OWoNO3B05r3uxsUF3ccCkJcahMiVpr9B7ru1cQcS2qZoyDmmEu95VMsFGErydqo7GxolfKBX5Wi/IQNBuqNBFuAur5x0SlJKQh6B8DcHn+hahNH++fG6edDN7LYbzq15dMSaPczPV4e1owkQ+e7m2B2JIrm+yveLCaj4H6ol/pxB6YHvkMTci+Aionh5dqaGa5EZFDMEoS0l0IPvLeF08p8sz7zGXfjmCxQZepapLaR3VuQcPcwEMGCSDx+7B4QlGpfwlOcIQLQ2JgPac3VMi57Fmkf9qFRO9DoxXS769HteQgvRp1AreZKPaL/4hFrAn95rZSO6gfk4vjCQhJEA42XL5xBekEVE646CrgwZfFop2XxcVHZhA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2ce313-0bea-4494-6795-08d7288aac40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:00:35.8433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 404SKO1q+Em+0KGI91X811b7hLl+OMeyDSBQpdCfybmIxRb91PgdJYx2Fal3/p39q2I1+7P4rBVDfyo4n96a5WXfY0P9NH0cDgqTODf1n1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Depends on 'mtd: spi-nor: move manuf out of the core - batch 0' series:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D127030

v2:
- addressed all the comments
- all flash parameters and settings are now set in 'struct
  spi_nor_flash_parameter', for a clearer separation between the SPI NOR
  layer and the flash params.

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

    3/ specific flash_info tweeks done when decisions can not be done just
       on MFR:
            nor->info->fixups->default_init()

    4/ SFDP tables flash parameters init - SFDP knows better:
            spi_nor_sfdp_init_params()

    5/ post SFDP tables flash parameters updates - in case manufacturers
       get the serial flash tables wrong or incomplete.
            nor->info->fixups->post_sfdp()
       The later can be extended to nor->manufacturer->fixups->post_sfdp()
       if needed.

Setting of flash parameters will no longer be spread interleaved across
the spi-nor core, there will be a clear separation on who and when will
update the flash parameters.

Tested on sst26vf064b with atmel-quadspi SPIMEM driver.

Boris Brezillon (3):
  mtd: spi-nor: Add a default_init() fixup hook for gd25q256
  mtd: spi-nor: Create a ->set_4byte() method
  mtd: spi-nor: Rework the SPI NOR lock/unlock logic

Tudor Ambarus (4):
  mtd: spi-nor: Add default_init() hook to tweak flash parameters
  mtd: spi_nor: Move manufacturer quad_enable() in ->default_init()
  mtd: spi-nor: Split spi_nor_init_params()
  mtd: spi-nor: Rework the disabling of block write protection

 drivers/mtd/spi-nor/spi-nor.c | 320 ++++++++++++++++++++++++++++----------=
----
 include/linux/mtd/spi-nor.h   |  25 +++-
 2 files changed, 233 insertions(+), 112 deletions(-)

--=20
2.9.5

