Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CDDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C792E2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tf5ffYZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfGPNni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:43:38 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:60294
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387748AbfGPNnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:43:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDNquXnAknb4GTmYVB0qE0EME64ip4LydAjCOMf1xMhRsBmP1KCURc/u87z/Vj3HmjIOgEhQjSuHfteiVvikkjq1tR7mgWQ1TFdDMPUCA1ar2oq6zo/RxVL//r1NSNI8VTYSfn+Lv7k4Bgkntw7kd3my8zOqzGBqNhHuKxEN1o+2rAi2AVO13VX3RXmB8XfBmyhzujTAM4lAqvUxfvhqKxQVtiBd/x732dRJS+5cyVwzdpuZrBFMBuv7Ulm2K10I7SX9AWQvOxRwesQfdSy0Af20OiJXPYBtMScNxXzGoMarTWJ0pHpfM4/GKeMneb17VQ+Wi3j9a8i2Dv5z8ew2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZulAEcvE3+2Z/ufHWJMnYKukDBbEk3QWvZBYlBpAYbw=;
 b=mwvfJIB95XA7Tif0KSSa4K8dY6OicydKujmQ0w0bwFLHfSZogHpjEI0P4lBus0JpclPMA0cKTKBri0byRHzLtDj9XEwH4BULoTGowijIXldGXbQstkvP1Na3zReJ8C96lUBKTJYFb4gOA8yIUdDwfC7B+runoAwCONJ0vcxvh2MAlA3uxYENt2QMpHxqMi8QDB0ZsfZhFXvhjpGGY7eB13yXG9Z9YPA7SrL/+Ndt7Aia84+4gKaTuUHqrk2a8LWJv7WR7Vp07ZsjL4xZN4uvlC2Zz8z1/NfeXBOIsLmZAP1JVyeKskC8alVtvoifuKoeigGmshXJHMJNTbKb95lFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZulAEcvE3+2Z/ufHWJMnYKukDBbEk3QWvZBYlBpAYbw=;
 b=Tf5ffYZzjC5Sw2E4O/tYYGIJttOep9EIkgdmYOEXhO17ujL6IilqIoQzoAP2lb27edixQtJiWaOdI+1+ZyYsVBLCwO5mv/TBoCAxiycI/njF+Ph+0vGFqobltAPqSbDcRRk62R6sLiSHBiRox8LSBled7ws0KZ9eQc/f8FwSn8k=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6102.eurprd04.prod.outlook.com (20.179.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 13:43:32 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511%6]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 13:43:32 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v4 2/2] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Topic: [PATCH v4 2/2] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Index: AQHVO9x1+XHD0wKR7UK1CmDhArLZxg==
