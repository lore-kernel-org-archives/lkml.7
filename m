Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F65CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCCA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/ETzjvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfJUTDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:03:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37928 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbfJUTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:03:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so7080719plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aZL/3d1/h8RCc0nddpikyAjJxLVmuM26/wtYP52MfEI=;
        b=D/ETzjvXVJtoIz7whSpLNHmkoiXeoGfpsxtTnzQ/FGjY3hOOoFBlYVNTuaql6JkPGf
         +4XUFtRoVDIwNguYhHfoWb4anW67aVLUs7aZNKRaKPla5fRFcyj/uZ9D4X1oyEwiCWVO
         xlohsUsm4mPqY3yhsEf2/IJ5q4mKmCQDNP8ovPY9AOPjuiA5Y3zXlJmydihDfUKoeyEb
         VlezVyu5DbHuOWk9jeq4BGBMpIGPjV9wmaaparjBAZze37Zo5BDwtuTuuWPi5S2mZoDm
         NC2Nx0m1U6GKnFxkqylmzW6IXmiN2JixwRW936A7E/vZmPUKwia5X6eKVFk3s2aOvUQ/
         irRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aZL/3d1/h8RCc0nddpikyAjJxLVmuM26/wtYP52MfEI=;
        b=teBA2m9eQdwY7k2SfKUT3i6LmwdV7jR/xB80NI8e6UMMGn88PTXj/D3lXjldg/V+wt
         qdLAr8ThXZGEJsash8+2kKty7ZiX/slpcUdm2i03Yd836ShNFDGf7Cu5dm0M/rHEzv4x
         V/nJf2Mh2ODypAO8DKN92NHXBLV8Dm3tjA0psgQKbEHCo8hRnD10F5f/6z1JjklFe2pZ
         Tg/ddb0Y0PfkUDYJZNRFzDnuZICq/tUzn8l/4FUvZSl3A1lvmSJDv+0wiX6Gmhpa9CJ6
         bKueMUd2nRzEqVpgoWGulE4kOUFSghcJvz4giZvu4DhtvmNMftvAgrfhjKRIFesjdfzw
         yhYA==
X-Gm-Message-State: APjAAAXLbdJEQA6KnCYCmy1nogfU4DRtvDpieiPQDbSsCEU/LGvWZjC8
        FiQalpxYgMasmPz4gwK9PUksS0R/E4E=
X-Google-Smtp-Source: APXvYqzIjcILNPbPm9b2HRaEQlR9uN2x+zb1d7ck/K5c3Nu2uOKdUFO6EKGUHSriVblNd3xzV0myhQ==
X-Received: by 2002:a17:902:bd8c:: with SMTP id q12mr2810497pls.257.1571684595320;
        Mon, 21 Oct 2019 12:03:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 127sm16223673pfy.56.2019.10.21.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:03:14 -0700 (PDT)
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
        Hillf Danton <hdanton@sina.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v13 2/5] dma-buf: heaps: Add heap helpers
Date:   Mon, 21 Oct 2019 19:03:07 +0000
Message-Id: <20191021190310.85221-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021190310.85221-1-john.stultz@linaro.org>
References: <20191021190310.85221-1-john.stultz@linaro.org>
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
Cc: Hillf Danton <hdanton@sina.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
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
v8:
* Remove unused private_flags value
* Condense dma_heap_buffer and heap_helper_buffer (suggested by
  Christoph)
* Fix indentation by using shorter argument names (suggested by
  Christoph)
* Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
  (suggested by Christoph)
* Checkpatch whitespace fixups
v9:
* Minor cleanups suggested by Brian Starkey
v10:
* Fix missing vmalloc.h inclusion in heap helpers (found by
  kbuild test robot <lkp@intel.com>)
v12:
* Add symbol exports for heaps as modules
v13:
* Re-remove symbol exports, per discussion with Brian, as I'll
  resubmit the change for review independently.
