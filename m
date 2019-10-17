Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F5ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1220820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+cZ35+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440726AbfJQRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:37:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfJQRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/7ydX64Y3MlgTFOaeZ9aq7MX2phJVP+JprNKSr3R4gU=; b=O+cZ35+GZ2xotfju+597+zIktS
        czhU26S06c6jEKG2CkJee8+LEreW/9nJMoBDxq6UN201hBc/Kcdu1mPcghb/tNSTt01dXqipZ2/gF
        o13wLwkqU8PVmEcbYuXBksZnMkvphWZdVUrwmP2DlfTRQhTxa3BajLD3Qll7CUxlWK6GqUxLvaTra
        DjpEdglwCc4hdKfioYsqdm8L68NLFBebhGR2Nm7EDo+J5fPo/MVLNOqKI7GWKoKA2uxf6PnP+oMrp
        tJlA3v66UAs2KKTw0VDej6x912jqX/pMawdsy9YMVFh2ljtRjt6LdxhSMtDq+wW0t0Ye5dM4qqO5K
        jjK9LDIg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9ie-0007FU-3C; Thu, 17 Oct 2019 17:37:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] riscv: cleanup <asm/bug.h>
Date:   Thu, 17 Oct 2019 19:37:29 +0200
Message-Id: <20191017173743.5430-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017173743.5430-1-hch@lst.de>
References: <20191017173743.5430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove various not required ifdefs and externs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/bug.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 07ceee8b1747..75604fec1b1b 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -12,7 +12,6 @@
 
 #include <asm/asm.h>
 
-#ifdef CONFIG_GENERIC_BUG
 #define __INSN_LENGTH_MASK  _UL(0x3)
 #define __INSN_LENGTH_32    _UL(0x3)
 #define __COMPRESSED_INSN_MASK	_UL(0xffff)
@@ -20,7 +19,6 @@
 #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
 #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
 
-#ifndef __ASSEMBLY__
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
@@ -43,6 +41,7 @@ typedef u32 bug_insn_t;
 	RISCV_SHORT " %2"
 #endif
 
+#ifdef CONFIG_GENERIC_BUG
 #define __BUG_FLAGS(flags)					\
 do {								\
 	__asm__ __volatile__ (					\
@@ -58,14 +57,10 @@ do {								\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
-
-#endif /* !__ASSEMBLY__ */
 #else /* CONFIG_GENERIC_BUG */
-#ifndef __ASSEMBLY__
 #define __BUG_FLAGS(flags) do {					\
 	__asm__ __volatile__ ("ebreak\n");			\
 } while (0)
-#endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_GENERIC_BUG */
 
 #define BUG() do {						\
@@ -79,15 +74,10 @@ do {								\
 
 #include <asm-generic/bug.h>
 
-#ifndef __ASSEMBLY__
-
 struct pt_regs;
 struct task_struct;
 
-extern void die(struct pt_regs *regs, const char *str);
-extern void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr);
-
-#endif /* !__ASSEMBLY__ */
+void die(struct pt_regs *regs, const char *str);
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
 
 #endif /* _ASM_RISCV_BUG_H */
-- 
2.20.1

