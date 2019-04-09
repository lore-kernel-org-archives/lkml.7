Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABC4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EF20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bGE76B1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDIJIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:08:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbfDIJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:08:16 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x398pmKO021436;
        Tue, 9 Apr 2019 11:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Ihw2vSvs6AA0LkCRPUc9omKGsQLZXtdPzeoLMV4GV8M=;
 b=bGE76B1mDj+fmCfRs1h/HgHbFOQti3turh+Z0DoL+8SRZAGp5cGdzmasNCHDBnbl76CH
 +V9nTL4rn+IE5M43qX1ZGoG87IUs/RcHe101yFlh4uvavmKroLqd2ISJ++BCLN9IUUnw
 itYBSF8MUl5T471hizzoQ3ao8hmpghiiL98yYuDsWejl9PiyRCP0wRkT84DQ/st3z9l5
 ef+bVVXiSE+F4KtdPshtayDRkRQ5WTiuK7BqPJOyt8ooEqV/RYnvZ5h0K9XUy/odYS/0
 Rp+XGC/SddDgmH512IlMD9DhiFYmfrMUY7g6N5oYy9y4EnyMrbRV4GuJhUfhbkcZ6WQz uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wgkf6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:07:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DD7F31;
        Tue,  9 Apr 2019 09:07:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13E562748;
        Tue,  9 Apr 2019 09:07:04 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Apr
 2019 11:07:03 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 9 Apr 2019 11:07:03 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/3] ARM: dts: stm32: add stpmic1 support on stm32mp157a
 dk1 board
Thread-Topic: [PATCH v2 2/3] ARM: dts: stm32: add stpmic1 support on
 stm32mp157a dk1 board
Thread-Index: AQHU7rOZC+/rg+MUg028eou+9g6Okw==
Date:   Tue, 9 Apr 2019 09:07:03 +0000
Message-ID: <1554800820-5412-3-git-send-email-p.paillet@st.com>
References: <1554800820-5412-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1554800820-5412-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds stpmic1 support on stm32mp157a dk1 board.
The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.
The DMAs are disabled because the PMIC generates a very few traffic and
DMA channels may lack for other usage.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 158 ++++++++++++++++++++++++++++++=
++--
 1 file changed, 150 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm3=
2mp157a-dk1.dts
index 1b1886d..4bb91ab 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -9,6 +9,7 @@
 #include "stm32mp157c.dtsi"
 #include "stm32mp157-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
=20
 / {
 	model =3D "STMicroelectronics STM32MP157A-DK1 Discovery Board";
@@ -36,14 +37,6 @@
 			default-state =3D "off";
 		};
 	};
-
-	v3v3: regulator-3v3 {
-		compatible =3D "regulator-fixed";
-		regulator-name =3D "v3v3";
-		regulator-min-microvolt =3D <3300000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-always-on;
-	};
 };
=20
 &ethernet0 {
@@ -65,6 +58,155 @@
 	};
 };
=20
+
+&i2c4 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c4_pins_a>;
+	i2c-scl-rising-time-ns =3D <185>;
+	i2c-scl-falling-time-ns =3D <20>;
+	status =3D "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pmic: stpmic@33 {
+		compatible =3D "st,stpmic1";
+		reg =3D <0x33>;
+		interrupts-extended =3D <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+		status =3D "okay";
+
+		regulators {
+			compatible =3D "st,stpmic1-regulators";
+			ldo1-supply =3D <&v3v3>;
+			ldo3-supply =3D <&vdd_ddr>;
+			ldo6-supply =3D <&v3v3>;
+			pwr_sw1-supply =3D <&bst_out>;
+			pwr_sw2-supply =3D <&bst_out>;
+
+			vddcore: buck1 {
+				regulator-name =3D "vddcore";
+				regulator-min-microvolt =3D <800000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-always-on;
+				regulator-initial-mode =3D <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd_ddr: buck2 {
+				regulator-name =3D "vdd_ddr";
+				regulator-min-microvolt =3D <1350000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-always-on;
+				regulator-initial-mode =3D <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd: buck3 {
+				regulator-name =3D "vdd";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-always-on;
+				st,mask-reset;
+				regulator-initial-mode =3D <0>;
+				regulator-over-current-protection;
+			};
+
+			v3v3: buck4 {
+				regulator-name =3D "v3v3";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+				regulator-initial-mode =3D <0>;
+			};
+
+			v1v8_audio: ldo1 {
+				regulator-name =3D "v1v8_audio";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-always-on;
+				interrupts =3D <IT_CURLIM_LDO1 0>;
+			};
+
+			v3v3_hdmi: ldo2 {
+				regulator-name =3D "v3v3_hdmi";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-always-on;
+				interrupts =3D <IT_CURLIM_LDO2 0>;
+			};
+
+			vtt_ddr: ldo3 {
+				regulator-name =3D "vtt_ddr";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <750000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			vdd_usb: ldo4 {
+				regulator-name =3D "vdd_usb";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				interrupts =3D <IT_CURLIM_LDO4 0>;
+			};
+
+			vdda: ldo5 {
+				regulator-name =3D "vdda";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <2900000>;
+				interrupts =3D <IT_CURLIM_LDO5 0>;
+				regulator-boot-on;
+			};
+
+			v1v2_hdmi: ldo6 {
+				regulator-name =3D "v1v2_hdmi";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <1200000>;
+				regulator-always-on;
+				interrupts =3D <IT_CURLIM_LDO6 0>;
+			};
+
+			vref_ddr: vref_ddr {
+				regulator-name =3D "vref_ddr";
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			 bst_out: boost {
+				regulator-name =3D "bst_out";
+				interrupts =3D <IT_OCP_BOOST 0>;
+			 };
+
+			vbus_otg: pwr_sw1 {
+				regulator-name =3D "vbus_otg";
+				interrupts =3D <IT_OCP_OTG 0>;
+			 };
+
+			 vbus_sw: pwr_sw2 {
+				regulator-name =3D "vbus_sw";
+				interrupts =3D <IT_OCP_SWOUT 0>;
+				regulator-active-discharge;
+			 };
+		};
+
+		onkey {
+			compatible =3D "st,stpmic1-onkey";
+			interrupts =3D <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
+			interrupt-names =3D "onkey-falling", "onkey-rising";
+			power-off-time-sec =3D <10>;
+			status =3D "okay";
+		};
+
+		watchdog {
+			compatible =3D "st,stpmic1-wdt";
+			status =3D "disabled";
+		};
+	};
+};
+
 &ipcc {
 	status =3D "okay";
 };
--=20
1.9.1
