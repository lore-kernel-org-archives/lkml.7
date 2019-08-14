Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B4C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38A62133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEF+bkJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHNH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:59:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfHNH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r4axfViZZyZ+fuvT3jC+Yx773mt75vv7oepOJvLdF2Q=; b=nEF+bkJ/uOpwV81bxUK8L50P0Z
        Q9Ui9x3uYU+lWOSSyKlo/kpfVGPZD4ATVWu/7NfypeSvK47HYQUE91aiDe65KDhsZtzj04hSIVCC0
        JN/Fn/v8ufPUzw9PUFrM5yXHhLzV5/HXXalBESjH2Fx76jVX/d2fjU7Gpu5EO97F9HLUUk+24Pyyc
        epT+N0O9fWv4t+o3NDEVXqamyWgVyF1owIQOgytq40EuG55oaCJFfnxRakoQhhalTgtj7QN1lCwmw
        Tz6ym6tXty1XMU/Z4YR1mNVUHEbcBex28dMnceRdP9AkSL13RiBJXvq8xyn++ZfLbudL4jpwya7x9
        8sKa9vEA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoC1-0007yA-Cx; Wed, 14 Aug 2019 07:59:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] nouveau: reset dma_nr in nouveau_dmem_migrate_alloc_and_copy
Date:   Wed, 14 Aug 2019 09:59:20 +0200
Message-Id: <20190814075928.23766-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
References: <20190814075928.23766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we start a new batch of dma_map operations we need to reset dma_nr,
as we start filling a newly allocated array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 38416798abd4..e696157f771e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -682,6 +682,7 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
 	migrate->dma = kmalloc(sizeof(*migrate->dma) * npages, GFP_KERNEL);
 	if (!migrate->dma)
 		goto error;
+	migrate->dma_nr = 0;
 
 	/* Copy things over */
 	copy = drm->dmem->migrate.copy_func;
-- 
2.20.1

