Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED3C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADF5206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oEAtIWLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKNT4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:56:31 -0500
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:16771
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfKNT4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:56:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U20G/bbq//j59YBiKTq6lKzZOvcJrJxGUNebAWPi42JTPzF8jWfCkAFGT1xgUqWKEreg99XrLDFOKLZPEBS5lNTvDCPBYKPwKBi6uRfNzLFTv8KwBsqWHvlDSAhEWVnPKQl2dTTZ/mglaXxFu3Fx+btYW6Fd4KdSTl0zf4HKkAvSsooo4GLWms+5hQEp+VtE1ceW+drJs7Nb6j2DII3YYf8bi1JLf3Z2Lt7wvoyNtn3+7ZGDbu4KgR57C2TlrRcheaDMtebPEWfbQKV/d925a2iy7BPD5F6AkKHet1cHFyhfTJtAd32ye7EzytVKVQ+DDBCHpSo3rlPczYFRs0FCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X23Y55lhScL+uTbii4whTbpe1MRZ3ecrW6dueIEYqnM=;
 b=acCKgecktqsHcN+9hlLWCa7Ki2dilYwPAqJ9esD/9BmEb1S1+r+l3d8SMLWK0S2S0Dox0nRlu2X7qRtY4BFZ5t5+cqR4jDFtQ7LGDnmbORqFH+PEz0CHP7xLzlGa6LfpzqwSKcwSa0VLov8UnrnIhsngYw46gf9r35ClQWLZ5kPRYpnT1ZLdbJfy67I/dpfriM1pfrc9xEuvCBW5Wd0s136YBKYGL9zJj9TlAr2RPFkvLTuZxvz2QSyxNc+l7gmBx6+rrH/v6uudkfk0WacByEjiI44Psc0jnLlPnZxGO0DBuzMe4SvWerft7IL8VMpzZMLiOuXQ8xMU3FtlkTyuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X23Y55lhScL+uTbii4whTbpe1MRZ3ecrW6dueIEYqnM=;
 b=oEAtIWLNealVkfN1v1GPwlzrP4GuBWYh6RSediGVcbfVTkxVHXhKcNXbgsa4Jq5mxv/ZQ+NsefKNbGhe5osK4o1MiHs5hxJnvSo2vt0/XgxikEgsYWO9tFzN4a/MWplQBwfGH/OsL/jEOPV7cC0NlUGZ5ouq3VlRQxYXkZ7bYbk=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6655.eurprd04.prod.outlook.com (20.179.232.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 19:56:21 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 19:56:21 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH] arm64: dts: freescale: add initial support for Google i.MX
 8MQ Phanbell
Thread-Topic: [PATCH] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
Thread-Index: AQHVmyWV3TPieM6iNUSqAsCuFHjdAw==
Date:   Thu, 14 Nov 2019 19:56:20 +0000
Message-ID: <20191114195609.30222-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0058.lamprd80.prod.outlook.com
 (2603:10d6:102:19::20) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5234395a-cf6a-45e7-644f-08d7693cb857
