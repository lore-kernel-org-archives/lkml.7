Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22ECC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08CF20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Ix+JXVfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEBTup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43380 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEBTui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so4054103qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IADIU/EJ9FI/G06p19V/c4J8lEcHwqipgCGxkBiLylg=;
        b=Ix+JXVfo5ioRlNyP7UOsKwtCE1OZDBhyykPeRvW+abKdoCm2K5Iwhtt9QaXnM5CyQT
         QFEfeE1IT/KketqZA5YmdbDSrdGnTEUv2hi+OaOgcE3WEG+scLnzz/ecldOczc8PblKe
         w7t7g/f+LUB23NhiJqV/Amje431fC0KPD9WcMUVbNEwBA38DsWzYUpXxpNdRvbVnzuS6
         RULSnXewuPeKU00sikjI+d2D1Cmc+ZpvMfPDTcg54RpVtubQsm7pvWnTiOYhTRig4Sod
         0yy24k5oVH7rnk8M4EnOgcCx+k/lrqn5jGBDkzYlVas4d8kBKOK0DSjkrRHQddd8i0l5
         zCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IADIU/EJ9FI/G06p19V/c4J8lEcHwqipgCGxkBiLylg=;
        b=pfXHg26uXHQV+Z9KB3DBR7FJZ7A/Rk1pF/JzVXOZ8esetRzFex18VMDS8LRovQfYKA
         M8YVys2lAuAocXNJDQ9kGPZMZ/4Z0giM554K1ZHvCEXv8eRhXiBaUg/1d3Ae/ajgXcMl
         b5+0iRlObz9SpB2tyM5SaiMNnpn/XilApwRJjFKtgBeMW7jk4HtEH8T2lCkuEsy86YTF
         wVvwknO9jKewAVZ8KGr97x1f+0i+KHLJLnXP8nMzT6PW/T99Pt7jHOnrYpFztWv3B1oO
         CTGDyuOLzDvqrl9futrHDz/0jdSBiGooiZ8IzGMejf4cIFG9M58tHnPzfyG1awo8BsfJ
         GxwQ==
X-Gm-Message-State: APjAAAWRRFG9ByLcstzQlXa5GVM/6zyZgT2dwB+/zA1O8Y89+fbAb55b
        I/316ooCzl8mfNEUGFehQGa+Cg==
X-Google-Smtp-Source: APXvYqxoEjvDEwkFiRYlf8cfhBENPjVWtZtE47VplWYS6ASODl3pXsDRHDYt5Doku3c45vfLjiwn3g==
X-Received: by 2002:ac8:3166:: with SMTP id h35mr4853635qtb.268.1556826637769;
        Thu, 02 May 2019 12:50:37 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:37 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] drm/rockchip: Use drm_atomic_helper_commit_tail_rpm
Date:   Thu,  2 May 2019 15:49:52 -0400
Message-Id: <20190502194956.218441-11-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190502194956.218441-1-sean@poorly.run>
References: <20190502194956.218441-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Now that we use the drm psr helpers, we no longer need to hand-roll our
atomic_commit_tail implementation. So use the helper

Changes in v2:
- None
Changes in v3:
- None

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-6-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-5-sean@poorly.run

Cc: Zain Wang <wzz@rock-chips.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 214064d599ee..1c63d9e833bc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -117,27 +117,8 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
-static void
-rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
-{
-	struct drm_device *dev = old_state->dev;
-
-	drm_atomic_helper_commit_modeset_disables(dev, old_state);
-
-	drm_atomic_helper_commit_modeset_enables(dev, old_state);
-
-	drm_atomic_helper_commit_planes(dev, old_state,
-					DRM_PLANE_COMMIT_ACTIVE_ONLY);
-
-	drm_atomic_helper_commit_hw_done(old_state);
-
-	drm_atomic_helper_wait_for_vblanks(dev, old_state);
-
-	drm_atomic_helper_cleanup_planes(dev, old_state);
-}
-
 static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
-	.atomic_commit_tail = rockchip_atomic_helper_commit_tail_rpm,
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
-- 
Sean Paul, Software Engineer, Google / Chromium OS

