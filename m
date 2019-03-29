Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E22183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbA1bYUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfC2AQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:16:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43363 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfC2AQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:16:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so291634pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ErZHW0xXHQOtHF8GgpwR2Y0iAGiFqBZ9Qw3SJrGI8Y=;
        b=BbA1bYUleMH6srk+p8AhjUT3zZT5o5NCDatjMmdD99ai86fogk8ueAsFxTXT/C6VbU
         DPsHf7QyWdNPoo9uJbr8YWf4f8ejXnxtLOAicBLGEG2khUGAFBDfgmBrD2q3sYJfDTL7
         KPT/eZhRlqFMSf9eG0/1w8OAFDur9LtQlCrN5lco5BXHPhXFGgQ479Veoif5gTLOOBBC
         4k1ElYAtJRuHHwG/77+ASDrCxATOgRjl8sYJzANXVeAmYMvSmDEbl1KDiqFpx751nWTc
         EQz6525IOlGtSDGtvox54avpS7qMuoDv3/mc9EQKjIisBYa35fD1gnm7Sv/tNLRTkDNX
         4Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ErZHW0xXHQOtHF8GgpwR2Y0iAGiFqBZ9Qw3SJrGI8Y=;
        b=R8jkHm8tqeqaHBpsHZArUpQ/KvC0rojBykGAo5EQ/z30u5imUuJDJCYdmckX04fHWZ
         79H/UM1uzsXdGDkIxrG+n4KhUp2/GEoT8qZeDvTi+p+RBR4DrdhH4RL/PI2KBH1ovSs4
         vGPU4VoR7L7D2OP65W3he1w+WuyNqcqxFZBUylcVJZ7sLz9wlSyxIUf5cRdqab42zkpM
         rUO5EOp7uMz1MKmgUVA/+GFFfYCCCh3DJg2D6EeCz4TlZrVoZM/3xlWAT4gAK1eiLg2W
         f8cZtKByol1SgwLEc6TY4NZ8iOAsmj19nC/so2jMGnZ6/dCUzjWn0gGRBKsOtaItynwL
         Aa1A==
X-Gm-Message-State: APjAAAWphqHR8ydoVFcidpv0xL0AeJWGq6qWN/nmO7OOpFV4rr6cUX3i
        pI23i9V8jkfXV7gXPeQq0/ObTUyZYPI=
X-Google-Smtp-Source: APXvYqzpRv45mSiBRK4F8uIHbxMsgJ9NfclX6N6S5IIrui0p7t2w7YqterIiSae09yISN9fiZ3NLag==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr43127793pgr.187.1553818573589;
        Thu, 28 Mar 2019 17:16:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id g5sm430137pfo.53.2019.03.28.17.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 17:16:12 -0700 (PDT)
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
Subject: [RFC][PATCH 3/6 v3] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Thu, 28 Mar 2019 17:15:59 -0700
Message-Id: <1553818562-2516-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
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
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 120 ++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/system_heap.c

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 09c61db..63c139d 100644
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
index 0000000..2050527
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
index de49898..d1808ec 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= heap-helpers.o
+obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
new file mode 100644
index 0000000..f58ee3f
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,120 @@
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
+				unsigned long flags)
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
+	helper_buffer->heap_buffer.flags = flags;
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
+	exp_info.flags = O_RDWR;
+	exp_info.priv = &helper_buffer->heap_buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto err1;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
+
+	ret = dma_buf_fd(dmabuf, O_CLOEXEC);
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
2.7.4

