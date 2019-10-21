Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C83DCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F15D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miQncsYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfJUTDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:03:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37932 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfJUTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:03:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so7080769plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M2dfDAnX3mNo486r8iPg8Xzv2WQBrUh28/r2sNyR+y0=;
        b=miQncsYOMavT2xk3ELjuhwAFCOsHb1cDa5nZtVP7YvvsDWuovWSgGCqaZddEPNuSj3
         Wakhwcdgl65MYDQBM2qve73/sKA7IuE89ZVJ5XqGUuqurcRb0wbkCOyCsmaoci/Y3Wzd
         E4SPRNcpTupNw3hcmrEeRpDPuIIXS8Jexz62QYT6Wlk54Bj7MUuBSM2lIA+pyCchX3lD
         A6Lrbg4QyQuhMQPHERAdrcQzWtJXguyaBUtEjfobM3PzTNjMoEiY5JgREL1+rox7CvKg
         ejjtNjGoxORFIn76ZKIedbPkI0wf421wq+4i6GX7Reqg6R/TWlzeHesO5cZWnI3Pae6b
         RujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M2dfDAnX3mNo486r8iPg8Xzv2WQBrUh28/r2sNyR+y0=;
        b=PWnS+1FVgstmvi4dpUdA+tLmEJydQh5A5byEg5kztbXXWve+BIvy5Qf3gR1Qeg1vm2
         aIlF1cEZvzBfFY8XtYlnKpcpjw1+1eAzYjiDayCZd38UlJj1FPE+KQo6M4Mvk5CBTtSr
         fGzHF+SXwAev6s0toDqoiL0hSzcAMexH6ODFrl5oLqmosatSANwrBdEe0O6/ys9VOpl+
         7+LGrb9BsFIwjaggrM2aY4d7U/ZS+YwU+iZh+aWs8qg59iv/1knTiR3QzU44/w71+6gc
         6FDAEq+j0JiCT0KaRJ1e5Mz8E0cHK41pdP1eXc/C+J1V0TurcYlgkmEeGKXHuiRb0MuC
         7+5A==
X-Gm-Message-State: APjAAAXz8aSQEuFhWNFuQKsdDmn5yLqarOEWP3dAu2up1/DhCiuyCmSd
        hHneDKOowpSqBXi1yRD26KfvlPAUZ20=
