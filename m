Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D910C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0409220709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FfwGbqCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLWP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:26:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:14100 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfLWP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:26:18 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47hNVD00x6z9vJyv;
        Mon, 23 Dec 2019 16:26:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=FfwGbqCe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id d-7QULOjJFaa; Mon, 23 Dec 2019 16:26:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47hNVC62yCz9vJyp;
        Mon, 23 Dec 2019 16:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1577114771; bh=sK12wjRZfrby2Z/oe0vR7BYWS1jDKg9slrhX8TwMHvc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=FfwGbqCeZjDMlv8wLU7Rp8NmOSL+7xj9DH7jV5O0Xd7qew+gVu6k6aMqUfLJTsmyz
         Im0u710FzSLBsWB39gfxmcHKzzFmxGzmKB45I5Q2niznSVGaH6syGKnuGR5KzCXIJa
         DZzShAQ+OLpk7IHcFH99YZveHhrVsXxUN4bnjYXM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B21A8B7AB;
        Mon, 23 Dec 2019 16:26:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YgF9-JgEU1Bo; Mon, 23 Dec 2019 16:26:16 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3F1A8B7A1;
        Mon, 23 Dec 2019 16:26:16 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EAA6A637D8; Mon, 23 Dec 2019 15:26:16 +0000 (UTC)
Message-Id: <6469f08e55055d80a4c11cf339c69c2395b5bf78.1577114567.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1577114567.git.christophe.leroy@c-s.fr>
References: <cover.1577114567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 6/8] powerpc/irq: cleanup check_stack_overflow() a bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Dec 2019 15:26:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of #ifdef, use IS_ENABLED(CONFIG_DEBUG_STACKOVERFLOW).
This enable GCC to check for code validity even when the option
is not selected.

The function is not using current_stack_pointer() anymore so no
need to declare it inline, let GCC decide.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4df49f6e9987..a1122ef4a16c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -596,20 +596,19 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
-static inline void check_stack_overflow(struct pt_regs *regs)
+static void check_stack_overflow(struct pt_regs *regs)
 {
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
 	bool is_user = user_mode(regs);
-	long sp;
+	long sp = regs->gpr[1] & (THREAD_SIZE - 1);
 
-	sp = regs->gpr[1] & (THREAD_SIZE - 1);
+	if (!IS_ENABLED(CONFIG_DEBUG_STACKOVERFLOW))
+		return;
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(!is_user && sp < 2048)) {
 		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
-#endif
 }
 
 #ifdef CONFIG_PPC32
-- 
2.13.3

