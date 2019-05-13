Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B8FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2920850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M21k49y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEMTan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:30:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40472 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfEMTan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:30:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id h13so9939655lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PDEUjjOBUJS5iHQaBAG+Z33WI0zFNAprAtoJyuCQ0PY=;
        b=M21k49y1eNn330/lF5JvreEZChjrS2M6ynm3TqPbbn/Q9xiZAzxNCYtv/EuxrqqtMM
         QGsNsvmFxgy9sSC46EshhJEpWH5Pz4ZTv2l1DCMYxEhHs7XqE1HQbPYe5KlbUPpZoz1u
         CROTIRFp0MmW7feCctSmkdf9rvOLpD1AHPnKXgEBya6wH+hN4dttUD8c/NIeoCMp+8G5
         7LZjDpnxdIB9RSMG00FALVcyBAhvnwEyA3AsG5QE2IRgu2aE+wNxXs4Clt22/rk1KpRQ
         w4c/YO/4ShYOv7C674P9egAkOJOTIQ8CMoR5T4g9Bnk7vkufWL1z+GXWXR2K+l22GP4M
         zUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PDEUjjOBUJS5iHQaBAG+Z33WI0zFNAprAtoJyuCQ0PY=;
        b=bJq26zCjlSdZhMXSw3/7Mmd1Me53H64weJbDjudolM8ibfopWDzzGaGxcPFXro1Boj
         4lnfCCzTUib/y9Ap1+JOGeHa6AkareIdc/UNrRjk6urn28TafGut8kYZcBbLXco3h+IS
         10KdwZUFyjRCrfZnrox9NuGhACplUt9W26ifqhUb6uwD65kzlbNTVhyCZ9MrN8+YiDiu
         ZaMqc+oH77DATUJWnRFaT7/NLWsU3z67HKskYdyLn0NJRh7GfDQ+/fnRzFqF69n9ednl
         ztA6fMMuwyQ/HNJYfWts2qPz6JJAuwJsLOwIoEFnhNA162cgRk+FEqNQsxqTyENEC5V0
         YYYQ==
X-Gm-Message-State: APjAAAXpE6ZBKQ0x+2WIGoo/S6uL6mWYmSu4PRINH0mdE/q+H7UcsVTr
        7FK9Swt0JlM6f9wYr6kUPhakZg==
X-Google-Smtp-Source: APXvYqzkkltCyacB6OrKhqu88JBHdO9W+dZpAtceJBpmMRPPTu1skXnjUWJRxuUbEzEFar3+9FUfjQ==
X-Received: by 2002:a19:e002:: with SMTP id x2mr15509153lfg.16.1557775417282;
        Mon, 13 May 2019 12:23:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:36 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 17/18] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date:   Mon, 13 May 2019 21:22:59 +0200
Message-Id: <20190513192300.653-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

In the hierarchical layout, we are creating power domains around each CPU
and describes the idle states for them inside the power domain provider
node. Note that, the CPU's idle states still needs to be compatible with
"arm,idle-state".

Furthermore, represent the CPU cluster as a separate master power domain,
powering the CPU's power domains. The cluster node, contains the idle
states for the cluster and each idle state needs to be compatible with the
"domain-idle-state".

If the running platform is using a PSCI FW that supports the OS initiated
CPU suspend mode, which likely should be the case unless the PSCI FW is
very old, this change triggers the PSCI driver to enable it.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- None.

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0803ca8c02da..1bb33f0326b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -110,10 +110,11 @@
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 		};
 
 		CPU1: cpu@1 {
@@ -122,10 +123,11 @@
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		CPU2: cpu@2 {
@@ -134,10 +136,11 @@
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		CPU3: cpu@3 {
@@ -146,10 +149,11 @@
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		L2_0: l2-cache {
@@ -166,12 +170,57 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-gdhs {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
 		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
 	};
 
 	pmu {
-- 
2.17.1

