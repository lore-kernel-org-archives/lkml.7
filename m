Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8712DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55944205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U1gmKyx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLaNF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:05:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32955 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfLaNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:05:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so15902827pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4bPo8ZUsPUay4xqO2AMjOfE/DZ5OrDO5jUkRoUY2VY=;
        b=U1gmKyx8CuXnL3PQzKepsp555RKkUMBTs6zt2sWqDklR4ytbWLaYee8G1BijtxRCRg
         gDTWkAZOJlMcS86FTxi4jnDeXF0O2vOyq/pDQrgzV01yZVIkCQReTf5nEn2xZZ7+4wJM
         /aYKLrB4tYGlRHKShfKL0jtLnB2dUzDRnMWWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4bPo8ZUsPUay4xqO2AMjOfE/DZ5OrDO5jUkRoUY2VY=;
        b=fB4hnYWR7mI0qp/JBTbSnvbc8BhErbwTbfcMdnkN1kR7YB5Vj4J3gLr35Ay+ohuX3A
         vA94n/RLUUJ8EzomI//ead77MpBw6Pv2qC/MzSjdYH14YZJnrM8Huxu4077ZUC5+Lm2A
         eg+3ucW3Pb+GY78y+67XzqzT+8GjmNaXfpQx45cXGTpXIkxU76HHN2PyG2NV4VBylHGy
         rKlk0nIMDnq6sOtjqOk+xtgvNxrnrYePOtrB5A4seXATSMYvUc63b05t98nv7x8nCROJ
         kbGMT3sdnAY+cKT9LdkWJBCl3iqsQzBFByp0CRyKCy27YEiv4x9KQnvRhO3S6jGOdlJ8
         weSQ==
X-Gm-Message-State: APjAAAXoNiOhNde44NSVb6httVr7gCM6AgzS3LDL62XRZLFSdrncTCeX
        JDhxbxCODtDaOzDgrcYI0JjGUw==
X-Google-Smtp-Source: APXvYqzGxUTLPshcgs4piIKf+BqFt92fK+2KuvQXB+m3PyXKksH8GIPO+5kN+3UoqrcAEtaSJdCpLw==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr74759458pls.210.1577797557554;
        Tue, 31 Dec 2019 05:05:57 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:05:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 3/9] ARM: dts: sun8i: r40: Use tcon top clock index macros
Date:   Tue, 31 Dec 2019 18:35:22 +0530
Message-Id: <20191231130528.20669-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
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
Changes for v3:
- none

 arch/arm/boot/dts/sun8i-r40.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index c9c2688db66d..3faa35d43afa 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 
@@ -709,7 +710,7 @@
 			compatible = "allwinner,sun8i-r40-tcon-tv";
 			reg = <0x01c73000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>;
+			clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top CLK_TCON_TOP_TV0>;
 			clock-names = "ahb", "tcon-ch1";
 			resets = <&ccu RST_BUS_TCON_TV0>;
 			reset-names = "lcd";
@@ -752,7 +753,7 @@
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

