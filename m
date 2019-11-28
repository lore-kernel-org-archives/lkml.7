Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4497C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C0F2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fcLk7zZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfK1Tsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:48:41 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:57860
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfK1Tsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw0aLmSOvyx3mm97p+dHj6QuHFu/eGN4RMIPL7iBfVJS6tNvioReyoIsf0vSZZxUIah0gBli112HXPEx3faWwVvTCtthtUqNGKWiX6NGi+lk1PvH3Dxv7SRw5aJNCY61bdmrDwpAfZUFdtSD6gSv7xXXeQTTy2ei1U66Y0EtXDkrVGMzOsxjZuaMdK+FJ1snsUAyM5N91vPZnstNONiCerfPleCmjoZiivSF6I2hyJcyc67XGYLztsnJH5WgXYDEbUwxurFuCarRquVH0ENW3uVE4RGW38kpfVtCtDMIKESFmWsdFlAR9J0bleMEszhCM/d9U4xcF+8RjJ3V0UczuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1fu2SF7lbQ7t3uriq6QkXvo2QrqfmRw1m7l5CCkah0=;
 b=KkVT3bmnMnvsC/dtRExDZZm/4eh+ZP3U5CSqDPrJVITDt2JH2ZVTv6uBK0b4EHoiHWuOeFrVN9+RJqejpAQluo3j5XGexIDzqBlx4QUgKRTMd2bxpJReqhDKgO5of/eoZs6969CDfsYDnbfnXpfkOSuPorQkfcL/zoLmOKVJxwyShGd1L3FI9fvIuO+gmzvvl/5DCptTqmflxpiOU0OXdLcwNSB9DQ3aTHi1me9gz0C7EryisIuwkel3qJXH+ODU2p8dpuy7FkTiQCMlRpu5adDZa0HndvOpY+I/V6fskhKVKCpUYgU44oGnK7gl9KTbbvMdWWTNcZVAfypIimjVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1fu2SF7lbQ7t3uriq6QkXvo2QrqfmRw1m7l5CCkah0=;
 b=fcLk7zZTYeSlQIiwZW9PH5sHkLLQsZlbK2lpQsHIgiCvN9k69Q6dRPtSwkBcEanriePfe9/5hQQbb9oCOej9tMGkvlnkyiy8+BrE6UVt8UpmHZmEbquY/RH9SzPNMKiVZaKZ0O4/lsOTmxgq9j55Ei53+wqISbS15nwoTTq5y80=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6445.eurprd04.prod.outlook.com (20.179.232.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 28 Nov 2019 19:48:35 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 19:48:35 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v4 2/2] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
