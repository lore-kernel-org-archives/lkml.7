Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7518C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEED20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jkt/1rMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFRGyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:54:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40645 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:54:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so5297103pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XxKJMd1N/7H2JNZBrL0GjfLdKt5XA0nEjEVfgW6l7ug=;
        b=Jkt/1rMftJP6m6z7TQi0Lj1ts9T3Bnft1lLH1k2/Owsf4O6uyB/NJkikR2b6Q0tUXr
         1kDMpWHVWBProI1B8MbJAdCZEcEfO/Y9IG/ZrI7gS4taTpy1gBOivJvCRfWR0qC2XOxe
         BPPsOVw5JyWj75xjUV7B5MdRajEhBAT7mVVSX9U5n+QPQ9SLfGWzGlcqPO2fGJ0X29Zc
         fKA7I8t6MkanAjFWFHIbB6v5pr8oYDzMF6lI2BuxrqIi2RD1DhZad0R98LZ8/9jYXA98
         H1RLSvZy5PSNx4VTR0BQWFaUKkTkruE7bG6+R4oeNcqymIzPx/SPutl9YlXg+2GPBauk
         lnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XxKJMd1N/7H2JNZBrL0GjfLdKt5XA0nEjEVfgW6l7ug=;
        b=aY2Hx4SkY7GbLv45bQXP6K3VaO4GspOO2590ge8qLxcAcl+9mFh+L+Yx6Kc1O0Kn6Y
         ekygdB7v4dckTlvmoEjHQ7nB5wgnIWNRRaiGbPD5WaditdMr0W019h/bo1HACZXWkLoZ
         ZcO3FbfOv6dIA7sFYBGozcFDmaNdbOLj7SQlTawjQT/+scsl7ECdN+Ifl0i8Mn2iKueE
         nsPgjpP528NWUD2FSEVALWNAWBkekwSCAuClpNAOBEKs36qzt020pPmMSF9wcwPQ45Tr
         kZrJcZyAJUSokixzD0NO8goQqHAFq5EZ4OGWQpszFwlumsE1X3cxuA+AlRUcT/YfEY38
         l6uA==
X-Gm-Message-State: APjAAAXFTtfEqoL3NzhhGOgTjZRCVzuJNlE5BtKuyHDtJQESJZpoK2qg
        pgF5fkGEe/Ad4aHgS69VU4JOwg==
X-Google-Smtp-Source: APXvYqyC9+nnRj/+oVT15o3AC/A4OCdMwP0JLaEdRTbNBGjixQ6Fv5rz5PMgpGflDjfBe/pKedGKIw==
X-Received: by 2002:a17:902:d897:: with SMTP id b23mr22622007plz.214.1560835430352;
        Mon, 17 Jun 2019 22:23:50 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j2sm16457065pfn.135.2019.06.17.22.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 22:23:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: msm8996: Enable SMMUs
Date:   Mon, 17 Jun 2019 22:23:46 -0700
Message-Id: <20190618052346.32239-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SMMUs on 8996 now that the WRZ workaround in the arm-smmu driver
has landed.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1e3143c4fe8f..2ecd9d775d61 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1177,7 +1177,6 @@
 			clock-names = "iface",
 				      "bus";
 			#iommu-cells = <1>;
-			status = "disabled";
 		};
 
 		camss: camss@a00000 {
@@ -1330,8 +1329,6 @@
 			clock-names = "iface", "bus";
 
 			power-domains = <&mmcc GPU_GDSC>;
-
-			status = "disabled";
 		};
 
 		mdp_smmu: arm,smmu@d00000 {
@@ -1348,8 +1345,6 @@
 			clock-names = "iface", "bus";
 
 			power-domains = <&mmcc MDSS_GDSC>;
-
-			status = "disabled";
 		};
 
 		lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
@@ -1376,7 +1371,6 @@
 			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
 				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
 			clock-names = "iface", "bus";
-			status = "disabled";
 		};
 
 		agnoc@0 {
-- 
2.18.0

