Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11AC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61E8222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAA0qFXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgABOzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:55:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50549 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgABOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:55:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so3348673pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQ3dPyVIYOxnnD+V93y32YHWB9TyUbtp8D+2BSxgJjI=;
        b=HAA0qFXPm/feR1Ew/vwtwclzWPyBuVhbCMyKzSfk+mFTqf+hLc7gq+QlFGuYOyr/fc
         CyhSu4o6NwWWTPcJn1t2qjZtoHIo/vbiZMrudIJlV8u+ikmzs+30YbcYs29LU9vFfW+z
         Aj/dyGVA8AvnEZbqp9vnD5aC85GvONjy0ss2CPjOPdNZpVYplhIQ/0G8/CDQd/Nqhu+z
         X5J60RFDye1a+qyv691H9YIKYuRP1iZ8kowTd4C+3hR6y834ctBesFJfkPWsqH3PI6s9
         caxkCijpZALFHNzbuvTe5hO4OcCoNKHJuloha4Q4Q5eQMOKxmCa5Bw8qwYHZOyVQqYmT
         SVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQ3dPyVIYOxnnD+V93y32YHWB9TyUbtp8D+2BSxgJjI=;
        b=GclMzr5JASabZZ69++Oaus4waaa9rpaf50dJvprK7+Eo0EqCISWMmu7ak1T29aFjb8
         qK35PIUoA75Mno9/tOJQqYwy78WhiEjc5j7noX4Nps9EoF54NDMl31NA0aOjuGriJ0wb
         S12fNhS2Oudwuko6blwkHaYawGJ7Ci/wJE9KiZDITwbTgGJAxJRsvZRDVtv928N95bdW
         Usjq0dMOTunx5NreW46H/jhCz61jBL4EzA1I9VeCk4wAYsmttpEyEpZcacCwf912d8Az
         SzyZ26MSsvrOnmzLbevuklzM3PK+Zk06lAJ3Yi1Wx0qrxwg0dydzrU6v7SzCIOCcrz0E
         xZvA==
X-Gm-Message-State: APjAAAVyDOaWLc11eorcbhXP5kTlaien4sa8VLu3RpjYzqVXpQiwq9Zy
        C5a3COpwzjYqXAA/SUcvijbOM6BDnmpnqQ==
X-Google-Smtp-Source: APXvYqwQggvFSNCdOyWo4GIOGfBb4EPNOjBCZx/+BM2YzYiNE/19lee99UQH/FwKdi2eQNwxfET3Yw==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr83625707plo.225.1577976911485;
        Thu, 02 Jan 2020 06:55:11 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id d65sm64405487pfa.159.2020.01.02.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:55:11 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 9/9] arm64: dts: msm8998: thermal: Add critical interrupt support
Date:   Thu,  2 Jan 2020 20:24:34 +0530
Message-Id: <445b152a10e51c29590659ce717f505d56a98d9e.1577976221.git.amit.kucheria@linaro.org>
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
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index fc7838ea9a01..4b786b8651a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -817,8 +817,9 @@
 			reg = <0x010ab000 0x1000>, /* TM */
 			      <0x010aa000 0x1000>; /* SROT */
 			#qcom,sensors = <14>;
-			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -827,8 +828,9 @@
 			reg = <0x010ae000 0x1000>, /* TM */
 			      <0x010ad000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.20.1

