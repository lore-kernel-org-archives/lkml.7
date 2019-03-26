Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ADA2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="MHeUsr3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfCZKwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:52:42 -0400
Received: from mailout.micron.com ([137.201.242.129]:57086 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:52:41 -0400
Received: from mail.micron.com (bowex36b.micron.com [137.201.84.100])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x2QAq0FC021932;
        Tue, 26 Mar 2019 04:52:00 -0600
Received: from bowex17c.micron.com (137.201.21.211) by bowex36b.micron.com
 (137.201.84.100) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 04:51:59 -0600
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (137.201.20.7) by
 bowex17c.micron.com (137.201.21.211) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 04:51:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWfwYNt8y0qwDEwgQzGpXIxvc9AnaxwFm0waCR2RPPk=;
 b=MHeUsr3b2zuJ+nsJmxrGfz94Dhhw1qEcM8huScjBK+Yp0SBTrCxPSBPbr4JwyVU/Ha4ms5hu+I2nN+HVs68bedBKEEyUMrYnG1xYR09K9Xar03/P5ZkdNkdUzN4fS10LdHZaZ9nGFWpGWOxNufwHN+vRl5GdihkWcwiikT9wofU=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5759.namprd08.prod.outlook.com (20.179.86.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Tue, 26 Mar 2019 10:51:56 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 10:51:56 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Liang Yang <liang.yang@amlogic.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 2/4] mtd: nand: Move ONFI code into nand/ directory
Thread-Topic: [PATCH 2/4] mtd: nand: Move ONFI code into nand/ directory
Thread-Index: AdTjwLylLmaJhZFZS7aXTwK2bTqhxw==
Date:   Tue, 26 Mar 2019 10:51:56 +0000
Message-ID: <MN2PR08MB59511F374C25C091FF6EB316B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 866db253-1fff-45c8-611d-08d6b1d910b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5759;
x-ms-traffictypediagnostic: MN2PR08MB5759:|MN2PR08MB5759:
x-microsoft-antispam-prvs: <MN2PR08MB57593E5B4CC77166FC15ED85B85F0@MN2PR08MB5759.namprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(26005)(9686003)(97736004)(99286004)(71190400001)(55016002)(81156014)(71200400001)(55236004)(6506007)(2906002)(81166006)(7416002)(102836004)(8676002)(7736002)(476003)(486006)(74316002)(14454004)(305945005)(2201001)(7696005)(186003)(86362001)(105586002)(316002)(478600001)(106356001)(33656002)(25786009)(66066001)(5660300002)(4326008)(6116002)(6436002)(3846002)(52536014)(8936002)(256004)(110136005)(68736007)(2501003)(54906003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5759;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hxDTIMXc6ROQZxkzoXK4utLZTqa4cyXCMB94101rLAbiu82svyJ72yeg/m1Q055PKnlrz/c0c6VG3ARUKO1DbEY8+qRD3G97UGJ915tOi9YUbFC/3xewAjZAWfpTVUV0m9oD2xqnQjzBQdaIymPcNevBokgMnzu4q+PeydsX68j3+SB4S0+FNOQnC/I1VmfQA5m30OrLXhk/uX5Ytx8A4PzMbB1ngRppbdB2r1dcvQvgb8ruV29USAMtVgf425qKObQPP7IwN4cmhmUgu3Oe8z/iBrTCZ4sztiz6Y3reTvtQoIJe8bhRx8AqB2ZzgNwiz5iG+7lFhF/ZJRIHkpxBSBRE6FEH06dnW9svBRSmoWyxD+AXLmm7h1slMoRd4q6+nC68vGxvQfYgLqSfrhgASZTpygd0x1jJRHdiBv9gUm8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 866db253-1fff-45c8-611d-08d6b1d910b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 10:51:56.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5759
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24512.005
X-TM-AS-Result: No--3.041000-0.000000-31
X-TM-AS-MatchedID: 105640-701604-700016-121588-701669-188019-121336-702931-1
        48004-148007-148020-148050-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move generic ONFI code to nand/ directory, which can be used by SPI
NAND layer.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/Makefile                    | 2 +-
 drivers/mtd/nand/{raw/nand_onfi.c =3D> onfi.c} | 0
 drivers/mtd/nand/raw/Makefile                | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename drivers/mtd/nand/{raw/nand_onfi.c =3D> onfi.c} (100%)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 9772e781534d..1b43a911aa4a 100644
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
similarity index 100%
rename from drivers/mtd/nand/raw/nand_onfi.c
rename to drivers/mtd/nand/onfi.c
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 898e90508a3a..3467bbb4a51a 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -59,7 +59,6 @@ obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+=3D stm32_fmc2_nand.o
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

