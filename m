Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306BC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C52B206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VPFlLkkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfKLHUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:20:04 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:5526 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:20:02 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: +MnSm9BKqlFLKbE1vZVZ5RosDS9Y5Mp3bE1qyq4JxSQLmhs7D2SZh3iwLxCT2YEufrYiq0ekAP
 x+kwr8XgfeTbst5P0REQLg3Ix/SsOzVDcGCcMz15Xp+NuVpz3EKaI0xgUNC3lTl3i7lf6RRSdj
 K0MwyeKkRLFTnS4ISjiMCtqNgTkzGDA0XCazpCFnD+KsrkPNGoL+pt+qqiO8FbuEMD3Y09ufGz
 sh4RzbE2/odFNUPE7LWOqEnG4f9/l1SWqLGUJ6uFpp6eVe+PYa+jWiTGGDwh4Ymmpa1FeK0KVH
 wYk=
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="54997992"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Nov 2019 00:20:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 00:19:58 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 00:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oExzsAyoLri81bqs/rxIbsB8uXROu5ZJjWJbkdICQrHVqYkFkHRqmnufoEezFRyYh+iKPgufe/QTG3mU3acsVdbDmd5E4/l2awQtrKJ9RojzJRE9FUUwPxf3OaExkH4wdWZLZnQQBnzuKoxbvk+7GTwdbLOq/A9ssJl81WAqYAJfUn1R1h6ezDz1aWUBMBMTmDV5/K4vVfkZdzQjkR+2RCG34ARjvR2mwvnqz3JLU0ameKv4HoC9jJ+O8OaMWwVJKskbw/3oB3tzHKb2BvxPJhgWJf3RFXuWQ/tNUEWq2f9X2c/Q5EQh+RU0tiBexLGqrPAxK6xBFDVLac1kFTmXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am8Vi0yxlknLRFiusMlTiG0RhwlsGVkGVyuDDprD3TA=;
 b=WcrTR+ZbuHWT9Oy5iESsRRGZSd6kjp/Xuj12pjR1j1wRrn/b1r3/6cBYhj5qN3kVA7JWVDkiL6d+7yPR0cB+PLqS93CsrSqod9h4NibzwujMfYBqy6UkfXwUZU92L+vQsygXpWP94lSysYH6HcENcsCtkMZ1Lu3jLGxTvvjKJVKx8v1f/P+Z9ECN1Rh/4ekupoMNyHj8qziST1KxF4sJyStK51bB6X8enKt3QGQSvfq2yjrACwW7UzJVLMagcE2F+YttAfJf6X2r5RoJsq9eFyVnrO3Hc+cLC7O00sQVLq9+1FkwnJFntSuecE0PxyMv+EFuFwcqyyTDW+YXBx+Obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am8Vi0yxlknLRFiusMlTiG0RhwlsGVkGVyuDDprD3TA=;
 b=VPFlLkkBqkdPjD/eslNsW1cLP3WOQhV0qssEyr06yzSj1lXxFRwVHp3c4Na53uP1aYccAG3Gr5BbfRxT2aEQwV7JGnPCA2tk+I/5MCOwdrnwetz/TYbV4VcESFJANg18ddl5rUIG/vXictJRKiQMJ7YpRL00tE//INZ9ylq1+wc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1323.namprd11.prod.outlook.com (10.168.108.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 07:19:56 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 07:19:56 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 4/4] ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and
 wlsom1-ek
Thread-Topic: [PATCH 4/4] ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1
 and wlsom1-ek
