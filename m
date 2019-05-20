Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A4C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3820815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+f0EQyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfETGBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:01:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfETGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qcNLeLvPH2g6VMTa9XX70nBLAss1SSxUJ+jGxGFYSuk=; b=T+f0EQySfnQT0LlYHxNbpq8uUj
        VRAZqBViMEjBlsL40GwqaObh/vaEPFPfLWKwxAsaOAlTnbWiilvcgdqq3bJ3uE23MMCHgccCaeVyQ
        D+YOMmD7ODS86K3TV2vF4umWMyTSclSOqGKaO4awpWiZpDgaMbyAmdGFM9KBuLT7KsvDyIeVSqFr6
        frqUVY3C70O/+9fy3VxPFgoei4V9vGTL7oezRDUd4xd0nUhCBWkc/C3q6tW+IISRnFm/k+KNyhjRz
        LrIy8NclaNhec2Rk8op2q9WhgVz5JIvYg5mKfdzQKQkoHkHwNVYBfaIkc/kIywJJUNko+ZxxG5elc
        sDewchow==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbMJ-0001VM-SF; Mon, 20 May 2019 06:01:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
Date:   Mon, 20 May 2019 08:00:15 +0200
Message-Id: <20190520060018.25569-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 6f047730e642..fc007d186a82 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -115,18 +115,33 @@ struct pt_regs
 
 #ifndef __ASSEMBLY__
 
-#define GET_IP(regs)		((regs)->nip)
-#define GET_USP(regs)		((regs)->gpr[1])
-#define GET_FP(regs)		(0)
-#define SET_FP(regs, val)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->nip;
+}
+
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->nip = val;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->gpr[1];
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
+#else
+#define profile_pc(regs) instruction_pointer(regs)
 #endif
 
-#include <asm-generic/ptrace.h>
-
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
-- 
2.20.1

