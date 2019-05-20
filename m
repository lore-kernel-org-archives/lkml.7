Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8751C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D820856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QgG+8N+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfETHbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbfETHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GPl2sHacLirnzduPMd6J/U3o9vxeyME3AJMYoHwdhAo=; b=QgG+8N+WDiBgInGyZzoJ6vOh8t
        /iuahOTKQovsbSgFacBY/R02Io7lbzcEIUildZwt/WJTGYCePyj+DaMEXcbPz5vYUYobUmZw13gky
        fn9jRmkrQV7IpxiYGvdr8QDR7MYFtSY7cq6BuSOGbMITB0L/Lw0rSxONqaDprkznSWkfsaKe2Ui6T
        UWLYre/CFWAWSneXDcu8D2JG26UI8UY9kDsH/zP/hjrLhhpObLncWqXaHCXo22KXhgD9XEX7nEToK
        QOynNjC1f9xWxouzQQodriegNEIjgkm5FPmkrhldwy9lrYpfOVyG9++V6NBg1rh8e1asMcp07PysN
        WYZ4YkNA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclr-000573-1H; Mon, 20 May 2019 07:31:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] arm64: trim includes in dma-mapping.c
Date:   Mon, 20 May 2019 09:29:48 +0200
Message-Id: <20190520072948.11412-25-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520072948.11412-1-hch@lst.de>
References: <20190520072948.11412-1-hch@lst.de>
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

