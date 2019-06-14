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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961FBC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A65F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGBD+TBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfFNMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfFNMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2405736wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LQVSIEeD0nQzbNe4535DUZpv1oRub2NRc611Dv3vQ2E=;
        b=OGBD+TBx8N5h5M7hqo9FLX4pLxhzEZsCYqoAEaTl7ua/mP0uHew+Lqcg9A7yeKJIcJ
         KNs0dPdBzQH2l/YVDrrvsoWAK7N4/c0BD+0edugp+RFN9ay8P8dmMXS/NiaERFiGk8Og
         Z2Tl6XU0+Nb8PqL2WodA/Dskr7w9VTedd7TF/W6zbmOTOJaLDe+Z4S0p4KMKB4O61Ghx
         EOmdsGe7lKv5KG/H8b/dCUxv6Vh4KCorOFGnI5vW2AIEG+28pG1pdiz8p3feCjMsjHmh
         DJTt8Fjrw9BtvlXIgfMTWOBwZ58TxTogvySRswGvxJnwPfzC7rmEzGbOAIsTN7ljoV7h
         wLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQVSIEeD0nQzbNe4535DUZpv1oRub2NRc611Dv3vQ2E=;
        b=RbtmYBE6OyDVNkIAXns+T2psBOM0fc1HCOadaFntL8d5EvfHgakaLZ/P9pPsO0IOMN
         7czZ8wpX/ED1HeTPH1vuQBPlbuOw+R/ZpuOX0hBdZ4QeXV7cSVfTdGUOgmvxiAvZOZWT
         DoqNp/HvM/lGxlcGt+BncHTfCnL1Us+6mWdlnRsxSTm1WTg8YWZ8g6gk73MJfuIBwOOW
         5v3qc4NNeWhgbKoaEzc5ZznH8FWNXJf3MPQpUUFrKEkOLwjXdmtIPBSZlq53wC/kqOmB
         h8dz4fGHnBXrpw6bqhuDqua5xGzSoj3jAiYCZYOvMxG/I+rS9tfTDPyxGspb9wMjKJxy
         +WmQ==
X-Gm-Message-State: APjAAAWS1+CmqekSu8yRf5//piS5PLBEAZPuFrYYE5i+UvFqqQq51ARU
        dcjSPipGW1PwXaEaUdpISxeBOkzX
X-Google-Smtp-Source: APXvYqzEdAgdauf41YwPRc3SYhWnz6aN1kSFojwDXPTchHah0RZrzIl9XgaiXofcDmaHzXYGkQX60Q==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr65247584wrw.306.1560516089779;
        Fri, 14 Jun 2019 05:41:29 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:29 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 2/6] drm/ttm: use new ww_mutex_(un)lock_for_each macros
Date:   Fri, 14 Jun 2019 14:41:21 +0200
Message-Id: <20190614124125.124181-3-christian.koenig@amd.com>
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
 drivers/gpu/drm/ttm/ttm_execbuf_util.c | 87 +++++++++-----------------
 1 file changed, 30 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 957ec375a4ba..3c3ac6c94d7f 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -33,16 +33,6 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 
-static void ttm_eu_backoff_reservation_reverse(struct list_head *list,
-					      struct ttm_validate_buffer *entry)
-{
-	list_for_each_entry_continue_reverse(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-
-		reservation_object_unlock(bo->resv);
-	}
-}
-
 static void ttm_eu_del_from_lru_locked(struct list_head *list)
 {
 	struct ttm_validate_buffer *entry;
@@ -96,8 +86,9 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			   struct list_head *list, bool intr,
 			   struct list_head *dups, bool del_lru)
 {
-	struct ttm_bo_global *glob;
 	struct ttm_validate_buffer *entry;
+	struct ww_mutex *contended;
+	struct ttm_bo_global *glob;
 	int ret;
 
 	if (list_empty(list))
@@ -109,68 +100,39 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 	if (ticket)
 		ww_acquire_init(ticket, &reservation_ww_class);
 
-	list_for_each_entry(entry, list, head) {
+	ww_mutex_lock_for_each(list_for_each_entry(entry, list, head),
+			       &entry->bo->resv->lock, contended, ret,
+			       intr, ticket)
+	{
 		struct ttm_buffer_object *bo = entry->bo;
 
-		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
 		if (!ret && unlikely(atomic_read(&bo->cpu_writers) > 0)) {
 			reservation_object_unlock(bo->resv);
-
 			ret = -EBUSY;
+			goto error;
+		}
 
-		} else if (ret == -EALREADY && dups) {
+		if (ret == -EALREADY && dups) {
 			struct ttm_validate_buffer *safe = entry;
+
 			entry = list_prev_entry(entry, head);
 			list_del(&safe->head);
 			list_add(&safe->head, dups);
 			continue;
 		}
 
-		if (!ret) {
-			if (!entry->num_shared)
-				continue;
-
-			ret = reservation_object_reserve_shared(bo->resv,
-								entry->num_shared);
-			if (!ret)
-				continue;
-		}
+		if (unlikely(ret))
+			goto error;
 
-		/* uh oh, we lost out, drop every reservation and try
-		 * to only reserve this buffer, then start over if
-		 * this succeeds.
-		 */
-		ttm_eu_backoff_reservation_reverse(list, entry);
-
-		if (ret == -EDEADLK) {
-			if (intr) {
-				ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
-								       ticket);
-			} else {
-				ww_mutex_lock_slow(&bo->resv->lock, ticket);
-				ret = 0;
-			}
-		}
+		if (!entry->num_shared)
+			continue;
 
-		if (!ret && entry->num_shared)
-			ret = reservation_object_reserve_shared(bo->resv,
-								entry->num_shared);
-
-		if (unlikely(ret != 0)) {
-			if (ret == -EINTR)
-				ret = -ERESTARTSYS;
-			if (ticket) {
-				ww_acquire_done(ticket);
-				ww_acquire_fini(ticket);
-			}
-			return ret;
+		ret = reservation_object_reserve_shared(bo->resv,
+							entry->num_shared);
+		if (unlikely(ret)) {
+			reservation_object_unlock(bo->resv);
+			goto error;
 		}
-
-		/* move this item to the front of the list,
-		 * forces correct iteration of the loop without keeping track
-		 */
-		list_del(&entry->head);
-		list_add(&entry->head, list);
 	}
 
 	if (del_lru) {
@@ -179,6 +141,17 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		spin_unlock(&glob->lru_lock);
 	}
 	return 0;
+
+error:
+	ww_mutex_unlock_for_each(list_for_each_entry(entry, list, head),
+				 &entry->bo->resv->lock, contended);
+	if (ret == -EINTR)
+		ret = -ERESTARTSYS;
+	if (ticket) {
+		ww_acquire_done(ticket);
+		ww_acquire_fini(ticket);
+	}
+	return ret;
 }
 EXPORT_SYMBOL(ttm_eu_reserve_buffers);
 
-- 
2.17.1

