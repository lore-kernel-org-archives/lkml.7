Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B82C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3666020665
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ok3TDXB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfFLEpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:45:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34676 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbfFLEpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:45:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so8860263pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lU+1IReUFq1QxTqJmNw/PFLd12Qda0MdEvw29DLYGsI=;
        b=Ok3TDXB/0ir1GXhXi4ceey/ULS/XIgOAO3ADiqKp5EnZ72xf3Z2Rz5aTAdztTH/lSH
         yV+BGzMyOaXTmH7eA8jzZnCBDsKHX/YtNUEwo9JofnxkgjlptRcxgMLCBDz2C4iN6ePX
         eUMC9IntZ82vQqR23loEnCWf7Tk9R+bNazeOqRZ8/QFTDDFa2tzRoVbht8lRG8t4j+RB
         RC1SswfT5jxdzNHlGZm4nu2xuGfYrAwMEEFcWkdLL/eAWYwtGx5+X9B8b5oOQJahhGMK
         96HmPZsmjNF64F6fuxyJaERspyC9niiFYDxMNub4ply7vD9VPSoGCaxLI6fZE97mgI/q
         546Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lU+1IReUFq1QxTqJmNw/PFLd12Qda0MdEvw29DLYGsI=;
        b=JTqyCTCe50jZqWfkZP38IQIVlODyPS3pd4hHVIP8i9SY52Ip4UJG+JoUkUilKNVflz
         VCs5/Yz0SaZ4r8ZMy24XlV0lHY9u9LYOnXff6K2zWOJJRuJZN2McbxGQpzVcn8VfRrs4
         qU9HKtVFjRgDVHF8a4NKKDtK1UwIV8FHTPezy655pjcgK4CxH+wUmk0SyiOI/hZKFBPu
         vwFdzA0MkHdg7ARN3iajFesDYPj4r7FzewM3XbKPHEYZLN5H+g1T2nZ2qF3ZDBjJmTPg
         B72CjFY0KWvX17lmlfmn54b3fKLmcMffvZI4IrRhHhLUAWdcgadUIhjOeJW0YmqhL2uz
         gb3w==
X-Gm-Message-State: APjAAAWcGdg9HhUzjYZYpBNgqSE8otoPj300KB/0ujWQ5RKfAnu00Tot
        yetniS7buhHYNRXCDA4INH7Ijg==
X-Google-Smtp-Source: APXvYqxidn6YVca8VaGCmJ1n6WsjntR5pgsqjt1jIgf7t/P0osUBMOKWEroQFtZYfl48vexKIAhPJw==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr29021075pjw.26.1560314742061;
        Tue, 11 Jun 2019 21:45:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z126sm17129194pfb.100.2019.06.11.21.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 21:45:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/4] arm64: dts: qcom: Add AOSS QMP node
Date:   Tue, 11 Jun 2019 21:45:35 -0700
Message-Id: <20190612044536.13940-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190612044536.13940-1-bjorn.andersson@linaro.org>
References: <20190612044536.13940-1-bjorn.andersson@linaro.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v8:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c5a5c5b086b1..c80881309f79 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2448,6 +2448,16 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

