Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CF72075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQ3o7bDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfCEUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:55:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35177 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfCEUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so6620881pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4gbFKLyjI3IwmyANMx9RTxgAjbN5gJRajPVnQsoKow=;
        b=tQ3o7bDEfeFHNNx9lxcsffx/ug2FlH6XBA80njihZ82Qubnsm9gFWpTOt3ssLsgmke
         NVoHUmU82mFiPJkh9x+SrBQOwCRNNdbmJ5F47VB2OKwuWtoFa8Z1ykd9aryppldlnhcV
         RTgJS41k57yo0St04Wff+xyrcDmVD8sLa10X1fxerw9NcgfUjOdne2Q4kiztqENL80wW
         dRxtZtc2vxLK2D7ym5tjbbkF//mBdrWXByMIz8bu1oLhUsNKfh0z1aAhpABTE0cAu3Tw
         EpIgqIT5HXIqN35clE+c4O4XmtdPoqy3sVU5WWVZVdFeEiBueZbmohXH82F9LEMt/c9x
         e1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4gbFKLyjI3IwmyANMx9RTxgAjbN5gJRajPVnQsoKow=;
        b=tmnkN69uLaUfoFGETFum3zSGnJo2x0cc2H5Al8ULLt8IWDybY3wS/9HlizYpcCf1I4
         PU8E4jLxNMwH3467+zstCqrfoHSA6RqCtpg53uTWjbc2HdWOel5xOfA80/h/exXEyiie
         Dzb9ACI0uunjADVpxOsaUDuSaKnvyjwA8d4Mhe6PyhnoiWJFPkWMnc7CrJD0nsFzMho5
         HxMPoO+AiptgXxwammkyt76tN+hQ8Kq+442uklS7JxK1YQHZkrjancwsnxMxERKXvOyt
         sdX46lE34HPY1/X4lYro4nHPFGZwIZaTgM6hOG0kR9XklvFNzf0rtGFRyK1RLZ8p5Ty1
         Vwkw==
X-Gm-Message-State: APjAAAVGmyJE12GP4ytPzuLVzqiiCNUKnr4AeKZMVTaE9WSvt9ZTvLBD
        +UTBDZpwUxfnKFpVhfUY218tR/wmbAk=
X-Google-Smtp-Source: APXvYqwjoDN0TV9qV8dX52oCEtTS7B1X2+9fRWiLb/GYUrddBubzSbk3CGQdr1xikKUKpm7vwp+aIg==
X-Received: by 2002:a65:6241:: with SMTP id q1mr3146039pgv.340.1551819284810;
        Tue, 05 Mar 2019 12:54:44 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:43 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
Date:   Tue,  5 Mar 2019 12:54:30 -0800
Message-Id: <1551819273-640-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
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
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Removed cache management performance hack that I had
  accidentally folded in.
* Removed stats code that was in helpers
* Lots of checkpatch cleanups
---
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/heaps/Makefile       |   2 +
 drivers/dma-buf/heaps/heap-helpers.c | 335 +++++++++++++++++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h |  48 +++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index b0332f1..09c2f2d 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,4 +1,5 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
+obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
new file mode 100644
index 0000000..de49898
--- /dev/null
+++ b/drivers/dma-buf/heaps/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y					+= heap-helpers.o
diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
new file mode 100644
index 0000000..ae5e9d0
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -0,0 +1,335 @@
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
+
+static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
+{
+	struct scatterlist *sg;
+	int i, j;
+	void *vaddr;
+	pgprot_t pgprot;
+	struct sg_table *table = buffer->sg_table;
+	int npages = PAGE_ALIGN(buffer->heap_buffer.size) / PAGE_SIZE;
+	struct page **pages = vmalloc(array_size(npages,
+						 sizeof(struct page *)));
+	struct page **tmp = pages;
+
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	pgprot = PAGE_KERNEL;
+
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
+		struct page *page = sg_page(sg);
+
+		WARN_ON(i >= npages);
+		for (j = 0; j < npages_this_entry; j++)
+			*(tmp++) = page++;
+	}
+	vaddr = vmap(pages, npages, VM_MAP, pgprot);
+	vfree(pages);
+
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	return vaddr;
+}
+
+static int dma_heap_map_user(struct heap_helper_buffer *buffer,
+			 struct vm_area_struct *vma)
+{
+	struct sg_table *table = buffer->sg_table;
+	unsigned long addr = vma->vm_start;
+	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
+	struct scatterlist *sg;
+	int i;
+	int ret;
+
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		struct page *page = sg_page(sg);
+		unsigned long remainder = vma->vm_end - addr;
+		unsigned long len = sg->length;
+
+		if (offset >= sg->length) {
+			offset -= sg->length;
+			continue;
+		} else if (offset) {
+			page += offset / PAGE_SIZE;
+			len = sg->length - offset;
+			offset = 0;
+		}
+		len = min(len, remainder);
+		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
+				      vma->vm_page_prot);
+		if (ret)
+			return ret;
+		addr += len;
+		if (addr >= vma->vm_end)
+			return 0;
+	}
+
+	return 0;
+}
+
+
+void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	if (buffer->kmap_cnt > 0) {
+		pr_warn_once("%s: buffer still mapped in the kernel\n",
+			     __func__);
+		vunmap(buffer->vaddr);
+	}
+
+	buffer->free(buffer);
+}
+
+static void *dma_heap_buffer_kmap_get(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	void *vaddr;
+
+	if (buffer->kmap_cnt) {
+		buffer->kmap_cnt++;
+		return buffer->vaddr;
+	}
+	vaddr = dma_heap_map_kernel(buffer);
+	if (WARN_ONCE(!vaddr,
+		      "heap->ops->map_kernel should return ERR_PTR on error"))
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(vaddr))
+		return vaddr;
+	buffer->vaddr = vaddr;
+	buffer->kmap_cnt++;
+	return vaddr;
+}
+
+static void dma_heap_buffer_kmap_put(struct dma_heap_buffer *heap_buffer)
+{
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	buffer->kmap_cnt--;
+	if (!buffer->kmap_cnt) {
+		vunmap(buffer->vaddr);
+		buffer->vaddr = NULL;
+	}
+}
+
+static struct sg_table *dup_sg_table(struct sg_table *table)
+{
+	struct sg_table *new_table;
+	int ret, i;
+	struct scatterlist *sg, *new_sg;
+
+	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
+	if (!new_table)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
+	if (ret) {
+		kfree(new_table);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new_sg = new_table->sgl;
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		memcpy(new_sg, sg, sizeof(*sg));
+		new_sg->dma_address = 0;
+		new_sg = sg_next(new_sg);
+	}
+
+	return new_table;
+}
+
+static void free_duped_table(struct sg_table *table)
+{
+	sg_free_table(table);
+	kfree(table);
+}
+
+struct dma_heaps_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			      struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a;
+	struct sg_table *table;
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = dup_sg_table(buffer->sg_table);
+	if (IS_ERR(table)) {
+		kfree(a);
+		return -ENOMEM;
+	}
+
+	a->table = table;
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
+static void dma_heap_detatch(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	mutex_lock(&buffer->lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->lock);
+	free_duped_table(a->table);
+
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
+	table = a->table;
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
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	int ret = 0;
+
+	mutex_lock(&buffer->lock);
+	/* now map it to userspace */
+	ret = dma_heap_map_user(buffer, vma);
+	mutex_unlock(&buffer->lock);
+
+	if (ret)
+		pr_err("%s: failure mapping buffer to userspace\n",
+		       __func__);
+
+	return ret;
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct dma_heap_buffer *buffer = dmabuf->priv;
+
+	dma_heap_buffer_destroy(buffer);
+}
+
+static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
+					unsigned long offset)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+
+	return buffer->vaddr + offset * PAGE_SIZE;
+}
+
+static void dma_heap_dma_buf_kunmap(struct dma_buf *dmabuf,
+					unsigned long offset,
+					void *ptr)
+{
+}
+
+static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					enum dma_data_direction direction)
+{
+	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
+	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
+	void *vaddr;
+	struct dma_heaps_attachment *a;
+	int ret = 0;
+
+	mutex_lock(&buffer->lock);
+	vaddr = dma_heap_buffer_kmap_get(heap_buffer);
+	if (IS_ERR(vaddr)) {
+		ret = PTR_ERR(vaddr);
+		goto unlock;
+	}
+	mutex_unlock(&buffer->lock);
+
+	mutex_lock(&buffer->lock);
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
+				    direction);
+	}
+
+unlock:
+	mutex_unlock(&buffer->lock);
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
+	dma_heap_buffer_kmap_put(heap_buffer);
+	mutex_unlock(&buffer->lock);
+
+	mutex_lock(&buffer->lock);
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
+				       direction);
+	}
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+const struct dma_buf_ops heap_helper_ops = {
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.mmap = dma_heap_mmap,
+	.release = dma_heap_dma_buf_release,
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detatch,
+	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
+	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
+	.map = dma_heap_dma_buf_kmap,
+	.unmap = dma_heap_dma_buf_kunmap,
+};
diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
new file mode 100644
index 0000000..0bd8643
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.h
@@ -0,0 +1,48 @@
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
+struct heap_helper_buffer {
+	struct dma_heap_buffer heap_buffer;
+
+	unsigned long private_flags;
+	void *priv_virt;
+	struct mutex lock;
+	int kmap_cnt;
+	void *vaddr;
+	struct sg_table *sg_table;
+	struct list_head attachments;
+
+	void (*free)(struct heap_helper_buffer *buffer);
+
+};
+
+#define to_helper_buffer(x) \
+	container_of(x, struct heap_helper_buffer, heap_buffer)
+
+static inline void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
+				 void (*free)(struct heap_helper_buffer *))
+{
+	buffer->private_flags = 0;
+	buffer->priv_virt = NULL;
+	mutex_init(&buffer->lock);
+	buffer->kmap_cnt = 0;
+	buffer->vaddr = NULL;
+	buffer->sg_table = NULL;
+	INIT_LIST_HEAD(&buffer->attachments);
+	buffer->free = free;
+}
+
+extern const struct dma_buf_ops heap_helper_ops;
+
+#endif /* _HEAP_HELPERS_H */
-- 
2.7.4

