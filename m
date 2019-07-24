Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBACB206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7VX6cyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfGXAhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:37:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40810 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfGXAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:37:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so19961757pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gG4foaWh2iCNus5gyTRB5t5U1Yj3aDJJLs13UfI1dew=;
        b=l7VX6cyQMD/lJw9uHaDWvi7dlEGptXxL0eSfcqJpV0RRNnAEwi/ctaKByeW0TA3LYo
         JiJ4NBgBd80fNhVzdfVnAeuBeCgZD+PNzPp48YbCiVFqMkXiY+1LwcOYgJvHXjD9d3qH
         g8d2nz5zFdn5xs3/9Zb5SZCO0JWbdKYf/KTukVrSBcuYCU8cOlnrxRXnGx9q9U4glrXD
         ASfvjOgiZxg0D4YAuwEcliPMRQ75jR8HAg+5r3jklFGgYN0OtnHu0piPi3Yr+NSSgh+t
         pye9cWAjiUW86Nk0NJIx0uvHz0PJ3E/Pdn8zB1dNvC0SUpNU+VTXrCsnopeFeqqm1w7H
         CKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gG4foaWh2iCNus5gyTRB5t5U1Yj3aDJJLs13UfI1dew=;
        b=XEcCf9t2Ku5Enen7dFek/F72wRAtdnolORYPGRPqJ9Z96JgEQwvb2vnHlNhffChg5z
         fRK7Ahbrdx+zYHhJAA6Jnt0CZFhKdwdpzw5shuwoZzb+jnq7p1qCEWQ2ALxuTR++7k0o
         /B/YTsf8iJESyKQLOWQWabfB/SgxTmnODntggu6Vbzv4Jz1PGeuSq5H6SmmdLI++5zf8
         rexXqXpYPPZHEO9qWVionYkQtA4xnTFipl9Nb6rktLbZ/IfM20kPVCqWi50sH88fhsyL
         BsS5kM0zfQ3HkmuwRbETAbwV/AJvsUh3ICz0Y3FlYnocG7hLmKQJZhEE2IRWrHdCJDEk
         w8gg==
X-Gm-Message-State: APjAAAVIhVFiLEKBf9SmEZw1OJVq7vJAn7cw2M7LpWOn+mSPjEi4rWSF
        CbV13r7JWOe+kQwyAnu9hC4etHOHP+E=
X-Google-Smtp-Source: APXvYqweETm5iA3BCXYCb3vPssshCzfXVhSAvT3azAMwqPwU9HZEeDmh3U0qbAqbcfWlyp06Nd1mkA==
X-Received: by 2002:a65:5882:: with SMTP id d2mr52834454pgu.134.1563928630847;
        Tue, 23 Jul 2019 17:37:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x26sm58890022pfq.69.2019.07.23.17.37.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:37:10 -0700 (PDT)
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
Subject: [PATCH v7 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Date:   Wed, 24 Jul 2019 00:36:55 +0000
Message-Id: <20190724003656.59780-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724003656.59780-1-john.stultz@linaro.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a CMA heap, which allows userspace to allocate
a dma-buf of contiguous memory out of a CMA region.

This code is an evolution of the Android ION implementation, so
thanks to its original author and maintainters:
  Benjamin Gaignard, Laura Abbott, and others!

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
---
 drivers/dma-buf/heaps/Kconfig    |   8 ++
 drivers/dma-buf/heaps/Makefile   |   1 +
 drivers/dma-buf/heaps/cma_heap.c | 164 +++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
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
index 000000000000..cc657380ad60
--- /dev/null
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF CMA heap exporter
+ *
+ * Copyright (C) 2012, 2019 Linaro Ltd.
+ * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/cma.h>
+#include <linux/scatterlist.h>
+#include <linux/highmem.h>
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
+	struct cma_heap *cma_heap = dma_heap_get_data(buffer->heap_buffer.heap);
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
+				unsigned long len,
+				unsigned long fd_flags,
+				unsigned long heap_flags)
+{
+	struct cma_heap *cma_heap = dma_heap_get_data(heap);
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
+	helper_buffer->heap_buffer.flags = heap_flags;
+	helper_buffer->heap_buffer.heap = heap;
+	helper_buffer->heap_buffer.size = len;
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
+	for (pg = 0; pg < helper_buffer->pagecount; pg++) {
+		helper_buffer->pages[pg] = &cma_pages[pg];
+		if (!helper_buffer->pages[pg])
+			goto free_pages;
+	}
+
+	/* create the dmabuf */
+	dmabuf = heap_helper_export_dmabuf(helper_buffer, fd_flags);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pages;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
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
+static struct dma_heap_ops cma_heap_ops = {
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
+static int add_cma_heaps(void)
+{
+	cma_for_each_area(__add_cma_heap, NULL);
+	return 0;
+}
+device_initcall(add_cma_heaps);
-- 
2.17.1

