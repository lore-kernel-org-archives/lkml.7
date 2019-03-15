Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F401EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5454218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qdgV9tOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCON5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:57:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38460 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfCON5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:57:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so6127638wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox5dhzmGa/6JQDhw+Y9moNKLx34n2K2pj1pY4zKasYU=;
        b=qdgV9tORh+lf/4sku7mYCbPT/s6p04k67zrHnrzQJA9aULYXbshCXDV4v1DhJzqhov
         1CJ6CFvTv6K/hd7gDmUPwYQZ7Ys2Uli/T1dVdn5ijxoCybkpOIjY64uxxrBLbDNUD+GT
         hgnJjEYETb2QuxHjza7tGum719AM8P/rBtMHUvdwCNh/Pp/LXqX6wrRDxOJRe48ZMHkU
         TTq6elMdoDBW9MJTYr5E0TLt8krzW0sTwPjM9CPIdfpqOKnSNs3ejOfLH3cGpP13KL8h
         d0UZKgEX5h8p6GNFfsJ3ynA4RAQ94fJy3OrwATDUx1/35JeBwc/fzA1VxGNfwtoBK5Vx
         uPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox5dhzmGa/6JQDhw+Y9moNKLx34n2K2pj1pY4zKasYU=;
        b=BCzKNeFFQOV6DN1ViXdKD+VbvPE+k5SGt71PF5Hx5GPi+GQlflOwWJFvkF0lGjf/g2
         JLQZblJ5z6p9IVx+j1qyZRLIIRadOFaXpgf6Jms+lpNwm5soLj/jg2Z7Iqza6zWHiL+e
         4pvV81m+RZay8aMbJc/njZbLxwIdjOgAMIiWH3OB9VNrLUMK+lP7W2Pep2mYBxVwOzHe
         Q5FgRvnQwCFE8lUWhMKQD12jnAioc9glAuaYBj1KIlKyr+1E3FefQqX0Zzn8GQQ5WSjM
         9Go7M7xnrLtxSfumUmuSZZqzcOzxhWIx5sArilDcDjrK/+6o6bq1RsTkBwwaKX4mQRA5
         8VdQ==
X-Gm-Message-State: APjAAAWQSc54IA2j0lM2rtbDXECam0NhlTVS//djtVqZfJ1Q/WhTJSc/
        jfqFXmrrLIV/5MefSx7o3RavbA==
X-Google-Smtp-Source: APXvYqwIQoneCKa9W32nALR6Tj3GimCywQ1qdcByeYfBG/0A4RWS2a3XeyPEe0eLTiJg6DWQRGfehA==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr2217652wmh.122.1552658220950;
        Fri, 15 Mar 2019 06:57:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a14sm2131900wrx.96.2019.03.15.06.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 06:57:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/2] arm64: dts: meson-gxm: Add Mali-T820 node
Date:   Fri, 15 Mar 2019 14:56:55 +0100
Message-Id: <20190315135655.28359-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315135655.28359-1-narmstrong@baylibre.com>
References: <20190315135655.28359-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

The Amlogic Meson GXM SoC embeds an ARM Mali T820 GPU.

This patch adds the node with all the needed properties to power
on the GPU.

This has been tested with the work-in-progress PanFrost project
aiming support for ARM Mali Midgard and later GPUs.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 247888d68a3a..35e59d390903 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -91,6 +91,33 @@
 		reset-names = "phy";
 		status = "okay";
 	};
+
+	mali: gpu@c0000 {
+		compatible = "amlogic,meson-gxm-mali", "arm,mali-t820";
+		reg = <0x0 0xc0000 0x0 0x40000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gpu", "mmu", "job";
+		clocks = <&clkc CLKID_MALI>;
+		resets = <&reset RESET_MALI_CAPB3>, <&reset RESET_MALI>;
+
+		/*
+		 * Mali clocking is provided by two identical clock paths
+		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+		 * free mux to safely change frequency while running.
+		 */
+		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+				  <&clkc CLKID_MALI_0>,
+				  <&clkc CLKID_MALI>; /* Glitch free mux */
+		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+					 <0>, /* Do Nothing */
+					 <&clkc CLKID_MALI_0>;
+		assigned-clock-rates = <0>, /* Do Nothing */
+				       <666666666>,
+				       <0>; /* Do Nothing */
+	};
 };
 
 &clkc_AO {
-- 
2.20.1

