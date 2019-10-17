Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B5ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1D20820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pwk+v2yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503054AbfJQRhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:37:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfJQRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mZYYIsx3vUti8Ycvb0HYKD/nT0xKewtlb0GUV8Tj5DI=; b=Pwk+v2yJPT7+7nzztfWftAKoLT
        bv/NDDLmM6PBXWEsg3UPzBLgxXvTK18YjvYKXtxsyavi/ogzsBSzxTbgOsI+qXwEZpdORB7lvdtSd
        ZSTRV2p7i78niV0o3fY6iaAm+PALza57H9Cza88XaAPDRu/FF28tjY33wlRRqTvvmotVo5zTgVaiO
        xDSTNx9zx5WOr1cIXoaQUyg3SPPywrj+XeyoibcC7XUDApmHs/AFIWWTTWHWNihUvbqpPm9J1dj93
        rhR0kbRA3Q9oBLmmkcKUpyEUERP8N84wZIYlq1itNPJ8Rf+KW5cRk1azyFKGyGRo7vv4yTv0rAnOs
        rq8gQ7vg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9ig-0007Gy-I7; Thu, 17 Oct 2019 17:37:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] riscv: cleanup do_trap_break
Date:   Thu, 17 Oct 2019 19:37:30 +0200
Message-Id: <20191017173743.5430-3-hch@lst.de>
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

If we always compile the get_break_insn_length inline function we can
remove the ifdefs and let dead code elimination take care of the warn
branch that is now unreadable because the report_bug stub always
returns BUG_TRAP_TYPE_BUG.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/traps.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 1ac75f7d0bff..10a17e545f43 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -111,7 +111,6 @@ DO_ERROR_INFO(do_trap_ecall_s,
 DO_ERROR_INFO(do_trap_ecall_m,
 	SIGILL, ILL_ILLTRP, "environment call from M-mode");
 
-#ifdef CONFIG_GENERIC_BUG
 static inline unsigned long get_break_insn_length(unsigned long pc)
 {
 	bug_insn_t insn;
@@ -120,28 +119,15 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 		return 0;
 	return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
 }
-#endif /* CONFIG_GENERIC_BUG */
 
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		force_sig_fault(SIGTRAP, TRAP_BRKPT,
-				(void __user *)(regs->sepc));
-		return;
-	}
-#ifdef CONFIG_GENERIC_BUG
-	{
-		enum bug_trap_type type;
-
-		type = report_bug(regs->sepc, regs);
-		if (type == BUG_TRAP_TYPE_WARN) {
-			regs->sepc += get_break_insn_length(regs->sepc);
-			return;
-		}
-	}
-#endif /* CONFIG_GENERIC_BUG */
-
-	die(regs, "Kernel BUG");
+	if (user_mode(regs))
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->sepc);
+	else if (report_bug(regs->sepc, regs) == BUG_TRAP_TYPE_WARN)
+		regs->sepc += get_break_insn_length(regs->sepc);
+	else
+		die(regs, "Kernel BUG");
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.20.1

