Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1A5218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s4CKHm0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfC2QHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:07:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfC2QHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:07:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so3201703wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffLBMmlN/R91KDE3bFeIaFV85gfF8NMBVLWE87EFlsw=;
        b=s4CKHm0QAPPaPdPapbBThGbHXPQD1osO6knnosaihjd3z+4NXUBjS56VJoka7LLNgd
         mZK4GFZlC3i6M2WfMBfCFuEXrjm8HkNVw0z/V6ZzYDK0cqzcT5i88AAZwSKo0eqeIXur
         qsh7mBNoH0jE8kilTGvPV8rCeN5iyi95mDRbczoUEUgLoJT2DFHfxd9X1ANasZhJk6yj
         Mvb868PuAxvjgvrgWoatvlkhwIaW690hjkgmiTI9ZHtpv5GTvBUsNl5bDSjyGDfsr/eN
         jyCnxKkU34KTjqOWZYbVt6rtU7clJGb1pMuFlPOVrOSzv/yTIge3FZesJdGUwmGa8/hV
         REFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffLBMmlN/R91KDE3bFeIaFV85gfF8NMBVLWE87EFlsw=;
        b=BBPmBjx43n9MqWTu4EgPJfz7xyp3A5c8/pAEcLG9JPy/PORAnX4YgQGFgXLdp4OBJC
         zjv+oSvTBkHwVseQ7HRDjRoXWv2R8p6w78CrAldgeCr4KsYeGxxr+Y21FWsmjtXDsEEb
         dhcV9SjBgkz3uol7zc4eomm2TQ/93Z5JQGNRDXYrKCiAw9S6T8ze6/baymo5tGUCuhOo
         45fvbkzGsrfA2oZhWhCuD6FOE3PPoduer74JQhbqs/cBK0/TTwOG479iv8628Hb7Cs7E
         3++KJYf6+rtGqAKxeO7HkmAgMaLmJX+7BySN8LCEL6VggbF9JAIfJq0JBgx4TFGUlimc
         ev9Q==
X-Gm-Message-State: APjAAAVx78oy1aG1+50wCvG97KQyoavFs6dmK2XGJoNefHTpFXSmwvRM
        6ljBlmVLdW7Y63gmm55yjbJI+A==
X-Google-Smtp-Source: APXvYqwdgF9JFhBs8GvLw0C3GPwnW0HYgtmJ09Q8WyUILKmpEKm5w2fxTYBiXTjKvREb/kVRHNXVTQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr14733625wrs.155.1553875626386;
        Fri, 29 Mar 2019 09:07:06 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id c10sm3329527wrt.65.2019.03.29.09.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:06:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clk: axg-audio: add g12a support
Date:   Fri, 29 Mar 2019 17:06:46 +0100
Message-Id: <20190329160649.31603-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329160649.31603-1-jbrunet@baylibre.com>
References: <20190329160649.31603-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string and additional clock ids for audio clock
controller of the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt          |  3 ++-
 include/dt-bindings/clock/axg-audio-clkc.h             | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
index 61777ad24f61..0f777749f4f1 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
@@ -6,7 +6,8 @@ devices.
 
 Required Properties:
 
-- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D
+- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D,
+		  "amlogic,g12a-audio-clkc" for G12A.
 - reg		: physical base address of the clock controller and length of
 		  memory mapped region.
 - clocks	: a list of phandle + clock-specifier pairs for the clocks listed
diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index eafb0de8466b..75901c636893 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -70,5 +70,15 @@
 #define AUD_CLKID_TDMOUT_A_LRCLK	134
 #define AUD_CLKID_TDMOUT_B_LRCLK	135
 #define AUD_CLKID_TDMOUT_C_LRCLK	136
+#define AUD_CLKID_SPDIFOUT_B		151
+#define AUD_CLKID_SPDIFOUT_B_CLK	152
+#define AUD_CLKID_TDM_MCLK_PAD0		155
+#define AUD_CLKID_TDM_MCLK_PAD1		156
+#define AUD_CLKID_TDM_LRCLK_PAD0	157
+#define AUD_CLKID_TDM_LRCLK_PAD1	158
+#define AUD_CLKID_TDM_LRCLK_PAD2	159
+#define AUD_CLKID_TDM_SCLK_PAD0		160
+#define AUD_CLKID_TDM_SCLK_PAD1		161
+#define AUD_CLKID_TDM_SCLK_PAD2		162
 
 #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
-- 
2.20.1

