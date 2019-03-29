Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1184C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D920811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfC2KkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:40:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729050AbfC2KkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5A82454DC83587D6ECD0;
        Fri, 29 Mar 2019 18:39:58 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 18:39:49 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <labbott@redhat.com>, <sumit.semwal@linaro.org>
CC:     <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: android: ion: refactory ion_alloc for kernel driver use
Date:   Sat, 30 Mar 2019 02:40:16 +0800
Message-ID: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two reasons for this patch:
1. There are some potential requirements for ion_alloc in kernel space,
some media drivers need to allocate media buffers from ion instead of
buddy or dma framework, this is more convient and clean very for media
drivers. And In that case, ion is the only media buffer provider, it's
more easier to maintain.
2. Fd is only needed by user processes, not the kernel space, so dma_buf
should be returned instead of fd for kernel space, and dma_buf_fd should
be called only for userspace api.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/staging/android/ion/ion.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 92c2914..e93fb49 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -387,13 +387,13 @@ static const struct dma_buf_ops dma_buf_ops = {
 	.unmap = ion_dma_buf_kunmap,
 };
 
-static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
+struct dma_buf *ion_alloc(size_t len, unsigned int heap_id_mask,
+			  unsigned int flags)
 {
 	struct ion_device *dev = internal_dev;
 	struct ion_buffer *buffer = NULL;
 	struct ion_heap *heap;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
-	int fd;
 	struct dma_buf *dmabuf;
 
 	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
@@ -407,7 +407,7 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	len = PAGE_ALIGN(len);
 
 	if (!len)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	down_read(&dev->lock);
 	plist_for_each_entry(heap, &dev->heaps, node) {
@@ -421,10 +421,10 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	up_read(&dev->lock);
 
 	if (!buffer)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	if (IS_ERR(buffer))
-		return PTR_ERR(buffer);
+		return ERR_PTR(PTR_ERR(buffer));
 
 	exp_info.ops = &dma_buf_ops;
 	exp_info.size = buffer->size;
@@ -432,17 +432,12 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	exp_info.priv = buffer;
 
 	dmabuf = dma_buf_export(&exp_info);
-	if (IS_ERR(dmabuf)) {
+	if (IS_ERR(dmabuf))
 		_ion_buffer_destroy(buffer);
-		return PTR_ERR(dmabuf);
-	}
 
-	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
-	if (fd < 0)
-		dma_buf_put(dmabuf);
-
-	return fd;
+	return dmabuf;
 }
+EXPORT_SYMBOL(ion_alloc);
 
 static int ion_query_heaps(struct ion_heap_query *query)
 {
@@ -539,12 +534,19 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case ION_IOC_ALLOC:
 	{
 		int fd;
+		struct dma_buf *dmabuf;
 
-		fd = ion_alloc(data.allocation.len,
+		dmabuf = ion_alloc(data.allocation.len,
 			       data.allocation.heap_id_mask,
 			       data.allocation.flags);
-		if (fd < 0)
+		if (IS_ERR(dmabuf))
+			return PTR_ERR(dmabuf);
+
+		fd = dma_buf_fd(dmabuf, O_CLOEXEC);
+		if (fd < 0) {
+			dma_buf_put(dmabuf);
 			return fd;
+		}
 
 		data.allocation.fd = fd;
 
-- 
2.7.4

