Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D806CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EA320820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+fb3tE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406711AbfJRF55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:57:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46431 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392149AbfJRF55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:57:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id e15so2712699pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjR68Nu1t94WjnFzIRWXICEwhOwBhStsX4bSmZOmhNs=;
        b=U+fb3tE/PXhBNdyt+N8SnfrqAnvToUfKvHhzKzU0b45zxSed9yn6r1dkMtJEzAMp12
         b1q/xjnm/4KeWJUVrj19bSnu9nxn9JwA29Dp3+d02eB14HJ2tbRnWCyx3RsfbNGxV8E7
         iwh/HzxzF+Cr0JvgfFOIa5EvWJ+PlDYp0SmuSgXw5a2Zub9Tiki6hA+I2mi8rUlxt8sp
         CmvnBXem1FFDkVXLLJ91IVwDJv5UaR7p2S3xo9zxBmSNrfn3U7XvFlDWEo92oNKYjetN
         z3+/AwRmQUsxJGezI6NQOEWKqEUU6TfhKhCQnEmfcmbKcYYj1NGEUqGlgQJlDxdydym+
         WZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjR68Nu1t94WjnFzIRWXICEwhOwBhStsX4bSmZOmhNs=;
        b=JpZ0u3sl267/TMdivfvrI0HlwWAYolVcPwJ0gpsNUjzxbc7uFLGPrBZtRWNFF1h9bo
         kRUPJX0uzoM8XA0CRbyJcGv9SY2kfDPHKkHRywt5z7erNrytfvXa6/BOS8FLmX7T/lss
         0NYddv134K5L9YjxN4bHhuJlQ9jiAN/QU1mkSr4xp1eKajeBf8V7Q2vnQNId3KiHrySf
         A9+7FEmGTaCAt3snfTVZpciLHUYBJq/t2+ZvzVFX3UHAqgIgRlP31SoynFKvgQXdSHrn
         XM42N4JLC1Vn/xqpP1KU6HHDJHn3kEY+1cuRDtDwTMapb10Pp8ablbDG3tHfuZAwg0C8
         yDKg==
X-Gm-Message-State: APjAAAWCUHzN1/HvWP7TbKBxU1l7DZ/0UZJ6Gt+kfaoLdLdfXLYnTPur
        UZrb3wx1Y2GUriop2nUiljW+ng==
X-Google-Smtp-Source: APXvYqy5IJeHpgkEnhtjCit/UQHxfkfdJ1iX3G7PowQjWoI5KfKn/OGjXDBMpAkntx8AHu8A8oBhuw==
X-Received: by 2002:a62:3441:: with SMTP id b62mr4734957pfa.233.1571378276610;
        Thu, 17 Oct 2019 22:57:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f89sm4447849pje.20.2019.10.17.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:57:55 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Enable UFS device reset
Date:   Thu, 17 Oct 2019 22:57:52 -0700
Message-Id: <20191018055752.3729530-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the TLMM UFS_RESET to make the UFS core reset the UFS memory
device during initialization.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 13dc619687f3..01709951fdb6 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 #include "pm8998.dtsi"
@@ -394,6 +395,8 @@
 &ufs_mem_hc {
 	status = "okay";
 
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.23.0

