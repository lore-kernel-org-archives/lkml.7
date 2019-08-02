Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2372C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4382087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mqVpanE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406750AbfHBTrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:47:42 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:31662
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405999AbfHBTrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQQoV0BjEaB6+MNCipcPbJjac72s4BHlHFseOfblMbpc5XMI45lqNuVrN42rdpuN7+rexuxgD0Bh8Z3uNqroBVsriX3aewj2RN8TTYVH1tUoFg8QC5iVvXzVtbe3wk38gLItyIyuWFWiHp8w5bkhD/6pIzq87trubsMhcjt2P8kOpZpowd5052ictYi+fWJWKG4aeTUnRR3CJJwRWaO8EBucX2rZM/MEJwhhiQmKhON4b8DB4v5NMgOyoAjh99KzvV13xoR3Q5BjJEvS77ADa9/ssq2sxC44yif4jHhkzzBu6qlddShe7CbnrOkTquGmZJtGdGItnBE8jUdIaegU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE/gC6i1cHXtF/6zcPk+yKMd6cFbA5iKCkKABP46PEI=;
 b=Ffm8CVzablXv34woqynPcOyStVoN75v/4/F8mb+z/ALB76/HJC6ppny6me+svrQvCNmlwxn4hVikSjqkMUJcylidjSYb1bgrExSKaFeLi4tpRWTVj8NpJrPZCWGAB5W2hUGIGg6ebi7oC+pwNIRNh7j5qWBN9ejVShOOS0SoHUBC7zOOOLxHaDkDy8xpIHlbGP7SBfM8bzCWwC3ozlPtkJefSBPX1vFEcC+8iT3o6mOCImubk6hUSBUaglRXX9hWSg/rScOX3w+JVgpNlDJwNeye04YsO5kHz02NCYan9PU+uUla7UcxtHfUrLqIZMdFuEhrYOrpd7+c5yjSV4juaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE/gC6i1cHXtF/6zcPk+yKMd6cFbA5iKCkKABP46PEI=;
 b=mqVpanE6s4H2TwxqUpaM/T0aabeKQPYcfPf0PuazvUVHRyzh6BwaDrt/Vz3Vevuc+4tLZEsgg4APt4GTxmgZmKpRuH47/eyNQ3uQtWH09yPs0goibEtB0UiLUGDtTqtbSg8bmGISU6RUQ7iL9FPyePjNLdKjdh3LtbMjXRPSV04=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2829.eurprd04.prod.outlook.com (10.175.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 19:47:20 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 19:47:20 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Dan Nica <dan.nica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 3/6] arm64: dts: fsl: Add device tree for S32V234-EVB
