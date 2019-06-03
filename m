Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D36C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7C27EBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="voXMYeul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfFCMoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:44:09 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:39902
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbfFCMnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUGFUHjDuC9zQr7lFbbDIbJGIAyqnoCUl1vz0YJezgQ=;
 b=voXMYeuleti8qC6bYC9T86dJIz9KK4vRoQK8YuHQ9GMQhrtaj6FUkdkzEkNcyxyVpXDMa0/Ju/cNNwaYvtURFZfQTQnSUA721SzYiMrNQJWRGR6wCUoWP5OAB6Bmj/UN9QCBpI2b9j5ZeRe23xEgQucKecvnwlBBY/xzKZs0DuE=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:32 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:32 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/12] mtd: nand: Move ONFI code into nand/ directory
Thread-Topic: [PATCH v3 06/12] mtd: nand: Move ONFI code into nand/ directory
Thread-Index: AdUaBNtca2KDLPT1Q8mI6fj/40cXiw==
Date:   Mon, 3 Jun 2019 12:43:32 +0000
Message-ID: <MN2PR08MB5951D8BB1624C922812DB38EB8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7939fbf2-89a4-4d78-aa13-08d6e821167a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872E75243C5B860E2C851DBB8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1wlj9f+DGpNcaLCEGDkK4qrMFf9kDneoUupWHf8OFKZM+nwxium/mOPHWV/RQcgNBxmvisLdyGpCX904ztXwmigw2xznh/aIgim+osbRFDsBL144IqfZ4d7sgGXN8cMm6lW4OP5kxuqXxX3/vZwNjiXSihtA+qWiqRGpZMLhnFr7iPq6nUCcfEp4Ox2ixop2XBKI0A0dKGjwM11WCARdi357tngUyeZbg3erO7WHx+rIOw6zC9VT7+BgFaDcOxC0EgrGqA7vJbeHzBCjUMVD3StB49ZQYJt6Mimdk3Y73FjFrtlT5Sqa1pg2uYn1GxJOOR//ye9oeBD8pE4ZVNkXphPHybYoPkSN0dZn8gH9xt4rSDPGju16adWS+dpLMjQRfzj2Q0AFFB+zH5KBP+RYFvQOTAtmyOdSjOLcb5hn3EQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7939fbf2-89a4-4d78-aa13-08d6e821167a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:32.6487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move generic ONFI code to nand/ directory, which can be used by SPI
NAND layer.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/Makefile                    | 2 +-
 drivers/mtd/nand/{raw/nand_onfi.c =3D> onfi.c} | 1 +
 drivers/mtd/nand/raw/Makefile                | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/mtd/nand/{raw/nand_onfi.c =3D> onfi.c} (99%)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 7ecd80c0a66e..221945c223c3 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-nandcore-objs :=3D core.o bbt.o
+nandcore-objs :=3D core.o bbt.o onfi.o
 obj-$(CONFIG_MTD_NAND_CORE) +=3D nandcore.o
=20
 obj-y	+=3D onenand/
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/onfi.c
similarity index 99%
rename from drivers/mtd/nand/raw/nand_onfi.c
rename to drivers/mtd/nand/onfi.c
index 05592f815949..fad03bb4b1ea 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/onfi.c
@@ -177,3 +177,4 @@ int nand_onfi_detect(struct nand_device *base)
=20
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nand_onfi_detect);
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index ff7f90e9d417..9045336019d5 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+=3D stm32_fmc2_nand.o
 obj-$(CONFIG_MTD_NAND_MESON)		+=3D meson_nand.o
=20
 nand-objs :=3D nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_id=
s.o
-nand-objs +=3D nand_onfi.o
 nand-objs +=3D nand_jedec.o
 nand-objs +=3D nand_amd.o
 nand-objs +=3D nand_esmt.o
--=20
2.17.1

