Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE781C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42221850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSX2woIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfCTNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:49 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34850 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfCTNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:47 -0400
Received: by mail-pf1-f182.google.com with SMTP id t21so1174394pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n8wsQ7ixOIiYIm36smSOqEN/oeuVV2Uzvv7QGvE7MK8=;
        b=bSX2woIfjmWZ6MS1ON7RyACNxWEuYrjBwDPqUi1qLKA3hblgxdLaH48iks0zZsZJEb
         OP6oO6NXNMEH4nf/TXWEf9rm/aGY09HYEtjkVIQSoDuDIRIxf0KamS6SzE5DVIe3gn35
         XkLLALg20+EeVJ4Yq7hzJSvET5/aU3E87/jSJxFHnSw3M71nDkDk6UTWTDHsRKB22iAz
         0AekHMAh8EFKvweDfVrsCO3QmUkBBEEmqLPM4OwShNP1pa+wzVV24A4mm9fOtbNVxDrp
         MuRV2HptsYAmCL8YC5Nt8/E1IpBj5d92gZ9XR51WMIJhySSWXsQBnd9ByXrKa3KTvEUs
         eh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n8wsQ7ixOIiYIm36smSOqEN/oeuVV2Uzvv7QGvE7MK8=;
        b=Y51e7lXqW37rxDxPmJtbu6sSJy+lnlCRZM5VQgPHpfTOOoPakrp2cyiSKbSLuvkT0s
         bQSFO88IgM7LfMNVQkTj0l9Uokf+qrqJPYGJQ508h7ynyUmtIs00xZNMqd0CQOrefBSO
         s2l/NLxGOE5FDeGmP2eUKIZKXD1GKUeStdCx7UvzaPZweyj9tx2IgxCB99tzpHhnu3E3
         th60inf49kxUCjEnAnpQ+ewvsyEk/wLW91L41FVoFbyBwSr8YLHi87dZukc51w1MHdpo
         dlqU3AlJZyNuLPPEsWSY4zO7fnks1+SRd8NZoSf85wVx3IP2b7JF6vaSz9durJ3cvvlV
         4Mzw==
X-Gm-Message-State: APjAAAU5ZPofY0WjDoh+93vGlYBXQD2Y5GxwHTiWZoyoWmeD0NU3iKPd
        m7Dr7f+FkZfPHIhvQo36bdaKJT1W44s=
X-Google-Smtp-Source: APXvYqw+R4H62H+aFB9U/nouAhJIMV5gK2XbkUBmyEBYKM7iXny9gigdjrWnO36va9rK+Ag+8h3W4Q==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr8326788plr.36.1553087986870;
        Wed, 20 Mar 2019 06:19:46 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id i79sm5913448pfj.28.2019.03.20.06.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:45 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCHv3 19/23] dt: thermal: tsens: Add bindings for qcs404
Date:   Wed, 20 Mar 2019 18:47:59 +0530
Message-Id: <7e4fd2f96fecc4daaee6ff87e486891b2c0764f9.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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

