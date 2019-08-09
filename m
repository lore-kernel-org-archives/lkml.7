Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B12820C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="sjshfWhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436597AbfHIOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:49:00 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:24036
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIOs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcg2MY5sgQNqH9DAMJkRAHyX92Xkuoh1iCsEKcpofUJZ25ddIE35b7lpMGFyVxOnMM+5NhE7FCmnUGFdWlHlzl5U7/AoH9V7QG6ckiVs7vwTKJ9TNe97URffCkcPmAPMRq9Z9sgGEeZOzykzBJ0Kvos05u/Oupa83UyJewmuLaaaz+fkeGOcyRUFSK8pmKeOKYrHuwtlwOZiOYpxNaBIJbDvhrctjL/9wlcQJbcfmLoSP0pj2gPElEUCOh1j6SQ3au2++t6viLJBIsKCYYd6Vti9d8UnS+o5HxIN+mrr+RR/A6aKGaU3BGuX+dO/DMFSeLPExEq++P6Qr+ie0pkv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ+e60RQEScAkCnA2lpy/k+W1E3+r62Dwpyou3D/ZIs=;
 b=VDCMCiGGXD58D3pzFpQgvmvkxnSMCgE4FL1GVU4MeqBxg+d12RrTq1NRrZCIggE4+86ewJ9EbyI84vikbx7UNH+HlD+3J4dirsEDVHwIbzRqjhhIJsLX0fzzKYJ/kcu1bcp4jbknJB1G4v/EHspFplM6ZodHBJjR6leinbsCWxNtnCSkpvJ1g0sfjsIIUG8/6Khv4z92Il3VsU3IiRvk1UT2gFArh3xkImJ/9m0b19R27CH/GwP32hq9uJf+E6gR+VOGp5bOonTbgrYVe7Lfsh43OhV+IL4oeFUTzReO1NLW9+PMqGVdtd46EhDyy0zL5txnCLJ9OCtvE5w5Fxkh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ+e60RQEScAkCnA2lpy/k+W1E3+r62Dwpyou3D/ZIs=;
 b=sjshfWhc+jLW57A30RgKmtRCr5xacGagqMsIqBfa/vXXKxlgZ0JCVchEBwZKd4ZAyBmHfqvLeBk3+P95jd2BelahAalnkXtKu+FzqOqt2jwFka2S6dBk9YCY7af7PiCMKuqzIHpq1hD+sqBP8mzqIdOifj9SvO7p1Di/oklmoIM=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3486.eurprd04.prod.outlook.com (52.134.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 14:48:47 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:48:47 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] ata: ahci: Cleanup hex values to use lowercase
 everywhere
Thread-Topic: [PATCH v2 2/2] ata: ahci: Cleanup hex values to use lowercase
 everywhere
