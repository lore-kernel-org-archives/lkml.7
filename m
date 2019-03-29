Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D067C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1CE2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwfvFzt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfC2KNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfC2KNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so1887252wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4WP7vJpVKRp4mAy2lLrKwHicvrn2dHrj30KYt06Ejqg=;
        b=HwfvFzt8WzHIRDTIuZ5svJlx/Vl9TO7GcKcruimTKRHJmnsLIZ69awWsY91wPokyYV
         HR7XGUH5V2ih3tAzX9UmYrB+yWh1bJen/kGRRVHuV1vP31iZIihdwOnRlsPlgPARDwSg
         YAaKXKXCBRLdxkr6Yvnb9drh9AEF5NR2yrMUUQZZQ86IMnWCE9a9qYS1Q37t5KfpDJ2R
         oj3pMR7ACboa4xPsVTQvKqVPRF8jEqWInoVWClXup7rHXEJC/z3AocRvGHRHOmpE8O5b
         t+7EjQUCmwAQim/YU2s0Yr8do7+e5n0VqoYy9M87M8AmEPEMBEcqJk5BuNtwmQLX6mUJ
         8muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4WP7vJpVKRp4mAy2lLrKwHicvrn2dHrj30KYt06Ejqg=;
        b=mKx41923JsLirtrO0nVbplODx0DuWQ+0/VyRANyCZPpimOtleNMU9KQ5YH1nUvumWU
         OrxbXhuDMXmHV8agBUi1hKepwSI2Dc4YU25hCV6K8FJocX8kjbx5fyd6KKLQB+VMKgHd
         EW6dtGdF1+9xn1pyzNDEAMIFuLCKQ7cFXgD4wMbN4NtceSMb/rVHZrGhnMelnQEYYArn
         yir0Y94PYaUyf2fyCYqwyG/UZQyEZAViFbiQAtiSCGYqvqs2an2huoM/wLGIZY6YKq9Y
         T3LARx7KZMBx7WOvI5V4IuDhZ7XpbEVuO7IxDGyyI8tanAmOe1Kkmn0FyQKJeib+gaHx
         D7Pg==
X-Gm-Message-State: APjAAAUw26aGgrwcrJf6YzxjLtU85CJcTgAopkRnxxhBD8YJ74YqBw25
        eqHVz79rbAsGXbI2b1NznN+vdg1ljuo=
X-Google-Smtp-Source: APXvYqwCtehYs3FHKPi0HoOMQLG8kd2Nd7Yx1AadsOuhqNnRkAI75cCK97Jsw/YEvOtcFZ8J1Fso+w==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr19580004wrr.59.1553854397857;
        Fri, 29 Mar 2019 03:13:17 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id s10sm1836419wmh.0.2019.03.29.03.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:17 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 08/13] arm64: dts: msm8998: thermal: Add temperature sensors near major peripherals
Date:   Fri, 29 Mar 2019 15:42:14 +0530
Message-Id: <e1915567fcf7544475584e91d2fb39424cb2bbf6.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8998 has a total of 22 temperature sensors. Populate DT with
information about them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 135 ++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b368da235663..26e476078cb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -535,6 +535,141 @@
 				};
 			};
 		};
+
+		cluster0-mhm-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cluster0_mhm_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster1-mhm-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				cluster1_mhm_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				cluster1_l2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				modem_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				mem_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				wlan_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				q6_dsp_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				camera_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		multimedia-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				multimedia_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 	};
 
 	timer {
-- 
2.17.1

