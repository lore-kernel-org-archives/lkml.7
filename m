Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE4CC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D47218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3EKb9yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfGHRvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:51:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfGHRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AOs5st77O9pj+7M9UFOQZQXNGqS7EXSA7ZK+X2SZmMQ=; b=G3EKb9yf/Txs/Pz5KqWfftkOp
        U9Lyww5tpatISpvX1dtKuBS43jWy3Bjwc9sx7lSSG3dfnj4EsiTTEqvnuNJMh+fDNziUCSoayhO+9
        WR58WHEg01GQxrwfN2ngmF4iAWSpzoMjU3IE9w2l+iEqRFIgRc5ttqop3M1dpaeCokfT4enoFRhhL
        shVQoZfNjLVUnAnrR2N1JilxLTmCG+zXk6C39PIXARVjIcwq65sB8YqFEuAPTynYfBkaasCItXJmd
        z8yWcYLjyIZT3006mqBX/uu9uIlFlPvblj8vkmKdtBAfhGaQgKwU9g9ErPb1DilUcki2Y1pd/+Trl
        R4ntw2e5w==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkXn9-0003g1-FP; Mon, 08 Jul 2019 17:51:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     geert@linux-m68k.org
Cc:     linux@roeck-us.net, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: don't select ARCH_HAS_DMA_PREP_COHERENT for nommu or coldfire
Date:   Mon,  8 Jul 2019 10:51:01 -0700
Message-Id: <20190708175101.19990-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m68k only provides the dma_prep_coherent symbol when an mmu is enabled
and not on the coldfire platform.  Fix the Kconfig symbol selection
up to match this.

Fixes: 69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 8f765cfefca6..c518d695c376 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -5,7 +5,7 @@ config M68K
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
-	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
-- 
2.20.1