Thread-Topic: [PATCH v4 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
Thread-Index: AQHVpiTRaeN7WAI2gUiESuVcSnobTA==
Date:   Thu, 28 Nov 2019 19:48:34 +0000
Message-ID: <20191128194815.26642-2-marco.franchi@nxp.com>
References: <20191128194815.26642-1-marco.franchi@nxp.com>
In-Reply-To: <20191128194815.26642-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0233.lamprd80.prod.outlook.com
 (2603:10d6:102:17::27) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2bfce13-acfe-4055-c1b4-08d7743bf3fc
x-ms-traffictypediagnostic: VE1PR04MB6445:|VE1PR04MB6445:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6445265F318AB1D9F58DAD2FF6470@VE1PR04MB6445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(966005)(8676002)(81166006)(81156014)(71200400001)(36756003)(86362001)(102836004)(99286004)(386003)(2201001)(6116002)(2501003)(6506007)(478600001)(25786009)(26005)(3846002)(54906003)(2906002)(110136005)(5660300002)(186003)(7736002)(30864003)(14454004)(8936002)(66066001)(6486002)(71190400001)(50226002)(14444005)(256004)(316002)(6306002)(66446008)(4326008)(6436002)(11346002)(6512007)(64756008)(76176011)(446003)(66556008)(1076003)(66946007)(2616005)(66476007)(52116002)(305945005)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6445;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HH0oD7ALVgscBDkhf1IxEh0WoVPeL+04y4Mrx35xgXyB46BrHLrk+UqR1amPctPSEUYXdDCiYVjd01JI1B3n+JQPH1XrpJ15jHnvRFNuUTEyOy6PlExdsqufdzPBHBcK943ZnjT6cc5bvfGjoplyn6Gxu6BrQ0XW6BQJYnr+6HLFtEhxOHX/Sp0VNmoxW5YOvvb1QNLwppZ7XpBvuEp9GyvYilvuPlACjZ/H9YW3UVMSM/2PQ5voe15yYtCy9P6H+0v/tcy7E1KgRbQhWGtQ55WPhZ+tCYI4Xp7s8KXa9Yakw8NGTcnope53HKRQPIN1WhpfffnwdV+cO/5xFyZsHD5jgg0YJnj3FfCwxCRv/QqM2/geUVBltd2S7UccCYmTJo8G/1ikqyTyBa7/s6Z942HVVoxPNnHKpws9J7/O8rb+mCmpqIEB83E8BU4wyGW912McX8VtgQ9AykrVKvUQJGzZAHa6s9OoNMhxNAKgVDc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bfce13-acfe-4055-c1b4-08d7743bf3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 19:48:34.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1AftXbVj82Lt08Ekfcz0egx6Y7OiAPCI9a/k7xBf1exknKIacsBJ2RuadDMaH+RNoPJYlFOsRnQGmVpySh0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree to support Google Coral Edge TPU,
historicaly named as fsl-imx8mq-phanbell, a computer on module
which can be used for AI/ML propose.

It introduces a minimal enablement support for this module and
was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell
Google Source Code for Coral Edge TPU Mendel release:
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
Changes since v3:
- remove reg_gpio_dvfs regulator
- change cpu-supply to buck2
- fix regulators values and properties
- remove sai2 node
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-phanbell.dts    | 377 ++++++++++++++++++
 2 files changed, 378 insertions(+)
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
index 000000000000..a7565a0146ee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -0,0 +1,377 @@
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
+};
+
+&A53_0 {
+	cpu-supply =3D <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply =3D <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply =3D <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply =3D <&buck2>;
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
+				regulator-always-on;
+				regulator-ramp-delay =3D <1250>;
+				rohm,dvs-run-voltage =3D <900000>;
+				rohm,dvs-idle-voltage =3D <900000>;
+				rohm,dvs-suspend-voltage =3D <800000>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name =3D "buck2";
+				regulator-min-microvolt =3D <850000>;
+				regulator-max-microvolt =3D <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				rohm,dvs-run-voltage =3D <1000000>;
+				rohm,dvs-idle-voltage =3D <900000>;
+			};
+
+			buck3: BUCK3 {
+				regulator-name =3D "buck3";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage =3D <900000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name =3D "buck4";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				rohm,dvs-run-voltage =3D <900000>;
+			};
+
+			buck5: BUCK5 {
+				regulator-name =3D "buck5";
+				regulator-min-microvolt =3D <700000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name =3D "buck6";
+				regulator-min-microvolt =3D <3000000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck7: BUCK7 {
+				regulator-name =3D "buck7";
+				regulator-min-microvolt =3D <1605000>;
+				regulator-max-microvolt =3D <1995000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck8: BUCK8 {
+				regulator-name =3D "buck8";
+				regulator-min-microvolt =3D <800000>;
+				regulator-max-microvolt =3D <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
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
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name =3D "ldo4";
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name =3D "ldo5";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo6: LDO6 {
+				regulator-name =3D "ldo6";
+				regulator-min-microvolt =3D <900000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo7: LDO7 {
+				regulator-name =3D "ldo7";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
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
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status =3D "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_pmic: pmicirq {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
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
+	pinctrl_wdog: wdoggrp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
+		>;
+	};
+};
--=20
2.17.1

