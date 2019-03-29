Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE512070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4nMLi7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfC2KM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfC2KM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so1882029wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F45uud4f8fCAV227MMD1FiQHOuaHoLclmOUA48d6Dsg=;
        b=Q4nMLi7WinqfW+e3zNC6pCmXvHOvzW+FEuU/N51o2fP/bgvyBuzOmHuzsRp18JDLmr
         QFCpV16GYJWzpgFiETFix0SblZeoqll96Ix0itKTWDxx4AUxVBLglY7Z1vHbPmrZfKH7
         20cljgIWJlH5FzAKLw3tRe4wsd+3yAklz99DOyfsCqMUJP/A3gKqW4edb6C5g00Wdg3D
         ArGslNenT+9Dl3ogBDeqC82fVI68fPbTAuEZADMfFUlevcOtYXZ0aCyGpjLZcq3dSASs
         cwG7mGp3qzY3IxhJqyUX9eWLPJa1b2iAXtyAIXksHaTld8LMcofp10mFsz4UTtTdVWGy
         1Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F45uud4f8fCAV227MMD1FiQHOuaHoLclmOUA48d6Dsg=;
        b=ZjIVL9N0/X/fa8q7LlKahUzmE1HM6YXnruz6683H+StFdYYhKq+b7+buqQ9zC9a5nx
         cvOfvzBQKvCnYMeNrpxpGMA26oWhYIMsJAn4Y4pcHUR5Wop73ymYGP00zn935WOiAVJY
         hwbWgPYZx+ugOxir7SBY5odcesCLflTCSPnNqFziuo5y1XHDMx4j97UGJ3fYW9iA+rY4
         HrKWfBwcqfQhE/7mGu6kbydGLt0aix9zeBpgsC18GoVtDFrcRcxkidQH7KixRI+lvwvZ
         FRmR1ufuD50PgDdob6QwJF+RZBO93gkOvFL92oYvW1akP6tRhclfDPpQAq1ovIqFtkd5
         lNmg==
X-Gm-Message-State: APjAAAUBj8L3K1TBIJud589Ud7eL7yT+8XMeQkvCP2giQrj+3YwjIhZ/
        /0B58IpZirC6eKzOL6+Sj6lQQyHucgA=
X-Google-Smtp-Source: APXvYqwUTz97GlzEWljX6BocTLRDnfNXr4iJ49cczQVQxpV82tFKqQuFG6QJxfIyKj68wB5pjo80Qg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr29314802wrq.176.1553854373296;
        Fri, 29 Mar 2019 03:12:53 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id y8sm1720955wrm.8.2019.03.29.03.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 04/13] arm64: dts: msm8996: thermal: Add temperature sensors near major peripherals
Date:   Fri, 29 Mar 2019 15:42:10 +0530
Message-Id: <ad459ca0cd9b2e68787a4bd76ec3e0a677ce3b31.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8996 has a total of 21 temperature sensors. Populate DT with
information about them.

There are 2 sensors on each of the cpus - one on the top, the other
below (we only expose one on the top in DT for now). For the GPU, we
expose both, the one on the top and the one below.

Depending on the version of the silicon, sensor 2 is either placed near
the L3 cache or the venus video decoder. It would've been nice to be
able to be version-specific but we don't have DTs that differentiate the
two versions of silicon yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 150 ++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c761269caf80..e2408ee91184 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -237,6 +237,156 @@
 				};
 			};
 		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
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
+			thermal-sensors = <&tsens1 7>;
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
+		m4m-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				m4m_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		l3-or-venus-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				l3_or_venus_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cluster0_l2_alert0: trip-point@0 {
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
+			thermal-sensors = <&tsens0 12>;
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
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
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
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
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
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
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
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				modemtx_alert0: trip-point@0 {
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

