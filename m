Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3ABC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EFC20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJT2Wk+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLRWgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:36:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40136 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLRWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:35:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so1047327pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ac+GRDMFPcxFMKgFQ0+PN5ep2CIAGQOVje6d76UBFmU=;
        b=bJT2Wk+hjANwW4eZsDvl3YCIgdw/UuJFo8So+f9iGdvMWtC/AP2mu4QAeyNQg7MIMV
         NGhDP8H44Vst4zK5cQkKxqoMD36i7D+cxsnYr44KppfZLgtBfFTjveKVD8T8XjE7qsiS
         hBysUPQrLSAIjCwADAfprx/LC4F6GhQIFQkEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ac+GRDMFPcxFMKgFQ0+PN5ep2CIAGQOVje6d76UBFmU=;
        b=VnF1i6VXAvkVUUAaa0YFUovcuUObNiRgzQnkcCrTGZP5jmraVkJbui8Kdq4rWI3wtM
         dcrVMXymJk8yDo3guBZHF44H8mAMzr8eiiB12fn8kkHZrosDv18JPYbEWJ2BnWPIcOU8
         KW2t4xOAcvhtyxsdjLViDlOeBm9NquwydOf5DU8HIjg81phgwvOd8UfnzCOTLEWF8bz5
         RhjSfntzRlgStSuFxnG9e8M6D98a5G11CrM7lL6mH89REcOoTReiNgHccTlhs4RAIxBw
         rssNOvG1P7SuIUL6qSYpcwFHThGCgD7+VWzSz4zSmL02uvQqA4rJrdUEnZBDPgmulMSj
         3WTA==
X-Gm-Message-State: APjAAAVHimJYd2DcEdWl//VuUKhV7JQqUpgtQoudNtfrn0zxlXyKj0M8
        0UqM2y1j7oXzrxJyQ04h7EOuwA==
X-Google-Smtp-Source: APXvYqx57BZ+CNHb/hjEGlMO3rpcPAYYWODK4qahli7hCHRhAdX55bWmLvl5Xm6VZGLGAG7faFuJjw==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr5720489plz.29.1576708557854;
        Wed, 18 Dec 2019 14:35:57 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i9sm4709919pfk.24.2019.12.18.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:35:57 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, seanpaul@chromium.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 0/9] drm/bridge: ti-sn65dsi86: Improve support for AUO B116XAK01 + other DP
Date:   Wed, 18 Dec 2019 14:35:21 -0800
Message-Id: <20191218223530.253106-1-dianders@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a pile of patches that was created to support
hooking up the AUO B116XAK01 panel to the eDP side of the bridge.  In
general it should be useful for hooking up a wider variety of DP
panels to the bridge, especially those with lower resolution and lower
bits per pixel.

The overall result of this series:
* Allows panels with fewer than 4 DP lanes hooked up to work.
* Optimizes the link rate for panels with 6 bpp.
* Supports trying more than one link rate when training if the main
  link rate didn't work.
* Avoids invalid link rates.

It's not expected that this series will break any existing users but
testing is always good.

To support the AUO B116XAK01, we could actually stop at the ("Use
18-bit DP if we can") patch since that causes the panel to run at a
link rate of 1.62 which works.  The patches to try more than one link
rate were all developed prior to realizing that I could just use
18-bit mode and were validated with that patch reverted.

These patches were tested on sdm845-cheza atop mainline as of
2019-12-13 and also on another board (the one with AUO B116XAK01) atop
a downstream kernel tree.

This patch series doesn't do anything to optimize the MIPI link and
only focuses on the DP link.  For instance, it's left as an exercise
to the reader to see if we can use the 666-packed mode on the MIPI
link and save some power (because we could lower the clock rate).

I am nowhere near a display expert and my knowledge of DP and MIPI is
pretty much zero.  If something about this patch series smells wrong,
it probably is.  Please let know and I'll try to fix it.

Changes in v3:
- Init rate_valid table, don't rely on stack being 0 (oops).
- Rename rate_times_200khz to rate_per_200khz.
- Loop over the ti_sn_bridge_dp_rate_lut table, making code smaller.
- Use 'true' instead of 1 for bools.
- Added note to commit message noting DP 1.4+ isn't well tested.

Changes in v2:
- Squash in maybe-uninitialized fix from Rob Clark.
- Patch ("Avoid invalid rates") replaces ("Skip non-standard DP rates")

Douglas Anderson (9):
  drm/bridge: ti-sn65dsi86: Split the setting of the dp and dsi rates
  drm/bridge: ti-sn65dsi86: zero is never greater than an unsigned int
  drm/bridge: ti-sn65dsi86: Don't use MIPI variables for DP link
  drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
  drm/bridge: ti-sn65dsi86: Read num lanes from the DP sink
  drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
  drm/bridge: ti-sn65dsi86: Group DP link training bits in a function
  drm/bridge: ti-sn65dsi86: Train at faster rates if slower ones fail
  drm/bridge: ti-sn65dsi86: Avoid invalid rates

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 259 +++++++++++++++++++++-----
 1 file changed, 216 insertions(+), 43 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

