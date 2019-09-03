Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51C7215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="kRDnlGIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfICNP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:15:29 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39744 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfICNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:15:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5CD594041E;
        Tue,  3 Sep 2019 15:15:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=kRDnlGIx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HEPT9RSmogm2; Tue,  3 Sep 2019 15:15:19 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 3AAC94047D;
        Tue,  3 Sep 2019 15:15:18 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E453F360330;
        Tue,  3 Sep 2019 15:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567516518; bh=1DziKwTjiIMj17OZYZOeUEJ6CP5BMAzv4f1IdbkdopM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRDnlGIxm2xAiKU2h+6QgzVP4jgLGi7H7/e3P/PcpWk2QfzaUVu6YHSkh4zYUw4AB
         cUsOOvXQOE0f5q8skRRj2Z6FvIhsATajksRYEOj/SPQmulnssLTAa5DJniDGmjbcbG
         t0Z4hJkPl5N9cWf9aRIhktUPL0iSoqtRb76d20xc=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 4/4] drm/ttm: Cache dma pool decrypted pages when AMD SEV is active
Date:   Tue,  3 Sep 2019 15:15:04 +0200
Message-Id: <20190903131504.18935-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903131504.18935-1-thomas_os@shipmail.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The TTM dma pool allocates coherent pages for use with TTM. When forcing
unencrypted DMA, such allocations become very expensive since the linear
kernel map has to be changed to mark the pages decrypted. To avoid too many
such allocations and frees, cache the decrypted pages even if they
are in the normal cpu caching state, where otherwise the pool frees them
immediately when unused.

Tested with vmwgfx on SEV-ES.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index 9b15df8ecd49..a3247f24e106 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -1000,7 +1000,7 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
 	struct dma_pool *pool;
 	struct dma_page *d_page, *next;
 	enum pool_type type;
-	bool is_cached = false;
+	bool immediate_free = false;
 	unsigned count, i, npages = 0;
 	unsigned long irq_flags;
 
@@ -1035,8 +1035,17 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
 	if (!pool)
 		return;
 
-	is_cached = (ttm_dma_find_pool(pool->dev,
-		     ttm_to_type(ttm->page_flags, tt_cached)) == pool);
+	/*
+	 * If memory is cached and sev encryption is not active, allocating
+	 * and freeing coherent memory is relatively cheap, so we can free
+	 * it immediately. If sev encryption is active, allocating coherent
+	 * memory involves a call to set_memory_decrypted() which is very
+	 * expensive, so cache coherent pages is sev is active.
+	 */
+	immediate_free = (ttm_dma_find_pool
+			  (pool->dev,
+			   ttm_to_type(ttm->page_flags, tt_cached)) == pool &&
+			  !force_dma_unencrypted(dev));
 
 	/* make sure pages array match list and count number of pages */
 	count = 0;
@@ -1051,13 +1060,13 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
 			d_page->vaddr &= ~VADDR_FLAG_UPDATED_COUNT;
 		}
 
-		if (is_cached)
+		if (immediate_free)
 			ttm_dma_page_put(pool, d_page);
 	}
 
 	spin_lock_irqsave(&pool->lock, irq_flags);
 	pool->npages_in_use -= count;
-	if (is_cached) {
+	if (immediate_free) {
 		pool->nfrees += count;
 	} else {
 		pool->npages_free += count;
-- 
2.20.1

