Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C0C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA97A217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573029997;
	bh=XPHAfWI50FqeR2Qai3oNMg7QosMziMbbCg128q8f7rk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ewU+vXEkcMOXnxwDw66dG1VkJ5eSKFxYh5tsFYvzoQBUBlQmokt6Ok7QskZ22iFqT
	 M3pGJ2fqCNHm2HIUUhBh6en+V2pWwCH20NbhhkXjar69l3czLGQNnkGdvwSuUb7kfJ
	 cfdioghbtHNqqIHqi3DIvK2CLPFM80sfks3u5Sbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfKFIqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbfKFIqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:46:36 -0500
Received: from localhost.localdomain (unknown [223.226.46.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDC3206A3;
        Wed,  6 Nov 2019 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573029995;
        bh=XPHAfWI50FqeR2Qai3oNMg7QosMziMbbCg128q8f7rk=;
        h=From:To:Cc:Subject:Date:From;
        b=XTaJ8cPtrvjO1ZPeGsp08fmPy9j5kkEfwR3dBwiVt3IOf0a6B6XLLZWRH5n2eL54g
         cyuMCiD1FJ23dVLUqPZvXXCuUy1TQ4XvZ17B8jxnbLY2g5bZ7khLypXxCgSgVv8CRf
         OKwl/kImMPKnZDq4hcFg6ZfpsW64jZOD/Fvkf/cA=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Use gcc clock enums
Date:   Wed,  6 Nov 2019 14:16:04 +0530
Message-Id: <20191106084604.1746544-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that header defining gcc clocks is upstream, use the enums instead
of numbers

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 379c40b9a52f..a9b1cabccbf6 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,gcc-sm8150.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -490,8 +491,8 @@
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
 			clock-names = "m-ahb", "s-ahb";
-			clocks = <&gcc 123>,
-				 <&gcc 124>;
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -501,7 +502,7 @@
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x00a90000 0x0 0x4000>;
 				clock-names = "se";
-				clocks = <&gcc 105>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.23.0

