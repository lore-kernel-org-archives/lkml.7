Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D4B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwKD064r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfDPSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbfDPSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so28526321wrp.0;
        Tue, 16 Apr 2019 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JeBlbexg079RZIlnX/Tm9rmA/UxC3OfguN8akv7z74g=;
        b=XwKD064rKWxHzoMMm4gKJqm8wil2WwGUuB/Mg582rXmSb6/MkAXDl5vFbkKL5kcf9C
         Y7JocFy+Hf+2q5PtMsgrXep7rxKoLHmB3kyMw7TZ7EOHsupcvKBBrZQD71pv7Fvqj3rq
         aCL+5ymfd/fFg5eQsZE6oq6Uix5X85UU2zJ7pFmNPv+EF/XFDXSb2fpVHzrGBwWRRiJF
         nXa/AtYc+FxVcYtlgffUSIpBufmd+JY6lpOhIgjO+0C3SNhqtMp3ecj06IEOdjz3wEPf
         eF0zi8WFp4XrNUXudrY4Scx31W1o0PuY2XNR3FWT8fJh+SrCwnax9WDnZUPkpaDBY4ST
         EpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeBlbexg079RZIlnX/Tm9rmA/UxC3OfguN8akv7z74g=;
        b=uGv3vyC4p5S/tP8p/8cgIMx+UviOKMdVXXdYfxK/j+nnOTmq2N0QBTIKQrfZeQR17b
         g3Y0i1kw3bBUBzLmWCjVelvex/zCAaFngWG0EhGzWSplEYofQr4gUbs1g+shYWh2ys+i
         zmuQOOmw4IZoISqIfay2Y6f2oXNMCrUpjKC+SOe5G1xrUL8wtzaKv9uiqgJa0F3InCZn
         JN/eUP2Bjo9wD9zToKi+g3kUXtOhyomtxB3OCOUaw4uJDdpOm768UhHQ8WoudRuTY9Eg
         pGRxARIMavXezQlIVfN8dF3QpMGY2+3EObmNmtFnmFxd2Mr8goHUl6UTqAI0D4U9kupf
         ae2A==
X-Gm-Message-State: APjAAAX0UEGplib1Qhhx69911uOTv9DQY6gyZzODGPHS+QggzPbzNPS6
        hBwQ1bUWPXTb34w6bnHzoY4=
X-Google-Smtp-Source: APXvYqzQDu0rooj+lH+tX8mk8Eeul1orwZ2Q3u5RFHJB/13lOykkVDg0nkaWswSe+EuBeI8akmx/qw==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr55446489wrp.298.1555439937182;
        Tue, 16 Apr 2019 11:38:57 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:56 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amdgpu: add DMA-buf invalidation callback v2
Date:   Tue, 16 Apr 2019 20:38:41 +0200
Message-Id: <20190416183841.1577-13-christian.koenig@amd.com>
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

Allow for invalidation of imported DMA-bufs.

v2: add dma_buf_pin/dma_buf_unpin support

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c  | 24 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fdb98eb562db..c3a5a115bfc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -848,6 +848,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		return 0;
 	}
 
+	if (bo->gem_base.import_attach)
+		dma_buf_pin(bo->gem_base.import_attach->dmabuf);
+
 	bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	/* force to pin into visible video ram */
 	if (!(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS))
@@ -931,6 +934,9 @@ int amdgpu_bo_unpin(struct amdgpu_bo *bo)
 
 	amdgpu_bo_subtract_pin_size(bo);
 
+	if (bo->gem_base.import_attach)
+		dma_buf_unpin(bo->gem_base.import_attach->dmabuf);
+
 	for (i = 0; i < bo->placement.num_placement; i++) {
 		bo->placements[i].lpfn = 0;
 		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index 40cd89271b20..30634396719b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -459,6 +459,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 	return buf;
 }
 
+/**
+ * amdgpu_gem_prime_invalidate_mappings - &attach.invalidate implementation
+ *
+ * @attach: the DMA-buf attachment
+ *
+ * Invalidate the DMA-buf attachment, making sure that the we re-create the
+ * mapping before the next use.
+ */
+static void
+amdgpu_gem_prime_invalidate_mappings(struct dma_buf_attachment *attach)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct drm_gem_object *obj = attach->importer_priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct ttm_placement placement = {};
+	int r;
+
+	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
+	if (r)
+		DRM_ERROR("Failed to invalidate DMA-buf import (%d))\n", r);
+}
+
 /**
  * amdgpu_gem_prime_import - &drm_driver.gem_prime_import implementation
  * @dev: DRM device
@@ -476,6 +498,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	struct dma_buf_attach_info attach_info = {
 		.dev = dev->dev,
 		.dmabuf = dma_buf,
+		.invalidate = amdgpu_gem_prime_invalidate_mappings
 	};
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
@@ -496,6 +519,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	if (IS_ERR(obj))
 		return obj;
 
+	attach_info.importer_priv = obj;
 	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach)) {
 		drm_gem_object_put(obj);
-- 
2.17.1

