Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D600C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B97C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Kume8Qo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfFMSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:54:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38964 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbfFMSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:54:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so31735pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxUBHxdyKSzAEkz8czOIEFewVHEPOOsCs5aBdAtPCog=;
        b=Kume8Qo4DTG31GVT3HwqbSf3jX8+J5mtu6SNBDXX4prsKonHXwtLuXX1DCWbwlHeOw
         RHJzfX2ocMubC3vE5FSZ9hKhNTLlI9eva7D8JP29vVUiTPla+FjmevRgyG2Mf2GisNf0
         ujNCTpb7ZdioL8SUWW0FMmy5symxIEKBW2XOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxUBHxdyKSzAEkz8czOIEFewVHEPOOsCs5aBdAtPCog=;
        b=lyOTd8BFOzB87t3vMhmt9koOEjCtCueS/0xVHmEagb7m0m7EoRA+ts1ax6/wxSdDUN
         AfDI0f3RnnRCD9gqsWXDmyBR/5W3wZT3h7lU2LzC57Y53npdK7rTMA5KPaAQSXl6nlH8
         tDV81rHYSaq+UGymGfJY9OAPDAA/Kr+dnnlayo+qKogmAS1btngS4xGjYZPy4UbiAMpi
         4zBA6kHUmV12Zwfje+ANH2bxy4gGjdrCSAXwB+X6mJpdEUFhZHhKLTLrJxGfJW0a5A6V
         Rqh7P42nichmGWPOGISlIssaDgr+ULKiW+7ba6/RAB7OTQuzC6KqUgJKoPVxZRWnBsB2
         Nb/Q==
X-Gm-Message-State: APjAAAWcH6Ncej05ZVcR2oYU/5Dryrnsy1P9O4r8x4nPTw264rX4dD+h
        Nh37wZFXyLZaX6JA8pKHbUOwNQ==
X-Google-Smtp-Source: APXvYqwk7NSKhbPrQsFpyhC5tg7Fy+h3BJ/6OroJFVaqFFLZ0+/oLQ3lZQhgppFUTYV9k17o5ZQ2qQ==
X-Received: by 2002:a63:9142:: with SMTP id l63mr14357491pge.185.1560452041895;
        Thu, 13 Jun 2019 11:54:01 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:54:01 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/9] ARM: dts: sun8i: r40: Use tcon top clock index macros
Date:   Fri, 14 Jun 2019 00:22:35 +0530
Message-Id: <20190613185241.22800-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcon_tv0, tcon_tv1 nodes have a clock names of tcon-ch0,
tcon-ch1 which are referring tcon_top clocks via index
numbers like 0, 1 with CLK_TCON_TV0 and CLK_TCON_TV1
respectively.

Use the macro in place of index numbers, for more code
readability.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index bb856e53b806..219d2dca16b3 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 
@@ -704,7 +705,7 @@
 			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c73000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>;
+			clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top CLK_TCON_TOP_TV0>;
 			clock-names = "ahb", "tcon-ch1";
 			resets = <&ccu RST_BUS_TCON_TV0>;
 			reset-names = "lcd";
@@ -747,7 +748,7 @@
 			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c74000 0x1000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_TCON_TV1>, <&tcon_top 1>;
+			clocks = <&ccu CLK_BUS_TCON_TV1>, <&tcon_top CLK_TCON_TOP_TV1>;
 			clock-names = "ahb", "tcon-ch1";
 			resets = <&ccu RST_BUS_TCON_TV1>;
 			reset-names = "lcd";
-- 
2.18.0.321.gffc6fa0e3

