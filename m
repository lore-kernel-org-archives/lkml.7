Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C16DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D418420862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gur3tIs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfENJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:05:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64142 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENJFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:05:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 453Bbc16jLz9v0Yd;
        Tue, 14 May 2019 11:05:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gur3tIs8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vsVOIm8G4b7p; Tue, 14 May 2019 11:05:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 453Bbc01n9z9v0Yb;
        Tue, 14 May 2019 11:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557824716; bh=DiCOmDtSq7OwtImUj14O9P3JgGKMZDEuEiJxkx/6VFQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=gur3tIs8KePKLaDaOra06DO/CmplPefZlCk/dveYFoSfoIcLyuk1K/qN9bzUmCSxR
         Pa1Ok2OWOLuEAQxWnEkCrFvsuWJdQkRF3BcN4s5YkJrgKpXjqu4emrhSkWToA5+C6S
         JZ92IKJS3TVObeN4dh9PmyNyP6TzW31Ehqpos0ZE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C57478B8BF;
        Tue, 14 May 2019 11:05:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ifnKRYh7VJFZ; Tue, 14 May 2019 11:05:16 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B6118B7C1;
        Tue, 14 May 2019 11:05:16 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D3EC06742D; Tue, 14 May 2019 09:05:15 +0000 (UTC)
Message-Id: <139368cc27b054f6fe155011dad63ef753db036e.1557824379.git.christophe.leroy@c-s.fr>
In-Reply-To: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/4] powerpc/32: define helpers to get L1 cache sizes.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 May 2019 09:05:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines C helpers to retrieve the size of
cache blocks and uses them in the cacheflush functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cache.h      | 16 ++++++++++++++--
 arch/powerpc/include/asm/cacheflush.h | 24 +++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 40ea5b3781c6..0009a0a82e86 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -33,7 +33,8 @@
 
 #define IFETCH_ALIGN_BYTES	(1 << IFETCH_ALIGN_SHIFT)
 
-#if defined(__powerpc64__) && !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_PPC64
 
 struct ppc_cache_info {
 	u32 size;
@@ -53,7 +54,18 @@ struct ppc64_caches {
 };
 
 extern struct ppc64_caches ppc64_caches;
-#endif /* __powerpc64__ && ! __ASSEMBLY__ */
+#else
+static inline u32 l1_cache_shift(void)
+{
+	return L1_CACHE_SHIFT;
+}
+
+static inline u32 l1_cache_bytes(void)
+{
+	return L1_CACHE_BYTES;
+}
+#endif
+#endif /* ! __ASSEMBLY__ */
 
 #if defined(__ASSEMBLY__)
 /*
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index e9a40b110f1d..d405f18441cd 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -64,11 +64,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
  */
 static inline void flush_dcache_range(unsigned long start, unsigned long stop)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long shift = l1_cache_shift();
+	unsigned long bytes = l1_cache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < size >> shift; i++, addr += bytes)
 		dcbf(addr);
 	mb();	/* sync */
 }
@@ -80,11 +82,13 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
  */
 static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long shift = l1_cache_shift();
+	unsigned long bytes = l1_cache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < size >> shift; i++, addr += bytes)
 		dcbst(addr);
 	mb();	/* sync */
 }
@@ -97,11 +101,13 @@ static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 static inline void invalidate_dcache_range(unsigned long start,
 					   unsigned long stop)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long shift = l1_cache_shift();
+	unsigned long bytes = l1_cache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < size >> shift; i++, addr += bytes)
 		dcbi(addr);
 	mb();	/* sync */
 }
-- 
2.13.3

