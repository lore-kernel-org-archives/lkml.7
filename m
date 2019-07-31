Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60577C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6F0206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="rqUmfu1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfGaMiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:19 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com ([40.107.0.121]:56484
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387690AbfGaMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYfpPSlqiSn7R3eJwgcVpOqmewDRHJmR4+wy+vgnYHPRXTeS6Y7En8XKnUtkpwIW8A3Fo6m8kOgXyaQXaE/9KgoELPSaynrnSPu/kkpYMToGMPD60B0h328HgJBXhGXvyPWlRGDl3GENr+zS+8MJFen5iy2lfu3IiPBq1aKbThq1tjsKS/1J9Yuq/yFsl79XQlO24PclM2umjxsOT4B9kI22g3i6l7IU5wx2THfxYC7W18YjAsv/ZrGKI9b9AthfO+aIlGXAOcHxG+ZSnEUMobCEeFs1hTomqnAq4QBa9WLsiLwMpAZT/UvusxmUskOsRQm0lFS+l7Gv8asulmt8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buyK0CMD+beFl7G57vrFpq3e8zJbHvyfKR7qawHIy9s=;
 b=X1xJoGLdx1Ec+6JhspPipi70bGHAxvwdZ23ZiDdXunRnT1sA/ASyeTtreGDRIVHzKS5hzXb9Qvc9z3+JtqRyBySIo98IhBsVelos3CXp6Ih0FAEhElqb2SYZrmkYTdWkXbNZ1WyCR8JN1C68IE52CheluwHZJRcdmdvtOCIP8B0xIxglyOsIGJtqyK2Z13/QvvsdFQDBiVeGIFrAuJHbjJW6sWoWqy5943gTy9Atg2DzociIjGE4nGC8PkHbGhrv21u+XRAcT1gDw7rxvR8hU+nJ7LQ+S1kl9V3Iq1apgJER+xgXr+f8/HOhQ5rz8+xEJrGQrG+cVOlpXAd+1/mAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buyK0CMD+beFl7G57vrFpq3e8zJbHvyfKR7qawHIy9s=;
 b=rqUmfu1ivtMxgzM3JJcWVrsSTHIs+8b3lgVBOVDlGMMeSm6/BUkXU+Ofm7apRMSKj1Fo5TYDH4+6YOf9dAwXRSa64ouDWAYTrj+wNY0F4U3J3dLJVVKSwy6BxV6Ck0QTroIgjdK2Oks9ff+6VnAUB0Lb/wOBSG99CunFwVmRbYM=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:08 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:08 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 05/20] ARM: dts: add recovery for I2C for iMX7
Thread-Topic: [PATCH v2 05/20] ARM: dts: add recovery for I2C for iMX7
Thread-Index: AQHVR5zO+FSW3mGr80K7Hkqp21YoIQ==
Date:   Wed, 31 Jul 2019 12:38:08 +0000
Message-ID: <20190731123750.25670-6-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d7c08aa-70d5-4566-b116-08d715b3f106
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB3615ABAA73E9CACB6057958AF4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u9APjfAhrtjtW57wUVI7XyWHpQvOsCRkk1PQ+gKGiHwbDU8L8hRSmo8Ah1RAyEkvsh5nGzT/DvOb5zR9VVBvdNrwm2UlLXVumkXY3HE2rjMGJPJyBaNBN7upQETOucwe0B0AUK9AG9UnvtHZaL2tX+a6JOntHhAP0lMLmt3d6AkelxH4sMZo1upGu5Jok9V6FpEnB9mFUgh/aKVGWy4ar68UpKLaIxFxrIVpn8X4xTEo4AvWLgAqeNl0hjCjSmQt62ro9U//PGG8hfnYsZTzkDI2cTOvhIwEHmQJQ6JQWYL/lmZdYGPFTFywwSup7ROubeWFY4A8ytWVI6eTZx9+fzzyhXb0IZ2TVfMded7ok+AMwEhi38hkVRoDJEUZETec5VNT1IPEaWyMjR+/AGMxTVah1OA4kITGOsTv4fm+Xyo=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c08aa-70d5-4566-b116-08d715b3f106
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:08.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

- add recovery mode for applicable i2c buses for
  Colibri iMX7 module.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index a8d992f3e897..2480623c92ff 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -140,8 +140,12 @@
=20
 &i2c1 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c1 &pinctrl_i2c1_int>;
+	pinctrl-1 =3D <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
+	scl-gpios =3D <&gpio1 4 GPIO_ACTIVE_HIGH>;
+	sda-gpios =3D <&gpio1 5 GPIO_ACTIVE_HIGH>;
+
 	status =3D "okay";
=20
 	codec: sgtl5000@a {
@@ -242,8 +246,11 @@
=20
 &i2c4 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c4>;
+	pinctrl-1 =3D <&pinctrl_i2c4_recovery>;
+	scl-gpios =3D <&gpio7 8 GPIO_ACTIVE_HIGH>;
+	sda-gpios =3D <&gpio7 9 GPIO_ACTIVE_HIGH>;
 };
=20
 &lcdif {
@@ -540,6 +547,13 @@
 		>;
 	};
=20
+	pinctrl_i2c4_recovery: i2c4-recoverygrp {
+		fsl,pins =3D <
+			MX7D_PAD_ENET1_RGMII_TD2__GPIO7_IO8	0x4000007f
+			MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
+		>;
+	};
+
 	pinctrl_lcdif_dat: lcdif-dat-grp {
 		fsl,pins =3D <
 			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
@@ -740,6 +754,13 @@
 		>;
 	};
=20
+	pinctrl_i2c1_recovery: i2c1-recoverygrp {
+		fsl,pins =3D <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
+		>;
+	};
+
 	pinctrl_cd_usdhc1: usdhc1-cd-grp {
 		fsl,pins =3D <
 			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
--=20
2.22.0

