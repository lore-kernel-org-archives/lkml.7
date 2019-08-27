Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95E0206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yt68EfZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfH0MOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:14:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36979 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfH0MOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so13641990pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pptHIxhK3eUIONZUZXLRgUgraNH7ZHKiRKOOZXId9Og=;
        b=Yt68EfZ2pCFv6y3gNY6s3zwZ4WSXntxsFOa47DjhNzOsV1J5zO/oWMXCCM4ziZopTz
         bc59P5UcoHPyCzi8fpT3YV0x8Y8a9xopYAIppMf0Ei5huVhnE/riO5bgNckL3Lc/tu2E
         ibzWAufe7k3bLbA3nFAaz6IiNjcoh1dSxIr1vja5R5iKFcCSEVke98SjyUfm4yQmHgsL
         fW34Jl0um+NvWqv2+ew8nSypw3pPLE70fQXXZEuaKLWxhzYUoaei9XyypBgJ89dre9CI
         qO3nXzc/NqrNtjkAHCVo2hp3/8mQokN+UyXXdqAJCEf8u8epkU2/7YYUTaOcAtwCW2sF
         NIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pptHIxhK3eUIONZUZXLRgUgraNH7ZHKiRKOOZXId9Og=;
        b=saBWK8hJpfiKaytnkechx4bOxIg9yUp5FCIiid9SC9DnIdKxR+Bn3Uix9RU1r5aw8A
         2tWb6vdH1AntouGuIqYQu74yq83jltUFV+gy3pGZdEiuSI+hxSGBxz2ht/wkNjrTGpkT
         aB9MwvWTcqjO+9yCer/de7hFWan9FkZc7mEKhKHr6V/EYl0Xb4znJThW97Rq/mb+haxL
         qThNR2NsIL/joTIiQTjaTZd58KYbSr3l75MAzDTMNoKZcl2oo9Jaxn/FHn7i2kzaxO6U
         455XzIu/wl76W3PvqbftC8OwePdyT0LC/ThJRmW4C8wNmYVJwGZqw6QteMGrZNNnRoA/
         uY2A==
X-Gm-Message-State: APjAAAXC8MgX7alRKzLeEdnPx+2mIF/RW8R1/rrrOceaZISuMI10X6jq
        GJwHU+SoHlJvK67FQzYFmOdbZzaA9v/SDA==
X-Google-Smtp-Source: APXvYqwqFs89Mvx84AcWAVFxVj9NOaNbeWi9cVrFQYua1OYgL8Er/3O3Nn0U/M+BXMH8RumzRgrbgA==
X-Received: by 2002:a17:90a:2ec3:: with SMTP id h3mr5833943pjs.121.1566908084300;
        Tue, 27 Aug 2019 05:14:44 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id g10sm25108702pfb.95.2019.08.27.05.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:43 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 05/15] arm: dts: msm8974: thermal: Add thermal zones for each sensor
Date:   Tue, 27 Aug 2019 17:44:01 +0530
Message-Id: <5b26d4410b50387fcacae939d97f9f75853e69ea.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8974 has 11 sensors connected to a single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 369e58f64145d..d32f639505f1b 100644
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

