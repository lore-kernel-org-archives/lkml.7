Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AEFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341420830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOAkHkd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJUFNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:13:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33013 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJUFNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:13:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so6041383pls.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TA6r0HFsjABGnmZJC70YO+O9cOHq3VBrd6ui/ESIs1g=;
        b=xOAkHkd95lSx28nu/OAXvlxSwb+WoaMnxOtY7G8S1YiSuJjY20uhlUuOwdfsr8PX3y
         ceTeYXNsl/q0Dd4cyXEjg3w4li8o74smzKeGTxygd0iSNOaCWtz6tDy27j+vGp9rlyjE
         0URMs+vXwOXqZqTU6d1PT6x17LBzexo0FvN91jPUZgKRzVve75jNMSVL2IUvJVKgwjpE
         mBHuWb2IFmEat4jYnVp7ZnTm8zXn5S1lmbVB/JWTNsD3pUX9CCkLLDh1Wx2Obi+NtKLl
         IIo+6441O/+L7Iq9RLp/qDlV6N9pDbVIok/z8TkA6Z9ZnF3ISf6LnuX0Ee722JEIBqIj
         DkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TA6r0HFsjABGnmZJC70YO+O9cOHq3VBrd6ui/ESIs1g=;
        b=e3Z2RzbryEEjNIC2NyKVCvMQhHzc8jPxf2R/TJBVSKnaifqVegqYIPiVq0zShtTZ6V
         4B+zO3oTcSaBOEctbzeGJaXuBW9dIonMANEVwYj24gnV/XOWGoyFq3GPx9entqTlnWn/
         Vv4rtNCO+Bhm0KgkTyILkEzCv459g90zwF9mMgGXWrO4KixTQMTbTVnFK0Hf2mT1MpA7
         Fguxqr69M76wnl/yAau5OxHjMW4Bres9HlP0NBZN7dPqTHPnFdAZ3WQM1s++/SBhGmTE
         mLS5jrApz5oBWIRTB98zGxuEKpVFa2tyLJrTTi0poJDzX7NJ06gRqlUAR5oOtDNoJo8y
         nakw==
X-Gm-Message-State: APjAAAXXsGI7SXioEGVHzLevOeiqdXQdhp9MPazwcUelk8sCM4cInrU9
        vQh9qu1VRLA4/M1O9N/xrt9zzw==
X-Google-Smtp-Source: APXvYqykYjJ3Rx3SnCUMFZkEgAjHWfp9iI8//IackT+XeMslToB7dFZBBXFrGXF22N/veTvJRc/Azg==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr13604930plr.108.1571634820676;
        Sun, 20 Oct 2019 22:13:40 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h68sm15716862pfb.149.2019.10.20.22.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:13:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: qcom: msm8996: Introduce IFC6640
Date:   Sun, 20 Oct 2019 22:13:22 -0700
Message-Id: <20191021051322.297560-12-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021051322.297560-1-bjorn.andersson@linaro.org>
References: <20191021051322.297560-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a base dts for the Inforce 6640 Single Board Computer. This
initial commit boots to console on the uart and provides UFS and SD card
storage support.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts | 412 +++++++++++++++++++
 2 files changed, 413 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6498a1ec893f..b7e33b415e2a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
+dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
new file mode 100644
index 000000000000..ef8f8ccf837c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "msm8996.dtsi"
+#include "pm8994.dtsi"
+#include "pmi8994.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "Inforce 6640 Single Board Computer";
+	compatible = "inforce,ifc6640", "qcom,apq8096-sbc", "qcom,apq8096";
+
+	qcom,msm-id = <291 0x00030001>;
+	qcom,board-id = <0x00010018 0>;
+
+	aliases {
+		serial0 = &blsp2_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	v1p05: v1p05-regulator {
+		compatible = "regulator-fixed";
+		reglator-name = "v1p05";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+
+		vin-supply = <&v5p0>;
+	};
+
+	v12_poe: v12-poe-regulator {
+		compatible = "regulator-fixed";
+		reglator-name = "v12_poe";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	v3p3: v3p3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "v3p3";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&v12_poe>;
+	};
+
+	v5p0: v5p0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "v5p0";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		vin-supply = <&v12_poe>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+	};
+};
+
+&blsp2_uart1 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart1_2pins_default>;
+	pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
+};
+
+&msmgpio {
+	sdc2_pins_default: sdc2-pins-default {
+		clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		cd {
+			pins = "gpio38";
+			function = "gpio";
+
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+
+	sdc2_pins_sleep: sdc2-pins-sleep {
+		clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		cd {
+			pins = "gpio38";
+			function = "gpio";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
+};
+
+&rpm_requests {
+	pm8994-regulators {
+		compatible = "qcom,rpm-pm8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_l1-supply = <&vreg_s1b_1p025>;
+		vdd_l2_l26_l28-supply = <&vreg_s3a_1p3>;
+		vdd_l3_l11-supply = <&vreg_s3a_1p3>;
+		vdd_l4_l27_l31-supply = <&vreg_s3a_1p3>;
+		vdd_l5_l7-supply = <&vreg_s5a_2p15>;
+		vdd_l6_l12_l32-supply = <&vreg_s5a_2p15>;
+		vdd_l8_l16_l30-supply = <&vph_pwr>;
+		vdd_l9_l10_l18_l22-supply = <&vph_pwr_bbyp>;
+		vdd_l13_l19_l23_l24-supply = <&vph_pwr_bbyp>;
+		vdd_l14_l15-supply = <&vph_pwr_bbyp>;
+		vdd_l17_l29-supply = <&vph_pwr_bbyp>;
+		vdd_l20_l21-supply = <&vph_pwr_bbyp>;
+		vdd_l25-supply = <&vreg_s3a_1p3>;
+		vdd_lvs1_2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p3: s3 {
+			regulator-name = "vreg_s3a_1p3";
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		vreg_s4a_1p8: s4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+		vreg_s5a_2p15: s5 {
+			regulator-name = "vreg_s5a_2p15";
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+		};
+		vreg_s7a_1p0: s7 {
+			regulator-name = "vreg_s7a_1p0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		vreg_l1a_1p0: l1 {
+			regulator-name = "vreg_l1a_1p0";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l2a_1p25: l2 {
+			regulator-name = "vreg_l2a_1p25";
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1250000>;
+		};
+		vreg_l3a_0p875: l3 {
+			regulator-name = "vreg_l3a_0p875";
+			regulator-min-microvolt = <850000>;
+			regulator-max-microvolt = <850000>;
+		};
+		vreg_l4a_1p225: l4 {
+			regulator-name = "vreg_l4a_1p225";
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		vreg_l6a_1p2: l6 {
+			regulator-name = "vreg_l6a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vreg_l8a_1p8: l8 {
+			regulator-name = "vreg_l8a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l9a_1p8: l9 {
+			regulator-name = "vreg_l9a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l10a_1p8: l10 {
+			regulator-name = "vreg_l10a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l11a_1p15: l11 {
+			regulator-name = "vreg_l11a_1p15";
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+		vreg_l12a_1p8: l12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l13a_2p95: l13 {
+			regulator-name = "vreg_l13a_2p95";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		vreg_l14a_1p8: l14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l15a_1p8: l15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l16a_2p7: l16 {
+			regulator-name = "vreg_l16a_2p7";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+		vreg_l17a_2p8: l17 {
+			regulator-name = "vreg_l17a_2p8";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+		vreg_l18a_2p85: l18 {
+			regulator-name = "vreg_l18a_2p85";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2900000>;
+		};
+		vreg_l19a_2p8: l19 {
+			regulator-name = "vreg_l19a_2p8";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		vreg_l20a_2p95: l20 {
+			regulator-name = "vreg_l20a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+		vreg_l21a_2p95: l21 {
+			regulator-name = "vreg_l21a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		vreg_l22a_3p0: l22 {
+			regulator-name = "vreg_l22a_3p0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		vreg_l23a_2p8: l23 {
+			regulator-name = "vreg_l23a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l24a_3p075: l24 {
+			regulator-name = "vreg_l24a_3p075";
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+		vreg_l25a_1p2: l25 {
+			regulator-name = "vreg_l25a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+		vreg_l26a_0p8: l27 {
+			regulator-name = "vreg_l26a_0p8";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l28a_0p925: l28 {
+			regulator-name = "vreg_l28a_0p925";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+		vreg_l29a_2p8: l29 {
+			regulator-name = "vreg_l29a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l30a_1p8: l30 {
+			regulator-name = "vreg_l30a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l32a_1p8: l32 {
+			regulator-name = "vreg_l32a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-name = "vreg_lvs1a_1p8";
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-name = "vreg_lvs2a_1p8";
+		};
+	};
+
+	pmi8994-regulators {
+		compatible = "qcom,rpm-pmi8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_bst_byp-supply = <&vph_pwr>;
+
+		vreg_s1b_1p025: s1 {
+			regulator-name = "vreg_s1b_1p025";
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
+		};
+
+		vph_pwr_bbyp: bst-byp {
+			regulator-name = "vph_pwr_bbyp";
+			regulator-min-microvolt = <3150000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&sdhc2 {
+	status = "okay";
+
+	bus-width = <4>;
+
+	cd-gpios = <&msmgpio 38 0x1>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_pins_default>;
+	pinctrl-1 = <&sdc2_pins_sleep>;
+};
+
+&ufshc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l25a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+
+	vcc-max-microamp = <600000>;
+	vccq-max-microamp = <450000>;
+	vccq2-max-microamp = <450000>;
+};
+
+&ufsphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+
+	vdda-phy-max-microamp = <18380>;
+	vdda-pll-max-microamp = <9440>;
+};
-- 
2.23.0