Thread-Index: AQHVTsGMJcG0Qf5cnkuq+z8xUv5cVA==
Date:   Fri, 9 Aug 2019 14:48:47 +0000
Message-ID: <20190809144827.1609-3-stephend@silicom-usa.com>
References: <20190809144827.1609-1-stephend@silicom-usa.com>
In-Reply-To: <20190809144827.1609-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:405:3a::40) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9d05cfa-459c-41d7-99da-08d71cd8af1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3486;
x-ms-traffictypediagnostic: VI1PR0402MB3486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34865440E9886B6274C06A2A94D60@VI1PR0402MB3486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(136003)(376002)(346002)(199004)(189003)(1076003)(102836004)(6512007)(386003)(2906002)(76176011)(6506007)(53936002)(86362001)(6436002)(6486002)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(14444005)(5660300002)(50226002)(99286004)(81166006)(7736002)(476003)(81156014)(256004)(11346002)(2616005)(486006)(71190400001)(71200400001)(52116002)(446003)(8676002)(478600001)(36756003)(6916009)(8936002)(25786009)(66066001)(186003)(6116002)(3846002)(26005)(54906003)(14454004)(4326008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J0Qb1Sm8uao38wWWQEhFI7+cl/n1G2RyUw2wk4+VU+9FyqM+w1zRC/wOdtlX/tTUac+bM/qZupyOwvNkUveFHNI5y2ERs9vmGJhLs2TCC1YkILNz+86QqLMVS5Xuu40a5zYj8PvlTArXRrwQQkSt58VCf7TOcGIpIfgRJRb6YmMuLXDUCDbmIs03UKMEFgu5xXjnFegDz9Lsxh23Ws/cPSMtJQgqp1FQloU5RNqK+q0khKFoW4iN+EEO7vVzE0Kdy4b19jzfz5aQf2Hge4zo/2BTZ8F+FhF57bs+dLiFISNR+lWeYg0VmDMiZlTMrJ+As2PYA1md3psxKAunD8PcFMnFTv4MEGHgn1ZbkkOdZAUwONG1a/hiBRovYs8KKC1I411exdApClrUNgcmww2a98PKXxFBqZ9u1rAcBdDO7m4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d05cfa-459c-41d7-99da-08d71cd8af1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:48:47.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qYQhk4EwPWIfLTAJQKM7iTL9AOqVCNLPCy6qGVG6wkN8R7j8p1DvKrY8svLxCR0q2pgOK0sY/q15LYDfaom7maMV77d8hIjuUguXbyMIwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Result of sed -i 's/\(0x[0-9a-fA-F]\{1,\}\)/\L\1/' drivers/ata/ahci.c

No functional change intended.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/ata/ahci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7e4abeb10606..ce7373f0a861 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -272,8 +272,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	{ PCI_VDEVICE(INTEL, 0x19b5), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b6), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b7), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19bE), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19bF), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19be), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19bf), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19c0), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19c1), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19c2), board_ahci }, /* DNV AHCI */
@@ -282,8 +282,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	{ PCI_VDEVICE(INTEL, 0x19c5), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19c6), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19c7), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19ce), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19cf), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
@@ -506,7 +506,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	{ PCI_VDEVICE(SI, 0x0186), board_ahci },		/* SiS 968 */
=20
 	/* ST Microelectronics */
-	{ PCI_VDEVICE(STMICRO, 0xCC06), board_ahci },		/* ST ConneXt */
+	{ PCI_VDEVICE(STMICRO, 0xcc06), board_ahci },		/* ST ConneXt */
=20
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
@@ -1192,7 +1192,7 @@ static bool ahci_broken_system_poweroff(struct pci_de=
v *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nx6310"),
 			},
 			/* PCI slot number of the controller */
-			.driver_data =3D (void *)0x1FUL,
+			.driver_data =3D (void *)0x1fUL,
 		},
 		{
 			.ident =3D "HP Compaq 6720s",
@@ -1201,7 +1201,7 @@ static bool ahci_broken_system_poweroff(struct pci_de=
v *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 6720s"),
 			},
 			/* PCI slot number of the controller */
-			.driver_data =3D (void *)0x1FUL,
+			.driver_data =3D (void *)0x1fUL,
 		},
=20
 		{ }	/* terminate list */
@@ -1490,9 +1490,9 @@ static void acer_sa5_271_workaround(struct ahci_host_=
priv *hpriv,
=20
 	if (dmi_check_system(sysids)) {
 		dev_info(&pdev->dev, "enabling Acer Switch Alpha 12 workaround\n");
-		if ((hpriv->saved_cap & 0xC734FF00) =3D=3D 0xC734FF00) {
+		if ((hpriv->saved_cap & 0xc734ff00) =3D=3D 0xC734FF00) {
 			hpriv->port_map =3D 0x7;
-			hpriv->cap =3D 0xC734FF02;
+			hpriv->cap =3D 0xc734ff02;
 		}
 	}
 }
@@ -1691,7 +1691,7 @@ static int ahci_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
 			 "PDC42819 can only drive SATA devices with this driver\n");
=20
 	/* Some devices use non-standard BARs */
-	if (pdev->vendor =3D=3D PCI_VENDOR_ID_STMICRO && pdev->device =3D=3D 0xCC=
06)
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_STMICRO && pdev->device =3D=3D 0xcc=
06)
 		ahci_pci_bar =3D AHCI_PCI_BAR_STA2X11;
 	else if (pdev->vendor =3D=3D 0x1c44 && pdev->device =3D=3D 0x8000)
 		ahci_pci_bar =3D AHCI_PCI_BAR_ENMOTUS;
--=20
2.21.0

