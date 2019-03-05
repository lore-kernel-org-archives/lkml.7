Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D102075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvBnCV+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfCEUyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:54:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id 125so6226070pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BG94J8n4JZbnxfrekiwpt69zPxSc7JCbOZr/oAI9WHA=;
        b=DvBnCV+VDj6+dTQ3JqYAVu46uY16fx5QHPkEp0TQbCH9iJDLmAAAmUPVlNyfhOA3Ot
         jRcM94UeZmqSG17v3aKd4pggxnbM38DAL8k6azBaWy756ZTGdlovhWnCPUW6iNVvf4rC
         1I4YhSK3IvAsVj2RktHrg/beONtZf1eRla9GTJwRPog+8SCK7nzk/Mb7PatfthTChnjC
         OM7U3DUq45P2tw19RCx8QcjRrtKjF019N5ySCUmbZUqJw8WvyXb18eoHbw5XabTbtbmL
         dvv8RYA2TgjjXwf9K45/B39jMIavUe9Hq7eyEEPgwa++YdiRLLmVr+ptEx0i4MaQ3Ye0
         x68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BG94J8n4JZbnxfrekiwpt69zPxSc7JCbOZr/oAI9WHA=;
        b=O2a0E0EYEX36tRyP17MuUWhpORBcWip0ERDKNfGA+gK4UZ+uReZGPlqaLvruDu2WEF
         sSU+5nng26bhgS/c55UdKpj5d7MPsVVAkFzv4QwwKElZsJ33XqT9tjyGWFBeGsb3Dyrm
         4sexJe0iXwuACxbjenRwASZH8RQg5Yjy44sLwHnqDfOxfiLqKPy3lOFKgRL81pp0wFqs
         pVoZyv+xffmJP+i7/iZ9RvPj5CpsGpkeZIJfkoqbxyDaElrAqkYeBwIyD4ncQ94F/0kA
         WHdOX/vCZGQOMFZ7xDLAbDNurTFyCV7BQmCP77MzPKaArvXhCZkuKutlOdoeRarxkVzq
         zYcw==
X-Gm-Message-State: APjAAAWSWT6tcvKxDyRe1cmHyfdq8XR8WXkrj6CLqiTIYX3+tYAYYwns
        x+X8Gb66g8Ue36Ez5Q1rL3pqRvYknOo=
X-Google-Smtp-Source: APXvYqwhBQzKMB98Agxzd4hdnG+gvvWsB/MpP1KzDsieRzFUOBTztn3nv3OM7smscsoV9DNO6/GoYg==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr3150482plc.326.1551819283088;
        Tue, 05 Mar 2019 12:54:43 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:41 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Date:   Tue,  5 Mar 2019 12:54:29 -0800
Message-Id: <1551819273-640-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

This framework allows a unified userspace interface for dma-buf
exporters, allowing userland to allocate specific types of
memory for use in dma-buf sharing.

Each heap is given its own device node, which a user can
allocate a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.

This code is an evoluiton of the Android ION implementation,
and a big thanks is due to its authors/maintainers over time
for their effort:
  Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
  Laura Abbott, and many other contributors!

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
Signed-off-by: Andrew F. Davis <afd@ti.com>
[jstultz: reworded commit message, and lots of cleanups]
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
---
 MAINTAINERS                   |  16 ++++
 drivers/dma-buf/Kconfig       |   8 ++
 drivers/dma-buf/Makefile      |   1 +
 drivers/dma-buf/dma-heap.c    | 191 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-heap.h      |  65 ++++++++++++++
 include/uapi/linux/dma-heap.h |  52 ++++++++++++
 6 files changed, 333 insertions(+)
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 include/linux/dma-heap.h
 create mode 100644 include/uapi/linux/dma-heap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ac2e518..a661e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4621,6 +4621,22 @@ F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
