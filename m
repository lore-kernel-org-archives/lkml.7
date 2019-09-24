Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B85C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC45E214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LUDChKRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408147AbfIXHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:45:52 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:27979 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408088AbfIXHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:45:51 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0hw8cnv6oT+AdPa2QAC68CFyH4eDTPbj6GGFOxHetv9apz5U6/QdxmNLjZ/3oBouF50zpp3lLi
 oLaKNw1DFii9q2DGZonY+OpZS28ZSm4VBURRQu/0XL2aLwtnh8kW+2fAagsoZD4g3tpmU9f79G
 /5RvDLQN80lMJOSucbnWbIoa2128oFB3SUnnbTkaWoS2x8wwlWekxNkNazbg3ttg9z+MyhPORT
 8KptrjSV/dh8lJw5Zpd++Gmi8PfgmnS8cxIsKOauKryGUg0WlcWXoRdLAWcfCaAb/dElhlcSQs
 Blk=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="50281662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:45:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:45:46 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwXfDTGm5/aZPRoJpyXq9JShgok8y1tE2rGA6dAdWmdoL/Jgg1Kh6AMS0wJBlMKnAlTemA3e2bbQKEG0CQejtv8DCZ1DTw1rERFuaUYVqoe9le/NMrAoTqJ2hoz5Q5a/hiWbGozfLUaCHmtj5Gvx/1LR86stjd5uBwCb1FHj/EAlEc0qV4s4wnTVyXYYZc10aqc6257XfQr//OTtVPEI9eKZAuf7yl+DIxBzQGIoDRPt9cD/N35QzV8iH0VUE32vT78XNWXrXt9S/HHFvnfRDTT89fius0NTv4d0nShjn9H9i2wnfFMtclUrdNxnzodwX2Z4qhWde+qJG30NX/91uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAcmMyY8SgGOCecCRC6mku9wfzcu6s2jqfClUBSO43c=;
 b=UiOt2603n0WxADHczEpv6EekAj8JVj71XVICKKmPHpi9OEFUJHpKhfy6xwLX3D+sJLzFI05ZLIYhqce0W3wEn7LQ7rZ1hdemHaWZNaZMkOr/g4AIesKKeVezA0EXWNNUIw1h2HqXJxNcDCniDTlQ6GmOJhfwEZhmzubi60zhK/bfkliew5ZJb8ttRXxN166LfJ+ky+FzldiServLT4GSX8yWGLA0003JT1uE6153bl0x8ypTOSqDuWJWhkafY2tc7k3vzz+48ka50yziBDGaxFEd8IGLf4OANgDpC03W756NEgLbht2FhjZdZKX2Pe7xxhzdtCEizzG0co6Q+jQjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAcmMyY8SgGOCecCRC6mku9wfzcu6s2jqfClUBSO43c=;
 b=LUDChKRxB5i8gbcdK6xficQradyBwPxPMVF5vBJP7g7dVozyJllhKGoGhKbVaPJ4kEHShuAYUW+5kGeEhrENliM8rDMVnIc/CybdcXUeAiOhVJU4uGe30N9Mn9VhMfa+Tb6XRPGpL5RQjpq0un+YzwQjvy0MFx53l5herZCY3tM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:45:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:45:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 00/22] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v2 00/22] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVcqwSdD6kLiVX1Emf+kHUSzIQ7g==
Date:   Tue, 24 Sep 2019 07:45:45 +0000
Message-ID: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 735cf0e2-b911-4b93-478b-08d740c33507
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB431922042CFBABCA7FA459F1F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(66446008)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JLPd58/WQkDxO4f/qXIuUrpyKxfyaJ/FFNreNjD+qyTWkWCRI3XeDN7Fv5oP9aCSR6X9V3Mk86S8KEJhGGEiBeqQGKotilxKg5p88fEpvpULjjiv/s6nmqYZSvVC47xyfYIFS9iM4OxlHartBlw3h+Al5+NC6wpn2MnNk8YbonJXzysJtRdyngxsGZ3KzPVZHFRgzQg4P0VzYqdEjCGbPEzi8h4csF2k+dWKWxUI8ipQ0QSwPi/e3ZFl7hzTQyhlChwQdfwP1GMvI4br5WZ8+7FPiSI0vnDvq7vRi56sC0iMq7cnhjpqYV0Pq9MG02gQz189ABz4geUdv/Jacg/3JUtPmUsFkmkjMrh/fmloxSodhk4+qu69BiuvR9f2MHz1YNv6J0gL1ylKNTlsI7XPuLtyQ9KatXnvtmi4lnefR3c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 735cf0e2-b911-4b93-478b-08d740c33507
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:45:45.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aw8XKnJvL4QZMOQ4+pZrEwBSnltSbbZps1Fv+ommikhP6XmiPdypzm3prldoLx3YT5kBMN941UYr7X2VVTBCb9x31TmfT70aY7aEiMC71js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches 1 - 14 are just clean up patches for the Flash Register
Operations.