---
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/heaps/Makefile       |   2 +
 drivers/dma-buf/heaps/heap-helpers.c | 268 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h |  55 ++++++
 4 files changed, 326 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index caee5eb3d351..9c190026bfab 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -2,6 +2,7 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
 	 dma-resv.o seqno-fence.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
+obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
 obj-$(CONFIG_UDMABUF)		+= udmabuf.o
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
index 000000000000..750bef4e902d
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <uapi/linux/dma-heap.h>
+
+#include "heap-helpers.h"
+
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *))
+{
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
+struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
+					  int fd_flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = buffer->size;
+	exp_info.flags = fd_flags;
+	exp_info.priv = buffer;
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
+static void dma_heap_buffer_destroy(struct heap_helper_buffer *buffer)
+{
+	if (buffer->vmap_cnt > 0) {
+		WARN("%s: buffer still mapped in the kernel\n", __func__);
+		vunmap(buffer->vaddr);
+	}
+
+	buffer->free(buffer);
+}
+
+static void *dma_heap_buffer_vmap_get(struct heap_helper_buffer *buffer)
+{
+	void *vaddr;
+
+	if (buffer->vmap_cnt) {
+		buffer->vmap_cnt++;
+		return buffer->vaddr;
+	}
+	vaddr = dma_heap_map_kernel(buffer);
+	if (IS_ERR(vaddr))
+		return vaddr;
+	buffer->vaddr = vaddr;
+	buffer->vmap_cnt++;
+	return vaddr;
+}
+
+static void dma_heap_buffer_vmap_put(struct heap_helper_buffer *buffer)
+{
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
+			   struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a;
+	struct heap_helper_buffer *buffer = dmabuf->priv;
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
+			    struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->lock);
+
+	sg_free_table(&a->table);
+	kfree(a);
+}
+
+static
+struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+				      enum dma_data_direction direction)
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
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
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
+	struct heap_helper_buffer *buffer = dmabuf->priv;
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
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	dma_heap_buffer_destroy(buffer);
+}
+
+static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					     enum dma_data_direction direction)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a;
+	int ret = 0;
+
+	mutex_lock(&buffer->lock);
+
+	if (buffer->vmap_cnt)
+		invalidate_kernel_vmap_range(buffer->vaddr, buffer->size);
+
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
+					   enum dma_data_direction direction)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a;
+
+	mutex_lock(&buffer->lock);
+
+	if (buffer->vmap_cnt)
+		flush_kernel_vmap_range(buffer->vaddr, buffer->size);
+
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
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	void *vaddr;
+
+	mutex_lock(&buffer->lock);
+	vaddr = dma_heap_buffer_vmap_get(buffer);
+	mutex_unlock(&buffer->lock);
+
+	return vaddr;
+}
+
+static void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+	dma_heap_buffer_vmap_put(buffer);
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
index 000000000000..911c931f7f06
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.h
@@ -0,0 +1,55 @@
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
+ * struct heap_helper_buffer - helper buffer metadata
+ * @heap:		back pointer to the heap the buffer came from
+ * @dmabuf:		backing dma-buf for this buffer
+ * @size:		size of the buffer
+ * @flags:		buffer specific flags
+ * @priv_virt		pointer to heap specific private value
+ * @lock		mutext to protect the data in this structure
+ * @vmap_cnt		count of vmap references on the buffer
+ * @vaddr		vmap'ed virtual address
+ * @pagecount		number of pages in the buffer
+ * @pages		list of page pointers
+ * @attachments		list of device attachments
+ *
+ * @free		heap callback to free the buffer
+ */
+struct heap_helper_buffer {
+	struct dma_heap *heap;
+	struct dma_buf *dmabuf;
+	size_t size;
+	unsigned long flags;
+
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
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *));
+
+struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
+					  int fd_flags);
+
+extern const struct dma_buf_ops heap_helper_ops;
+#endif /* _HEAP_HELPERS_H */
-- 
2.17.1