+DMA-BUF HEAPS FRAMEWORK
+M:	Laura Abbott <labbott@redhat.com>
+R:	Liam Mark <lmark@codeaurora.org>
+R:	Brian Starkey <Brian.Starkey@arm.com>
+R:	"Andrew F. Davis" <afd@ti.com>
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
index 2e5a0fa..09c61db 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -39,4 +39,12 @@ config UDMABUF
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
index 0913a6c..b0332f1 100644
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
index 0000000..14b3975
--- /dev/null
+++ b/drivers/dma-buf/dma-heap.c
@@ -0,0 +1,191 @@
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
+#include <linux/idr.h>
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
+static DEFINE_IDR(dma_heap_idr);
+static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
+
+dev_t dma_heap_devt;
+struct class *dma_heap_class;
+struct list_head dma_heap_list;
+struct dentry *dma_heap_debug_root;
+
+static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
+				 unsigned int flags)
+{
+	len = PAGE_ALIGN(len);
+	if (!len)
+		return -EINVAL;
+
+	return heap->ops->allocate(heap, len, flags);
+}
+
+static int dma_heap_open(struct inode *inode, struct file *filp)
+{
+	struct dma_heap *heap;
+
+	mutex_lock(&minor_lock);
+	heap = idr_find(&dma_heap_idr, iminor(inode));
+	mutex_unlock(&minor_lock);
+	if (!heap) {
+		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
+		return -ENODEV;
+	}
+
+	/* instance data as context */
+	filp->private_data = heap;
+	nonseekable_open(inode, filp);
+
+	return 0;
+}
+
+static int dma_heap_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+static long dma_heap_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long arg)
+{
+	switch (cmd) {
+	case DMA_HEAP_IOC_ALLOC:
+	{
+		struct dma_heap_allocation_data heap_allocation;
+		struct dma_heap *heap = filp->private_data;
+		int fd;
+
+		if (copy_from_user(&heap_allocation, (void __user *)arg,
+				   sizeof(heap_allocation)))
+			return -EFAULT;
+
+		if (heap_allocation.fd ||
+		    heap_allocation.reserved0 ||
+		    heap_allocation.reserved1 ||
+		    heap_allocation.reserved2) {
+			pr_warn_once("dma_heap: ioctl data not valid\n");
+			return -EINVAL;
+		}
+		if (heap_allocation.flags & ~DMA_HEAP_VALID_FLAGS) {
+			pr_warn_once("dma_heap: flags has invalid or unsupported flags set\n");
+			return -EINVAL;
+		}
+
+		fd = dma_heap_buffer_alloc(heap, heap_allocation.len,
+					   heap_allocation.flags);
+		if (fd < 0)
+			return fd;
+
+		heap_allocation.fd = fd;
+
+		if (copy_to_user((void __user *)arg, &heap_allocation,
+				 sizeof(heap_allocation)))
+			return -EFAULT;
+
+		break;
+	}
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static const struct file_operations dma_heap_fops = {
+	.owner          = THIS_MODULE,
+	.open		= dma_heap_open,
+	.release	= dma_heap_release,
+	.unlocked_ioctl = dma_heap_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= dma_heap_ioctl,
+#endif
+};
+
+int dma_heap_add(struct dma_heap *heap)
+{
+	struct device *dev_ret;
+	int ret;
+
+	if (!heap->name || !strcmp(heap->name, "")) {
+		pr_err("dma_heap: Cannot add heap without a name\n");
+		return -EINVAL;
+	}
+
+	if (!heap->ops || !heap->ops->allocate) {
+		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
+		return -EINVAL;
+	}
+
+	/* Find unused minor number */
+	mutex_lock(&minor_lock);
+	ret = idr_alloc(&dma_heap_idr, heap, 0, NUM_HEAP_MINORS, GFP_KERNEL);
+	mutex_unlock(&minor_lock);
+	if (ret < 0) {
+		pr_err("dma_heap: Unable to get minor number for heap\n");
+		return ret;
+	}
+	heap->minor = ret;
+
+	/* Create device */
+	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
+	dev_ret = device_create(dma_heap_class,
+				NULL,
+				heap->heap_devt,
+				NULL,
+				heap->name);
+	if (IS_ERR(dev_ret)) {
+		pr_err("dma_heap: Unable to create char device\n");
+		return PTR_ERR(dev_ret);
+	}
+
+	/* Add device */
+	cdev_init(&heap->heap_cdev, &dma_heap_fops);
+	ret = cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);
+	if (ret < 0) {
+		device_destroy(dma_heap_class, heap->heap_devt);
+		pr_err("dma_heap: Unable to add char device\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dma_heap_add);
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
+
+	return 0;
+}
+subsys_initcall(dma_heap_init);
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
new file mode 100644
index 0000000..ed86a8e
--- /dev/null
+++ b/include/linux/dma-heap.h
@@ -0,0 +1,65 @@
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
+/**
+ * struct dma_heap_buffer - metadata for a particular buffer
+ * @heap:		back pointer to the heap the buffer came from
+ * @dmabuf:		backing dma-buf for this buffer
+ * @size:		size of the buffer
+ * @flags:		buffer specific flags
+ */
+struct dma_heap_buffer {
+	struct dma_heap *heap;
+	struct dma_buf *dmabuf;
+	size_t size;
+	unsigned long flags;
+};
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
+	unsigned int minor;
+	dev_t heap_devt;
+	struct cdev heap_cdev;
+};
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
+			unsigned long flags);
+};
+
+/**
+ * dma_heap_add - adds a heap to dmabuf heaps
+ * @heap:		the heap to add
+ */
+int dma_heap_add(struct dma_heap *heap);
+
+#endif /* _DMA_HEAPS_H */
diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
new file mode 100644
index 0000000..75c5d3f
--- /dev/null
+++ b/include/uapi/linux/dma-heap.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+/* Currently no flags */
+#define DMA_HEAP_VALID_FLAGS (0)
+
+/**
+ * struct dma_heap_allocation_data - metadata passed from userspace for
+ *                                      allocations
+ * @len:		size of the allocation
+ * @flags:		flags passed to pool
+ * @fd:			will be populated with a fd which provdes the
+ *			handle to the allocated dma-buf
+ *
+ * Provided by userspace as an argument to the ioctl
+ */
+struct dma_heap_allocation_data {
+	__u64 len;
+	__u64 flags;
+	__u32 fd;
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 reserved2;
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
2.7.4

