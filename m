Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B905C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BA23CBD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8iHJaeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfFDQ61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:58:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55482 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfFDQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:58:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 16so804101wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVCO5NdhCO4ClvnqUv2FsN5kOQCRCbVjJWhoMXw1NDQ=;
        b=U8iHJaeNQwgfZyonZpmCY+8eHEAJFzgZQHl4ZBgMB7Ehc1h2CJidpz9etKcpnvU01a
         fdT0yfOUja+9mp77Qt7n0A8kIpZCp5BOm+jY1QG8/1SSyaF/lYSYJkKv5lhQvqfxApcs
         aRvUtwN/SQiwf9Gb3ICSTbT7qQxfw8EzQ4t37U4ioJKeyYm9ZKp68qrJaS5TiPi8HNuL
         Ad2tzh8fiCQgixXuooOSB0jyT4RrTmlzXAAWj6F5suSxrHSkAaLOwXQA6Q8jKbVGsBxv
         l0AZtugD8sTl+zF6170ZkYKO1l5PD79mwoFVwLwixQlwxPFdlkYXrZ5P9WHE/ixvl8vP
         LFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVCO5NdhCO4ClvnqUv2FsN5kOQCRCbVjJWhoMXw1NDQ=;
        b=L6AWbLPOuYRsHXpdjZfd+2/uJuXyozuZzRNwmO28uQMaRlaK4QVOMz2CzIE1S1eipU
         qQlIXlm7lU0dAg/FmkGWQ6xGPUrbEeHIGObu3dbhd+tDrFHe6ScU3j0ShXtm6rSGbBiE
         3+aOo/nGYk8ctZlZDUHbHBXbpNDtGLl4AN/vjCI9Ua6CLsLvr1w7v96LlaNJErnqRoMx
         CX5SNsAC6F6seg76zdVGiv4qv952x4F3tHVlnxCrKtwU9kKoZDqmqZzQQ3jZnv0nh7SL
         z6uSEprSM9g5jdqqWQy+7UuWJu8Nz1rxLOhFnXLJhJllWS2VQHUe+JxdtGwXaS/SpcOi
         v1lg==
X-Gm-Message-State: APjAAAWUQHRO0Y+JmbrlcYOi/E9ks0QNJg/sXJ8a8y0SrqGUnI/goVnX
        48HgBesEmWnIEHpWqbb164l5eA==
X-Google-Smtp-Source: APXvYqyTSxvUapZ02X/hXKoASJXPNOtj9HjRjSK5iLdyKziVYT0pPX38I5nv+gb7+mLfsXpPzGyVLg==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr9346231wmf.19.1559667504165;
        Tue, 04 Jun 2019 09:58:24 -0700 (PDT)
Received: from clegane.local (20.119.129.77.rev.sfr.net. [77.129.119.20])
        by smtp.gmail.com with ESMTPSA id t13sm25524979wra.81.2019.06.04.09.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:58:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        manivannan.sadhasivam@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 2/2] arm64: dts: rockchip: Define values for the IPA governor for rock960
Date:   Tue,  4 Jun 2019 18:57:58 +0200
Message-Id: <20190604165802.7338-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604165802.7338-1-daniel.lezcano@linaro.org>
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default thermal values for the rk3399-rock960 board is
inherited from the generic definition in rk3399.dtsi.

In order to ensure the rock960 has more room for througput before
being capped by the thermal framework and is correctly supported by
the IPA governor, let's define the power values and the right trip
points for better performances:

 - sustainable power is tested to be 1550mW

 - increase the first mitigation point to 75°C in order to get better
   performances

 - the first trip point is 65°C in order to let the IPA to collect
   enough data for the PID regulation when it reaches 75°C

 - restrict the cooling device to the big CPUs as the little CPUs
   contribution to the heating effect can be considered negligible

The intelligent power allocator PID coefficient to be set in sysfs
are:

    k_d: 0
    k_po: 79
    k_i: 10
    k_pu: 50

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../boot/dts/rockchip/rk3399-rock960.dts      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 12285c51cceb..701d5b5fad46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -114,6 +114,45 @@
 	};
 };
 
+&thermal_zones {
+	cpu_thermal: cpu {
+		polling-delay-passive = <100>;
+		polling-delay = <1000>;
+		thermal-sensors = <&tsadc 0>;
+		sustainable-power = <1550>;
+
+		trips {
+			cpu_alert0: cpu_alert0 {
+				    temperature = <65000>;
+				    hysteresis = <2000>;
+				    type = "passive";
+			};
+
+			cpu_alert1: cpu_alert1 {
+				    temperature = <75000>;
+				    hysteresis = <2000>;
+				    type = "passive";
+			};
+
+			cpu_crit: cpu_crit {
+				  temperature = <95000>;
+				  hysteresis = <2000>;
+				  type = "critical";
+			};
+		};
+
+		cooling-maps {
+			     map0 {
+
+			     trip = <&cpu_alert1>;
+			     cooling-device =
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "otg";
 };
-- 
2.17.1

