Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD487C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A82083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4rNZOWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfB1M2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:28:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52864 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfB1M2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:28:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so9088478wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=C9KTcipBBMH7iKIKkQeECQsP2OoeAr07E1QgLTBcEng=;
        b=U4rNZOWPYk3JdSh5EfKt+17n3fALS6FunIpr9HvS0GEuvgK28pPMANAdGYJWJWGOKy
         Q0b8lh9LFQrjIfGUNvrzsu/gaoJOanYgVGFJGNIUINuX1faSy3a4p2htrMnHxNxmtONK
         efQEjt6GRZWJLTqSRHHs528gzI/0m9aQDhdPT+jDKoNW7ST+yc0oGYrYfLdFlHOiR/xK
         vMqoyJJxIT44R+gBVmyI/fNo8Vx3DTjdUns3q/8VohR6MpG672FCGT0leSYMGIgVuc8k
         nWVLuCJoNDCoW7e5+3Ed8LSfTM5JTxzJme87HELZZ5BAOa8YNnZlXbWb10zcrfpLT+O1
         rllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=C9KTcipBBMH7iKIKkQeECQsP2OoeAr07E1QgLTBcEng=;
        b=VI7seJEMTfWNIO68vrg10vNWIWCcVdtsHIQAKqSxBkPieDgZzR9yC1h6j94B0qb2B5
         mrx1UFNRelw/rl4MmEJ38HBQMj7KCKbL4qj6lEmGb0pDJBxFWhfPvMsKgsjKVygk8FDm
         JtB/5v6k//dJMEkd7iq5+Fam/jiR4T7Db0bxHFlzVfwK82geHMv9CmM14HfPp7QfN28K
         nOQPmbTzowpAp07jWqPRQLO6N6vlPg7FXsnk+aUSkw1y7w0R/BgoY+FqQpjj84UznlU8
         a6MKS5Xg5BPwLaFYYmSwc4SAJN5k6IdRQBfUM+K196QpYFghvKnTeAltFhrx6G1fLejw
         EXrw==
X-Gm-Message-State: APjAAAVO+1WZf5vRpTnxE9M5+TEbH4ayh3R3JQmugvVVwZDdKuPDTabG
        IroQx7jnLUR1B/TCJNOf8sfMon4xSs0=
X-Google-Smtp-Source: AHgI3IbXZvDZrkGk/mg10q/vpJzTiaqCpdBhLTS5+enh4XqQDF1IaZ72/EOAf7N8J5EQ/t4Xap3cRQ==
X-Received: by 2002:a1c:7d8c:: with SMTP id y134mr2914817wmc.102.1551356896073;
        Thu, 28 Feb 2019 04:28:16 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id i16sm15119244wru.16.2019.02.28.04.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:28:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 23/24] arm64: dts: qcom: qcs404: Add thermal zones for each sensor
Date:   Thu, 28 Feb 2019 17:51:13 +0530
Message-Id: <63c4711ea258c557158ef9dd551a1b4eae4038da.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 252 +++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 57d14d8f0c90..8b3ac5f7f2a3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -30,6 +31,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU1: cpu@101 {
@@ -38,6 +40,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU2: cpu@102 {
@@ -46,6 +49,7 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU3: cpu@103 {
@@ -54,6 +58,7 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		L2_0: l2-cache {
@@ -507,4 +512,251 @@
 			#interrupt-cells = <2>;
 		};
 	};
+
+	thermal-zones {
+		aoss-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 0>;
+
+			trips {
+				aoss_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				aoss_crit: aoss_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				dsp_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				dsp_crit: dsp_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		lpass-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				lpass_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				lpass_crit: lpass_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				wlan_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				wlan_crit: wlan_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cluster_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster_crit: cluster_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cluster_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu0_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				cpu1_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu2_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu2_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu3_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu3_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				gpu_alert0: trip-point@0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				gpu_crit: gpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.17.1

