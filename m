Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676FFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030F820843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbGV/rAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHNJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:34:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfHNJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:34:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so52797418pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GK299kDR0vV7SNOJOg9LpYGWAWPNCXyg2WC+aojoqo=;
        b=LbGV/rAQCBtiVTMp+L2GG6w5DWyptLRd/JdLqBv4Lxa+uc+EbLHHkzEIoaqQIvIE68
         FKnr3GNQF75ENlEzq+jo9JMQztpX4mBhem5UzSiPCKHZ3IYiE5uZLJHvIhVO5KMmiGFH
         GCa/b9w8wLJZK1YNEuX4SQKJim2UJ2XimbtOz0mD+BvNUYIR2hCfl+gtSlrNeLxD4/uF
         ebhPyP5fd+eXJjUrrfhis90gRPnBZezdN3m5TBbmYEZIn1VXEDhf4bGGkuDQhMWHAKTh
         vzeaZFiUoJMQysWQeNa+Tt283MOzXku8NSFsx2PnLGjamY42NNsSEkotSU/yQENyq/Au
         jRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GK299kDR0vV7SNOJOg9LpYGWAWPNCXyg2WC+aojoqo=;
        b=p/G4ZD4gWrMm3PcA56ZRyyFAtwSO7+5Ihp/gogXWoQ0Wzf3CZQhD3pCi6wCPjpVzLV
         b/PxEg7vbg/CNkyK4GleIWdiWYGx+BvKAiElguTJJ84hKUCV2Oe74TMQUDo1z3yum5Q9
         DZP8PSh12ALMJ+VDbXXOQwOuInrdb3Wvf92ppn3tXvLjlu0ZKW5PNMDRMwhLkyyPnQGB
         u64FQSbAEbPlz6kKp/GI31F0mPrJz6/H1iPg6MujORmDJUkX02agW2hdwF5FtxkNRB/Y
         lXFYaAwOS09l93b04RkCA7xEluFVWyMtkyELi7Z8RoRwDqCOQLNH0nOrJqXQ0DHLdBcb
         7ZqQ==
X-Gm-Message-State: APjAAAWNhRC51wSdcRKaI0RNCWSjIgoJPjRpRk+qBI6ZmL05w5jP4c6y
        ZxZbq0TiX0wOqnwsygQqgLzH9w==
X-Google-Smtp-Source: APXvYqz6clUxM3vs62vcJ7/SjU6RwkgNzzWy3Y/gpf7xpXYlvIIvMr5rQNGAxzAnLDT4f/7ZvPNgDg==
X-Received: by 2002:aa7:9719:: with SMTP id a25mr19501946pfg.2.1565775287089;
        Wed, 14 Aug 2019 02:34:47 -0700 (PDT)
Received: from localhost.localdomain ([193.187.117.228])
        by smtp.gmail.com with ESMTPSA id v12sm3419815pjk.13.2019.08.14.02.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 02:34:46 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/2] uacce: add uacce module
Date:   Wed, 14 Aug 2019 17:34:25 +0800
Message-Id: <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce is the kernel component to support WarpDrive accelerator
framework. It provides register/unregister interface for device drivers
to expose their hardware resource to the user space. The resource is
taken as "queue" in WarpDrive.

Uacce create a chrdev for every registration, the queue is allocated to
the process when the chrdev is opened. Then the process can access the
hardware resource by interact with the queue file. By mmap the queue
file space to user space, the process can directly put requests to the
hardware without syscall to the kernel space.

