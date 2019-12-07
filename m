Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36432C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40EC24679
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdvmcV7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLGUWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:22:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfLGUWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 15:22:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so4147300plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIGNb9tUxYsrgWzIrvsSPWd3nGUTvWJqMa0r5ty9ysg=;
        b=FdvmcV7WJobL2lkk2TWCaEVCjYC7FRBoiSyYHSil2DoAUPxU8BWRJGIAQ/11IfR1hu
         4vbL5lS4SE0hcSGsvFiOWsTuf83nq9fr5NAuNuL5KXHf3FBADZTqeJ/FzTYH4tOFslm4
         Gy8JBaQJUnF2Slko5sJ67AtjqAEBiXuQiqg5lbXiAgMKbSy4QhNmDo11mRlAXZjPNFFW
         5OeNEHnR8/vAaZm+q5jVKGEVx+QkQWTRLISXVZnpSXI4oMWCdLnRtt86m1ZDeliH3WUM
         UwMS1doZ+lJ7pj2pP65P5tsPO4GKvXy8qqiQHH52UBV94XmVrlnoaFwYaHYMaZoEFeFM
         MYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIGNb9tUxYsrgWzIrvsSPWd3nGUTvWJqMa0r5ty9ysg=;
        b=DSgP5UbkznFIslPWHH3ALFfSiX7HkkRz2eJQVrYdFgYGBkAvDRs7VpO5PYSJuHfs0k
         /5AL5iSl1suSu1wSkgAkKIpKS2c5ygmt23HRYUfFfiN7CXsvD3pCr5ckHlhFkF++YNDK
         q3nradol0vi/5AvA58Hum5YbLAyFg9kMN8UN2awwhVO2VcjnUm/O+F87b39TpJULTI6y
         ReQrIn+rUn0JcgbcHuf9EIwpG9bKXPNbK+qLJEK7FVfnAhyjo4rmMoF4NCv0OInx6ljI
         JwlZBkPXKFpL5XxzO2O2uqsYcW5tXWv3OaleR6PrGPvBBge4zlW6RMc+JRL9wrFBwkZF
         yUkA==
X-Gm-Message-State: APjAAAUs+z0Hxys48wipWHMiO9l9HmMPVLIEGufCtW1yjUF3okP0Edg4
        FWqEBLs3SK84jkkqpZm1INxGwA==
X-Google-Smtp-Source: APXvYqzu7qBalmvtd2P3hBAnyhZsB4Y+b0o8j2oLQTJqENk9g9Nhnus49NLQ8srgkx9JPDJgvPjiRw==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr23574216pjh.101.1575750136274;
        Sat, 07 Dec 2019 12:22:16 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm21969662pfg.34.2019.12.07.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 12:22:15 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vinod.koul@linaro.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8996: Use generic QMP driver for UFS
Date:   Sat,  7 Dec 2019 12:21:47 -0800
Message-Id: <20191207202147.2314248-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191207202147.2314248-1-bjorn.andersson@linaro.org>
References: <20191207202147.2314248-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With support for the MSM8996 UFS PHY added to the common QMP driver,
migrate the DTS to use the common QMP binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 33 +++++++++++++++------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c9c6efbbcc01..d0f2544ccf5b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1323,27 +1323,30 @@ spmi_bus: qcom,spmi@400f000 {
 			#interrupt-cells = <4>;
 		};
 
-		ufsphy: phy@627000 {
-			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
-			reg = <0x627000 0xda8>;
-			reg-names = "phy_mem";
-			#phy-cells = <0>;
+		ufs_phy: phy@627000 {
+			compatible = "qcom,msm8996-qmp-ufs-phy";
+			reg = <0x00627000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
 			vdda-phy-supply = <&pm8994_l28>;
 			vdda-pll-supply = <&pm8994_l12>;
-
-			vdda-phy-max-microamp = <18380>;
-			vdda-pll-max-microamp = <9440>;
-
 			vddp-ref-clk-supply = <&pm8994_l25>;
-			vddp-ref-clk-max-microamp = <100>;
-			vddp-ref-clk-always-on;
 
-			clock-names = "ref_clk_src", "ref_clk";
-			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
-				 <&gcc GCC_UFS_CLKREF_CLK>;
+			clocks = <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref";
+
 			resets = <&ufshc 0>;
+			reset-names = "ufsphy";
 			status = "disabled";
+
+			ufs_phy_lane: lanes@627400 {
+				reg = <0x627400 0x12c>,
+				      <0x627600 0x200>,
+				      <0x627c00 0x1b4>;
+				#phy-cells = <0>;
+			};
 		};
 
 		ufshc: ufshc@624000 {
@@ -1351,7 +1354,7 @@ ufshc: ufshc@624000 {
 			reg = <0x624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
-			phys = <&ufsphy>;
+			phys = <&ufs_phy_lane>;
 			phy-names = "ufsphy";
 
 			vcc-supply = <&pm8994_l20>;
-- 
2.24.0

