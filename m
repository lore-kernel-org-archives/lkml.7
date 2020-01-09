Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC36C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AD32072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNcg2RhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgAIO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730326AbgAIO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDGiLHLaS/+Io2Phnnfgd/F37FeteIfvFFEQMfXM9RA=;
        b=ZNcg2RhUM+bkWQhtWq71Vb+UtJYXGnHaRvCUQpWOXKZjCRbtXIGjUpDgp5JcF7iO+a/yEC
        A0kC3dp2o+kCM3Qw1aFuKuTrWqcFRHnBbaBXVxKl4ZlVKjfOiEzL5hqSvm3IK522QOLT4Q
        g+MWpFpKFwBttkMt5hFwLBZ7nYMcjbo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-4eRYJZdnO5Gx667P3eHuaQ-1; Thu, 09 Jan 2020 09:57:36 -0500
X-MC-Unique: 4eRYJZdnO5Gx667P3eHuaQ-1
Received: by mail-qt1-f197.google.com with SMTP id l5so4360295qte.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDGiLHLaS/+Io2Phnnfgd/F37FeteIfvFFEQMfXM9RA=;
        b=Pgc2aTJbfxy+DCV+W43oDUrRBrtRoCtqxiLQt+rZZ2LW9Ecb//OvlfLFzyIHosrbhu
         mgSLuwsujukTnRiO7MVTBhIrab7jxBH5TRkw0827R53+flJ+76O0C3a2M55KRIpj45HH
         +ukPjU5+n8q63MfANAwyfbUJ3Zpj9/16OYKPpqojCXYeThu4FXHZ4xdFucdLCaxPZhc2
         7GhiyzEvaW0+6jvr5JsgIhWbiny0HKSLd4JkuBfm3mx5dFxXy4Sllppr2cuy/vG93Gfb
         P07VVc/JQrpfo/8QjWFU1Ygpv+pbwIvUjYCeGDI8V6un7paufsoaWQb0J/AhWUEnMzZn
         3FVA==
X-Gm-Message-State: APjAAAVaghKcdQpjlGjN/ITtawu40PNGyHgnShx0NWW5EZwGMj7r5bgG
        QIzZ7uwHg3XcScgQKFlwNhtgTxC1w4IdyDFCe+eE37Fcz2pP5Xow4G0hFS6eoETcUW0kM2Gazdl
        MPN+4/mM5m9xz/uYGhprbpaXv
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr9510825qkk.159.1578581855560;
        Thu, 09 Jan 2020 06:57:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9fW22cpWNa0ej5q9Tvxem01vg3v97AmZT7K2M9MRr1qsTUoG9MFfgUMx1bfEecySbeqsNlQ==
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr9510799qkk.159.1578581855290;
        Thu, 09 Jan 2020 06:57:35 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 01/21] vfio: introduce vfio_iova_rw to read/write a range of IOVAs
Date:   Thu,  9 Jan 2020 09:57:09 -0500
Message-Id: <20200109145729.32898-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

vfio_iova_rw will read/write a range of userspace memory (starting form
device iova to iova + len -1) into a kenrel buffer without pinning the
userspace memory.

TODO: vfio needs to mark the iova dirty if vfio_iova_rw(write) is
called.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/vfio/vfio.c             | 45 ++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 81 +++++++++++++++++++++++++++++++++
 include/linux/vfio.h            |  5 ++
 3 files changed, 131 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index c8482624ca34..36e91e647ed5 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1961,6 +1961,51 @@ int vfio_unpin_pages(struct device *dev, unsigned long *user_pfn, int npage)
 }
 EXPORT_SYMBOL(vfio_unpin_pages);
 
