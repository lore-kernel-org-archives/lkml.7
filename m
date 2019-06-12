Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCE5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4C6208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dp5fYdjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407924AbfFLIvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:51:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36527 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfFLIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:51:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15991923wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSKOs/0s6FR/9oTMsWE0q6h8Dj8JjCFySf1jc9f1nac=;
        b=dp5fYdjMMNY/KdA9qO5s73CMWXfw8DAreKnFk6nEKvfwIaxrHiPpb2vj6D5xptj9am
         c79WmDo+GdIjETFTCwSTtx4ceUbLL1MCw//rpanykdrl5xhvJ45V24cuOlrYVChWZ3XX
         V1tdSCToAm3CDM+e17q3hrpLYnPVOmWFWnO6vzFKql6LIUtgnO7+7BOJKdJ6IHOuWO5C
         /D9Pzz1hpaIGYWjjSr4Dk9sI7j7bP59zV2js1qoU9fbSRy3b5txPhtA3JglPMTizX8yC
         KOChxhh06wSr9W6MmhbtJ8aqXshg+LrnfW5lIUvmY9wiNPtv9p4qWjKSNl5zdr39JBDk
         U+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSKOs/0s6FR/9oTMsWE0q6h8Dj8JjCFySf1jc9f1nac=;
        b=CekPY5C5TF0bNdCp5sLwD6ugoMwxO3K0w9dpmCEZFzCuC0JyY+h+OIME7hDYmWinfd
         ZfpbxsYAuqwmVkWf72t2jkB8dxpyNqVq39ndOvl3ubW+KWvmiZ5ENF7TapAxWhE1cFnu
         PYCaIpm+yk9HirDh8f7vvIXmTiRfnnyoI8VORwm/8r3vOgj/LzP+B2TyJ9qP2yyM5yIC
         8cnFHEdK27BsoD6OkTw75vuJmWcWKV278VFnt0W1mRtFSqBHBrvw6aYwqi+feXXPdOvx
         Xaj6uZQeT2JqF7irfhOV7FW/Ue3hberTDblyDCqKkf2vw2dPai5T7XL55PasPnXNnBZR
         slQg==
X-Gm-Message-State: APjAAAW7RCWvy9fuv2j+SBgZTOrSelFgqohq3p3yAZwygZmHnEl2uTb4
        30Z5GRIBwkdF+vKiy5ppzvW8tQ==
X-Google-Smtp-Source: APXvYqyzpscGJR8fCa3uCffuwkxZ7AlhcgCsY6/bsrfkvgNWwSr/Lz5742sU4FWv0vu+LY4aelT8QA==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr4888821wrr.56.1560329509905;
        Wed, 12 Jun 2019 01:51:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm6218786wrx.17.2019.06.12.01.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 01:51:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] drm/bridge: dw-hdmi: Use automatic CTS generation mode when using non-AHB audio
Date:   Wed, 12 Jun 2019 10:51:47 +0200
Message-Id: <20190612085147.26971-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using an I2S source using a different clock source (usually the I2S
audio HW uses dedicated PLLs, different from the HDMI PHY PLL), fixed
CTS values will cause some frequent audio drop-out and glitches as
reported on Amlogic, Allwinner and Rockchip SoCs setups.

Setting the CTS in automatic mode will let the HDMI controller generate
automatically the CTS value to match the input audio clock.

The DesignWare DW-HDMI User Guide explains:
  For Automatic CTS generation
  Write "0" on the bit field "CTS_manual", Register 0x3205: AUD_CTS3

The DesignWare DW-HDMI Databook explains :
  If "CTS_manual" bit equals 0b this registers contains "audCTS[19:0]"
  generated by the Cycle time counter according to specified timing.

Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 44 +++++++++++++++--------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index c68b6ed1bb35..6458c3a31d23 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -437,8 +437,14 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
 
-	hdmi_writeb(hdmi, ((cts >> 16) & HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
-		    HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
+	/* Use automatic CTS generation mode when CTS is not set */
+	if (cts)
+		hdmi_writeb(hdmi, ((cts >> 16) &
+				   HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
+				  HDMI_AUD_CTS3_CTS_MANUAL,
+			    HDMI_AUD_CTS3);
+	else
+		hdmi_writeb(hdmi, 0, HDMI_AUD_CTS3);
 	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
 	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
 
@@ -508,24 +514,32 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 {
 	unsigned long ftdms = pixel_clk;
 	unsigned int n, cts;
+	u8 config3;
 	u64 tmp;
 
 	n = hdmi_compute_n(sample_rate, pixel_clk);
 
-	/*
-	 * Compute the CTS value from the N value.  Note that CTS and N
-	 * can be up to 20 bits in total, so we need 64-bit math.  Also
-	 * note that our TDMS clock is not fully accurate; it is accurate
-	 * to kHz.  This can introduce an unnecessary remainder in the
-	 * calculation below, so we don't try to warn about that.
-	 */
-	tmp = (u64)ftdms * n;
-	do_div(tmp, 128 * sample_rate);
-	cts = tmp;
+	config3 = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
 
-	dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
-		__func__, sample_rate, ftdms / 1000000, (ftdms / 1000) % 1000,
-		n, cts);
+	/* Only compute CTS when using internal AHB audio */
+	if (config3 & HDMI_CONFIG3_AHBAUDDMA) {
+		/*
+		 * Compute the CTS value from the N value.  Note that CTS and N
+		 * can be up to 20 bits in total, so we need 64-bit math.  Also
+		 * note that our TDMS clock is not fully accurate; it is
+		 * accurate to kHz.  This can introduce an unnecessary remainder
+		 * in the calculation below, so we don't try to warn about that.
+		 */
+		tmp = (u64)ftdms * n;
+		do_div(tmp, 128 * sample_rate);
+		cts = tmp;
+
+		dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
+			__func__, sample_rate,
+			ftdms / 1000000, (ftdms / 1000) % 1000,
+			n, cts);
+	} else
+		cts = 0;
 
 	spin_lock_irq(&hdmi->audio_lock);
 	hdmi->audio_n = n;
-- 
2.21.0

