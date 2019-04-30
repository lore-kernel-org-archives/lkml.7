Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C921707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FVteQbEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfD3LBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:01:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfD3LBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3Xy1bF8Wi5NVGLFCvIkaMkXFvZgNVtaIEsOwlocOpa8=; b=FVteQbElIFLrLRScMi0IGrrKLV
        IfHvcUjEhQclgQEIYfQlTDPC4h+kXCY3mybGeyGJxw/8QD04gTXHoDeOcdBUOiDihzQ5ko9rJCnpX
        PajdpExsVPCZFXMBwOH9w8k9nloM8T4jFDNJvhdeTK9cdfMTG0iYYRfhKlwiWf/dV9KeMQj8DOUQR
        h6+SSpn/K03HfkTBiQFpZgHL047EcNRBFuJFMi+K4Py9mNpGeRiSgjaGvx8kHXiYOmOtH4+yCVV/8
        i/enaApttRIWfsuDCTDCE/FJHEyij2G169hThFMgPzZoXYkKkwaupnh5OsVTuPlzGEhQAvmeG9JBJ
        JWUKvUCw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQVb-0000GX-PN; Tue, 30 Apr 2019 11:01:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/7] MIPS: remove the _dma_cache_wback_inv export
Date:   Tue, 30 Apr 2019 07:00:26 -0400
Message-Id: <20190430110032.25301-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430110032.25301-1-hch@lst.de>
References: <20190430110032.25301-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This export is not used in modular code, which is a good thing as
everyone should use the proper DMA API instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 3da216988672..33b409391ddb 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -62,8 +62,6 @@ void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 void (*_dma_cache_wback)(unsigned long start, unsigned long size);
 void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
-EXPORT_SYMBOL(_dma_cache_wback_inv);
-
 #endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
-- 
2.20.1

