Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB0C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0305620850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iguEcn8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfEMT3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:29:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40221 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfEMT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:29:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so12077216ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7AxPd/WiAkEtzi6eC4zcfxrPuKGzl2d+dQ6Z4/Ng9yA=;
        b=iguEcn8d2UHmA1BdPS+ybI3lkwBDS3Ab7tjgLTOWKG6wZ7qEdUTtbHKOqgM2Pnvm4B
         Xofw8r8SJPdY+sJxTtVFiOGqhI6kONaT2HlWPLlUPTFxNHUtX5OLL4bifccr+S/yXa3L
         1874f/2ZGLG1PlPpnMLUejT0OAYu+L+O/+Tjquwfhc9n4SfDn/aZgcGK8cGVd1V0uzUf
         PPof97i8Xu9/kDaXfsu5Hm2b0l3KZKU/pEG+zdRjUSm4VqyLizf/dMOcOLG7wEsnVQ0t
         p+FWaZl+/zA11ABliZ+oXMfD7J1aEnNIpgO0Q9nWUTv9CRs6+XpZ0/jLRxkxzf+u27O2
         FmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7AxPd/WiAkEtzi6eC4zcfxrPuKGzl2d+dQ6Z4/Ng9yA=;
        b=MM+ImOkF3BBW8TqS4WaH5UwobIBswLXZpILiEdAFuZUJcVC7dMLSwVb6/JF0S+ipJi
         cCJR/lm3iyS2Z1T/JBljzr2Ivkptjuv4f+szhktkDSOVeLDyUQNBfPmYjtG3/wAC1Vvu
         8z1Zf/zLyUscb1pH6uF8mqUUpp9AO0UFU3tXW1dVYoYNNwUle/JLquUck1dxRXeAi+Rd
         9bkuhph1Hmgm1QlS9W1rjff+kkGNH17gHX/x06iCwt3dLFgWlPLwwmmuYT5/HCahWRxI
         1mPrCpI+v5KEaqiQ2uecl9OXyV2Q2KbFzJPNdMxXcSmdxMI6ei8GuBx/vGeRxJNe/sdX
         ikyw==
X-Gm-Message-State: APjAAAV5YkuDbfrNIJSwhsyJrdz/2FxSxOguU5MgntV63wl+15jQn/AW
        52/RZTWGE4U1gEGLr0xg1MJmXw==
X-Google-Smtp-Source: APXvYqwxMWB7/4WyFA59ijUF+6dp1ja8lpTuNpIG+hVBnaOO/pbLdkkOZsUgbqrpPxXYczj1YuOnIA==
X-Received: by 2002:a2e:309:: with SMTP id 9mr15762950ljd.114.1557775419346;
        Mon, 13 May 2019 12:23:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 18/18] arm64: dts: hikey: Convert to the hierarchical CPU topology layout
Date:   Mon, 13 May 2019 21:23:00 +0200
Message-Id: <20190513192300.653-19-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the OS to manage last-man standing activities for a CPU, while an
idle state for a group of CPUs is selected, let's convert the Hikey
platform into using the hierarchical CPU topology layout.

Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- None.

---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 87 ++++++++++++++++++++---
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 108e2a4227f6..36ff460f428f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -20,6 +20,64 @@
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD4: cpu-pd4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD5: cpu-pd5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD6: cpu-pd6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD7: cpu-pd7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CLUSTER_PD0: cluster-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP>;
+		};
+
+		CLUSTER_PD1: cluster-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP>;
+		};
 	};
 
 	cpus {
@@ -70,9 +128,8 @@
 			};
 
 			CLUSTER_SLEEP: cluster-sleep {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x1010000>;
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000000>;
 				entry-latency-us = <1000>;
 				exit-latency-us = <700>;
 				min-residency-us = <2700>;
@@ -88,9 +145,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 		};
 
 		cpu1: cpu@1 {
@@ -101,9 +159,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		cpu2: cpu@2 {
@@ -114,9 +173,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		cpu3: cpu@3 {
@@ -127,9 +187,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		cpu4: cpu@100 {
@@ -140,9 +201,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 		};
 
 		cpu5: cpu@101 {
@@ -153,9 +215,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 		};
 
 		cpu6: cpu@102 {
@@ -166,9 +229,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 		};
 
 		cpu7: cpu@103 {
@@ -179,9 +243,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 		};
 
 		CLUSTER0_L2: l2-cache0 {
-- 
2.17.1

