Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C27C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F252064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A715qd05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfHPNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:01:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfHPNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o81E6N21kZpYRvlw8IF+a9xn425bqQPWRFVr7mRzKo0=; b=A715qd05e/Gmx9uDJm2TaiW1RP
        1b5IR38JurFTo400njBTZgNznuEBdsKebuLXbFn0p7E1tDhoGfKFwJeMQgCiSZ1cjDx82nJHf4Qtu
        Lkjuh+pVf9gfB31ulpS34adxXouSFgpvdKso0bJpVqI2m84DW3djEg22pk9dk1/SiCDzrTuq+tv0u
        1Rpp3dN2oFs1liGxJyERP4WuM1Q4zZDXkY3lJWg3GYeq0XUjCQ/x3Ut4JclIJaoe2StzC36moRO+R
        9MfINkcPMI0pTRLfgTB3g81MVhh1qtcWkkeVphSZh6bQneZFJs/qJYjMjpBF3IZpzTFYK7Y+A5jSr
        yTwZcjkA==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybqg-0006it-CQ; Fri, 16 Aug 2019 13:00:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: use asm-generic/dma-mapping.h
Date:   Fri, 16 Aug 2019 15:00:13 +0200
Message-Id: <20190816130013.31154-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Xen special cases are gone nothing worth mentioning is
left in the arm64 <asm/dma-mapping.h> file, so switch to use the
asm-generic version instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/dma-mapping.h | 22 ----------------------
 arch/arm64/mm/dma-mapping.c          |  1 +
 3 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm64/include/asm/dma-mapping.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index c52e151afab0..98a5405c8558 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += delay.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
+generic-y += dma-mapping.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += hw_irq.h
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
deleted file mode 100644
index 67243255a858..000000000000
--- a/arch/arm64/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Ltd.
- */
-#ifndef __ASM_DMA_MAPPING_H
-#define __ASM_DMA_MAPPING_H
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/vmalloc.h>
-
-#include <xen/xen.h>
-#include <asm/xen/hypervisor.h>
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return NULL;
-}
-
-#endif	/* __KERNEL__ */
-#endif	/* __ASM_DMA_MAPPING_H */
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4b244a037349..6578abcfbbc7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -8,6 +8,7 @@
 #include <linux/cache.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-iommu.h>
+#include <xen/xen.h>
 #include <xen/swiotlb-xen.h>
 
 #include <asm/cacheflush.h>
-- 
2.20.1

