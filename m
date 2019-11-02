Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944020679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pFrJ7D/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKBLX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:27 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39918 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBLX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:26 -0400
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
IronPort-SDR: SCePL+nPJEBTSZ7BPlEdMQF5bQ3gKYBRV8F34HF082+XW6n9bkYzdAzgw4CeW7EiB3XyZWT1hr
 ugQKdgZR+eVTCiQjqEbgWMGSELIEFk66b0ylwgPZLf4aEMIjjUCLdBcM6weVjR1tRfw2Yj12cF
 KbaQyDXA97QluJgrSiYGlI3CrMiGG+ai5cHCmsPh19Q+8mjxITpJ01rt73z2c8mM+DeSHvuxvZ
 haijpqjKWJeLN12nWjYu261eIziy12Cg4AaKT+7TZ57SXYfOebMDw3e441lQ5QNOaOdyYVYTH9
 svs=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900843"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:25 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA14OEh/iiMHYnxvD9DiOBioNQCM0F87rQJsI7W5hbKi9BKqv2GFd8d2Wqw+LL4Qd/GGF1Riz4MRJzrKdoYo32NRZWtShCyHjpBRbvkey0EnwcK9NuK6MaNmY7viKUX4aevzNI6dD+iJ8dWB/q3e/Kv/1ayvakkjGHdnYHyYZKW/QYM3+yx314iGRuPptDfaPmPRLd2y3HW7cxQiU8FdaYtLycchMc+IYJUbceLZvpmZ3bIQROXF3NDVIsFUUNTqr6yYA7J44K47aEdYrHm0GYvnHNrIr/u6Xd6IcJtEq2FADhq6oAs/l1ueVokmf3T4OYyAU/8oMs93bj9RhWgF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZ+YTrwDtyyxhTuNWHqB1tIrbevGYqfNs3Cs2q3oiM=;
 b=gg8bKNZ0Olhn4zBFVJ6R/4SJFFJUmVYHCvlS8pWoxUcFprESZqK6seUQNRU5PtfRInu8Qhd3og002Tksw5i72bYzLbx77Mu8IBDnijoY0NAXXTMsi6h6EKHwxUstHOxCzcuDEMA02cd4Ex7lDqdh6IJ/+6TLElhSEmgUhD1tb+g9WUbPrw3Ml3XUtuwMqfemDwwmpTowAs2gBwqgRHO3f5zn4lrKeIhX4fayufokfr1Q78BrpnZ3xToY6ggcyTZEooDHb9XUDX6MJCG4olJ3RRVvURp3QDYgnZ+cw1X3erK3+EvEIpD4gqlR6j2Iu1c6IHHUpf8FckwR7lXVfLdYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZ+YTrwDtyyxhTuNWHqB1tIrbevGYqfNs3Cs2q3oiM=;
 b=pFrJ7D/2T1ucas4GFH9vgH7VqO44ezZFATc8+OrMTjLwcKnoq/nOffgEw0MTN3K8CnWJ5Aj4WEthjP5ReIsYnanD8kbqb1uocK4R7dkKSPyj6LmYA1xrMD6DndJzuIw9csmZO2BUY0c+4uhtuXV3lwE/FBt7zhLkt94FXo70zCw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:23 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 00/20] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v4 00/20] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVkW/w1K7mIia8jkCIYuk++qibtw==
Date:   Sat, 2 Nov 2019 11:23:23 +0000
Message-ID: <20191102112316.20715-1-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 1e8c085f-7397-4fc5-c6d5-08d75f87129a
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371131AAF004F326DC50CC10F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(64756008)(386003)(316002)(4326008)(5660300002)(81166006)(6506007)(2616005)(81156014)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHX4bTMs0UY/dPEiOeVFheT/D/0AWhGHxZVxCMu5Y5x89Uv9Y2wfc4T0iSqsa48b3/z28tF/lkOCgdpI++E4LX1pLhAEOXkqNMhsmc52V9lPe0txVGuJ90dpE8BGIp/NYwjHip3d2FLxjhUgZ7+QZfpc8WW6L1CoQqgt5QJTnYulfoMXe398H9HqF+mQhbM+6+1BjHCOS9mcEvosCd7A+gLv2hA7133xkoo9AHNDqE0gMbWSIOxfox8VP9ppxQpjezUVE89XqN9oL9IJKE5PC1n8vQBow5OHqv0BScleqTdxhmC53odP+csCUurRBYlSzH7G2BDyyPcdJ+f2NQM352Dt7nfnpXj3iU8RYwrmDMfD6bLs5zHAm8yqNupWCufpIybf9j+DV/dkIR/bmongo7opbNYqTBKjpscn1Q8COLH7q3UJqbgPms5kfvgtDGmW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c085f-7397-4fc5-c6d5-08d75f87129a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:23.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q29eMiwDb3IVwjn9wNGpU5RBBwGw6wzHuQ+mFzlFeB/+Xg5PW1O/A5Yzcx0MwlKOy6nDqPcRh+VJfccBaj8Ca3/tYv1fHsYGNaNw+DULyOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Tested on s25fl116k and w25q128jv-q.

Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

v4:
- Use dev_dbg insted of dev_err for low level info
- replace "&nor->bouncebuf[0]" with "nor->bouncebuf" and "&sr_cr[0]" with
  "sr_cr". Update across all patches.

v3: split patches, update retlen handling in sst_write.

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

Tudor Ambarus (20):
  mtd: spi-nor: Use dev_dbg insted of dev_err for low level info
  mtd: spi-nor: Print debug info inside Reg Ops methods
  mtd: spi-nor: Check for errors after each Register Operation
  mtd: spi-nor: Rename label as it is no longer generic
  mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
  mtd: spi-nor: Move the WE and wait calls inside Write SR methods
  mtd: spi-nor: Merge spi_nor_write_sr() and spi_nor_write_sr_cr()
  mtd: spi-nor: Describe all the Reg Ops
  mtd: spi-nor: Drop spansion_quad_enable()
  mtd: spi-nor: Fix errno on Quad Enable methods
  mtd: spi-nor: Check all the bits written, not just the BP ones
  mtd: spi-nor: Print debug message when the read back test fails
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Extend the QE Read Back test to the entire SR byte
  mtd: spi-nor: Extend the QE Read Back test to both SR1 and SR2
  mtd: spi-nor: Rename CR_QUAD_EN_SPAN to SR2_QUAD_EN_BIT1
  mtd: spi-nor: Merge spansion Quad Enable methods
  mtd: spi-nor: Rename macronix_quad_enable to
    spi_nor_sr1_bit6_quad_enable
  mtd: spi-nor: Prepend "spi_nor_" to "sr2_bit7_quad_enable"
  mtd: spi-nor: Rework the disabling of block write protection

 drivers/mtd/spi-nor/spi-nor.c | 952 +++++++++++++++++++++++++-------------=
----
 include/linux/mtd/spi-nor.h   |  12 +-
 2 files changed, 583 insertions(+), 381 deletions(-)

--=20
2.9.5

