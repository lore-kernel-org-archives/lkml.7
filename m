Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836BFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8BB21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ahfinawy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MBidmFaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfKHJ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:29:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38298 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfKHJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C03460F40; Fri,  8 Nov 2019 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205364;
        bh=ysTTdFvEbAolfHrTuxRFcEof4QSbx+c8hmA93aRZu6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahfinawyjbpzm5KVavK8qu5HhhH1fC3kOeGLz3XVukrshW4qCLevtRgcLxZ9jFvzv
         8m0hbC6h7+w05dRURFflzzBabWQ9CP0mH7Dogtb2tZDwCCseyy41gKm4N69uF2JQcr
         bqhdukLYWn3M5UgzuMmSE7AXkVtfj1IiXlLTSOsg=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE02260F6D;
        Fri,  8 Nov 2019 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205363;
        bh=ysTTdFvEbAolfHrTuxRFcEof4QSbx+c8hmA93aRZu6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBidmFaNqwgt9d47rVEVS9HnD2RcIvjglH0BpZVa1atYG5z8dW7QNADF9cZaC4Ngo
         7g8ctk1G+tdqzFQgNUauEBZwpPdmC/gX/q89fMXXEZuAspo/KaW6rbuZPNdsUKvMny
         CS36wJETA8brHOzIuUng6yriXerBnaVMXg6abIkU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE02260F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 10/13] arm64: dts: qcom: pm6150: Add PM6150/PM6150L PMIC peripherals
Date:   Fri,  8 Nov 2019 14:58:21 +0530
Message-Id: <20191108092824.9773-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191108092824.9773-1-rnayak@codeaurora.org>
References: <20191108092824.9773-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Gunda <kgunda@codeaurora.org>

Add PM6150/PM6150L peripherals such as PON, GPIOs, ADC and other
PMIC infra modules.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi    | 72 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm6150l.dtsi   | 31 +++++++++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  2 +
 3 files changed, 105 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm6150.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm6150l.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
new file mode 100644
index 000000000000..1fcbc7a1e062
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2019, The Linux Foundation. All rights reserved.
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/thermal/thermal.h>
+
+&spmi_bus {
+	pm6150_lsid0: pmic@0 {
+		compatible = "qcom,pm6150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm6150_pon: pon@800 {
+			compatible = "qcom,pm8998-pon";
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
+		pm6150_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm6150_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm6150_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@ADC5_DIE_TEMP {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
+		};
+
+		pm6150_gpio: gpios@c000 {
+			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm6150_gpio 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm6150_lsid1: pmic@1 {
+		compatible = "qcom,pm6150", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
new file mode 100644
index 000000000000..f84027b505d1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2019, The Linux Foundation. All rights reserved.
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pm6150l_lsid4: pmic@4 {
+		compatible = "qcom,pm6150l", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm6150l_gpio: gpios@c000 {
+			compatible = "qcom,pm6150l-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm6150l_gpio 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm6150l_lsid5: pmic@5 {
+		compatible = "qcom,pm6150l", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index c637a4a647f8..eb4e7f320a41 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -8,6 +8,8 @@
 /dts-v1/;
 
 #include "sc7180.dtsi"
+#include "pm6150.dtsi"
+#include "pm6150l.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SC7180 IDP";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

