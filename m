Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E84CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D53420882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GB/iNLsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfJUKgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35913 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfJUKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8179783pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cUh1ZeV5zyjcsg3Iod3jbARGXcyJz+PpaHp2DpcKIvo=;
        b=GB/iNLsVk+ApucmOndcOCjbvj0CgYAqzijKY5FGCBUbaN+U/kVWyXWHbkpG7BSggYp
         f6IbuQNNH5x5j+409JsPqM3ZQJarU5yMHogMhB0PyoyaikyLZmvxEEFHMiSBDwnffIZO
         WpvIzsaXwYEBhjSwBfaeE2vmVUoU73KJFSPVsLn90WenyvhMqiwWhbDif/QJuCDnGWc5
         QgXpc2EGiPmug9U5kBGw8Ffwt+Aim18NdbY+U0BbBw/UwfYMUdtjT2C1unkOxVNPrF1x
         db8UIVOYhkcOd4txq4pUd3AbSig2rXuqT4iyIRnPiEhWEDPRWyMaVBApa3utcJEO4DMQ
         BXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cUh1ZeV5zyjcsg3Iod3jbARGXcyJz+PpaHp2DpcKIvo=;
        b=f+pSdhJIEEt3viULTbrMMDj7OWonwNgbckHdje+pOmmyUTTa8f2NAA43Rx4KKXJEno
         +wmEaPeBHWCuBtRgUul4nKab7q6w/vBP2bclAy/SQmEhGxMmbB+TTZ5xKj52n+MPYSi5
         d+IEx34EK+b2Mb1z+QpPeBXBHjHo748z5s/xERJYZx2ICi03LESdoU71OCqKtYFjr7HO
         sKy2NqqXEJK1+QVK7O8X+ezkNDe2sA1T4Isajk27LVqtMC5MBEoMP5io+/Bqep/OZncb
         LdGzyQQpuu7ATF/IAFFYwFFevgTv02Punwvt0RVRxO1RTb9Zh/eDWpdSDIbEhL8rR7+r
         PugA==
X-Gm-Message-State: APjAAAXE5WRUB+4/F/mAM8/JOJcBfXwu1c2PCGHMdKIzXkg4iNijerOn
        eEEKMA23tDjl2X87yY80XmNayf9s1PQY5g==
X-Google-Smtp-Source: APXvYqzu4KtmcnKs1aGYq5s9UfB37tPDNG7pn1yvfavKMydIQjaFEEQUfn6CZX3PmLG1fG1PQEM1CQ==
X-Received: by 2002:a63:934d:: with SMTP id w13mr6975734pgm.185.1571654160053;
        Mon, 21 Oct 2019 03:36:00 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id e14sm15420515pgk.70.2019.10.21.03.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:59 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v6 05/15] arm: dts: msm8974: thermal: Add thermal zones for each sensor
Date:   Mon, 21 Oct 2019 16:05:24 +0530
Message-Id: <72cc755c16888976edea555f1df60a299daa8a1e.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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
index 369e58f64145d..33c534370fd5c 100644
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

