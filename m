Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA8EC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InjZvruL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfEWHBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfEWHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GPl2sHacLirnzduPMd6J/U3o9vxeyME3AJMYoHwdhAo=; b=InjZvruLAZhhm+mMoSfDUq4rpR
        iprIlqNG6gmDn+Pbnr69K/vTb0lLv+YYpXLqFfx5dbomf59xQYfjm7WXWnr4wZpTRHhhadyaFSKvq
        2OhUZBr7B3QbYn4AAutXjHfwoTFdBFKX7MlouNQNBi3ffnrv+gnYy9wPKBd2ZXzxZwUuWpb3ySleL
        24t0Tye9jYMxlW761opcfhuQXRAFTjah7boyTdjSSLXRwmjXCqZ8lR25uQSNEicG8GIiBqGWngzEZ
        MndKp4QTj2a++43gEmVIkZWW+ZUN6coAH7w+4oIaro/Rl5nKNlA0mjYOnL//BxEGPHah1Ur0jkDND
        cCogz7Iw==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThjM-00065b-BR; Thu, 23 May 2019 07:01:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 23/23] arm64: trim includes in dma-mapping.c
Date:   Thu, 23 May 2019 09:00:28 +0200
Message-Id: <20190523070028.7435-24-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523070028.7435-1-hch@lst.de>
References: <20190523070028.7435-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With most of the previous functionality now elsewhere a lot of the
headers included in this file are not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 184ef9ccd69d..1669618db08a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -5,19 +5,9 @@
  */
 
 #include <linux/gfp.h>
-#include <linux/acpi.h>
-#include <linux/memblock.h>
 #include <linux/cache.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/genalloc.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
-#include <linux/vmalloc.h>
-#include <linux/swiotlb.h>
-#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 
-- 
2.20.1

