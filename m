Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5347FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AA92083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpLpTz9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfB1M2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:28:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbfB1M17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so21720578wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n8wsQ7ixOIiYIm36smSOqEN/oeuVV2Uzvv7QGvE7MK8=;
        b=zpLpTz9EuHe3H8J6BSqrYGGXTQ59pWPo9uc0KOL3uym5G7IC5wsSariHgQn36HPBDw
         irV3C4yxFv0bUCagssXQLQIy0m2YSNPGTKxqKZySv5s3rd7ZdtS4pzgtrHTJ+jxnD4yA
         w0ahKEvSrkGcZWoX6fHpBT7VWPsPHAk04Flh0/4S3VZ08V7gxqAIwKvgongvnVVqg455
         sDkKAmvN8kx1fH0/FdjaGEmzORdawyBNWI8bN3GKozOgEGnVFyclIj82+Dxl8o6heTxG
         76fmwzxKpOntZM+ED9U0tznDVrlNkQ9bskfhpWts3HtPkgEX2RlAflM8HcKTGUIGniTP
         /M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n8wsQ7ixOIiYIm36smSOqEN/oeuVV2Uzvv7QGvE7MK8=;
        b=MCJEcWVDB83NUsPbvFGEUjNJ1bF8P6e26pheq/I1FZaKLOjkitAomUFIdfyFIzrhJ+
         lAnobO1Fwk2Kg8nIeEoHORNuXaYNumdXOBIYxcO8/PsKhAmnOFYrJusketvhz0/iE+72
         7HgA65I8VHncsWTvUg06KgMCW/0n/kFdSj+fY6uC3Vyy2eLUhYDU8F0SvrKHSOrth57/
         NvcKwud3h8fTLTIiRUVLKpv5QC42Vgw+uLwHcVRHjj7w0VI1xUgZCXLronp0pMCAlV7E
         yqo4mdwk/oEt1TamZ7mtXN4VBsxfEHDFY0+pWXdB/D3nhedK5Rfvs7tfvRPmaFn8ozim
         iDCg==
X-Gm-Message-State: APjAAAUsfrm6WK2Ff7cnIgIavouz8s2Qk/tNPFKI7dAQ5rw4YNLZ5iuM
        R0ABFpZhZ8p1O1mI5kcERs3KWfqWzSM=
X-Google-Smtp-Source: APXvYqy7YvntvF6dxJr51JcnI6mpGmjmzovMuYYQmK3YiP5lPTeQdvR2DFooi1mnykKmstOt/fxAaQ==
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr6228423wrw.14.1551356877669;
        Thu, 28 Feb 2019 04:27:57 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id a1sm25201268wrq.96.2019.02.28.04.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:56 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 20/24] dt: thermal: tsens: Add bindings for qcs404
Date:   Thu, 28 Feb 2019 17:51:10 +0530
Message-Id: <65d1d506388301b88fdc4380897441d3b1d36f90.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
"qcom,tsens-v1" to gather common code

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 1d9e8cf61018..673cc1831ee9 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -6,11 +6,14 @@ Required properties:
     - "qcom,msm8916-tsens" (MSM8916)
     - "qcom,msm8974-tsens" (MSM8974)
     - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
     - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
     - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
   The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
   with version 2 of the TSENS IP. MSM8996 is the only exception because the
   generic property did not exist when support was added.
+  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
+  any SoC with version 1 of the TSENS IP.
 
 - reg: Address range of the thermal registers.
   New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
@@ -39,3 +42,14 @@ tsens0: thermal-sensor@c263000 {
 		#qcom,sensors = <13>;
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 3 (for any platform containing v1 of the TSENS IP):
+tsens: thermal-sensor@4a9000 {
+		compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+		reg = <0x004a9000 0x1000>, /* TM */
+		      <0x004a8000 0x1000>; /* SROT */
+		nvmem-cells = <&tsens_caldata>;
+		nvmem-cell-names = "calib";
+		#qcom,sensors = <10>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.1

