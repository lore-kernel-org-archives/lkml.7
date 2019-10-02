Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C73C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BF42070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/zOukb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfJBUq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:46:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36142 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:46:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so296410pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NXZoaM8JnR0+26PVfw4tVHTn5SdQ45I7gpO85lvpiP0=;
        b=d/zOukb8JkdaGMJDkXWNp2Q+WzlGXbZZGxLJkrMZ8FFJBwkDoe1BlOgLfvcWlg7OIV
         FswyVy2UdZ9QywcGA3Shg+vQFos67XMyw9AqTmCvhSNVv+Z7IwtD7IvbVEWeiDoS8aFM
         McCilSu2GEofjob8stzUmA8e/JlxTLTzVMtbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NXZoaM8JnR0+26PVfw4tVHTn5SdQ45I7gpO85lvpiP0=;
        b=A2tY5/wBLPvzWfuffH8Qs4NYK62zIJb6Tr1ukeLQQVU6uD9LxgRE0UIOpWDhiFS6oP
         5uVzpeghwxRHy64BR4SDyfxkj4juJ2qZFcIOXA/bDr9vVmsj+iUvkpbY4tY4RsaJgPbs
         23rmV+sSwDCC5ImfVbosJn9Yi2owV6wzxkIhaljZIqZmlZHqeh7WMdYF8qw43k/H7gW1
         Fov3hfX3X+lF15toK9+HuyZJOfErWnOTt/4evJ5AonyptGsNzT6neyhp44YezJ+te80L
         6xIY7MQzyyqiFI6GhPsfOzqOpElve/dyyuzEFftm1u7d9XfA//8CdzQZQCK0VIFuA6gy
         Kx9Q==
X-Gm-Message-State: APjAAAXOPyqpoeYqCvMwqmVjsbyON5mW6BV9wWHgxH9Alpq5ntJOqVJM
        m3QpksP5mDavoVUzNsrhJtYh/A==
X-Google-Smtp-Source: APXvYqz4cuEetDgLVL9xZEkahkfeg3mPz43ZiRkqQe1eIgZwxKs63wCyjcBd+aYAmiRIbW1RZftzuw==
X-Received: by 2002:a63:4142:: with SMTP id o63mr6002272pga.426.1570049217206;
        Wed, 02 Oct 2019 13:46:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm359178pfq.121.2019.10.02.13.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:46:56 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:46:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910021341.7819A660@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we've seen from USB and other areas, we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
consolidates the (existing!) checks and makes them on by default. A
warning will be triggered for any drivers still using DMA on the stack
(as has been seen in a few recent reports).

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/dma-debug.h   |  8 --------
 include/linux/dma-mapping.h |  8 +++++++-
 kernel/dma/debug.c          | 16 ----------------
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 4208f94d93f7..2af9765d9af7 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -18,9 +18,6 @@ struct bus_type;
 
 extern void dma_debug_add_bus(struct bus_type *bus);
 
-extern void debug_dma_map_single(struct device *dev, const void *addr,
-				 unsigned long len);
-
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr);
@@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
 {
 }
 
-static inline void debug_dma_map_single(struct device *dev, const void *addr,
-					unsigned long len)
-{
-}
-
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..2d6b8382eab1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	debug_dma_map_single(dev, ptr, size);
+	/* DMA must never operate on stack or other remappable places. */
+	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
+		"%s %s: driver maps %lu bytes from %s area\n",
+		dev ? dev_driver_string(dev) : "unknown driver",
+		dev ? dev_name(dev) : "unknown device", size,
+		is_vmalloc_addr(ptr) ? "vmalloc" : "invalid");
+
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
 }
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..aa1e6a1990b2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1232,22 +1232,6 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
-void debug_dma_map_single(struct device *dev, const void *addr,
-			    unsigned long len)
-{
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	if (!virt_addr_valid(addr))
-		err_printk(dev, NULL, "device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
-			   addr, len);
-
-	if (is_vmalloc_addr(addr))
-		err_printk(dev, NULL, "device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
-			   addr, len);
-}
-EXPORT_SYMBOL(debug_dma_map_single);
-
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr)
 {
-- 
2.17.1


-- 
Kees Cook
