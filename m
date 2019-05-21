Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F48121783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Li1LAeqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfEUJft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:35:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34096 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEUJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:35:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so8186323plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5A+pTqqd2a8qNgMyuAo19hoC6uwfhm1K0BZ01QSlkgg=;
        b=Li1LAeqGN84eOvubvgAiBnWgkvR1sH2n04p1U7s+F5KAuHyopqI1mgyYP/Z1gR0utg
         qWnXrUWyJ6sA5LHbd3b5vK/eOix0UCh9F8M6q8TYBds3HV5fQViUNTtpsFQkuLhhBLWC
         yMdS0A8pWvt3+DL17SifU4lg8BnZQDh5aVmENDpGUeP3KpmEWIpGb7KMXRxozDHyVEYz
         H0tPFa82HnSlUxFbNvmjcrbfNkmSVnbMu/VHibJz+fiKjnAxwBfCEWvI0UCBV2B+RWYx
         dLT4+OTT/zAbwf9nem1zZquQhbszyJCNlsY3ycnW/U4+GIA+hGZF+fLZeGF+GWzhvFoI
         PUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5A+pTqqd2a8qNgMyuAo19hoC6uwfhm1K0BZ01QSlkgg=;
        b=Ud7yiDupwiN2syvWrB2qjR+xJWUylgTyWiwYD8LQu0FTME17dj2bl5VFpNjUX/3+NA
         mLJOkSYZMT0yJZYFfYw/55dNwt4SOd7y2djhJZSjN8YMBCo5DuKGuP4pXYf3tEQq1R7l
         H4qIbhO94+Lhao/ZcK9w9+djmByI4JRPMLPZXTLUTFp6OLSa2SNvf4yDKqng4BKDTsBl
         Pz2ve6YzeFMOGL6gebtjxfF6bZDyQXre6/2k+1XuBHYVxJLKAevDoSALmeCbU8C3N0Pk
         w6VRAGWvSjDntaI7tXNjvm/AucjOfafEumZsHcOVQLwA+1kJnMhE9qUe1EyWcImhtJbJ
         kGDw==
X-Gm-Message-State: APjAAAW6QVXJnvnNiahZsdt9mT3yzVSnqkP9QO02EDZr6I1H2Q0LzIg5
        Z4j2tHCiUgc1LurxtE1GJbIipJc/I10bFw==
X-Google-Smtp-Source: APXvYqxhZKSf0oefmD5lcF436NYFKqqDQ9XbrWG0Qo6Gc3vfpp4dK6MoVEODDhi/EAvMjsMQc/Y+CQ==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr81926147plp.133.1558431345798;
        Tue, 21 May 2019 02:35:45 -0700 (PDT)
Received: from localhost ([49.248.189.249])
        by smtp.gmail.com with ESMTPSA id 63sm29430016pfu.95.2019.05.21.02.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 02:35:45 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        niklas.cassel@linaro.org, marc.w.gonzalez@free.fr,
        sibis@codeaurora.org, daniel.lezcano@linaro.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 6/9] arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states
Date:   Tue, 21 May 2019 15:05:16 +0530
Message-Id: <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
the same microarchitecture and the two clusters only differ in the
maximum frequency attainable by the CPUs.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c761269caf80..4f2fb7885f39 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -95,6 +95,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -107,6 +108,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -115,6 +117,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -127,6 +130,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_1>;
 		};
 
@@ -151,6 +155,19 @@
 				};
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <40>;
+				exit-latency-us = <80>;
+				min-residency-us = <300>;
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.17.1

