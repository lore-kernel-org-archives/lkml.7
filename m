Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702F20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="m0TAVI6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfDIJIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:08:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfDIJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:08:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x398pmKP021436;
        Tue, 9 Apr 2019 11:07:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=hHT9Ly9nAzaF/qpOAbbdbqdWgGi3WGKDqJqHavDy+No=;
 b=m0TAVI6aUx4Nw//2qtgQPB8Zw/uR0gF5JRbsNhqCcDWQfz7GuEXKjIFFa1gemlAk/SBT
 rF7JoRKm7PJk8AS/9DADopvj1Rw7ITWFP72QRERLbtb+mUFkho9uvPEpvzOy0K4xWl/g
 cjye7ltqZy6LAPa7TpJsH58AXHl3DC7D6vmhnE7dMF2VUzc6XoVJupi8Lv+UeFIBntV6
 K/1m+ektXrfka61maqYRlUrzZiICbiJgtGedU5el+QyWBwOwYqKuh2WbuBwBQw4J0j5l
 vW7vKhbpHbq46j4XeyJmkJsiXl93o2vXQljyuh2C6/GXKuoUOkTbdaKlqw1voGZsiA6F 8A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wgkf7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:07:11 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B73CC41;
        Tue,  9 Apr 2019 09:07:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 864942723;
        Tue,  9 Apr 2019 09:07:03 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Apr
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
Subject: [PATCH v2 1/3] ARM: dts: stm32: add stpmic1 support on stm32mp157c
 ed1 board
Thread-Topic: [PATCH v2 1/3] ARM: dts: stm32: add stpmic1 support on
 stm32mp157c ed1 board
Thread-Index: AQHU7rOY2tQ9FLm5QkG9QC4VO8EW1g==
Date:   Tue, 9 Apr 2019 09:07:03 +0000
Message-ID: <1554800820-5412-2-git-send-email-p.paillet@st.com>
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

This patch adds stpmic1 support on stm32mp157c ed1 board.
The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.
The DMAs are disabled because the PMIC generates a very few traffic and
DMA channels may lack for other usage.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 156 ++++++++++++++++++++++++++++++=
----
 1 file changed, 140 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm3=
2mp157c-ed1.dts
index 9fd7943..62a8c78 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -8,6 +8,7 @@
 #include "stm32mp157c.dtsi"
 #include "stm32mp157-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
=20
 / {
 	model =3D "STMicroelectronics STM32MP157C eval daughter";
@@ -42,22 +43,6 @@
 		regulator-always-on;
 	};
=20
-	vdd_sd: regulator-vdd_sd {
-		compatible =3D "regulator-fixed";
-		regulator-name =3D "vdd_sd";
-		regulator-min-microvolt =3D <3300000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-always-on;
-	};
-
-	vdd_usb: vdd-usb {
-		compatible =3D "regulator-fixed";
-		regulator-name =3D "vdd_usb";
-		regulator-min-microvolt =3D <3300000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-always-on;
-	};
-
 	sd_switch: regulator-sd_switch {
 		compatible =3D "regulator-gpio";
 		regulator-name =3D "sd_switch";
@@ -82,6 +67,145 @@
 	i2c-scl-rising-time-ns =3D <185>;
 	i2c-scl-falling-time-ns =3D <20>;
 	status =3D "okay";
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
+			ldo2-supply =3D <&v3v3>;
+			ldo3-supply =3D <&vdd_ddr>;
+			ldo5-supply =3D <&v3v3>;
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
+			vdda: ldo1 {
+				regulator-name =3D "vdda";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <2900000>;
+				interrupts =3D <IT_CURLIM_LDO1 0>;
+			};
+
+			v2v8: ldo2 {
+				regulator-name =3D "v2v8";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
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
+			vdd_sd: ldo5 {
+				regulator-name =3D "vdd_sd";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <2900000>;
+				interrupts =3D <IT_CURLIM_LDO5 0>;
+				regulator-boot-on;
+			};
+
+			v1v8: ldo6 {
+				regulator-name =3D "v1v8";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				interrupts =3D <IT_CURLIM_LDO6 0>;
+			};
+
+			vref_ddr: vref_ddr {
+				regulator-name =3D "vref_ddr";
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			bst_out: boost {
+				regulator-name =3D "bst_out";
+				interrupts =3D <IT_OCP_BOOST 0>;
+			};
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
 };
=20
 &ipcc {
--=20
1.9.1