Patches 15 - 22 deal with the Quad Enable and the (un)lock methods.
Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

Again, this is just compile tested, I don't have (yet) a relevant
spansion-like flash memory to test the (un)lock() methods, so I'll need
your help for testing this patch set.

The patch set can be tested using mtd-utils:
1/ do a read-erase-write-read-back test immediately after boot, to check
the spi_nor_unlock_all() method. The focus is on the erase/write
methods, we want to see if the flash is unlocked at power-up.
        mtd_debug read /dev/mtd-yours offset size read-file
        hexdump read-file
        mtd_debug erase /dev/mtd-yours offset size
        dd if=3D/dev/urandom of=3Dwrite-file bs=3Dplease-choose count=3Dple=
ase-choose
        mtd_debug write /dev/mtd-yours offset write-file-size write-file
        mtd_debug read /dev/mtd-yours offset write-file-size read-file
        sha1sum read-file write-file
2/ lock flash then try to erase/write it, to see if the lock works
        flash_lock /dev/mtd-yours offset block-count
        Do the read-erase-write-read-back test from 1/. The contents of
        flash should not change in the erase and write steps.
3/ unlock flash and do the read-erase-write-read-back from 1/. The value of=
 the
   QEE should not change and you should be able to erase and write the flas=
h.
   Test 1/ should be successful.

v2:
- Introduce spi_nor_write_16bit_cr_and_check() as per Vignesh's suggestion.=
 The
  Configuration Register contains bits that can be updated in future: FREEZ=
E,
  CMP. Provide a generic method that allows updating all bits of the
  Configuration Register.
- Fix SNOR_F_NO_READ_CR case in
  "mtd: spi-nor: Rework the disabling of block write protection". When the =
flash
  doesn't support the CR Read command, we make an assumption about the valu=
e of
  the QE bit. In spi_nor_init(), call spi_nor_quad_enable() first, then
  spi_nor_unlock_all(), so that at the spi_nor_unlock_all() time we can be =
sure
  the QE bit has value one, because of the previous call to spi_nor_quad_en=
able().
- Fix if statement in spi_nor_write_sr_and_check():
  if (nor->flags & SNOR_F_HAS_16BIT_SR)
- Fix documentation warnings.
- New patch: "mtd: spi-nor: Check all the bits written, not just the BP one=
s".
- Drop Global Unlock patches, will send them in a different patch set.

Tudor Ambarus (22):
  mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
  mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
  mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read() definition
  mtd: spi-nor: Rename nor->params to nor->flash
  mtd: spi-nor: Rework read_sr()
  mtd: spi-nor: Rework read_fsr()
  mtd: spi-nor: Rework read_cr()
  mtd: spi-nor: Rework write_enable/disable()
  mtd: spi-nor: Fix retlen handling in sst_write()
  mtd: spi-nor: Rework write_sr()
  mtd: spi-nor: Rework spi_nor_read/write_sr2()
  mtd: spi-nor: Report error in spi_nor_xread_sr()
  mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
  mtd: spi-nor: Drop duplicated new line
  mtd: spi-nor: Drop spansion_quad_enable()
  mtd: spi-nor: Fix errno on quad_enable methods
  mtd: spi-nor: Check all the bits written, not just the BP ones
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Rework macronix_quad_enable()
  mtd: spi-nor: Rework spansion(_no)_read_cr_quad_enable()
  mtd: spi-nor: Update sr2_bit7_quad_enable()
  mtd: spi-nor: Rework the disabling of block write protection

 drivers/mtd/spi-nor/aspeed-smc.c      |   23 +-
 drivers/mtd/spi-nor/cadence-quadspi.c |   54 +-
 drivers/mtd/spi-nor/hisi-sfc.c        |   23 +-
 drivers/mtd/spi-nor/intel-spi.c       |   24 +-
 drivers/mtd/spi-nor/mtk-quadspi.c     |   25 +-
 drivers/mtd/spi-nor/nxp-spifi.c       |   23 +-
 drivers/mtd/spi-nor/spi-nor.c         | 1716 ++++++++++++++++++-----------=
----
 include/linux/mtd/spi-nor.h           |   74 +-
 8 files changed, 1058 insertions(+), 904 deletions(-)

--=20
2.9.5

