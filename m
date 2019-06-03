Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD029C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32127EBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="MW6KmWIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfFCMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:31 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:20510
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfFCMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4A5V5oFqAtoLfyAer5GJlkd4qrfwcebqlM8DtwhfPk=;
 b=MW6KmWIA+3LpFoiZ84gmjQp9OCBPtJOaEzhyAZEvOOvjrCFGRm3nZdUW7NidmiBjDVUC0yslkyjE/L2UjfMYW0+WCzxdaWR0WqF2TlzRbiZyWi7rSaK6Fm7Jyp8+F6AiZnDsO5zQ9OVNNwP93lkR55B+V5uXCLnurE+VSQof8xU=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:25 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:25 +0000
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
Subject: [PATCH v3 02/12] mtd: rawnand: move ONFI related functions to nand.h
Thread-Topic: [PATCH v3 02/12] mtd: rawnand: move ONFI related functions to
 nand.h
Thread-Index: AdUaA33lzTYZjiQsTQKPsgxjg8oWdQ==
Date:   Mon, 3 Jun 2019 12:43:25 +0000
Message-ID: <MN2PR08MB5951ABF020CC1DFD080A7A21B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd5ae25d-f1f5-4f57-3b4f-08d6e821120a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872AC129DA51F3BED26D2E5B8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B51J2wQ45XON2SS5llADr/YbfHdSTK/O0sQ5GLGgaAh9ENNOc3vo8Zk9Zb0jJ8aIzXTbzCsGxQwUawDTuzQPMHQ84PKX0mbZaLnJszoxPnbCkDM2VvSRVoHRnfGv9QahJjqHxFm4EpFfcnAof3EZC0E6M9uusQEejPu/TuDbzlOdImRafRsIWESIN9jJxPwKokVWVMDIl7xXISFe2oe+pzBrPijTgBW9uhRMoZJsY9wuOm/EraWSL12rwP7mrrSyFCvUOf6SCm9g+KBVdjTQml/8Iuw0DNLq6t3faZpNGWJrCaB5mgwXfV+a3IihboltcNm6uBJBRWncmXfX6dCLr2YY05dcorzKukTzDay72PorXiaM/dJTDvQKbeVtKKOtfzGlzC28AgQP7NpXZXFg3CZtHQRqh/IPPphHLOFizXk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5ae25d-f1f5-4f57-3b4f-08d6e821120a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:25.1790
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

ONFI reated functions are used by nand_jedec.c and in next patch
nand_onfi.c will be moving to nand/ directory, it is necessary to move
these functions to nand.h.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/internals.h | 4 ----
 drivers/mtd/nand/raw/nand_onfi.c | 8 ++++----
 include/linux/mtd/nand.h         | 9 +++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/intern=
als.h
index 4dc9ae108fa1..c7c684f533fc 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -139,10 +139,6 @@ void nand_legacy_set_defaults(struct nand_chip *chip);
 void nand_legacy_adjust_cmdfunc(struct nand_chip *chip);
 int nand_legacy_check_hooks(struct nand_chip *chip);
=20
-/* ONFI functions */
-u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
-int nand_onfi_detect(struct nand_device *base);
-
 /* JEDEC functions */
 int nand_jedec_detect(struct nand_chip *chip);
=20
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_o=
nfi.c
index e20b60b8dd93..939e2277830e 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -107,10 +107,10 @@ static int nand_flash_detect_ext_param_page(struct na=
nd_chip *chip,
 /*
  * Recover data with bit-wise majority
  */
-static void nand_bit_wise_majority(const void **srcbufs,
-				   unsigned int nsrcbufs,
-				   void *dstbuf,
-				   unsigned int bufsize)
+void nand_bit_wise_majority(const void **srcbufs,
+			    unsigned int nsrcbufs,
+			    void *dstbuf,
+			    unsigned int bufsize)
 {
 	int i, j, k;
=20
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index cebc38b6d6f5..3cdf06cae8b6 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -760,4 +760,13 @@ static inline bool nanddev_bbt_is_initialized(struct n=
and_device *nand)
 int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
 int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t l=
en);
=20
+/* ONFI functions */
+u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
+void nand_bit_wise_majority(const void **srcbufs,
+			    unsigned int nsrcbufs,
+			    void *dstbuf,
+			    unsigned int bufsize);
+void sanitize_string(u8 *s, size_t len);
+int nand_onfi_detect(struct nand_device *base);
+
 #endif /* __LINUX_MTD_NAND_H */
--=20
2.17.1

