Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07719C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98E9206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugtyN4aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfECXYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:24:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34369 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfECXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:24:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so3636077pfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/RkezotWe0qKz9gHI76Sx6wtXQAllpgle4h0JP9cnd8=;
        b=ugtyN4aWkbZ/xhfEWgsJkOc+gWDbNF9B9D+Yyui7dkiGipwGkMFmNn0NwPZ52HzZfj
         Mg6H4LQOaoYV4qmeIr70TuVEcdZGQ+v3HadDR5FRIx3adlE3HG98hjGJ1iY4icxXpEsr
         rQ0kH2jFKRG6LQiQ7NehMf0mFbJiOqH7Doi8qpGk8LarR3nzIdNmGIUg7hVhAZqk2Y7z
         +g6FSZJGjEoFz64pJthDkOT/zPNsCtm7Fe7wjSvfgCOdbdImiF9sx/T4PYAeHn9lWPIm
         YmuRaQzBsqw7pxw2YuwCHv/1nOIBhJtayWqA0cpleSnDk34iMh1TTNCTDZ+FU6PsBFgx
         UXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/RkezotWe0qKz9gHI76Sx6wtXQAllpgle4h0JP9cnd8=;
        b=EjnR4QS0ATzJuLiUbFx9mve+dPC813myrV4MresXHSFJYXHj4G8bOUyJnmv1W1Ine+
         Nh7OL4RmYeRONtVi+WSUEI9fJy51+c9yg/Xo/N0wuro1Q179MnP9X0GGVIjzGOCWDBN5
         pWzXIkBbpwiILx0t8MCEHtSxJ0GvbaEzmBN6RlR0zKYmhG3//k1FxxdZNTPHIzfVTcFE
         QHCKwdHo3iLJ8mR8VV2BWmXATaZsmiz5Pef+sv6f4Nw1YxOJVTOGDab8Vbkrt/O2BRej
         dq7wzMRDNDLjWp+TqWO4zQ5S0QdHBgX6FNvj8Nh7BedLB8huuQmI0fPFxRnzy1PV+bwO
         fJiQ==
X-Gm-Message-State: APjAAAWkENm/HOqWGaoOwsSYBULSVfRRnJIfYW6mPI6OqOxnJjTOhLK6
        CS4ofWrXj8zn+Gtw2AUM7kNgUw==
X-Google-Smtp-Source: APXvYqy2094pPqrRw5vcRArh29lDQGBGEffB4m2Hn2aAzXW9yXtO3zUgfgWhWfcozfRDjin+8YwDCA==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr14402079pfo.169.1556925885301;
        Fri, 03 May 2019 16:24:45 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e184sm9381071pfc.102.2019.05.03.16.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:24:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: Stop using legacy clock names
Date:   Fri,  3 May 2019 16:24:42 -0700
Message-Id: <20190503232442.1530-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDSS and its friends complain about the DTS is using legacy clock names,
update these to silence the warnings.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index a988edabe474..3d861f1d836c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1678,7 +1678,7 @@
 			#interrupt-cells = <1>;
 
 			clocks = <&mmcc MDSS_AHB_CLK>;
-			clock-names = "iface_clk";
+			clock-names = "iface";
 
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1697,11 +1697,11 @@
 					 <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc SMMU_MDP_AXI_CLK>,
 					 <&mmcc MDSS_VSYNC_CLK>;
-				clock-names = "iface_clk",
-					      "bus_clk",
-					      "core_clk",
-					      "iommu_clk",
-					      "vsync_clk";
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "iommu",
+					      "vsync";
 
 				iommus = <&mdp_smmu 0>;
 
@@ -1736,11 +1736,11 @@
 					 <&mmcc MDSS_HDMI_AHB_CLK>,
 					 <&mmcc MDSS_EXTPCLK_CLK>;
 				clock-names =
-					"mdp_core_clk",
-					"iface_clk",
-					"core_clk",
-					"alt_iface_clk",
-					"extp_clk";
+					"mdp_core",
+					"iface",
+					"core",
+					"alt_iface",
+					"extp";
 
 				phys = <&hdmi_phy>;
 				phy-names = "hdmi_phy";
@@ -1777,8 +1777,8 @@
 
 				clocks = <&mmcc MDSS_AHB_CLK>,
 					 <&gcc GCC_HDMI_CLKREF_CLK>;
-				clock-names = "iface_clk",
-					      "ref_clk";
+				clock-names = "iface",
+					      "ref";
 			};
 		};
 	};
-- 
2.18.0

