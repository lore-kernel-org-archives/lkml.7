Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC6C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9772F2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I97wPUn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLCFYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:24:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39448 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfLCFYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:24:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id v93so1028029pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=z0wd2bkKduQ+i5fk/EQsJPpFHH3ALeC9IpHFk2IOC4U=;
        b=I97wPUn5AdpqoulNYp4MLektHFnqlZpzv1q6Tple/h1X9kp4o6h9qh1FQIG/VBV0BE
         Tvl3InjLcCwxYV7b+gpFhrSZQdo0MlgijP574fZFNyHv6Nz76r7nqs/B7m+kT5wAM7m1
         vwG5QeygVMxOqAy1yRrhuGSM/gRdLCVnt/Vqc5NhiccxGRfpys1DnV++S2frxyKP34xm
         /qkuWYgBjLO0Nm+YfuTbVGqorGkiaZQr9GbAsLODRkJsoA5Hi/MTxbHgNL3WCSfUvLkb
         lNH6nfwLml4FcQOwJm3vh2wmEvVpb/D3CE+rxzG5MJfi44HPyFH1Lf4jkDN5hwoPmlRX
         9Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=z0wd2bkKduQ+i5fk/EQsJPpFHH3ALeC9IpHFk2IOC4U=;
        b=rA5eHp4Fqk3A7AQIp2w1DUNEPo9RD4EMEbmyWgQgfb9SQkfcrtzxVjnXTl+BAuk7fA
         sB2Oefujy/gLagKvTKIrgJI8mtXbUUw8fWoUfjzvO9ZglvRPXgomDIqQJC1djA4VTeh5
         NQDaGaTcfS+XlpTjhnQmZJ77m3aDtBSKTfxgzjqRomVm73+YqJiw8FyJjgnXZlR+Dz7w
         FiLjLr9e/tTFPAeHVCbIlRLBaAAr8nqJkUIy+vN8Kauyu8I/njYWkRIa3ohEVNuRTOZ5
         B9HrXc6aocYxgcAdHVODTeUsy/hK3uYnR/Tyb51hEUG+gwUnU/fYlaOSvv+DeIG+YSCl
         PcTw==
X-Gm-Message-State: APjAAAVPvK5PLDI80+ctNmHMwJkAGGyw/2pDvPRCEjCXlY0lsQHvL+Ts
        CxriumGu45ySheJpNXKXHrLrlypwdDyLZA==
X-Google-Smtp-Source: APXvYqz+n883h7TApBIYHyvjaAf7Zr+4v90MCkLzZ/Urywenueq6LOa0pUx8KSfoS0Bqxxy1cArcbQ==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr3255707plr.28.1575350647017;
        Mon, 02 Dec 2019 21:24:07 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id u26sm1419005pfn.46.2019.12.02.21.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:24:06 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 8/9] arm64: dts: msm8996: thermal: Add critical interrupt support
Date:   Tue,  3 Dec 2019 10:53:29 +0530
Message-Id: <53d8f7b922ec889ed11380896c2a367ae0998db2.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register critical interrupts for each of the two tsens controllers

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4ca2e7b44559c..fec0e50fe4fa3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -591,8 +591,9 @@
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
-			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -601,8 +602,9 @@
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

