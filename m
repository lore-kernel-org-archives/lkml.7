Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0598D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqCLyoUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDPSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45480 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfDPSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so28448489wra.12;
        Tue, 16 Apr 2019 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YHP56/x8Y0vj9UsUHargeze959GmvGO+zgN4AFX2eV8=;
        b=tqCLyoUXlj5bU4CWRw2h01Gk2EfBDnhv1d6JQoxTTHBm7somvhMaJmk+llXBmlJEAz
         BD0M3IHJjaxUpQlgHVzP1053DSJpR0NjMwLGumjNyCL1GY7tuY6MOWQ9KIqRTSwIHFqY
         RpCmPSqY7k3tNrSTRU92QwbtYO5OqJZHcZmLJ+AXA1FTCNEbJ3Bi0xNyQ+Q9GC+7lTLU
         iDhUlg5r6syXdmeBVIU9NwAv07/cVOJZG43I038K0Z//Bs2nfwePS2dpgFolhx3ov2nn
         BZzF0nh6mQYOZGx6wO/fHNzptHYMHgVBwRgJf7VW1ZU1QpPLWj93EHtuA4JlAdW5Tzf6
         eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHP56/x8Y0vj9UsUHargeze959GmvGO+zgN4AFX2eV8=;
        b=TVP+wqlsW2J9m5D4f7qem9GBJ2E/Us35bwm6JcVAugWt/2tshykC6/jED78H/+20YE
         ZfhwrtcKHAJKDdPBiz/CVjo6CZ2LjMKN2RhVxer0Ft+7Vs2sd8q9fmfEMEY7yJpb2foN
         6pfSwKMvMhyw8UpW/p3BS45KW28WtDzPyR9Mc4UyduqcV4tt9l6qcebWuNpSyxm+gPBu
         dwRuBixBCUeHkxkku7uJmRoOUbMFuRxVYD//X/ajzU9+voIdRXUITXw64BIDBiDRocJs
         M6RtoAcDiqi+Vn9bA0qAakq8nT43s5tEnwmukyd0obKBYrzxDhts/XtKumFT/NrqT+5d
         64wQ==
X-Gm-Message-State: APjAAAUieY7qkbAJ5i/Ya9gQxWwXr4OXENu+3n+zcO1sbH8lkfhfGn74
        gEQIwhQJcT/IrTIvFSYXyPEQaJM0
X-Google-Smtp-Source: APXvYqzBqW1/u8EB5MTMX+pFMF1VzudtLXi5fspXg48y8SjZWJZPXHjzMX6D6YkikiZVgQbcr5drdA==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr22752424wrl.262.1555439929291;
        Tue, 16 Apr 2019 11:38:49 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:48 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/12] dma-buf: lock the reservation object during (un)map_dma_buf v3
Date:   Tue, 16 Apr 2019 20:38:32 +0200
Message-Id: <20190416183841.1577-4-christian.koenig@amd.com>
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

Make it mandatory for dynamic dma-buf callbacks to be called with the
reservation lock held.

For static dma-buf exporters we still have the fallback of using cached sgt.

v2: reordered
v3: rebased on sgt caching
v4: use the cached sgt when possible

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c                     | 24 ++++++++++---------
 drivers/gpu/drm/armada/armada_gem.c           |  6 ++++-
 drivers/gpu/drm/drm_prime.c                   |  6 ++++-
 drivers/gpu/drm/i915/i915_gem_dmabuf.c        |  6 ++++-
 drivers/gpu/drm/tegra/gem.c                   |  6 ++++-
 drivers/gpu/drm/udl/udl_dmabuf.c              |  6 ++++-
 .../common/videobuf2/videobuf2-dma-contig.c   |  6 ++++-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  6 ++++-
 drivers/staging/media/tegra-vde/tegra-vde.c   |  6 ++++-
 include/linux/dma-buf.h                       | 23 ++++++++++++++++--
 10 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ef480e5fb239..83c92bfd964c 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -532,8 +532,9 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
 /**
  * dma_buf_attach - Add the device to dma_buf's attachments list; optionally,
  * calls attach() of dma_buf_ops to allow device-specific attach functionality
- * @dmabuf:	[in]	buffer to attach device to.
- * @dev:	[in]	device to be attached.
+ * @info:	[in]	holds all the attach related information provided
+ *			by the importer. see &struct dma_buf_attach_info
+ *			for further details.
  *
  * Returns struct dma_buf_attachment pointer for this attachment. Attachments
  * must be cleaned up by calling dma_buf_detach().
@@ -547,20 +548,20 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
  * accessible to @dev, and cannot be moved to a more suitable place. This is
  * indicated with the error code -EBUSY.
  */
-struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
-					  struct device *dev)
+struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info)
 {
+	struct dma_buf *dmabuf = info->dmabuf;
 	struct dma_buf_attachment *attach;
 	int ret;
 
-	if (WARN_ON(!dmabuf || !dev))
+	if (WARN_ON(!dmabuf || !info->dev))
 		return ERR_PTR(-EINVAL);
 
 	attach = kzalloc(sizeof(*attach), GFP_KERNEL);
 	if (!attach)
 		return ERR_PTR(-ENOMEM);
 
-	attach->dev = dev;
+	attach->dev = info->dev;
 	attach->dmabuf = dmabuf;
 
 	mutex_lock(&dmabuf->lock);
@@ -688,9 +689,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 	if (attach->sgt)
 		return attach->sgt;
 
-	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
-	if (!sg_table)
-		sg_table = ERR_PTR(-ENOMEM);
+	reservation_object_lock(attach->dmabuf->resv, NULL);
+	sg_table = dma_buf_map_attachment_locked(attach, direction);
+	reservation_object_unlock(attach->dmabuf->resv);
 
 	return sg_table;
 }
@@ -744,8 +745,9 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
 	if (attach->sgt == sg_table)
 		return;
 
-	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
-						direction);
+	reservation_object_lock(attach->dmabuf->resv, NULL);
+	dma_buf_unmap_attachment_locked(attach, sg_table, direction);
+	reservation_object_unlock(attach->dmabuf->resv);
 }
 EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
 
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 642d0e70d0f8..19c47821032f 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -501,6 +501,10 @@ armada_gem_prime_export(struct drm_device *dev, struct drm_gem_object *obj,
 struct drm_gem_object *
 armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev->dev,
+		.dmabuf = buf
+	};
 	struct dma_buf_attachment *attach;
 	struct armada_gem_object *dobj;
 
@@ -516,7 +520,7 @@ armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
 		}
 	}
 
-	attach = dma_buf_attach(buf, dev->dev);
+	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach))
 		return ERR_CAST(attach);
 
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 231e3f6d5f41..1fadf5d5ed33 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -709,6 +709,10 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 					    struct dma_buf *dma_buf,
 					    struct device *attach_dev)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = attach_dev,
+		.dmabuf = dma_buf
+	};
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
 	struct drm_gem_object *obj;
@@ -729,7 +733,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 	if (!dev->driver->gem_prime_import_sg_table)
 		return ERR_PTR(-EINVAL);
 
-	attach = dma_buf_attach(dma_buf, attach_dev);
+	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach))
 		return ERR_CAST(attach);
 
diff --git a/drivers/gpu/drm/i915/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
index 82e2ca17a441..aa7f685bd6ca 100644
--- a/drivers/gpu/drm/i915/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
@@ -277,6 +277,10 @@ static const struct drm_i915_gem_object_ops i915_gem_object_dmabuf_ops = {
 struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 					     struct dma_buf *dma_buf)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev->dev,
+		.dmabuf = dma_buf
+	};
 	struct dma_buf_attachment *attach;
 	struct drm_i915_gem_object *obj;
 	int ret;
@@ -295,7 +299,7 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 	}
 
 	/* need to attach */
-	attach = dma_buf_attach(dma_buf, dev->dev);
+	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach))
 		return ERR_CAST(attach);
 
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 4f80100ff5f3..8e6b6c879add 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -332,6 +332,10 @@ struct tegra_bo *tegra_bo_create_with_handle(struct drm_file *file,
 static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
 					struct dma_buf *buf)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = drm->dev,
+		.dmabuf = buf
+	};
 	struct tegra_drm *tegra = drm->dev_private;
 	struct dma_buf_attachment *attach;
 	struct tegra_bo *bo;
@@ -341,7 +345,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
 	if (IS_ERR(bo))
 		return bo;
 
-	attach = dma_buf_attach(buf, drm->dev);
+	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach)) {
 		err = PTR_ERR(attach);
 		goto free;
diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c b/drivers/gpu/drm/udl/udl_dmabuf.c
index 556f62662aa9..86b928f9742f 100644
--- a/drivers/gpu/drm/udl/udl_dmabuf.c
+++ b/drivers/gpu/drm/udl/udl_dmabuf.c
@@ -226,6 +226,10 @@ static int udl_prime_create(struct drm_device *dev,
 struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
 				struct dma_buf *dma_buf)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev->dev,
+		.dmabuf = dma_buf
+	};
 	struct dma_buf_attachment *attach;
 	struct sg_table *sg;
 	struct udl_gem_object *uobj;