Date:   Tue, 16 Jul 2019 13:43:31 +0000
Message-ID: <1563284586-29928-3-git-send-email-pramod.kumar_1@nxp.com>
References: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
In-Reply-To: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0133.apcprd04.prod.outlook.com
 (2603:1096:3:16::17) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.142.151.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a36e3857-c7c1-4772-661c-08d709f39747
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB6102;
x-ms-traffictypediagnostic: AM6PR04MB6102:
x-microsoft-antispam-prvs: <AM6PR04MB610297FCDCBB46167DF76E3EF6CE0@AM6PR04MB6102.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(186003)(66066001)(2906002)(54906003)(110136005)(14454004)(71190400001)(78486014)(26005)(76176011)(4326008)(6636002)(7736002)(305945005)(486006)(68736007)(71200400001)(102836004)(52116002)(5660300002)(55236004)(8676002)(6506007)(386003)(8936002)(86362001)(50226002)(81166006)(6436002)(81156014)(3846002)(99286004)(256004)(446003)(53936002)(476003)(36756003)(66556008)(2616005)(478600001)(66446008)(6512007)(66476007)(66946007)(11346002)(6116002)(316002)(6486002)(25786009)(2501003)(2201001)(64756008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6102;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LfTsEPu0LugVJByM+dWEB3RmUoAj1wyCueSUwT1cpSxPlLslrLWgNuHnti+2I/EkfS07piOrMqYAsi5C5EFKEsY1zCGU74DT9H0nAOoCCagV0QF7MAjR6w78X6xjAvp5Qd9gUJKs0FtMid7C4Nx2lP5YSmmgeCAf+0UwMHXoTHj3XS1c015sKFuKee0flU/vLWMhiq00HEaTZCgKZjHbW4eN/CNoLdOK4ohte3Uh2Ajq5GGu2RZM+7PL8xc/U/IFaLnos81HuOKE38WemjofLHeBc9qvudYpARlUtmD27xxw9G54Xn/hPfiSPP1tsJirOu/nVWgwNwouxSIrsBjv+auecTBEVAaD7X7w7RnvJSSj4ZINLM1znUe2cR/KbnZ/rmyQs/8gJ0pRYcZTXd7856QO7invDC1SMhICIvSpC6c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36e3857-c7c1-4772-661c-08d709f39747
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 13:43:31.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1046afrwy board is based on nxp ls1046a SoC.
Board support's 4GB ddr memory, i2c, microSD card,
serial console,qspi nor flash,ifc nand flash,qsgmii network interface,
usb 3.0 and serdes interface to support two x1gen3 pcie interface.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 156 +++++++++++++++++=
++++
 2 files changed, 157 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 0bd122f..1211531 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1046a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1046a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1046a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1088a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm6=
4/boot/dts/freescale/fsl-ls1046a-frwy.dts
new file mode 100644
index 0000000..cda4998
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree Include file for Freescale Layerscape-1046A family SoC.
+ *
+ * Copyright 2019 NXP.
+ *
+ */
+
+/dts-v1/;
+
+#include "fsl-ls1046a.dtsi"
+
+/ {
+	model =3D "LS1046A FRWY Board";
+	compatible =3D "fsl,ls1046a-frwy", "fsl,ls1046a";
+
+	aliases {
+		serial0 =3D &duart0;
+		serial1 =3D &duart1;
+		serial2 =3D &duart2;
+		serial3 =3D &duart3;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "LT8642SEV-3.3V";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&duart0 {
+	status =3D "okay";
+};
+
+&duart1 {
+	status =3D "okay";
+};
+
+&duart2 {
+	status =3D "okay";
+};
+
+&duart3 {
+	status =3D "okay";
+};
+
+&i2c0 {
+	status =3D "okay";
+
+	i2c-mux@77 {
+		compatible =3D "nxp,pca9546";
+		reg =3D <0x77>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		i2c@0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0>;
+
+			power-monitor@40 {
+				compatible =3D "ti,ina220";
+				reg =3D <0x40>;
+				shunt-resistor =3D <1000>;
+			};
+
+
+			temperature-sensor@4c {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4c>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+
+			rtc@51 {
+				compatible =3D "nxp,pcf2129";
+				reg =3D <0x51>;
+			};
+
+			eeprom@52 {
+				compatible =3D "atmel,24c512";
+				reg =3D <0x52>;
+			};
+
+			eeprom@53 {
+				compatible =3D "atmel,24c512";
+				reg =3D <0x53>;
+			};
+
+		};
+	};
+};
+
+&ifc {
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+	/* NAND Flash */
+	ranges =3D <0x0 0x0 0x0 0x7e800000 0x00010000>;
+	status =3D "okay";
+
+	nand@0,0 {
+		compatible =3D "fsl,ifc-nand";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x0 0x0 0x10000>;
+	};
+
+};
+
+#include "fsl-ls1046-post.dtsi"
+
+&fman0 {
+	ethernet@e0000 {
+		phy-handle =3D <&qsgmii_phy4>;
+		phy-connection-type =3D "qsgmii";
+	};
+
+	ethernet@e8000 {
+		phy-handle =3D <&qsgmii_phy2>;
+		phy-connection-type =3D "qsgmii";
+	};
+
+	ethernet@ea000 {
+		phy-handle =3D <&qsgmii_phy1>;
+		phy-connection-type =3D "qsgmii";
+	};
+
+	ethernet@f2000 {
+		phy-handle =3D <&qsgmii_phy3>;
+		phy-connection-type =3D "qsgmii";
+	};
+
+	mdio@fd000 {
+		qsgmii_phy1: ethernet-phy@1c {
+			reg =3D <0x1c>;
+		};
+
+		qsgmii_phy2: ethernet-phy@1d {
+			reg =3D <0x1d>;
+		};
+
+		qsgmii_phy3: ethernet-phy@1e {
+			reg =3D <0x1e>;
+		};
+
+		qsgmii_phy4: ethernet-phy@1f {
+			reg =3D <0x1f>;
+		};
+	};
+};
--=20
2.7.4

