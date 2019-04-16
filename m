Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B021741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0YHabX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfDPSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41385 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbfDPSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so28455326wrq.8;
        Tue, 16 Apr 2019 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BmYZ26HRwgELri9v8FC9yqT/YSzqU3wGyhizu/lSJ5o=;
        b=S0YHabX+SLyBqWIoCjbclH5alkHdkIpasVQBmisRK0yCO6m0lJQTvh3aNZuMusu2k0
         bcQ3EoxHNUS6B1hdZhKpFD70iOpfsLYHkr8C5WNNSmKFOLqHFV/n7dEYSO4gBQdb74Pg
         NAZZDEicfEtzs3esYpjR9H8K811kBQRDNBxXXNbJAh2CgKW+8IBsw4hHNlZ8Bud/05ic
         CxNIfhwppJM4sRXBsz+5slxpxtv7u+3aBhlo4w/8pSlHeR4AXzrldktPd3OU/+yzAslf
         yHsU9GxDAXulVDwhxr3fd5WoMG3nAGbkJb1jn6nlzVHnGGayz1OAgZNmjrmF8qzDdqLS
         JQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmYZ26HRwgELri9v8FC9yqT/YSzqU3wGyhizu/lSJ5o=;
        b=OKN4iDkvbMhgoZt+eXdXtn8Taz++0MUCOBYo7X+fur2gTtYH+UnsECaDTGyWsJ72gy
         H61vPk3POvFscnnFyq3OY8/W+qwtcga+mQJIg1mT38LDuws8dITJ/vA/RcsYt9Irkzno
         KPaBAE0m9eaGR19pP+kokzErpETDRttmxz48aDCGSfJo7/fGxR2cAw516Ngv9TfdL1eT
         gQY5Jow2A/XZNpxj4IWDhdCPIZce011SAPR9jiXofCA/2e3/e+08e9XPVJc+OABWGc0J
         CS69F7hL+Y3JA+yqB7FHZLLCDQ40XG5bGTlFYsH5j6smf90ItwXpNKgmYZlsDNiux5og
         RXag==
X-Gm-Message-State: APjAAAVEPpaYxVvQNTthl4/SlWqK2DVX+61JDhxK/Nvn/lW2zlYnLrIi
        BIBLMQbOmTjZkS6/sbze4SAaaxOA
X-Google-Smtp-Source: APXvYqw82PoM1Nz4qmAVJiwkCzhGYUSwFWYPWuYwfLXUDdwkAMA+8geT4QcpK17HGyfT0svCOcXrSg==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr44765558wrq.151.1555439930186;
        Tue, 16 Apr 2019 11:38:50 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:49 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback v5
Date:   Tue, 16 Apr 2019 20:38:33 +0200
Message-Id: <20190416183841.1577-5-christian.koenig@amd.com>
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

Each importer can now provide an invalidate_mappings callback.

This allows the exporter to provide the mappings without the need to pin
the backing store.

v2: don't try to invalidate mappings when the callback is NULL,
    lock the reservation obj while using the attachments,
    add helper to set the callback
v3: move flag for invalidation support into the DMA-buf,
    use new attach_info structure to set the callback
v4: use importer_priv field instead of mangling exporter priv.
v5: drop invalidation_supported flag

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 83c92bfd964c..a3738fab3927 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
 
 	attach->dev = info->dev;
 	attach->dmabuf = dmabuf;
+	attach->importer_priv = info->importer_priv;
+	attach->invalidate = info->invalidate;
 
 	mutex_lock(&dmabuf->lock);
 
@@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
 		if (ret)
 			goto err_attach;
 	}
+	reservation_object_lock(dmabuf->resv, NULL);
 	list_add(&attach->node, &dmabuf->attachments);
+	reservation_object_unlock(dmabuf->resv);
 
 	mutex_unlock(&dmabuf->lock);
 
@@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 					   DMA_BIDIRECTIONAL);
 
 	mutex_lock(&dmabuf->lock);
+	reservation_object_lock(dmabuf->resv, NULL);
 	list_del(&attach->node);
+	reservation_object_unlock(dmabuf->resv);
 	if (dmabuf->ops->detach)
 		dmabuf->ops->detach(dmabuf, attach);
 
