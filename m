Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B0CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF08208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Bf3Sgrw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfJ2LQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:16:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16439 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2LQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:16:50 -0400
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
IronPort-SDR: t56jks3QGM7VVCJZiu1FAQAON24D4qQ4hqtkGreHIzGljd1ujX/s5ZlJe/9vbwaFIkcaKfGt+5
 O0UYa+q+Pljz3qeWVuDFxp8dq6OmdX6ZAyvde0V07E5jBsa/XBSUa+u4FadcGF74KiYtFFRc67
 UNKW0tfonbPnTAofQGH5/wxUP6eXUcwIGt+tdM0BeA0qaHzF3xxLafugFqMNzRjHnJv53i+gRc
 aN8taqQt5JVVcS7F8qEO+9EA1u6ttlp7w6TVMxpI5IkDc3rF9whAffYfp7x4TYxUG10/hvEUtT
 BiI=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53323505"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:16:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:16:49 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtEY1NBrcT8HhFb18X4M4wcAU0Or8ULxmfPr30u1T/58fdcEWX+SvMw/jpGKqB3SSNoxZFiC9bJUyFoG3tWwV4wcP0TvO/RNisv5PnkrvwyhWo/AETJ8rGozKwZLZx198MbZWhD9kiodDbOB5wFLfIODhAx79QBeqzhqT7lIaN5XQHlHMvJ4BflMaN39K13ZOFju4hHqhZ2qceG0mWq29SLlNQfAx5ruxuZ9XowLNSaB51XVAg4P1tXPIfE5GfL/OxrTBQOQENNcyYDXcQ8DoP0tcjzNbFJVlkjd+Y1ey9nO66DKl2kSrJhG0L9l2gtMWGKeOX7fHfMGIOLiPEnhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT2rG4h8XAFydXeGpirR/RgL9P1DI2UoZL141jJZhe0=;
 b=JoGMj5idc5AscKgnSqtGmYIMsi2NMI+96dRCczzYd+adlezXSPneYUDvgFHgK0h2tNttJKZuP9NyxvjE8O1BVulWrrijPQ7SX3I5sIvy8kI9NPhswqahNRnRckAa7a3OGlg9GcjhzcbiECGyDNoYz2b4ouEO4a7bDCKi1VawJZY87d5rwJP7s2mzo5ct5PuArqSSicNa7KC8pRy14Uy0JEAsVyhMpk7YwlmxWdgjpvfdoAoEjAGsxf6GY4grPLVoXe0dKHgUmeyqvjKYtsiedlYvwurS+obFi8ERm7t35xv7tDbKv5EmxIThdPqYTwHA9SjVlAEQ5I9FJ3dm7mPuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT2rG4h8XAFydXeGpirR/RgL9P1DI2UoZL141jJZhe0=;
 b=Bf3Sgrw2lnL12wOpDs+NwvmLbl+4DpgRbuK5svBdqXHLS37OmgunOUBeAEtqGaZUBr2PJZZ29HOap+kUO5pIJyvF3Wzh8macGXn+FsTb1hYM5MFDn7zVDppMv0/yMYYGg+5GJbocOtVATHZmEbEcEqYH7OAiOHYRlfhv6HTo4o0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 00/32] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v3 00/32] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVjkpasZGdubImkEKiA3/sngs/Jw==
