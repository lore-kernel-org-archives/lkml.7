Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71124C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4483E20863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoJJ45RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfFSAQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:16:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42179 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:16:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8585856pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rj1JwC5n4pB7Dhbe0Ao/biHZaqd5UjG4Gs7lrigeZc8=;
        b=LoJJ45RA69zD11EO8Btx9b8gd9Cb8A9z4ALILngsiDR8YYbjzPANv5sy5o92/MuzhZ
         5qNs5Ghml0uKqipt+uzpCItL8q6pP3A6iKs0ypT1DjLDlWr9NFbFIqa+WGHHN+dTg5h7
         FhbArgWJvsqT1JV0KRkjAfxyuDxoHPi9ho7j7sl3mUzu1salMRc1MH3kqzD6gtWSkoHT
         3ej9oGa5IYpZY5L6wLNUgQXbNLT1MbDXQSe7Shq7CswD3buRBTpxd4oMcTnTzesE/6Y+
         hX2fukWWYW/tyPjUebUZNVsvoVnBGBkI6AmakeR1UaJtdOcwvOtyDa7i3taAPLSIxHRB
         FeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rj1JwC5n4pB7Dhbe0Ao/biHZaqd5UjG4Gs7lrigeZc8=;
        b=n5LTtXXUTsY6jjcGn/RoFAB+DBsr6MMD+2UPMFcypVy8wsOsK2OrvBNI4I6nTxcCuQ
         ShpnXXt2XgfXjmtYnwjEtFQ9AS0QTiEcKKkj3YWwSV0FZL2EXik8YZM7hdHzn/eB1X2M
         jVjOx0blrqkbfN3PE0b1Hr+XIpt/YbHwGhr46JE+IkH3DOqhzhOaXUQdw8hROxld3xP7
         ObbenzL7/WS9g23KOxCOJ947ozgAXnMJ/9vCrMn1m4VlTlBMjjfeogeU/hFmmQiFv4D9
         BSMr4JF9o2b/TIWFJ5VsCXu8ZZVAYbM/rPPd7u68gThrunktm+x0RHJTZmgBe09aXmj2
         GTOA==
X-Gm-Message-State: APjAAAUIvNajzeGxevsi8BKXFap8gT82bUs7M0Vv3Mam3y6mo61mXUYj
        C9iwawAtl0WxA/OhClrzrgFVZg==
X-Google-Smtp-Source: APXvYqxmOTrQOpTGIV29dhD7dMfNmq7D3jbBdlbuSFW3gz8q8OTUWaN9T1MdLCPbnwZ3h5EqDt1bqg==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr8144509pjp.114.1560903365397;
        Tue, 18 Jun 2019 17:16:05 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m19sm26271431pff.153.2019.06.18.17.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 17:16:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: msm8996: Rename smmu nodes
Date:   Tue, 18 Jun 2019 17:16:02 -0700
Message-Id: <20190619001602.4890-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names shouldn't include a vendor prefix and should whenever
possible use a generic identifier. Resolve this by renaming the smmu
nodes "iommu".

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Updated commit message to talk about vendor prefix rather than qcom,

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2ecd9d775d61..c934e00434c7 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1163,7 +1163,7 @@
 			};
 		};
 
-		vfe_smmu: arm,smmu@da0000 {
+		vfe_smmu: iommu@da0000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
 			reg = <0xda0000 0x10000>;
 
@@ -1314,7 +1314,7 @@
 			};
 		};
 
-		adreno_smmu: arm,smmu@b40000 {
+		adreno_smmu: iommu@b40000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
 			reg = <0xb40000 0x10000>;
 
@@ -1331,7 +1331,7 @@
 			power-domains = <&mmcc GPU_GDSC>;
 		};
 
-		mdp_smmu: arm,smmu@d00000 {
+		mdp_smmu: iommu@d00000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
 			reg = <0xd00000 0x10000>;
 
@@ -1347,7 +1347,7 @@
 			power-domains = <&mmcc MDSS_GDSC>;
 		};
 
-		lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
+		lpass_q6_smmu: iommu@1600000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
 			reg = <0x1600000 0x20000>;
 			#iommu-cells = <1>;
-- 
2.18.0

