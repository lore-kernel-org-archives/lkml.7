Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCACE22CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XnGi4Lma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfHZL6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:58:45 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22005 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfHZL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:58:45 -0400
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
IronPort-SDR: AB9yQUCCwCEOnN4FD3asV3BuOd6YknWKcEQl9w8vGF/BpL5w9i/BFItpk7Ia4K2d5L0hiHIv30
 haljBobXy8KEyDLftw8M9CaqStlQuXLc8ik84xXOk3JxDurvGAhr5b/5cmGazoPfSfyjvVQY1H
 e9bUImhZqelpY/9t2PPjHTMoRDPBuwRNZd4OEPCCYB3F5uHcdkVfDIXc8qkgBAz1EEvouUuj1d
 hoK5359V1Lr6975bjMl7rwQKO6QGX/SU+Udcef+ZIqdgalFumCMTJ6v4MRhwRdpEKEiHKi+42v
 mCQ=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="44987613"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 04:58:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 04:58:43 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 04:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN7SwaCQLgOWM+LB0s3omdi26MwDaBkKmdtQpg8/gGPNkYouaXYuH+Lu0ptML6f+ynt5Z7n+KOxgKJBUZO/vpSNBG+ISfjXb4ZGm4JhstbAIVKxWJnHPVXCEdfS2ZamWb3wynnlEMPFEAeC8lS2sOwuKd5f0JH7LUZxVlDtknNju/IGrYG83crXVCENFhOLuQRNYcIa98wXFtGufXHGW2FPTE4qZJ9uwixNkaIl/p/1pjX0LlevNwjE4u3fIPbSLvJWsbVqSLbXGWRJtCwGvhz3MhJjZgGlZ4fE3MYUlBDOIjfV1jlRjNm1iq3NRXIXBylSwk/SEaThCwZUds8chCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh5gELZGDZjGE3vCLY8uS2usuq0UtlUlwYFVIFVD7NE=;
 b=Id5mNYi2yWAozxaeQ4OE0ZzpqZWrP1k1MoIch325E2HSXu2CLNLfI6HpggXUb4VcIZRnegBuBOWzmsuMIsAX7dI1LB05l2XbsOhRaGVb+O8LRETAZvY19++3vnLxYhZMzXju0jFxy1SwK+P7JLtGtNEFh4MJRQNKhtMdKPmrc8N7Jzpu8ZdU2JdXW6mpd0OuQWWNO/096e5ScPyYt88IDac4+dEs0shPQqEpz/izA9Xo+qmaSdCF0O9qFycn8bDkka0XM0Sys8mpEcYGXXm6Fd4lK3L3cDFAsee+68gYAXmvV5faonbvrpbDytUeSFikxGBJ4qMCWA1v9v3DNRvUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh5gELZGDZjGE3vCLY8uS2usuq0UtlUlwYFVIFVD7NE=;
 b=XnGi4LmasVEKJb82HU/g+yZmrSauiS0O/rzTD2lfVttAniBKg2eYJlTa3pyMCvDwrEAkNe8P/xv3OWIym693BGLytlr68AzOl1VCnTTRQS5+ox0Ikwh15bdN39NHipuPs0SVcZe5GtJRQz0s66hdFaewfqRzWq1SjKC9myU3uvQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:58:42 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 11:58:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Topic: [PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Index: AQHVXAWaaFubNaAlfEiKmjbmMwLXNg==
Date:   Mon, 26 Aug 2019 11:58:41 +0000
Message-ID: <20190826115833.14913-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64672a0-451a-4df0-d372-08d72a1cbd18
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43502F747242F97CC0E6FC77F0A10@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(386003)(66476007)(6506007)(66556008)(64756008)(81156014)(66446008)(66946007)(14444005)(256004)(8676002)(81166006)(71200400001)(71190400001)(25786009)(6512007)(1076003)(6436002)(8936002)(107886003)(53936002)(36756003)(6486002)(5660300002)(4326008)(50226002)(486006)(86362001)(66066001)(2616005)(476003)(305945005)(3846002)(186003)(52116002)(99286004)(6116002)(478600001)(2501003)(7736002)(14454004)(2906002)(110136005)(2201001)(316002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OFb1sTiO/JbV/v9enPERMqzfRIcmO9dUlHpQDpXyeP4JCAOddVeDcQU5Axzfgz0D6I/Dpf5mKuJ46JaUPnPdR6pK4OXxkve7hJAwoLzpjhqdZWGhGRW8AdXeqmoMVZNppJ5+90L1/uXyaRsHmCWvLWp6JSrGXDaWJpatZazhFCvygRe20/qJn4FlLL3KHO8PcQ8CSyv5L9B0ERwf59H6Zjz6nkZL5rSG9g7hWKMqMguVcCj0TB05Y9mq0Lo8GURNT3ieBKdH2jO/7L6SXHK4XBX61IFzeeq84iYrUT/kcBXJZrLAGC3lFgJmyFDwLe8g2xtQ3vO4HXv1OlynJAsZXHenVVnecRZn99x7FOh9SlkfIH/IqzRad0soVszOvG05PDsc0bf/xbr9J1prSFBUUJNbVW6AytEA6j+A32jmUtU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d64672a0-451a-4df0-d372-08d72a1cbd18
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:58:41.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zdk3PzZJXeiXgJwvGOH5K6q8T/3WcAfiMz3W7uEyrmpl9Sqen2A01wDg61Mp2C7/7RAozgEx4e4zpHnbtkqPHMjnbnAtufHUmMw9DsjaxBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

v3:
- Drop patches:
  "mtd: spi-nor: Move clear_sr_bp() to 'struct spi_nor_flash_parameter'"
  "mtd: spi-nor: Rework the disabling of block write protection"
and replace them with the RFC patch:
  "mtd: spi-nor: Rework the disabling of block write protection"
- rename spi_nor_legacy_init_params() to spi_nor_info_init_params()
- rebase patches and send them all in a single patch set.

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

Boris Brezillon (7):
  mtd: spi-nor: Add a default_init() fixup hook for gd25q256
  mtd: spi-nor: Create a ->set_4byte() method
  mtd: spi-nor: Rework the SPI NOR lock/unlock logic
  mtd: spi-nor: Add post_sfdp() hook to tweak flash config
  mtd: spi-nor: Add spansion_post_sfdp_fixups()
  mtd: spi-nor: Add a ->convert_addr() method
  mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag

Tudor Ambarus (13):
  mtd: spi-nor: Regroup flash parameter and settings
  mtd: spi-nor: Use nor->params
  mtd: spi-nor: Drop quad_enable() from 'struct spi-nor'
  mtd: spi-nor: Move erase_map to 'struct spi_nor_flash_parameter'
  mtd: spi-nor: Add default_init() hook to tweak flash parameters
  mtd: spi_nor: Move manufacturer quad_enable() in ->default_init()
  mtd: spi-nor: Split spi_nor_init_params()
  mtd: spi_nor: Add a ->setup() method
  mtd: spi-nor: Add s3an_post_sfdp_fixups()
  mtd: spi-nor: Bring flash params init together
  mtd: spi_nor: Introduce spi_nor_set_addr_width()
  mtd: spi-nor: Introduce spi_nor_get_flash_info()
  mtd: spi-nor: Rework the disabling of block write protection

 drivers/mtd/spi-nor/spi-nor.c | 1304 +++++++++++++++++++++++--------------=
----
 include/linux/mtd/spi-nor.h   |  298 +++++++---
 2 files changed, 927 insertions(+), 675 deletions(-)

--=20
2.9.5

