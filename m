Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41853C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151692133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK8JhE7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfFNMlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35902 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfFNMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so2407837wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tm2PN34VJevI9ZW9IJurutGMCzu2ZjY7ozaA/XjkBM0=;
        b=qK8JhE7mT9tUOlNnJxB6GUKXut/FqmO9LP3BIxIeFQe5NAz8q/LKgql3AyaXL8zVuy
         wPpR5OFybGGjpF5QukjAFSb6YcyNCtopkfBdwUIZskiqViZ2GlhOgDILEfRF1pJq3pvS
         zJVbcrEr1eXxzDMOegJNm6x62WsbBwmtq8RjQJntxwe/W6e1DLR4F+2KiufGjNdIkKiQ
         5Q3FFmU9uEwPYZ1dJ+Vqkm+THiq8HhEsFoW5RZDRDmt7SHX3AtYawPhdibpsCcQhXmRP
         9KE6euVBNa0tSKezoiM1rlvvJCTgd60eYNvT4diSQFQ1baDroKGhWiiuCrTnHFaR2FX7
         4IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tm2PN34VJevI9ZW9IJurutGMCzu2ZjY7ozaA/XjkBM0=;
        b=EZKl5MvqQuJpSLTDipYsgMldL7WSK2yEj7DEwayhvgtZqlkILwtyz5uPZdWOqyHBq7
         Kg6MPdR+lwQCf0jAK5/lWDgK/HzYSfQrW87V7Tsw+LfjwL54PELos5wnFgx/WQN3AFgh
         7E+yglwEXIiHnd0g8fdYRl+HF7EdnssqyCdj0OeRFMZXX9escOr+uxLCXkslY7Q3Fcea
         88lPbf9/NgeZRRxwruQko6e+OZRHGeGMCVz0F/6e0DUAYN6onoGAtrHpUy3IWVQGpmOZ
         MkZj7HLKDTkLEIsP9Hx9jM0hflrxxwe35ogJAWvmsmwgl7/DYxIQYadySOBuOQpBUXb5
         rQXw==
X-Gm-Message-State: APjAAAWsOJPV62TsMBjx+bQGmBWiQDwG9nqZQyY+k+Uc716GwQ1aBZ1Q
        cA5v7EGRYr3MvdZ9nzF95j8=
X-Google-Smtp-Source: APXvYqzODwjMLrDLW/wAvxdO5UwbM+997kIqDgc3LoJww4panaWD52GNOzzJGcOdSinPiLSrE1KQEw==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr65268942wri.69.1560516093689;
        Fri, 14 Jun 2019 05:41:33 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:33 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 6/6] drm/vc4: use new ww_mutex_(un)lock_for_each macros
Date:   Fri, 14 Jun 2019 14:41:25 +0200
Message-Id: <20190614124125.124181-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614124125.124181-1-christian.koenig@amd.com>
References: <20190614124125.124181-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided macros instead of implementing deadlock handling on our own.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 56 ++++++++---------------------------
 1 file changed, 13 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index d9311be32a4f..628b3a8bcf6a 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -584,53 +584,17 @@ vc4_lock_bo_reservations(struct drm_device *dev,
 			 struct vc4_exec_info *exec,
 			 struct ww_acquire_ctx *acquire_ctx)
 {
-	int contended_lock = -1;
-	int i, ret;
+	struct ww_mutex *contended;
 	struct drm_gem_object *bo;
+	int i, ret;
 
 	ww_acquire_init(acquire_ctx, &reservation_ww_class);
 
-retry:
-	if (contended_lock != -1) {
-		bo = &exec->bo[contended_lock]->base;
-		ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
-						       acquire_ctx);
-		if (ret) {
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
-
-	for (i = 0; i < exec->bo_count; i++) {
-		if (i == contended_lock)
-			continue;
-
-		bo = &exec->bo[i]->base;
-
-		ret = ww_mutex_lock_interruptible(&bo->resv->lock, acquire_ctx);
-		if (ret) {
-			int j;
-
-			for (j = 0; j < i; j++) {
-				bo = &exec->bo[j]->base;
-				ww_mutex_unlock(&bo->resv->lock);
-			}
-
-			if (contended_lock != -1 && contended_lock >= i) {
-				bo = &exec->bo[contended_lock]->base;
-
-				ww_mutex_unlock(&bo->resv->lock);
-			}
-
-			if (ret == -EDEADLK) {
-				contended_lock = i;
-				goto retry;
-			}
-
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
+	ww_mutex_lock_for_each(for (i = 0; i < exec->bo_count; i++),
+			       &exec->bo[i]->base.resv->lock, contended, ret,
+			       true, acquire_ctx)
+		if (ret)
+			goto error;
 
 	ww_acquire_done(acquire_ctx);
 
@@ -648,6 +612,12 @@ vc4_lock_bo_reservations(struct drm_device *dev,
 	}
 
 	return 0;
+
+error:
+	ww_mutex_unlock_for_each(for (i = 0; i < exec->bo_count; i++),
+				 &exec->bo[i]->base.resv->lock, contended);
+	ww_acquire_done(acquire_ctx);
+	return ret;
 }
 
 /* Queues a struct vc4_exec_info for execution.  If no job is
-- 
2.17.1

