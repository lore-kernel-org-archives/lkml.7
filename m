Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F9EECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6738320873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHQTggvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfJPHen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:34:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41268 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733052AbfJPHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:34:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so13751493pga.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N1sFZqwPmR4rpLnTH9EOl8Ec1vu8lx2vJgOvXRwWkdo=;
        b=nHQTggvoUfAdmuLIISJfzQD+E5MdYiRMIJMZhsaRyVJooc3Na6gQvHL8n7SYjjZ6wr
         HacXvujAglqyTWjGUDxGzUEeDyCh6z7o+6VceXISis/Ik5gJ5jn6r1FnZiGxjfI+X603
         i/Fgm6YM1XcAl7XVQ0QbisND0p7J4xB0MZTTgkhwH2q4pploc79rciwHb8pTFgspqMac
         q89VeCtNrikU1tlUyyXDFXK/1AA6wQRfjr51H8oVtfUJ9WLHvB+8+v8pPucUf3iNjohO
         V5QI5nL/N58L01MA7oWhRVM3rLTH0I23adq8XWtwe6hBqX/7iwPy3xFTtSVUq9t1qL6W
         shHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N1sFZqwPmR4rpLnTH9EOl8Ec1vu8lx2vJgOvXRwWkdo=;
        b=oZlnRNlFQqByOdm42hH2AorFul0aMxbmzUA0OzdrUeYXfuR2NhdWodzIgSrdN+INmw
         P8B76P2LPe68J2G+6bNSnpSh7DmdzcqWup4assXwS15GtymC9NxLd0PQhwTeRaZW/Bz1
         iOclYXFNEGq5vuPig7cLusrE4Vvsc6AzhLM+sNO7Df8rYVBU/PKaO8VSQ6j3cIkQtdT2
         EOFO8T0zsYMSW4qYf9KEZ/UwYQh31k7z6bcchGzSgrvOfQYu9OEFewp1XaZPvOg0kTb9
         Ev7cIKGAaXVoEE9adP/AfMyu5aHauXF5JTjlX2p5v1ja1SuO0QfrMIAtbj093Cgmod1+
         cxaA==
X-Gm-Message-State: APjAAAWxRW6EwVfjFaCSDETUiUM/WXna/0hbxggFDLMAjfZXsucpD1Tj
        0TArGJtLdSs2ot35M5msG2+7367e6heCYg==
X-Google-Smtp-Source: APXvYqzbI7MOcYzohhn5F8MgUPZtpPBx+xG2u+Ec32GKe2sHF+YG5Eu3VXng0EV25WKSSG9R8SGBDQ==
X-Received: by 2002:a17:90a:ac06:: with SMTP id o6mr3233009pjq.133.1571211281067;
        Wed, 16 Oct 2019 00:34:41 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id p190sm29052416pfb.160.2019.10.16.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:40 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 05/15] arm: dts: msm8974: thermal: Add thermal zones for each sensor
Date:   Wed, 16 Oct 2019 13:04:04 +0530
Message-Id: <72cc755c16888976edea555f1df60a299daa8a1e.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8974 has 11 sensors connected to a single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 369e58f64145..33c534370fd5 100644
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
+			polling-delay-passive = <250>;
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
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
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

