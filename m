Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC23C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0938D2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0Nd48Q2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCRJ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfCRJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:59:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so10323619wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjVBkKsTPRU/Q2eEbXFlLg5kFo5cEHjROJ7k0lYdBTE=;
        b=0Nd48Q2DZOWGKmW6OW1yTxm2aw4rIPbyuIFcDQE91ZJNwI8qsZP0JyweVN/WGi3uMo
         UcbYO6qUzlHiCmoGWYNA3AkPep0/bAjcPDLOwyCH6VmStAT5a0620eWllujGc6eolWVM
         9dnGS/4AgJn9AsJs28oTA1AtuYv1PNxYD/yazV2wMqrmNT9OCKMuGsROA6mIT8XkB5Sp
         RZtKpEMV7Ldo4r69JztYU8jpLoiLu6d2MUyreeQ6Rj2EeDzrF9BVHPvqUskw3pibT5M4
         uJwN/aq6tT/ooRnAqsJJuQ41NHWC4wyTAoYovD6riAmd0Kw+MEVt6tBRvM1coDH6yQYm
         WTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjVBkKsTPRU/Q2eEbXFlLg5kFo5cEHjROJ7k0lYdBTE=;
        b=i2eQmHlGVKLKPZNV3rRMOYmclC9Euus6Df3GNjX/nu7im37neMb44Y2vluequfvSfb
         4qAxvgFqI7csvwBi7loYiDPe88CNpWX6Ur7vqXdK6Imwo2ybeWDiQHG4AvB1t5E/c1qD
         JY1iPC8+ExTHWJ0uxImIVsa7/1TBHYDMK0ckRauTcMNJjpAhi8fvSPaGNnJMCUyplwMi
         AcC46u/yuMJ8J/i+ge7Od5fdMp4ui6l5jF3hxX/v17EnryNuQjn8BPQH5hLa7nBHBowS
         oa8fOBxPH3nWZfJHpif1lgVzvhKSBpar/KF1ybE26SsFoQuLHK649uKAS7hdHISwTbQA
         /RFQ==
X-Gm-Message-State: APjAAAWgtkl2YiXShFYSqwDjNmHjR7wMBuRkyIOQoChQfkYtm5zRiQVT
        6hkcom+N0UPnW1VnJMCmMeQZmw==
X-Google-Smtp-Source: APXvYqygEds8OM/Uu3G+2DFWP+jb/8sLRUfA0eTXcpWrTRmfAGHH4feF9X/2x97pubDm1W/5bO+bxA==
X-Received: by 2002:adf:e487:: with SMTP id i7mr11071619wrm.202.1552903142703;
        Mon, 18 Mar 2019 02:59:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:59:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: meson: g12a: Add mali-g31 gpu node
Date:   Mon, 18 Mar 2019 10:58:51 +0100
Message-Id: <20190318095851.4062-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
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
index ce681aef8d5b..05f0f06f89a5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -421,6 +421,33 @@
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

