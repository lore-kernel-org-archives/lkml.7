Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EAC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142522C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOd7YlV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGYWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34505 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfGYWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so23437027pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uiQPKHwj11EPpZuRQWpTBZjUd/uUqkvhWCoDYYQxDwA=;
        b=uOd7YlV1/OOkQMJdcCgl8oAUvZobH84I3dUpaQ7blEHEOkHE07y7s7uxV0nagTTRuq
         q+/TPHlFixOUvXsY0FvjBwKRm+lQO62aY6VronZUz2YP7XZLwuTPTFJwdqlC55ASutoA
         dQm/VXAe2/IYPSjkimFXad0hCsBy9HXoU+5If2Assoa8l8tP7c04epZcBHhhWf25zdOd
         B3UzyJdvxULSnoZ1San1Txtsiuu0NxVkVwjmsORJ9lAWJMIte4qpze53IwJjrVgyY+Nl
         nomgCque2ZcK2lkjnEJlj1SvHGb37Yu2tbQuAtMOiQDYdMd8YHMAfB2ekcPrKDEEa4zV
         vO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uiQPKHwj11EPpZuRQWpTBZjUd/uUqkvhWCoDYYQxDwA=;
        b=Yqq700L6jxfwdIhX/aHdyIRUdYc1w1myMi7YVgtv8u59OgU31zECa5Z3QV90duk/rX
         cbnJtNtOscWFt/CR0KoSNnALIPXlRdBPH2tVmijf9/vpFIep4UE3pMCa42EcpfCTv+rR
         WgZDLkbUuNcxqBNMC3oNGqiE9MUIEOVw0W7CIYuG0lu5QQd0al9ErVC5e8Vv7mO0Kcym
         tZ2auDV3XLGCi81x6Gx6pEWPvOs58YxAKGJdyj2Yfk8oIpXYn5k0zh18oPd/dv0HScU6
         3arRmIsWgk1GzMUsnwVxrZF4TdijkroKAWChUUvFFTIEW6F+d6w9pBdTX5e/ljNPP2qA
         gsEg==
X-Gm-Message-State: APjAAAVheYrBsKNTt3z19iGMJkhmg/x5o32qI6uv8NTdGuM+LZ7oNRyJ
        oiogUVCezqsTi9SNeiT62e73aS3DL+WBww==
X-Google-Smtp-Source: APXvYqyOLmezE9hL+lr5a5L7jAm7oojRGUA14/di4toZXjfHwMeg5P/peFoaSrSDPtk8GcsuOxPIfg==
X-Received: by 2002:a62:1bca:: with SMTP id b193mr18389670pfb.57.1564093156830;
        Thu, 25 Jul 2019 15:19:16 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id f64sm53517242pfa.115.2019.07.25.15.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     masneyb@onstation.org, devicetree@vger.kernel.org
Subject: [PATCH 05/15] arm: dts: msm8974: thermal: Add thermal zones for each sensor
Date:   Fri, 26 Jul 2019 03:48:40 +0530
Message-Id: <9e2948528c789225bf8a6ef458b83a5350a7ea26.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8974 has 11 sensors connected to a single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Cc: masneyb@onstation.org

 arch/arm/boot/dts/qcom-msm8974.dtsi | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 369e58f64145..d32f639505f1 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -217,6 +217,96 @@
 				};
 			};
 		};
+
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				q6_dsp_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				modemtx_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		video-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				video_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				wlan_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.17.1

