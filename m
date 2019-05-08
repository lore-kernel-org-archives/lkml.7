Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8FC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE5216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SfmynSg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfEHQJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39798 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfEHQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so4372521qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRNTbKqT4JCfOSK6xrkUmA02JfSOD9QQELwl7WDvtpU=;
        b=SfmynSg1AWxXf5d82GnEIvAHjeX1xH/Fb+F7Moe9A/+pxMp24GZorMQ5g0XNcMK8Cm
         Gbhushqoo70XYPrnF+P/GHPL3Vdkr+y7M8sJvlzEFou8P7APvcpdZG9mJMO0u5dttHEw
         3rL2nQwHour5/S9FaIR0hI1Umt1ohM+MkqyL4n6p7EBNuW8V3WIzWxVYBE9LbSBEs4Ax
         ar45aXOK3GN/0W4hYac1bNPAQy0uP819fcgjjvUWXj65rd1R+phgA+TlZvKN1fc+4lwi
         jgidmqLUXWCzUulWoSl9KCJtev6297tYX+MTVDAVfE5Yvz4ZD8xrRkKzcU/AmORcNzpq
         nvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRNTbKqT4JCfOSK6xrkUmA02JfSOD9QQELwl7WDvtpU=;
        b=oAGueFO/NhUhNunoAxnN3C5usEWyUPwYvonYKsacqjQaM+njs3oy57Sn2CXr8a1hjp
         cbEZBJwuIanPtI4OHzxAEoodSkhHfMujlXAqQmBDKcSntXjHxRRNzQH5lNI4FlgcjDJ5
         7HtFyN22KGLxnfMehg+BaL2s27gmuJwam3zp7E/cyAy4IuOrFviPAgnggdhohUcgTkhS
         VUjLGAQPZIpWFoLtfj5jtvI2Tu+Y5Nn6SQNF0PLoSGTfCBlnUae+/LW/eqfZ336s+FuS
         yG5bjSdBef0993UaxoHkMHvFoKvIyRlo5oO1Eoyne/lYfs2CTXjGdiwh+Nq8qd0nEO+s
         1d/Q==
X-Gm-Message-State: APjAAAUpCcMmDYewq64dVDEsgogqTr0BvyOURbs1X8ra4SrhplXUJKj9
        ns28zM8da3k5//8sZaHRFLLhWw==
X-Google-Smtp-Source: APXvYqy3tayWKc8duRQ+bmjeFbIIdoifi1bY3aQ16j3Eu10XqXuqG/BNha0+Qge2up4EtO7LgVBghA==
X-Received: by 2002:ac8:36ce:: with SMTP id b14mr10657578qtc.190.1557331786216;
        Wed, 08 May 2019 09:09:46 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:45 -0700 (PDT)
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
Subject: [PATCH v4 11/11] drm/rockchip: Use drm_atomic_helper_commit_tail_rpm
Date:   Wed,  8 May 2019 12:09:16 -0400
Message-Id: <20190508160920.144739-12-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508160920.144739-1-sean@poorly.run>
References: <20190508160920.144739-1-sean@poorly.run>
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
Changes in v4:
- None

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-6-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-5-sean@poorly.run
Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-11-sean@poorly.run

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

