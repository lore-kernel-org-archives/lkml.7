Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3BBC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91B72173E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXue9bSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfLMBIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:08:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38268 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfLMBIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:08:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so443207pjt.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 17:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkgyMWnJPA7zPuIRZMDlek4Ocs5Jn4Aj6e2Q5KIp8ZQ=;
        b=XXue9bSsn/QGwPyZsS9Yw5oDsyV6R7ISqQjzNtilrdV0LqHP7ydlrwoNZ0Fe1Z58oY
         5jqZZ/k9DgwzVES0emuhCdP43nT5SFJPwlfZWNmu9xvxF/F1I2p5/k8iMvZRG5uLeOHy
         1Tyw4wHmYFJ4ycLlJGE2SmTSuQLsGmg8VoA1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkgyMWnJPA7zPuIRZMDlek4Ocs5Jn4Aj6e2Q5KIp8ZQ=;
        b=B3acte0aoCeXIijJ+q3PEJ8WYMArnQbOwu0p2GuyX7oGtvfLcJb7op06eEzorX2wzl
         4XeZ5Bk44js6q56Sa4FOn6fqVWifwW143/eApAX1igra/nDVXclLQQ13G3vgafuhOd8u
         enZm2Uh5E/Ad/4PFrSUub1gh2Niz7LYIhRaA/o9NlQikzrUIh9fchAyUUvu2Ix0FKWzc
         C7HHzmS6u03GSQEftPVN3CrfDHmI6gpRZbK4DXFe6Jb21FplHlvgbW+3VVwH5B633mMA
         gpoY6pFKb6gUdSilZ7qEfViWNzjnte0Lcpt6Pz5PpHNn0k1Dn4kxxvDaeUmxV6PC+ac/
         HOYg==
X-Gm-Message-State: APjAAAW4bcFD228+EmK8kKdtbYUq1VeFzFnw+XyvwBEbWzI+WtRdHN6+
        J5yGEYXvHCABk2tpx0lmMBOzlQ==
X-Google-Smtp-Source: APXvYqzxQMXTCdlwRfSZ1o1MO2oKXU5lgxZGM559VlbYDbYkUzeHc6zmlxEHFO1YwaaLKV2mD+KtHA==
X-Received: by 2002:a17:90a:fa13:: with SMTP id cm19mr12755762pjb.141.1576199320402;
        Thu, 12 Dec 2019 17:08:40 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b22sm8652452pfd.63.2019.12.12.17.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 17:08:39 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajeshwari <rkambl@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7180: Fix node order
Date:   Thu, 12 Dec 2019 17:08:36 -0800
Message-Id: <20191212170824.v2.1.I55198466344789267ed1eb5ec555fd890c9fc6e1@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC7180 device tree nodes should be ordered by address. Re-shuffle
some nodes which currently don't follow this convention.

Since we are already moving it add a missing leading zero to the
address in the 'reg' property of the 'interrupt-controller@b220000'
node.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- updated commit message
- added Doug's 'Reviewed-by' tag
- added leading zero to address of 'interrupt-controller@b220000'

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 74 ++++++++++++++--------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 52a58615ec06d..6876aae2e46b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -642,16 +642,6 @@ uart11: serial@a94000 {
 			};
 		};
 
-		pdc: interrupt-controller@b220000 {
-			compatible = "qcom,sc7180-pdc", "qcom,pdc";
-			reg = <0 0xb220000 0 0x30000>;
-			qcom,pdc-ranges = <0 480 15>, <17 497 98>,
-					  <119 634 4>, <124 639 1>;
-			#interrupt-cells = <2>;
-			interrupt-parent = <&intc>;
-			interrupt-controller;
-		};
-
 		tlmm: pinctrl@3500000 {
 			compatible = "qcom,sc7180-pinctrl";
 			reg = <0 0x03500000 0 0x300000>,
@@ -952,33 +942,6 @@ qspi: spi@88dc000 {
 			status = "disabled";
 		};
 
-		system-cache-controller@9200000 {
-			compatible = "qcom,sc7180-llcc";
-			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
-			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		tsens0: thermal-sensor@c263000 {
-			compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
-			reg = <0 0x0c263000 0 0x1ff>, /* TM */
-				<0 0x0c222000 0 0x1ff>; /* SROT */
-			#qcom,sensors = <15>;
-			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
-			#thermal-sensor-cells = <1>;
-		};
-
-		tsens1: thermal-sensor@c265000 {
-			compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
-			reg = <0 0x0c265000 0 0x1ff>, /* TM */
-				<0 0x0c223000 0 0x1ff>; /* SROT */
-			#qcom,sensors = <10>;
-			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
-			#thermal-sensor-cells = <1>;
-		};
-
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sc7180-qusb2-phy";
 			reg = <0 0x088e3000 0 0x400>;
@@ -1028,6 +991,13 @@ usb_1_ssphy: phy@88e9200 {
 			};
 		};
 
+		system-cache-controller@9200000 {
+			compatible = "qcom,sc7180-llcc";
+			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
+			reg-names = "llcc_base", "llcc_broadcast_base";
+			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sc7180-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -1072,6 +1042,36 @@ usb_1_dwc3: dwc3@a600000 {
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sc7180-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 15>, <17 497 98>,
+					  <119 634 4>, <124 639 1>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
+			reg = <0 0x0c263000 0 0x1ff>, /* TM */
+				<0 0x0c222000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <15>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
+			reg = <0 0x0c265000 0 0x1ff>, /* TM */
+				<0 0x0c223000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.24.1.735.g03f4e72817-goog

