Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C998EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D321019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfE2K2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:28:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51812 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfE2K2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:28:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 252A92003EF;
        Wed, 29 May 2019 12:28:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17B5A2003E7;
        Wed, 29 May 2019 12:28:51 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 94F32205E4;
        Wed, 29 May 2019 12:28:50 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de
Subject: [PATCH v7 1/5] lib/genalloc.c: Add gen_pool_dma_zalloc() for zeroed DMA allocations
Date:   Wed, 29 May 2019 13:28:39 +0300
Message-Id: <20190529102843.13174-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fredrik Noring <noring@nocrew.org>

gen_pool_dma_zalloc() is a zeroed memory variant of gen_pool_dma_alloc().
Document return values of both, and indicate NULL as a "%NULL" constant.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Tested-by: Fredrik Noring <noring@nocrew.org>
---
 include/linux/genalloc.h |  1 +
 lib/genalloc.c           | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index dd0a452373e7..6c62eeca754f 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,6 +121,7 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 		genpool_algo_t algo, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
+void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 7e85d1e37a6e..5db43476a19b 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -337,12 +337,14 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
  * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
  * @pool: pool to allocate from
  * @size: number of bytes to allocate from the pool
- * @dma: dma-view physical address return value.  Use NULL if unneeded.
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
  *
  * Allocate the requested number of bytes from the specified pool.
  * Uses the pool allocation function (with first-fit algorithm by default).
  * Can not be used in NMI handler on architectures without
  * NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated memory, or %NULL on failure
  */
 void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 {
@@ -362,6 +364,31 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 }
 EXPORT_SYMBOL(gen_pool_dma_alloc);
 
+/**
+ * gen_pool_dma_zalloc - allocate special zeroed memory from the pool for
+ * DMA usage
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool.
+ * Uses the pool allocation function (with first-fit algorithm by default).
+ * Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
+
+	if (vaddr)
+		memset(vaddr, 0, size);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc);
+
 /**
  * gen_pool_free - free allocated special memory back to the pool
  * @pool: pool to free to
-- 
2.17.1

