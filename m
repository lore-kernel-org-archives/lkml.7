Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E5BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3AD21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YoxYoVPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfENLPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54741 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfENLPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so2423307wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH/9jGUTYqNchbklGeod/jCiLtawhcosDapSAft/y/g=;
        b=YoxYoVPOitJltIYLqd6dVcVS8kBc0olC0nqpmZOXI1okxviKNcCGelSEGL3srl9FuR
         8teYFRzjPqEKQKvo45cx1QF6GxMcOazu+vkGdD6bhVzvFL2+BBmtFwB04qYdijZ5bfZz
         0QHCQZybDoT5YyNXgZepeTbECSU6pyMyrVciLByz5PWOqrGtfgLwWpUEUySccnOMdSqj
         vt6kaB5r/q12Zys9C/bGNLiErKd3vmSuizSacJ3/X988PKeHdvj4OkLv7WIg7Uhe8MsI
         ZoDmSRsm0zzeUoaO9ZwBWkOR3eZTIut2jHmpvhkxuv2peJK1dwY3R/tG0ArjJIA+C2PC
         VCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH/9jGUTYqNchbklGeod/jCiLtawhcosDapSAft/y/g=;
        b=bPkAWXNr6ZBEGX5MVRlYZzDAKj/ZXnZ9UxQIwU3ta6O8eoemxQqY/2a8Z3Rj4tInNo
         Mh96QW1fE2tceB5+4RLWLQ9E24iIGZi4k3ISblcuuyzSzTQDrflr3cgWzWV06vzq/3Jl
         rCKN5Kdz1Zr4FaZL9e6sbC7GNNSOo3q4Vl7wqZp2KUw4Ma89bItsQtXf3tydjpicH30I
         2Q5QRYRqWcpuIkAHudaS2Xs7lxYSoSRembWQyi/2qipbJ+9WpeR2N9x/5FR8/K69is1a
         6gGK0epnWDtarmokL/qJvxzIkyA+CQ9NSMbg4uZ8nLmZ2kAOX9QyMXxRO2ASmHPmfkO9
         h2ug==
X-Gm-Message-State: APjAAAUW0PRwlcRX3P6R7BVK/OB0c6yCuTH2jxsPgmJC8JoPSXnzyZMt
        YotQRYc2U3UD6qJHJsTwhpOFlQ==
X-Google-Smtp-Source: APXvYqyFXBhASQ7s2Rzi8oOTabzfkeNhlmXxwFIUALwnaLudgCnEC7/4EHYWhhjH2bC1IexA/KblNw==
X-Received: by 2002:a1c:eb12:: with SMTP id j18mr530763wmh.48.1557832518385;
        Tue, 14 May 2019 04:15:18 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:17 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] arm64: dts: meson: g12a: add audio clock controller
Date:   Tue, 14 May 2019 13:15:03 +0200
Message-Id: <20190514111510.23299-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the g12a clock controller dedicated to audio.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index e6c0c19b3223..09aa024d9f0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -673,6 +673,42 @@
 				};
 			};
 
+			audio: bus@42000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x42000 0x0 0x2000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x42000 0x0 0x2000>;
+
+				clkc_audio: clock-controller@0 {
+					status = "disabled";
+					compatible = "amlogic,g12a-audio-clkc";
+					reg = <0x0 0x0 0x0 0xb4>;
+					#clock-cells = <1>;
+
+					clocks = <&clkc CLKID_AUDIO>,
+						 <&clkc CLKID_MPLL0>,
+						 <&clkc CLKID_MPLL1>,
+						 <&clkc CLKID_MPLL2>,
+						 <&clkc CLKID_MPLL3>,
+						 <&clkc CLKID_HIFI_PLL>,
+						 <&clkc CLKID_FCLK_DIV3>,
+						 <&clkc CLKID_FCLK_DIV4>,
+						 <&clkc CLKID_GP0_PLL>;
+					clock-names = "pclk",
+						      "mst_in0",
+						      "mst_in1",
+						      "mst_in2",
+						      "mst_in3",
+						      "mst_in4",
+						      "mst_in5",
+						      "mst_in6",
+						      "mst_in7";
+
+					resets = <&reset RESET_AUDIO>;
+				};
+			};
+
 			usb3_pcie_phy: phy@46000 {
 				compatible = "amlogic,g12a-usb3-pcie-phy";
 				reg = <0x0 0x46000 0x0 0x2000>;
-- 
2.20.1

