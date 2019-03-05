Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA326C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CD42087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGXEitfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfCEUyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:54:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46718 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbfCEUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so6605278pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjNdJq9UTy396FItVuuFMC2moUGC3uBW2PZHwqhq9dk=;
        b=JGXEitfWTC2Fx8f/vKAaxDImoKOjNAKc/WUp8LWBS8yzzGJu6Hvqz1ohHTFYRbieZ4
         m68weAQQgYdRN2VJoAVodZOyQ5W1bcx6E4gncHyE7EtAcTHSFcDNeP2TxXWxGJZNC/ZH
         s36M3ziKhwOLNaNCW4TShZcu3qAs48TnDwwHwwAleoNlBnf5rzLayRZjf+oQ/IpuTMrL
         R0o8zQbdqfUPrZoZ+y1JdeO9oh754Zp3ozNzlhFhjZf8hRb+K6wT7ySImkuG6cdVybf9
         wvTBnyAqTwihnTN+4qu0rV7YolTCP/cnBUXDWpjcLX37Vvfb0dDrzLN1L3QN2/+KJgCX
         alJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjNdJq9UTy396FItVuuFMC2moUGC3uBW2PZHwqhq9dk=;
        b=JVUw/NL2w/jehUHckxw7xf+8PiAgUJQFLkJE4esmxwvCxwhl1wM+PZ4sLD9WNwl30X
         1VIyQg4lonB5tQW/t+gx86kQBXggc9cMrUjplmeu8KCHqj76p71gLS3FqLduG2tmB4Hq
         j5a6BTvA4nhgRGw2dcSxlCyuhcSfP1DRKnLKf7J8DLvMWRVIlKl1qyVzeZheE5Xwk/lW
         13m/6LiY4jYV2SB00JpdNigRfxjgos8RhIYG10kYKSsh6EqckYtciEkMw49rpC6Wt98p
         Omc1V1F/lIfH/Zp6zI+Sx1MlXlUv7hojAIG0XPfECZL5ov/3PRiSS8saobgZH4kYWSpr
         FMaA==
X-Gm-Message-State: APjAAAWcNLBUmv54LnjojY1kH8w5oFOc4HzZyC6vc9ORfKiUzINMLBI2
        CnZQtqeOldwEHt5DX1tAluGKrLlzp6g=
X-Google-Smtp-Source: APXvYqyCoIwrVw6dklhSs10riFYQ7lAejNtK1w2JcI8ZHD/fdINxXX4t16AcR3LX1QOc3azbJVEYYQ==
X-Received: by 2002:a17:902:7613:: with SMTP id k19mr3118077pll.207.1551819288135;
        Tue, 05 Mar 2019 12:54:48 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:46 -0800 (PST)
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
Subject: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
Date:   Tue,  5 Mar 2019 12:54:32 -0800
Message-Id: <1551819273-640-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
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
* Switch allocate to return dmabuf fd
* Simplify init code
* Checkpatch fixups
---
 drivers/dma-buf/heaps/Kconfig    |   8 ++
 drivers/dma-buf/heaps/Makefile   |   1 +
 drivers/dma-buf/heaps/cma_heap.c | 164 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index 2050527..a5eef06 100644
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
index d1808ec..6e54cde 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= heap-helpers.o
 obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
new file mode 100644
index 0000000..33c18ec
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
+	struct dma_heap heap;
+	struct cma *cma;
+};
+
+
+#define to_cma_heap(x) container_of(x, struct cma_heap, heap)
+
+
+static void cma_heap_free(struct heap_helper_buffer *buffer)
+{
+	struct cma_heap *cma_heap = to_cma_heap(buffer->heap_buffer.heap);
+	struct page *pages = buffer->priv_virt;
+	unsigned long nr_pages;
+
+	nr_pages = PAGE_ALIGN(buffer->heap_buffer.size) >> PAGE_SHIFT;
+
+	/* release memory */
+	cma_release(cma_heap->cma, pages, nr_pages);
+	/* release sg table */
+	sg_free_table(buffer->sg_table);
+	kfree(buffer->sg_table);
+	kfree(buffer);
+}
+
+/* dmabuf heap CMA operations functions */
+static int cma_heap_allocate(struct dma_heap *heap,
+				unsigned long len,
+				unsigned long flags)
+{
+	struct cma_heap *cma_heap = to_cma_heap(heap);
+	struct heap_helper_buffer *helper_buffer;
+	struct sg_table *table;
+	struct page *pages;
+	size_t size = PAGE_ALIGN(len);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long align = get_order(size);
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
+
+	if (align > CONFIG_CMA_ALIGNMENT)
+		align = CONFIG_CMA_ALIGNMENT;
+
+	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
+	if (!helper_buffer)
+		return -ENOMEM;
+
+	INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
+	helper_buffer->heap_buffer.flags = flags;
+	helper_buffer->heap_buffer.heap = heap;
+	helper_buffer->heap_buffer.size = len;
+
+
+	pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
+	if (!pages)
+		goto free_buf;
+
+	if (PageHighMem(pages)) {
+		unsigned long nr_clear_pages = nr_pages;
+		struct page *page = pages;
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
+		memset(page_address(pages), 0, size);
+	}
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		goto free_cma;
+
+	ret = sg_alloc_table(table, 1, GFP_KERNEL);
+	if (ret)
+		goto free_table;
+
+	sg_set_page(table->sgl, pages, size, 0);
+
+	/* create the dmabuf */
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = len;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = &helper_buffer->heap_buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_table;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
+	helper_buffer->priv_virt = pages;
+	helper_buffer->sg_table = table;
+
+	ret = dma_buf_fd(dmabuf, O_CLOEXEC);
+	if (ret < 0) {
+		dma_buf_put(dmabuf);
+		/* just return, as put will call release and that will free */
+		return ret;
+	}
+
+	return ret;
+free_table:
+	kfree(table);
+free_cma:
+	cma_release(cma_heap->cma, pages, nr_pages);
+free_buf:
+	kfree(helper_buffer);
+	return ret;
+}
+
+static struct dma_heap_ops cma_heap_ops = {
+	.allocate = cma_heap_allocate,
+};
+
+static int __add_cma_heaps(struct cma *cma, void *data)
+{
+	struct cma_heap *cma_heap;
+
+	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
+
+	if (!cma_heap)
+		return -ENOMEM;
+
+	cma_heap->heap.name = cma_get_name(cma);
+	cma_heap->heap.ops = &cma_heap_ops;
+	cma_heap->cma = cma;
+
+	dma_heap_add(&cma_heap->heap);
+
+	return 0;
+}
+
+static int add_cma_heaps(void)
+{
+	cma_for_each_area(__add_cma_heaps, NULL);
+	return 0;
+}
+device_initcall(add_cma_heaps);
-- 
2.7.4

