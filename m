Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07609C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FB320838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYHHvwbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406178AbfIFSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:47:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45356 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405083AbfIFSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:47:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so3942308pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bteUBRSovqxiREZAaKxuf2P5GWKtzttCSC6EU+uFSpU=;
        b=wYHHvwbqJ7HaMYcTkWb2dYNF4W2+NAqxn7tlNQMBrJzw+tTBU6H5R9G6RnJQJFH6H1
         sVWcPG9rLnl62rIBoCi1Bk4PTKr9Txy1+7IhcQAg6e3xBSqWL1WGu11uTpxhucPx2btq
         D0QZXCOOIdJFrC0gNZJt1ggOelOxRtbQHNV4NIw2mtD9y0hIWfPoZHGaKQa5RDCJU+QI
         BgUAD6CatfeW/Vu4B5chs2KMblYoqxMkJ2WIhUB0gAKnkJAt8P/MVLSguRdBqHAir4u0
         bbVxTjr3UL/d8HhvkIL6RDmNU/A+jJl4Ob/P8dTJ5agRZYYFlmunQxMFRXLO3/syO1Ch
         29sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bteUBRSovqxiREZAaKxuf2P5GWKtzttCSC6EU+uFSpU=;
        b=WsjdGKcJTRt+EyD3eTKZDUY00+PbMLirIboDdEHm5iQJ2f88FdsAwGJpfBNJyhGFkX
         sOM3dBJBDDPQAd/2RHKBGAWerS3nJejqGvHP9IUUntKUA6LHNMdBoKqQ0z/zbnEBn1cP
         ukpVvAkKUlsd5PqIHCdcFBiMejgIfSp6iCQ6MtdnWsgaW2qcEfV87jQAVMmJHnjMq2GX
         R1FSe1IKKbrwuEDQmlis5uUCWfjxvVh5Lifnn5xlG53yxKtqBCDNM9lxvYswtc3DBFo2
         uHOz4B+mkeMQytZnmkMu3EPgdGyfr+YkXT6frdtI+TQIcStz4BkKHLl6kze6SalSfpXi
         VXCA==
X-Gm-Message-State: APjAAAXXrCSrZ0gvrFp6w2AxIRXxy6JmQFuSdbJz9zo4XUBlXa1RG0EH
        84OtN3XXyXUQGoRki9+QZX8AcH4/epc=
X-Google-Smtp-Source: APXvYqxUd7CeOske7s7rKJ5qenySNBiLKVhOtGGcx2JVBT5NDIDkolf3oDezDlaXOrdICm2PTDjaqg==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr12281895pfb.17.1567795643355;
        Fri, 06 Sep 2019 11:47:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o35sm4889462pgm.29.2019.09.06.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 11:47:22 -0700 (PDT)
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
Subject: [RESEND][PATCH v8 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Fri,  6 Sep 2019 18:47:10 +0000
Message-Id: <20190906184712.91980-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906184712.91980-1-john.stultz@linaro.org>
References: <20190906184712.91980-1-john.stultz@linaro.org>
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
v7:
* Use newly lower-cased init_heap_helper_buffer helper
* Add system heap DOS avoidance suggested by Laura from ION code
* Use new dmabuf export helper
v8:
* Make struct dma_heap_ops consts (suggested by Christoph)
* Get rid of needless struct system_heap (suggested by Christoph)
* Condense dma_heap_buffer and heap_helper_buffer (suggested by
  Christoph)
* Add forgotten include file to fix build issue on x86
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 122 ++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/system_heap.c

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 162e24e1e429..657ce743abda 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -48,4 +48,6 @@ menuconfig DMABUF_HEAPS
 	  allows userspace to use to allocate dma-bufs that can be shared
 	  between drivers.
 
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
index 000000000000..5db4ef9b4afc
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,122 @@
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
+#include <linux/sched/signal.h>
+
+#include "heap-helpers.h"
+
+struct dma_heap *sys_heap;
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
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
+	pgoff_t pg;
+
+	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
+	if (!helper_buffer)
+		return -ENOMEM;
+
+	init_heap_helper_buffer(helper_buffer, system_heap_free);
+	helper_buffer->flags = heap_flags;
+	helper_buffer->heap = heap;
+	helper_buffer->size = len;
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
+		/*
+		 * Avoid trying to allocate memory if the process
+		 * has been killed by by SIGKILL
+		 */
+		if (fatal_signal_pending(current))
+			goto err1;
+
+		helper_buffer->pages[pg] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!helper_buffer->pages[pg])
+			goto err1;
+	}
+
+	/* create the dmabuf */
+	dmabuf = heap_helper_export_dmabuf(helper_buffer, fd_flags);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto err1;
+	}
+
+	helper_buffer->dmabuf = dmabuf;
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
+static const struct dma_heap_ops system_heap_ops = {
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
+	exp_info.priv = NULL;
+
+	sys_heap = dma_heap_add(&exp_info);
+	if (IS_ERR(sys_heap))
+		ret = PTR_ERR(sys_heap);
+
+	return ret;
+}
+device_initcall(system_heap_create);
-- 
2.17.1

