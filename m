Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC40C73C61
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D246B20861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+2aDXwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGIW6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:58:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:58:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so170894pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfBNRjMW96lNOTO1+wc8G+mqG3/RxD26VY8ohNb7l7s=;
        b=g+2aDXwaj0DzsFicoZrXvoungL+MWOPC0VtEH2gPXuj8zlNnwwgyIhkxF0bkqpoWcm
         8TboO6bKfQEBXG8g8wp2IMRGW/TvAviOydq287DyBpvxHMXEz6+WOc0/hqAIcJYCcTju
         BoRstaqm8JPuzjtT4y8KqxFrOGp53xRR93cJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfBNRjMW96lNOTO1+wc8G+mqG3/RxD26VY8ohNb7l7s=;
        b=JQ4d+RBAKrxl0xYU4qxMdR8Bhiat5EriEOsQvrGpCQt9nn/UyRh2NWsA73fzRXxAHC
         +9iSOLiw8LiDfjgOa5Jv94swbnpd9gdLRMQ+ipkitXWHdmPEQB1vE4b0NoQH7S0ujXf4
         A+HZQZo2fPorvz/sl87A9EnuQ0jbEehgEef53bsS66WK13IMjhqeU6eLOiUDFmxs0pcK
         nnLcieywFn2WQVqHVQaYjq+f4hDyaKgAjsQ6VQCKtiny7627pdSz0gOJyiPPb86DhAEx
         mJvhbU6RUjpBGlaFHBMXXTRoU074skz0dcpCgGan5YQfBXIAHHjdAiFSbjxpU9TGyDXc
         xExg==
X-Gm-Message-State: APjAAAXSqxzOGxDB+gQTavJqxPJRSalYHB0y1+N7dqRvW3Vs5V8/tcsr
        NexBAjFhJ0wTMU7YGP+Zde9d4rEGTGg=
X-Google-Smtp-Source: APXvYqzHCjdRgs8T2Gzw/2FP8RssoOjRLpdQrKxiGCNwSt8p03lTof0IAKIZqNN5ejjfFbu9SwHkpQ==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr2812506pjg.57.1562713125358;
        Tue, 09 Jul 2019 15:58:45 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id 201sm152939pfz.24.2019.07.09.15.58.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:58:44 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v6 0/4] Panel rotation patches
Date:   Tue,  9 Jul 2019 15:58:36 -0700
Message-Id: <20190709225840.144038-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the plumbing for reading panel rotation from the devicetree
and sets up adding a panel property for the panel orientation on
Mediatek SoCs when a rotation is present.

v6 changes:
-added enum declaration to drm_panel.h header

v5 changes:
-rebased

v4 changes:
-fixed some changes made to the i915 driver
-clarified comments on of orientation helper

v3 changes:
-changed from attach/detach callbacks to directly setting fixed panel
 values in drm_panel_attach
-removed update to Documentation
-added separate function for quirked panel orientation property init

v2 changes:
fixed build errors in i915

Derek Basehore (4):
  drm/panel: Add helper for reading DT rotation
  drm/panel: set display info in panel attach
  drm/connector: Split out orientation quirk detection
  drm/mtk: add panel orientation property

 drivers/gpu/drm/drm_connector.c    | 45 ++++++++++++++-----
 drivers/gpu/drm/drm_panel.c        | 70 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp.c    |  4 +-
 drivers/gpu/drm/i915/vlv_dsi.c     |  5 +--
 drivers/gpu/drm/mediatek/mtk_dsi.c |  8 ++++
 include/drm/drm_connector.h        |  2 +
 include/drm/drm_panel.h            | 21 +++++++++
 7 files changed, 138 insertions(+), 17 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