Thread-Topic: [PATCH 3/6] arm64: dts: fsl: Add device tree for S32V234-EVB
Thread-Index: AQHVSWsY8BwSLOGir0eFJATVCFuxHw==
Date:   Fri, 2 Aug 2019 19:47:20 +0000
Message-ID: <20190802194702.30249-4-stefan-gabriel.mirea@nxp.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b02beb62-60cb-41bf-e550-08d717823af3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2829;
x-ms-traffictypediagnostic: VI1PR0402MB2829:
x-microsoft-antispam-prvs: <VI1PR0402MB2829118EB1A38F56A38E1516DFD90@VI1PR0402MB2829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(68736007)(446003)(8676002)(6486002)(54906003)(110136005)(3846002)(305945005)(7416002)(1076003)(14444005)(6116002)(66066001)(2906002)(2201001)(316002)(256004)(36756003)(6636002)(486006)(102836004)(14454004)(71200400001)(53936002)(26005)(66476007)(11346002)(81166006)(71190400001)(186003)(76176011)(66946007)(2616005)(64756008)(8936002)(66446008)(66556008)(99286004)(4326008)(386003)(6506007)(5660300002)(2501003)(52116002)(81156014)(50226002)(25786009)(476003)(478600001)(86362001)(7736002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2829;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LGIGpNA37BiSz1FHUQGWLN4v1PwIIn0RSOBNqOHYWEQqy1V+OYspaF52z/FsVPvyGufXj8Yr76y24U7ZabV1erBkeZm2fKL0ub7HHJUrqCJPNRM7ah11/KWuQ5DZMER2rxPGWaAwo3NqZ/HYZPIJlJWke9ojj7T7NzfH0/Kf0i3coWxkWBkgMiUM5p/3TYzth7ZP3rCwijcctbsSEKgUhwVXQScjX1UGS5w4F/96nESkjqCSMCmvoUbC35RTOin7vokZL0baE3WJyPCBGtcPZ5PUB2KiW7EWwHQ3owEIdXe4f2OZXvkkiz04lFw7T0RKwQ+wvlGYhdkvoXn9e4ZqN6uS3do5BxfBsXfl8bAXLwxy+Qd3Jb0qAtBMq1SoZ9Jgu+KNdKL76pph8GNxmRFUoMvuvmgSr8ilNTOR/9Xcmjg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02beb62-60cb-41bf-e550-08d717823af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 19:47:20.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stefan-gabriel.mirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>

Add initial version of device tree for S32V234-EVB, including nodes for the
4 Cortex-A53 cores, AIPS bus with UART modules, ARM architected timer and
Generic Interrupt Controller (GIC).

Keep SoC level separate from board level to let future boards with this SoC
share common properties, while the dts files will keep board-dependent
properties.

Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../boot/dts/freescale/fsl-s32v234-evb.dts    |  20 +++
 .../arm64/boot/dts/freescale/fsl-s32v234.dtsi | 130 ++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index c043aca66572..3af29b58a833 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -26,3 +26,5 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-zest.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
+
+dtb-$(CONFIG_ARCH_S32) +=3D fsl-s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts b/arch/arm64=
/boot/dts/freescale/fsl-s32v234-evb.dts
new file mode 100644
index 000000000000..9b3983402998
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2017 NXP
+ */
+
+/dts-v1/;
+#include "fsl-s32v234.dtsi"
+
+/ {
+	compatible =3D "fsl,s32v234-evb", "fsl,s32v234";
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-s32v234.dtsi
new file mode 100644
index 000000000000..6d686d3ba997
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2018 NXP
+ */
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	model =3D "Freescale S32V234";
+	compatible =3D "fsl,s32v234";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	aliases {
+		serial0 =3D &uart0;
+		serial1 =3D &uart1;
+	};
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x0>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster0_l2_cache>;
+		};
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x1>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster0_l2_cache>;
+		};
+		cpu2: cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x100>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster1_l2_cache>;
+		};
+		cpu3: cpu@101 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x101>;
+			enable-method =3D "spin-table";
+			cpu-release-addr =3D <0x0 0x80000000>;
+			next-level-cache =3D <&cluster1_l2_cache>;
+		};
+
+		cluster0_l2_cache: l2-cache0 {
+			compatible =3D "cache";
+		};
+
+		cluster1_l2_cache: l2-cache1 {
+			compatible =3D "cache";
+		};
+	};
+
+	soc {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		compatible =3D "simple-bus";
+		interrupt-parent =3D <&gic>;
+		ranges;
+
+		aips0: aips-bus@40000000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			interrupt-parent =3D <&gic>;
+			reg =3D <0x0 0x40000000 0x0 0x7D000>;
+			ranges;
+
+			uart0: serial@40053000 {
+				compatible =3D "fsl,s32-linflexuart";
+				reg =3D <0x0 0x40053000 0x0 0x1000>;
+				interrupts =3D <0 59 1>;
+				status =3D "disabled";
+			};
+		};
+
+		aips1: aips-bus@40080000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			interrupt-parent =3D <&gic>;
+			reg =3D <0x0 0x40080000 0x0 0x70000>;
+			ranges;
+
+			uart1: serial@400bc000 {
+				compatible =3D "fsl,s32-linflexuart";
+				reg =3D <0x0 0x400bc000 0x0 0x1000>;
+				interrupts =3D <0 60 1>;
+				status =3D "disabled";
+			};
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+		/* clock-frequency might be modified by u-boot, depending on the
+		 * chip version.
+		 */
+		clock-frequency =3D <10000000>;
+	};
+
+	gic: interrupt-controller@7d001000 {
+		compatible =3D "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells =3D <3>;
+		#address-cells =3D <0>;
+		interrupt-controller;
+		reg =3D <0 0x7d001000 0 0x1000>,
+		      <0 0x7d002000 0 0x2000>,
+		      <0 0x7d004000 0 0x2000>,
+		      <0 0x7d006000 0 0x2000>;
+		interrupts =3D <1 9 0xf04>;
+	};
+};
--=20
2.22.0

