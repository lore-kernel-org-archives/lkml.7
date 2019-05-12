Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D620DC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83E92184E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inYC9kKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfELBZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33991 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfELBZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:54 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so10781443itm.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHRmV7yhtSWQbIFA/oMwKk8g276jL1Sz3uKi1jWy/30=;
        b=inYC9kKQT2zZLFQjj9yjgmT6loR3m5ScDdmA670i9cD7AVrEI68Q7s037mEDlCjODd
         QPYAOf8k5p4av4/ump2SBqlYlo6scjXApT0zEeJ1VXEdYPvET9jg4naxg2REbfBC96el
         M/cf46haKHbF20wuzlSLPUFgMmpruexsfE+q0N1rF1dLr9JkA2dbbwBT5PpLkEqXjb0N
         /biFzLSgOo2TFWIQGiWZvZ5IWnGSDgw+u5/sSgPpId/oDY2QLLGOAEFWb1UVXyODPe1R
         jicp3UWv6BL4bdUMfEdbtPx/e40Aw/qIAtGwAUrqZ6pNvvLbAP3X0M3C/GojEevDLCA8
         w57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHRmV7yhtSWQbIFA/oMwKk8g276jL1Sz3uKi1jWy/30=;
        b=Mzq7PqPzozF8pJY5AS1MWMjU7cMFjRfW5dC+AZfKgQqrwp6nZWZ2UsO6DZmqcGbkGB
         Fa/fcVBUlifssd4gP16SsVIeDid4csx2lca1yzVvWoK7ujsxJt5rj5G2wPLVJYPCeSW0
         qA2/8UcqoI4GT7vSUn5gs/RQZrXfmg4njHIKLkNTIFskSL0TU3hEK1VGsNc2IL2wBKf3
         ghdpjX+epLzChqF/raGb94Z0AQaBRM+Xt17nmZAM+Hb5jK71YGqL9ujqmcFND6+IR2QR
         cdvFmaCQIEfml4Lp9b6rma0WQwKUiEyjK7UjsjWI+g8gkyF1yhjbRrqJQ5Ew4P+5PHBY
         eZUQ==
X-Gm-Message-State: APjAAAUOdvyUr3slUQaP0vuoV2T2uOS19WhK3Ekdgykn31/GiSYLsdH1
        Zmgt1zLF+HWggFNPxuGzibWI2w==
X-Google-Smtp-Source: APXvYqw/lTTqibE0sJFT0USzQYgt2KgmXhcumESovS6B928dyKRnfmZphdi62DkP2cIUjtAvrremPg==
X-Received: by 2002:a24:75d4:: with SMTP id y203mr13005033itc.142.1557624353765;
        Sat, 11 May 2019 18:25:53 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:53 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 17/18] arm64: dts: sdm845: add IPA information
Date:   Sat, 11 May 2019 20:25:07 -0500
Message-Id: <20190512012508.10608-18-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPA-related nodes and definitions to "sdm845.dtsi".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..b8b2bb753710 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -342,6 +343,17 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	smp2p-slpi {
@@ -1090,6 +1102,45 @@
 			};
 		};
 
+		ipa@1e40000 {
+			compatible = "qcom,sdm845-ipa";
+
+			modem-init;
+
+			reg = <0 0x1e40000 0 0x7000>,
+			      <0 0x1e47000 0 0x2000>,
+			      <0 0x1e04000 0 0x2c000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended =
+					<&intc 0 311 IRQ_TYPE_EDGE_RISING>,
+					<&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+					<&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					<&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects =
+				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_EBI1>,
+				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_IMEM>,
+				<&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_IPA_CFG>;
+			interconnect-names = "memory",
+					     "imem",
+					     "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0 0x01f40000 0 0x40000>;
-- 
2.20.1

