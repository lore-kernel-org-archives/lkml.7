Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52053C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253BD22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOCg3jZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgABOzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:55:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgABOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:55:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so21990763pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKeVu2oWXHPKcwPZ0buj2l0Dr4vKizCXYv05Mdip8Hc=;
        b=aOCg3jZT5CYlpjXjebRIQsZa+VwXZzFX1CHogqR1kDbwM739xnyKPnNsiU0ptp3MHs
         vYNvseYPu6YsagozpbIM+kpO23j4wCrPMT6ASiFLWD+ZaIV5n7iHk/fpS6a0OrPjqDVB
         wLSsrxtnlhLWi2/A8IUrPe8e747GUP8eJM/bQwrN0xzPid2xkGtLIe4SNXhd2UmBeDXb
         rJ1hS2kHlqSKjfitfC0rWgXOX4GVmoT2jexzlI3Hm/HRdJShXdVFreaxXnF1jCjUnBxQ
         eDpled0SOGTiaEhhrhFfcpDsaF0de9fkEsolCKoKzyU4ULTQtRoo1ow8VgIgfk78uBZq
         oWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKeVu2oWXHPKcwPZ0buj2l0Dr4vKizCXYv05Mdip8Hc=;
        b=tY0J6DMcxm0lkB4YEq2PMXMFu+JJY02YGsA3Smn7KHQxQX2PSgn4q1iHT56IBPuWDK
         3gYLXeCs9NllvjzqmxdZlJ0iXcMsgf36Zmf155g+uRxdTgkrbnoKSFzTqktzlfFXZHvh
         LCEiegWtJ9wUi+e3XY5jLv6JEYyD0jWe9wKnH6zWhriDW+P5oCP3npTlaQGmJkt2Pb2K
         fa/3/+Ox7UsWp+g0rTjdcUuceXWlL/hbSjbcdszfd1csn+fDW58FGRNDGurxBJ18eh31
         /Lp/fs0Gxp6gUcyzhUtkgwhkxjeIyDNfPwPSNI/vK0N3UnTXuM++zhsF07233K2DdLtC
         ZVDg==
X-Gm-Message-State: APjAAAVyymu5G6Gold8xfAB5TDpejkdDcPp4w6CTd68wrc5n5Wu1ySGE
        vVkd9EAFHjY/DARBd5o0ZSJPvTf8zmNJUA==
X-Google-Smtp-Source: APXvYqxB4xjsUOgn8YNPlgmgcM4Aw1ezSDGoiNG8NiNNvB6RvRNGaCPhPTEpWobjPT0hyB0c+LByXw==
X-Received: by 2002:a63:111e:: with SMTP id g30mr92154214pgl.251.1577976904992;
        Thu, 02 Jan 2020 06:55:04 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id a28sm63716786pfh.119.2020.01.02.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:55:04 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 7/9] arm64: dts: sdm845: thermal: Add critical interrupt support
Date:   Thu,  2 Jan 2020 20:24:32 +0530
Message-Id: <a86be6121986d1c37b34f791532cd65ec13f1e00.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register critical interrupts for each of the two tsens controllers

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Link: https://lore.kernel.org/r/3686bd40c99692feb955e936b608b080e2cb1826.1568624011.git.amit.kucheria@linaro.org
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936f..8986553cf2eb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2950,8 +2950,9 @@
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <13>;
-			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -2960,8 +2961,9 @@
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.20.1

