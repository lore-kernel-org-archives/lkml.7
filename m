Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RbLFGlsD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H6vwgunM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJUG4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:56:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:56:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14DE360A08; Mon, 21 Oct 2019 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571640984;
        bh=5ebcvipsQ3v3kdsn0W99SWFEJTliWn2K2fxIAJclb3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbLFGlsDuriJdcfsCeh1dkKMCqwNATaca0oKUwJbjpPGAlDxoJhn2UV9SvEgfAufF
         bwNu/78zt/o0RYO5G0/dNliXSoHJKZClQ1LkTA/Hg0LoOZZGlkELC3LWYPiKYMstrm
         IssTCOe54za+p7eedNzErsvyPC7cC1nUH32hv9q8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85DE660953;
        Mon, 21 Oct 2019 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571640983;
        bh=5ebcvipsQ3v3kdsn0W99SWFEJTliWn2K2fxIAJclb3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6vwgunMBS2OtQJGG0gxj4pCpVuB8WZSKhtqj2kdQ9Jm4npvbRpqrAbtyz2QNsAZ6
         9/EkoGB61nGA+Cj2BcPyaRGYHDn1PFRheXv7OdjZe0cl1r4Kc6QMz6g40EPARnAfJA
         l3ClJIu+BnZ/QZZ35Kx9FDa6yEJSK2Hunh5HS+cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85DE660953
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 06/13] arm64: dts: qcom: sc7180: Add rpmh-rsc node
Date:   Mon, 21 Oct 2019 12:25:15 +0530
Message-Id: <20191021065522.24511-7-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021065522.24511-1-rnayak@codeaurora.org>
References: <20191021065522.24511-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

Add device bindings for the application processor's rsc. The rsc
contains the TCS that are used for communicating with the hardened
resource accelerators on Qualcomm Technologies, Inc. (QTI) SoCs.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
v2: No change

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 012ee5028bf6..6b3f08133eff 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sc7180.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -388,6 +389,24 @@
 				status = "disabled";
 			};
 		};
+
+		apps_rsc: rsc@18200000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0 0x18200000 0 0x10000>,
+			      <0 0x18210000 0 0x10000>,
+			      <0 0x18220000 0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
+		};
 	};
 
 	timer {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

