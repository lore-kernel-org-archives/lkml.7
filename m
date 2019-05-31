Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F7AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A02635C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVaU2Uk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfEaDyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:54:20 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:55228 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEaDyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:54:17 -0400
Received: by mail-it1-f182.google.com with SMTP id h20so13557882itk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kagssQd3QuWugHezIJ6doapoPYga+HnLQRv+8NMyX9g=;
        b=aVaU2Uk/PSvFOR2ZTUEkpLv50UR082xEm5HsKlrw7QgZckzEHtXA7yO/Wn/WOBbJvJ
         Dc+RwCg9LLpK+kEt8JnxklzRSCovp7PitZw296lYP8Jd1UwgpjL6wVVrUTMb+9Bc9n+N
         t3Maw5oZUPapO1nFVOsnDqMKzA6i4fmK+kL1wanbzG8ogV628MK9QBHGEZKqK77sc8Wg
         gEHiQzbr0xcVtCqK6elbQQ1PkYtX5ZPymVlQtCfCogAJWOQT7ZhIg+V/xQd8Q9pgDbYZ
         zifSkJyuzPAChGKjgwm6JomDh11WZ8yM0/5ykVmjJzQLsMFc391cvHSKIpBnUCPJl/x6
         CBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kagssQd3QuWugHezIJ6doapoPYga+HnLQRv+8NMyX9g=;
        b=XG2O495XXv1bvkCZc9jHWsxpSBda4KDVpcSi7G03CfiAzfMNKRB9EjvIqyBXt/EUrk
         FQoCa9qSTF2QtxUnmsK4vBRn1hnRIdngbZu/sP4MkwG8srr9LR8Z2IA1hFwNLOkLSV3T
         nu4LoYXx2Fw0/i++/MQ8SdkzO/OOOXeh6YeaWmqhpe/kLMzaHb9+jawX9w70hn9MFnW6
         2rPYwUeB5Ug4uCoA8Gwx0UBoz1GRiRE6mGxD4/Lmc8YiAUQU6XBQfDETA2OoGOgCcm7n
         aFoy8Soym3h2kFoRH5VbY9MUNXBdBec9OO+K7pSE5IbRXY8ouWKPD/qOjRdOH0pcCNcf
         aX3A==
X-Gm-Message-State: APjAAAVdutHjcqnkZUigJoVfWSqILA7Ga+86vZOeZZMbdWmuX4/6OmNW
        lqLR0l3MFi9jGyBmmZspV2mMww==
X-Google-Smtp-Source: APXvYqwU/ZRoDGo6axXL+D8tg1NufQkmrF7bSAtLkJC7p296STpfjSogYdgLZwKpdUbt2XAzDoRcpA==
X-Received: by 2002:a24:5095:: with SMTP id m143mr5427071itb.68.1559274856806;
        Thu, 30 May 2019 20:54:16 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id q15sm1626947ioi.15.2019.05.30.20.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:54:16 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 16/17] arm64: dts: sdm845: add IPA information
Date:   Thu, 30 May 2019 22:53:47 -0500
Message-Id: <20190531035348.7194-17-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
References: <20190531035348.7194-1-elder@linaro.org>
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
index fcb93300ca62..985479925af8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -20,6 +20,7 @@
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -517,6 +518,17 @@
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
@@ -1268,6 +1280,45 @@
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