Date:   Tue, 29 Oct 2019 11:16:47 +0000
Message-ID: <20191029111615.3706-1-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: cbe9e537-a86c-4b38-ab10-08d75c617ceb
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37123411B7A570533BB2F5F0F0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(52116002)(1076003)(102836004)(14444005)(71200400001)(71190400001)(6506007)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNR/c5HdEoKr+f/bd/iz88RvjrCoA0gncP9gcqH5KwtIV2nvOM+I/qsGLUWN04AXmui9w8XP5dt/DrQmcaTqYfsgHy/S822kOxpnr1OqFHt0PLxJxNXB1eK1eToLO8suPKoyUrPzRq7PzyWObfRX02LLoSS5S10l+BEGn7f4tGYfT6ay5OndQ1+WXG3tg6BqSfQqYAl6074kOkMuoabMf+7JRYKL8QWTR0WHQPmf5f86EEHzaN4njBLP4H31+IFdghF4Bs9OSrvAM8zTC1AoPZbNFtOFo89QcIoKfFQX+LWRQtYdA1Fxxrq9sqIFw++VKiBW6Hxs1B7Ht0i2y8YvJ7+gs4sczQZTZkZR3cuUIOD+YIyoD+2m7722GzfELofId65a7TVbSFgQcp5Khpvrb8JeDweWMb024b+mfZHsbqu8+mG/ONvggvTVdOKeBYT7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe9e537-a86c-4b38-ab10-08d75c617ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:47.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMLqo93KZSq3P3X/sc612AftY0QfYC7TV3S+q7re9Uy18EHsuiGHjTSQa2aorqaeTGte+aLq9LpgcmQGCJs8J3erTw/mt15bu5i/SI9NEG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches 1 - 20 are just clean up patches for the Flash Register
Operations.

Patches 21 - 32 deal with the Quad Enable and the (un)lock methods.
Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

Tested on s25fl116k and w25q128jv-q.

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

Tudor Ambarus (32):
  mtd: spi-nor: Prepend spi_nor_ to all Reg Ops methods
  mtd: spi-nor: Drop duplicated new line
  mtd: spi-nor: Group all Reg Ops to avoid forward declarations
  mtd: spi-nor: Stop compare with negative in Reg Ops methods
  mtd: spi-nor: Drop explicit cast to int to already int value
  mtd: spi-nor: Use dev_err() instead of pr_err()
  mtd: spi-nor: Don't overwrite errno from Reg Ops
  mtd: spi-nor: Pointer parameter for SR in spi_nor_read_sr()
  mtd: spi-nor: Pointer parameter for FSR in spi_nor_read_fsr()
  mtd: spi-nor: Pointer parameter for CR in spi_nor_read_cr()
  mtd: spi-nor: Drop redundant error reports in Reg Ops callers
  mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
  mtd: spi-nor: Print error messages inside Reg Ops methods
  mtd: spi-nor: Fix retlen handling in sst_write()
  mtd: spi-nor: Check for errors after each Register Operation
  mtd: spi-nor: Rename label as it is no longer generic
  mtd: spi-nor: Move the WE and wait calls inside Write SR methods
  mtd: spi-nor: Constify data to write to the Status Register
  mtd: spi-nor: Merge spi_nor_write_sr() and spi_nor_write_sr_cr()
  mtd: spi-nor: Describe all the Reg Ops
  mtd: spi-nor: Drop spansion_quad_enable()
  mtd: spi-nor: Fix errno on Quad Enable methods
  mtd: spi-nor: Check all the bits written, not just the BP ones
  mtd: spi-nor: Print error message when the read back test fails
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Extend the QE Read Back test to the entire SR byte
  mtd: spi-nor: Extend the QE Read Back test to both SR1 and SR2
  mtd: spi-nor: Rename CR_QUAD_EN_SPAN to SR2_QUAD_EN_BIT1
  mtd: spi-nor: Merge spansion Quad Enable methods
  mtd: spi-nor: Rename macronix_quad_enable to
    spi_nor_sr1_bit6_quad_enable
  mtd: spi-nor: Prepend "spi_nor_" to "sr2_bit7_quad_enable"
  mtd: spi-nor: Rework the disabling of block write protection

 drivers/mtd/spi-nor/spi-nor.c | 1645 +++++++++++++++++++++++--------------=
----
 include/linux/mtd/spi-nor.h   |   12 +-
 2 files changed, 924 insertions(+), 733 deletions(-)

--=20
2.9.5

