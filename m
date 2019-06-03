Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5309DC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6C27EC0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="Ie0xqtLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfFCMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:34 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:50830
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfFCMnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWBUlUMVe6k0BTIl65sU7HynpgoMDyGncHgqunkahxI=;
 b=Ie0xqtLHbUqGEDS4QY8A46GFMSiHPHVaZ2n6aVZDbxfCWf+WqWkmTK0pucpo/elK8+THHxKPk7YonDla0Y0pPxAXgh9VV8Lnk35IIHESUh4iXyNcBr4VhbytqS+ayb/ITIxFkLI2KfIxMj9XIBidh0ITsg4hpU+uu6VSU0FRU5E=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:29 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:29 +0000
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
Subject: [PATCH v3 04/12] mtd: rawnand: introduce struct onfi_helper
Thread-Topic: [PATCH v3 04/12] mtd: rawnand: introduce struct onfi_helper
Thread-Index: AdUaBIJVYblkvvsDT0y1heXJZCvR1g==
Date:   Mon, 3 Jun 2019 12:43:28 +0000
Message-ID: <MN2PR08MB5951E35FED92DD502F57B590B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47522b63-4218-428e-3d98-08d6e8211451
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB58724437F662F18107B21F5CB8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(5024004)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EAGwhX5YQVvvkuZ6H/IEQ2G1U0pbFnXcNoOek031KVnr/1Bi5wiOP80godheeMNY5X8Tz9//sNuXcT4M/qkyzvuNgXYyNxCUd5Iiw6dG/9RBa5IpVzpmpQlFrKWBPS0h8b/yiLZStSdJu8n0whmxaiikF9uK8mpdl6RsB3+BkJ1trQRUwCGtruZOzGqvFmQmExtYBeyTEJpbJmHyLXmzyewm0MbFH6SboFWvDWBRYuK3CKJeCxKyuqoVXg77eNd5o7VmiAr5UbAFMyXrApJX48WAlUJrADpX5+6D24PGEKqyrSCsqazWutN6prsfofw2AT2ZQTqVh55SsuzsSz4YhKlTXIOW3+pvA5eiJb31P5wHHjOJceQew/ImU1tV6eHwqgBOPj1gI+2wZOpX7X19OjZ8DG/hKpj0nQ00mXoZ0/Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47522b63-4218-428e-3d98-08d6e8211451
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:28.9458
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

Create onfi_helper object. This is base to turn ONFI code to generic.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 include/linux/mtd/nand.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 3cdf06cae8b6..645dde4c5797 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -11,6 +11,7 @@
 #define __LINUX_MTD_NAND_H
=20
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/onfi.h>
=20
 /**
  * struct nand_memory_organization - Memory organization structure
@@ -157,6 +158,24 @@ struct nand_ops {
 	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
 };
=20
+/**
+ * struct onfi_helper - ONFI helper functions that should be implemented b=
y
+ * specialized layers (raw NAND, SPI NAND, etc.)
+ * @page: Page number for ONFI parameter table
+ * @check_revision: Check ONFI revision number
+ * @parameter_page_read: Function to read parameter pages
+ * @init_intf_data: Initialize interface specific data or fixups
+ */
+struct onfi_helper {
+	u8 page;
+	int (*check_revision)(struct nand_device *base,
+			      struct nand_onfi_params *p, int *onfi_version);
+	int (*parameter_page_read)(struct nand_device *base, u8 page,
+				   void *buf, unsigned int len);
+	int (*init_intf_data)(struct nand_device *base,
+			      struct nand_onfi_params *p);
+};
+
 /**
  * struct nand_device - NAND device
  * @mtd: MTD instance attached to the NAND device
@@ -165,6 +184,7 @@ struct nand_ops {
  * @rowconv: position to row address converter
  * @bbt: bad block table info
  * @ops: NAND operations attached to the NAND device
+ * @helper: Helper functions to detect and initialize ONFI NAND
  *
  * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNA=
ND)
  * should declare their own NAND object embedding a nand_device struct (th=
at's
@@ -183,6 +203,7 @@ struct nand_device {
 	struct nand_row_converter rowconv;
 	struct nand_bbt bbt;
 	const struct nand_ops *ops;
+	struct onfi_helper helper;
 };
=20
 /**
--=20
2.17.1

