Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A549C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829621473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wkOdjC3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENO1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55678 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:26:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so3099200wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH/9jGUTYqNchbklGeod/jCiLtawhcosDapSAft/y/g=;
        b=wkOdjC3PU+m4vMRNuxaV9tMM7OAiptxtSi7DTbZiAxVF+9ux1XzAMwFFmVvERR7Rq7
         bt9y8cyUqzNTV6GkkB1tCoKiKSeiJfGs9YzGhF1tIIRZg7ccslM6YN9+tb01CG3srn0b
         YZpm6/l2qoV2MNjqlzTNOGWbjByT8B64XBmVPI//QM/574T5w8IrXmfvWmBnPZEQe3Vk
         xCqXpmQNKf2k4aAqfVSoqQ6V9VnZjFe+zY5+PB2Aa+nt/Oq4+jLjXwdQLOxVfzIpSdab
         XEWo8v60lEwmwxPjxqFQ1NubMbI/RyrHCVeII8LNpEX9XnfLwLnyJoBxp8kLkpqG7ukK
         bLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH/9jGUTYqNchbklGeod/jCiLtawhcosDapSAft/y/g=;
        b=RVZ6o6eu+fC1lLSV192oSiPUZd1fNq/0nzLMgjlDZv116HvRw0JaZDWq7P2f+Yb/0J
         cQS/4p17qw9njV6FYWDZyVWGbcrwyhl3t1NEgMEdGOA57w5O9uXOspWu0fPfaxFBAa2r
         2TChewpvMayjiiC5TTpKP5E1K0rXWDtTAymzYMenjyOH0R4/50EdQAvvSK8tAZrrO4ys
         ZU09dlK3VJWSwCtpLP2+dTWSNEpbXm2eXxbaNG+uQwXbhRQZN2SGlvMA6TdXjjUQ9Cp9
         AVMU/AGA1jDpTDEvqOsQf+3m3e+5AyPPf5GpmSNRJeP3lQ29NZ7BxtVz23Fuk+XoILLi
         mN6Q==
X-Gm-Message-State: APjAAAUujEoDV4vQ/a6Y+hqFO7srGsV0JZdlqlIXKc3s5BVKnX/DlbKk
        qHMe3w7RGcUEClvQewyL8QGVZw==
X-Google-Smtp-Source: APXvYqxK2UhF4PI66FD0zC96shlHSfEZOFlJbdtlZnfhsSFIV83NzKSf2mcthfJJcwaSS5XULg5Fuw==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr20372013wmo.93.1557844016377;
        Tue, 14 May 2019 07:26:56 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:26:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] arm64: dts: meson: g12a: add audio clock controller
Date:   Tue, 14 May 2019 16:26:42 +0200
Message-Id: <20190514142649.1127-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514142649.1127-1-jbrunet@baylibre.com>
References: <20190514142649.1127-1-jbrunet@baylibre.com>
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

