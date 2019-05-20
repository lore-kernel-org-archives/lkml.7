Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EF5C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DCD216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ANP+z80r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfETWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 18:01:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36768 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfETWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:01:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so7353513plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3Nfs/DRidR4E+JraOJ0QC9J7vTv8+QYMg2eI3k8SAk=;
        b=ANP+z80ryOBxlhAoD1NQiuq5KGhSBLK6TIAyvMuecyDwGcEkfmwOXtJpj+Du/vSJ2j
         AoChR4T/+6F80fFzk0rvnVB/EIndYuxLal4f8cCiaqLe05U0GduzYmbOk8ojE8Pj+Wg0
         NIMYtysotE4SUuLRlDzMUmTxAtNV3uMR5Rlss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3Nfs/DRidR4E+JraOJ0QC9J7vTv8+QYMg2eI3k8SAk=;
        b=mkMhq/qQ96Gj+cqcFsw0sDQ26vNmWHKrncXM4uJXzK5mMyKVvULfHOTVifNH0Hu9Lx
         HLXRi5UKDC/DSFzfEnbXe4U/RjJk/TcST1Dx/nW2X/xanq9YfkwqpWvznKAhmL3tX8U3
         chQACGPaV/JbOe8LA/QhB/hvBsJW0yOVooHPuf72BYFeVE/mUTKtyJEUZJpcRQc3awAq
         /QrJOINevaD/CBmEyoP4EZViXyqyW0bYikd+jFT7G+AN95OSy31uXVgSFaBONI/M2sOR
         xIDOU5kg525GpRw8rYMGJc1I3w6QUHa8v44fM7vsSr2cgkKh9yYHijIDmIvYRpm00+zS
         DWaQ==
X-Gm-Message-State: APjAAAVn231353TVikY8kes8DBT2vu/5i5OYbLq/ARlwwvZvxnFHKDSA
        IpSsD1PARTCHf/nj3vWdcXiD+g==
X-Google-Smtp-Source: APXvYqw+HZyUvC1Bqlvj8gcVb1cFFjSgW7AgvPr0buTJwsw1fzt8o6bbctJfe0WWJvLhJCv64ngozw==
X-Received: by 2002:a17:902:c85:: with SMTP id 5mr4274125plt.172.1558389661271;
        Mon, 20 May 2019 15:01:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g17sm8484562pfb.56.2019.05.20.15.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 15:01:00 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] ARM: dts: rockchip: Configure the GPU thermal zone for mickey
Date:   Mon, 20 May 2019 15:00:51 -0700
Message-Id: <20190520220051.54847-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520220051.54847-1-mka@chromium.org>
References: <20190520220051.54847-1-mka@chromium.org>
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

The configuration matches that of the downstream Chrome OS 3.14
kernel, the 'official' kernel for mickey.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- specify all CPUs as cooling devices
- s/downstram/downstream/ in commit message

Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
---
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index 34797abe3403..945e80801292 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -136,6 +136,73 @@
 	};
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
+			cooling-device = <&cpu0 4 4>,
+					 <&cpu1 4 4>,
+					 <&cpu2 4 4>,
+					 <&cpu3 4 4>;
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

