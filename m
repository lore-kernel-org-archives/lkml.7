Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50267C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE820721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eoG+puxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLIGH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:07:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31633 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfLIGHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:07:24 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47WXlp4b4fz9v4lJ;
        Mon,  9 Dec 2019 07:07:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eoG+puxR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jaQvifrYL9WH; Mon,  9 Dec 2019 07:07:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47WXlp32nJz9v4lG;
        Mon,  9 Dec 2019 07:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575871638; bh=tkfm9OhHjqXChDBkWF26R6Jd4Y+Bbif1MoEgo3rfn7c=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eoG+puxRhsUTlTdIP+906wOHH2+I9ec9bXX4XOG9M0j6MfqBt7BSofvFHrvXrtXOg
         ZRblVsWZkHLPbwr9rjPo2/BgbJRkALSqmXKfxumIBUjmRPDschUad0HF68Sl/G8AYa
         2EzNSb8XqEn0ewYu38bk+CSdHRp6QlW6ox0fnrJw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC2C18B7AF;
        Mon,  9 Dec 2019 07:07:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jRxt4zlh6ZyY; Mon,  9 Dec 2019 07:07:22 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9DD18B755;
        Mon,  9 Dec 2019 07:07:22 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B715663679; Mon,  9 Dec 2019 06:07:22 +0000 (UTC)
Message-Id: <9db524b0490235042ed0bca067e6f4db481cbacd.1575871613.git.christophe.leroy@c-s.fr>
In-Reply-To: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/irq: use IS_ENABLED() in check_stack_overflow()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  9 Dec 2019 06:07:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of #ifdef, use IS_ENABLED(CONFIG_DEBUG_STACKOVERFLOW).
This enable GCC to check for code validity even when the option
is not selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4d468d835558..0aebd7843c73 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -598,16 +598,17 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 
 static inline void check_stack_overflow(void)
 {
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
 	register unsigned long r1 asm("r1");
 	long sp = r1 & (THREAD_SIZE - 1);
 
+	if (!IS_ENABLED(CONFIG_DEBUG_STACKOVERFLOW))
+		return;
+
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < 2048)) {
 		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
-#endif
 }
 
 #ifdef CONFIG_PPC32
-- 
2.13.3