x-ms-traffictypediagnostic: VE1PR04MB6655:|VE1PR04MB6655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB66558DC82AFD7A008C52B311F6710@VE1PR04MB6655.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(52116002)(81156014)(50226002)(8936002)(3846002)(316002)(81166006)(110136005)(6436002)(2906002)(6486002)(6512007)(305945005)(66446008)(4326008)(8676002)(86362001)(54906003)(66946007)(14444005)(5660300002)(256004)(36756003)(6116002)(6306002)(99286004)(71200400001)(71190400001)(66476007)(2201001)(66556008)(1076003)(30864003)(64756008)(966005)(478600001)(102836004)(66066001)(7736002)(25786009)(2616005)(26005)(6506007)(186003)(476003)(2501003)(14454004)(486006)(386003)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6655;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUyo32CnSztO7GwVEPkg7K/7ABp2IEUJc2HDKKKR7ZRZXQ+qBEy2PPbVDHW8edR7RVYY/zFHCluHlvmQZdquFyfjYaObvQrwLrwENEr3ilIFABz7wiVnBlXX7An4uCr0181c0j3TNZQa5yDh+K79MrajQg/DQsyIGRr2PO4acj0fJAO1pSqsmmF+2jgO7X8upcQQa3YHKPLPkVLi9ZcUMO1EaZsC0Z4Xzc55E+w8EbwCQHRJeg2McGxBlSimQ/Ki6OcYFV7ZL+Sdl0B3S5YjdHPlPZiz1GsdHwGps3s/i72HKEJqo17MsqY/e14Evtb6vMH0HQKa2I/x4/cmFYdc7T8u/OWHSEX8b230zKR816lOzGwQw4rUbIzsugBRXQ7vuhUcG9vo5e21wfADoKFzQBJ6dfAbRLBgZtJmalSirVj0dkD9TtZiOlAyGAq/ZMQN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5234395a-cf6a-45e7-644f-08d7693cb857
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 19:56:20.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIrlAl56X6pqszDVoHCkXYprZUk0E69WSL9r9qSP4nDbujyXUuhLJBqLkWax/lWRjP+QWIVNWC3ov4hDbE8d8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6655
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

This patch was tested using the U-Boot 2017-03-1-release-chef,
which is supported by the Coral Edge TPU Mendel release:
https://coral.googlesource.com/uboot-imx/

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-imx8mq-phanbell.dts     | 467 ++++++++++++++++++
 2 files changed, 468 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8mq-phanbell.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 38e344a2f0ff..cc7e02a30ed1 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
=20
+dtb-$(CONFIG_ARCH_MXC) +=3D fsl-imx8mq-phanbell.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8mq-phanbell.dts b/arch/a=
rm64/boot/dts/freescale/fsl-imx8mq-phanbell.dts
new file mode 100644
index 000000000000..aa9dca25ad79
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-imx8mq-phanbell.dts
@@ -0,0 +1,467 @@
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
+		reg =3D <0x00000000 0x40000000 0 0xc0000000>;
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
+
+	wm8524: audio-codec {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "wlf,wm8524";
+		wlf,mute-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
+	};
+
+	sound-wm8524 {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "wm8524-audio";
+		simple-audio-card,format =3D "i2s";
+		simple-audio-card,frame-master =3D <&cpudai>;
+		simple-audio-card,bitclock-master =3D <&cpudai>;
+		simple-audio-card,widgets =3D
+			"Line", "Left Line Out Jack",
+			"Line", "Right Line Out Jack";
+		simple-audio-card,routing =3D
+			"Left Line Out Jack", "LINEVOUTL",
+			"Right Line Out Jack", "LINEVOUTR";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&sai2>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai =3D <&wm8524>;
+			clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		};
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
+&fec1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_fec1>;
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethphy0>;
+	fsl,magic-packet;
+	status =3D "okay";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		ethphy0: ethernet-phy@0 {
+			compatible =3D "ethernet-phy-ieee802.3-c22";
+			reg =3D <0>;
+		};
+	};
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
+		pinctrl-0 =3D <&pinctrl_pmic>;
+		gpio_intr =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
+
+		gpo {
+			rohm,drv =3D <0x0C>;
+		};
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
+	assigned-clocks =3D
+		<&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents =3D
+		<&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
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
+	imx8mq-evk {
+		pinctrl_fec1: fec1grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+				MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x23
+				MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+				MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+				MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+				MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+				MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+				MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+				MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+				MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+				MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+				MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+				MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+				MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+				MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+				MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+			>;
+		};
+
+		pinctrl_dvfs: dvfsgrp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x16
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+				MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+				MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+				MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+				MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_gpio: usdhc2grpgpio {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
+				MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_sai2: sai2grp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+				MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+				MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
+				MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+				MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8	0xd6
+			>;
+		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
+			>;
+		};
+
+		pinctrl_pmic: pmicirq {
+			fsl,pins =3D <
+				MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41 /*0x17059*/
+			>;
+		};
+	};
+};
--=20
2.17.1