X-Google-Smtp-Source: APXvYqxQ06Ev0QpRQAhWlku/Pmy7dUlJJ4Y4yw9nwQqsA8j0IwxjjsHwbP9nELUW4pRPnHRMko8u+w==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr26838945plo.333.1571684598045;
        Mon, 21 Oct 2019 12:03:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 127sm16223673pfy.56.2019.10.21.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:03:17 -0700 (PDT)
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
Subject: [PATCH v13 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Date:   Mon, 21 Oct 2019 19:03:09 +0000
Message-Id: <20191021190310.85221-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021190310.85221-1-john.stultz@linaro.org>
References: <20191021190310.85221-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a CMA heap, which allows userspace to allocate
a dma-buf of contiguous memory out of a CMA region.

This code is an evolution of the Android ION implementation, so
thanks to its original author and maintainters:
  Benjamin Gaignard, Laura Abbott, and others!

NOTE: This patch only adds the default CMA heap. We will enable
selectively adding other CMA memory regions to the dmabuf heaps
interface with a later patch (which requires a dt binding)

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
* Switch allocate to return dmabuf fd
* Simplify init code
* Checkpatch fixups
v3:
* Switch to inline function for to_cma_heap()
* Minor cleanups suggested by Brian
* Fold in new registration style from Andrew
* Folded in changes from Andrew to use simplified page list
  from the heap helpers
v4:
* Use the fd_flags when creating dmabuf fd (Suggested by
  Benjamin)
* Use precalculated pagecount (Suggested by Andrew)
v6:
* Changed variable names to improve clarity, as suggested
  by Brian
v7:
* Use newly lower-cased init_heap_helper_buffer helper
* Use new dmabuf export helper
v8:
* Make struct dma_heap_ops const (Suggested by Christoph)
* Condense dma_heap_buffer and heap_helper_buffer (suggested by
  Christoph)
* Checkpatch whitespace fixups
v9:
* Removing needless check noted by Brian Starkey
* Rename dma_heap_get_data->dma_heap_get_drvdata suggested
  by Hilf Danton
* Check signals after clearing memory pages to avoid doing
  needless work if the task is killed as suggested by Hilf
v12:
* Rework to only add the default CMA heap
---
 drivers/dma-buf/heaps/Kconfig    |   8 ++
 drivers/dma-buf/heaps/Makefile   |   1 +
 drivers/dma-buf/heaps/cma_heap.c | 178 +++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index 205052744169..a5eef06c4226 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
+
+config DMABUF_HEAPS_CMA
+	bool "DMA-BUF CMA Heap"
+	depends on DMABUF_HEAPS && DMA_CMA
+	help
+	  Choose this option to enable dma-buf CMA heap. This heap is backed
+	  by the Contiguous Memory Allocator (CMA). If your system has these
+	  regions, you should say Y here.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index d1808eca2581..6e54cdec3da0 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= heap-helpers.o
 obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
new file mode 100644
index 000000000000..064926b5d735
--- /dev/null
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF CMA heap exporter
+ *
+ * Copyright (C) 2012, 2019 Linaro Ltd.
+ * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
+ */
+
+#include <linux/cma.h>
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/dma-contiguous.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/sched/signal.h>
+
+#include "heap-helpers.h"
+
+struct cma_heap {
+	struct dma_heap *heap;
+	struct cma *cma;
+};
+
+static void cma_heap_free(struct heap_helper_buffer *buffer)
+{
+	struct cma_heap *cma_heap = dma_heap_get_drvdata(buffer->heap);
+	unsigned long nr_pages = buffer->pagecount;
+	struct page *cma_pages = buffer->priv_virt;
+
+	/* free page list */
+	kfree(buffer->pages);
+	/* release memory */
+	cma_release(cma_heap->cma, cma_pages, nr_pages);
+	kfree(buffer);
+}
+
+/* dmabuf heap CMA operations functions */
+static int cma_heap_allocate(struct dma_heap *heap,
+			     unsigned long len,
+			     unsigned long fd_flags,
+			     unsigned long heap_flags)
+{
+	struct cma_heap *cma_heap = dma_heap_get_drvdata(heap);
+	struct heap_helper_buffer *helper_buffer;
+	struct page *cma_pages;
+	size_t size = PAGE_ALIGN(len);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long align = get_order(size);
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
+	pgoff_t pg;
+
+	if (align > CONFIG_CMA_ALIGNMENT)
+		align = CONFIG_CMA_ALIGNMENT;
+
+	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
+	if (!helper_buffer)
+		return -ENOMEM;
+
+	init_heap_helper_buffer(helper_buffer, cma_heap_free);
+	helper_buffer->flags = heap_flags;
+	helper_buffer->heap = heap;
+	helper_buffer->size = len;
+
+	cma_pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
+	if (!cma_pages)
+		goto free_buf;
+
+	if (PageHighMem(cma_pages)) {
+		unsigned long nr_clear_pages = nr_pages;
+		struct page *page = cma_pages;
+
+		while (nr_clear_pages > 0) {
+			void *vaddr = kmap_atomic(page);
+
+			memset(vaddr, 0, PAGE_SIZE);
+			kunmap_atomic(vaddr);
+			/*
+			 * Avoid wasting time zeroing memory if the process
+			 * has been killed by by SIGKILL
+			 */
+			if (fatal_signal_pending(current))
+				goto free_cma;
+
+			page++;
+			nr_clear_pages--;
+		}
+	} else {
+		memset(page_address(cma_pages), 0, size);
+	}
+
+	helper_buffer->pagecount = nr_pages;
+	helper_buffer->pages = kmalloc_array(helper_buffer->pagecount,
+					     sizeof(*helper_buffer->pages),
+					     GFP_KERNEL);
+	if (!helper_buffer->pages) {
+		ret = -ENOMEM;
+		goto free_cma;
+	}
+
+	for (pg = 0; pg < helper_buffer->pagecount; pg++)
+		helper_buffer->pages[pg] = &cma_pages[pg];
+
+	/* create the dmabuf */
+	dmabuf = heap_helper_export_dmabuf(helper_buffer, fd_flags);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pages;
+	}
+
+	helper_buffer->dmabuf = dmabuf;
+	helper_buffer->priv_virt = cma_pages;
+
+	ret = dma_buf_fd(dmabuf, fd_flags);
+	if (ret < 0) {
+		dma_buf_put(dmabuf);
+		/* just return, as put will call release and that will free */
+		return ret;
+	}
+
+	return ret;
+
+free_pages:
+	kfree(helper_buffer->pages);
+free_cma:
+	cma_release(cma_heap->cma, cma_pages, nr_pages);
+free_buf:
+	kfree(helper_buffer);
+	return ret;
+}
+
+static const struct dma_heap_ops cma_heap_ops = {
+	.allocate = cma_heap_allocate,
+};
+
+static int __add_cma_heap(struct cma *cma, void *data)
+{
+	struct cma_heap *cma_heap;
+	struct dma_heap_export_info exp_info;
+
+	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
+	if (!cma_heap)
+		return -ENOMEM;
+	cma_heap->cma = cma;
+
+	exp_info.name = cma_get_name(cma);
+	exp_info.ops = &cma_heap_ops;
+	exp_info.priv = cma_heap;
+
+	cma_heap->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(cma_heap->heap)) {
+		int ret = PTR_ERR(cma_heap->heap);
+
+		kfree(cma_heap);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int add_default_cma_heap(void)
+{
+	struct cma *default_cma = dev_get_cma_area(NULL);
+	int ret = 0;
+
+	if (default_cma)
+		ret = __add_cma_heap(default_cma, NULL);
+
+	return ret;
+}
+module_init(add_default_cma_heap);
+MODULE_DESCRIPTION("DMA-BUF CMA Heap");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

