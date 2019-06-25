Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE8E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfFYPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:06:16 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44504 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfFYPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:06:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 446863F4F6;
        Tue, 25 Jun 2019 17:06:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MJyxLx7KEe2Y; Tue, 25 Jun 2019 17:06:01 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D86033F44A;
        Tue, 25 Jun 2019 17:05:58 +0200 (CEST)
Date:   Tue, 25 Jun 2019 17:05:58 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: [PATCH 1/2] lib/genalloc.c: Add algorithm, align and zeroed family
 of DMA allocators
Message-ID: <20190625150558.GA2560@sx9>
References: <20190611172654.GA2602@sx9>
 <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
 <20190614142816.GA2574@sx9>
 <20190624063515.GA3296@lst.de>
 <20190624125916.GA2516@sx9>
 <20190625060000.GA28986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625060000.GA28986@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the algorithm option to DMA allocators as well, along with
convenience variants for zeroed and aligned memory. The following
four functions are added:

- gen_pool_dma_alloc_algo()
- gen_pool_dma_alloc_align()
- gen_pool_dma_zalloc_algo()
- gen_pool_dma_zalloc_align()

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
Hi Christoph,

This patch is based on my v5.0.21 branch, with Laurentiu Tudor's other
local memory changes.

Fredrik
---
 include/linux/genalloc.h |  10 +++-
 lib/genalloc.c           | 100 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,7 +121,15 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 		genpool_algo_t algo, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
-void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
+extern void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data);
+extern void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align);
+extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
+extern void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data);
+extern void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -347,13 +347,35 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
  * Return: virtual address of the allocated memory, or %NULL on failure
  */
 void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	return gen_pool_dma_alloc_algo(pool, size, dma, pool->algo, pool->data);
+}
+EXPORT_SYMBOL(gen_pool_dma_alloc);
+
+/**
+ * gen_pool_dma_alloc_algo - allocate special memory from the pool for DMA
+ * usage with the given pool algorithm
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: DMA-view physical address return value. Use %NULL if unneeded.
+ * @algo: algorithm passed from caller
+ * @data: data passed to algorithm
+ *
+ * Allocate the requested number of bytes from the specified pool. Uses the
+ * given pool allocation function. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated memory, or %NULL on failure
+ */
+void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data)
 {
 	unsigned long vaddr;
 
 	if (!pool)
 		return NULL;
 
-	vaddr = gen_pool_alloc(pool, size);
+	vaddr = gen_pool_alloc_algo(pool, size, algo, data);
 	if (!vaddr)
 		return NULL;
 
@@ -362,7 +384,31 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 
 	return (void *)vaddr;
 }
-EXPORT_SYMBOL(gen_pool_dma_alloc);
+EXPORT_SYMBOL(gen_pool_dma_alloc_algo);
+
+/**
+ * gen_pool_dma_alloc_align - allocate special memory from the pool for DMA
+ * usage with the given alignment
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: DMA-view physical address return value. Use %NULL if unneeded.
+ * @align: alignment in bytes for starting address
+ *
+ * Allocate the requested number bytes from the specified pool, with the given
+ * alignment restriction. Can not be used in NMI handler on architectures
+ * without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated memory, or %NULL on failure
+ */
+void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align)
+{
+	struct genpool_data_align data = { .align = align };
+
+	return gen_pool_dma_alloc_algo(pool, size, dma,
+			gen_pool_first_fit_align, &data);
+}
+EXPORT_SYMBOL(gen_pool_dma_alloc_align);
 
 /**
  * gen_pool_dma_zalloc - allocate special zeroed memory from the pool for
@@ -380,14 +426,60 @@ EXPORT_SYMBOL(gen_pool_dma_alloc);
  */
 void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 {
-	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
+	return gen_pool_dma_zalloc_algo(pool, size, dma, pool->algo, pool->data);
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc);
+
+/**
+ * gen_pool_dma_zalloc_algo - allocate special zeroed memory from the pool for
+ * DMA usage with the given pool algorithm
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: DMA-view physical address return value. Use %NULL if unneeded.
+ * @algo: algorithm passed from caller
+ * @data: data passed to algorithm
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool. Uses
+ * the given pool allocation function. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data)
+{
+	void *vaddr = gen_pool_dma_alloc_algo(pool, size, dma, algo, data);
 
 	if (vaddr)
 		memset(vaddr, 0, size);
 
 	return vaddr;
 }
-EXPORT_SYMBOL(gen_pool_dma_zalloc);
+EXPORT_SYMBOL(gen_pool_dma_zalloc_algo);
+
+/**
+ * gen_pool_dma_zalloc_align - allocate special zeroed memory from the pool for
+ * DMA usage with the given alignment
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: DMA-view physical address return value. Use %NULL if unneeded.
+ * @align: alignment in bytes for starting address
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool,
+ * with the given alignment restriction. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align)
+{
+	struct genpool_data_align data = { .align = align };
+
+	return gen_pool_dma_zalloc_algo(pool, size, dma,
+			gen_pool_first_fit_align, &data);
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc_align);
 
 /**
  * gen_pool_free - free allocated special memory back to the pool
-- 
2.21.0

