Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52392C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280B823429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="conO8oSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfH3QMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:12:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfH3QMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G4rBKjta8eB1QVEIyfmSCogCx0xyQ/mHy340A8ZXMHo=; b=conO8oSJr52qUdUuMYknMVXLJZ
        zWu8S8WoYZI+MZntQ/z7lZb5ezfPEN+fmE4gcv9ODmU2dPrdA7hZTV9xywrNmF5wRuBzGekWhtmr4
        /sZWPEHFcWi4NsMT6DfYgiJqHmf9fZC0wJgYzf2umPqZW6htP3I87OSQNeAF4ZIJyNgu4esFVJ3pU
        lYHzV9PWh/RDJ2vUbDWaZqN0NsOOEmXus5oGwZbQLqXRLFjCV5n+lo7KhqgH0Yk6PxELLfjrPML2i
        75P0vOcuScq1P50NXtyZEgbKQuq7vd7m+DCDmFrL4ZLzvNW7E8fDSjkl5v1QZNDRRQvpSynBm83Qb
        RkI/TcLw==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jVy-0000kc-BU; Fri, 30 Aug 2019 16:12:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] m68k: remove ioremap_fullcache
Date:   Fri, 30 Aug 2019 18:12:35 +0200
Message-Id: <20190830161237.23033-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830161237.23033-1-hch@lst.de>
References: <20190830161237.23033-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No callers of this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/kmap.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index aac7f045f7f0..03d904fe6087 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -43,13 +43,6 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr,
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-#define ioremap_fullcache ioremap_fullcache
-static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
-					      unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
-}
-
 #define memset_io memset_io
 static inline void memset_io(volatile void __iomem *addr, unsigned char val,
 			     int count)
-- 
2.20.1

