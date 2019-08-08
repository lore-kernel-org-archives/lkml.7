Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C32173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="D5HEB44e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbfHHUYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:24:37 -0400
Received: from mail-eopbgr00127.outbound.protection.outlook.com ([40.107.0.127]:16354
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731038AbfHHUYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLQ01DN/1btFXTGiLuMdOQzV0Pxg27vaXTJVYRr+RW3mOfnAHAuhf3/VS/NmKhBpLhIJga+I7tG8Kmad+3oM6Zeh+HbKafAxVqtmaEa1rGV8LgbJ/o+xT9kzcvH12f8rdg1dzJTkYdiVGAwomXHP7cMeT4EDPAsn9vMxuSRE3xhx1Z/lFJNYkGUl0tEAKkyfR5v7hnSlmdjWWRzBlOQfcgonJURosHQngFZvESOf0nvV8luL2Nd2MQMlBGyo9URZ3wNn5rx1vxtwzka+eZ0CPmgtBxJ45zbipvM6HnWRDxdw/i3+E+H32cNHEufeEqzzDJNoysfUOn8+nsbUk9jJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsjZvHEqBDK/pnqC6k740sZd1Mb9lnx9gxF6kO1WpO8=;
 b=A+OyzqJEKmiO+D6RPheD18C+JpZJAd4bCwrtsfA7mh/yowku5u/Eb/6HL2OSWxwVC8/QMTtd7yLWKk797KE045TBCgCXFzokWpPwD0J7Knk96dzOEdjDC9OXoqfrMALqFhsMZm6Ox6pp0Y6SbInCn9U8InMmdNzdSxnDoe3f5ia4rhAA5TyYHZv21yPKjXYjmtbhc+dpzOl3Ujljk2H81a+D+gJCT9omOZ+sEAN/GksJRmhdBg/u5Tko4nnyj6K/eWVCX86RoMXIqtwsU+Wsq5H0F6sQkDxrDvGa8FNl7DN9M/o7y9cXOlbgRlhbGbxRZIa/9km6Pf98JSVSVlOlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsjZvHEqBDK/pnqC6k740sZd1Mb9lnx9gxF6kO1WpO8=;
 b=D5HEB44e7amdeAptCluYSju1SyLTSTkiWe2vHiK0sSwhRi88bk7UOfYf/fkgIYe1dOcXYaci1iIsM03kuQQmYt9HecXtE2gyGeAoXP6CQ4995sqLH8fcO3+XF/mI/UQho05NsT6RMlVNhR8/UKIHC78OghnkbvuiYWfOrLHtGE4=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB2814.eurprd04.prod.outlook.com (10.172.255.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Thu, 8 Aug 2019 20:24:31 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 20:24:31 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39JoQ==
Date:   Thu, 8 Aug 2019 20:24:31 +0000
Message-ID: <20190808202415.25166-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2201CA0004.namprd22.prod.outlook.com
 (2603:10b6:405:5e::17) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4418f6a-3342-4dc3-9c9f-08d71c3e6b64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2814;
x-ms-traffictypediagnostic: VI1PR0402MB2814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2814F172119444048D4AE32994D70@VI1PR0402MB2814.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(396003)(39850400004)(376002)(366004)(189003)(199004)(14454004)(99286004)(2906002)(25786009)(7736002)(5660300002)(476003)(54906003)(66556008)(6486002)(6436002)(66446008)(64756008)(2616005)(66946007)(1076003)(36756003)(316002)(6916009)(102836004)(256004)(53936002)(6116002)(3846002)(66476007)(305945005)(71190400001)(71200400001)(8936002)(52116002)(81166006)(86362001)(81156014)(50226002)(66066001)(6506007)(386003)(186003)(4326008)(26005)(486006)(478600001)(6512007)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB2814;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V0h+NSy3nwRNkKEwSECgb9SFmHXQQiA9g+zCDQ5zf0kIAq5+A7hr/3WYXPb8GPt60kEzI1ffxeKb1rnB1hdJtWwtjaqbDv5PIZLewjwiOUSt8OGEOLwDdStT0J8LTQFstHZiSeMFz2p6W782/OVa0D3dbF1F8NtvfW5iVrfCBoSHe5F74D5+dN2fybrUu1JRcqsMdXAlA08xeY2UHM70gAjQ12vXY3W33rYv4WQCexneHhhKlUlUkyZ29mmMdlNB5VXP1Elh9LkNt2Kc084GscFewVdujMpC0PFh3vD98e215PuxE7HgL3URW4Xi9jyqttSYley8JWSA0p103p3mYTDeco1jsnlG1ZCKl3unod4BSvG/2Gl4vaq1l7s/+WlhZN8BUtRM/jedm5TcMv9KYc68k7ybeFhoJMa8etPlbRc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4418f6a-3342-4dc3-9c9f-08d71c3e6b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 20:24:31.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtO4FI9q9IR4DeDNn137a4dvBPtQ40vVpBvDN8ZbRqZjvsrRAybfEAyyrzny9GxPzIM2e87b8XvvMY1A6OmG1z/wVNrL/q6NDJjNH71idQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2814
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
index f7652baa6337..7090c7754fc2 100644
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
+	case 0x19bE:
+	case 0x19bF:
+	case 0x19c0:
+	case 0x19c1:
+	case 0x19c2:
+	case 0x19c3:
+	case 0x19c4:
+	case 0x19c5:
+	case 0x19c6:
+	case 0x19c7:
+	case 0x19cE:
+	case 0x19cF:
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