Thread-Index: AQHVmSmVZPTswPTROkGYb6lRMpcPIA==
Date:   Tue, 12 Nov 2019 07:19:56 +0000
Message-ID: <1573543139-8533-4-git-send-email-eugen.hristev@microchip.com>
References: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:208:15::26) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa48345-061d-4e9b-3048-08d76740b824
x-ms-traffictypediagnostic: DM5PR11MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1323F1349E0C46783628BCABE8770@DM5PR11MB1323.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(30864003)(186003)(81156014)(8676002)(8936002)(81166006)(50226002)(6116002)(3846002)(7736002)(2906002)(54906003)(36756003)(6636002)(478600001)(2501003)(110136005)(316002)(6436002)(71200400001)(71190400001)(86362001)(14454004)(25786009)(305945005)(486006)(2616005)(66946007)(5660300002)(76176011)(52116002)(4326008)(26005)(476003)(386003)(6486002)(66066001)(102836004)(6506007)(66556008)(446003)(256004)(6512007)(64756008)(107886003)(99286004)(66476007)(14444005)(11346002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1323;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /k6Z8JJ0LNUgstqp8HOpuU31iz8SoIIxf+nDbLVAwouV2lQdule0RNCJGuwUiSu6tQ6eBYFpvuEsO8SczsgmOlgs1CAlM6XMrumRhrViYtcine/uM4qElz53BgbabPZDsl713+ukexSHUNeAXj/gSQQ4XhJUiRXjTBlE8VFJmYvf7MfLjI6ZPPwvHRb5mHslTTOjpm0yjQK2CRfwYLCC8wDYTj88YZJ30jAdmFRga5WJAN0ncofY8dgLkp3MKhgVbiU9uuJL5B4hUIr/q9Sklgr1QPGeH4D2eKbzIt994nyXC3fTqc8u5wgGuwjHpRHvw/VkqWWE9q0JzdTn92heoSdc3PWPVPIQYpmK/j1AVKBlqYB4BH2KK1OWaY14uipFppDmPlzJVILwNF3OdbZLM9VL3ZR6XuO/j+7auZSrfz8+CWAnDQCs/BcqVZGW96+V
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: caa48345-061d-4e9b-3048-08d76740b824
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:19:56.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0BsY2c2k2YiB1H2gjKrZmi/hOyFNqdgRdAGE4Q5QLhfuN2go/YyoAK1KBMYBci2aVdZFR1b+XUbs5QkeDKNiDYIU+dtYlojFdZio1irzUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This is the addition of a new Evaluation Kit the SAMA5D27-WLSOM1-EK.
It's based on the Microchip WireLess SoM which contains the
SAMA5D27 LPDDR2 2Gbits SiP.

[nicolas.ferre@microchip.com]: initial implementation
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[eugen.hristev@microchip.com]: ported to new kernel version,
[eugen.hristev@microchip.com]: addition of peripherals (adc, pmic, qspi, ua=
rt)
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 304 ++++++++++++++++++++++=
++++
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 270 ++++++++++++++++++++++=
+
 3 files changed, 575 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4ac0531..3beb450 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_SOC_SAM_V7) +=3D \
 	at91-kizbox3-hs.dtb \
 	at91-nattis-2-natte-2.dtb \
 	at91-sama5d27_som1_ek.dtb \
