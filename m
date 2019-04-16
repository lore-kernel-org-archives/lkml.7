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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3937DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0570E20449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdNvQxPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDPSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35358 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfDPSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so28502500wrp.2;
        Tue, 16 Apr 2019 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BeyFL0YvTGgnodFDzdo62bEx81WVOxS6em1BI9hl5QI=;
        b=WdNvQxPIytMj1qcS3y/Pq9ARofZCeXMA6QPWfLgWwIfqJ3w1/cqln6BvzQ+CWWsjRR
         W00cz5kc3ayYiyAje0jTewl9MZA5haY2iF3gJ29ZvEU43GHSW15zCPQu6iNgRUXeWl+t
         A1vRu09nyipkP67ybvY82LjNK8IhxKz4Hg1qUFDMhnR3x15o/2YFcCvXWcN9FAmPD6+U
         uxvXdJDWMsreyovaNvwmkg4/bFUWxIFSC8T8+O92WlpbIxhNdUDc3CQktbsYM6Cynnn/
         N9WaMqKKKpJlgcY7oIjGOop7ijew6jYL5g71vROQIq8/DEkR+ZUdVnvwqqVFKb4U3x1F
         CqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeyFL0YvTGgnodFDzdo62bEx81WVOxS6em1BI9hl5QI=;
        b=IYOaNHDbNHHdYewXJNpcYdPhWhndYdNRDyIlG2Z7SFfdXB4vG6YHrdks/YjCzyO42O
         DyAFaRTITB3oBUAtsfAZTlVx1guCyfqspSukPeMhX3jtvI1XF1XidUr859rUisgGFcND
         4vj9tWc9uC2HOhh8/to8Ah9pjxhruuRbasBMt80caNecQNhJn36PURJuYmGvgUsX2ME4
         G40YvSBxuczK3XmNRfkBAlfrrz8R2I0pOxF1dVgOk3FFXF7+kcK3Jp+lteFrMRUlB6G8
         EfLEOuookdRb0GZqudPoYXma9XZj0rZwzefTsXvD1eCGsLiiFlaiO3oa+BV47jFDwwF5
         Mznw==
X-Gm-Message-State: APjAAAUbqQBtNyz+DiS6POdAR/nfHEdKMok24zcvKswGoWdOyOoyHL8U
        w00WYshRsp2NoBeWJRdPnLo=
X-Google-Smtp-Source: APXvYqyf7yr5qJ/CyP4jxT0o2dkchL5XaLzaHcIYZR8g/fp2231KzfQVqu+1avN+3ydaQrOeoy2yHA==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr51256764wrn.90.1555439928382;
        Tue, 16 Apr 2019 11:38:48 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:47 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] dma-buf: add dma_buf_(un)map_attachment_locked variants v3
Date:   Tue, 16 Apr 2019 20:38:31 +0200
Message-Id: <20190416183841.1577-3-christian.koenig@amd.com>
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

Add function variants which can be called with the reservation lock
already held.

v2: reordered, add lockdep asserts, fix kerneldoc
v3: rebased on sgt caching

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 63 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   |  5 ++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 65161a82d4d5..ef480e5fb239 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -623,6 +623,43 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 }
 EXPORT_SYMBOL_GPL(dma_buf_detach);
 
+/**
+ * dma_buf_map_attachment_locked - Maps the buffer into _device_ address space
+ * with the reservation lock held. Is a wrapper for map_dma_buf() of the
+ *
+ * Returns the scatterlist table of the attachment;
+ * dma_buf_ops.
+ * @attach:	[in]	attachment whose scatterlist is to be returned
+ * @direction:	[in]	direction of DMA transfer
+ *
+ * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
+ * on error. May return -EINTR if it is interrupted by a signal.
+ *
+ * A mapping must be unmapped by using dma_buf_unmap_attachment_locked(). Note
+ * that the underlying backing storage is pinned for as long as a mapping
+ * exists, therefore users/importers should not hold onto a mapping for undue
+ * amounts of time.
+ */
+struct sg_table *
+dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
+			      enum dma_data_direction direction)
+{
+	struct sg_table *sg_table;
+
+	might_sleep();
+	reservation_object_assert_held(attach->dmabuf->resv);
+
+	if (attach->sgt)
+		return attach->sgt;
+
+	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
+	if (!sg_table)
+		sg_table = ERR_PTR(-ENOMEM);
+
+	return sg_table;
+}
+EXPORT_SYMBOL_GPL(dma_buf_map_attachment_locked);
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
@@ -659,6 +696,32 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 }
 EXPORT_SYMBOL_GPL(dma_buf_map_attachment);
 
+/**
+ * dma_buf_unmap_attachment_locked - unmaps the buffer with reservation lock
+ * held, should deallocate the associated scatterlist. Is a wrapper for
+ * unmap_dma_buf() of dma_buf_ops.
+ * @attach:	[in]	attachment to unmap buffer from
+ * @sg_table:	[in]	scatterlist info of the buffer to unmap
+ * @direction:  [in]    direction of DMA transfer
+ *
+ * This unmaps a DMA mapping for @attached obtained by
+ * dma_buf_map_attachment_locked().
+ */
+void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *attach,
+				     struct sg_table *sg_table,
+				     enum dma_data_direction direction)
+{
+	might_sleep();
+	reservation_object_assert_held(attach->dmabuf->resv);
+
+	if (attach->sgt == sg_table)
+		return;
+
+	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
+						direction);
+}
+EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
+
 /**
  * dma_buf_unmap_attachment - unmaps and decreases usecount of the buffer;might
  * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 0d9c3c13c9fb..18a78be53541 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -395,8 +395,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
+struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment *,
+					       enum dma_data_direction);
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 					enum dma_data_direction);
+void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *,
+				     struct sg_table *,
+				     enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
-- 
2.17.1

