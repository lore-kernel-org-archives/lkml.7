Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtKkJn0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfC2KN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38592 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfC2KN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so2108917wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=o2Wp7eKMAG4NFM8Fr+KWAR1FMJdBJukeKveTGM8Z088=;
        b=ZtKkJn0ihizrjTT7FNr+XopsRNpLa3tJ1EfFLtumXB84bZiVCbZdDVJoQ0qgLNo1mA
         Z8+z3I9KCxStiq6vRmlbjzNXcc7u3impVlUE8tk47D1lfd7Sp0TBcro1KXJ1MYGrb1F4
         SiTnrK9yJ588yPLN7ag3L7pIcVbIjxlTnqJ42/NZECnkjN/aZKEuZP1JjFKBkGqPOC02
         W9bPlAcyxPmkpr+MT5OnkokkC+jqM3ScYqTqr+yUGUKB9tPlWGD12eWnO7UKVr+hP88/
         cbwtNn10RVhvpqW+CfhyQWZGikj6JOYXk6KXBHC/LvaX4pf0CssDBWQKKkV0KTMlECH1
         tszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=o2Wp7eKMAG4NFM8Fr+KWAR1FMJdBJukeKveTGM8Z088=;
        b=k3C1geIyAjiLMt2XmKFLf203TcH7bCnERQexBo8RI2r4QBSqM2U0Gsz20BKee/xfFB
         T2QAjZ7el9rmQJfgppZk2/vpr00pBo/C38Z2qcEbATardv6hZPLCN8ak8fgQ0DimicOC
         fJV+n1ATK7rLrDM3MjpWTDgDDcW/2vg/gXFfr9/QDFgG6nbjP5QJlKqLoN9yssdPUIDE
         YHlzTgToE5wEPkmC+VHAgYr5gIvZmXoQ6gyL92p33BwaxdEpeNyQI0POfFOpwSEGkPg6
         R/XucTSfi709VWWW3d8e1I/alCtq/8A1zYVjwGCRchmmhhQiLxH4Itq5N93OxCtC9y4/
         p+Cg==
X-Gm-Message-State: APjAAAXamONacszpX1NQo0RtHHZnHTQaklCFZgGziYy2WvoZ0VwobbTu
        yaxj69UFj2nBST32bztidf9BVA4RoaA=
X-Google-Smtp-Source: APXvYqzNIrJr4lTu6aUmyOR9TTjGKS5XrktPzmT8YuIxcoc+gdI3kvLT+8T0L0Q2iI9E2TzwtBwKzQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr3041939wmg.14.1553854404056;
        Fri, 29 Mar 2019 03:13:24 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id h2sm3025684wro.11.2019.03.29.03.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 09/13] arm64: dts: sdm845: thermal: Add temperature sensors near major peripherals
Date:   Fri, 29 Mar 2019 15:42:15 +0530
Message-Id: <19d3a2e99cb5ebce63e5cd1e604d71f8a919828a.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdm845 has a total of 21 temperature sensors. Populate DT with
information about them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 205 +++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..7c0643ccef18 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2611,5 +2611,210 @@
 				};
 			};
 		};
+
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				aoss0_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cluster0_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster0_crit: cluster0_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				cluster1_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster1_crit: cluster1_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				gpu1_alert0: trip-point@0 {
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
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				gpu2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				aoss1_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				q6_modem_alert0: trip-point@0 {
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
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				q6_hvx_alert0: trip-point@0 {
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
+		video-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				video_alert0: trip-point@0 {
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
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				modem_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 	};
 };
-- 
2.17.1

