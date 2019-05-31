Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD37C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AA226274
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsAugKex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfEaDBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:01:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46649 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfEaDBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:01:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so5195306pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9oOs0PxskGic5/b7RTQxcSk0/t3lEcqZGj07P5otHq8=;
        b=qsAugKex9pTeXPylDLyCfPWEn5qgXavR8GgzLC8UoUgRLxKALJvN8kOs8Eo26U4cz8
         EEGILf5qHnDVR9odU6omKYCjSGE5tW9LNJgaoSc1JxAglOLlDqq3s/BLtEjYgdQBi1Yc
         DIBVezOpjlK5Lgi6k8FC7L0WQrNFsIRpkD8GSuopMc7njgTpXuRcmGSeri1S1ADXhdHJ
         87YALectKjjH+Sp/Zxpms6dMYCf8VJ0WmIy39GwgQipD9m/66jiPu+QdMBZQGWSMqzgc
         UgcoH2gfLsTo2ZQACZkHnP5b5S5WR4tlXGKBZ5rkGGzRFq5D3spsK+FSryHtXhXHGsGj
         Dm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9oOs0PxskGic5/b7RTQxcSk0/t3lEcqZGj07P5otHq8=;
        b=kxFOWjeqJq6pjc59qaLAGsfEjmiFgZNGNBSmDWiU8G62IYGZfMqTgxS178lWIn64g+
         PtWqbxMWuqoYLIMH1H6NZu6ZqYej3f66qkUhZ6th6HYiCVAx3gbEKU5xIWROGKoG5NMS
         k7NCEArfQUGuPGcSlanS7Rvqu8jCC8W7Zp9mQ1EYHmhf5OJvSgapmx3UcVnrw9oodtme
         D6fRn/qFMOFsHpDJdzNK/dr5QG7c8VFO8OH6OrfKthCNaYxB4GeODuWeEVSemHfKVMcO
         9R+KQ0L0SedMjrlswLu2hcfeAykrYBJhwrAVVSMYfOCt7f/FbfHfIVlOdo+hYKG/SlEz
         r/xg==
X-Gm-Message-State: APjAAAUESCy1X7HxzTfoWzJmo49JQxa+8r9kr2MLwa9C7zN1IUvP5luo
        RAIZ43Oal8yWpdOgxs1SUFis9A==
X-Google-Smtp-Source: APXvYqyCJHRGfPuE7i7mQ60SXgUVFTvJNFmajEQIQuHvG/1GR5NKyMsxFJSfrXyyjMhagJamkQOUCA==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr6615078pgc.188.1559271666672;
        Thu, 30 May 2019 20:01:06 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m8sm6991549pff.137.2019.05.30.20.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:01:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/4] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Thu, 30 May 2019 20:00:57 -0700
Message-Id: <20190531030057.18328-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531030057.18328-1-bjorn.andersson@linaro.org>
References: <20190531030057.18328-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v7:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b25c251b6503..978ceaec78cb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1671,6 +1671,64 @@
 			};
 		};
 
+		mss_pil: remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended =
+				<&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+				 <&gcc GCC_PRNG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bus", "mem", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "prng", "xo";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+			reset-names = "mss_restart", "pdc_reset";
+
+			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+
+			power-domains = <&aoss_qmp 2>,
+					<&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_MSS>;
+			power-domain-names = "load_state", "cx", "mx", "mss";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
2.18.0

