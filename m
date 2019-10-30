Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCwevB+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJ3PjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:39:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfJ3PjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:39:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so2594451wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGJ4iUy7kzRHuML9MmU0ln8pdc2taAuOq/9kSKFneEA=;
        b=fCwevB+VkurnCVATJqQYDg571ypYrm5tfC8LTzNVt8K4Rap9YZgMFHMyRcKV4Wvk5B
         sW4i5XwdaCg0JuxCd0wtzVvY/rl0ui7MMWw1p86eopvigSmoiOMZ2v+HRDvZzEo/QnEW
         TI7oLN1ngc81NtWojTxW2pW4wdxySxId+JNilfjeR4oqUCb7Jt41svRT5mOeHkWIWgZE
         nzjGPLfb0gVJReaWN+WknD+KUJ0OetrK/ZqGDwcug/VYhmCYo1lTyM4e6OYlcs1UkNYT
         +Se9MvxzduySUosSf9l/J/25eI3WaOAYIhh5oJ+YT/QKDorwk0TGmq6uFUYIg9tO9oOn
         lVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGJ4iUy7kzRHuML9MmU0ln8pdc2taAuOq/9kSKFneEA=;
        b=Gb2uMTd6cmcWx6a71RUxcmiI4tK3EvLFvv85RYXLkGUXo8rl1Jt5TjH1cvfjdjTpCK
         B70EzrhFYvPHq5dCkRt3ILc4ELeu7/nOECDSHqiJWe/FEB5Pbd+pXKkAytpg7DP9AQws
         /LYuU+8AWBl/qiAHz6p8OL3B2RVFi8FNoNPKog0+JC/eHGH7vE0Bo+VkM1Yqn878qFED
         6YHLpjcIm8Kdnrg6rAMXtzZJLbit6OYstvY9kRygyUgPW+6mFDUGhDJdT/cuNJ0bA6bb
         bbTbLv63PpXuKHSBGbhqkAhi5zW1c+wh48BIM8wdE+SoTDVqt8YjNoTK2v0CGnXSvtUq
         p/kA==
X-Gm-Message-State: APjAAAU9CawNPAs7Ltnac8ox/eNUXRljl/TBZ+Ss+UKHh4dOpg0RuaCk
        IuBlsdbVMtj4/r2e6uwAePX/Dw==
X-Google-Smtp-Source: APXvYqz3Q6drLzEP7gjN8O8ha1iX2qF2icjYdi/IoHDlaqpgwwBgOkavnqDBFUPDp9mrqP9hEeWI+Q==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr93608wmh.102.1572449949424;
        Wed, 30 Oct 2019 08:39:09 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o25sm725524wro.21.2019.10.30.08.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 08:39:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 3/3] arm64: dts: msm8916: Add interconnect provider DT nodes
Date:   Wed, 30 Oct 2019 17:39:04 +0200
Message-Id: <20191030153904.8715-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030153904.8715-1-georgi.djakov@linaro.org>
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the network-on-chip interconnect buses present on
MSM8916-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..9c4d89319e7c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,msm8916.h>
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -364,11 +365,38 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		bimc: interconnect@400000 {
+			compatible = "qcom,msm8916-bimc";
+			reg = <0x00400000 0x62000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		restart@4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0x4ab000 0x4>;
 		};
 
+		pcnoc: interconnect@500000 {
+			compatible = "qcom,msm8916-pcnoc";
+			reg = <0x00500000 0x11000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			compatible = "qcom,msm8916-snoc";
+			reg = <0x00580000 0x14000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		msmgpio: pinctrl@1000000 {
 			compatible = "qcom,msm8916-pinctrl";
 			reg = <0x1000000 0x300000>;
