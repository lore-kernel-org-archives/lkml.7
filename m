Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7589C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881BE21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQ5pOicX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfLQNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:36:26 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:61190
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbfLQNg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:36:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ/I3q1EPiE1BqWcsyg9BA+jHxuptF68rVEwGeYk235C+89dwNkGVH0bBZtKRw9JF+No3RRkP+aqdhAfowD8MtJW5t9byTAgz6RFPhoyvJN9dKXrMFcd6BEb6n6e42HHUyx6PFyK04cMQyU2tbShBaurM6HgLNGSkIuu1w6of+5MwDFUGsUaveAdIX/0h4aKCbIDzov6l60QgzSMfcMVfExSJSH32mTeynN6bK1r0mPZjyT02m7192x0pto0RJeFcFdVmbJVC2M9B8ovUY6w/52crr8pL6FzLhyRYNIl/krxLJ+J8/ug9sdcI62UQhC6Ol1ayoBttiwIVT6hI95nCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7FIEouK6xLMZfJXP5P4P5T8LlQLUfcmNvUM5DlWVM4=;
 b=KvKrdfF7e4u/dkAquD9LcQVTXpm40Pq2EPWef8Vwb9ybgsND/2KGjbZxKzIh4UXcPRroOTRfE5iS+aqysVkpoX2SFVAWDFWobcs1kU9NiOSbBQUnL3HAmT4XURIflrpjewlSSdbp+VqOtm6ROb7B/KuhvkVB+522XH4duxJL14AAG2zeYNmQYxbzbjYKPjI85DN3h7WgerUrvX6d5RSFgEpIzwDgo8n/NSDO/49bb74P688Ne5qm5VRMq4S25FhTn5bnJ1wVtOpg1u10zABzRf3WLRlWnk+5xNEXt3rLrYfQ/gkMM+yKbOUXIE2Gxhcnu3jNMDZsWpLfBNSBT22sFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7FIEouK6xLMZfJXP5P4P5T8LlQLUfcmNvUM5DlWVM4=;
 b=HQ5pOicXXa1kgnEvAnn1+5pa8uPXNbksqaxdW8xmc6jnV93w1ttLgtTO1bBlUVMOVk0xcKwyoKAA/sRvdRdodudM1bWYEQ+0uVdM3BqE8XkL+Kxx4jeplwHEMVG6C2h8n3kfqaPS9HzB83TbREUDn6x+mQt6s/Xd1BFZK08fsJM=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6733.eurprd04.prod.outlook.com (20.179.233.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 13:36:17 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::84f0:21ba:2d32:4283]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::84f0:21ba:2d32:4283%4]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 13:36:17 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v5 2/2] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
Thread-Topic: [PATCH v5 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
Thread-Index: AQHVtN710UBThnrQokOtmD+SRgO7+w==
Date:   Tue, 17 Dec 2019 13:36:17 +0000
Message-ID: <20191217133607.8892-2-marco.franchi@nxp.com>
References: <20191217133607.8892-1-marco.franchi@nxp.com>
In-Reply-To: <20191217133607.8892-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:802:20::29) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d8b30b5-7991-464f-ea77-08d782f61800
x-ms-traffictypediagnostic: VE1PR04MB6733:|VE1PR04MB6733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6733FDDEC4641098FD204D47F6500@VE1PR04MB6733.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(6512007)(52116002)(6486002)(316002)(30864003)(6506007)(36756003)(478600001)(26005)(64756008)(66946007)(8936002)(8676002)(66446008)(81166006)(81156014)(66476007)(66556008)(966005)(71200400001)(54906003)(86362001)(2616005)(2906002)(1076003)(110136005)(186003)(4326008)(5660300002)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6733;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/f4lKH1hVvBRpDc6NknI1XDe4HedvzaPOh6j945fI+SvUXDxp1BTBZ9VFOLDyN+hqnthGfsKTljPcd6wx5NbXrbBXIlEdlflNLDp1husit4AMnI01leT5EPSxcLzwFOtTEzRYWbRJzihJAeAOWrVpbhCU0xwfINxRrYb17uApOLmxfPjbHrx0HP42r4282+TBarN+EXZPhCDTqaFASrAOM4iNbpevGzjR6xB2JSt8gJwNVjWey4rLuZbCFpcd8h5QKycV4O6aYloQG9CB21LAPEBSYDByCY6h+M6X8+TAVn8UrR9CXk/1jlwm+N0ryzA9mfCsS5yDKycQykVNUcE39aKA3LsfQz+fQpj8nNTrL27/mXJJG1h59sdGV+oyWfYgVOFo3R4P7MXrXWrSBLgW3Lj4Dzqc36BFzL9MF2dM+mzDbDU8czbPIvy2iYRsZD74ZoXZSmEGrVnb0/sCO03YERS7MCIBuT2Xib79EqDTwBDCapA4inNSUBYTuhvwIiMBdyArXZt0DXCH7sH7cvkuxR9PEEmZ76EDRk3gkxjYQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8b30b5-7991-464f-ea77-08d782f61800
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 13:36:17.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1HMtOupov1lEuAqFZSDJ9KDimzcK7j3lu6L0K6geL7P9qM5mixnzBNZuCXv3NBKQHXvqHBUtZmTd7Uuj9PbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733
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
Changes since v4:
- fix regulator name
- remove unnecessary names
- add clock-cells to pmic driver
- end property list with 'status'
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-phanbell.dts    | 376 ++++++++++++++++++
 2 files changed, 377 insertions(+)
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
index 000000000000..3f2a489a4ad8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -0,0 +1,376 @@
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
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
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
+		compatible =3D "rohm,bd71837";
+		reg =3D <0x4b>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_pmic>;
+		#clock-cells =3D <0>;
+		clocks =3D <&pmic_osc>;
+		clock-output-names =3D "pmic_clk";
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <3 GPIO_ACTIVE_LOW>;
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
+	dr_mode =3D "otg";
+	status =3D "okay";
+};
+
+&usb3_phy1 {
+	status =3D "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode =3D "host";
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

