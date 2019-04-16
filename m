Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F53920684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukEXoOwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfDPSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39927 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfDPSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so28469313wrn.6;
        Tue, 16 Apr 2019 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/Q+iJ6rJZ2HsKCGJQjBe3G9bfJhGCGmYeQPjdB6XZUQ=;
        b=ukEXoOwEBqy3IRbtG1NbdOrME1rTGkJvvZv02W7F2Sc3QiNSgsezF8Cnnx3Th4sRoM
         rh4kX/FFL1bOeKq6VjVrZ+BIoHggOKFKYP6d5GhoIiPuc4TIEcQUZ2SUXArAWnoQELTN
         ue+BI22xwaXvu6KJ7W0rXZE8VapXmSkUAZtdhnKqd6gtAuMZVe8Rn7xHUPiyN+6KdH4M
         VaT70kxsacb8/zJbxNVgQaVkYlQBdBG2CMWYgnH8T9/XPoSiYhAljEjwE5/jnIMKuZdo
         P4Ej9iSQIf0MsVJh61NJkgGwYrxiaapRn7AVUtKqfrPGNMkdTv2i0HKO0cmxnA+WmsSi
         7mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Q+iJ6rJZ2HsKCGJQjBe3G9bfJhGCGmYeQPjdB6XZUQ=;
        b=aJsQ0DWwdnh01gd20bNZiRkBlA8QicHIQP1y5EvfgIxsuY3H43utWg5SDStAhXlrWe
         7r8gUWbtiqd5b92efIBO5st3a/U7NszK9Hdaut1rj4vaQf7jbT7szXv7jdBmEVbZqprS
         JMc4mJhLNAurSVLaD3f0phZUuX32dXYxm0F48+BIBa2JCsalr4ODsswW3XnQZKndWLTe
         T7G6CjnFqHaKC53GtaHk3MU/1d2kiPnLLO8/YAg9EZVBpdMg1+8gKiLplfU+kvjR8nQL
         LXfmp2l0VMafnsxFM21hnCoGmjyHkStHOJlXFRYCJdepV8SwmSNR84KIUviDzOxhhhk1
         XmSg==
X-Gm-Message-State: APjAAAUJoYDZNlrvify1fN45aVCTPs4AyrKZBKIbwiaRzWC2+LQDYd8P
        /outYtPXfq8drBylPucXjFU=
X-Google-Smtp-Source: APXvYqzagQP4Gn4DI1EX20qWMjFP8Qx2G4jr0CoOD2Mfs94vmMDvMtnm27LgxVW4l+EzQYIbQe1qtg==
X-Received: by 2002:adf:e288:: with SMTP id v8mr46638599wri.7.1555439933776;
        Tue, 16 Apr 2019 11:38:53 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:53 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/12] drm/ttm: use the parent resv for ghost objects
Date:   Tue, 16 Apr 2019 20:38:37 +0200
Message-Id: <20190416183841.1577-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we can even pipeline imported BO evictions.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 895d77d799e4..97f35c4bda35 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -486,7 +486,6 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 				      struct ttm_buffer_object **new_obj)
 {
 	struct ttm_transfer_obj *fbo;
-	int ret;
 
 	fbo = kmalloc(sizeof(*fbo), GFP_KERNEL);
 	if (!fbo)
@@ -517,10 +516,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.acc_size = 0;
-	fbo->base.resv = &fbo->base.ttm_resv;
-	reservation_object_init(fbo->base.resv);
-	ret = reservation_object_trylock(fbo->base.resv);
-	WARN_ON(!ret);
+	reservation_object_init(&fbo->base.ttm_resv);
 
 	*new_obj = &fbo->base;
 	return 0;
@@ -716,8 +712,6 @@ int ttm_bo_move_accel_cleanup(struct ttm_buffer_object *bo,
 		if (ret)
 			return ret;
 
-		reservation_object_add_excl_fence(ghost_obj->resv, fence);
-
 		/**
 		 * If we're not moving to fixed memory, the TTM object
 		 * needs to stay alive. Otherwhise hang it on the ghost
@@ -729,7 +723,6 @@ int ttm_bo_move_accel_cleanup(struct ttm_buffer_object *bo,
 		else
 			bo->ttm = NULL;
 
-		ttm_bo_unreserve(ghost_obj);
 		ttm_bo_put(ghost_obj);
 	}
 
@@ -772,8 +765,6 @@ int ttm_bo_pipeline_move(struct ttm_buffer_object *bo,
 		if (ret)
 			return ret;
 
-		reservation_object_add_excl_fence(ghost_obj->resv, fence);
-
 		/**
 		 * If we're not moving to fixed memory, the TTM object
 		 * needs to stay alive. Otherwhise hang it on the ghost
@@ -785,7 +776,6 @@ int ttm_bo_pipeline_move(struct ttm_buffer_object *bo,
 		else
 			bo->ttm = NULL;
 
-		ttm_bo_unreserve(ghost_obj);
 		ttm_bo_put(ghost_obj);
 
 	} else if (from->flags & TTM_MEMTYPE_FLAG_FIXED) {
@@ -841,16 +831,10 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
 	if (ret)
 		return ret;
 
-	ret = reservation_object_copy_fences(ghost->resv, bo->resv);
-	/* Last resort, wait for the BO to be idle when we are OOM */
-	if (ret)
-		ttm_bo_wait(bo, false, false);
-
 	memset(&bo->mem, 0, sizeof(bo->mem));
 	bo->mem.mem_type = TTM_PL_SYSTEM;
 	bo->ttm = NULL;
 
-	ttm_bo_unreserve(ghost);
 	ttm_bo_put(ghost);
 
 	return 0;
-- 
2.17.1

