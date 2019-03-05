Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86321C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6E42075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9lnW8Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfCEUyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:54:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfCEUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so6623693pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10sN7326k7j9LMSRAvavufAoxXSQ/sxj9rGttiEYBLI=;
        b=y9lnW8Kmg4irPZPNx525O45cijd7sNdoQiLbkI6aBgRQH4pY3hwkFcZpSHZpvky9FZ
         wpSE5CC9PnR8pSMtn0ZsW1xOz92fTrNyLGW2r7ABwUQmx3L2VMncHcp5P3veEfzU6L4+
         q2380Qw4gqYxrEPwi4arsJBcSu0eyBPNppR4/XvZxWsXchOWW4w8+QagHCsbsll+/3wx
         sp2F2H9XMwiCaWco6ECKJLGvu1nVENUrD52ScmkmD7PLxFiW4HRE8F73dtwP6om+pRd+
         0rtk3moDnsiXq1f9dQsdo7nXNnzESau052vS2EGHRWvdKP1Km7azf1V1S5TQulCcFwCs
         6f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10sN7326k7j9LMSRAvavufAoxXSQ/sxj9rGttiEYBLI=;
        b=rRo4X13obMccDsscSyYTeUSDXgkv/TvtRrpORxDNTzJFnqqbO4iIONC3VLHuUf5X1l
         74ucVX7s1+af0YfrarPF4xbtxKThp6UF9sQUvf5ueX33K8R1fBjkCa9XdfOA4qPmDtmG
         ne5Q7xZjv9t6SDE7hjcp9MWwdFK0vhkqmq6k6Y9FbVs/bLLpJqQoJHfvkl6uDiVYuxwO
         JkEwISgitGneRel+RJM/h88dzhTT2C7IE8RtxENhsNeoOVGscoK2gDJiV2OD2EdB6MWI
         0CFCsab4XrN7CTqsdBYm7UglwtIZm6yjI7ky1/PAmeUBTyI7sGdAAn7AgWECJT7WBeiU
         BFKQ==
X-Gm-Message-State: APjAAAXRQbyBJriHZ9LiLSAc5Bc7b9pK8ydcKMoOKXsGvRSQplOGOFmX
        23I34hYAhBFwT7j2fAAmlc05J/2pTzI=
X-Google-Smtp-Source: APXvYqyw6P1dcy/08qrowb3Lcm2ulZcEET3axbofUHPNEjyyJTCXZqG8t1VPyxs28WwSFfLYwYRtGw==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr3194304plr.139.1551819286365;
        Tue, 05 Mar 2019 12:54:46 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:45 -0800 (PST)
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
Subject: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf heaps
Date:   Tue,  5 Mar 2019 12:54:31 -0800
Message-Id: <1551819273-640-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
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
* Droped dead system-contig code
---
 drivers/dma-buf/Kconfig             |   2 +
 drivers/dma-buf/heaps/Kconfig       |   6 ++
 drivers/dma-buf/heaps/Makefile      |   1 +
 drivers/dma-buf/heaps/system_heap.c | 132 ++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
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
index 0000000..e001661
--- /dev/null
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -0,0 +1,132 @@
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
+
+struct system_heap {
+	struct dma_heap heap;
+};
+
+
+static void system_heap_free(struct heap_helper_buffer *buffer)
+{
+	int i;
+	struct scatterlist *sg;
+	struct sg_table *table = buffer->sg_table;
+
+	for_each_sg(table->sgl, sg, table->nents, i)
+		__free_page(sg_page(sg));
+
+	sg_free_table(table);
+	kfree(table);
+	kfree(buffer);
+}
+
+static int system_heap_allocate(struct dma_heap *heap,
+				unsigned long len,
+				unsigned long flags)
+{
+	struct heap_helper_buffer *helper_buffer;
+	struct sg_table *table;
+	struct scatterlist *sg;
+	int i, j;
+	int npages = PAGE_ALIGN(len) / PAGE_SIZE;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
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
+	table = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
+	if (!table)
+		goto err0;
+
+	i = sg_alloc_table(table, npages, GFP_KERNEL);
+	if (i)
+		goto err1;
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		struct page *page;
+
+		page = alloc_page(GFP_KERNEL);
+		if (!page)
+			goto err2;
+		sg_set_page(sg, page, PAGE_SIZE, 0);
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
+		goto err2;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
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
+
+err2:
+	for_each_sg(table->sgl, sg, i, j)
+		__free_page(sg_page(sg));
+	sg_free_table(table);
+err1:
+	kfree(table);
+err0:
+	kfree(helper_buffer);
+	return -ENOMEM;
+}
+
+
+static struct dma_heap_ops system_heap_ops = {
+	.allocate = system_heap_allocate,
+};
+
+static int system_heap_create(void)
+{
+	struct system_heap *sys_heap;
+
+	sys_heap = kzalloc(sizeof(*sys_heap), GFP_KERNEL);
+	if (!sys_heap)
+		return -ENOMEM;
+	sys_heap->heap.name = "system_heap";
+	sys_heap->heap.ops = &system_heap_ops;
+
+	dma_heap_add(&sys_heap->heap);
+
+	return 0;
+}
+device_initcall(system_heap_create);
-- 
2.7.4

