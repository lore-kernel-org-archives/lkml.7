Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C45FC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC2C20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="T4x6TwEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEBTuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35620 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfEBTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id b7so2285411qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFVSuZJraJRY8lf7zLGr4Icu987vmHl/cFcB0vPbwTo=;
        b=T4x6TwEZL9VIqTV12O2BFwvKSIPNN7BS9WFC88TrYAEmDjgKlJUnAIv9A8+/WllSG+
         UEKM5WL87d4xq6HgqE3QULfTmN3wFg+WXSaGzcEjqq6uQdn6pexuw5YUxuP5q3MRdpP0
         k3Yla/PYmhA6I8boHirx6ETAqZNcMr0GFIBYTthqChrZ6WnGBeKxuLWO9gDaXat+vsyU
         Js1Q05cJ8VnDT9G7OdqrMODWsVG0DnZXZHIwQlVCV8LvYPk4rP4n+NCw/Sde4IGdPeGU
         uPj25y1BH/NZO8Tv8SuVdgaYxeLGgs9MTgqCN5oTiQBBzshAYGSd2uIJNLvR5KNez/+j
         a3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFVSuZJraJRY8lf7zLGr4Icu987vmHl/cFcB0vPbwTo=;
        b=HULPZqt4PBpcc/XBQXJQw6EDHWhBOBfhotBkexJkc0vrgS+oxyzkEf3OOfMdxKmg1S
         MLoFFz/2PBCLoHlEHgYefXSLx1tbK6iFBxlsXCjLBWFfe0ZoZmiSondNjpFyTDr+2D5H
         bj2VFQdUcoaoM/50oCAKn6y4nqEg9Us5CCZWGXgdsjfFobHJVmSY4DeABOneRHEJVkAh
         cRiHEJ/kCz1KnJmhuIPbKLQ3nOKfZcfdhxcjbM3s6qw1CyAsSpi4T96Tfx5YzaD0H870
         6+BsiNB5xq+8N0yKKRt0dOfHqszwRR3f3cwiB+BFj5SrbcDclGHwr+HVHpCNdyPIx163
         bsgw==
X-Gm-Message-State: APjAAAWsvdZRu3LYa9/NMojlTt9tGDZ4vQQYC/tBl0d6bRHfwIiwQppi
        3KQPpFXrjt7TJlrZ9+N5yZskRQ==
X-Google-Smtp-Source: APXvYqxxFG9zgR3WVcDfPdsGy4UEJe7Y+styDVNNm4qQfqbwO4kMeleh9vCf98fyvnm6StgEl1J4Hw==
X-Received: by 2002:a37:4948:: with SMTP id w69mr4703738qka.122.1556826628609;
        Thu, 02 May 2019 12:50:28 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:28 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] drm/rockchip: Use dirtyfb helper
Date:   Thu,  2 May 2019 15:49:48 -0400
Message-Id: <20190502194956.218441-7-sean@poorly.run>
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

Instead of flushing all vops every time we get a dirtyfb call, use the
damage helper to kick off an atomic commit. Even though we don't use
damage clips, the helper commit will force us through the normal
psr_inhibit_get/put sequence.

Changes in v3:
- Added to the set

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

