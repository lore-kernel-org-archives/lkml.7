Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA455C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD65721743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/jtMfdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfEUQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfEUQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so19305076wru.3;
        Tue, 21 May 2019 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=B/jtMfdcj/dmaTXVPTvxgNcwlKCsgqy9ZhcgBVcfw/M8F+FPXVO9xN/dsc8qjR+qGX
         wlT8gSuqfvPrYaFZO9iBZFczHY0DerEBjxIaTywINIhQtH4FH+wv19g2c5/kWbwmQtJT
         X2Z1EZJr7BLY9iXwP+T4K/wju0vwaB8a6BNRhraKUMsnEOuxptYmFWbk6dvX8lJSc9sH
         vq8tf5kmrs+CVMIdAsHJfgaFAsnHwVKuXD2M2XhWIse8GTOBt+S/JoylD8jY/AfQkmAo
         2E6fSN28+1qgWz5XWqDSYu9H6l5NyiG8hDop7DeLyGEiP9MydI1kne0gnBENOh10PhDc
         8OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=J7ZAidd1EArBHoNFY4MDL1bUO/sFEmmFIi6vUmR7nmzJPOAzyaMRteYMbW3hcF2//o
         SFqJaYl02E/8IIFmvyxo1mxWbcK/nUI2Vl9mmmEmUoGnPjvtaOSliJEWa85peqW/SvH7
         UHrF2+mp0i9dBudFXEkqeAex3CKdjPvIF+ciInv82HqFZigomL5GrbrphUHBGHZu4MpU
         HPN90XnYbXw964/nb7AySdgz4Z1QTwAsBfFM6j+ktEAmiSxgQ45cRDdQ6pTrysbCLyWk
         wxAaIgVEPBP0UGHkRMCXpEvHiCTS4cWMG2u1nzNBZjlM0v7dNFwv5ljnwZcGRwirWa24
         /qSg==
X-Gm-Message-State: APjAAAVDRc0+EpGlGHwAzmh/rdk3zHwjs4dwfqRixOPO+mjDdui82YIA
        wfn7dEoBPBFOZU7zWPfu+tY=
X-Google-Smtp-Source: APXvYqwVGxivnAT1rOZ1NLI0pVzHPTuwtsi/68dewsIH9xOuVl2rdWSn1rWNqkO1JUH72ACvEdzDJQ==
X-Received: by 2002:adf:f811:: with SMTP id s17mr19122623wrp.72.1558455074155;
        Tue, 21 May 2019 09:11:14 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:13 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 5/6] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Tue, 21 May 2019 18:11:01 +0200
Message-Id: <20190521161102.29620-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..6aad06095c40 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,20 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.17.1

