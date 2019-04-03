Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEB82133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HG8dSBfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDCUHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:07:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60056 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfDCUGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCF3H79z9v3pq;
        Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HG8dSBfj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fsk3bO9Ujalu; Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCF2Cznz9v3pp;
        Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321977; bh=970wlOaQpGtoCjkMZSnSrOj9AfwAnmYD5UEwoPtyWRU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=HG8dSBfjDa0f2F5csZF/g3MENcLHldD3iFiP9wiiX6JqxAEJvG71WGUa/5sDKEhHJ
         X49NVaU9UL774zVS8zsG2s8tRxr1YgpXeKVEEYS974e3qTRF1HuPlYq7PFdi36rWWB
         rpVhe+3l524kesHpqD2unpiJkhxComS72NNRBhPc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CD5F8B905;
        Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Py1XGp7M8-qb; Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 476608B902;
        Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3336C655EC; Wed,  3 Apr 2019 20:06:17 +0000 (UTC)
Message-Id: <5acb0d752bf5dd936ec9ae1050b81d21a5a535a0.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 05/15] powerpc/mm: get rid of nohash/32/mmu.h and
 nohash/64/mmu.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those files have no real added values, especially the 64 bit
which only includes the common book3e mmu.h which is also
included from 32 bits side.

So lets do the final inclusion directly from nohash/mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu.h | 19 -------------------
 arch/powerpc/include/asm/nohash/64/mmu.h |  8 --------
 arch/powerpc/include/asm/nohash/mmu.h    | 16 ++++++++++++----
 3 files changed, 12 insertions(+), 31 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 delete mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h

diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
deleted file mode 100644
index af0e8b54876a..000000000000
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
-#define _ASM_POWERPC_NOHASH_32_MMU_H_
-
-#if defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#include <asm/nohash/32/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#include <asm/nohash/32/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#include <asm/nohash/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#include <asm/nohash/32/mmu-8xx.h>
-#endif
-
-#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
deleted file mode 100644
index 87871d027b75..000000000000
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
-#define _ASM_POWERPC_NOHASH_64_MMU_H_
-
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#include <asm/nohash/mmu-book3e.h>
-
-#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
index a037cb1efb57..edc793e5f08f 100644
--- a/arch/powerpc/include/asm/nohash/mmu.h
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -2,10 +2,18 @@
 #ifndef _ASM_POWERPC_NOHASH_MMU_H_
 #define _ASM_POWERPC_NOHASH_MMU_H_
 
-#ifdef CONFIG_PPC64
-#include <asm/nohash/64/mmu.h>
-#else
-#include <asm/nohash/32/mmu.h>
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
 #endif
 
 #endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
-- 
2.13.3

