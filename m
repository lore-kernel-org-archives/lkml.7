Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B903C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNEI9YUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfFNMld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfFNMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2366686wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tr871nsuPUessZ2bWQYw8KM2Rhm9zDW+q+EHUwqz0SI=;
        b=HNEI9YUO4lBZW0DBXk5plxjkkx4xQ/YflRzByiAcXkH4cwflz+XvBCOOwzXZJLhC7o
         GxW+Ubr+oumu4sc42tY/cVho0+2gxLTw3mEiM4rCWRtJwVngZqQkV3kClYv17EqkKbuK
         FUIvtVA461czRvWSdgj8+yTRwMkYtsEXoPgP254I9QQsVtkaT5xOphCi0t6bNtnSb74A
         MBbglKuALMuorwBp59wdDD/wFDPtd8wnzn1R08YUDBUz3m6w/clWTtB/Af1EhDcwV4Gd
         90zc9J/Jq1I/38b1uBkaPxUsNL1q6p4PSwqJtuKHElDjOds3g+uHBURvFk4hUX/OtMVz
         nIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tr871nsuPUessZ2bWQYw8KM2Rhm9zDW+q+EHUwqz0SI=;
        b=gN9y75P9FfJk3CrM3LSNIp1kTBuT4e8Xz26BPoSyEUPdMvE1+rP0xkyW8rbDTYCcJ8
         vslM0Fi4mAYxAusbUVB7sieJW0ZOTXEy1CMs7KpfHVNIYcsSI5+c+SJTDhgxQHeD9nnZ
         ZIW7C8yjFJEd0mNkhGFZyBN6CW3KlHULGyTXPpJD6WOjQ26zzeAdAOhNTa2l+o7kb/Ap
         thLQpplLZB74T0SH1+YC12FKxPDKPCvQeYpsqxqlCCLa7/OKbBkU1TxqPNTiLBmK8yh0
         UDzw5nY0va73yO54Kf+Aqd6k6v7T37JzY00dmbtmQ9XXGLmnt10nlZDnjcsX2qYLrqyA
         6AyA==
X-Gm-Message-State: APjAAAW4kbLns374pk2mmmW3PoHYzHQWuUUxfxOorgZL+F8slsvVNqxB
        Z5f+p4QsYdY9UdRDSqCxVxw=
X-Google-Smtp-Source: APXvYqyzNlBKJCoQuX4ZgsYHo08dDzivgT9Ft6RDIkjEsdB1jkl76sickuRQBFCGcXcmKEYfhM0ncw==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr28050488wrs.116.1560516091594;
        Fri, 14 Jun 2019 05:41:31 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:31 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 4/6] drm/etnaviv: use new ww_mutex_(un)lock_for_each macros
Date:   Fri, 14 Jun 2019 14:41:23 +0200
Message-Id: <20190614124125.124181-5-christian.koenig@amd.com>
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
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 55 +++++---------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index e054f09ac828..923b8a71f80d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -118,55 +118,28 @@ static void submit_unlock_object(struct etnaviv_gem_submit *submit, int i)
 static int submit_lock_objects(struct etnaviv_gem_submit *submit,
 		struct ww_acquire_ctx *ticket)
 {
-	int contended, slow_locked = -1, i, ret = 0;
-
-retry:
-	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
-
-		if (slow_locked == i)
-			slow_locked = -1;
-
-		contended = i;
+	struct ww_mutex *contended;
+	int i, ret = 0;
 
-		if (!(submit->bos[i].flags & BO_LOCKED)) {
-			ret = ww_mutex_lock_interruptible(&obj->resv->lock,
-							  ticket);
-			if (ret == -EALREADY)
-				DRM_ERROR("BO at index %u already on submit list\n",
-					  i);
-			if (ret)
-				goto fail;
-			submit->bos[i].flags |= BO_LOCKED;
-		}
+	ww_mutex_lock_for_each(for (i = 0; i < submit->nr_bos; i++),
+			       &submit->bos[i].obj->base.resv->lock,
+			       contended, ret, true, ticket) {
+		if (ret == -EALREADY)
+			DRM_ERROR("BO at index %u already on submit list\n", i);
+		if (ret)
+			goto fail;
 	}
 
+	for (i = 0; i < submit->nr_bos; i++)
+		submit->bos[i].flags |= BO_LOCKED;
 	ww_acquire_done(ticket);
 
 	return 0;
 
 fail:
-	for (; i >= 0; i--)
-		submit_unlock_object(submit, i);
-
-	if (slow_locked > 0)
-		submit_unlock_object(submit, slow_locked);
-
-	if (ret == -EDEADLK) {
-		struct drm_gem_object *obj;
-
-		obj = &submit->bos[contended].obj->base;
-
-		/* we lost out in a seqno race, lock and retry.. */
-		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
-						       ticket);
-		if (!ret) {
-			submit->bos[contended].flags |= BO_LOCKED;
-			slow_locked = contended;
-			goto retry;
-		}
-	}
-
+	ww_mutex_unlock_for_each(for (i = 0; i < submit->nr_bos; i++),
+				 &submit->bos[i].obj->base.resv->lock,
+				 contended);
 	return ret;
 }
 
-- 
2.17.1

