Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80470C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BF220865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HyHetN5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbfJCRUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:20:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33876 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbfJCRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:20:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id y35so2190919pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YUdKlUjg7izQDgolGpnYHYo+vhd5m2wc6atfBTGDOc=;
        b=HyHetN5bW58UK8pvTmhvXzE8owYnlZMnXW9PjWvCODAS81IDbcZueUkr/Uoczsv9Vc
         bTur5ctetQ58WmGmffdgdCd9BwU66+/P56lnDRZ4y4rtAfxLuKVqeIh6JPJL1KjJbdg+
         FZhdZHeT3uiPdXRTNibqPLDiff8iMuzt7m6Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YUdKlUjg7izQDgolGpnYHYo+vhd5m2wc6atfBTGDOc=;
        b=qnzHN1ai6GmmsmDMcpMHxD7T4DN1vMFYkwddFjkoYu2viIVRJXj5x0oaUDDGdoCAo7
         f6b66HWbq+Dk566hfIFZuu06bZhk7kVX0dGnW4EXSfmeM6uo8NaAZHMHdWmKKSAtDG+z
         qIMk/Oa3DPLIGy4eiVi7t2JOvwirzwFtAxkZXlBlg6xw5q/dmjFTveB4LGyH0HNHB8H1
         O05hvHOHsSXVhDksCa+Fp74RQzlo2GF2zdkrP97BBN5rzqtRw+pD/2dXIDfKqhTksT9/
         cvI+uf/agSaOh9o6840//LTxAoxrOY6W0kQbQTov4DaE08X0FqSET63QxZf1+yDtsg7J
         ocQA==
X-Gm-Message-State: APjAAAX7qD28eSnPyPvBovbjk0pwF0yTfkFMBOXg49SX0C0mpRu7eOTX
        yz0chlfvOf9cvlwBKqzdsGeylA==
X-Google-Smtp-Source: APXvYqwqK3NYUOfm0zqEB+8oEVhfJkq+2Gkte77oRWmOxvpTWnoh+bkvBUCwT7uu3XNO4aStKCP0hw==
X-Received: by 2002:a65:6854:: with SMTP id q20mr10628268pgt.188.1570123246570;
        Thu, 03 Oct 2019 10:20:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c8sm3432491pga.42.2019.10.03.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:20:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     heiko@sntech.de
Cc:     ryandcase@chromium.org, mka@chromium.org, seanpaul@chromium.org,
        tfiga@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/rockchip: Round up _before_ giving to the clock framework
Date:   Thu,  3 Oct 2019 10:20:24 -0700
Message-Id: <20191003102003.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm embarassed to say that even though I've touched
vop_crtc_mode_fixup() twice and I swear I tested it, there's still a
stupid glaring bug in it.  Specifically, on veyron_minnie (with all
the latest display timings) we want to be setting our pixel clock to
66,666,666.67 Hz and we tell userspace that's what we set, but we're
actually choosing 66,000,000 Hz.  This is confirmed by looking at the
clock tree.

The problem is that in drm_display_mode_from_videomode() we convert
from Hz to kHz with:

  dmode->clock = vm->pixelclock / 1000;

...so when the device tree specifies a clock of 66666667 for the panel
then DRM translates that to 66666000.  The clock framework will always
pick a clock that is _lower_ than the one requested, so it will refuse
to pick 66666667 and we'll end up at 66000000.

While we could try to fix drm_display_mode_from_videomode() to round
to the nearest kHz and it would fix our problem, it wouldn't help if
the clock we actually needed was 60,000,001 Hz.  We could
alternatively have DRM always round up, but maybe this would break
someone else who already baked in the assumption that DRM rounds down.

Let's solve this by just adding 999 Hz before calling
clk_round_rate().  This should be safe and work everywhere.

NOTE: if this is picked to stable, it's probably easiest to first pick
commit 527e4ca3b6d1 ("drm/rockchip: Base adjustments of the mode based
on prev adjustments") which shouldn't hurt in stable.

Fixes: b59b8de31497 ("drm/rockchip: return a true clock rate to adjusted_mode")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 37 +++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 613404f86668..84e3decb17b1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1040,10 +1040,41 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 				struct drm_display_mode *adjusted_mode)
 {
 	struct vop *vop = to_vop(crtc);
+	unsigned long rate;
 
-	adjusted_mode->clock =
-		DIV_ROUND_UP(clk_round_rate(vop->dclk,
-					    adjusted_mode->clock * 1000), 1000);
+	/*
+	 * Clock craziness.
+	 *
+	 * Key points:
+	 *
+	 * - DRM works in in kHz.
+	 * - Clock framework works in Hz.
+	 * - Rockchip's clock driver picks the clock rate that is the
+	 *   same _OR LOWER_ than the one requested.
+	 *
+	 * Action plan:
+	 *
+	 * 1. When DRM gives us a mode, we should add 999 Hz to it.  That way
+	 *    if the clock we need is 60000001 Hz (~60 MHz) and DRM tells us to
+	 *    make 60000 kHz then the clock framework will actually give us
+	 *    the right clock.
+	 *
+	 *    NOTE: if the PLL (maybe through a divider) could actually make
+	 *    a clock rate 999 Hz higher instead of the one we want then this
+	 *    could be a problem.  Unfortunately there's not much we can do
+	 *    since it's baked into DRM to use kHz.  It shouldn't matter in
+	 *    practice since Rockchip PLLs are controlled by tables and
+	 *    even if there is a divider in the middle I wouldn't expect PLL
+	 *    rates in the table that are just a few kHz different.
+	 *
+	 * 2. Get the clock framework to round the rate for us to tell us
+	 *    what it will actually make.
+	 *
+	 * 3. Store the rounded up rate so that we don't need to worry about
+	 *    this in the actual clk_set_rate().
+	 */
+	rate = clk_round_rate(vop->dclk, adjusted_mode->clock * 1000 + 999);
+	adjusted_mode->clock = DIV_ROUND_UP(rate, 1000);
 
 	return true;
 }
-- 
2.23.0.444.g18eeb5a265-goog

