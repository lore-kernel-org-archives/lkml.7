Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D7FC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8238B2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivbrRfGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbfHGSow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:44:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42845 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389158AbfHGSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:44:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so42145088plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IbDDVz7AIYvob9RX49OsdDKJDV+Vvct093/EWA0a4E=;
        b=ivbrRfGOojgPeGQehWsvM+H2yaojSbdm98/KpCKzNDvnH6WagBvNAY+3WDms9j8vo4
         pzdMB6A7o01aVBXLwSgyksmc8auXDgupC9dhQe/0nKqzYwrCGyV+q7R5GDPPcpcdAzkK
         1jc7mFG3yu0O/xjVyxKMhY8qPY+o+5MP1KGHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IbDDVz7AIYvob9RX49OsdDKJDV+Vvct093/EWA0a4E=;
        b=gz5bo6cInMzR/n1CrtE9GPeG8J5PnDhYAQznsiIuagCXi9kyLI/6tmC9fDF+NdZAlH
         GSCEVJhlBPmcflLO/9DJWAgAC44QJ8CKxjUuLCTQiVevglXD0//m08l6RLkmUg9+9niO
         SIsDcyfv5R3Ryj67usFPcUNe7KnZNooPIu9ZOxGsytRKuwKielJ2DoQNTaRMYM5WOWGW
         G3t2EVYNkSgJVtr2vIL7dxeHOLcOPFRs8pRKRthqvNi1SvrhmZAxjNtsjFMT1oNxt0ej
         vJuMTtyF4DWvWhapa1xSsjYyETllM8Hai4RVAMJd42KXBTdiMsvcQufeYeLhCe/Kndct
         A3MQ==
X-Gm-Message-State: APjAAAVmikMM9IPpsgsubmuKLeO4JakOuAJ8IbeGUX3Mfor+uMEVJ1e4
        insbgK7uAX0OJPAPyfd0vT41rQ==
X-Google-Smtp-Source: APXvYqyPo9mJdjvn0x0NHv6/e03SbunwEogzp2cEC7vzJFwflpHwGALnVpplo1Q0DE/O448sW9GX3w==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr9127478plb.114.1565203490911;
        Wed, 07 Aug 2019 11:44:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u7sm83048472pgr.94.2019.08.07.11.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:44:50 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: sdm845: Add dynamic CPU power coefficients
Date:   Wed,  7 Aug 2019 11:44:44 -0700
Message-Id: <20190807184444.248984-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dynamic power coefficients for the Silver and Gold CPU cores of
the Qualcomm SDM845.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
just noticed that this patch fell through the cracks, resending
a rebased version.

Changes in v2:
- added Reviewd-by tags from Doug and Amit
- rebased on agross/for-next
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 78ec373a2b18..12ae58d76f8b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -194,6 +194,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <607>;
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
@@ -215,6 +216,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <607>;
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
@@ -233,6 +235,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <607>;
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
@@ -251,6 +254,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <607>;
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
@@ -269,6 +273,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
@@ -287,6 +292,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
@@ -305,6 +311,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
@@ -323,6 +330,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
-- 
2.22.0.770.g0f2c4a37fd-goog

