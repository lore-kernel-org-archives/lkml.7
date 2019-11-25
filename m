Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98EC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546EA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PI1dhOSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKYNMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:12:03 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:28022
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfKYNMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:12:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpNCMMZZ+a0RbMAIFdmZm91uk6n7qTBwO3wrl9lfg0ZBiDEe2Q+ojzGYDHQEK2CfawYi5IoPCMwzYSFy/1hTyUhc66cYxX4kyNPKAdNetTpVvWJQ1lnmfA0dZFCq/DG+RCjHs78TBLUM+n6KRK1ePaoT4l4UwH0miLx/Hn+FmLcfTAgXMVxBQPLQsU8xcdvFDHfxKDGzRSv3857UcifG+rUj2uN0Y4DD9UK/S3N8fR9q1uIa6x+hhYi6te1Hvb1v32rnlnSKrMmpgmejuCb24IQ8bhrfm+hFaGob5BY/7/m6ierNyaajM7MsPL3o1XtGI1n+arzP6MbKVnvpXmY4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xctPVqWhN9VYZd7W53uK71Wgvpq2QPvBwiKtZE2nsA=;
 b=MbEJkbqMtgM01GbCW1r/xdSdxKJpn0egXkIdUsq/HI9/1lmm93Uj8oFR49o4HenZdAfdRFAPB/614bbXM0/Nw6WBqo9u7ziiHgY/lT0ea6HRBioGVjGUMYX6HLefr1dmNZgKHoi4C/qcgqu+zEXdWl333xhbG/ztKENn/kkcc7ztIkAydNgj1gvfurqpvSFblwsL3uu5cuxBNdNDEkQix8+Eb03QL5pn1QpoAdD+C7i0uMqgdQMZSmF1cqpls3cO5s6s268kcd4bwciM6Dd6ASNmeHgEsfuVRrpYLZUrJjfSCoKqqLEn5dZprNxfF7zSngyfCPmwjwj63uxnVBDrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xctPVqWhN9VYZd7W53uK71Wgvpq2QPvBwiKtZE2nsA=;
 b=PI1dhOSkBL3tx1JkxkaJka14WZ3kFGntggdrWSMbzDTT2r/cIVH9MgpTKNp8BgC/PxYQWjNvNREeix+kkOFTRdb9d4AbvdVAl1G6tpo3IFzqM4oev02496NjA+ndmHd38zN+oonUctKpB7NsePo+1vmIfCf3vBXjmCCa+T3fHXo=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6752.eurprd04.prod.outlook.com (20.179.234.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 13:11:53 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 13:11:53 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
Thread-Topic: [PATCH v3 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
Thread-Index: AQHVo5Hn5+k7FOS1FE+qIc1vsxp5Zw==
Date:   Mon, 25 Nov 2019 13:11:52 +0000
Message-ID: <20191125131129.966-2-marco.franchi@nxp.com>
References: <20191125131129.966-1-marco.franchi@nxp.com>
In-Reply-To: <20191125131129.966-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0123.lamprd80.prod.outlook.com
 (2603:10d6:102:1b::13) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.27.230.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bfd079e-f500-4a57-bd95-08d771a909a9
x-ms-traffictypediagnostic: VE1PR04MB6752:|VE1PR04MB6752:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67524D6C716FCEA12590DF6DF64A0@VE1PR04MB6752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(6436002)(71200400001)(6486002)(2906002)(11346002)(8676002)(8936002)(81156014)(7736002)(305945005)(6306002)(6512007)(386003)(81166006)(6506007)(446003)(186003)(2201001)(76176011)(52116002)(256004)(14444005)(36756003)(66066001)(6116002)(3846002)(86362001)(66476007)(66556008)(102836004)(66446008)(64756008)(26005)(478600001)(2501003)(14454004)(966005)(110136005)(54906003)(99286004)(30864003)(25786009)(4326008)(316002)(50226002)(2616005)(1076003)(66946007)(71190400001)(5660300002)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6752;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghHhy7Cj4vBqx+a7MdEMTEj27GDhFPxXfGMwsdewFYHScoGi98mgXgUonyi0G2U4FufOa5+2AhMZpJEFymmA8Od0bMFNO+dZ1OoEDJgWXepZe5d2PNHcEpa7arlNIXuuhAxw+b/dcMTKiniM9MJHQNsLHLflJHuIZmhQoQDlVdt1L/YJun6/Rm/2tFGqdnULMVJ8T+U5s8bLGy3QoHfo6aePkdx88z72dfHqqvMo8fkGWpCwB11sv35lN9JRQwb8Nxa8a56XqapJ44Wxbzx2Ee8lzfKevte5DqLMnwd5dGYFaltec4bXPK6tKOIE1s7meLAWrF7Bc2RjaiVkioWsaZ9wk5BgOo1NXLkrcFEunDLT7EQTBzHaXhyDRBXVFtFqWlyOwN94YuVdZ6IYkjw5KalWfNoaI6Y3Hjg9Mx4WFaKkdFjD5hwk18DX3qdfEnYzmQFEE7NUb3rIMsvpZurI1u4AYjy/Xyfn/D50vx/Do4Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfd079e-f500-4a57-bd95-08d771a909a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 13:11:52.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTmTLjzMZFQLchCyxJG/DRkdYQt9ejqvQ6YnLKN4JVGVKlE6Pb+NE9cicre7SL3QoitAex1HKeZYxKEG5QRW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree to support Google Coral Edge TPU,
historicaly named as fsl-imx8mq-phanbell, a computer on module
which can be used for AI/ML propose.

It introduces a minimal enablement support for this module and
was based on the i.MX 8MQ Phanbell Google Source Code for Coral=20
Edge TPU Mendel release:
https://coral.googlesource.com/linux-imx/

Tested components:
- PMIC;
- USB-C OTG;
- USB-C PWR;
- micro-USB;
- USB.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- remove i.MX 8 MQ EVK from message log
- fix memory size node
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-phanbell.dts    | 405 ++++++++++++++++++
 2 files changed, 406 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 38e344a2f0ff..e50a934e2417 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-hummingboard-pulse.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-nitrogen.dtb
+dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-phanbell.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-zest.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64=
/boot/dts/freescale/imx8mq-phanbell.dts
new file mode 100644
index 000000000000..08820ea72427
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2017-2019 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+
+/ {
+	model =3D "Google i.MX8MQ Phanbell";
+	compatible =3D "google,imx8mq-phanbell", "fsl,imx8mq";
+
+	chosen {
+		stdout-path =3D &uart1;
+	};
+
+	memory@40000000 {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x40000000 0 0x40000000>;
+	};
+
+	pmic_osc: clock-pmic {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+		clock-output-names =3D "pmic_osc";
+	};
+
+	reg_usdhc2_vmmc: usdhc2_vmmc {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VSD_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_gpio_dvfs: regulator-gpio {
+		compatible =3D "regulator-gpio";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_dvfs>;
+		regulator-min-microvolt =3D <900000>;
+		regulator-max-microvolt =3D <1000000>;
+		regulator-name =3D "gpio_dvfs";
+		regulator-type =3D "voltage";
+		gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		states =3D <900000 0x1 1000000 0x0>;
+	};
+};
+
+&A53_0 {
+	cpu-supply =3D <&reg_gpio_dvfs>;
+};
+
+&A53_1 {
+	cpu-supply =3D <&reg_gpio_dvfs>;
+};
+
+&A53_2 {
+	cpu-supply =3D <&reg_gpio_dvfs>;
+};
+
+&A53_3 {
+	cpu-supply =3D <&reg_gpio_dvfs>;
+};
+
+&i2c1 {
+	clock-frequency =3D <400000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c1>;
+	status =3D "okay";
+
+	pmic: pmic@4b {
+		reg =3D <0x4b>;
+		compatible =3D "rohm,bd71837";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_pmic>;
+		clocks =3D <&pmic_osc>;
+		clock-names =3D "osc";
+		clock-output-names =3D "pmic_clk";
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <3 GPIO_ACTIVE_LOW>;
+		interrupt-names =3D "irq";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name =3D "buck1";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay =3D <1250>;
+				rohm,dvs-run-voltage =3D <900000>;
+				rohm,dvs-idle-voltage =3D <850000>;
+				rohm,dvs-suspend-voltage =3D <800000>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name =3D "buck2";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay =3D <1250>;
+				rohm,dvs-run-voltage =3D <1000000>;
+				rohm,dvs-idle-voltage =3D <900000>;
+			};
+
+			buck3: BUCK3 {
+				regulator-name =3D "buck3";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage =3D <1000000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name =3D "buck4";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage =3D <1000000>;
+			};
+
+			buck5: BUCK5 {
+				regulator-name =3D "buck5";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-boot-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name =3D "buck6";
+				regulator-min-microvolt =3D <3000000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+			};
+
+			buck7: BUCK7 {
+				regulator-name =3D "buck7";
+				regulator-min-microvolt =3D <1605000>;
+				regulator-max-microvolt =3D <1995000>;
+				regulator-boot-on;
+			};
+
+			buck8: BUCK8 {
+				regulator-name =3D "buck8";
+				regulator-min-microvolt =3D <800000>;
+				regulator-max-microvolt =3D <1400000>;
+				regulator-boot-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name =3D "ldo1";
+				regulator-min-microvolt =3D <3000000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name =3D "ldo2";
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name =3D "ldo3";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name =3D "ldo4";
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-boot-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name =3D "ldo5";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+			};
+
+			ldo6: LDO6 {
+				regulator-name =3D "ldo6";
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-boot-on;
+			};
+
+			ldo7: LDO7 {
+				regulator-name =3D "ldo7";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1>;
+	status =3D "okay";
+};
+
+&usdhc1 {
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc1>;
+	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
+	bus-width =3D <8>;
+	non-removable;
+	status =3D "okay";
+};
+
+&usdhc2 {
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	bus-width =3D <4>;
+	cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply =3D <&reg_usdhc2_vmmc>;
+	status =3D "okay";
+};
+
+&usb3_phy0 {
+	status =3D "okay";
+};
+
+&usb_dwc3_0 {
+	status =3D "okay";
+	dr_mode =3D "otg";
+};
+
+&usb3_phy1 {
+	status =3D "okay";
+};
+
+&usb_dwc3_1 {
+	status =3D "okay";
+	dr_mode =3D "host";
+};
+
+&sai2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sai2>;
+	assigned-clocks =3D <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI=
2>;
+	assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_P=
LL1_OUT>;
+	assigned-clock-rates =3D <0>, <24576000>;
+	status =3D "okay";
+};
+
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status =3D "okay";
+};
+
+&iomuxc {
+	pinctrl-names =3D "default";
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_dvfs: dvfsgrp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x16
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
+			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8	0xd6
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
+		>;
+	};
+
+	pinctrl_pmic: pmicirq {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
+		>;
+	};
+};
--=20
2.17.1

