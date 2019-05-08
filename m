Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B2120644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="b/Mzvp9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfEHQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:10:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35619 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfEHQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id d20so6282017qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSjzGScI7FWnThDcb7L6+9NbYWPOU1oEmSq7ubXMBrA=;
        b=b/Mzvp9NPtpNHKqVRbANgyrQcwT3N1aJFNvie3Z04eQTbUk6Qao33USN2IESlcHCOO
         4qnWQ0OSFA9kRNfw0U84tm6awagkWYPwG6lxiGHkQlacBIqYLmHbCoID7pE85RwJ6oWW
         fxCjWj0loJl7dr1aQl440frgop0Fsx3+xqDuR0iu3DGH+kYO/XBZ91bJw22MT3cefWmv
         9y+gjvaQnQ096PQRKvgg8gbPFShyevAenHdukkPFwgfEZVmYe7qW4oVd48HxFgI6IQar
         Fn788RAuaJM5XZ7ORF6O6nrqX9mxUfX5QCSmGbyiJwTNTf6qDqASZNABfmLhhypMhWKJ
         h7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSjzGScI7FWnThDcb7L6+9NbYWPOU1oEmSq7ubXMBrA=;
        b=EL7eOJckjytOkU6nMJUFt4FteqVbz7XvKGIKZ9nQ/2JFZbeWsgfmdC9T3gTvF3lyvt
         9fyzu/N5LxaZPCfNeNK+TYWwxonjK0GDnBZ9/Q2lD2J0tE3j0NvZJ2z4k+dXhNi/KfZt
         sw03VAPaLUdnMWC7fAuVhLfoEkJGzLAbu9kbmOWmUAP7zLYMjKDzLAC7N8fPhApmObSh
         L8eLcPloxU4dAlwbjnkuDfdhtBjTHlfd3WU7Qi17v3qZLRMbarJLdED8eC5lzldKk8i6
         bnWRP1dOANLu6yF+7Xf3IrAmQFdu3n6t8lNR8SSkZSqunc8HgD8I0Kgepc16hvmefBU3
         S8PQ==
X-Gm-Message-State: APjAAAVKLB63bKYwnZTFf1VFwuwflyvqTg7Yq7wykQwOXSY6pmkEC4oL
        lztb0pvnE7/XCSs20GVQVmPomA==
X-Google-Smtp-Source: APXvYqyZLDk2aXR6xfKMLulFGaYRoZh1EvXTEYMzxva9aBfDueLN4c20IV9V9OJciZpl/JQmHfwuKQ==
X-Received: by 2002:ac8:2cc1:: with SMTP id 1mr32738783qtx.389.1557331775692;
        Wed, 08 May 2019 09:09:35 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:35 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] drm/rockchip: Use dirtyfb helper
Date:   Wed,  8 May 2019 12:09:11 -0400
Message-Id: <20190508160920.144739-7-sean@poorly.run>
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

Instead of flushing all vops every time we get a dirtyfb call, use the
damage helper to kick off an atomic commit. Even though we don't use
damage clips, the helper commit will force us through the normal
psr_inhibit_get/put sequence.

Changes in v3:
- Added to the set
Changes in v4:
- None

Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-7-sean@poorly.run

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 97438bbbe389..02e81ca2d933 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -16,6 +16,7 @@
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -25,20 +26,10 @@
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_psr.h"
 
-static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
-				 struct drm_file *file,
-				 unsigned int flags, unsigned int color,
-				 struct drm_clip_rect *clips,
-				 unsigned int num_clips)
-{
-	rockchip_drm_psr_flush_all(fb->dev);
-	return 0;
-}
-
 static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
 	.destroy       = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
-	.dirty	       = rockchip_drm_fb_dirty,
+	.dirty	       = drm_atomic_helper_dirtyfb,
 };
 
 static struct drm_framebuffer *
-- 
Sean Paul, Software Engineer, Google / Chromium OS

