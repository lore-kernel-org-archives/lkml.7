Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C13521855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkgWa3lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfDEDzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:55:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46607 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfDEDzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:55:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so3940942ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/1mlm+04wVwhtMiLlTVCrPwXOYS7toZlKWNXa22sNE=;
        b=EkgWa3lLKtEbOWlu8Y6elZvv7Rih+xNWefGGDTvXZv24SRVRyvlst4xZHCm/hKMYG5
         KZfHjRfGbdkNd8kf14OQr8LP6YPhUjHvF5Ld34ZE9fgD7wadH35eFCoVaqL4AXoPKgfX
         UEcFfQE/TpJGtLzx2/xYR16QzTWEUbLPW+J/DsLJIxpJyC8Ap2sBUFLt+9z1HktZg3EJ
         mQPRywevhOVE12HTkFCFHNuuLNV6y5h85KO0wE8Fgiw0ec43kpT/F59BhIfPM1XU7Q9R
         W9bzttvLLe8QtlqRQN+WjEexzToeD36TPx4EHNoswOc7XXh3TCnqBj0wN5qUoq4uNbm+
         0WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/1mlm+04wVwhtMiLlTVCrPwXOYS7toZlKWNXa22sNE=;
        b=LHq7Fw6grVubcCxjmSME3URPDK3irN44jrXGoc1i65LxqUFTXFvD+fhcWYrN1rHCF6
         wMahl3o2c2vljIGsXQdpQnNlJgF6Kd5bvgToVTZt3NtY3Kr6WziwR3I3iunFAj0e57/T
         RSWmmNr2ZBdtgRI0AzqNjNPLTrL+6m2RoYf7AYvqG3FT3Hj1+uYzt2ZujId1Js32qULD
         wLETjliBQhuFBMKJG0I5r/rCTVKC28cQiXLQpfo/jIj1IlXdnV68WTA7Cz2ed2QI0RWP
         wHHFbc1miGz22iMBVpM9RX1wirn5bj0p2ont+Zjk84xUPg9HLlcn9A9Jfyjg3wE21cDN
         arow==
X-Gm-Message-State: APjAAAX6uj5H+DVRZ1Adq33QdBg1Rxmh650DmCO/TeszWMoB3TIJ3Q1N
        QiOKNAqobNLXb8vE0L7aiWW+zw==
X-Google-Smtp-Source: APXvYqyz2iDP84+5SX7Wz+x4EG741CH0A9mmrzuRJSauAZgDQHwYXPQfQd1NKxQPFC74FTUDY2/29Q==
X-Received: by 2002:a2e:711a:: with SMTP id m26mr5522243ljc.40.1554436516470;
        Thu, 04 Apr 2019 20:55:16 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i24sm4417633ljb.31.2019.04.04.20.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 20:55:15 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Fri,  5 Apr 2019 10:54:46 +0700
Message-Id: <20190405035446.31886-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405035446.31886-1-georgi.djakov@linaro.org>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e8fd26633d57..706e918f79f6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -226,6 +227,30 @@
 			compatible = "qcom,rpm-qcs404";
 			qcom,glink-channels = "rpm_requests";
 
+			bimc: interconnect@0 {
+				compatible = "qcom,qcs404-bimc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+					<&rpmcc RPM_SMD_BIMC_A_CLK>;
+			};
+
+			pcnoc: interconnect@1 {
+				compatible = "qcom,qcs404-pcnoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+					<&rpmcc RPM_SMD_PNOC_A_CLK>;
+			};
+
+			snoc: interconnect@2 {
+				compatible = "qcom,qcs404-snoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+					<&rpmcc RPM_SMD_SNOC_A_CLK>;
+			};
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-qcs404";
 				#clock-cells = <1>;
