Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72043C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADDF22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD1mSnBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfGYMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:40:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40109 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbfGYMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:40:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so44639018wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gCwqBNqiH6Cazjbw2rLinwK1/I01nMLWsu9gwurgxHI=;
        b=bD1mSnBXEW7qLuMEwtw52MukOBD8WVorM6KS53hbiejSUrciirPICdcv6qeuylS3xh
         akC7ZG8s+RL1zqMGkDkyxq7l1xflqBPwxvu5sNQMNz92sMK2Tyochn8fzbe4NpQfY0sE
         kXXwk6iu1XFwq3/BaVEseL4yLX/ZYsgmqKz6rPtB/P45Gv4z//UZFjUaA6rYJSeH1SWT
         CqVL7RdiSsgsmnvvHZ9JyS1ypW/2iNbPkYve+5KZrSDCwuRoyK5nzE8/1F7mOGHKo9Yd
         CQPPdqpR95J4XYppTdQp+nO+m7W1+DtaxraDM+IOfmaEN+uRwuPGbLg4rYuJLLK0Ci4u
         IZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gCwqBNqiH6Cazjbw2rLinwK1/I01nMLWsu9gwurgxHI=;
        b=pYQmvexozUWqau/ozSqVIxnw1a1D2KsX9tssYsTcn1mUfIzHYoXQ9U9RoON8i1HdCP
         06K+AoETgtEFxmnVwTwppbw/6G6YlTXbbUDKKJ3Skt+3RAj3Bz3gYO/ZhPnuRKF2fK3P
         RhMbsrdRetAEuqakejkaiSCEBgAOgEA5/90bbMztFbcV8u9hRwil8hix69LdWGcIgwtX
         fcdGv7a0zD0Do1OOxJEUkX3ojIpcS6WQJLJd/GkBC9UaiAXbU69+dBmlxqmWhDmtxoj4
         onX2BF+7AdS+MYlUumjK3m6P/z0eyWtGl7eEFbm92NLpIaCAfRdqx4dcuatgZyBKYXi/
         6/Fw==
X-Gm-Message-State: APjAAAW9kEgS9u8IsLEUEpCGW0McgJabq8fPkATZSaziDYZ65QEFDvgM
        81LR2gHdaYV+YZ+ILUtDAAP7oQ==
X-Google-Smtp-Source: APXvYqwiaaONoJ1bhDvxILB7j4yN0qCUfeyGhpyyuPT6/Uwbtwrc8H53YL2Zn4cnrRfO8IpiwM7Ohg==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr29120617wmj.39.1564058435359;
        Thu, 25 Jul 2019 05:40:35 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id c4sm39260225wrt.86.2019.07.25.05.40.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:40:34 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] arm64: dts: qcom: msm8996: Add Venus video codec DT node
Date:   Thu, 25 Jul 2019 15:39:49 +0300
Message-Id: <20190725123949.31763-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Qualcomm Venus video codec DT node for the video
codec hardware found in MSM8996 platforms.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 942465d8aeb7..ac6e4e430eec 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1777,6 +1777,74 @@
 					      "ref_clk";
 			};
 		};
+
+		venus_smmu: arm,smmu-venus@d40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xd40000 0x20000>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
+			clocks = <&mmcc SMMU_VIDEO_AHB_CLK>,
+				 <&mmcc SMMU_VIDEO_AXI_CLK>;
+			clock-names = "iface", "bus";
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
+		video-codec@c00000 {
+			compatible = "qcom,msm8996-venus";
+			reg = <0x00c00000 0xff000>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc VENUS_GDSC>;
+			clocks = <&mmcc VIDEO_CORE_CLK>,
+				 <&mmcc VIDEO_AHB_CLK>,
+				 <&mmcc VIDEO_AXI_CLK>,
+				 <&mmcc VIDEO_MAXI_CLK>;
+			clock-names = "core", "iface", "bus", "mbus";
+			iommus = <&venus_smmu 0x00>,
+				 <&venus_smmu 0x01>,
+				 <&venus_smmu 0x0a>,
+				 <&venus_smmu 0x07>,
+				 <&venus_smmu 0x0e>,
+				 <&venus_smmu 0x0f>,
+				 <&venus_smmu 0x08>,
+				 <&venus_smmu 0x09>,
+				 <&venus_smmu 0x0b>,
+				 <&venus_smmu 0x0c>,
+				 <&venus_smmu 0x0d>,
+				 <&venus_smmu 0x10>,
+				 <&venus_smmu 0x11>,
+				 <&venus_smmu 0x21>,
+				 <&venus_smmu 0x28>,
+				 <&venus_smmu 0x29>,
+				 <&venus_smmu 0x2b>,
+				 <&venus_smmu 0x2c>,
+				 <&venus_smmu 0x2d>,
+				 <&venus_smmu 0x31>;
+			memory-region = <&venus_region>;
+			status = "okay";
+
+			video-decoder {
+				compatible = "venus-decoder";
+				clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE0_GDSC>;
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+				clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE1_GDSC>;
+			};
+		};
 	};
 
 	sound: sound {
-- 
2.17.1

