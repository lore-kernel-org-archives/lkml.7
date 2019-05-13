Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B0BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPQENRQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfEMSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:38:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34283 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfEMShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:37:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so7662793pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gATWMxDxmzE+Kqrehkxf/HK0LYrFdMlroJJW15098zI=;
        b=xPQENRQD3xB5rkEH3fmjoqmS6J7mA2UN8L8WgN45PTWl9x/e7eY8REqvOCXhLDqt/q
         FmgBn/3cUgZ20lVFVD2FF5XVM47qdIVwIY5gcT1z2G+e077c7A9eAL7Lv9Vqm1Igcd5T
         VgK8VTAXSHpd3GjJNdOa6uf7O4OxQU2gh92J6VIh6iTkxouWADvmu992h2QFhzi68vbV
         Y2/F1PEJ3pKeLTo8PAPgtmF/hXSs5uj/V1Ufzo5D5mMKWAmPhMlupl4HWDjIyEtDvv3M
         GahYiZ2i3v1fN0MgrG7tr1QFkLWEONz3nKfzLQXW+y3A+yRMKmSYpsNl+c2XYsGTU5fT
         3sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gATWMxDxmzE+Kqrehkxf/HK0LYrFdMlroJJW15098zI=;
        b=QNSFbaPOFwLKrqKj1iAxOoWMW/6Xi9HkidxntIU9lXbgyCEfNDJJa7OD5ocNIafJJ/
         z8/JgPurYQGzsK5cvemOzh1tfeX6VGRaNeLFxN1L5JKBFmXioALSPGoFe58bOB5qQuIx
         Sk1CbAk9oh47+af2UDwDRrawmvYYlE1vg6lyDyaX4hgmP/482cvnVL/j7tX+WZrCrQ5/
         pY/4jOv2uOi1KUtD71Ff2h1CK7OgrYx1ltNDSXH0Iwh4M6tLFvTmco+QdiwXnEU+/Tit
         9aEINEABKJ89fMYF49ESFa6UBYdu9BFePzSjVw3pMdiLqQMkvaM038fyQpsupjEbBEbo
         lYig==
X-Gm-Message-State: APjAAAVb7rHqKg6yrQH/wnCKsj2AD/mlksHkr14b7l0pYxv5yjEP6jas
        D+aCwVrUER61IrJmM3k73cLQBLSKeoI=
X-Google-Smtp-Source: APXvYqxbpZ7Py6ANjtv5lmvcwTTYayLktNBid9ffOZKw0EymOnxcjUccRx+1qZiSUKMJuHhm76pJYA==
X-Received: by 2002:a63:8342:: with SMTP id h63mr33988771pge.251.1557772653475;
        Mon, 13 May 2019 11:37:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u11sm17334881pfh.130.2019.05.13.11.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:37:32 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 1/5 v4] dma-buf: Add dma-buf heaps framework
Date:   Mon, 13 May 2019 11:37:23 -0700
Message-Id: <20190513183727.15755-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513183727.15755-1-john.stultz@linaro.org>
References: <20190513183727.15755-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

This framework allows a unified userspace interface for dma-buf
exporters, allowing userland to allocate specific types of memory
for use in dma-buf sharing.

Each heap is given its own device node, which a user can allocate
a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.

This code is an evoluiton of the Android ION implementation,
and a big thanks is due to its authors/maintainers over time
for their effort:
  Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
  Laura Abbott, and many other contributors!

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
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Folded down fixes I had previously shared in implementing
  heaps
* Make flags a u64 (Suggested by Laura)
* Add PAGE_ALIGN() fix to the core alloc funciton
* IOCTL fixups suggested by Brian
* Added fixes suggested by Benjamin
* Removed core stats mgmt, as that should be implemented by
  per-heap code
* Changed alloc to return a dma-buf fd, rather then a buffer
  (as it simplifies error handling)
v3:
* Removed scare-quotes in MAINTAINERS email address
* Get rid of .release function as it didn't do anything (from
  Christoph)
* Renamed filp to file (suggested by Christoph)
* Split out ioctl handling to separate function (suggested by
  Christoph)
