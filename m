Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA1221D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RXrhESGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbfKGIlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:41:53 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52766 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfKGIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:41:53 -0500
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
IronPort-SDR: W+9RQ/rpysbzb1TkbvWbwYq3MvamFhqsw1LYAdejLQMsSOIOjc1zRBkIIjtdLXb5A1xqyUUaFw
 vbVumDKiZQxF/IK3eFkNiUwI3wgk64VQ8Od+2kbsUf4SiZh7WtSyNpOjfKB4SXsuRDgC/7khe0
 94Y+iU+z3q42LAqcljaH3oVRK0pinpLgZuk+2JMcVWCsX2FdExmAg/cU+ZHqQCIMQBvrIVihjx
 cmX7Nwdr8Uj48xTKcdJtDdPmdN6K2zXek8Lrj8qXg3OVbS8ePDd++DKIGuGb7WeqqcqOOCn3Eh
 VWg=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="54526170"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 01:41:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 01:41:50 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 01:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoU8Gr6FyfyZDviie9eFMcs6eKMSZFenLj2cGMP+udLES3f8tYzLwVipMcx6vaBKD342PX0ZK7OY6+b3hpeEJTYyUh+5Tv8vwEEkwlbWyMOI8vXKtp0XTg/1qsGbe7SKG33VSCdovHt73iWkHMuzuD4aZ3k0GkRBK0WCRavcqNfOoZcnHQxT6n1hOuRCMwIXcX274YVNnCKmpAFMViGIr9TRC2A82rTTWjxdM6Fo/4RY5Z+beCViJUg9y3pdQmnECnn42x75HvEzkZMm4Q7AFDvKP6QGlrWwzJKcU3GgtUqNMdv9fk5qcmMLI0FwGhnVD0hokwMhV8SILAs0eN9UmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+2vPP3Qj33UwjsUb34ZCEcsHIGzLtc3ygMR43pcTrg=;
 b=nLfmaMQr9ZpIcUn83NeFZjK4wplisZ+H4laMOdnF80AxRUOBUAxHqS2wlSaKQP0y7FYyE2ef9P0tnNATvZP0FIDA3ji5gc6J5t9WXjM5tyOsChs17PV9qtegb9XC3SdAwp7hje+Hh8jJTFS7gZH91G6xJEGKvLJCXNre2RVXHNuvhWY+fCThIpVo3Gqae6itgfHnZlsLoZM8Zgn1U6ObIc+qgv8r20MVZ10h4OskacSli2pb7Qfkhuw/oZml5khsUiW2t1eI98FsThNTiZx43OEq0HlW8oNWl+4k62matEgNUTPzO37NLBqxyQ6cmUdvr3ZW588b41ZXtKM59K1QxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+2vPP3Qj33UwjsUb34ZCEcsHIGzLtc3ygMR43pcTrg=;
 b=RXrhESGZCSgQFUA9ksO//f1AtEUV3I8aOWrXDwYKk1wpz24TqODZCHHR1wU+iCDxhad+upesHcuhpGvn6aKlxrD3NTjzeauiKUZjB0Yp7mcikkd4o6nU2Xh/LswdcZFhZCZgb4o2rniaPwyiINj+q1dsC22w/y9oxucGl9vihng=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3824.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:41:48 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 08:41:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 0/6] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v5 0/6] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVlUcxNfurCR7UA0az+I+u2JP03g==
Date:   Thu, 7 Nov 2019 08:41:47 +0000
Message-ID: <20191107084135.22122-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::40) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [109.166.128.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922a89c4-25b6-47d0-fbfd-08d7635e536f
x-ms-traffictypediagnostic: MN2PR11MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB382411D09DCBDC2D07F4E158F0780@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(25786009)(6512007)(66476007)(6486002)(110136005)(66946007)(6116002)(66446008)(71200400001)(86362001)(54906003)(66556008)(64756008)(2906002)(6436002)(14444005)(256004)(36756003)(478600001)(66066001)(14454004)(8936002)(186003)(52116002)(316002)(2616005)(99286004)(102836004)(71190400001)(107886003)(81156014)(81166006)(4326008)(2501003)(26005)(1076003)(305945005)(7736002)(6506007)(5660300002)(486006)(476003)(386003)(8676002)(3846002)(50226002)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3824;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXm32/gEVZJrQZR4tUnVwRMTuW0g5a/tYULXO/TKjxsR+3dJfUsynedzo86g+4sGcaxxQDTLW5grPzp70itv8MXb3ooxHMzufrhWVGjdA2VknDG53Om1hKK3HuFTaDbGEkSuqetzZXzdbBEfASTsJ8em14QsUJuDuxlYoK+u1Ouvu+IGVxmaKthGN7aRp5pmtdwDBvo24HF5EaaGKtCGY5nx8Eb55CoQcgt6VVYysFUmEZsoJVwzuJYM+5H8+2so2T4aobAI45N9SUp8BuQUl4U+tOIe8Dfcoe6Tr9QHHtuxPKZB4NRm24VvYgIFbdq+IPm7+UCPc0FhHilzMnRREHUS44vawszxAAVQF++YgGNzcHx9KyI6rW4kYpDLuSkJdPRLwdK3UGZvxMsUOB14JhEUO8ac/T3oTvzPCbp4fEHkEiG2M63tTA4WOxKmdVmN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 922a89c4-25b6-47d0-fbfd-08d7635e536f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:41:47.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKSsrGZ96Bvn/kId5eSOltrXrEXOKBWG7nhB/1Af6OHG3NLITl1dVP90eobRD3Dikl9WTcot8BhBpGD2aAq+6ulKjTbr8Dcxr6MuTDwN+Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Tested on w25q128jvq.

Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

v5:
- Rename all Quad Enable methods in one patch
- Extend the Read Back test to both SR1 and SR2 in one patch
- Reorder patches, so that the fixes come one after another
- Collect R-b tags.

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

Tudor Ambarus (6):
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Rework the disabling of block write protection
  mtd: spi-nor: Extend the SR Read Back test
  mtd: spi-nor: Rename CR_QUAD_EN_SPAN to SR2_QUAD_EN_BIT1
  mtd: spi-nor: Merge spansion Quad Enable methods
  mtd: spi-nor: Rename Quad Enable methods

 drivers/mtd/spi-nor/spi-nor.c | 438 ++++++++++++++++++++++++--------------=
----
 include/linux/mtd/spi-nor.h   |  12 +-
 2 files changed, 254 insertions(+), 196 deletions(-)

--=20
2.9.5

