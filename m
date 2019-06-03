Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A784C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF942808B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="p4oA8dC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfFCMnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:55 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:2273
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbfFCMnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N31gu65mo/zUo0sBjOpDK8lKNr1MdlVkERp8c7Pvrlw=;
 b=p4oA8dC+ybXtLokypwrcVnyCronSiqir3xv8D2mGUVfpqSUP3jBbK1MsoQzuAf2ITsoHrW8j/cITDGf64gjPSCaa26RnOxmH7Wym5/GpqPbKPhFZoyo3J2/4IjnvmdP4YXdqSJeAixCE9KUrkUcR5nTUEr4c8x3//viCxqQgUFM=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5854.namprd08.prod.outlook.com (20.179.98.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 12:43:42 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:42 +0000
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
Subject: [PATCH v3 11/12] mtd: spinand: micron: Fix read failure in Micron
 M70A flashes
Thread-Topic: [PATCH v3 11/12] mtd: spinand: micron: Fix read failure in
 Micron M70A flashes
Thread-Index: AdUaBqrYXG5fZNW1Tl+nROeafv3SiA==
Date:   Mon, 3 Jun 2019 12:43:42 +0000
Message-ID: <MN2PR08MB5951CC96E757BB4A3549AE89B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee1f652-795e-4e80-b212-08d6e8211c86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB5854;
x-ms-traffictypediagnostic: MN2PR08MB5854:|MN2PR08MB5854:
x-microsoft-antispam-prvs: <MN2PR08MB5854A98E5164BDABB807D6BCB8140@MN2PR08MB5854.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(5660300002)(81166006)(8936002)(7696005)(14444005)(7736002)(8676002)(305945005)(55016002)(256004)(2501003)(81156014)(102836004)(2906002)(110136005)(6506007)(25786009)(55236004)(33656002)(76116006)(476003)(73956011)(66066001)(66556008)(66946007)(26005)(99286004)(64756008)(486006)(66446008)(186003)(66476007)(52536014)(6436002)(74316002)(9686003)(6116002)(3846002)(2201001)(14454004)(7416002)(86362001)(316002)(53936002)(71190400001)(71200400001)(68736007)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5854;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MCjwPj12qcNNvEvqnIJq09WloBRfVzqQFtLr+9Q87B/GNqcL+phBEQuMkjmZBA91gw+E4z9cEUvLyYfYMaFGHjrWGDRtxoA/X2tP3zwTQD95gdgB2AHYGNgKFFY/SbsmlKDMcl+gzp1hIQlVc/oBBywx7KGkYA7wPPk2QpZ9ytuyA7akpZT2rHTmffBuEODSOxZibnE4glAOKSOpB3azYkw7JSHTE85jds+YvV7U6Dr7bLykCVC3gIVMfPFdxmcHfugS8xoLHxKhkvIGBLdr7/3F/vtrVaqWPFk5/zHBf81tbQ3mVwOEwh9L8NnZXHDYR26GWKUcBE0tVcmn5mQD+RU2c2fwGIpD3jUmmKZpxM8BxuMtKUe/dyGmZhoo1mgtTxv3sFdoFFU3MyooZDoLs5pQN+lJN6Lj2v6LjLW9z1o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee1f652-795e-4e80-b212-08d6e8211c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:42.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M70A series flashes by default enable continuous read feature (BIT0 in
configuration register). This feature will not expose the ECC to host
and causing read failure.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 6fde93ec23a1..1e28ea3d1362 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -127,6 +127,15 @@ static int micron_spinand_detect(struct spinand_device=
 *spinand)
 	return 1;
 }
=20
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * Some of the Micron flashes enable this BIT by default,
+	 * and there is a chance of read failure due to this.
+	 */
+	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
+}
+
 static void micron_fixup_param_page(struct spinand_device *spinand,
 				    struct nand_onfi_params *p)
 {
@@ -150,6 +159,7 @@ static void micron_fixup_param_page(struct spinand_devi=
ce *spinand,
=20
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops =3D =
{
 	.detect =3D micron_spinand_detect,
+	.init =3D micron_spinand_init,
 	.fixup_param_page =3D micron_fixup_param_page,
 };
=20
--=20
2.17.1