@@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
 	if (attach->sgt)
 		return attach->sgt;
 
+	/*
+	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
+	 * event to the caller by temporary removing this attachment from the
+	 * list.
+	 */
+	if (attach->invalidate)
+		list_del(&attach->node);
 	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
+	if (attach->invalidate)
+		list_add(&attach->node, &attach->dmabuf->attachments);
 	if (!sg_table)
 		sg_table = ERR_PTR(-ENOMEM);
 
@@ -751,6 +766,26 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
 }
 EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
 
+/**
+ * dma_buf_invalidate_mappings - invalidate all mappings of this dma_buf
+ *
+ * @dmabuf:	[in]	buffer which mappings should be invalidated
+ *
+ * Informs all attachmenst that they need to destroy and recreated all their
+ * mappings.
+ */
+void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
+{
+	struct dma_buf_attachment *attach;
+
+	reservation_object_assert_held(dmabuf->resv);
+
+	list_for_each_entry(attach, &dmabuf->attachments, node)
+		if (attach->invalidate)
+			attach->invalidate(attach);
+}
+EXPORT_SYMBOL_GPL(dma_buf_invalidate_mappings);
+
 /**
  * DOC: cpu access
  *
@@ -1163,10 +1198,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 		seq_puts(s, "\tAttached Devices:\n");
 		attach_count = 0;
 
+		reservation_object_lock(buf_obj->resv, NULL);
 		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
 			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
 			attach_count++;
 		}
+		reservation_object_unlock(buf_obj->resv);
 
 		seq_printf(s, "Total %d devices attached\n\n",
 				attach_count);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 7e23758db3a4..ece4638359a8 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -324,6 +324,7 @@ struct dma_buf {
  * @dev: device attached to the buffer.
  * @node: list of dma_buf_attachment.
  * @priv: exporter specific attachment data.
+ * @importer_priv: importer specific attachment data.
  *
  * This structure holds the attachment information between the dma_buf buffer
  * and its user device(s). The list contains one attachment struct per device
@@ -340,6 +341,29 @@ struct dma_buf_attachment {
 	struct list_head node;
 	void *priv;
 	struct sg_table *sgt;
+	void *importer_priv;
+
+	/**
+	 * @invalidate:
+	 *
+	 * Optional callback provided by the importer of the dma-buf.
+	 *
+	 * If provided the exporter can avoid pinning the backing store while
+	 * mappings exists.
+	 *
+	 * The function is called with the lock of the reservation object
+	 * associated with the dma_buf held and the mapping function must be
+	 * called with this lock held as well. This makes sure that no mapping
+	 * is created concurrently with an ongoing invalidation.
+	 *
+	 * After the callback all existing mappings are still valid until all
+	 * fences in the dma_bufs reservation object are signaled, but should be
+	 * destroyed by the importer as soon as possible.
+	 *
+	 * New mappings can be created immediately, but can't be used before the
+	 * exclusive fence in the dma_bufs reservation object is signaled.
+	 */
+	void (*invalidate)(struct dma_buf_attachment *attach);
 };
 
 /**
@@ -378,8 +402,10 @@ struct dma_buf_export_info {
 
 /**
  * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
- * @dmabuf:	the exported dma_buf
- * @dev:	the device which wants to import the attachment
+ * @dmabuf:		the exported dma_buf
+ * @dev:		the device which wants to import the attachment
+ * @importer_priv:	private data of importer to this attachment
+ * @invalidate:		callback to use for invalidating mappings
  *
  * This structure holds the information required to attach to a buffer. Used
  * with dma_buf_attach() only.
@@ -387,6 +413,8 @@ struct dma_buf_export_info {
 struct dma_buf_attach_info {
 	struct dma_buf *dmabuf;
 	struct device *dev;
+	void *importer_priv;
+	void (*invalidate)(struct dma_buf_attachment *attach);
 };
 
 /**
@@ -423,6 +451,7 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *,
 				     enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
+void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
 int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 			     enum dma_data_direction dir);
 int dma_buf_end_cpu_access(struct dma_buf *dma_buf,
-- 
2.17.1

