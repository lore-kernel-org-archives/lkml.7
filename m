Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FA92184B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJFQozyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEJEeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:34:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46656 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfEJEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:34:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi2so2180910plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=env9uxGf/YDPrGif/zsypWijN3KnRmxh8/WUWaV7Q78=;
        b=gJFQozyCmLkFapzpMYtWgmMIKnFeSmlXAAB8gAHcmU4aMPu874ZBoNT8dE4DLSMqCu
         Cq962ZaYtdy00rzlcyufkbBtBbLBbsgrIHb3BqgltfSIKzJXi4UGq+TDuzkHXC9IRTgb
         uU+gizZdExvTL7G1wGmcciBpgyTULL8Okovt90c4II4jOIOUOPvbOm+DA2vdG0bpz7RQ
         CVT1imO5xr0dIWCu/EsZJPRBtmkscsM4O5cnjyA+LJwGRPrmbT9lyOSVOy1aWjgKip8p
         uoQMG8IsUtdY3eEQFfydA6ytSixZkowVJj2oUEQuMr0E3SoJsBBlclgbW+3E1UL3qdrI
         WD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=env9uxGf/YDPrGif/zsypWijN3KnRmxh8/WUWaV7Q78=;
        b=W0QrI16iIcgj06MUpvUcg8XhIVxx7Mn5/nfO1knX22KaEM7FCi577e0zQS3CAnLBEv
         pAyHeKV5W6fUC/5N7Iv2GndKwtDo8QAaTlx3QcX10T/B+uQ8N+j+PXys9RRabwQ+9PWA
         pxVuwJVtUGTc2QcTkodbZlS3wok9+G0n5BTqK65Lf9zFcNOxE7FvSWi8u0Tr3BXasoyM
         Y4pyr7JYD/iA7hp0qpgRqhK9lmQGKFB2oh9FPy26hpef2aa6HKMiUPvjbn8k4WJYGXr7
         FB+68+sgzxDMLimfacW0Mn2YoekcLZO5C0YR4Op7oysgZp7l7Fz5OpSlAt39GO/EQL/P
         lfqA==
X-Gm-Message-State: APjAAAVBFVZ9PQN5SZe2GBDosumCrFRROccJbBR7DPytoNyBvBbjiVML
        70+i0qVCvRXU9uJK3QdMuhI/Fg==
X-Google-Smtp-Source: APXvYqxEtuHSsfNnwSWrni9vnsiFbozVj4Equl1s/fzYi2DGq0pIWP56GFGY0eeDOHbX9sWLdFNVwQ==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr10360710plf.142.1557462871562;
        Thu, 09 May 2019 21:34:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17sm4785317pfm.149.2019.05.09.21.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 21:34:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] arm64: dts: qcom: qcs404: Move lpass and q6 into soc
Date:   Thu,  9 May 2019 21:34:19 -0700
Message-Id: <20190510043421.31393-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190510043421.31393-1-bjorn.andersson@linaro.org>
References: <20190510043421.31393-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we don't describe lpass and wcss with all the details needed to
control them in a Trustzone-less environment, move them under soc in
order to tidy up the structure and prepare for describing them fully.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 126 ++++++++++++++-------------
 1 file changed, 64 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 896f95817f23..b213f6acad76 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -82,68 +82,6 @@
 		method = "smc";
 	};
 
-	remoteproc_adsp: remoteproc-adsp {
-		compatible = "qcom,qcs404-adsp-pas";
-
-		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready",
-				  "handover", "stop-ack";
-
-		clocks = <&xo_board>;
-		clock-names = "xo";
-
-		memory-region = <&adsp_fw_mem>;
-
-		qcom,smem-states = <&adsp_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		status = "disabled";
-
-		glink-edge {
-			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,remote-pid = <2>;
-			mboxes = <&apcs_glb 8>;
-
-			label = "adsp";
-		};
-	};
-
-	remoteproc_wcss: remoteproc-wcss {
-		compatible = "qcom,qcs404-wcss-pas";
-
-		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
-				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready",
-				  "handover", "stop-ack";
-
-		clocks = <&xo_board>;
-		clock-names = "xo";
-
-		memory-region = <&wlan_fw_mem>;
-
-		qcom,smem-states = <&wcss_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		status = "disabled";
-
-		glink-edge {
-			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,remote-pid = <1>;
-			mboxes = <&apcs_glb 16>;
-
-			label = "wcss";
-		};
-	};
-
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -458,6 +396,38 @@
 			#interrupt-cells = <4>;
 		};
 
+		remoteproc_wcss: remoteproc@7400000 {
+			compatible = "qcom,qcs404-wcss-pas";
+			reg = <0x07400000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&wlan_fw_mem>;
+
+			qcom,smem-states = <&wcss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 16>;
+
+				label = "wcss";
+			};
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
@@ -843,6 +813,38 @@
 				status = "disabled";
 			};
 		};
+
+		remoteproc_adsp: remoteproc@c700000 {
+			compatible = "qcom,qcs404-adsp-pas";
+			reg = <0x0c700000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_fw_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <2>;
+				mboxes = <&apcs_glb 8>;
+
+				label = "adsp";
+			};
+		};
 	};
 
 	timer {
-- 
2.18.0

