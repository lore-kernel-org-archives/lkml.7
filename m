Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79360C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1532175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="taWSJ99P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfEJJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:24:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34576 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfEJJYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:24:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 450lD01KCKz9v1Mt;
        Fri, 10 May 2019 11:24:48 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=taWSJ99P; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KJXQjKtTJ41s; Fri, 10 May 2019 11:24:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 450lD00HK7z9v1MX;
        Fri, 10 May 2019 11:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557480288; bh=7+rPkb2mMCN5fVEdeNW5Bv+959x/xuLC/xkQspJWIF4=;
        h=From:Subject:To:Cc:Date:From;
        b=taWSJ99PKG67Av4raH7KIE+Cms6j4wKbf27OdG2itiwITW2soKJWE2LGl/28cLXXI
         +U9DlPPhQ7uHNnTjc3v8CfSWhU7C4wW1W5gzC6RdgDS/zUWx0AKQuWgBtOW1VGp7b5
         JbHEWmola2E6NrjmVNMdZ+MR5+b67mB2A+KLvZ1E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 30AB88B940;
        Fri, 10 May 2019 11:24:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6vEArAskASY9; Fri, 10 May 2019 11:24:49 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 15F368B7E6;
        Fri, 10 May 2019 11:24:49 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DAAD2673B2; Fri, 10 May 2019 09:24:48 +0000 (UTC)
Message-Id: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: slightly improve cache helpers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 10 May 2019 09:24:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
that are summed to obtain the target address. Using 'Z' constraint
and '%y0' argument gives GCC the opportunity to use both registers
instead of only one with the second being forced to 0.

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 40ea5b3781c6..df8e4c407366 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -85,22 +85,22 @@ extern void _set_L3CR(unsigned long);
 
 static inline void dcbz(void *addr)
 {
-	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
 
 static inline void dcbi(void *addr)
 {
-	__asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
 
 static inline void dcbf(void *addr)
 {
-	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbf %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
 
 static inline void dcbst(void *addr)
 {
-	__asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.13.3

