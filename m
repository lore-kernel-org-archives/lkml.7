Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E01CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C07B21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYbg0nUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJYXsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:48:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43150 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJYXsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:48:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so2571801pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=akimG7mgtSazW0Xv9weq5WdYsXvPJgD82qEofxZDZEo=;
        b=kYbg0nUp/PxzkjVrb1KGOJVPc1ih+UCUGjDKAgLLtvpaZ9Pp+/Q3cv4t0dB71G44aS
         1wF3g90STc7JgIzQVNFd2OT47TMuSNGhWq6p3nERUIVHd5+QBDoi779pCYC6SDgp24GO
         WPFPM2iiqEYEZem9oWs2cJTf8hNVxEWG4h3ruJZzab15rfukexYiWFkNqjiorjlihRVj
         VcKekKIMo2nCLNOYMa8cqJA9lIn7e/RWWLtB65doGIXpH4JFEeeqg+ua2yA7dmZatZzj
         xh4go74AhdfigrguMdEtk2DgBS+XrR+zbHEJPdNUFIuJft1as404b2m+OKIUe0iRozLD
         UMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=akimG7mgtSazW0Xv9weq5WdYsXvPJgD82qEofxZDZEo=;
        b=sTBWRjN+2EljJQ0bqC/N5nYWtQLmx1Y0hYeY39Vrjml/LfxDsVD9BPsm1X5/tgRGed
         Z3T5He8j9e/+iyTIe3Hpf/fwm9BXAZR4xRqA3Hpu62FtrVNCemfyxficFIrd1NPmPFPQ
         DewO5YFRpnAWdTWmTplvIGJWUk3isdxxFRhTLmuOcWZMq82oRDMAOzAM0Rac6KiDu9lS
         zQ9G611CdhQheLqf+4ym2FHu1dFRjqZt6/iB9ZFSwgCjtRb8SI4BnXXRoT9mzxO++IAM
         1YZS+F72Urh/3xcLIdb8hV4P28Ub0Td7OzdX4Sy/X+hHFleQ4x0GqKwK8GBRRUKgxw4R
         BJeA==
X-Gm-Message-State: APjAAAWNCyJac1bH6YZlm8ukxc1hRX2omk0qzOzRxtuImVSfxUJRYkEC
        dmc7hLxAdNpBNqwSjNDSJ00wWD8o+Hs=
X-Google-Smtp-Source: APXvYqzFVpzIpCxoPgDb9KejO5rMTuJfOB/3/u6olhx9SqL/mVxNlO6qlClo1U0EarnNOG8lvUvjkg==
X-Received: by 2002:a17:90a:d58f:: with SMTP id v15mr7476798pju.17.1572047320896;
        Fri, 25 Oct 2019 16:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id cx22sm2817179pjb.19.2019.10.25.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 16:48:40 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 2/2] dma-buf: heaps: Allow system & cma heaps to be configured as a modules
Date:   Fri, 25 Oct 2019 23:48:34 +0000
Message-Id: <20191025234834.28214-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025234834.28214-1-john.stultz@linaro.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow loading system and cma heap as a module instead of just as
a statically built in heap.

Since there isn't a good mechanism for dmabuf lifetime tracking
it isn't safe to allow the heap drivers to be unloaded, so these
drivers do not implement any module unloading functionality and
will show up in lsmod as "[permanent]".

This patch also exports key functions from dmabuf heaps core and
the heap helper functions so they can be accessed by the module.

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yue Hu <huyue2@yulong.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/dma-heap.c           | 2 ++
 drivers/dma-buf/heaps/Kconfig        | 4 ++--
 drivers/dma-buf/heaps/heap-helpers.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 9a41b73e54b4..2c4ac71a715b 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -161,6 +161,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 {
 	return heap->priv;
 }
+EXPORT_SYMBOL_GPL(dma_heap_get_drvdata);
 
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
@@ -243,6 +244,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	kfree(heap);
 	return err_ret;
 }
+EXPORT_SYMBOL_GPL(dma_heap_add);
 
 static char *dma_heap_devnode(struct device *dev, umode_t *mode)
 {
diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index a5eef06c4226..e273fb18feca 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -1,12 +1,12 @@
 config DMABUF_HEAPS_SYSTEM
-	bool "DMA-BUF System Heap"
+	tristate "DMA-BUF System Heap"
 	depends on DMABUF_HEAPS
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
 config DMABUF_HEAPS_CMA
-	bool "DMA-BUF CMA Heap"
+	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
 	help
 	  Choose this option to enable dma-buf CMA heap. This heap is backed
diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 750bef4e902d..fb9835126893 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -24,6 +24,7 @@ void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
 	INIT_LIST_HEAD(&buffer->attachments);
 	buffer->free = free;
 }
+EXPORT_SYMBOL_GPL(init_heap_helper_buffer);
 
 struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
 					  int fd_flags)
@@ -37,6 +38,7 @@ struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
 
 	return dma_buf_export(&exp_info);
 }
+EXPORT_SYMBOL_GPL(heap_helper_export_dmabuf);
 
 static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
 {
-- 
2.17.1

