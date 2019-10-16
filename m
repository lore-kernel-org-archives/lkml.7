Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC72FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE4220663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="gq7KpqGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfJPRDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:03:50 -0400
Received: from mail-eopbgr50099.outbound.protection.outlook.com ([40.107.5.99]:9953
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727176AbfJPRDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:03:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN+vEdqcWrCGnJvnzVPeby67dVp/80P5qY5CkLMg38OItJH3KDdyP2P8nf6+yhlIcV4ty+8h4hYOK2oC0RDsGAJSqMoZjQc57OKu5zR0aLWZ53wnmQ2cHIzziHG7TXo/rdzlGmn7kdM1kEUSj6HXeZyOmy1d5hAU/NKgrbxIQK35UpNifc9HYtRW8UrQBgQyAuo2sRPyoUCYjHQijKQAfDnXLQZvpbEerS2u8ObYHLMzdpYmEvYJADq9/CSnN6Qyp3QOSzVIJdznb2LDjCquPShO61ciHIW6YA8LewQqXdZr/8Xd2e+BFoBk5dEs1Z6eNEPibJe6Tcm5yLtmChEZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=902Po3pbS8iMr4ClSt636Ubn51ClllqxSRLMbQUwMIk=;
 b=WY8lJ8HMPeVrIQf0SQwaoQQ0Grdw4/UGGUWf3A51oxqc8JlFMYLc+uUlS2hfiCgj598KSrRRAflPd+AtwCW7iUiH0XG3EVVne7+Y4kQnfgmf9b3VZJP6VffCpPs0TTsqV8LJepjeyvRYVmhLYhDbnfiznSKWuPwJrJliheVK2MT6Fq2QHMRHKvw8G8Z55gKUkaOJ2dLOaUYt64wyMHN5P3G3lYYsBY39b1NNBjlH/+ZI6LggfRcnK/6PtWqf94Pzd/5WUlavlPa+R2b2Z7Q2H6H5aDiL2y6EGN50dsd4lxoEP8LPT4phGh5MjRk277QwzlwOrj+OAPiURyF7fmyV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=902Po3pbS8iMr4ClSt636Ubn51ClllqxSRLMbQUwMIk=;
 b=gq7KpqGqcJ0C8bOj6QgE20R3Gz01Ebvd88fDQ0wLeXdvZPDa2s6yulunFSxLT3KP5irKXK14me62S3eeLeaXnmsnSgV7ke5tHuWHfz/Vr/kQcLbE2q0E2+YFV9+b1LilDvU04/gZ8WEEvUTIu14bkwRQ82s7bDfUTnHf1dNR+xk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB3039.eurprd05.prod.outlook.com (10.175.21.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 17:03:41 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 17:03:41 +0000
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
Subject: [PATCH v2 1/2] arm: dts: imx*(colibri|apalis): add missing recovery
 modes to i2c
Thread-Topic: [PATCH v2 1/2] arm: dts: imx*(colibri|apalis): add missing
 recovery modes to i2c
Thread-Index: AQHVhEOpbdbADN9NeE6Hx9OYrwaOig==
Date:   Wed, 16 Oct 2019 17:03:41 +0000
Message-ID: <20191016170332.2013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a8d5d1d-9c71-4c65-37ab-08d7525acb89
x-ms-traffictypediagnostic: VI1PR0502MB3039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3039D84125692A99CCC8A4B2F4920@VI1PR0502MB3039.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(199004)(189003)(2501003)(476003)(102836004)(386003)(6506007)(26005)(7736002)(50226002)(71200400001)(4326008)(478600001)(8676002)(8936002)(186003)(2616005)(3846002)(44832011)(66066001)(7416002)(99286004)(14454004)(6116002)(305945005)(86362001)(486006)(2906002)(71190400001)(110136005)(54906003)(316002)(6436002)(66476007)(5660300002)(256004)(6512007)(14444005)(6486002)(81156014)(81166006)(36756003)(66446008)(66556008)(64756008)(52116002)(66946007)(25786009)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3039;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PM8nKlznU7X0S5RkXrafotE4n+ALUwm/WWZ9CjZnPjdXxl6lf4k2hmMZGbXRZRcNqPZ17HDX/273sz8gkrFqNvwfoSH4H4yu2wUoHwD42BIPwGEi8rOKzIcfZOBZoBdLSRZJarl1Wjvh6W7YoiLLwQeyEhMD88ny+y34uep2K2IHdPCV6+gf2s5i9FA97Z9HxLnWmY+XT1jOuH5coxGcXrDpqmv+7M1Scy74CemyPuAQev1QvbAaYirf1u/2NDj8MY9lDvH/3v+OPu0nf+HlsLUL2s+hB/+AGApYTx5Pc/MKy0MsKzESMLMxrOUzqFhxEeHipZbul4bGz/BIW9R7J66beLF4E1Ic7PIDZUV9KIsbnX8CHJ6ivjryZI5cZbKYn1M5ZR40GwztBtE2ipRV39YJqrZuRsjU+g5KujafpSA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8d5d1d-9c71-4c65-37ab-08d7525acb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 17:03:41.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dyTuSXckrbobAOKmPDcbgv1uKhphqy6NZU4/xd4vQ711vr+HwiAwgDZ7i4X/7gJQgMc6VzLHsLyfuNq92XXa9Gbj/RiO2P7J+KuMtW5MUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing i2c recovery modes and corrects wrongly named
ones.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Added scl/sda gpio
- Added missing recovery mode to i2c2 on imx6qdl-colibri

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 30 +++++++++++++++++++++-----
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 18 ++++++++++++----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6=
qdl-apalis.dtsi
index 7c4ad541c3f5..86cad6c9f0f9 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -205,8 +205,11 @@
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c1>;
+	pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
+	scl-gpios =3D <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status =3D "disabled";
 };
=20
@@ -216,8 +219,11 @@
  */
 &i2c2 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c2>;
+	pinctrl-1 =3D <&pinctrl_i2c2_gpio>;
+	scl-gpios =3D <&gpio4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status =3D "okay";
=20
 	pmic: pfuze100@8 {
@@ -372,9 +378,9 @@
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
@@ -646,6 +652,13 @@
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
@@ -653,6 +666,13 @@
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
@@ -660,7 +680,7 @@
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
index 019dda6b88ad..8ab9960fc15d 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -166,8 +166,11 @@
  */
 &i2c2 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c2>;
+	pinctrl-0 =3D <&pinctrl_i2c2_gpio>;
+	scl-gpios =3D <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio3 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status =3D "okay";
=20
 	pmic: pfuze100@8 {
@@ -312,9 +315,9 @@
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
@@ -509,6 +512,13 @@
 		>;
 	};
=20
+	pinctrl_i2c2_gpio: i2c2grp {
+		fsl,pins =3D <
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
+			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x4001b8b1
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b8b1
@@ -516,7 +526,7 @@
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

