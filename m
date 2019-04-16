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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A43DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CD020684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNMJuMa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfDPSj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfDPSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so28530945wrm.4;
        Tue, 16 Apr 2019 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M/kIjOqVGNv4vBgweSTRQ/BBvI/9hw4+zPVGvnTZMfc=;
        b=oNMJuMa5GyVmvUDw5A5Gfv0UMNnC0M+zMSU/Qmk44BqywANc1tkyAc689yuXQYf4ql
         6rWk9ANB4QO1AdurXSb25dMLVCQHCTn24K6+sXy1piiUkjhSJ1UmnhD9JeOzpXSusL/c
         sREJeQeSiOb1OQCp/f4EAZLhbywrb6q/S1c/rB0dPuF5RAX3tNBWZw0UqtX3lVOXe661
         3eky9XVttJl46y4A44gT6lJud+Je0a0H3xTHrBYIE9VdHtCDlNNjL61xDEeC2kSvyU2J
         y8IV3zoBeD3bjywUFpoOGeSUMTSW+dLleL7674fT1DCpcZrx4s9RHkmxMN1RZFSlv+n6
         7ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/kIjOqVGNv4vBgweSTRQ/BBvI/9hw4+zPVGvnTZMfc=;
        b=BvNQcKfHo3mGArXYvDHVWvfmcBMaQ3Rby2jLVvJQOwvJawZ46T1gksig5aifOP08hv
         7a3KN/3dyEi5ZaRAIKbZ9ODSZaspSV9GpOgIsdGmwqS9LDs7xL62HyZrq/ripgwqDQhZ
         YEjzUAv7Ys9/0rhQRMbji3Clk0qO95dxdmxAC6XSf0cXZygSjfdCIoUhNiPACiXwiEON
         04uW7pZucfuGsmreiU1BeMnITLtj1vWa5adhpiClEGpzS8pb7N1fRpv4VhOU35t74ult
         pJ6n8sAyq2Q40zASWxYDaTF/qnKSZxRDVzrzrb5eFDxNHkf+rHzq1e44Hl87cMEYjGWo
         nLyg==
X-Gm-Message-State: APjAAAUR2WYRiauwmUwF5aRnakWbdyVAn2F2qmlei4NHTfkJ0Jbv6iWC
        f8Oy9CYWHaVjFG1ZeP/mst0=
X-Google-Smtp-Source: APXvYqxZUn7++NixRcKL1qAEoNbTzB0Fm883zq8HolfhogN/cyy1NaSOhvun+e85JAlNh01unMRE/Q==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr25160351wru.104.1555439936203;
        Tue, 16 Apr 2019 11:38:56 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:55 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/amdgpu: add DMA-buf pin/unpin implementation
Date:   Tue, 16 Apr 2019 20:38:40 +0200
Message-Id: <20190416183841.1577-12-christian.koenig@amd.com>
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

Pin and unpin the DMA-buf exported BOs only on demand and invalidate all
DMA-buf mappings when the underlying BO moves.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c  | 73 ++++++++++++++++++++--
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ec9e45004bff..fdb98eb562db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -31,6 +31,7 @@
  */
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/dma-buf.h>
 #include <drm/drmP.h>
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
@@ -1192,6 +1193,10 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 
 	amdgpu_bo_kunmap(abo);
 
+	if (abo->gem_base.dma_buf && !abo->gem_base.import_attach &&
+	    bo->mem.mem_type != TTM_PL_SYSTEM)
+		dma_buf_invalidate_mappings(abo->gem_base.dma_buf);
+
 	/* remember the eviction */
 	if (evict)
 		atomic64_inc(&adev->num_evictions);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index 56e2a606b9a1..40cd89271b20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -209,6 +209,61 @@ __reservation_object_make_exclusive(struct reservation_object *obj)
 	return -ENOMEM;
 }
 
+/**
+ * amdgpu_gem_pin_dma_buf - &dma_buf_ops.pin_dma_buf implementation
+ *
+ * @dma_buf: DMA-buf to pin in memory
+ *
+ * Pin the BO which is backing the DMA-buf so that it can't move any more.
+ */
+static int amdgpu_gem_pin_dma_buf(struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+	/* pin buffer into GTT */
+	return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+}
+
+/**
+ * amdgpu_gem_unpin_dma_buf - &dma_buf_ops.unpin_dma_buf implementation
+ *
+ * @dma_buf: DMA-buf to unpin
+ *
+ * Unpin a previously pinned BO to make it movable again.
+ */
+static void amdgpu_gem_unpin_dma_buf(struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+	amdgpu_bo_unpin(bo);
+}
+
+/**
+ * amdgpu_gem_dma_buf_attach - &dma_buf_ops.attach implementation
+ *
+ * @dma_buf: DMA-buf we attach to
+ * @attach: DMA-buf attachment
+ *
+ * Returns:
+ * Always zero for success.
+ */
+static int amdgpu_gem_dma_buf_attach(struct dma_buf *dma_buf,
+				     struct dma_buf_attachment *attach)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+	/* Make sure the buffer is pinned when userspace didn't set GTT as
+	 * preferred domain. This avoid ping/pong situations with scan out BOs.
+	 */
+	if (!(bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT))
+		attach->invalidate = NULL;
+
+	return 0;
+}
+
 /**
  * amdgpu_gem_map_dma_buf - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
@@ -247,10 +302,15 @@ amdgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
 			return ERR_PTR(r);
 	}
 
-	/* pin buffer into GTT */
-	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
-	if (r)
-		return ERR_PTR(r);
+	if (attach->invalidate) {
+		/* move buffer into GTT */
+		struct ttm_operation_ctx ctx = { false, false };
+
+		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (r)
+			return ERR_PTR(r);
+	}
 
 	sgt = drm_prime_pages_to_sg(bo->tbo.ttm->pages, bo->tbo.num_pages);
 	if (IS_ERR(sgt))
@@ -289,8 +349,6 @@ static void amdgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
-	amdgpu_bo_unpin(bo);
-
 	if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
 		bo->prime_shared_count--;
 
@@ -357,6 +415,9 @@ static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.dynamic_sgt_mapping = true,
+	.attach = amdgpu_gem_dma_buf_attach,
+	.pin = amdgpu_gem_pin_dma_buf,
+	.unpin = amdgpu_gem_unpin_dma_buf,
 	.map_dma_buf = amdgpu_gem_map_dma_buf,
 	.unmap_dma_buf = amdgpu_gem_unmap_dma_buf,
 	.release = drm_gem_dmabuf_release,
-- 
2.17.1

