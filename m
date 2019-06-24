Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A3C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2cEKL42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfFXTtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:49:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFXTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:49:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so8097127pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImGT/RYfIwkVeKcevhBFy+DosfaXfO541YHID3itWtM=;
        b=K2cEKL428RjFQQhy0jJ4MPXqCg1bYhJemOQGffAiTDMKcib6WNLk9yqH0b6tv2eL08
         MUVzXi2qPzSyy7lWHu2BMVR/Vl+cQRManWokku18IbZPhQtzJQBeh3Kqa8ZeJ3Z6MPkB
         W0s7ozufT5+GutJWnNvG3Uh5fBTe3eI5wUv8oawRScSDcgRhsnsTGq6VPAknIHxu9SBa
         scijkqITNcudaxkRuNO9JGuAlzymR+sx9H8zJSj8kYZgJ4fmlGJQHRqtA5evVYuZlJci
         gGGi9SjWR/q/iGFOjB/YgaFt2YtLqlbbP35wWdW34+kvztHCS0HR0lV8WA73e72qtLuH
         PEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImGT/RYfIwkVeKcevhBFy+DosfaXfO541YHID3itWtM=;
        b=ixyAQfUVMhyV4t/RGx86jZt1rGVB3kwqUo5shDfnGQ8+FF5S2jN0oBHBCSyuTs1kS2
         wfMeqP/EsRgc8YGOnTpWr4xyIKW5LsttkY70QMfXFYef7QridBHRR/08HthmfLddm1Za
         DYf4B7SurGDTH9j7zdG9BVErV/b/cfFak2qhR3cRXMlBOuj5M4z68IXvbUvS1KLoL8Sg
         AThgMBb1GLurvs1xnNEyvxdCvXW9SfVO0kMLJyfyyppXiukA/Wh+CHpXn7bmkHmvH0nJ
         YPoBj/MeyFrwft9m4AhdEIR6IARkFFdJVo1BHDevjjXlfd/v0Zre707TfwDjQ4hJ3oin
         TvhQ==
X-Gm-Message-State: APjAAAWXyLCZ+IROCc3RGMY69fsxlIEPFe6C6sVwfTPHAo1iIB59yPvY
        fthhct/76KGl6pFgo9BeECRpMnGs6KY=
X-Google-Smtp-Source: APXvYqzYzW2MbLf5j7s2EnV9yXdQfDtROWmXRGP5Gb7Mg6WFQoLIT7Za6gCW7O6XtPigFVvWJJlXpA==
X-Received: by 2002:a17:90a:214e:: with SMTP id a72mr27617457pje.0.1561405758711;
        Mon, 24 Jun 2019 12:49:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v3sm7957031pfm.188.2019.06.24.12.49.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:49:17 -0700 (PDT)
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
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
Date:   Mon, 24 Jun 2019 19:49:05 +0000
Message-Id: <20190624194908.121273-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624194908.121273-1-john.stultz@linaro.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
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
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
Cc: butao <butao@hisilicon.com>
Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc: Yudongbin <yudongbin@hisilicon.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I48d43656e7783f266d877e363116b5187639f996
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
---
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/heaps/Makefile       |   2 +
 drivers/dma-buf/heaps/heap-helpers.c | 262 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h |  54 ++++++
 4 files changed, 319 insertions(+)
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
index 000000000000..fba1895f3bf0
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -0,0 +1,262 @@
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
+void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *))
+{
+	buffer->private_flags = 0;
+	buffer->priv_virt = NULL;
+	mutex_init(&buffer->lock);
+	buffer->vmap_cnt = 0;
+	buffer->vaddr = NULL;
+	buffer->pagecount = 0;
+	buffer->pages = NULL;;
+	INIT_LIST_HEAD(&buffer->attachments);
+	buffer->free = free;
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
index 000000000000..7e0a82b11c9e
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.h
@@ -0,0 +1,54 @@
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
+void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
+				 void (*free)(struct heap_helper_buffer *));
+extern const struct dma_buf_ops heap_helper_ops;
+
+#endif /* _HEAP_HELPERS_H */
-- 
2.17.1

