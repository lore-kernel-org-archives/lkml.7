Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F33C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B932184B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDwrUyGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfEJEe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:34:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34254 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfEJEe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:34:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so2514733pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9XJT6/tH1dITtwqwwLksUn/i2UuLzClmRgZy8rDTNU=;
        b=bDwrUyGicRP9fSW6fbUR34sFHt4e3afbYdrtDoiQet4eIfjmlw0QLI1eIaUKuswFbM
         LbIGKBZjCQBX9EQrW8nigwlmLJedEWzM/PkucoGO2ywGW3gBRwQ7HBmzjKdKHqyhbVHh
         dG1F5LvMkdI93G0Nyy+/detIg+eJOVf+CuruHZvqA/xp2DfZvgaSt24ceJa1PjHGODEe
         Fe/M56z8UEHzKh35wPl7s6NNN4aQfOv9eCLCJMtHaSg6ZhozOBi1iVzyHS1DSh5QETJL
         9qAwPqE8+4jIuejFfheUw6nXcspOCSbO1W9/mtM3IJB3iZD+M2AofBxGuFNZs+Gz2Ccl
         XTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9XJT6/tH1dITtwqwwLksUn/i2UuLzClmRgZy8rDTNU=;
        b=rPdnGks82xnzE32iWHFuWZLADiDVsTIml0Xfpe4fYQWEcc7lgitUpWngZawOV48n8x
         ReQs8f5LRWyhh50ICivzjDQmScY2To9nowhgJbgebvazUaQflxl/6fwJx2UedfE8k/Ah
         4IjMTHx0k2pPDXSoepUPfiHKygCEBCTy3cAyiK8DafpWdydW1Xs/Kc/iTqvwXEUpHoUJ
         crX95JGyeorPYohtxIIDCLl3QyXIHDxdEH0GFwmTRtomcsleBsVY5t3aM4eG6QcIKNvu
         yq3TasozuK9zAk8UpXt9EsoYk+h9PwLOwWTgeIaRTIUCXdmDi89M4uTtdKcQ0TkH94wO
         SzmQ==
X-Gm-Message-State: APjAAAVYkqBX07RTKsS2NF6J16sYjR7tb+jicR3TjWSiyEDaUBIu16L4
        caiiZBGYDjjj2IpmMq4IRsnDsg==
X-Google-Smtp-Source: APXvYqx2tWMZbLvXcC5dL4h3+Ji6jKr/3wiZYay/VBSDzYcTpM25FB4xAbgZ2RwJciBxjYcSochlSQ==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr10993170pgm.15.1557462868338;
        Thu, 09 May 2019 21:34:28 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17sm4785317pfm.149.2019.05.09.21.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 21:34:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: dts: qcom: qcs404-evb: Mark CDSP clocks protected
Date:   Thu,  9 May 2019 21:34:16 -0700
Message-Id: <20190510043421.31393-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190510043421.31393-1-bjorn.andersson@linaro.org>
References: <20190510043421.31393-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Trustzone based CDSP remoteproc driver these clocks are
controlled elsewhere and as they are not enabled by anything in Linux
the clock framework will turn them off during lateinit.

This results in issues either to later start the CDSP, using the
Trustzone interface, or if the CDSP is already running it will crash.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 2c3127167e3c..dc1d7d5d21a4 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -56,6 +56,13 @@
 	qcom,controlled-remotely;
 };
 
+&gcc {
+	protected-clocks = <GCC_BIMC_CDSP_CLK>,
+			   <GCC_CDSP_CFG_AHB_CLK>,
+			   <GCC_CDSP_BIMC_CLK_SRC>,
+			   <GCC_CDSP_TBU_CLK>;
+};
+
 &pms405_spmi_regulators {
 	vdd_s3-supply = <&pms405_s3>;
 
-- 
2.18.0

