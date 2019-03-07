Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E118C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2D20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R88ieLyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCGPOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:14:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37477 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfCGPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so9542604wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmcKckFFoMcjeya15ZmDQKDKc+LuZwnHpbF6leSa7CM=;
        b=R88ieLypq4ahZHl4Hz/vkiNMGbHyglkQCCJ5MG2kcH/UTsHng7NZbOiIfgMHym0cnG
         u4lMN1tj+jEdL9JkpMTOQbQmHpd3dDFyQ7wDZbgjfCpVCbp00j4gH5RPxDfDQNfrzpLt
         6n0E/RYSlHhdAvH1ys2B6yJQ2jMuPSzN5djjlx/YGRUHqeYA982SL8lEQ+pFGWYOF5z3
         J55GT6KlkUTitEotrsOytI6ARK1OquHUFJ0o1I22Ji1DrMIF7tf5BJ8mo5SAYrMDpdc5
         cO8MByqVfyPfI8jr82qPSpsOa2x2I+GMEk/KjtTwegInJ1xa1qr26rcVZtrP9qN2lAFE
         Feog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmcKckFFoMcjeya15ZmDQKDKc+LuZwnHpbF6leSa7CM=;
        b=M1kwH/HwFiOgcFeEgmxcUbD9Yc15YIe9ncB2gyBc9MDjvPtlogwMZqmtdNYOvSYBv6
         lYeq3uCm4wrc6q8DybkycnTcK4qCXFOc/tRckwfyWl8wOq/OoqfwYJPVXP1Gzxi1bk4c
         SCs6eH6eO5p4zi9SizpS9hbkhrxT9ORughFDNG+l2SDaWuJB10mRS0pL856OCSU0VrgY
         6xCuy7HwhgLwNhuthK/G/6/Lua3qTey27kFZzgI/98jo/3MOgopkoVqB2lfUs34KSAWA
         TrOMUoKCHMH8UPm1wH3xcQWrG1fbGqNQX6h9v203sjgO7zHTNemH3lzBMKZnYJ2gdBAy
         IZSQ==
X-Gm-Message-State: APjAAAWrFgLqloSfwa7HlRxsDBvUbKhJjy+Fj+teMK15Vb67uZ7Wrgo6
        HvheRT2XW3KLULXZI+E2IN73og==
X-Google-Smtp-Source: APXvYqxSlBK/CV8ggTc1nVlXI79nkBo7btojOUczdtNPu3F7Hj96Dipv0Fap+6ZNAh7o9KVT/Lswgw==
X-Received: by 2002:a1c:6506:: with SMTP id z6mr5902373wmb.153.1551971630737;
        Thu, 07 Mar 2019 07:13:50 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:50 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: meson: g12a: Add mali-g31 gpu node
Date:   Thu,  7 Mar 2019 16:13:41 +0100
Message-Id: <20190307151342.7381-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ARM Mali G31 GPU node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 991883ea023c..bd2d9379dcb5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -431,6 +431,33 @@
 				snps,quirk-frame-length-adjustment;
 			};
 		};
+
+		mali: gpu@ffe40000 {
+			compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+			reg = <0x0 0xffe40000 0x0 0x40000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpu", "mmu", "job";
+			clocks = <&clkc CLKID_MALI>;
+			resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+
+			/*
+			 * Mali clocking is provided by two identical clock paths
+			 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+			 * free mux to safely change frequency while running.
+			 */
+			assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+					  <&clkc CLKID_MALI_0>,
+					  <&clkc CLKID_MALI>; /* Glitch free mux */
+			assigned-clock-parents = <&clkc CLKID_FCLK_DIV2P5>,
+						 <0>, /* Do Nothing */
+						 <&clkc CLKID_MALI_0>;
+			assigned-clock-rates = <0>, /* Do Nothing */
+					       <800000000>,
+					       <0>; /* Do Nothing */
+		};
 	};
 
 	timer {
-- 
2.20.1