+/*
+ * Read/Write a range of userspace IOVAs for a device into/from a kernel
+ * buffer without pinning the userspace memory
+ * @dev [in]  : device
+ * @iova [in] : base IOVA of a userspace buffer
+ * @data [in] : pointer to kernel buffer
+ * @len [in]  : kernel buffer length
+ * @write     : indicate read or write
+ * Return error on failure or 0 on success.
+ */
+int vfio_iova_rw(struct device *dev, unsigned long iova, void *data,
+		   unsigned long len, bool write)
+{
+	struct vfio_container *container;
+	struct vfio_group *group;
+	struct vfio_iommu_driver *driver;
+	int ret = 0;
+
+	if (!dev || !data || len <= 0)
+		return -EINVAL;
+
+	group = vfio_group_get_from_dev(dev);
+	if (!group)
+		return -ENODEV;
+
+	ret = vfio_group_add_container_user(group);
+	if (ret)
+		goto out;
+
+	container = group->container;
+	driver = container->iommu_driver;
+
+	if (likely(driver && driver->ops->iova_rw))
+		ret = driver->ops->iova_rw(container->iommu_data,
+					   iova, data, len, write);
+	else
+		ret = -ENOTTY;
+
+	vfio_group_try_dissolve_container(group);
+out:
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL(vfio_iova_rw);
+
 static int vfio_register_iommu_notifier(struct vfio_group *group,
 					unsigned long *events,
 					struct notifier_block *nb)
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ada8e6cdb88..aee191077235 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -27,6 +27,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/rbtree.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
@@ -2326,6 +2327,85 @@ static int vfio_iommu_type1_unregister_notifier(void *iommu_data,
 	return blocking_notifier_chain_unregister(&iommu->notifier, nb);
 }
 
+static int next_segment(unsigned long len, int offset)
+{
+	if (len > PAGE_SIZE - offset)
+		return PAGE_SIZE - offset;
+	else
+		return len;
+}
+
+static int vfio_iommu_type1_rw_iova_seg(struct vfio_iommu *iommu,
+					  unsigned long iova, void *data,
+					  unsigned long seg_len,
+					  unsigned long offset,
+					  bool write)
+{
+	struct mm_struct *mm;
+	unsigned long vaddr;
+	struct vfio_dma *dma;
+	bool kthread = current->mm == NULL;
+	int ret = 0;
+
+	dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
+	if (!dma)
+		return -EINVAL;
+
+	mm = get_task_mm(dma->task);
+
+	if (!mm)
+		return -ENODEV;
+
+	if (kthread)
+		use_mm(mm);
+	else if (current->mm != mm) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vaddr = dma->vaddr + iova - dma->iova + offset;
+
+	ret = write ? __copy_to_user((void __user *)vaddr,
+			data, seg_len) :
+		__copy_from_user(data, (void __user *)vaddr,
+				seg_len);
+	if (ret)
+		ret = -EFAULT;
+
+	if (kthread)
+		unuse_mm(mm);
+out:
+	mmput(mm);
+	return ret;
+}
+
+static int vfio_iommu_type1_iova_rw(void *iommu_data, unsigned long iova,
+				    void *data, unsigned long len, bool write)
+{
+	struct vfio_iommu *iommu = iommu_data;
+	int offset = iova & ~PAGE_MASK;
+	int seg_len;
+	int ret = 0;
+
+	iova = iova & PAGE_MASK;
+
+	mutex_lock(&iommu->lock);
+	while ((seg_len = next_segment(len, offset)) > 0) {
+		ret = vfio_iommu_type1_rw_iova_seg(iommu, iova, data,
+						   seg_len, offset, write);
+		if (ret)
+			break;
+
+		offset = 0;
+		len -= seg_len;
+		data += seg_len;
+		iova += PAGE_SIZE;
+	}
+
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -2338,6 +2418,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.unpin_pages		= vfio_iommu_type1_unpin_pages,
 	.register_notifier	= vfio_iommu_type1_register_notifier,
 	.unregister_notifier	= vfio_iommu_type1_unregister_notifier,
+	.iova_rw		= vfio_iommu_type1_iova_rw,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e42a711a2800..7bf18a31bbcf 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -82,6 +82,8 @@ struct vfio_iommu_driver_ops {
 					     struct notifier_block *nb);
 	int		(*unregister_notifier)(void *iommu_data,
 					       struct notifier_block *nb);
+	int		(*iova_rw)(void *iommu_data, unsigned long iova,
+				   void *data, unsigned long len, bool write);
 };
 
 extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
@@ -107,6 +109,9 @@ extern int vfio_pin_pages(struct device *dev, unsigned long *user_pfn,
 extern int vfio_unpin_pages(struct device *dev, unsigned long *user_pfn,
 			    int npage);
 
+extern int vfio_iova_rw(struct device *dev, unsigned long iova, void *data,
+			unsigned long len, bool write);
+
 /* each type has independent events */
 enum vfio_notify_type {
 	VFIO_IOMMU_NOTIFY = 0,
-- 
2.24.1

