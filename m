Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F139C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A522084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fxrp6R8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfCYKDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:03:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbfCYKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:03:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so1650420wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rj9dXO0PSj4zIwHhB+C8+xFo6dIfbTEEVH7yM8XGRx0=;
        b=Fxrp6R8h+NKPanlYEVS38S/Unml0hg3ZHiP5CaA1fDrXqH3pXJaw/FBJ6jgu1P91pG
         1WEjOkcERfhTNiR0A2r8nkQpEc02BP8AaDn673PxQyjzXNNaCOhhc7nRMcfeC4yC00RI
         eUBd69ABkGT6DRagLlq2jDzBkqN9gFsaUVhBKMsKq+ymKMdyQodoctMu27o76SXZysLU
         ur4Off/qD4xu+D564EI9xbMLMWUmZNf9c3XqDyjtjhOZQpC4THpR+oeH02jXavHnm0N1
         tyZgL/R9ShGdS9BD5CgL2wTttBUHA/Pozlf7MUGYa6oURrqcnXSp++pPaHN+h3/bz1X5
         fj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rj9dXO0PSj4zIwHhB+C8+xFo6dIfbTEEVH7yM8XGRx0=;
        b=LYdgteEc/IjI8rFad71QvMbuoa9Fxw8vgDOT0q5C776tgbB+SWaMmjmeanKhXdh8fm
         3iQCuZ3EQrWEluaExQNKjahRVKobW9jp61cRV4FCv8CG1ORtGfJsU2x+3d3SQiRtg/1j
         OmANJUKMA/Hwei6eHtLlDQ7D1f0cdB/vlsrGXVBWfP0rGOIuhmEnDrSc3/V7btwOaV5l
         dLswhZ1N8JQ4xus/m1DRVPrS0Ti5DaloZoUGbpORX2/fyF7CLxtKgUcf2oahkPehqwRt
         j1bI8cqpJQgRp8xgqGo/VIYb+9YEilm876GK6jzLSE8w0mRd3cy3aiy6QemKWkyLejNW
         Dgzg==
X-Gm-Message-State: APjAAAXL1q3Yr+Oe1MXn5IqcePDLpWjcVg+ZLGsL5jd+dTPIZx8AVgKa
        7bucNb9pIiyTAZznKkERHGrqeCg65UOTAg==
X-Google-Smtp-Source: APXvYqy04QdQFMmsanhWv+DXKuDLHOz2aBSfy9CCzE/uLnHyaXZeC4TZPvMUcevf9kSZusb/dSr8GQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr14473811wrn.21.1553508225262;
        Mon, 25 Mar 2019 03:03:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm11581215wrw.40.2019.03.25.03.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:03:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: meson: g12a: Add mali-g31 gpu node
Date:   Mon, 25 Mar 2019 11:03:39 +0100
Message-Id: <20190325100339.749-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325100339.749-1-narmstrong@baylibre.com>
References: <20190325100339.749-1-narmstrong@baylibre.com>
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
index a9cd91f033f2..c762e2309b2b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -433,6 +433,33 @@
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
2.21.0

