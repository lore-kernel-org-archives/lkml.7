Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9FFC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24023229EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utRo4D/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGXAhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:37:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43889 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfGXAhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:37:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so20233706pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eCJcdrdV5vXslXNmNWdX1+xjDhPGdq+9No5ztEZ9ag0=;
        b=utRo4D/Hb3sozHOY2wm7Ih9x75qhFMAxKs6pLS5yxMcVNkTfhD2EXP0nyyJyGX72+x
         8uYkguOPqCD1B84l8AFU9VfdLzGLSNojOXg19cvPcqAWBGTeVgWhjOZ5C/PqW6mZh2gP
         1oLaVTF1BoNVsT61rIj0H/mKI4aQXl5z6HsuT8Rflh+4thKYszbvJP0o6/iy2pTzPDw2
         AR93+qEvJKNUYX4tszYCHcY5dEPydIWtI0oIUWH1KMYuqTu2K6v6cOEh8hHZbxj2ZNvS
         50gnQcOFE2SzbTuuZ90Fb87rwLXbitOTEL/IRHb4etDsh8n4tf5OwYn71tFdYKPKDSuU
         Amzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCJcdrdV5vXslXNmNWdX1+xjDhPGdq+9No5ztEZ9ag0=;
        b=dKD60eSqxI/egwpfI/qcqqvsqradEuwwjeTazD+0iLmategrVKKBNBp5Cim6H5kEwG
         +cXCUkaX22ZMWwtBmn48bqSkyTPNJ3aHKV9oyOvFJVvobDjXscmjBXE0PvlXUyNAiBK0
         YAxOQtYYsTlvcx1bFy8sSFHdI0+o17Tc1QKpIjc5Z+zoxsbT/6lw1jrwreRFJIesSI2K
         x4DtovD1bC/97et9wFwXGE3qcFePUFZpxFhZyEzlsrlx53M6InGxGHsdirWqiAZKP/AJ
         sOeE6LHhW72szZ/5LYYL1JCWbwiSDwRAQwLiDzYb+cueAczqLTx9YODQ4+7buxtaZ0xE
         3DNA==
X-Gm-Message-State: APjAAAV2SMouHizRysV0JsvVLlxy7sS/6wZ58dYzRQVKmLAALeTPSTYF
        dyf1yy8x6ap59lR7G0ab7CSdFJ1Valw=
X-Google-Smtp-Source: APXvYqyq3aYiWmQkvR/qAy48XbEOER2AONFHRLatEgTPkG/5N9BpkPPLuGCZ+dj/0MBVF7/W3sIJQQ==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr77747242pgc.139.1563928627003;
        Tue, 23 Jul 2019 17:37:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x26sm58890022pfq.69.2019.07.23.17.37.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:37:06 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v7 2/5] dma-buf: heaps: Add heap helpers
Date:   Wed, 24 Jul 2019 00:36:53 +0000
Message-Id: <20190724003656.59780-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724003656.59780-1-john.stultz@linaro.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic helper dmabuf ops for dma heaps, so we can reduce
the amount of duplicative code for the exported dmabufs.

This code is an evolution of the Android ION implementation, so
thanks to its original authors and maintainters:
  Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Removed cache management performance hack that I had
  accidentally folded in.
* Removed stats code that was in helpers
* Lots of checkpatch cleanups
v3:
* Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
* Switch to WARN on buffer destroy failure (suggested by Brian)
* buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
* Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
  (suggested by Brian)
* Switch to_helper_buffer from macro to inline function
  (suggested by Benjamin)
* Rename kmap->vmap (folded in from Andrew)
* Use vmap for vmapping - not begin_cpu_access (folded in from
  Andrew)
* Drop kmap for now, as its optional (folded in from Andrew)
* Fold dma_heap_map_user into the single caller (foled in from
  Andrew)
* Folded in patch from Andrew to track page list per heap not
  sglist, which simplifies the tracking logic
v4:
* Moved dma-heap.h change out to previous patch
v6:
* Minor cleanups and typo fixes suggested by Brian
v7:
* Removed stray ;
* Make init_heap_helper_buffer lowercase, as suggested by Christoph
* Add dmabuf export helper to reduce boilerplate code
---
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/heaps/Makefile       |   2 +
 drivers/dma-buf/heaps/heap-helpers.c | 276 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h |  58 ++++++
 4 files changed, 337 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index 1cb3dd104825..e3e3dca29e46 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
 	 reservation.o seqno-fence.o
+obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
new file mode 100644
index 000000000000..de49898112db
--- /dev/null
+++ b/drivers/dma-buf/heaps/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y					+= heap-helpers.o
diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
new file mode 100644
index 000000000000..df1bd3cf7262
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/dma-heap.h>
+
+#include "heap-helpers.h"
+
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *))
+{
+	buffer->private_flags = 0;
+	buffer->priv_virt = NULL;
+	mutex_init(&buffer->lock);
+	buffer->vmap_cnt = 0;
+	buffer->vaddr = NULL;
+	buffer->pagecount = 0;
+	buffer->pages = NULL;
+	INIT_LIST_HEAD(&buffer->attachments);
+	buffer->free = free;
+}
+
+struct dma_buf *heap_helper_export_dmabuf(
+				struct heap_helper_buffer *helper_buffer,
+				int fd_flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = helper_buffer->heap_buffer.size;
+	exp_info.flags = fd_flags;
+	exp_info.priv = &helper_buffer->heap_buffer;
+
+	return dma_buf_export(&exp_info);
+}
+
+static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
+{
+	void *vaddr;
+
+	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	return vaddr;
+}
+
+static void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	if (buffer->vmap_cnt > 0) {
+		WARN("%s: buffer still mapped in the kernel\n",
+			     __func__);
+		vunmap(buffer->vaddr);
+	}
+
+	buffer->free(buffer);
+}
+
+static void *dma_heap_buffer_vmap_get(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	void *vaddr;
+
+	if (buffer->vmap_cnt) {
+		buffer->vmap_cnt++;
+		return buffer->vaddr;
+	}
+	vaddr = dma_heap_map_kernel(buffer);
+	if (WARN_ONCE(!vaddr,
+		      "heap->ops->map_kernel should return ERR_PTR on error"))
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(vaddr))
+		return vaddr;
+	buffer->vaddr = vaddr;
+	buffer->vmap_cnt++;
+	return vaddr;
+}
+
+static void dma_heap_buffer_vmap_put(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	if (!--buffer->vmap_cnt) {
+		vunmap(buffer->vaddr);
+		buffer->vaddr = NULL;
+	}
+}
+
+struct dma_heaps_attachment {
+	struct device *dev;
+	struct sg_table table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			      struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a;
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	int ret;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
+					buffer->pagecount, 0,
+					buffer->pagecount << PAGE_SHIFT,
+					GFP_KERNEL);
+	if (ret) {
+		kfree(a);
+		return ret;
+	}
+
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+static void dma_heap_detach(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	mutex_lock(&buffer->lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->lock);
+
+	sg_free_table(&a->table);
+	kfree(a);
+}
+
+static struct sg_table *dma_heap_map_dma_buf(
+					struct dma_buf_attachment *attachment,
+					enum dma_data_direction direction)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct sg_table *table;
+
+	table = &a->table;
+
+	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
+			direction))
+		table = ERR_PTR(-ENOMEM);
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+			      struct sg_table *table,
+			      enum dma_data_direction direction)
+{
+	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+}
+
+static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct heap_helper_buffer *buffer = vma->vm_private_data;
+
+	vmf->page = buffer->pages[vmf->pgoff];
+	get_page(vmf->page);
+
+	return 0;
+}
+
+static const struct vm_operations_struct dma_heap_vm_ops = {
+	.fault = dma_heap_vm_fault,
+};
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
+	vma->vm_ops = &dma_heap_vm_ops;
+	vma->vm_private_data = buffer;
+
+	return 0;
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct dma_heap_buffer *buffer = dmabuf->priv;
+
+	dma_heap_buffer_destroy(buffer);
+}
+
+static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					enum dma_data_direction direction)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	struct dma_heaps_attachment *a;
+	int ret = 0;
+
+	mutex_lock(&buffer->lock);
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_cpu(a->dev, a->table.sgl, a->table.nents,
+				    direction);
+	}
+	mutex_unlock(&buffer->lock);
+
+	return ret;
+}
+
+static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
+				      enum dma_data_direction direction)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	struct dma_heaps_attachment *a;
+
+	mutex_lock(&buffer->lock);
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_device(a->dev, a->table.sgl, a->table.nents,
+				       direction);
+	}
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+static void *dma_heap_dma_buf_vmap(struct dma_buf *dmabuf)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	void *vaddr;
+
+	mutex_lock(&buffer->lock);
+	vaddr = dma_heap_buffer_vmap_get(heap_buffer);
+	mutex_unlock(&buffer->lock);
+
+	return vaddr;
+}
+
+static void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	mutex_lock(&buffer->lock);
+	dma_heap_buffer_vmap_put(heap_buffer);
+	mutex_unlock(&buffer->lock);
+}
+
+const struct dma_buf_ops heap_helper_ops = {
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.mmap = dma_heap_mmap,
+	.release = dma_heap_dma_buf_release,
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detach,
+	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
+	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
+	.vmap = dma_heap_dma_buf_vmap,
+	.vunmap = dma_heap_dma_buf_vunmap,
+};
diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
new file mode 100644
index 000000000000..741c7ec013f5
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMABUF Heaps helper code
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#ifndef _HEAP_HELPERS_H
+#define _HEAP_HELPERS_H
+
+#include <linux/dma-heap.h>
+#include <linux/list.h>
+
+/**
+ * struct dma_heap_buffer - metadata for a particular buffer
+ * @heap:		back pointer to the heap the buffer came from
+ * @dmabuf:		backing dma-buf for this buffer
+ * @size:		size of the buffer
+ * @flags:		buffer specific flags
+ */
+struct dma_heap_buffer {
+	struct dma_heap *heap;
+	struct dma_buf *dmabuf;
+	size_t size;
+	unsigned long flags;
+};
+
+struct heap_helper_buffer {
+	struct dma_heap_buffer heap_buffer;
+
+	unsigned long private_flags;
+	void *priv_virt;
+	struct mutex lock;
+	int vmap_cnt;
+	void *vaddr;
+	pgoff_t pagecount;
+	struct page **pages;
+	struct list_head attachments;
+
+	void (*free)(struct heap_helper_buffer *buffer);
+};
+
+static inline struct heap_helper_buffer *to_helper_buffer(
+						struct dma_heap_buffer *h)
+{
+	return container_of(h, struct heap_helper_buffer, heap_buffer);
+}
+
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+				 void (*free)(struct heap_helper_buffer *));
+struct dma_buf *heap_helper_export_dmabuf(
+				struct heap_helper_buffer *helper_buffer,
+				int fd_flags);
+extern const struct dma_buf_ops heap_helper_ops;
+
+
+#endif /* _HEAP_HELPERS_H */
-- 
2.17.1

