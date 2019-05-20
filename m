Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E52AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222D8216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMN/Oml3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392687AbfETRBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:01:44 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:32962 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392639AbfETRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:01:41 -0400
Received: by mail-it1-f194.google.com with SMTP id j17so427979itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qokhmyg9AkiB7tKMWMX8AGwwTlpK4uMhtkgK3NBAxgg=;
        b=kMN/Oml37u7vJbRpOT0j2yTOznwnEEooNyxt25SS3DcSRXTuB1xPm0P7e8vbR20kre
         LT8ziTh1f2zXBnsymYXwKEQ3FpYPOvslMACY7YqTwRwlNJ/edFwO+SiIjkhMWNGqKUcj
         fp/rHmkPpnAylQNQMEAa4u2Vi0qYh0nDsHqXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qokhmyg9AkiB7tKMWMX8AGwwTlpK4uMhtkgK3NBAxgg=;
        b=Cp1UbqTBje6TjYOcZLd5g3c2fJf8C8QPQvXpEA2hxAlqk2PHgDhYWsL28QlrTB1K0H
         SznSABxAKWxNYiKXrZg3x0ouqPyOFum6P/WmRTVulIg6l3tALqhdfNcLIQ/GhYXOTdWp
         j+OHtj0Bt4M0Rwd2U7c8tJSgB/JrjYkEI+817qdCtoSPqK2fqrkbqCgvbQMlmrn2zItQ
         j8GYYm9CB03r9bttIJodM9XeMbCs1srl9EgDzPIZesaPsKTSgzwEVSEi+f1nfAtWlPPU
         u0O3DAzneWpicKqvlDFv90xiJDQiyNPDAJ+YWQgAb8zWRcJiYEeZ3MvWc9XOv/wuyEYY
         rOFw==
X-Gm-Message-State: APjAAAUhtsst0S1OqmlEnFW1rAEPl8dCihck/vSo7hTVxSU9Xx4YOIs5
        GjuWP+UuRAuWquo1Ud1Tnagqv5r4ilE=
X-Google-Smtp-Source: APXvYqyHAk2xbHN0WR5VjQgADInV80IQzivFF7mpA00fOKKjAmpbUTNHpk3Rj+5wPik797i+kj5q4A==
X-Received: by 2002:a02:c818:: with SMTP id p24mr3087274jao.100.1558371701136;
        Mon, 20 May 2019 10:01:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s4sm6118340ioc.76.2019.05.20.10.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:01:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] ARM: dts: rockchip: Configure the GPU thermal zone for mickey
Date:   Mon, 20 May 2019 10:01:32 -0700
Message-Id: <20190520170132.91571-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520170132.91571-1-mka@chromium.org>
References: <20190520170132.91571-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mickey crams a lot of hardware into a tiny package, which requires
more aggressive thermal throttling than for devices with a larger
footprint. Configure the GPU thermal zone to throttle the GPU
progressively at temperatures >= 60°C. Heat dissipated by the
CPUs also affects the GPU temperature, hence we cap the CPU
frequency to 1.4 GHz for temperatures above 65°C. Further throttling
of the CPUs may be performed by the CPU thermal zone.

The configuration matches that of the downstram Chrome OS 3.14
kernel, the 'official' kernel for mickey.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
---
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index f118d92a49d0..f0b83afa2a60 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -138,6 +138,70 @@
 	/delete-property/mmc-hs200-1_8v;
 };
 
+&gpu_thermal {
+	/delete-node/ trips;
+	/delete-node/ cooling-maps;
+
+	trips {
+		gpu_alert_warmish: gpu_alert_warmish {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		gpu_alert_warm: gpu_alert_warm {
+			temperature = <65000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		gpu_alert_hotter: gpu_alert_hotter {
+			temperature = <84000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		gpu_alert_very_very_hot: gpu_alert_very_very_hot {
+			temperature = <86000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		gpu_crit: gpu_crit {
+			temperature = <90000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		/* After 1st level throttle the GPU down to as low as 400 MHz */
+		gpu_warmish_limit_gpu {
+			trip = <&gpu_alert_warmish>;
+			cooling-device = <&gpu THERMAL_NO_LIMIT 1>;
+		};
+
+		/*
+		 * Slightly after we throttle the GPU, we'll also make sure that
+		 * the CPU can't go faster than 1.4 GHz.  Note that we won't
+		 * throttle the CPU lower than 1.4 GHz due to GPU heat--we'll
+		 * let the CPU do the rest itself.
+		 */
+		gpu_warm_limit_cpu {
+			trip = <&gpu_alert_warm>;
+			cooling-device = <&cpu0 4 4>;
+		};
+
+		/* When hot, GPU goes down to 300 MHz */
+		gpu_hotter_limit_gpu {
+			trip = <&gpu_alert_hotter>;
+			cooling-device = <&gpu 2 2>;
+		};
+
+		/* When really hot, don't let GPU go _above_ 300 MHz */
+		gpu_very_very_hot_limit_gpu {
+			trip = <&gpu_alert_very_very_hot>;
+			cooling-device = <&gpu 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c2 {
 	status = "disabled";
 };
-- 
2.21.0.1020.gf2820cf01a-goog

