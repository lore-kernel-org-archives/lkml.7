Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2450E208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="gmn3x8KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436579AbfHIOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:48:56 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:24036
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfHIOsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:48:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaWZq6Fa0anSwUa2wUVjzmhzXA0n8x+Dz0Yj7Q7uZsgalwcUBTKDiYBUcdFbAh7+FeJLorTIHo0ZnX2xLzMxaP7OxqUNmFE696lbrApCVEZnHs4b6BAg/xzFW86tNAFCwDYHpPJn/TMlwrxgRr3XlxoWtMvtKYGi/EoxpUUGXH0ePhasix0dNMgH3KbOKO291Q1yiB0QoUjJCe96wmhzrI32lmdMeLlwT8w53JDG2ARftYG9IwRszkkhKT/tsQ2bv5hxCumldQ8WGZJ25c45b0YX/FOyQIlWCLbseLks/UcB98J1tzAguLStAAT/wMm9J89LJHAVDIvyj3TGtCZEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ/FaZWWfhEY81e02FO93HCNg3RgwTl+ozMHIX3syk4=;
 b=ipYHufnzjMdf88rHa2ryKWd07BOnyEulaiovIiYOZQ5N0icwljxR/lElchmO8RK3IiskccIcXZycVYAhicY2UFryzcKGdvIefkRl7aBmQF3ObCG2PsEBcPw8Mck6GCBOuLpL9IcTrGEw7tYwKrPHf99qLHtmUuAqV8DsthR8uuwmq5/rr3ACwZXFHPNlEzYbIjSvBUgmnhbiMTiHgVc87Z15UCRcWJpB794YOdq0w1i20S0G2h9g8IOmWI8F1Rvq6Amnkrcfsg3nOKOyXjq5EnULpYKagZYkOTS6wyn8VDYwpepGfhYCXiOG3c5ouW1j3GF8ih4C3+GwD62tN5bryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ/FaZWWfhEY81e02FO93HCNg3RgwTl+ozMHIX3syk4=;
 b=gmn3x8KSQ6jysqtPH9Mquk5MnElBs43zBpaFeejT6ulma5qCIYqdg7tdkPDmGN7CSfEp+A+4Bj01D1KGuUos4u2ksfFuaOjQMCRo63RIE3bjiiF6LvPqO8kfd4gE5hOgHI8H+Z+U1hXIS02CbzYxbWwP3tclNKoOnteeneZeV0I=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3486.eurprd04.prod.outlook.com (52.134.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 14:48:46 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:48:46 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Topic: [PATCH v2 1/2] ata: ahci: Lookup PCS register offset based on
 PCI device ID
Thread-Index: AQHVTsGMufv/T4to/0W+4QF9rKZkDw==
Date:   Fri, 9 Aug 2019 14:48:46 +0000
Message-ID: <20190809144827.1609-2-stephend@silicom-usa.com>
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
x-ms-office365-filtering-correlation-id: 8285c0fb-4cf0-41d8-51ba-08d71cd8ae5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3486;
x-ms-traffictypediagnostic: VI1PR0402MB3486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3486BA08D4BC9FDED36AC4A994D60@VI1PR0402MB3486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(136003)(376002)(346002)(199004)(189003)(1076003)(102836004)(6512007)(386003)(2906002)(76176011)(6506007)(53936002)(86362001)(6436002)(6486002)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(5660300002)(50226002)(99286004)(81166006)(7736002)(476003)(81156014)(256004)(11346002)(2616005)(486006)(71190400001)(71200400001)(52116002)(446003)(8676002)(478600001)(36756003)(6916009)(8936002)(25786009)(66066001)(186003)(6116002)(3846002)(26005)(54906003)(14454004)(4326008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FziNx6lrMEpzdr7OXdksssMtZyZVT3D+41DNaKidqmk7FUGc7kVYCyN4Z+X2seMDT6dtNcMHpG1APxhV7z0ZgFqM/aYA29TREKZgH2jfUqA2kkDmVNqF2HyxlYMYxNPsGxvswsLp70UcxDIstW0qiFy8xbzwm1yZ4Uqmj03h7QjApRKBAn7LbUhbs5hfZnpwDne1fEX6wUu3xpNYsi+UPM60TlwLc+trGjHyNCy7rUAJWPNL5I1GsNNLTu2Fqvgo5UvnVPnWESnK4Cm7g7bK/hlbhDO5yY66f6cbOaFFtGEpQV0grGEFmKtm4NJJHiI8e3YePrUW3jJCxiALjYw8T2RmBrEdnktA267AnGOrh+c0AAfZvsItshrb47Q3OOUFW9+ifCTilAbLg2YJcMHYPJKdZBKGfjVhSl0ZIy+PkHY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8285c0fb-4cf0-41d8-51ba-08d71cd8ae5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:48:46.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6sWiXLbAwu9KehYHQCItYS4oXmiSkv3BTwd5J2WrLeHFFXBHNMFpKywovicEdKZJgKO7qpVbvnG0ZkmZxjOeVmAeQ0fMTcig1qvUtPaiqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
reason, so now we get to check the device ID before poking it on reset.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/ata/ahci.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..7e4abeb10606 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -623,6 +623,41 @@ static void ahci_pci_save_initial_config(struct pci_de=
v *pdev,
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
=20
+/*
+ * Intel moved the PCS register on the Denverton AHCI controller, see whic=
h
+ * offset this controller is using
+ */
+static int ahci_pcs_offset(struct ata_host *host)
+{
+	struct pci_dev *pdev =3D to_pci_dev(host->dev);
+
+	switch (pdev->device) {
+	case 0x19b0:
+	case 0x19b1:
+	case 0x19b2:
+	case 0x19b3:
+	case 0x19b4:
+	case 0x19b5:
+	case 0x19b6:
+	case 0x19b7:
+	case 0x19be:
+	case 0x19bf:
+	case 0x19c0:
+	case 0x19c1:
+	case 0x19c2:
+	case 0x19c3:
+	case 0x19c4:
+	case 0x19c5:
+	case 0x19c6:
+	case 0x19c7:
+	case 0x19ce:
+	case 0x19cf:
+		return 0x94;
+	}
+
+	return 0x92;
+}
+
 static int ahci_pci_reset_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev =3D to_pci_dev(host->dev);
@@ -634,13 +669,14 @@ static int ahci_pci_reset_controller(struct ata_host =
*host)
=20
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
 		struct ahci_host_priv *hpriv =3D host->private_data;
+		int pcs =3D ahci_pcs_offset(host);
 		u16 tmp16;
=20
 		/* configure PCS */
-		pci_read_config_word(pdev, 0x92, &tmp16);
+		pci_read_config_word(pdev, pcs, &tmp16);
 		if ((tmp16 & hpriv->port_map) !=3D hpriv->port_map) {
-			tmp16 |=3D hpriv->port_map;
-			pci_write_config_word(pdev, 0x92, tmp16);
+			tmp16 |=3D hpriv->port_map & 0xff;
+			pci_write_config_word(pdev, pcs, tmp16);
 		}
 	}
=20
--=20
2.21.0

