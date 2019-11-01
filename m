Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8AECA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7B218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FottNfCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfKAVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:42:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33254 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfKAVmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:42:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c184so7926239pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsyNUtxc9hXZeSAhIQe7CJ4uz0AseevIwmkwC456WIM=;
        b=FottNfCa6Y2ifojb04XiQ4QD7BavbugchST44Gitb/q4wPFyuBg0HpoteYS6zSLrgS
         B0/t6BxerfwYT4VQ9maXk88FF1jPqJFAWh2zasRJgbwaZOKMFIccZ4VtXVo7rNDnelQc
         6ZwnXWDoSbJ0baqNQTmEHIM29AnTHTLyExB0Rcq6uCHa/zxgyJxFHfDrG5qutGPMOyJI
         Mbz7x9uAmoSpEvXLXrDQeK3FazRx5HhQpJA9EIghuoL2P3CuxyN35Cxl1vD9zfd+HBiP
         FaDWuOQmdDuU9KsKbN9BPrTbp4ejlSMqXCkscxdZm2kat/Ij+8cf8NoD2TYX4S1fN/oV
         KSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsyNUtxc9hXZeSAhIQe7CJ4uz0AseevIwmkwC456WIM=;
        b=NjRIjnOnPzQrpdLHvCjDOJgC52Xcx+LQ4d7kmcAyp3iM3E9flxc46SlcGlYKQyMg0v
         dXX0DJJNWBPWXIQmeaJcZQftjGK6+UOAuFjO2gpibtk7DD8+4CvIEMzq74ee62wirRO8
         5ktP8y/ihBzT6ZaXeaVTB0Q+Y+hy/cEx45zWrsPUkNCYd008rIji4l2jBxRfPMmoehBd
         0HXYJFQiAzuLbMZJN0kGEi++xbbQ6tBqqDUPEHtj0SvKXIQQfIeibUkxpPLmmW/u3IkV
         zbJeQhGR+TCZZvG4zF9/6Tolx2S1s38eFVTvoWqJu8KQk18GWzhPPA66ptIPH8C70lKS
         WKRg==
X-Gm-Message-State: APjAAAXu2FKJ3Pkjq1zRhIwaxPqNGZf+OZDFJH4qWCp0z/fILQt72I7f
        wk03eKpZRlSgZynDWrFGQvaEB93AnaQ=
X-Google-Smtp-Source: APXvYqzD05OeotubP9D6EuYseumR2DT41+TpoL69H5vG+rcqcfKHVj/jrqYz5iZrdLfnH93q2/977w==
X-Received: by 2002:a62:108:: with SMTP id 8mr16120307pfb.53.1572644565180;
        Fri, 01 Nov 2019 14:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u36sm8299058pgn.29.2019.11.01.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:42:44 -0700 (PDT)
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
Subject: [PATCH v14 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Fri,  1 Nov 2019 21:42:36 +0000
Message-Id: <20191101214238.78015-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101214238.78015-1-john.stultz@linaro.org>
References: <20191101214238.78015-1-john.stultz@linaro.org>
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
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 124 ++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)
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
index 000000000000..9a56393e40b4
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,124 @@
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

