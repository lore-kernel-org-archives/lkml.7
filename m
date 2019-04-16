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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B975C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348CF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKKdLaZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfDPSjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40290 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfDPSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so28499274wre.7;
        Tue, 16 Apr 2019 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e/bMfpTA4NY7PCVgTGYtMz12DKZOhfy3t2Mwhe7/vv8=;
        b=jKKdLaZNPZxaa2NOPAEI9VsXF8DT7D3K41ir+8NFXOGc6/KrL5sJN+zQwExL6LHqus
         kSrU6l0+PYXrHL29GyrzywvYm3HH8FcjEd1tPvh/kEO7nA5BwW1bkmiVTrK7xt0mYR+5
         UqdNiSFsVGHhBQsaLV/QLf38OlIy5J0pXyPj/DU4+Xhc0zyg/3EFN3EddnS25sHUOAej
         fwoUSit00mlUZlxsYnblomMEkT0Z6K/B8KS28ZYYiLoO0v0+h7zgsguV7jK2Lwxrhpuw
         Z3j60FMMNyhcwkRyKkmvf6adtRq2zmcBCq2ttnEtgLU0Tj4nTaZhgvg4KNE+8yVxA1YS
         6g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/bMfpTA4NY7PCVgTGYtMz12DKZOhfy3t2Mwhe7/vv8=;
        b=iXtsDPspOou/r+CMbYRJ+87TLUWOmHk+rtKuQJwFgcP4GNwv+n7zL8fQkO4loHht3D
         wgn5EPJ3nWaPQzuX680XaFbusS8mZVmlHwcLO/kUVTDl0XiSENZWzM4yYYnpsT7CL0RK
         xuCmFNXJ7VaPgCsfde7I9pPKOV2KzFck6KZwrwrGlYzssII0Dhf0OOcSpISL2lLOIemK
         7WwRMttaT/52mkzJNOHJGEbdOTMZMmnPgATOXWShWVc2Zp6N9Oz10DqUGJ01QKgc912F
         n2hGF9T2Ho6++uR8kN0EolV+XnIh4kvxX4dRopRnnEkhOpRw5X+NjTFb4zqTtDHjULAZ
         pJWQ==
X-Gm-Message-State: APjAAAU5dwinzAjnqqbOkEaZR5QR+sb0MEtg2S4VgOuQAI/5fAkuD6CQ
        b3aaS/ozorhdtvnUfvuHBRI=
X-Google-Smtp-Source: APXvYqwuvkG60OJ4P7pl8Lse3NlhRcb2EjqpR0R5oiDfxac/1bnPN3SeiXMXj9PZRsfky3tVn5j3hg==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr34963537wrq.280.1555439932185;
        Tue, 16 Apr 2019 11:38:52 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:51 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm: remove prime sg_table caching
Date:   Tue, 16 Apr 2019 20:38:35 +0200
Message-Id: <20190416183841.1577-7-christian.koenig@amd.com>
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

That is now done by the DMA-buf helpers instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_prime.c | 76 ++++++++-----------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 1fadf5d5ed33..7e439ea3546a 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -86,11 +86,6 @@ struct drm_prime_member {
 	struct rb_node handle_rb;
 };
 
