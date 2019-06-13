Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0604DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D9D20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X69ZulaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfFMSyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:54:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36753 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfFMSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:54:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so8524120plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8S69BX3xpHZr2uy2odezTDXnVK0j/vxrp4XQpnzj94=;
        b=X69ZulaE4ksswSOcisK935ppPOCimBaK9wKQzoWbdJx9hexnxFxppTxwlkfyDk335f
         zg+xx/max7Lj5RHHaALWr4GF2Rs4pIVNcW+EsctqJTj4kTJGRhw4jp4Qu94m+HyOzm5y
         brXa4+I9BLezFomx007mMIT0udlZ21rLXg6bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8S69BX3xpHZr2uy2odezTDXnVK0j/vxrp4XQpnzj94=;
        b=H6kOxOKZ/Xmf4uj0qjyR4ySBp5ZmWmqckNEAvL6F8gVKMNm3lvG8w94X64k8pLl5dj
         9afw2wWMAvejQwnX4rCf2ThZh3e6gNLlO2ZxTLRT3toKv2ghN6tPFzbkDvhSt6hSPsWq
         7r9tzjMbeonPPS44Wo1QFRVubyESRWw/GB1rvhNsbvovWRL4vGb9ECBWnTzLvVtcPhVo
         +HkC2/yuMUwxxjj1eCZko7fR6a3KOBAOhin5J8FIAHbe9cNKKiRYEECB1pHI71qZrkp1
         EPLo4VmKC4PNb2uq8WxK6BxNoEENbU3vmfQQl2dRKq35UdRdd5dmvf9yUd6/8jaePNTT
         pzxg==
X-Gm-Message-State: APjAAAXGX0NzJB4ZlBUsMO4xHWwpJRCKoCRn7CvdMiVs26QnXkb1+19T
        kTTsiVRth1JY+39evkOuncey8A==
X-Google-Smtp-Source: APXvYqxaaPemy8HlCqx44EJP2dYlb26OfNzzTdIleOfRx7U76bvedSxq5O2wJ0IWbVnEXm6M9wSwDQ==
X-Received: by 2002:a17:902:7793:: with SMTP id o19mr28815033pll.110.1560452049961;
        Thu, 13 Jun 2019 11:54:09 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:54:09 -0700 (PDT)
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
Subject: [PATCH 5/9] ARM: dts: sun8i: r40: Add TCON TOP LCD clocking
Date:   Fri, 14 Jun 2019 00:22:37 +0530
Message-Id: <20190613185241.22800-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Fig 7-2. TCON Top Block Diagram in User manual.

TCON TOP can have an hierarchy for TCON_LCD0, LCD1 like
TCON_TV0, TV1 so, the tcon top would handle the clocks of
TCON_LCD0, LCD1 similar like TV0, TV1.

But, the current tcon_top node is using dsi clock name with
CLK_DSI_DPHY which is ideally handle via dphy which indeed
a separate interface block.

So, use tcon-lcd0 instead of dsi which would refer the
CLK_TCON_LCD0 similar like CLK_TCON_TV0 with tcon-tv0.

This way we can refer CLK_TCON_LCD0 from tcon_top clock in
tcon_lcd0 node and the actual DSI_DPHY clock node would
refer in dphy node.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi           | 6 +++---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c     | 6 +++---
 include/dt-bindings/clock/sun8i-tcon-top.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 219d2dca16b3..12576536df4a 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -591,16 +591,16 @@
 				 <&ccu CLK_TVE0>,
 				 <&ccu CLK_TCON_TV1>,
 				 <&ccu CLK_TVE1>,
-				 <&ccu CLK_DSI_DPHY>;
+				 <&ccu CLK_TCON_LCD0>;
 			clock-names = "bus",
 				      "tcon-tv0",
 				      "tve0",
 				      "tcon-tv1",
 				      "tve1",
-				      "dsi";
+				      "tcon-lcd0";
 			clock-output-names = "tcon-top-tv0",
 					     "tcon-top-tv1",
-					     "tcon-top-dsi";
+					     "tcon-top-lcd0";
 			resets = <&ccu RST_BUS_TCON_TOP>;
 			#clock-cells = <1>;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 465e9b0cdfee..e23c19f18986 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -205,11 +205,11 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 						     CLK_TCON_TOP_TV1);
 
 	if (quirks->has_dsi)
-		clk_data->hws[CLK_TCON_TOP_DSI] =
-			sun8i_tcon_top_register_gate(dev, "dsi", regs,
+		clk_data->hws[CLK_TCON_TOP_LCD0] =
+			sun8i_tcon_top_register_gate(dev, "tcon-lcd0", regs,
 						     &tcon_top->reg_lock,
 						     TCON_TOP_TCON_DSI_GATE,
-						     CLK_TCON_TOP_DSI);
+						     CLK_TCON_TOP_LCD0);
 
 	for (i = 0; i < CLK_NUM; i++)
 		if (IS_ERR(clk_data->hws[i])) {
diff --git a/include/dt-bindings/clock/sun8i-tcon-top.h b/include/dt-bindings/clock/sun8i-tcon-top.h
index 25164d767835..88de3f2ba335 100644
--- a/include/dt-bindings/clock/sun8i-tcon-top.h
+++ b/include/dt-bindings/clock/sun8i-tcon-top.h
@@ -6,6 +6,6 @@
 
 #define CLK_TCON_TOP_TV0	0
 #define CLK_TCON_TOP_TV1	1
-#define CLK_TCON_TOP_DSI	2
+#define CLK_TCON_TOP_LCD0	2
 
 #endif /* _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_ */
-- 
2.18.0.321.gffc6fa0e3

