Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD5C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6369D207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHHADuwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgAFPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:50:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38861 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgAFPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:50:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so29429492ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sRlbBOojW7v2VRLaDWPeR8d17hgWrl9wNZOspFmUuFU=;
        b=VHHADuwxDXdHKVvS4EfoZEB51p5On/YbIIYEECjNzYkMkFyB2yrzudKHOeHa6JehJN
         tpLSmcXb9pfEWEBUZrSyzAmDiNtA9+Q51Dmy+LxJbHi9ISwZmp86WW7fI2VHX6WIliOn
         3qXQDGYV9ndcEkD90lma1CRwwyLow3WLwHv0x+rUCj3ERtbuoYAkVdgvxw9GuLnb1YQV
         5yWmmElSoW9GsHbZ747RumV3vQ7Jo+Pu6Lw2m9n94UehNyLcIhS71oKsDUUczwSVuR+L
         XYzTz9uTxIkGyMNTf5lTfxV0uENJvyZvw3Bb06Ff74d/z4B1zjBmZioDsUs0XRFN+iU+
         Q5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sRlbBOojW7v2VRLaDWPeR8d17hgWrl9wNZOspFmUuFU=;
        b=NgR4q8BA91VGjgoxzpzVgtRxT71a2GgLyV0guZ9QpjJrBbcAUf3MpkdxZRZKlJcASi
         6GvetYXyH6bFRzdo+pil+E+QBSTQupPyTq6tQHkVN0bJ4gTumCUFL+q9IUDm84HHUpTp
         bPsugzE0HncaxAvIIIo0l3p0+BV5xQvupymkR/q+ffV8XTwhqCJ22IcrNiVONl0itkJs
         R3MC1XHGbDaIk1LZPUzjiks6DaOHTVHJ2W9xg4b7Op7eFBQYuRJrXpvMySgvdh6BDEDj
         cJBKvMAuH1+Xx8bRMm4WR7PKuQN1kShbM2qPd5qZ2TLIm4Hh6J8F/AP5vGkJGZpfBMuE
         CxpA==
X-Gm-Message-State: APjAAAU+gBurN9j2sBEmkf7DPCPClq+ldVOxU60uy0rrIDI08zOCVqHr
        ZmVVdSjLKj+qJnd/81zI4z6gHveSky8=
X-Google-Smtp-Source: APXvYqweqRbcLjpZBO9R386SyjrSeygZaSYvJ9s4WcSo3dElLqK3KTp6bnjDWO1h+k6ORG7J1vuPrg==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr52679075ljg.73.1578325824387;
        Mon, 06 Jan 2020 07:50:24 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id x84sm29388259lfa.97.2020.01.06.07.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:50:23 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 11/12] arm64: dts: sdm845: follow venus-sdm845v2 DT binding
Date:   Mon,  6 Jan 2020 17:49:28 +0200
Message-Id: <20200106154929.4331-12-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all pmdomain and clock resources to Venus DT node. And make
possible to support dynamic core assignment on v4.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936f..c5784951d408 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2568,32 +2568,33 @@
 		};
 
 		video-codec@aa00000 {
-			compatible = "qcom,sdm845-venus";
+			compatible = "qcom,sdm845-venus-v2";
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&videocc VENUS_GDSC>;
+			power-domains = <&videocc VENUS_GDSC>,
+					<&videocc VCODEC0_GDSC>,
+					<&videocc VCODEC1_GDSC>;
+			power-domain-names = "venus", "vcodec0", "vcodec1";
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
 				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
-			clock-names = "core", "iface", "bus";
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+			clock-names = "core", "iface", "bus",
+				      "vcodec0_core", "vcodec0_bus",
+				      "vcodec1_core", "vcodec1_bus";
 			iommus = <&apps_smmu 0x10a0 0x8>,
 				 <&apps_smmu 0x10b0 0x0>;
 			memory-region = <&venus_mem>;
 
 			video-core0 {
 				compatible = "venus-decoder";
-				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
-				clock-names = "core", "bus";
-				power-domains = <&videocc VCODEC0_GDSC>;
 			};
 
 			video-core1 {
 				compatible = "venus-encoder";
-				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
-					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
-				clock-names = "core", "bus";
-				power-domains = <&videocc VCODEC1_GDSC>;
 			};
 		};
 
-- 
2.17.1