-struct drm_prime_attachment {
-	struct sg_table *sgt;
-	enum dma_data_direction dir;
-};
-
 static int drm_prime_add_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				    struct dma_buf *dma_buf, uint32_t handle)
 {
@@ -188,25 +183,16 @@ static int drm_prime_lookup_buf_handle(struct drm_prime_file_private *prime_fpri
  * @dma_buf: buffer to attach device to
  * @attach: buffer attachment data
  *
- * Allocates &drm_prime_attachment and calls &drm_driver.gem_prime_pin for
- * device specific attachment. This can be used as the &dma_buf_ops.attach
- * callback.
+ * Calls &drm_driver.gem_prime_pin for device specific handling. This can be
+ * used as the &dma_buf_ops.attach callback.
  *
  * Returns 0 on success, negative error code on failure.
  */
 int drm_gem_map_attach(struct dma_buf *dma_buf,
 		       struct dma_buf_attachment *attach)
 {
-	struct drm_prime_attachment *prime_attach;
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	prime_attach = kzalloc(sizeof(*prime_attach), GFP_KERNEL);
-	if (!prime_attach)
-		return -ENOMEM;
-
-	prime_attach->dir = DMA_NONE;
-	attach->priv = prime_attach;
-
 	return drm_gem_pin(obj);
 }
 EXPORT_SYMBOL(drm_gem_map_attach);
@@ -222,26 +208,8 @@ EXPORT_SYMBOL(drm_gem_map_attach);
 void drm_gem_map_detach(struct dma_buf *dma_buf,
 			struct dma_buf_attachment *attach)
 {
-	struct drm_prime_attachment *prime_attach = attach->priv;
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	if (prime_attach) {
-		struct sg_table *sgt = prime_attach->sgt;
-
-		if (sgt) {
-			if (prime_attach->dir != DMA_NONE)
-				dma_unmap_sg_attrs(attach->dev, sgt->sgl,
-						   sgt->nents,
-						   prime_attach->dir,
-						   DMA_ATTR_SKIP_CPU_SYNC);
-			sg_free_table(sgt);
-		}
-
-		kfree(sgt);
-		kfree(prime_attach);
-		attach->priv = NULL;
-	}
-
 	drm_gem_unpin(obj);
 }
 EXPORT_SYMBOL(drm_gem_map_detach);
@@ -286,39 +254,22 @@ void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpr
 struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
 				     enum dma_data_direction dir)
 {
-	struct drm_prime_attachment *prime_attach = attach->priv;
 	struct drm_gem_object *obj = attach->dmabuf->priv;
 	struct sg_table *sgt;
 
-	if (WARN_ON(dir == DMA_NONE || !prime_attach))
+	if (WARN_ON(dir == DMA_NONE))
 		return ERR_PTR(-EINVAL);
 
-	/* return the cached mapping when possible */
-	if (prime_attach->dir == dir)
-		return prime_attach->sgt;
-
-	/*
-	 * two mappings with different directions for the same attachment are
-	 * not allowed
-	 */
-	if (WARN_ON(prime_attach->dir != DMA_NONE))
-		return ERR_PTR(-EBUSY);
-
 	if (obj->funcs)
 		sgt = obj->funcs->get_sg_table(obj);
 	else
 		sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
 
-	if (!IS_ERR(sgt)) {
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC)) {
-			sg_free_table(sgt);
-			kfree(sgt);
-			sgt = ERR_PTR(-ENOMEM);
-		} else {
-			prime_attach->sgt = sgt;
-			prime_attach->dir = dir;
-		}
+	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
+			      DMA_ATTR_SKIP_CPU_SYNC)) {
+		sg_free_table(sgt);
+		kfree(sgt);
+		sgt = ERR_PTR(-ENOMEM);
 	}
 
 	return sgt;
@@ -331,14 +282,19 @@ EXPORT_SYMBOL(drm_gem_map_dma_buf);
  * @sgt: scatterlist info of the buffer to unmap
  * @dir: direction of DMA transfer
  *
- * Not implemented. The unmap is done at drm_gem_map_detach().  This can be
- * used as the &dma_buf_ops.unmap_dma_buf callback.
+ * This can be used as the &dma_buf_ops.unmap_dma_buf callback.
  */
 void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
 			   struct sg_table *sgt,
 			   enum dma_data_direction dir)
 {
-	/* nothing to be done here */
+	if (!sgt)
+		return;
+
+	dma_unmap_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
+			   DMA_ATTR_SKIP_CPU_SYNC);
+	sg_free_table(sgt);
+	kfree(sgt);
 }
 EXPORT_SYMBOL(drm_gem_unmap_dma_buf);
 
-- 
2.17.1

