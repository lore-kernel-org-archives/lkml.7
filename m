Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A7206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SFA9jBNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfFEMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:53:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfFEMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:53:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so2141907wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uycimCcEQzjnF8sAY15CB1rjUO658nghgDAo0Xg98gY=;
        b=SFA9jBNJIJjn/VRmKcxWKSqZlCzG68DwU1APLNgz/VGf54XhH+wBfVmPfIf0S9G78i
         B83QHCtcDhiKC3BC/qlukVnIfhbtivcNHDGthGl2vtQyePaPo/cpWuF6v2NMyzf12abb
         YxiD0aZzeGxoJxmQALzwEgncPRo/6fQCFcLfOQiR0EpFhS7oCP3JZzP5B/OeyAGX0E42
         CRsfyWi8aGOtUWN8J73M790NZ//umWtXEvn+qpC6beRqeQJUePP3JRwTEy0Bmeg+X/yZ
         y6W86bz1rzSAuLj1PM9rlsKgyPNaF5nKaYqAgWGwmse4N7A/DMfDQWuwtgokhCattDhE
         N6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uycimCcEQzjnF8sAY15CB1rjUO658nghgDAo0Xg98gY=;
        b=VIuLwJOVPXNHlR65e+ocz6GgJEknvYVuzODUfiEH1D3+MRAnb34S+CNDozAb8yHTYi
         U0yJBhFX7eVsA/LBAiaS8plxmUVRXYhPRT1BtRwO+wJ6dV5oMRmX+ytlLPmg8TICTiIE
         hPxbBvvI7ouIoEd/ksZeszAEGjwmcizIbit2iZ8ClVr0jLGwgM8GlQvgE4RhhSFoHEsz
         lxec9uZsIG5jIwcf43UMhUEelwa1nFEqU+lk4R/Kv600dat5jJWg4qOISGBoJrVNzpDk
         dhuOMz0Dp1+DAgjPjgkICZJAJMTqJ5VwqgeDHkgQERvVapHDzxmwpLB8ZdcH4JACoB8d
         Oxyw==
X-Gm-Message-State: APjAAAVCtv218sa53ETWo7+qBl2xCJWR+xAQQ4FNe5CQBCQTtQwvjDkV
        SgEVJCYboDgnMz6xJuCg9hoyTQ==
X-Google-Smtp-Source: APXvYqyFNJn7u0rlc7fuBS/JBHoswH/Cksr0I7UUMNH8dOfpQeeAAj7ioSr6w1ClZki3MK5UMpczUg==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr12477467wmd.131.1559739202495;
        Wed, 05 Jun 2019 05:53:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y133sm20899720wmg.5.2019.06.05.05.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:53:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: fix G12A HDMI PLL settings for 4K60 1000/1001 variations
Date:   Wed,  5 Jun 2019 14:53:20 +0200
Message-Id: <20190605125320.8708-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A HDMI PLL needs some specific settings to lock with
different fractional values for the 5,4GHz mode.

Handle the 1000/1001 variation fractional case here to avoid having
the PLL in an non lockable state.

Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 44250eff8a3f..83fc2fc82001 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -553,8 +553,17 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
 
 		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
 		if (m >= 0xf7) {
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
+			if (frac < 0x10000) {
+				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
+							0x6a685c00);
+				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
+							0x11551293);
+			} else {
+				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
+							0xea68dc00);
+				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
+							0x65771290);
+			}
 			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
 			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
 		} else {
-- 
2.21.0

