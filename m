Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F9EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AA320644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/mDm974"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfFMQjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbfFMHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jK/gGLsodzGw/W/Jdp61k5bjN/xChJWEP8DWfDcQEpo=; b=k/mDm974CDIfw6zdcYg4r4OkoA
        QZMtkH2/phvSd/ZQgjQrjZH0j3zTyVR+DhFCso0frHK/bcY/dw4QlSBxa+l3MLYXgFh4xMLZEUyda
        TtYR7dJYkF8+w13SM4sTstdH7EOGEN2/urGin/pCgQD20NWvAvL90Qf6cG8R6ZhHBmTW4v6aiaVjO
        QmcVZBLkfCuslcPzHug5lpFG0Ni1UmxW7sKPfBgvzPI3/8PTuQUDhPxxeXFKnAevwD8+2NI4UVrZJ
        HlAIOkj21XOYwUh7xMe6z/0CPc/2miJeceQYpMWfcIvq7aXUvl5gEPijIr6NhDz53NJmv/Rl+G/89
        3RRhGOHQ==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrH-0004Ax-Gw; Thu, 13 Jun 2019 07:09:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 03/17] binfmt_flat: provide a default version of flat_get_relocate_addr
Date:   Thu, 13 Jun 2019 09:08:49 +0200
Message-Id: <20190613070903.17214-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
References: <20190613070903.17214-1-hch@lst.de>
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
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
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

