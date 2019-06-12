Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C2C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86BE20665
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPqruB5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfFLEpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:45:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfFLEpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:45:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so8330401pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nklP3shPG4ODY4LCy558nFWqV2jQgBjX6+qH4GruTes=;
        b=lPqruB5x/x03TcytL7LVzvnmJ+yemBLds1ibUr/mVVzOzZ6w2j2C/krp36OlLbD8yh
         QsJBhhfHx94RSc30x87DYrEs82Qlp6ePW+Q2k1cl3Cy0Chg59N6FHigUHCN1qXjo4YzO
         E9HeULmJlirqarV4/bJbL4ud/YtRa0MVr79nozbJxCNlAhECdlSJn5q2Ff0cD0l0brqk
         BqgRiRPv5iqlvPf1hNFdGHfbzJBGKQ5rW1It33qWoZwNzL+lSmHCiwTtAcWja0MpF37B
         iEBF+WvW2IOV0xub5iNXxw+LN0qiKsdNkUiuV7ADG8nxz1T7GdKU7ETtxVc5qFZLE03x
         yoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nklP3shPG4ODY4LCy558nFWqV2jQgBjX6+qH4GruTes=;
        b=LIHFEjXFFsPdm+F+drY7WjGca6Ef23rdnkUS+wbl/8xTBMloAeJUBpo5xJ+fEGFo/p
         PzxIjsREedSkl5525mGOaQ7N+Op5WrhkoUjHkYFU/iuIGmFiiLCQ61U8bUSmppctKCTk
         bD8R7Zi4uLDRDDTRMGzq4rAmk2342UeAXbfcC6ZYqVJHN+egDAJwWeMyr5HLtY1Nv2y3
         iqvRMmiTKF8aL4eFZNQld9fdo1vscEPtLa9qDUhjlM9K/eGD8CuijlZm9o0yV0LFmIjy
         PIhoQhsKCLIjmFDdvxdg9kJWiogCD5MMx8yCm2R1Wu7xuOkBCes+NQeIeYEfK5u4Rajd
         e4cg==
X-Gm-Message-State: APjAAAUM6q89Xqe8gZd34gYfACSTfM5YLKXx43fxuh0wUjAwI870ZEuG
        vrJXlujx7D4C8iuF1wprkFOb+KJs63U=
X-Google-Smtp-Source: APXvYqwFBdGhHcjeVlfocEKbR9j58n78JNQlwypjDowu3shZmxffhL57NUrwLladwD1Gq2ifHwsVfw==
X-Received: by 2002:a17:90a:22c5:: with SMTP id s63mr29977778pjc.23.1560314743008;
        Tue, 11 Jun 2019 21:45:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z126sm17129194pfb.100.2019.06.11.21.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 21:45:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Tue, 11 Jun 2019 21:45:36 -0700
Message-Id: <20190612044536.13940-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190612044536.13940-1-bjorn.andersson@linaro.org>
References: <20190612044536.13940-1-bjorn.andersson@linaro.org>
To:     unlisted-recipients:; (no To-header on input)
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

Changes since v8:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c80881309f79..601cfb078bd5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1850,6 +1850,64 @@
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

