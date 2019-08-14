Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84227C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532022083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787177;
	bh=8rCmgCmjbHa3LmqgXmT8xe3QsdrTF0QeAhzbRowfYfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w1rFlbFaZYdXQCtAoTXFVx/p0NG2EX+DgKVcm47xTrFvkisPD6kTltFA4kH9lawiK
	 8GUHB1a4Ckc9FG7b6Xnkfor9LKrK+6BMexMbbjmJQ4iLkEAaRtF3XS0a/Lq9YD4/jd
	 iy2YwMQsL0pujM+LuekwPaGu5enuM5r25Ne4yamU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfHNMwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfHNMwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:53 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFF92184B;
        Wed, 14 Aug 2019 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787172;
        bh=8rCmgCmjbHa3LmqgXmT8xe3QsdrTF0QeAhzbRowfYfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOXvXoo/7J2/z3iVLdEuY+0R8b9nPJXJ8mNA1ayGHjC+luH4bZi8R++hMTerBlAFD
         nAsOH8snZ24GBMlg+xW4Q5R8rICY4tFUIl5uy3vzjr9rFgUka81xyl/Sh+61087ywi
         MuW/AXpQNqy/sN2R4rvT6Nl7gE7Vp3vKUZemSHIQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] arm64: dts: qcom: sm8150: Add apss_shared and apps_rsc nodes
Date:   Wed, 14 Aug 2019 18:20:07 +0530
Message-Id: <20190814125012.8700-18-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apss_shared and apps_rsc node including the rpmhcc child node

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5c6b103b042b..5258b79676f6 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -213,6 +214,12 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		apss_shared: mailbox@17c00000 {
+			compatible = "qcom,sm8150-apss-shared";
+			reg = <0x17c00000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
 		timer@17c20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -272,6 +279,29 @@
 			};
 		};
 
+		apps_rsc: rsc@18200000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x18200000 0x10000>,
+			      <0x18210000 0x10000>,
+			      <0x18220000 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   1>,
+					  <WAKE_TCS    1>,
+					  <CONTROL_TCS 0>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sm8150-rpmh-clk";
+				#clock-cells = <1>;
+			};
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0c440000 0x0001100>,
-- 
2.20.1