* Add comment documenting PAGE_ALIGN usage (suggested by Brian)
* Switch from idr to Xarray (suggested by Brian)
* Fixup cdev creation (suggested by Brian)
* Avoid EXPORT_SYMBOL until we finalize modules (suggested by
  Brian)
* Make struct dma_heap internal only (folded in from Andrew)
* Small cleanups suggested by GregKH
* Provide class->devnode callback to get consistent /dev/
  subdirectory naming (Suggested by Bjorn)
v4:
* Folded down dma-heap.h change that was in a following patch
* Added fd_flags entry to allocation structure and pass it
  through to heap code for use on dma-buf fd creation (suggested
  by Benjamin)
---
 MAINTAINERS                   |  18 +++
 drivers/dma-buf/Kconfig       |   8 ++
 drivers/dma-buf/Makefile      |   1 +
 drivers/dma-buf/dma-heap.c    | 241 ++++++++++++++++++++++++++++++++++
 include/linux/dma-heap.h      |  59 +++++++++
 include/uapi/linux/dma-heap.h |  56 ++++++++
 6 files changed, 383 insertions(+)
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 include/linux/dma-heap.h
 create mode 100644 include/uapi/linux/dma-heap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e77c31652881..7d85484fa8db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4725,6 +4725,24 @@ F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
