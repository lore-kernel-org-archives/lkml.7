Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51547C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D62805E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="cKzk3TBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfFCMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:39 -0400
Received: from mail-eopbgr750081.outbound.protection.outlook.com ([40.107.75.81]:35335
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727675AbfFCMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49uho8PXTG3BUzuqMEOeKTa/Lmq+qMFpFX8svDm+OMU=;
 b=cKzk3TBe2p9UC4VGPHS2g9U9rIqacFNVOOsqOv5DNHOlSfTuSAxAtrhhrVzSmNOPwdY9JL8TENN8jZtcLxyKwxZsLQgQYuD4N+zwTUM2RIjvr/kpfw1dPrLy/SGFjBCyuHu4dlEzky/kb+VKyG3cBavqDAwJonE1iit10kWwxeA=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:27 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:27 +0000
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
Subject: [PATCH v3 03/12] mtd: rawnand: move sanitize_strings to nand_onfi.c
Thread-Topic: [PATCH v3 03/12] mtd: rawnand: move sanitize_strings to
 nand_onfi.c
Thread-Index: AdUaA/hcpPGw56iXSLSBfv6P/4KvCg==
Date:   Mon, 3 Jun 2019 12:43:26 +0000
Message-ID: <MN2PR08MB5951B7C2961DC882DADB8CD8B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7857bc8c-005d-4241-fcb7-08d6e8211319
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB587206E42396A6C6A46B5C26B8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ut83Y5XrOdHjZSyQ7/nreiej7SmkgihmrMGAij6b4m7h5r1gqBNuvs9xfajDXMTyHIxieEnA7AVV7OLYSUnJLXrlYI3UmeYU0bEH4oftb8swuB9pODCUowS005nUq4OD98RYwfRALZQLvAPeUTvNL2sOUZIxVPtqROgyX5w3844s1BSSLUefMmMLAYtoFjCT5QIGlSiN5+oRXKeOhF/dBs8p0Xo6tFy0M8J1PiEaaRVV6/zHbF9FWj8Y1cSu/OAzhmk6HGrgarVozzn/q+JEc9Z/W47qOka0pD4k0GKIobcfbaIBpjWMMpyBtAZ+RDcO00BET00gI2DyWFvXjWfb9hwm1B02PBbOzOuOK0fgz82XdS9ceciSV7AQJBeCmsgvLn7NnR9iWB8QlSDVx/ub9YCDc0DfyNRftmnyKMNbxXk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7857bc8c-005d-4241-fcb7-08d6e8211319
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:26.9210
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

sanitize_strings is not used in nand_base.c but used in nand_onfi.c. It
is better to move sanitize_strings definition to nand_onfi.c, with this
all ONFI related functions will be in the same file.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 18 ------------------
 drivers/mtd/nand/raw/nand_onfi.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 96a93481420f..c28ed2da733a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4375,24 +4375,6 @@ static void nand_set_defaults(struct nand_chip *chip=
)
 		chip->buf_align =3D 1;
 }
=20
-/* Sanitize ONFI strings so we can safely print them */
-void sanitize_string(uint8_t *s, size_t len)
-{
-	ssize_t i;
-
-	/* Null terminate */
-	s[len - 1] =3D 0;
-
-	/* Remove non printable chars */
-	for (i =3D 0; i < len - 1; i++) {
-		if (s[i] < ' ' || s[i] > 127)
-			s[i] =3D '?';
-	}
-
-	/* Remove trailing spaces */
-	strim(s);
-}
-
 /*
  * nand_id_has_period - Check if an ID string has a given wraparound perio=
d
  * @id_data: the ID string
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_o=
nfi.c
index 939e2277830e..e5b9a27aa4e3 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -135,6 +135,24 @@ void nand_bit_wise_majority(const void **srcbufs,
 	}
 }
=20
+/* Sanitize ONFI strings so we can safely print them */
+void sanitize_string(u8 *s, size_t len)
+{
+	ssize_t i;
+
+	/* Null terminate */
+	s[len - 1] =3D 0;
+
+	/* Remove non printable chars */
+	for (i =3D 0; i < len - 1; i++) {
+		if (s[i] < ' ' || s[i] > 127)
+			s[i] =3D '?';
+	}
+
+	/* Remove trailing spaces */
+	strim(s);
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwi=
se.
  */
--=20
2.17.1

