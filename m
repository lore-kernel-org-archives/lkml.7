Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF8C282DA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B721721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="OWGBqZjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfDMQyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:54:37 -0400
Received: from vps.xff.cz ([195.181.215.36]:49238 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfDMQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555174462; bh=ZOGzdottk2RIleoufnn4ifjkGAGSzeCzkeoCu7y/pEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWGBqZjc/8/KoY6E+eSWtL3ZZ54ewioajB0/Vu4xWQ69iY3uxz6wDs5lUdlnGjHbO
         j0F3/iVkUqz46L4hop0GXcArJC7xd7cyuy3DrgYpVLJheF317eYFapi9Ygg3zAXhQJ
         EaEaqOBu0z3X4rcRcfBRw0p/Ak1xjzU/GLQIjSNQ=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH v4 9/9] arm64: dts: allwinner: h6: Add MMC1 pins
Date:   Sat, 13 Apr 2019 18:54:18 +0200
Message-Id: <20190413165418.27880-10-megous@megous.com>
In-Reply-To: <20190413165418.27880-1-megous@megous.com>
References: <20190413165418.27880-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

MMC1 is used on some H6 boards we want to support. Typical use is 4-bit
SDIO interface with a WiFi chip. Add pin definitions for this use case.

As this is the only possible configration for mmc1, make it the default
one, too.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e0dc4a05c1ba..bd37b849d3b7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -243,6 +243,15 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_pins: mmc2-pins {
 				pins = "PC1", "PC4", "PC5", "PC6",
 				       "PC7", "PC8", "PC9", "PC10",
@@ -294,6 +303,8 @@
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.21.0