Uacce also manages unify addresses between the hardware and user space
of the process. So they can share the same virtual address in the
communication.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/Kconfig        |    1 +
 drivers/misc/Makefile       |    1 +
 drivers/misc/uacce/Kconfig  |   13 +
 drivers/misc/uacce/Makefile |    2 +
 drivers/misc/uacce/uacce.c  | 1186 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/uacce.h       |  109 ++++
 include/uapi/misc/uacce.h   |   44 ++
 7 files changed, 1356 insertions(+)
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6abfc8e..8073eb8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -502,4 +502,5 @@ source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
+source "drivers/misc/uacce/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae2..93a131b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,4 +58,5 @@ obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/uacce/Kconfig b/drivers/misc/uacce/Kconfig
new file mode 100644
index 0000000..569669c
--- /dev/null
+++ b/drivers/misc/uacce/Kconfig
@@ -0,0 +1,13 @@
+config UACCE
+	tristate "Accelerator Framework for User Land"
+	depends on IOMMU_API
+	help
+	  UACCE provides interface for the user process to access the hardware
+	  without interaction with the kernel space in data path.
+
+	  The user-space interface is described in
+	  include/uapi/misc/uacce.h
+
+	  See Documentation/misc-devices/warpdrive.rst for more details.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/misc/uacce/Makefile b/drivers/misc/uacce/Makefile
new file mode 100644
index 0000000..5b4374e
--- /dev/null
+++ b/drivers/misc/uacce/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-$(CONFIG_UACCE) += uacce.o
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
new file mode 100644
index 0000000..43e0c9b
--- /dev/null
+++ b/drivers/misc/uacce/uacce.c
@@ -0,0 +1,1186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/compat.h>
+#include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/file.h>
+#include <linux/idr.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
+#include <linux/uacce.h>
+
+static struct class *uacce_class;
+static DEFINE_IDR(uacce_idr);
+static dev_t uacce_devt;
+static DEFINE_MUTEX(uacce_mutex); /* mutex to protect uacce */
+
+/* lock to protect all queues management */
+static DECLARE_RWSEM(uacce_qs_lock);
+#define uacce_qs_rlock() down_read(&uacce_qs_lock)
+#define uacce_qs_runlock() up_read(&uacce_qs_lock)
+#define uacce_qs_wlock() down_write(&uacce_qs_lock)
+#define uacce_qs_wunlock() up_write(&uacce_qs_lock)
+
+static const struct file_operations uacce_fops;
+
+/* match with enum uacce_qfrt */
+static const char *const qfrt_str[] = {
+	"mmio",
+	"dko",
+	"dus",
+	"ss",
+	"invalid"
+};
+
+static const char *uacce_qfrt_str(struct uacce_qfile_region *qfr)
+{
+	enum uacce_qfrt type = qfr->type;
+
+	if (type > UACCE_QFRT_INVALID)
+		type = UACCE_QFRT_INVALID;
+
+	return qfrt_str[type];
+}
+
+/**
+ * uacce_wake_up - Wake up the process who is waiting this queue
+ * @q the accelerator queue to wake up
+ */
+void uacce_wake_up(struct uacce_queue *q)
+{
+	dev_dbg(&q->uacce->dev, "wake up\n");
+	wake_up_interruptible(&q->wait);
+}
+EXPORT_SYMBOL_GPL(uacce_wake_up);
+
+static int uacce_queue_map_qfr(struct uacce_queue *q,
+			       struct uacce_qfile_region *qfr)
+{
+	struct device *dev = q->uacce->pdev;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	int i, j, ret;
+
+	if (!(qfr->flags & UACCE_QFRF_MAP) || (qfr->flags & UACCE_QFRF_DMA))
+		return 0;
+
+	dev_dbg(dev, "queue map %s qfr(npage=%d, iova=%lx)\n",
+		uacce_qfrt_str(qfr), qfr->nr_pages, qfr->iova);
+
+	if (!domain)
+		return -ENODEV;
+
+	for (i = 0; i < qfr->nr_pages; i++) {
+		ret = iommu_map(domain, qfr->iova + i * PAGE_SIZE,
+				page_to_phys(qfr->pages[i]),
+				PAGE_SIZE, qfr->prot | q->uacce->prot);
+		if (ret) {
+			dev_err(dev, "iommu_map page %i fail %d\n", i, ret);
+			goto err_with_map_pages;
+		}
+		get_page(qfr->pages[i]);
+	}
+
+	return 0;
+
+err_with_map_pages:
+	for (j = i - 1; j >= 0; j--) {
+		iommu_unmap(domain, qfr->iova + j * PAGE_SIZE, PAGE_SIZE);
+		put_page(qfr->pages[j]);
+	}
+	return ret;
+}
+
+static void uacce_queue_unmap_qfr(struct uacce_queue *q,
+				  struct uacce_qfile_region *qfr)
+{
+	struct device *dev = q->uacce->pdev;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	int i;
+
+	if (!(qfr->flags & UACCE_QFRF_MAP) || (qfr->flags & UACCE_QFRF_DMA))
+		return;
+
+	dev_dbg(dev, "queue map %s qfr(npage=%d, iova=%lx)\n",
+		uacce_qfrt_str(qfr), qfr->nr_pages, qfr->iova);
+
+	if (!domain || !qfr)
+		return;
+
+	for (i = qfr->nr_pages - 1; i >= 0; i--) {
+		iommu_unmap(domain, qfr->iova + i * PAGE_SIZE, PAGE_SIZE);
+		put_page(qfr->pages[i]);
+	}
+}
+
+static int uacce_qfr_alloc_pages(struct uacce_qfile_region *qfr)
+{
+	int gfp_mask = GFP_ATOMIC | __GFP_ZERO;
+	int i, j;
+
+	qfr->pages = kcalloc(qfr->nr_pages, sizeof(*qfr->pages), gfp_mask);
+	if (!qfr->pages)
+		return -ENOMEM;
+
+	for (i = 0; i < qfr->nr_pages; i++) {
+		qfr->pages[i] = alloc_page(gfp_mask);
+		if (!qfr->pages[i])
+			goto err_with_pages;
+	}
+
+	return 0;
+
+err_with_pages:
+	for (j = i - 1; j >= 0; j--)
+		put_page(qfr->pages[j]);
+
+	kfree(qfr->pages);
+	return -ENOMEM;
+}
+
+static void uacce_qfr_free_pages(struct uacce_qfile_region *qfr)
+{
+	int i;
+
+	for (i = 0; i < qfr->nr_pages; i++)
+		put_page(qfr->pages[i]);
+
+	kfree(qfr->pages);
+}
+
+static inline int uacce_queue_mmap_qfr(struct uacce_queue *q,
+				       struct uacce_qfile_region *qfr,
+				       struct vm_area_struct *vma)
+{
+	int i, ret;
+
+	if (qfr->nr_pages)
+		dev_dbg(q->uacce->pdev, "mmap qfr (page ref=%d)\n",
+			page_ref_count(qfr->pages[0]));
+	for (i = 0; i < qfr->nr_pages; i++) {
+		ret = remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT),
+				      page_to_pfn(qfr->pages[i]), PAGE_SIZE,
+				      vma->vm_page_prot);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct uacce_qfile_region *
+uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
+		    enum uacce_qfrt type, unsigned int flags)
+{
+	struct uacce_qfile_region *qfr;
+	struct uacce *uacce = q->uacce;
+	unsigned long vm_pgoff;
+	int ret = -ENOMEM;
+
+	dev_dbg(uacce->pdev, "create qfr (type=%x, flags=%x)\n", type, flags);
+	qfr = kzalloc(sizeof(*qfr), GFP_ATOMIC);
+	if (!qfr)
+		return ERR_PTR(-ENOMEM);
+
+	qfr->type = type;
+	qfr->flags = flags;
+	qfr->iova = vma->vm_start;
+	qfr->nr_pages = vma_pages(vma);
+
+	if (vma->vm_flags & VM_READ)
+		qfr->prot |= IOMMU_READ;
+
+	if (vma->vm_flags & VM_WRITE)
+		qfr->prot |= IOMMU_WRITE;
+
+	if (flags & UACCE_QFRF_SELFMT) {
+		ret = uacce->ops->mmap(q, vma, qfr);
+		if (ret)
+			goto err_with_qfr;
+		return qfr;
+	}
+
+	/* allocate memory */
+	if (flags & UACCE_QFRF_DMA) {
+		dev_dbg(uacce->pdev, "allocate dma %d pages\n", qfr->nr_pages);
+		qfr->kaddr = dma_alloc_coherent(uacce->pdev, qfr->nr_pages <<
+						PAGE_SHIFT, &qfr->dma,
+						GFP_KERNEL);
+		if (!qfr->kaddr) {
+			ret = -ENOMEM;
+			goto err_with_qfr;
+		}
+	} else {
+		dev_dbg(uacce->pdev, "allocate %d pages\n", qfr->nr_pages);
+		ret = uacce_qfr_alloc_pages(qfr);
+		if (ret)
+			goto err_with_qfr;
+	}
+
+	/* map to device */
+	ret = uacce_queue_map_qfr(q, qfr);
+	if (ret)
+		goto err_with_pages;
+
+	/* mmap to user space */
+	if (flags & UACCE_QFRF_MMAP) {
+		if (flags & UACCE_QFRF_DMA) {
+
+			/* dma_mmap_coherent() requires vm_pgoff as 0
+			 * restore vm_pfoff to initial value for mmap()
+			 */
+			dev_dbg(uacce->pdev, "mmap dma qfr\n");
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			ret = dma_mmap_coherent(uacce->pdev, vma, qfr->kaddr,
+						qfr->dma,
+						qfr->nr_pages << PAGE_SHIFT);
+			vma->vm_pgoff = vm_pgoff;
+		} else {
+			ret = uacce_queue_mmap_qfr(q, qfr, vma);
+		}
+
+		if (ret)
+			goto err_with_mapped_qfr;
+	}
+
+	return qfr;
+
+err_with_mapped_qfr:
+	uacce_queue_unmap_qfr(q, qfr);
+err_with_pages:
+	if (flags & UACCE_QFRF_DMA)
+		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
+				  qfr->kaddr, qfr->dma);
+	else
+		uacce_qfr_free_pages(qfr);
+err_with_qfr:
+	kfree(qfr);
+
+	return ERR_PTR(ret);
+}
+
+/* we assume you have uacce_queue_unmap_qfr(q, qfr) from all related queues */
+static void uacce_destroy_region(struct uacce_queue *q,
+				 struct uacce_qfile_region *qfr)
+{
+	struct uacce *uacce = q->uacce;
+
+	if (qfr->flags & UACCE_QFRF_DMA) {
+		dev_dbg(uacce->pdev, "free dma qfr %s (kaddr=%lx, dma=%llx)\n",
+			uacce_qfrt_str(qfr), (unsigned long)qfr->kaddr,
+			qfr->dma);
+		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
+				  qfr->kaddr, qfr->dma);
+	} else if (qfr->pages) {
+		if (qfr->flags & UACCE_QFRF_KMAP && qfr->kaddr) {
+			dev_dbg(uacce->pdev, "vunmap qfr %s\n",
+				uacce_qfrt_str(qfr));
+			vunmap(qfr->kaddr);
+			qfr->kaddr = NULL;
+		}
+
+		uacce_qfr_free_pages(qfr);
+	}
+	kfree(qfr);
+}
+
+static long uacce_cmd_share_qfr(struct uacce_queue *tgt, int fd)
+{
+	struct file *filep = fget(fd);
+	struct uacce_queue *src;
+	int ret = -EINVAL;
+
+	if (!filep)
+		return ret;
+
+	if (filep->f_op != &uacce_fops)
+		goto out_with_fd;
+
+	src = filep->private_data;
+	if (!src)
+		goto out_with_fd;
+
+	/* no share sva is needed if the dev can do fault-from-dev */
+	if (tgt->uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
+		goto out_with_fd;
+
+	dev_dbg(&src->uacce->dev, "share ss with %s\n",
+		dev_name(&tgt->uacce->dev));
+
+	uacce_qs_wlock();
+	if (!src->qfrs[UACCE_QFRT_SS] || tgt->qfrs[UACCE_QFRT_SS])
+		goto out_with_lock;
+
+	ret = uacce_queue_map_qfr(tgt, src->qfrs[UACCE_QFRT_SS]);
+	if (ret)
+		goto out_with_lock;
+
+	tgt->qfrs[UACCE_QFRT_SS] = src->qfrs[UACCE_QFRT_SS];
+	list_add(&tgt->list, &src->qfrs[UACCE_QFRT_SS]->qs);
+	ret = 0;
+
+out_with_lock:
+	uacce_qs_wunlock();
+out_with_fd:
+	fput(filep);
+	return ret;
+}
+
+static int uacce_start_queue(struct uacce_queue *q)
+{
+	int ret, i, j;
+	struct uacce_qfile_region *qfr;
+	struct device *dev = &q->uacce->dev;
+
+	/*
+	 * map KMAP qfr to kernel
+	 * vmap should be done in non-spinlocked context!
+	 */
+	for (i = 0; i < UACCE_QFRT_MAX; i++) {
+		qfr = q->qfrs[i];
+		if (qfr && (qfr->flags & UACCE_QFRF_KMAP) && !qfr->kaddr) {
+			qfr->kaddr = vmap(qfr->pages, qfr->nr_pages, VM_MAP,
+					  PAGE_KERNEL);
+			if (!qfr->kaddr) {
+				ret = -ENOMEM;
+				dev_dbg(dev, "fail to kmap %s qfr(%d pages)\n",
+					uacce_qfrt_str(qfr), qfr->nr_pages);
+				goto err_with_vmap;
+			}
+
+			dev_dbg(dev, "kernel vmap %s qfr(%d pages) to %lx\n",
+				uacce_qfrt_str(qfr), qfr->nr_pages,
+				(unsigned long)qfr->kaddr);
+		}
+	}
+
+	ret = q->uacce->ops->start_queue(q);
+	if (ret < 0)
+		goto err_with_vmap;
+
+	dev_dbg(&q->uacce->dev, "uacce state switch to STARTED\n");
+	atomic_set(&q->uacce->state, UACCE_ST_STARTED);
+	return 0;
+
+err_with_vmap:
+	for (j = i; j >= 0; j--) {
+		qfr = q->qfrs[j];
+		if (qfr && qfr->kaddr) {
+			vunmap(qfr->kaddr);
+			qfr->kaddr = NULL;
+		}
+	}
+	return ret;
+}
+
+static long uacce_get_ss_dma(struct uacce_queue *q, void __user *arg)
+{
+	struct uacce *uacce = q->uacce;
+	long ret = 0;
+	unsigned long dma = 0;
+
+	if (!(uacce->flags & UACCE_DEV_NOIOMMU))
+		return -EINVAL;
+
+	uacce_qs_wlock();
+	if (q->qfrs[UACCE_QFRT_SS]) {
+		dma = (unsigned long)(q->qfrs[UACCE_QFRT_SS]->dma);
+		dev_dbg(&uacce->dev, "%s (%lx)\n", __func__, dma);
+	} else {
+		ret = -EINVAL;
+	}
+	uacce_qs_wunlock();
+
+	if (copy_to_user(arg, &dma, sizeof(dma)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static long uacce_fops_unl_ioctl(struct file *filep,
+				 unsigned int cmd, unsigned long arg)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce *uacce = q->uacce;
+
+	switch (cmd) {
+	case UACCE_CMD_SHARE_SVAS:
+		return uacce_cmd_share_qfr(q, arg);
+
+	case UACCE_CMD_START:
+		return uacce_start_queue(q);
+
+	case UACCE_CMD_GET_SS_DMA:
+		return uacce_get_ss_dma(q, (void __user *)arg);
+
+	default:
+		if (uacce->ops->ioctl)
+			return uacce->ops->ioctl(q, cmd, arg);
+
+		dev_err(&uacce->dev, "ioctl cmd (%d) is not supported!\n", cmd);
+		return -EINVAL;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static long uacce_fops_compat_ioctl(struct file *filep,
+				   unsigned int cmd, unsigned long arg)
+{
+	arg = (unsigned long)compat_ptr(arg);
+	return uacce_fops_unl_ioctl(filep, cmd, arg);
+}
+#endif
+
+static int uacce_dev_open_check(struct uacce *uacce)
+{
+	if (uacce->flags & UACCE_DEV_NOIOMMU)
+		return 0;
+
+	/*
+	 * The device can be opened once if it dose not support multiple page
+	 * table. The better way to check this is counting it per iommu_domain,
+	 * this is just a temporary solution
+	 */
+	if (uacce->flags & (UACCE_DEV_PASID | UACCE_DEV_NOIOMMU))
+		return 0;
+
+	if (atomic_cmpxchg(&uacce->state, UACCE_ST_INIT, UACCE_ST_OPENED) !=
+	    UACCE_ST_INIT) {
+		dev_info(&uacce->dev, "this device can be openned only once\n");
+		return -EBUSY;
+	}
+
+	dev_dbg(&uacce->dev, "state switch to OPENNED");
+
+	return 0;
+}
+
+static int uacce_fops_open(struct inode *inode, struct file *filep)
+{
+	struct uacce_queue *q;
+	struct iommu_sva *handle = NULL;
+	struct uacce *uacce;
+	int ret;
+	int pasid = 0;
+
+	uacce = idr_find(&uacce_idr, iminor(inode));
+	if (!uacce)
+		return -ENODEV;
+
+	if (atomic_read(&uacce->state) == UACCE_ST_RST)
+		return -EINVAL;
+
+	if (!uacce->ops->get_queue)
+		return -EINVAL;
+
+	if (!try_module_get(uacce->pdev->driver->owner))
+		return -ENODEV;
+
+	ret = uacce_dev_open_check(uacce);
+	if (ret)
+		goto open_err;
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID) {
+		handle = iommu_sva_bind_device(uacce->pdev, current->mm, NULL);
+		if (IS_ERR(handle))
+			goto open_err;
+		pasid = iommu_sva_get_pasid(handle);
+	}
+#endif
+	ret = uacce->ops->get_queue(uacce, pasid, &q);
+	if (ret < 0)
+		goto open_err;
+
+	q->pasid = pasid;
+	q->handle = handle;
+	q->uacce = uacce;
+	q->mm = current->mm;
+	memset(q->qfrs, 0, sizeof(q->qfrs));
+	INIT_LIST_HEAD(&q->list);
+	init_waitqueue_head(&q->wait);
+	filep->private_data = q;
+	mutex_lock(&uacce->q_lock);
+	list_add(&q->q_dev, &uacce->qs);
+	mutex_unlock(&uacce->q_lock);
+
+	return 0;
+open_err:
+	module_put(uacce->pdev->driver->owner);
+	return ret;
+}
+
+static int uacce_fops_release(struct inode *inode, struct file *filep)
+{
+	struct uacce_queue *q = (struct uacce_queue *)filep->private_data;
+	struct uacce_qfile_region *qfr;
+	struct uacce *uacce = q->uacce;
+	int i;
+	bool is_to_free_region;
+	int free_pages = 0;
+
+	mutex_lock(&uacce->q_lock);
+	list_del(&q->q_dev);
+	mutex_unlock(&uacce->q_lock);
+
+	if (atomic_read(&uacce->state) == UACCE_ST_STARTED &&
+	    uacce->ops->stop_queue)
+		uacce->ops->stop_queue(q);
+
+	uacce_qs_wlock();
+
+	for (i = 0; i < UACCE_QFRT_MAX; i++) {
+		qfr = q->qfrs[i];
+		if (!qfr)
+			continue;
+
+		is_to_free_region = false;
+		uacce_queue_unmap_qfr(q, qfr);
+		if (i == UACCE_QFRT_SS) {
+			list_del(&q->list);
+			if (list_empty(&qfr->qs))
+				is_to_free_region = true;
+		} else
+			is_to_free_region = true;
+
+		if (is_to_free_region) {
+			free_pages += qfr->nr_pages;
+			uacce_destroy_region(q, qfr);
+		}
+
+		qfr = NULL;
+	}
+
+	uacce_qs_wunlock();
+
+	if (current->mm == q->mm) {
+		down_write(&q->mm->mmap_sem);
+		q->mm->data_vm -= free_pages;
+		up_write(&q->mm->mmap_sem);
+	}
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID)
+		iommu_sva_unbind_device(q->handle);
+#endif
+
+	if (uacce->ops->put_queue)
+		uacce->ops->put_queue(q);
+
+	dev_dbg(&uacce->dev, "uacce state switch to INIT\n");
+	atomic_set(&uacce->state, UACCE_ST_INIT);
+	module_put(uacce->pdev->driver->owner);
+	return 0;
+}
+
+static enum uacce_qfrt uacce_get_region_type(struct uacce *uacce,
+					     struct vm_area_struct *vma)
+{
+	enum uacce_qfrt type = UACCE_QFRT_MAX;
+	int i;
+	size_t next_start = UACCE_QFR_NA;
+
+	for (i = UACCE_QFRT_MAX - 1; i >= 0; i--) {
+		if (vma->vm_pgoff >= uacce->qf_pg_start[i]) {
+			type = i;
+			break;
+		}
+	}
+
+	switch (type) {
+	case UACCE_QFRT_MMIO:
+		if (!uacce->ops->mmap) {
+			dev_err(&uacce->dev, "no driver mmap!\n");
+			return UACCE_QFRT_INVALID;
+		}
+		break;
+
+	case UACCE_QFRT_DKO:
+		if ((uacce->flags & UACCE_DEV_PASID) ||
+		    (uacce->flags & UACCE_DEV_NOIOMMU))
+			return UACCE_QFRT_INVALID;
+		break;
+
+	case UACCE_QFRT_DUS:
+		break;
+
+	case UACCE_QFRT_SS:
+		/* todo: this can be valid to protect the process space */
+		if (uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
+			return UACCE_QFRT_INVALID;
+		break;
+
+	default:
+		dev_err(&uacce->dev, "uacce bug (%d)!\n", type);
+		return UACCE_QFRT_INVALID;
+	}
+
+	/* make sure the mapping size is exactly the same as the region */
+	if (type < UACCE_QFRT_SS) {
+		for (i = type + 1; i < UACCE_QFRT_MAX; i++)
+			if (uacce->qf_pg_start[i] != UACCE_QFR_NA) {
+				next_start = uacce->qf_pg_start[i];
+				break;
+			}
+
+		if (next_start == UACCE_QFR_NA) {
+			dev_err(&uacce->dev, "uacce config error: SS offset set improperly\n");
+			return UACCE_QFRT_INVALID;
+		}
+
+		if (vma_pages(vma) !=
+		    next_start - uacce->qf_pg_start[type]) {
+			dev_err(&uacce->dev, "invalid mmap size (%ld vs %ld pages) for region %s.\n",
+				vma_pages(vma),
+				next_start - uacce->qf_pg_start[type],
+				qfrt_str[type]);
+			return UACCE_QFRT_INVALID;
+		}
+	}
+
+	return type;
+}
+
+static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct uacce_queue *q = (struct uacce_queue *)filep->private_data;
+	struct uacce *uacce = q->uacce;
+	enum uacce_qfrt type = uacce_get_region_type(uacce, vma);
+	struct uacce_qfile_region *qfr;
+	unsigned int flags = 0;
+	int ret;
+
+	dev_dbg(&uacce->dev, "mmap q file(t=%s, off=%lx, start=%lx, end=%lx)\n",
+		 qfrt_str[type], vma->vm_pgoff, vma->vm_start, vma->vm_end);
+
+	if (type == UACCE_QFRT_INVALID)
+		return -EINVAL;
+
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
+
+	uacce_qs_wlock();
+
+	/* fixme: if the region need no pages, we don't need to check it */
+	if (q->mm->data_vm + vma_pages(vma) >
+	    rlimit(RLIMIT_DATA) >> PAGE_SHIFT) {
+		ret = -ENOMEM;
+		goto out_with_lock;
+	}
+
+	if (q->qfrs[type]) {
+		ret = -EBUSY;
+		goto out_with_lock;
+	}
+
+	switch (type) {
+	case UACCE_QFRT_MMIO:
+		flags = UACCE_QFRF_SELFMT;
+		break;
+
+	case UACCE_QFRT_SS:
+		if (atomic_read(&uacce->state) != UACCE_ST_STARTED) {
+			ret = -EINVAL;
+			goto out_with_lock;
+		}
+
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
+
+		if (uacce->flags & UACCE_DEV_NOIOMMU)
+			flags |= UACCE_QFRF_DMA;
+		break;
+
+	case UACCE_QFRT_DKO:
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_KMAP;
+
+		if (uacce->flags & UACCE_DEV_NOIOMMU)
+			flags |= UACCE_QFRF_DMA;
+		break;
+
+	case UACCE_QFRT_DUS:
+		if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
+		    (uacce->flags & UACCE_DEV_PASID)) {
+			flags = UACCE_QFRF_SELFMT;
+			break;
+		}
+
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
+		break;
+
+	default:
+		WARN_ON(&uacce->dev);
+		break;
+	}
+
+	qfr = uacce_create_region(q, vma, type, flags);
+	if (IS_ERR(qfr)) {
+		ret = PTR_ERR(qfr);
+		goto out_with_lock;
+	}
+	q->qfrs[type] = qfr;
+
+	if (type == UACCE_QFRT_SS) {
+		INIT_LIST_HEAD(&qfr->qs);
+		list_add(&q->list, &q->qfrs[type]->qs);
+	}
+
+	uacce_qs_wunlock();
+
+	if (qfr->pages)
+		q->mm->data_vm += qfr->nr_pages;
+
+	return 0;
+
+out_with_lock:
+	uacce_qs_wunlock();
+	return ret;
+}
+
+static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
+{
+	struct uacce_queue *q = (struct uacce_queue *)file->private_data;
+	struct uacce *uacce = q->uacce;
+
+	poll_wait(file, &q->wait, wait);
+	if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
+		return EPOLLIN | EPOLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations uacce_fops = {
+	.owner		= THIS_MODULE,
+	.open		= uacce_fops_open,
+	.release	= uacce_fops_release,
+	.unlocked_ioctl	= uacce_fops_unl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= uacce_fops_compat_ioctl,
+#endif
+	.mmap		= uacce_fops_mmap,
+	.poll		= uacce_fops_poll,
+};
+
+#define UACCE_FROM_CDEV_ATTR(dev) container_of(dev, struct uacce, dev)
+
+static ssize_t id_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+	return sprintf(buf, "%d\n", uacce->dev_id);
+}
+
+static ssize_t api_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+	return sprintf(buf, "%s\n", uacce->api_ver);
+}
+
+static ssize_t numa_distance_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+	int distance = 0;
+
+#ifdef CONFIG_NUMA
+	distance = cpu_to_node(smp_processor_id()) - uacce->pdev->numa_node;
+#endif
+	return sprintf(buf, "%d\n", abs(distance));
+}
+
+static ssize_t node_id_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+	int node_id = -1;
+
+#ifdef CONFIG_NUMA
+	node_id = uacce->pdev->numa_node;
+#endif
+	return sprintf(buf, "%d\n", node_id);
+}
+
+static ssize_t flags_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+	return sprintf(buf, "%d\n", uacce->flags);
+}
+
+static ssize_t available_instances_show(struct device *dev,
+					  struct device_attribute *attr,
+						  char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+	return sprintf(buf, "%d\n", uacce->ops->get_available_instances(uacce));
+}
+
+static ssize_t algorithms_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+	return sprintf(buf, "%s", uacce->algs);
+}
+
+static ssize_t qfrs_offset_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+	int i, ret;
+	unsigned long offset;
+
+	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
+		offset = uacce->qf_pg_start[i];
+		if (offset != UACCE_QFR_NA)
+			offset = offset << PAGE_SHIFT;
+		if (i == UACCE_QFRT_SS)
+			break;
+		ret += sprintf(buf + ret, "%lu\t", offset);
+	}
+	ret += sprintf(buf + ret, "%lu\n", offset);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(api);
+static DEVICE_ATTR_RO(numa_distance);
+static DEVICE_ATTR_RO(node_id);
+static DEVICE_ATTR_RO(flags);
+static DEVICE_ATTR_RO(available_instances);
+static DEVICE_ATTR_RO(algorithms);
+static DEVICE_ATTR_RO(qfrs_offset);
+
+static struct attribute *uacce_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_api.attr,
+	&dev_attr_node_id.attr,
+	&dev_attr_numa_distance.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_available_instances.attr,
+	&dev_attr_algorithms.attr,
+	&dev_attr_qfrs_offset.attr,
+	NULL,
+};
+
+static const struct attribute_group uacce_dev_attr_group = {
+	.name	= UACCE_DEV_ATTRS,
+	.attrs	= uacce_dev_attrs,
+};
+
+static const struct attribute_group *uacce_dev_attr_groups[] = {
+	&uacce_dev_attr_group,
+	NULL
+};
+
+static int uacce_create_chrdev(struct uacce *uacce)
+{
+	int ret;
+
+	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	cdev_init(&uacce->cdev, &uacce_fops);
+	uacce->dev_id = ret;
+	uacce->cdev.owner = THIS_MODULE;
+	device_initialize(&uacce->dev);
+	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
+	uacce->dev.class = uacce_class;
+	uacce->dev.groups = uacce_dev_attr_groups;
+	uacce->dev.parent = uacce->pdev;
+	dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
+	ret = cdev_device_add(&uacce->cdev, &uacce->dev);
+	if (ret)
+		goto err_with_idr;
+
+	dev_dbg(&uacce->dev, "create uacce minior=%d\n", uacce->dev_id);
+	return 0;
+
+err_with_idr:
+	idr_remove(&uacce_idr, uacce->dev_id);
+	return ret;
+}
+
+static void uacce_destroy_chrdev(struct uacce *uacce)
+{
+	cdev_device_del(&uacce->cdev, &uacce->dev);
+	idr_remove(&uacce_idr, uacce->dev_id);
+}
+
+static int uacce_default_get_available_instances(struct uacce *uacce)
+{
+	return -1;
+}
+
+static int uacce_default_start_queue(struct uacce_queue *q)
+{
+	dev_dbg(&q->uacce->dev, "fake start queue");
+	return 0;
+}
+
+static int uacce_dev_match(struct device *dev, void *data)
+{
+	if (dev->parent == data)
+		return -EBUSY;
+
+	return 0;
+}
+
+/* Borrowed from VFIO to fix msi translation */
+static bool uacce_iommu_has_sw_msi(struct iommu_group *group,
+				   phys_addr_t *base)
+{
+	struct list_head group_resv_regions;
+	struct iommu_resv_region *region, *next;
+	bool ret = false;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+	list_for_each_entry(region, &group_resv_regions, list) {
+		pr_debug("uacce: find a resv region (%d) on %llx\n",
+			 region->type, region->start);
+
+		/*
+		 * The presence of any 'real' MSI regions should take
+		 * precedence over the software-managed one if the
+		 * IOMMU driver happens to advertise both types.
+		 */
+		if (region->type == IOMMU_RESV_MSI) {
+			ret = false;
+			break;
+		}
+
+		if (region->type == IOMMU_RESV_SW_MSI) {
+			*base = region->start;
+			ret = true;
+		}
+	}
+	list_for_each_entry_safe(region, next, &group_resv_regions, list)
+		kfree(region);
+	return ret;
+}
+
+static int uacce_set_iommu_domain(struct uacce *uacce)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+	struct device *dev = uacce->pdev;
+	bool resv_msi;
+	phys_addr_t resv_msi_base = 0;
+	int ret;
+
+	if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
+	    (uacce->flags & UACCE_DEV_PASID))
+		return 0;
+
+	/*
+	 * We don't support multiple register for the same dev in RFC version ,
+	 * will add it in formal version
+	 */
+	ret = class_for_each_device(uacce_class, NULL, uacce->pdev,
+				    uacce_dev_match);
+	if (ret)
+		return ret;
+
+	/* allocate and attach a unmanged domain */
+	domain = iommu_domain_alloc(uacce->pdev->bus);
+	if (!domain) {
+		dev_dbg(&uacce->dev, "cannot get domain for iommu\n");
+		return -ENODEV;
+	}
+
+	ret = iommu_attach_device(domain, uacce->pdev);
+	if (ret)
+		goto err_with_domain;
+
+	if (iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY)) {
+		uacce->prot |= IOMMU_CACHE;
+		dev_dbg(dev, "Enable uacce with c-coherent capa\n");
+	} else
+		dev_dbg(dev, "Enable uacce without c-coherent capa\n");
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		ret = -EINVAL;
+		goto err_with_domain;
+	}
+
+	resv_msi = uacce_iommu_has_sw_msi(group, &resv_msi_base);
+	iommu_group_put(group);
+
+	if (resv_msi) {
+		if (!irq_domain_check_msi_remap() &&
+		    !iommu_capable(dev->bus, IOMMU_CAP_INTR_REMAP)) {
+			dev_warn(dev, "No interrupt remapping support!");
+			ret = -EPERM;
+			goto err_with_domain;
+		}
+
+		dev_dbg(dev, "Set resv msi %llx on iommu domain\n",
+			(u64)resv_msi_base);
+		ret = iommu_get_msi_cookie(domain, resv_msi_base);
+		if (ret)
+			goto err_with_domain;
+	}
+
+	return 0;
+
+err_with_domain:
+	iommu_domain_free(domain);
+	return ret;
+}
+
+static void uacce_unset_iommu_domain(struct uacce *uacce)
+{
+	struct iommu_domain *domain;
+
+	if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
+	    (uacce->flags & UACCE_DEV_PASID))
+		return;
+
+	domain = iommu_get_domain_for_dev(uacce->pdev);
+	if (domain) {
+		iommu_detach_device(domain, uacce->pdev);
+		iommu_domain_free(domain);
+	} else
+		dev_err(&uacce->dev, "bug: no domain attached to device\n");
+}
+
+/**
+ *	uacce_register - register an accelerator
+ *	@uacce: the accelerator structure
+ */
+int uacce_register(struct uacce *uacce)
+{
+	int ret;
+
+	if (!uacce->pdev) {
+		pr_debug("uacce parent device not set\n");
+		return -ENODEV;
+	}
+
+	if (uacce->flags & UACCE_DEV_NOIOMMU) {
+		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+		dev_warn(uacce->pdev,
+			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
+	}
+
+	/* if dev support fault-from-dev, it should support pasid */
+	if ((uacce->flags & UACCE_DEV_FAULT_FROM_DEV) &&
+	    !(uacce->flags & UACCE_DEV_PASID)) {
+		dev_warn(&uacce->dev, "SVM/SAV device should support PASID\n");
+		return -EINVAL;
+	}
+
+	if (!uacce->ops->start_queue)
+		uacce->ops->start_queue = uacce_default_start_queue;
+
+	if (!uacce->ops->get_available_instances)
+		uacce->ops->get_available_instances =
+			uacce_default_get_available_instances;
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID) {
+		ret = iommu_dev_enable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
+		if (ret)
+			uacce->flags &= ~(UACCE_DEV_FAULT_FROM_DEV |
+					  UACCE_DEV_PASID);
+	}
+#endif
+
+	ret = uacce_set_iommu_domain(uacce);
+	if (ret)
+		return ret;
+
+	mutex_lock(&uacce_mutex);
+
+	ret = uacce_create_chrdev(uacce);
+	if (ret)
+		goto err_with_lock;
+
+	dev_dbg(&uacce->dev, "uacce state initialized to INIT");
+	atomic_set(&uacce->state, UACCE_ST_INIT);
+	INIT_LIST_HEAD(&uacce->qs);
+	mutex_init(&uacce->q_lock);
+	mutex_unlock(&uacce_mutex);
+
+
+	return 0;
+
+err_with_lock:
+	mutex_unlock(&uacce_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(uacce_register);
+
+/**
+ * uacce_unregister - unregisters a uacce
+ * @uacce: the accelerator to unregister
+ *
+ * Unregister an accelerator that wat previously successully registered with
+ * uacce_register().
+ */
+void uacce_unregister(struct uacce *uacce)
+{
+	mutex_lock(&uacce_mutex);
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID)
+		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
+#endif
+	uacce_unset_iommu_domain(uacce);
+
+	uacce_destroy_chrdev(uacce);
+
+	mutex_unlock(&uacce_mutex);
+}
+EXPORT_SYMBOL_GPL(uacce_unregister);
+
+static int __init uacce_init(void)
+{
+	int ret;
+
+	uacce_class = class_create(THIS_MODULE, UACCE_CLASS_NAME);
+	if (IS_ERR(uacce_class)) {
+		ret = PTR_ERR(uacce_class);
+		goto err;
+	}
+
+	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, "uacce");
+	if (ret)
+		goto err_with_class;
+
+	pr_info("uacce init with major number:%d\n", MAJOR(uacce_devt));
+
+	return 0;
+
+err_with_class:
+	class_destroy(uacce_class);
+err:
+	return ret;
+}
+
+static __exit void uacce_exit(void)
+{
+	unregister_chrdev_region(uacce_devt, MINORMASK);
+	class_destroy(uacce_class);
+	idr_destroy(&uacce_idr);
+}
+
+subsys_initcall(uacce_init);
+module_exit(uacce_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
+MODULE_DESCRIPTION("Accelerator interface for Userland applications");
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
new file mode 100644
index 0000000..fe2f6f4
--- /dev/null
+++ b/include/linux/uacce.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __UACCE_H
+#define __UACCE_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/iommu.h>
+#include <uapi/misc/uacce.h>
+
+struct uacce_queue;
+struct uacce;
+
+/* uacce mode of the driver */
+#define UACCE_MODE_NOUACCE	0 /* don't use uacce */
+#define UACCE_MODE_UACCE	1 /* use uacce exclusively */
+#define UACCE_MODE_NOIOMMU	2 /* use uacce noiommu mode */
+
+#define UACCE_QFRF_MAP		BIT(0)	/* map to current queue */
+#define UACCE_QFRF_MMAP		BIT(1)	/* map to user space */
+#define UACCE_QFRF_KMAP		BIT(2)	/* map to kernel space */
+#define UACCE_QFRF_DMA		BIT(3)	/* use dma api for the region */
+#define UACCE_QFRF_SELFMT	BIT(4)	/* self maintained qfr */
+
+struct uacce_qfile_region {
+	enum uacce_qfrt type;
+	unsigned long iova;	/* iova share between user and device space */
+	struct page **pages;
+	int nr_pages;
+	int prot;
+	unsigned int flags;
+	struct list_head qs;	/* qs sharing the same region, for ss */
+	void *kaddr;		/* kernel addr */
+	dma_addr_t dma;		/* dma address, if created by dma api */
+};
+
+/**
+ * struct uacce_ops - WD device operations
+ * @get_queue: get a queue from the device according to algorithm
+ * @put_queue: free a queue to the device
+ * @start_queue: make the queue start work after get_queue
+ * @stop_queue: make the queue stop work before put_queue
+ * @is_q_updated: check whether the task is finished
+ * @mask_notify: mask the task irq of queue
+ * @mmap: mmap addresses of queue to user space
+ * @reset: reset the WD device
+ * @reset_queue: reset the queue
+ * @ioctl:   ioctl for user space users of the queue
+ */
+struct uacce_ops {
+	int (*get_available_instances)(struct uacce *uacce);
+	int (*get_queue)(struct uacce *uacce, unsigned long arg,
+	     struct uacce_queue **q);
+	void (*put_queue)(struct uacce_queue *q);
+	int (*start_queue)(struct uacce_queue *q);
+	void (*stop_queue)(struct uacce_queue *q);
+	int (*is_q_updated)(struct uacce_queue *q);
+	void (*mask_notify)(struct uacce_queue *q, int event_mask);
+	int (*mmap)(struct uacce_queue *q, struct vm_area_struct *vma,
+		    struct uacce_qfile_region *qfr);
+	int (*reset)(struct uacce *uacce);
+	int (*reset_queue)(struct uacce_queue *q);
+	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
+		      unsigned long arg);
+};
+
+struct uacce_queue {
+	struct uacce *uacce;
+	void *priv;
+	wait_queue_head_t wait;
+	int pasid;
+	struct iommu_sva *handle;
+	struct list_head list; /* share list for qfr->qs */
+	struct mm_struct *mm;
+	struct uacce_qfile_region *qfrs[UACCE_QFRT_MAX];
+	struct list_head q_dev;
+};
+
+#define UACCE_ST_INIT		0
+#define UACCE_ST_OPENED		1
+#define UACCE_ST_STARTED	2
+#define UACCE_ST_RST		3
+
+struct uacce {
+	const char *name;
+	const char *drv_name;
+	const char *algs;
+	const char *api_ver;
+	unsigned int flags;
+	unsigned long qf_pg_start[UACCE_QFRT_MAX];
+	struct uacce_ops *ops;
+	struct device *pdev;
+	bool is_vf;
+	u32 dev_id;
+	struct cdev cdev;
+	struct device dev;
+	void *priv;
+	atomic_t state;
+	int prot;
+	struct mutex q_lock;
+	struct list_head qs;
+};
+
+int uacce_register(struct uacce *uacce);
+void uacce_unregister(struct uacce *uacce);
+void uacce_wake_up(struct uacce_queue *q);
+
+#endif
diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
new file mode 100644
index 0000000..44a0a5d
--- /dev/null
+++ b/include/uapi/misc/uacce.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _UAPIUUACCE_H
+#define _UAPIUUACCE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define UACCE_CLASS_NAME	"uacce"
+#define UACCE_DEV_ATTRS		"attrs"
+#define UACCE_CMD_SHARE_SVAS	_IO('W', 0)
+#define UACCE_CMD_START		_IO('W', 1)
+#define UACCE_CMD_GET_SS_DMA	_IOR('W', 2, unsigned long)
+
+/**
+ * UACCE Device Attributes:
+ *
+ * NOIOMMU: the device has no IOMMU support
+ *	can do share sva, but no map to the dev
+ * PASID: the device has IOMMU which support PASID setting
+ *	can do share sva, mapped to dev per process
+ * FAULT_FROM_DEV: the device has IOMMU which can do page fault request
+ *	no need for share sva, should be used with PASID
+ * SVA: full function device
+ * SHARE_DOMAIN: no PASID, can do share sva only for one process and the kernel
+ */
+#define UACCE_DEV_NOIOMMU		(1 << 0)
+#define UACCE_DEV_PASID			(1 << 1)
+#define UACCE_DEV_FAULT_FROM_DEV	(1 << 2)
+#define UACCE_DEV_SVA		(UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV)
+#define UACCE_DEV_SHARE_DOMAIN	(0)
+
+#define UACCE_API_VER_NOIOMMU_SUBFIX	"_noiommu"
+
+#define UACCE_QFR_NA ((unsigned long)-1)
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,	/* device mmio region */
+	UACCE_QFRT_DKO,		/* device kernel-only */
+	UACCE_QFRT_DUS,		/* device user share */
+	UACCE_QFRT_SS,		/* static share memory */
+	UACCE_QFRT_MAX,
+};
+#define UACCE_QFRT_INVALID UACCE_QFRT_MAX
+
+#endif
-- 
2.7.4

