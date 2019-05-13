Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E074C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019C1208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMVPwHtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfEMShx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:37:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36758 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfEMShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:37:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so7208754pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pksOvnyHpZN4MdrMWr5EO61V7mUvaoL7ZYP9ufezzeQ=;
        b=CMVPwHtJ6snzx4UzujJmTFtWfRTVyZtIFTIpOCAQkdON+8elJ6pq5QtNNZkqUpgrce
         daZsvXrkwTo/wkKpFngOEUs0EI+RA1rFNV6RpmA77m0VrfabRxEv+hhRhGMrIIwWffb1
         k/usWGAzeJap3XwUL83aWRvhnOJcCpMCl7TDFH1FAnokwx0msaB5TmECI+hw1kTYTwcg
         sEq7Yap1XSYRLf+DVo2ODXCtovP1m34e5xRk26glMXKhLofw9kv2i0iFqooZelfbdv8d
         rVZaCiZvpYjMSPWuaEipIq1FTyp8VwxmooKE4KyM42i5qkxBQlGrvXLhqp5/q+UYfggI
         AKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pksOvnyHpZN4MdrMWr5EO61V7mUvaoL7ZYP9ufezzeQ=;
        b=tlLPE1xKTsGVWXGwp/QUF1FyuWQ3jz2kwccPJeoE2PCKYIAQj9hDJChaZi9Ou26RMt
         T+m/22hZZ1r4FS4iauyWK5DnY9+J4i9YLSUZxYwS34wM4dNoP7n0qzyX+Qr4UDcn/91+
         b4WIBYV/prn4VTcVueYpohPnQbpxuSXof+pGPObJVZtGhNRinYgSfOOxlNRrR42VqhEF
         sMoGbVf2G109kwgP2MLyIFWNKt2TwXfiIe7VrJOXIgno42cff1oi718oIHQib3DCcR3S
         E1cokBaVhD7JfYgZeNAjC5N523J8pCe4LF/TlE6oGIRgfCDKOsN2ElBdTrOgeY7j4S4W
         FtCQ==
X-Gm-Message-State: APjAAAW4NXWB849lOEnebRuCYM31nL0yO5GSWXRgukFEIuHpVXUEPveH
        v4ddEtS0GcQNYyjVSNJF8NcSagVkz0A=
X-Google-Smtp-Source: APXvYqxO+PQl4VMbDmDSLqWr2bN+xGoO+r1774xAKAHLpGcL+wPoVuj0udn5c8luvn3KwMtNtDMjkA==
X-Received: by 2002:a63:1650:: with SMTP id 16mr33397157pgw.164.1557772657122;
        Mon, 13 May 2019 11:37:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u11sm17334881pfh.130.2019.05.13.11.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:37:36 -0700 (PDT)
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
Subject: [RFC][PATCH 3/5 v4] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Mon, 13 May 2019 11:37:25 -0700
Message-Id: <20190513183727.15755-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513183727.15755-1-john.stultz@linaro.org>
References: <20190513183727.15755-1-john.stultz@linaro.org>
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
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 162 ++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/system_heap.c

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 8344cdaaa328..e34b6e61b702 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -46,4 +46,6 @@ menuconfig DMABUF_HEAPS
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
index 000000000000..60ee531e1a24
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,162 @@
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
+
+#define NUM_ORDERS ARRAY_SIZE(orders)
+#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
+				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
+				| __GFP_COMP)
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
+static const unsigned int orders[] = {8, 4, 0};
+
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
+static struct page *alloc_largest_available(unsigned long size,
+					    unsigned int max_order)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < NUM_ORDERS; i++) {
+		if (size <  (PAGE_SIZE << orders[i]))
+			continue;
+		if (max_order < orders[i])
+			continue;
+
+		page = alloc_pages(order_flags[i], orders[i]);
+		if (!page)
+			continue;
+		return page;
+	}
+	return NULL;
+}
+
+
+static int system_heap_allocate(struct dma_heap *heap,
+				unsigned long len,
+				unsigned long fd_flags,
+				unsigned long heap_flags)
+{
+	struct heap_helper_buffer *helper_buffer;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	unsigned long size_remaining = len;
+	unsigned int max_order = orders[0];
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
+	pg = 0;
+	while (size_remaining > 0) {
+		struct page *page = alloc_largest_available(size_remaining,
+							    max_order);
+		int i;
+
+		if (!page)
+			goto err1;
+		size_remaining -= PAGE_SIZE << compound_order(page);
+		max_order = compound_order(page);
+		for (i = 0; i < 1 << max_order; i++)
+			helper_buffer->pages[pg++] = page++;
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

