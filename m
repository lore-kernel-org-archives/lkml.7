Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B6C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453E520989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXKaE/Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfCXRUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:20:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36068 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfCXRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:20:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so4796757pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8jjXUZYrVPacaQgdp11GuDHSIunYAokgnlYeCW0bcU4=;
        b=JXKaE/GwuWAdYSXBt3R8GAurLLKerYczfdGIb7fFj9O/Y21ZTUNzMhpVdgLjoYQAkz
         XMAjEeApwikW7IBDEcUrn+/lb6aKXruO0uSjDIpRhY9GdwzgWOUYg+1/iYIvVju8R7AP
         EelBTGo9lYBp0CrL4fXmoSM8Tn3uhiHBxdWQMm+pZJ/szPxti+B/8Mo+QPB8ezjRw8+M
         +VyTb5JHIRXnu7aXhl6yssYX6+YbWVR/W1+1SBKKps4OW3G38OEkkncodP3U4ZbFxkVX
         gnptXDDjCnXSqmbIJl+VpDqYZEDtCwRjTdSJMX69KaEI3ZJIrWldKwEWxGJEC3UgUhyS
         t1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8jjXUZYrVPacaQgdp11GuDHSIunYAokgnlYeCW0bcU4=;
        b=hdqpYMbQEzQwjgBZq0frHOTRAYLcgdQJK2b/hdlLg6DBA6XqKnH0EpIo7v/0moDrY+
         K3sOsVtcaqw3Zny/Ob5x1Tt+SZLntplyJBcCaFNBYw0Ah7OJPFriQgitH8m7ptmJDqMf
         nqTSZJ45SRu+/8tt/SpMkV/kHIVa10mljxPqAayyfcrhljdVY8pFsnc49GkKRfcWyRAg
         KjpxrKA3jfOU3u4A1eNhy9qWpS0ssLh6FMdzMHDr7r5FYu6CjotAx12Jol9EBZyC7kTs
         StCh5UAGltyvj0woEx7XT5adx3aknuHyUBgXIz7QAIQVKwU5xzJNyZH6l7KnhyZ2W9sa
         nTwg==
X-Gm-Message-State: APjAAAXMtAO39PX8vecRZEPUH7FcsaJkRNgZ6b9W06606jAt+zRW/uVX
        pT+b+AN5TJC+ZbL52oCAPZGfTw==
X-Google-Smtp-Source: APXvYqyTB5dmczecULGoeU84poBUfEu7/+C79q86HXVFJELqHpnBkTpxuG+eoGpW1nS9hmfSqyOpog==
X-Received: by 2002:a63:7150:: with SMTP id b16mr12025583pgn.83.1553448022319;
        Sun, 24 Mar 2019 10:20:22 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g6sm20382713pgq.54.2019.03.24.10.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:20:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: Fully describe the CDSP
Date:   Sun, 24 Mar 2019 10:20:16 -0700
Message-Id: <20190324172016.1195-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190324172016.1195-1-bjorn.andersson@linaro.org>
References: <20190324172016.1195-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 88 ++++++++++++++++++----------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index f62cd09d965e..c20425aa9ed9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -113,37 +113,6 @@
 		};
 	};
 
-	remoteproc_cdsp: remoteproc-cdsp {
-		compatible = "qcom,qcs404-cdsp-pas";
-
-		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
-				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready",
-				  "handover", "stop-ack";
-
-		clocks = <&xo_board>;
-		clock-names = "xo";
-
-		memory-region = <&cdsp_fw_mem>;
-
-		qcom,smem-states = <&cdsp_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		status = "disabled";
-
-		glink-edge {
-			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,remote-pid = <5>;
-			mboxes = <&apcs_glb 12>;
-
-			label = "cdsp";
-		};
-	};
-
 	remoteproc_wcss: remoteproc-wcss {
 		compatible = "qcom,qcs404-wcss-pas";
 
@@ -288,6 +257,57 @@
 			clock-names = "core";
 		};
 
+		remoteproc_cdsp: remoteproc@b00000 {
+			compatible = "qcom,qcs404-cdsp-pas";
+			reg = <0x00b00000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>,
+				 <&gcc GCC_CDSP_CFG_AHB_CLK>,
+				 <&gcc GCC_CDSP_TBU_CLK>,
+				 <&gcc GCC_BIMC_CDSP_CLK>,
+				 <&turingcc TURING_WRAPPER_AON_CLK>,
+				 <&turingcc TURING_Q6SS_AHBS_AON_CLK>,
+				 <&turingcc TURING_Q6SS_AHBM_AON_CLK>,
+				 <&turingcc TURING_Q6SS_Q6_AXIM_CLK>;
+			clock-names = "xo",
+				      "sway",
+				      "tbu",
+				      "bimc",
+				      "ahb_aon",
+				      "q6ss_slave",
+				      "q6ss_master",
+				      "q6_axim";
+
+			resets = <&gcc GCC_CDSP_RESTART>;
+			reset-names = "restart";
+
+			qcom,halt-regs = <&tcsr 0x19004>;
+
+			memory-region = <&cdsp_fw_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <5>;
+				mboxes = <&apcs_glb 12>;
+
+				label = "cdsp";
+			};
+		};
+
 		usb3_phy: phy@78000 {
 			compatible = "qcom,usb-ssphy";
 			reg = <0x78000 0x400>;
@@ -506,6 +526,7 @@
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 
 			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
 			assigned-clock-rates = <19200000>;
@@ -516,6 +537,11 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		tcsr: syscon@1937000 {
+			compatible = "syscon";
+			reg = <0x01937000 0x25000>;
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x001000>,
-- 
2.18.0