@@ -233,7 +237,7 @@ struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
 
 	/* need to attach */
 	get_device(dev->dev);
-	attach = dma_buf_attach(dma_buf, dev->dev);
+	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach)) {
 		put_device(dev->dev);
 		return ERR_CAST(attach);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index aff0ab7bf83d..1f2687b5eb0e 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -676,6 +676,10 @@ static void vb2_dc_detach_dmabuf(void *mem_priv)
 static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
 	unsigned long size, enum dma_data_direction dma_dir)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev,
+		.dmabuf = dbuf
+	};
 	struct vb2_dc_buf *buf;
 	struct dma_buf_attachment *dba;
 
@@ -691,7 +695,7 @@ static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
 
 	buf->dev = dev;
 	/* create attachment for the dmabuf with the user device */
-	dba = dma_buf_attach(dbuf, buf->dev);
+	dba = dma_buf_attach(&attach_info);
 	if (IS_ERR(dba)) {
 		pr_err("failed to attach dmabuf\n");
 		kfree(buf);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 015e737095cd..cbd626d2393a 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -608,6 +608,10 @@ static void vb2_dma_sg_detach_dmabuf(void *mem_priv)
 static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
 	unsigned long size, enum dma_data_direction dma_dir)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev,
+		.dmabuf = dbuf
+	};
 	struct vb2_dma_sg_buf *buf;
 	struct dma_buf_attachment *dba;
 
@@ -623,7 +627,7 @@ static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
 
 	buf->dev = dev;
 	/* create attachment for the dmabuf with the user device */
-	dba = dma_buf_attach(dbuf, buf->dev);
+	dba = dma_buf_attach(&attach_info);
 	if (IS_ERR(dba)) {
 		pr_err("failed to attach dmabuf\n");
 		kfree(buf);
diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
index aa6c6bba961e..5a10c1facc27 100644
--- a/drivers/staging/media/tegra-vde/tegra-vde.c
+++ b/drivers/staging/media/tegra-vde/tegra-vde.c
@@ -568,6 +568,10 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
 				   size_t *size,
 				   enum dma_data_direction dma_dir)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev,
+		.dmabuf = dmabuf
+	};
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dmabuf;
 	struct sg_table *sgt;
@@ -591,7 +595,7 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
 		return -EINVAL;
 	}
 
-	attachment = dma_buf_attach(dmabuf, dev);
+	attachment = dma_buf_attach(&attach_info);
 	if (IS_ERR(attachment)) {
 		dev_err(dev, "Failed to attach dmabuf\n");
 		err = PTR_ERR(attachment);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 18a78be53541..7e23758db3a4 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -128,6 +128,9 @@ struct dma_buf_ops {
 	 * any other kind of sharing that the exporter might wish to make
 	 * available to buffer-users.
 	 *
+	 * This is always called with the dmabuf->resv object locked when
+	 * no_sgt_cache is true.
+	 *
 	 * Returns:
 	 *
 	 * A &sg_table scatter list of or the backing storage of the DMA buffer,
@@ -148,6 +151,9 @@ struct dma_buf_ops {
 	 * It should also unpin the backing storage if this is the last mapping
 	 * of the DMA buffer, it the exporter supports backing storage
 	 * migration.
+	 *
+	 * This is always called with the dmabuf->resv object locked when
+	 * no_sgt_cache is true.
 	 */
 	void (*unmap_dma_buf)(struct dma_buf_attachment *,
 			      struct sg_table *,
@@ -370,6 +376,19 @@ struct dma_buf_export_info {
 	struct dma_buf_export_info name = { .exp_name = KBUILD_MODNAME, \
 					 .owner = THIS_MODULE }
 
+/**
+ * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
+ * @dmabuf:	the exported dma_buf
+ * @dev:	the device which wants to import the attachment
+ *
+ * This structure holds the information required to attach to a buffer. Used
+ * with dma_buf_attach() only.
+ */
+struct dma_buf_attach_info {
+	struct dma_buf *dmabuf;
+	struct device *dev;
+};
+
 /**
  * get_dma_buf - convenience wrapper for get_file.
  * @dmabuf:	[in]	pointer to dma_buf
@@ -384,8 +403,8 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
 	get_file(dmabuf->file);
 }
 
-struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
-							struct device *dev);
+struct dma_buf_attachment *
+dma_buf_attach(const struct dma_buf_attach_info *info);
 void dma_buf_detach(struct dma_buf *dmabuf,
 				struct dma_buf_attachment *dmabuf_attach);
 
-- 
2.17.1

