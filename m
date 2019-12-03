Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CA12073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdBRxm93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLCR0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:26:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37703 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfLCR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:26:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so1960673plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62c/6FPwz+q6rvXrG8i3YVfn6MxAXoMreZTxPxOlj5A=;
        b=TdBRxm93MWEJzLPG3GFmjGfx9o6FR4Xsykb8BQA7fymlky86MVXEOAUyqGbiasfRD2
         C5/BQraHivWT/xoldACd0bT+JhRJITX+L3NUcAufY1tMfIPKmczoXM9ZaUXSo2blvTJD
         zWwDL3DvZsXytdVuBPD2+EdA9aRupeBkF3lcs/eF4Ee7HqqPAqn/+gT++BF9AL3QaYnp
         cS5zSGMU2nX0tuSI49Hq4/kcS1SkOCmbv9J1LOBXE/vSuf/BKN1AlKvQMjZTB5PFPAJc
         BoIV6TA95dalrNmXwSkwmRTbcWnN+pmBqlElNh0oV+sTEVh0xq2gGtmwEakg/ogGPtFz
         mM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62c/6FPwz+q6rvXrG8i3YVfn6MxAXoMreZTxPxOlj5A=;
        b=jHOy8ENIFxfb27s5BXfmaddEF8wjcEzcLB2m+5xkfQd+ikmWeO7a02ws5L2QRcitFm
         zE3/bmGAGYctefEp6BHwzfjKfuhLbrqR8cbz2p5KX+aSAxrFJtd0RbFr/jC0Mcas3fZv
         1ca96aANi/yqpe2iILwz8P12kiymr2UH+qlucc2wsyxOx5ujvxCJarq1WS99iFjXp8rc
         XJaulN41D+WasOBA1LDxFSkAzWlFmYPhAA8YJhE1R5kGTjuzyDNDl3Kk4AMJO3zMPzsr
         dkJdO5+/5KhkMJXYPAxc1x1yO2OW3wHNDxvebl7ZXjePsVrTivikuhAZcSnNQDpqlTR2
         cHLQ==
X-Gm-Message-State: APjAAAWj0yfYN1cdRR97dVZlpPNFIH/34/VmrYE/F1LmJQNZmwkC2n2C
        vjrqI6UCuLW83jj3yRMYL97vsxI1EaI=
X-Google-Smtp-Source: APXvYqwTvd+G7j/muP9d4H1LYFWUAYeYC+6TXLm+r+/Ehkl8KbkkauA3iVfSzy2+GF7qEXDIKwBXqA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr5841727plo.329.1575394008406;
        Tue, 03 Dec 2019 09:26:48 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l9sm4066177pgh.34.2019.12.03.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:26:47 -0800 (PST)
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND][PATCH v16 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Tue,  3 Dec 2019 17:26:39 +0000
Message-Id: <20191203172641.66642-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203172641.66642-1-john.stultz@linaro.org>
References: <20191203172641.66642-1-john.stultz@linaro.org>
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
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Sandeep Patil <sspatil@android.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
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
v12:
* Minor tweaks to prep loading heap from module
v14:
* Fix "redundant assignment to variable ret" issue reported
  by Colin King and fixed by Andrew Davis
v15:
* Drop unused heap flag from heap_helper_buffer as suggested
  by Sandeep Patil
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 123 ++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/system_heap.c

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index bffa58fc3e6e..0613bb7770f5 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -53,4 +53,6 @@ menuconfig DMABUF_HEAPS
 	  allows userspace to allocate dma-bufs that can be shared
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
index 000000000000..1aa01e98c595
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF System heap exporter
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-heap.h>
+#include <linux/err.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/sched/signal.h>
+#include <asm/page.h>
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
+	return ret;
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
+module_init(system_heap_create);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

