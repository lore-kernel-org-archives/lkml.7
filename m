Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3227C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CFB217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bNGr10gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfHZMIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:08:35 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24870 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbfHZMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:08:35 -0400
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
IronPort-SDR: DTBEqRILX95idGbK/zfU02QvW83S78dbYNGNRoIv/RA9ojssYqoY3yAoxW63rfHLYxxz5daHY5
 1fvmksz5FsyYYOwnhUhlNBpjXNodW10XqW1d2Fepd9cFzQD9ncwCWp8wOkZqBBOCeK0c1ORcLP
 Q/r0C+sFytOYcvMLyzogm2uqmonAN5AyWDvpuMAHPbCYgxZ8rXMuDoLMXeBElTytEvxOcM/ikD
 qRERZj4oP1ZKMKEIDhR3sI5J8c6GbVatpkoTxEGy6UYFpXNcGzwafSH/B0W1U8m/VsZ9IaM9cw
 R/0=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="43686870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:08:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:08:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 05:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LArusWyJ9IvYyCvTIcjI2CsRbK3lex12T4p/P1sZ/+RD/diLtW5CiAMLTb4SZ8HOTVJElgPSAq/kj0/l9M7vRyQVexH1IdXeJ2sE6yE8ozZZ8c95IFaIuL8NDlmtN2LQXRK/6bk2YBQKfdkJgH+yvucR9lSIGY9P8B2xx4ESx2tFkxU3ghg6D8kerYHvBHvANnwCQxhwTbkaCdH8euQe+LXQLiWAu63fu3jcj6lDboV6aOI3ziWSV+Dok1qrmHjZOGukdrZSvBXDLSjBlo22LzzvZObVC1q+0YzIG3lj4F/J1y3D/ztDDHzbvyvXHhEgeBgy/4aFLcIVufObqBYOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L49BPHoaxTE+dbB3Cl1gC5Nenk57omUeyLEZr1xIhV8=;
 b=GhcGelIeHvT5a6wVCfgmYscFmcjDWo0WpX/zsPGZ2Zt/nRYZI2vfzStwN/R2aDXgX+UnQoRmER6wriLR01siRhnRhSkXoE/d389bp2kcGCTPKG1jPehOhZbOPxEDW+xSvCbORzo8FIbTC1si/IW5p7s4HU9M+H5H0b0A4tRXvtT2A8xg/VRyrWV8PEyKM0jOPcPYmB29tEOz4bAS43ot2MAscoDVYRTEkB1Gpmj3g2dq8zTrMdj7kZCRC2SBMeZWIF9H2p0JEwCDMFZLmEBEA3qd7I/jn8iccUykUxeDHmTl9S5GP5yJjk2/yI8K+hlWpuurWi6hY0fA2Khvt33xWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L49BPHoaxTE+dbB3Cl1gC5Nenk57omUeyLEZr1xIhV8=;
 b=bNGr10gP51/zingfzKyl43smHx5BBvDx1bwlag6xTDBsOiD3KnKXzJ1kLOZF5hjgXuVfqJNey3YKNq/ybu+blvfzZ/DLTjjlTYjMjgeUrG0TF0VFW0xsqE0n1IbNKEL6VXNgJqH7Aag0N57tM1jaoCVgHHws5Z/YfJCOv++Rk3w=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:08:30 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:08:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Topic: [RESEND PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Index: AQHVXAb5BskU+i2FLEuxBjAKiOchAg==
Date:   Mon, 26 Aug 2019 12:08:30 +0000
Message-ID: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:28::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4a2fce8-f28c-42b6-ecb6-08d72a1e1c0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3776;
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB377631C85CBD970C1FA1EA51F0A10@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(8676002)(1076003)(2201001)(2501003)(14444005)(256004)(26005)(7736002)(99286004)(66066001)(2906002)(52116002)(316002)(186003)(50226002)(8936002)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(53936002)(2616005)(36756003)(25786009)(5660300002)(386003)(305945005)(6506007)(102836004)(3846002)(6116002)(478600001)(4326008)(86362001)(6436002)(6486002)(6512007)(14454004)(71200400001)(71190400001)(107886003)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NtuhTvWG/Sr4NnMWhqZFQATgolVN9BftbGks+qUVz3PWCNasrgjjIBcqBZnUVm8snt4vfBEPFmkjx7OV90R9q/vlwt4Z+bqOwHfZFr+WWSubmF/SZQfP7uietTeU79hoHiPOZDxPS2yNbAUU20ZHv5sS7n7/lqx+ruXT00S481LvCzUimO/i7CUA+H4G6dwMZHrh3javRdQJWjnXorrNYOabMXZN2zcbXil9Rtox4iVUSgI41TqD8O+iz7CuH75ejAUrbRbGY+pFDZHZSKle8s0MZfn6GGj5pX1NuKSCu+ey1eN7yfeV35cpWxUii18kSAjwpIYF49Z40HN6isAFbKZoyYvmHqL9zEZQi9cE3x0crSCHutEWJh9/4S4fOjo/VbPw0zHDu1+tpjwvDfbTFQD057eiC+WVqiQX60Xdc9g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a2fce8-f28c-42b6-ecb6-08d72a1e1c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:30.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvrqPMqqLt7ckAdjUIk7joo+tvPDLfOSRW6aZntCqCz1SlWusiuDZz/gf21QSAGIcHp2HlHceUDL/cvWTzeI2yLGVsSz83W55GoVf2oXyI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
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

In order to test this, you'll have to merge v5.3-rc5 in spi-nor/next.
This patch set depends on
'commit 834de5c1aa76 ("mtd: spi-nor: Fix the disabling of write protection =
at init")

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

