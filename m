Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998CEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C45F217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="majRNknw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfEJLaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:30:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJLaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:30:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so3069973pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vxbRgWsY1oo16QVLjuEv5vJpgQAg02SeRW3oIPG3HnE=;
        b=majRNknwjCIZzqzc4d0Qf2KSDJ845oaJmYikIf4x95USXpK3heltnfr/FkhqZSbUmt
         ana31GB2FZ8yw+s/CDGOcaOCH5BHAFXcd8a+1Kcilsaw6//0LMdVHUFxbg46HglF+CR9
         3wWEOqDB6wF8rhx3GwNkhimtooLej6PLUxYeFE3Gv86wzEFK1/6/7us5axHAJiTBIZoW
         kS2E5JQDU5Vsptjpgmd8jHgwsuxhWISp8jQNa2n+R4dzvnJ4SUCkPrRb4xNlGNwtX28H
         7DxtEBuj+qnU4BLWf2oD/0J5HThB4cE2N+IQVOhutsNC4VKx6pDfoSd2NKp7ZnnlqdZC
         6ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vxbRgWsY1oo16QVLjuEv5vJpgQAg02SeRW3oIPG3HnE=;
        b=K+TPyRcTm2NcrpnU+fcBeJUgHiZFBvUmMWljaEjoTy6Z4PF7iKnbUyahCcHinixr2H
         Onelcv0bqCMPlOm7LW5HelnYTXjMqVA2kxg1oaMbeFVjWOwdOo+XrCfYmSBG0Y6vpvvP
         w6BpkdZSoWxH71oc1Pqa3Ww2nKivPeRVOUjVQbkFsNwSoG9lxdFXLNrHKQN3WY9oh1z3
         iSFedmuVlAkzFtwIEoglisNS3n5oV/Tooo86CwOuAeQCntnXZaEP6bhR0DYgMVbCUMOG
         L2smzkOYQrbS3OxJIjTMcKcIiE/esEyGiVTHkdzQdil6HYoERXvgsj+Yxdf2Nu0xhhOA
         9zHw==
X-Gm-Message-State: APjAAAXTKvtbY3alUMCfxEUtzkbVikilF0prcUKxiohiyc8t6J3a/Ir9
        +BD2pQKQ3t6USidBXHhkk/s8B44Jl6A=
X-Google-Smtp-Source: APXvYqwdIL0EfbSiX42k8sFfKHDlMcLhJWYsKHWyAGukAhP0HaiNos3zWxVtyEdlTTDwwFC01VQdGg==
X-Received: by 2002:a65:6496:: with SMTP id e22mr12758716pgv.249.1557487813185;
        Fri, 10 May 2019 04:30:13 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id q80sm10840463pfa.66.2019.05.10.04.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:30:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCHv1 5/8] arm64: dts: qcom: qcs404: Add PSCI cpuidle low power states
Date:   Fri, 10 May 2019 16:59:43 +0530
Message-Id: <d3a517b90620fe167eb9fd27bcc88a43dce514b2.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

Add device bindings for cpuidle states for cpu devices.

[amit: rename the idle-states to more generic names and fixups]

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e8fd26633d57..369c59c35bc7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -30,6 +30,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -38,6 +39,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -46,6 +48,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x102>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -54,6 +57,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x103>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -61,6 +65,20 @@
 			compatible = "cache";
 			cache-level = <2>;
 		};
+
+		idle-states {
+			entry-method="psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <125>;
+				exit-latency-us = <180>;
+				min-residency-us = <595>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
-- 
2.17.1