+	at91-sama5d27_wlsom1_ek.dtb \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dt=
s/at91-sama5d27_wlsom1.dtsi
new file mode 100644
index 0000000..db3e223
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sama5d27_wlsom1.dtsi - Device Tree file for SAMA5D27 WLSOM1
+ *
+ * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Nicolas Ferre <nicolas.ferre@microcihp.com>
+ * Author: Eugen Hristev <eugen.hristev@microcihp.com>
+ */
+#include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/pinctrl/at91.h>
+
+/ {
+	model =3D "Microchip SAMA5D27 WLSOM1";
+	compatible =3D "microchip,sama5d27-wlsom1", "atmel,sama5d27", "atmel,sama=
5d2", "atmel,sama5";
+
+	clocks {
+		slow_xtal {
+			clock-frequency =3D <32768>;
+		};
+
+		main_xtal {
+			clock-frequency =3D <24000000>;
+		};
+	};
+};
+
+&flx1 {
+	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
+
+	uart6: serial@200 {
+		compatible =3D "atmel,at91sam9260-usart";
+		reg =3D <0x200 0x200>;
+		interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas =3D <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(13))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(14))>;
+		dma-names =3D "tx", "rx";
+		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
+		clock-names =3D "usart";
+		pinctrl-0 =3D <&pinctrl_flx1_default>;
+		pinctrl-names =3D "default";
+	};
+};
+
+&i2c0 {
+	pinctrl-0 =3D <&pinctrl_i2c0_default>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&i2c1 {
+	dmas =3D <0>, <0>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c1_default>;
+	status =3D "okay";
+
+	mcp16502@5b {
+		compatible =3D "microchip,mcp16502";
+		reg =3D <0x5b>;
+		status =3D "okay";
+		lpm-gpios =3D <&pioBU 0 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			vdd_3v3: VDD_IO {
+				regulator-name =3D "VDD_IO";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3700000>;
+				regulator-initial-mode =3D <2>;
+				regulator-allowed-modes =3D <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode =3D <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode =3D <4>;
+				};
+			};
+
+			vddio_ddr: VDD_DDR {
+				regulator-name =3D "VDD_DDR";
+				regulator-min-microvolt =3D <600000>;
+				regulator-max-microvolt =3D <1850000>;
+				regulator-initial-mode =3D <2>;
+				regulator-allowed-modes =3D <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1200000>;
+					regulator-changeable-in-suspend;
+					regulator-mode =3D <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1200000>;
+					regulator-changeable-in-suspend;
+					regulator-mode =3D <4>;
+				};
+			};
+
+			vdd_core: VDD_CORE {
+				regulator-name =3D "VDD_CORE";
+				regulator-min-microvolt =3D <600000>;
+				regulator-max-microvolt =3D <1850000>;
+				regulator-initial-mode =3D <2>;
+				regulator-allowed-modes =3D <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode =3D <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode =3D <4>;
+				};
+			};
+
+			vdd_ddr: VDD_OTHER {
+				regulator-name =3D "VDD_OTHER";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-initial-mode =3D <2>;
+				regulator-allowed-modes =3D <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1800000>;
+					regulator-changeable-in-suspend;
+					regulator-mode =3D <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt =3D <1800000>;
+					regulator-changeable-in-suspend;
+					regulator-mode =3D <4>;
+				};
+			};
+
+			LDO1 {
+				regulator-name =3D "LDO1";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3700000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			LDO2 {
+				regulator-name =3D "LDO2";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3700000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&macb0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_macb0_default>;
+	phy-mode =3D "rmii";
+
+	ethernet-phy@0 {
+		reg =3D <0x0>;
+		interrupt-parent =3D <&pioA>;
+		interrupts =3D <PIN_PB24 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_macb0_phy_irq>;
+	};
+};
+
+&pmc {
+	atmel,osc-bypass;
+};
+
+&qspi1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_qspi1_default>;
+	status =3D "disabled";
+
+	qspi1_flash: spi_flash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor";
+		reg =3D <0>;
+		spi-max-frequency =3D <80000000>;
+		spi-rx-bus-width =3D <4>;
+		spi-tx-bus-width =3D <4>;
+		m25p,fast-read;
+		status =3D "disabled";
+
+		at91bootstrap@0 {
+			label =3D "at91bootstrap";
+			reg =3D <0x0 0x40000>;
+		};
+
+		bootloader@40000 {
+			label =3D "bootloader";
+			reg =3D <0x40000 0xc0000>;
+		};
+
+		bootloaderenvred@100000 {
+			label =3D "bootloader env redundant";
+			reg =3D <0x100000 0x40000>;
+		};
+
+		bootloaderenv@140000 {
+			label =3D "bootloader env";
+			reg =3D <0x140000 0x40000>;
+		};
+
+		dtb@180000 {
+			label =3D "device tree";
+			reg =3D <0x180000 0x80000>;
+		};
+
+		kernel@200000 {
+			label =3D "kernel";
+			reg =3D <0x200000 0x600000>;
+		};
+	};
+};
+
+&pioA {
+	pinctrl_flx1_default: flx1_usart_default {
+		pinmux =3D <PIN_PA24__FLEXCOM1_IO0>,
+			 <PIN_PA23__FLEXCOM1_IO1>,
+			 <PIN_PA25__FLEXCOM1_IO3>,
+			 <PIN_PA26__FLEXCOM1_IO4>;
+		bias-disable;
+	};
+
+	pinctrl_i2c0_default: i2c0_default {
+		pinmux =3D <PIN_PD21__TWD0>,
+			 <PIN_PD22__TWCK0>;
+		bias-disable;
+	};
+
+	pinctrl_i2c1_default: i2c1_default {
+		pinmux =3D <PIN_PD19__TWD1>,
+			 <PIN_PD20__TWCK1>;
+		bias-disable;
+	};
+
+	pinctrl_macb0_default: macb0_default {
+		pinmux =3D <PIN_PB14__GTXCK>,
+			 <PIN_PB15__GTXEN>,
+			 <PIN_PB16__GRXDV>,
+			 <PIN_PB17__GRXER>,
+			 <PIN_PB18__GRX0>,
+			 <PIN_PB19__GRX1>,
+			 <PIN_PB20__GTX0>,
+			 <PIN_PB21__GTX1>,
+			 <PIN_PB22__GMDC>,
+			 <PIN_PB23__GMDIO>;
+		bias-disable;
+	};
+
+	pinctrl_macb0_phy_irq: macb0_phy_irq {
+		pinmux =3D <PIN_PB24__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_qspi1_default: qspi1_default {
+		pinmux =3D <PIN_PB5__QSPI1_SCK>,
+			 <PIN_PB6__QSPI1_CS>,
+			 <PIN_PB7__QSPI1_IO0>,
+			 <PIN_PB8__QSPI1_IO1>,
+			 <PIN_PB9__QSPI1_IO2>,
+			 <PIN_PB10__QSPI1_IO3>;
+		bias-pull-up;
+	};
+};
+
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/=
dts/at91-sama5d27_wlsom1_ek.dts
new file mode 100644
index 0000000..0b9fa29
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sama5d27_wlsom1_ek.dts - Device Tree file for SAMA5D27 WLSOM1 EK
+ *
+ * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Nicolas Ferre <nicolas.ferre@microcihp.com>
+ */
+/dts-v1/;
+#include "at91-sama5d27_wlsom1.dtsi"
+
+/ {
+	model =3D "Microchip SAMA5D27 WLSOM1 EK";
+	compatible =3D "microchip,sama5d27-wlsom1-ek", "microchip,sama5d27-wlsom1=
", "atmel,sama5d27", "atmel,sama5d2", "atmel,sama5";
+
+	aliases {
+		serial0 =3D &uart0;	/* DBGU */
+		serial1 =3D &uart6;	/* BT */
+		serial2 =3D &uart5;	/* mikro BUS 2 */
+		serial3 =3D &uart3;	/* mikro BUS 1 */
+		i2c1	=3D &i2c1;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	gpio_keys {
+		compatible =3D "gpio-keys";
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_key_gpio_default>;
+		status =3D "okay";
+
+		sw4 {
+			label =3D "USER BUTTON";
+			gpios =3D <&pioA PIN_PB2 GPIO_ACTIVE_LOW>;
+			linux,code =3D <0x104>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_led_gpio_default>;
+		status =3D "okay";
+
+		red {
+			label =3D "red";
+			gpios =3D <&pioA PIN_PA6 GPIO_ACTIVE_HIGH>;
+		};
+
+		green {
+			label =3D "green";
+			gpios =3D <&pioA PIN_PA7 GPIO_ACTIVE_HIGH>;
+		};
+
+		blue {
+			label =3D "blue";
+			gpios =3D <&pioA PIN_PA8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "heartbeat";
+		};
+	};
+};
+
+&adc {
+	vddana-supply =3D <&vdd_3v3>;
+	vref-supply =3D <&vdd_3v3>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_adc_default>;
+	status =3D "okay";
+};
+
+&flx0 {
+	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
+	status =3D "okay";
+
+	uart5: serial@200 {
+		compatible =3D "atmel,at91sam9260-usart";
+		reg =3D <0x200 0x200>;
+		interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas =3D <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(11))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(12))>;
+		dma-names =3D "tx", "rx";
+		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
+		clock-names =3D "usart";
+		pinctrl-0 =3D <&pinctrl_flx0_default>;
+		pinctrl-names =3D "default";
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status =3D "okay";
+	};
+};
+
+&flx1 {
+	status =3D "okay";
+
+	uart6: serial@200 {
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status =3D "okay";
+	};
+};
+
+&macb0 {
+	status =3D "okay";
+};
+
+&pioA {
+	/*
+	 * There is no real pinmux for ADC, if the pin
+	 * is not requested by another peripheral then
+	 * the muxing is done when channel is enabled.
+	 * Requesting pins for ADC is GPIO is
+	 * encouraged to prevent conflicts and to
+	 * disable bias in order to be in the same
+	 * state when the pin is not muxed to the adc.
+	 */
+	pinctrl_adc_default: adc_default {
+		pinmux =3D <PIN_PD25__GPIO>,
+			 <PIN_PD26__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_flx0_default: flx0_usart_default {
+		pinmux =3D <PIN_PB28__FLEXCOM0_IO0>,
+			 <PIN_PB29__FLEXCOM0_IO1>;
+		bias-disable;
+	};
+
+	pinctrl_key_gpio_default: key_gpio_default {
+		pinmux =3D <PIN_PB2__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_led_gpio_default: led_gpio_default {
+		pinmux =3D <PIN_PA6__GPIO>,
+			 <PIN_PA7__GPIO>,
+			 <PIN_PA8__GPIO>;
+		bias-pull-down;
+	};
+
+	pinctrl_sdmmc0_default: sdmmc0_default {
+		cmd_data {
+			pinmux =3D <PIN_PA1__SDMMC0_CMD>,
+				 <PIN_PA2__SDMMC0_DAT0>,
+				 <PIN_PA3__SDMMC0_DAT1>,
+				 <PIN_PA4__SDMMC0_DAT2>,
+				 <PIN_PA5__SDMMC0_DAT3>;
+			bias-disable;
+		};
+
+		ck_cd_vddsel {
+			pinmux =3D <PIN_PA0__SDMMC0_CK>,
+				 <PIN_PA11__SDMMC0_VDDSEL>,
+				 <PIN_PA12__SDMMC0_WP>,
+				 <PIN_PA13__SDMMC0_CD>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart0_default: uart0_default {
+		pinmux =3D <PIN_PB26__URXD0>,
+			 <PIN_PB27__UTXD0>;
+		bias-disable;
+	};
+
+	pinctrl_uart3_default: uart3_default {
+		pinmux =3D <PIN_PB11__URXD3>,
+			 <PIN_PB12__UTXD3>;
+		bias-disable;
+	};
+
+	pinctrl_pwm0_default: pwm0_default {
+		pinmux =3D <PIN_PA31__PWML0>,
+			 <PIN_PA30__PWMH0>;
+		bias-disable;
+	};
+
+	pinctrl_usb_default: usb_default {
+		pinmux =3D <PIN_PA10__GPIO>;
+		bias-disable;
+	};
+};
+
+&pwm0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_pwm0_default>;
+	status =3D "okay";
+};
+
+&qspi1 {
+	status =3D "okay";
+
+	qspi1_flash: spi_flash@0 {
+		status =3D "okay";
+	};
+};
+
+&sdmmc0 {
+	bus-width =3D <4>;
+	mmc-ddr-3_3v;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sdmmc0_default>;
+	status =3D "okay";
+};
+
+&shutdown_controller {
+	atmel,shdwc-debouncer =3D <976>;
+	atmel,wakeup-rtc-timer;
+
+	input@0 {
+		reg =3D <0>;
+		atmel,wakeup-type =3D "low";
+	};
+};
+
+&tcb0 {
+	timer0: timer@0 {
+		compatible =3D "atmel,tcb-timer";
+		reg =3D <0>;
+	};
+
+	timer1: timer@1 {
+		compatible =3D "atmel,tcb-timer";
+		reg =3D <1>;
+	};
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart0_default>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status =3D "okay";
+};
+
+&uart3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart3_default>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status =3D "okay";
+};
+
+&usb1 {
+	num-ports =3D <3>;
+	atmel,vbus-gpio =3D <0
+			   &pioA PIN_PA10 GPIO_ACTIVE_HIGH
+			   0
+			  >;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_usb_default>;
+	status =3D "okay";
+};
+
+&usb2 {
+	phy_type =3D "hsic";
+	status =3D "okay";
+};
+
+&watchdog {
+	status =3D "okay";
+};
+
--=20
2.7.4