+DMA-BUF HEAPS FRAMEWORK
+M:	Sumit Semwal <sumit.semwal@linaro.org>
+R:	Andrew F. Davis <afd@ti.com>
+R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
+R:	Liam Mark <lmark@codeaurora.org>
+R:	Laura Abbott <labbott@redhat.com>
+R:	Brian Starkey <Brian.Starkey@arm.com>
+R:	John Stultz <john.stultz@linaro.org>
+S:	Maintained
+L:	linux-media@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
+F:	include/uapi/linux/dma-heap.h
+F:	include/linux/dma-heap.h
+F:	drivers/dma-buf/dma-heap.c
+F:	drivers/dma-buf/heaps/*
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 L:	dmaengine@vger.kernel.org
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 3fc9c2efc583..8344cdaaa328 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -38,4 +38,12 @@ config UDMABUF
 	  A driver to let userspace turn memfd regions into dma-bufs.
 	  Qemu can use this to create host dmabufs for guest framebuffers.
 
+menuconfig DMABUF_HEAPS
+	bool "DMA-BUF Userland Memory Heaps"
+	select DMA_SHARED_BUFFER
+	help
+	  Choose this option to enable the DMA-BUF userland memory heaps,
+	  this allows userspace to allocate dma-bufs that can be shared between
+	  drivers.
+
 endmenu
diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index 0913a6ccab5a..b0332f143413 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,4 +1,5 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
+obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
 obj-$(CONFIG_UDMABUF)		+= udmabuf.o
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
new file mode 100644
index 000000000000..d8c3e586fec6
--- /dev/null
+++ b/drivers/dma-buf/dma-heap.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Framework for userspace DMA-BUF allocations
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/cdev.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/xarray.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/dma-heap.h>
+#include <uapi/linux/dma-heap.h>
+
+#define DEVNAME "dma_heap"
+
+#define NUM_HEAP_MINORS 128
+
+/**
+ * struct dma_heap - represents a dmabuf heap in the system
+ * @name:		used for debugging/device-node name
+ * @ops:		ops struct for this heap
+ * @minor		minor number of this heap device
+ * @heap_devt		heap device node
+ * @heap_cdev		heap char device
+ *
+ * Represents a heap of memory from which buffers can be made.
+ */
+struct dma_heap {
+	const char *name;
+	struct dma_heap_ops *ops;
+	void *priv;
+	unsigned int minor;
+	dev_t heap_devt;
+	struct cdev heap_cdev;
+};
+
+static dev_t dma_heap_devt;
+static struct class *dma_heap_class;
+static DEFINE_XARRAY_ALLOC(dma_heap_minors);
+
+static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
+				 unsigned int fd_flags,
+				 unsigned int heap_flags)
+{
+	/*
+	 * Allocations from all heaps have to begin
+	 * and end on page boundaries.
+	 */
+	len = PAGE_ALIGN(len);
+	if (!len)
+		return -EINVAL;
+
+	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
+}
+
+static int dma_heap_open(struct inode *inode, struct file *file)
+{
+	struct dma_heap *heap;
+
+	heap = xa_load(&dma_heap_minors, iminor(inode));
+	if (!heap) {
+		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
+		return -ENODEV;
+	}
+
+	/* instance data as context */
+	file->private_data = heap;
+	nonseekable_open(inode, file);
+
+	return 0;
+}
+
+static long dma_heap_ioctl_allocate(struct file *file, unsigned long arg)
+{
+	struct dma_heap_allocation_data heap_allocation;
+	struct dma_heap *heap = file->private_data;
+	int fd;
+
+	if (copy_from_user(&heap_allocation, (void __user *)arg,
+			   sizeof(heap_allocation)))
+		return -EFAULT;
+
+	if (heap_allocation.fd ||
+	    heap_allocation.reserved0 ||
+	    heap_allocation.reserved1) {
+		pr_warn_once("dma_heap: ioctl data not valid\n");
+		return -EINVAL;
+	}
+
+	if (heap_allocation.fd_flags & ~DMA_HEAP_VALID_FD_FLAGS) {
+		pr_warn_once("dma_heap: fd_flags has invalid or unsupported flags set\n");
+		return -EINVAL;
+	}
+
+	if (heap_allocation.heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS) {
+		pr_warn_once("dma_heap: heap flags has invalid or unsupported flags set\n");
+		return -EINVAL;
+	}
+
+
+	fd = dma_heap_buffer_alloc(heap, heap_allocation.len,
+				   heap_allocation.fd_flags,
+				   heap_allocation.heap_flags);
+	if (fd < 0)
+		return fd;
+
+	heap_allocation.fd = fd;
+
+	if (copy_to_user((void __user *)arg, &heap_allocation,
+			 sizeof(heap_allocation)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long dma_heap_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case DMA_HEAP_IOC_ALLOC:
+		ret = dma_heap_ioctl_allocate(file, arg);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return ret;
+}
+
+static const struct file_operations dma_heap_fops = {
+	.owner          = THIS_MODULE,
+	.open		= dma_heap_open,
+	.unlocked_ioctl = dma_heap_ioctl,
+};
+
+/**
+ * dma_heap_get_data() - get per-subdriver data for the heap
+ * @heap: DMA-Heap to retrieve private data for
+ *
+ * Returns:
+ * The per-subdriver data for the heap.
+ */
+void *dma_heap_get_data(struct dma_heap *heap)
+{
+	return heap->priv;
+}
+
+struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
+{
+	struct dma_heap *heap;
+	struct device *dev_ret;
+	int ret;
+
+	if (!exp_info->name || !strcmp(exp_info->name, "")) {
+		pr_err("dma_heap: Cannot add heap without a name\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!exp_info->ops || !exp_info->ops->allocate) {
+		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	heap = kzalloc(sizeof(*heap), GFP_KERNEL);
+	if (!heap)
+		return ERR_PTR(-ENOMEM);
+
+	heap->name = exp_info->name;
+	heap->ops = exp_info->ops;
+	heap->priv = exp_info->priv;
+
+	/* Find unused minor number */
+	ret = xa_alloc(&dma_heap_minors, &heap->minor, heap,
+			XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
+	if (ret < 0) {
+		pr_err("dma_heap: Unable to get minor number for heap\n");
+		return ERR_PTR(ret);
+	}
+
+	/* Create device */
+	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
+
+	cdev_init(&heap->heap_cdev, &dma_heap_fops);
+	ret = cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
+	if (ret < 0) {
+		pr_err("dma_heap: Unable to add char device\n");
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * TODO: Need to filter "name" to make
+	 * sure we don't add something crazy
+	 */
+	dev_ret = device_create(dma_heap_class,
+				NULL,
+				heap->heap_devt,
+				NULL,
+				heap->name);
+	if (IS_ERR(dev_ret)) {
+		pr_err("dma_heap: Unable to create device\n");
+		cdev_del(&heap->heap_cdev);
+		return (struct dma_heap *)dev_ret;
+	}
+
+	return heap;
+}
+
+static char *dma_heap_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
+}
+
+
+static int dma_heap_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&dma_heap_devt, 0, NUM_HEAP_MINORS, DEVNAME);
+	if (ret)
+		return ret;
+
+	dma_heap_class = class_create(THIS_MODULE, DEVNAME);
+	if (IS_ERR(dma_heap_class)) {
+		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
+		return PTR_ERR(dma_heap_class);
+	}
+	dma_heap_class->devnode = dma_heap_devnode;
+
+	return 0;
+}
+subsys_initcall(dma_heap_init);
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
new file mode 100644
index 000000000000..7a1b633ac02f
--- /dev/null
+++ b/include/linux/dma-heap.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMABUF Heaps Allocation Infrastructure
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#ifndef _DMA_HEAPS_H
+#define _DMA_HEAPS_H
+
+#include <linux/cdev.h>
+#include <linux/types.h>
+
+struct dma_heap;
+
+/**
+ * struct dma_heap_ops - ops to operate on a given heap
+ * @allocate:		allocate dmabuf and return fd
+ *
+ * allocate returns dmabuf fd  on success, -errno on error.
+ */
+struct dma_heap_ops {
+	int (*allocate)(struct dma_heap *heap,
+			unsigned long len,
+			unsigned long fd_flags,
+			unsigned long heap_flags);
+};
+
+/**
+ * struct dma_heap_export_info - information needed to export a new dmabuf heap
+ * @name:	used for debugging/device-node name
+ * @ops:	ops struct for this heap
+ * @priv:	heap exporter private data
+ *
+ * Information needed to export a new dmabuf heap.
+ */
+struct dma_heap_export_info {
+	const char *name;
+	struct dma_heap_ops *ops;
+	void *priv;
+};
+
+/**
+ * dma_heap_get_data() - get per-heap driver data
+ * @heap: DMA-Heap to retrieve private data for
+ *
+ * Returns:
+ * The per-heap data for the heap.
+ */
+void *dma_heap_get_data(struct dma_heap *heap);
+
+/**
+ * dma_heap_add - adds a heap to dmabuf heaps
+ * @exp_info:		information needed to register this heap
+ */
+struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
+
+#endif /* _DMA_HEAPS_H */
diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
new file mode 100644
index 000000000000..c382280277d7
--- /dev/null
+++ b/include/uapi/linux/dma-heap.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * DMABUF Heaps Userspace API
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+#ifndef _UAPI_LINUX_DMABUF_POOL_H
+#define _UAPI_LINUX_DMABUF_POOL_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * DOC: DMABUF Heaps Userspace API
+ *
+ */
+
+/* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
+#define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
+
+/* Currently no heap flags */
+#define DMA_HEAP_VALID_HEAP_FLAGS (0)
+
+/**
+ * struct dma_heap_allocation_data - metadata passed from userspace for
+ *                                      allocations
+ * @len:		size of the allocation
+ * @fd:			will be populated with a fd which provdes the
+ *			handle to the allocated dma-buf
+ * @fd_flags:		file descriptor flags used when allocating
+ * @heap_flags:		flags passed to heap
+ *
+ * Provided by userspace as an argument to the ioctl
+ */
+struct dma_heap_allocation_data {
+	__u64 len;
+	__u32 fd;
+	__u32 fd_flags;
+	__u64 heap_flags;
+	__u32 reserved0;
+	__u32 reserved1;
+};
+
+#define DMA_HEAP_IOC_MAGIC		'H'
+
+/**
+ * DOC: DMA_HEAP_IOC_ALLOC - allocate memory from pool
+ *
+ * Takes an dma_heap_allocation_data struct and returns it with the fd field
+ * populated with the dmabuf handle of the allocation.
+ */
+#define DMA_HEAP_IOC_ALLOC	_IOWR(DMA_HEAP_IOC_MAGIC, 0, \
+				      struct dma_heap_allocation_data)
+
+#endif /* _UAPI_LINUX_DMABUF_POOL_H */
-- 
2.17.1

