Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A34321835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="rkY1UVNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406283AbfJPQ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:28:55 -0400
Received: from mail-eopbgr30127.outbound.protection.outlook.com ([40.107.3.127]:36480
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404056AbfJPQ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvwvDY+8w7lUeBXYSYtZwGSHv5yZ9IzVkNhEOTH+hicAZzGtcNcCp/Mh0K5hw2+F53ebAnwx2VxJEtrphH8K+BSmPVlcS4VUwmjPjIB3MDeCoE98SzEFRJ1zuSzNzmntLWoh9qbOuhlfGreGRAe+TYXb40xqRH49vJtwogCvekTtBJUOPz1W9dqvOcpB+RAzoBqoBbvPlabO/aiw5D0QbsXhz7Q/4wjE0NhEjyf0Dax76B902JifB16pEd4OuBvkiCGMjhL4NIbsrZR9/C8CD3H/slMSE5SCUQ2OK+37ONt5ftdCgPa6Eb4ySSFvul4CJ7jIsKxHPuhscL+XAgkCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIfdlUkn+rcxnXUzJe0RcqcduXG71RQCzjp1HpOG9y8=;
 b=Z5tDW5NHCCXMg3KuMlP6leb8GjIuokjFSielJSDeHoGeoBjOgA2EIOozs4+X2AFMm5Wj68CR+BPZo4mRsNr175RIdyhPdOwcZsia67X5mQHyMl8pbvit80ojCZLpVOAimsekwUByj2SXbEAk7yIRf65R/EA0natZw2jDsoXUUnEAE3pX/v/1AjZEvuZOUqZ+FJqaKLOzG9qH68Gh3H80i0WVgUc9RrTYWwYpNVhSl1jGGGPm8St5CooPuI/7X5OgUV175OocjvP/3mlrBgJfV1RvvwmglxhXr2DnjteJSu6IAF13OdlPe7YWxl1cyN+M3z1WTghv/67PhPQRRpifFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIfdlUkn+rcxnXUzJe0RcqcduXG71RQCzjp1HpOG9y8=;
 b=rkY1UVNxKsoWd3hnMHDms/ElKB7IqoWBx5YCMYlZ05ZVn593CPMUZyYE7X/eKGt3XfU5RXF+1xG+HaAC5W8X4eEVlX5QhVLDM0hmywfvfbA6Uc6SBkSMTEJUpPlwaYpooN9CvCuxLAQ3anL1HOGi7nrzn7a/AFXyikKcs5tu2Ig=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB3629.eurprd05.prod.outlook.com (52.134.7.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 16:28:42 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:28:42 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v1 1/2] arm: dts: imx*(colibri|apalis): add missing recovery
 modes to i2c
Thread-Topic: [PATCH v1 1/2] arm: dts: imx*(colibri|apalis): add missing
 recovery modes to i2c
Thread-Index: AQHVhD7G2HgM23iAn0WcdFEjmyuWhg==
Date:   Wed, 16 Oct 2019 16:28:42 +0000
Message-ID: <20191016162833.1893-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a907b77-bd25-4845-7a97-08d75255e8a7
x-ms-traffictypediagnostic: VI1PR0502MB3629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3629279C3F9037A7CDE5ACFEF4920@VI1PR0502MB3629.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(376002)(39850400004)(189003)(199004)(66066001)(26005)(86362001)(54906003)(36756003)(8676002)(7736002)(4326008)(66946007)(71190400001)(71200400001)(478600001)(7416002)(6512007)(256004)(14444005)(44832011)(386003)(66556008)(66446008)(66476007)(2906002)(64756008)(6506007)(5660300002)(102836004)(99286004)(316002)(186003)(25786009)(1076003)(486006)(14454004)(8936002)(2501003)(81156014)(3846002)(2616005)(50226002)(305945005)(6116002)(476003)(6436002)(81166006)(52116002)(110136005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3629;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsfvtETTs/Rak1A3+Jivp/bBPkqwRzv4knQzjfIAbjvZ6DymGa5SPidouvpUw8gJZb1RVRC2R4vjiOZ6fZ0mYTjN/UkpAebyRXSYDXkA6Paa+91K3NxkPLJUkh1GPFnfCRDledB16LiTKUSpESULGq8Poiit1eNiYNNmHNpOe3XMaNBXLiC+eiNgEcKOLFxp0Ol0gAzxEKxKSVd6gJn9lf11VtTwI/GRxMIwTM1FA1pAjcLRP0neF9eNuYK9e0ZryQ3zfHtPb40C/6BtnNY3bTFth1gGH4B3Y4VdVsf8Iltbg6wTsaBaq3VfEhCd27f9v5lKUKLVuLVhY0xf5CkjGAX1WezKci7vQDTvHSF3XtlllO8v+tFbroycn+ekKZ7mFY92fBmWAuxZQkyYIbtERPVuezi4ERErg5F1KFc//Ic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a907b77-bd25-4845-7a97-08d75255e8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:28:42.7630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoOCd6wIJQrnEdAhDtIuFOUYQujGgG6QP7zGMmQJcOzG3Nu21WLbl6ya1gpg2IIUQaXeocNp5XdQjL/g47t08XDjbr+lJBFaQ/qgJk9mWT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing i2c recovery modes and corrects wrongly named
ones.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 26 +++++++++++++++++++++-----
 arch/arm/boot/dts/imx6qdl-colibri.dtsi |  6 +++---
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6=
qdl-apalis.dtsi
index 7c4ad541c3f5..7baf4a6f04eb 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -205,8 +205,9 @@
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c1>;
+	pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
 	status =3D "disabled";
 };
=20
@@ -216,8 +217,9 @@
  */
 &i2c2 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c2>;
+	pinctrl-1 =3D <&pinctrl_i2c2_gpio>;
 	status =3D "okay";
=20
 	pmic: pfuze100@8 {
@@ -372,9 +374,9 @@
  */
 &i2c3 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default", "recovery";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c3>;
-	pinctrl-1 =3D <&pinctrl_i2c3_recovery>;
+	pinctrl-1 =3D <&pinctrl_i2c3_gpio>;
 	scl-gpios =3D <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios =3D <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status =3D "disabled";
@@ -646,6 +648,13 @@
 		>;
 	};
=20
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26 0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27 0x4001b8b1
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =3D <
 			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
@@ -653,6 +662,13 @@
 		>;
 	};
=20
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x4001b8b1
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins =3D <
 			MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
@@ -660,7 +676,7 @@
 		>;
 	};
=20
-	pinctrl_i2c3_recovery: i2c3recoverygrp {
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_EIM_D17__GPIO3_IO17 0x4001b8b1
 			MX6QDL_PAD_EIM_D18__GPIO3_IO18 0x4001b8b1
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 019dda6b88ad..4ed7ae57030d 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -312,9 +312,9 @@
  */
 &i2c3 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default", "recovery";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c3>;
-	pinctrl-1 =3D <&pinctrl_i2c3_recovery>;
+	pinctrl-1 =3D <&pinctrl_i2c3_gpio>;
 	scl-gpios =3D <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios =3D <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status =3D "disabled";
@@ -516,7 +516,7 @@
 		>;
 	};
=20
-	pinctrl_i2c3_recovery: i2c3recoverygrp {
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_3__GPIO1_IO03 0x4001b8b1
 			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b8b1
--=20
2.23.0

