Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A778F2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dZXH9NvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFNQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:43:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44667 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:43:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so1778287pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=848PkAQSuqGBV9d1ZE22q9YEz/y0k4xnXoRXzpZqX+0=;
        b=dZXH9NvKdmO0bTsLkbJzcgWsuOWrWooI8HoZvgEnDZAITMfdSO31becAdutXgCndye
         MHderODMAFVl3kDDQUpeEvuaZoNXhqkGysP/vFvCfDg3SYV3HcMKFSS9NMVFDDhAaFDG
         eJI66CGb5Ses9xXU+ojj0rPo/6FtA8Nuaz1Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=848PkAQSuqGBV9d1ZE22q9YEz/y0k4xnXoRXzpZqX+0=;
        b=BBJhOHC04MfUTDRrxchFvWGU9JmOjwrZ21swYBWp1ucC7yqnjo0x1sRsfXg+6/GL8R
         M4gwyBjpsPJhKHkb841TjRrZwv+8wxv9aQQsTm/RBu08UUSNA+JqG7XMDFHfi9pBlIAF
         KR7M6MEAOMomSY0RI0yvv8q0ohgbbIzNggkMPWSeyd15hRhUaNQuwat5g0oibrw+S5hY
         8GLeCGNiSjyW7142tWBRaRiGuh4Edmo6CyWB8dFCGIyxN9HRQcOhIQSv7ADeF1CjyWWz
         9sEP/ZQpm+ppgnITBz1RZ8x2GfgNMx4vLlYXBKH3ARClN6zd7jD9PGMherZPPozX0Bns
         tUPA==
X-Gm-Message-State: APjAAAUmWI94xgQ/5odOKD9lHh34Q68WMZMAiRlADiRyBflfgBVvAcyO
        sMHnFihLo38Mrn8f/XdThfe0Rg==
X-Google-Smtp-Source: APXvYqwUHYYxZ/0pN9i06WfooF6JJ94tywE4LYJ0JGGICFTLtuW3GCdvLxxtuIbnkkx9sC5rpEpZNA==
X-Received: by 2002:a63:2349:: with SMTP id u9mr10900061pgm.410.1560530633068;
        Fri, 14 Jun 2019 09:43:53 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:43:52 -0700 (PDT)
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
Subject: [PATCH v2 3/9] ARM: dts: sun8i: r40: Use tcon top clock index macros
Date:   Fri, 14 Jun 2019 22:13:18 +0530
Message-Id: <20190614164324.9427-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
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
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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

