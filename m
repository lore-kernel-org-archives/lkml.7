Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DF3C32756
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECEA2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMlq/k++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbfHHPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:34:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbfHHPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r4axfViZZyZ+fuvT3jC+Yx773mt75vv7oepOJvLdF2Q=; b=tMlq/k++S7BlJF3D0IEJuqTiM6
        oqe5hKyEHH8CDmDKg/HmAt2rE73V4uPht0nVKiXD7U/2sWNbvrtvdTYnSe9A0uMfHV1GTMAocfrZe
        Ez6ZnLo9Oq7Y44HE7PPtfLoXruoTWqHHBDl8c5ijWE+wdI0Mnb4PqsoCzJHFGlgupiuSJHN33JcCC
        yysnIlvB94o4LnPBKd7u77cy+tjNHSPn5szyd/vrNWL1lix66MTnaXSMIrsCC/VYJOmjK1F4TwfAM
        F83YjQ/z5Hu9qyggzcysNHSygOCOmR/cTep7P0Q3SKjtTyRoBCizKh34pseJoX+Esu02CkwQepujN
        9ykuGN1A==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkQN-0005Ak-P2; Thu, 08 Aug 2019 15:33:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] nouveau: reset dma_nr in nouveau_dmem_migrate_alloc_and_copy
Date:   Thu,  8 Aug 2019 18:33:39 +0300
Message-Id: <20190808153346.9061-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808153346.9061-1-hch@lst.de>
References: <20190808153346.9061-1-hch@lst.de>
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

