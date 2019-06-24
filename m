Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F62FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMGVGMdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfFXTt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:49:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46858 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfFXTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:49:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so7638217pgr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oWVUodEWikobPmP2NxI6TMAts5qOQ2aR1KHWV1qmHaY=;
        b=OMGVGMdG7FI2WEBe6paPJXvzmL9umAeCrvt+690kiATXRKWLJnY0k3dSzGGezlHsaL
         bmlZw4HZwdAw0eQzp+j63SuqCnqzbQW33LtTrRK0CgvIZrzprXcVkL/Gb28w4lvE3wwr
         unVuDRKjhwJ9RjnOyrxE0AAHhwC6uOh/FkA9J9BoroM39Uy4s6JwOZ9HOHX5nnnBjKuF
         iyvP82d1AnDoWWAujZJftmexWhbA9zR+QbgWdTtVy6k4cJa5DUm6TSso60NQcsnf+mDH
         01K/2riu7EZaFbuXbGKZfMaGuUK8UPeAUjO80EonhjSnTeGJ+TAigZTr8J20Giaf5xW7
         5CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oWVUodEWikobPmP2NxI6TMAts5qOQ2aR1KHWV1qmHaY=;
        b=siRLanPW5SNctcoqvQldcvnIcrikgza65pzKpGiOORc9LOsiVH9GxigbpiVYrZDTqC
         sLauQiYwrlEG8viIs5gazuC783013WRHaOhGDgksLnEGeI92MLVJ1hVxxddNl9+iX6fF
         M/G4sPAasITM3RQouSOmnAGR9xOy/LTsejZEPxXs9t7CAUdlwqsLkdQYRgcVf1URjBJj
         190Ag2ZZenpCGEthWgV0b2IET59PulkEyg158ZQEqec709ZszqLn7kDl3iiKIvMfR5OV
         JOncS67oYjQGw6TWW8U4uqM2xUBeFH6jTCHtYKloIuKHt6WpEgVEQbRIcmBfOkACcDhK
         81uw==
X-Gm-Message-State: APjAAAXTohiEiz/r8UKBvdQJPgu9bhgQrJxEDMLZW1143oQetwMWfNSu
        bsyVkMXJk8606xsxbpsBuPhPS2tE1ZY=
X-Google-Smtp-Source: APXvYqxsUnp1BDfjcABrnn89z0dnV99eBZbZu9ehmgAAHGJhsqkMLcsGy8DN97NIAl5/baVeTn3Rcg==
X-Received: by 2002:a17:90a:3210:: with SMTP id k16mr25862830pjb.13.1561405760500;
        Mon, 24 Jun 2019 12:49:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v3sm7957031pfm.188.2019.06.24.12.49.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:49:19 -0700 (PDT)
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
Subject: [PATCH v6 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Mon, 24 Jun 2019 19:49:06 +0000
Message-Id: <20190624194908.121273-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624194908.121273-1-john.stultz@linaro.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds system heap to the dma-buf heaps framework.

This allows applications to get a page-allocator backed dma-buf
for non-contiguous memory.

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
Change-Id: I4dc5ff54ccb1f7ca3ac8675661114ca33813654b
---
v2:
* Switch allocate to return dmabuf fd
* Simplify init code
* Checkpatch fixups
* Droped dead system-contig code
v3:
* Whitespace fixups from Benjamin
* Make sure we're zeroing the allocated pages (from Liam)
* Use PAGE_ALIGN() consistently (suggested by Brian)
* Fold in new registration style from Andrew
* Avoid needless dynamic allocation of sys_heap (suggested by
  Christoph)
* Minor cleanups
* Folded in changes from Andrew to use simplified page list
  from the heap helpers
v4:
* Optimization to allocate pages in chunks, similar to old
  pagepool code
* Use fd_flags when creating dmabuf fd (Suggested by Benjamin)
v5:
* Back out large order page allocations (was leaking memory,
  as the page array didn't properly track order size)
v6:
* Minor whitespace change suggested by Brian
* Remove unused variable
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 121 ++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/system_heap.c

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 9b93f86f597c..434cfe646dad 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -47,4 +47,6 @@ menuconfig DMABUF_HEAPS
 	  this allows userspace to allocate dma-bufs that can be shared between
 	  drivers.
 
+source "drivers/dma-buf/heaps/Kconfig"
+
 endmenu
diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
new file mode 100644
index 000000000000..205052744169
--- /dev/null
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -0,0 +1,6 @@
+config DMABUF_HEAPS_SYSTEM
+	bool "DMA-BUF System Heap"
+	depends on DMABUF_HEAPS
+	help
+	  Choose this option to enable the system dmabuf heap. The system heap
+	  is backed by pages from the buddy allocator. If in doubt, say Y.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index de49898112db..d1808eca2581 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= heap-helpers.o
+obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
new file mode 100644
index 000000000000..6a16806181c2
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF System heap exporter
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <asm/page.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-heap.h>
+#include <linux/err.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#include "heap-helpers.h"
+
+struct system_heap {
+	struct dma_heap *heap;
+} sys_heap;
+
+static void system_heap_free(struct heap_helper_buffer *buffer)
+{
+	pgoff_t pg;
+
+	for (pg = 0; pg < buffer->pagecount; pg++)
+		__free_page(buffer->pages[pg]);
+	kfree(buffer->pages);
+	kfree(buffer);
+}
+
+static int system_heap_allocate(struct dma_heap *heap,
+				unsigned long len,
+				unsigned long fd_flags,
+				unsigned long heap_flags)
+{
+	struct heap_helper_buffer *helper_buffer;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
+	pgoff_t pg;
+
+	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
+	if (!helper_buffer)
+		return -ENOMEM;
+
+	INIT_HEAP_HELPER_BUFFER(helper_buffer, system_heap_free);
+	helper_buffer->heap_buffer.flags = heap_flags;
+	helper_buffer->heap_buffer.heap = heap;
+	helper_buffer->heap_buffer.size = len;
+
+	helper_buffer->pagecount = len / PAGE_SIZE;
+	helper_buffer->pages = kmalloc_array(helper_buffer->pagecount,
+					     sizeof(*helper_buffer->pages),
+					     GFP_KERNEL);
+	if (!helper_buffer->pages) {
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	for (pg = 0; pg < helper_buffer->pagecount; pg++) {
+		helper_buffer->pages[pg] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!helper_buffer->pages[pg])
+			goto err1;
+	}
+
+	/* create the dmabuf */
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = len;
+	exp_info.flags = fd_flags;
+	exp_info.priv = &helper_buffer->heap_buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto err1;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
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
+err1:
+	while (pg > 0)
+		__free_page(helper_buffer->pages[--pg]);
+	kfree(helper_buffer->pages);
+err0:
+	kfree(helper_buffer);
+
+	return -ENOMEM;
+}
+
+static struct dma_heap_ops system_heap_ops = {
+	.allocate = system_heap_allocate,
+};
+
+static int system_heap_create(void)
+{
+	struct dma_heap_export_info exp_info;
+	int ret = 0;
+
+	exp_info.name = "system_heap";
+	exp_info.ops = &system_heap_ops;
+	exp_info.priv = &sys_heap;
+
+	sys_heap.heap = dma_heap_add(&exp_info);
+	if (IS_ERR(sys_heap.heap))
+		ret = PTR_ERR(sys_heap.heap);
+
+	return ret;
+}
+device_initcall(system_heap_create);
-- 
2.17.1

