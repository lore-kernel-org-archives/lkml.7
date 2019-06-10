Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E83C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHjJBaxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfFJVUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389891AbfFJVUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gK/Yvf8faVmrh63U+btuZjl3JBVDnWKA1ZT84y942oU=; b=RHjJBaxBkB5IiWj3V3fPdq4m/K
        EjuJORZAFiVm6d4mdhDs4JLDsl6wUJO3nR5o4pJIgKrh+pJq3AEcq3NdqQuCpmBYhSpDDbtToqctZ
        iyByb/RPV0OPCQzpDK9f289ecsGhvalnq1DgVFv55KHwjvXQKe3leewYe3N2n5N2gd6/RMmnpt8cf
        S9a2af7b1zrQX9Zy2HZagfWdwZwkpkmBtLa8BtUe2jCIuT4qgfSCNTRRK+X4H1f9MEdzbrupeeHj4
        rQ3ifXtcYCwiFaTj/Dkx3g/p+orYj0csWFJvUsitLlEFAw/fF6csL7BX6LIkkdqqEByJPP9zEjTvS
        wYEiTTnQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRiL-0000Me-FJ; Mon, 10 Jun 2019 21:20:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] binfmt_flat: provide a default version of flat_get_relocate_addr
Date:   Mon, 10 Jun 2019 23:20:03 +0200
Message-Id: <20190610212015.9157-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
References: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way only the two architectures that do masking need to provide
the helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/flat.h    | 2 --
 arch/c6x/include/asm/flat.h    | 1 -
 arch/m68k/include/asm/flat.h   | 1 -
 arch/sh/include/asm/flat.h     | 1 -
 arch/xtensa/include/asm/flat.h | 1 -
 fs/binfmt_flat.c               | 4 ++++
 6 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index 576241d74704..a185fe023b60 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -30,6 +30,4 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 #endif
 }
 
-#define	flat_get_relocate_addr(rel)		(rel)
-
 #endif /* __ARM_FLAT_H__ */
diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
index ac87368efad1..c4d703b454c6 100644
--- a/arch/c6x/include/asm/flat.h
+++ b/arch/c6x/include/asm/flat.h
@@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define flat_get_relocate_addr(rel)			(rel)
 
 #endif /* __ASM_C6X_FLAT_H */
diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
index 955617bb937b..217fa89c8e34 100644
--- a/arch/m68k/include/asm/flat.h
+++ b/arch/m68k/include/asm/flat.h
@@ -28,7 +28,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	return put_user(addr, rp);
 #endif
 }
-#define	flat_get_relocate_addr(rel)		(rel)
 
 #define FLAT_PLAT_INIT(regs) \
 	do { \
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 6f3b18679a98..0d520b4cc5ea 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -24,7 +24,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define	flat_get_relocate_addr(rel)		(rel)
 
 #define FLAT_PLAT_INIT(_r) \
   do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
index b1bc0d9a8d4e..a1d88aa3ef8a 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
 	put_unaligned(addr, (__force u32 *)rp);
 	return 0;
 }
-#define flat_get_relocate_addr(rel)			(rel)
 
 #endif /* __ASM_XTENSA_FLAT_H */
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index a4c0b245ab1f..c0e4535dc1ec 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -43,6 +43,10 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
+#ifndef flat_get_relocate_addr
+#define flat_get_relocate_addr(rel)	(rel)
+#endif
+
 /****************************************************************************/
 
 /*
-- 
2.20.1

