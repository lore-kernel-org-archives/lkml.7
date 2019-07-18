Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC27C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E4D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Whrg4ctJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfGRPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:19:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45057 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:19:22 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so51991659ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Tbdphi8CrHqxWHaUURv6oHYNP9deEDGvOFqbwoY/Y0A=;
        b=Whrg4ctJ0WfkjGBYTaCrG+D6OUBE6Tnw2Q7NONAXv+ZDC7WaJk7O/zUK8LXgq2k3Ug
         +qTt5c8636LeXcgwlJEcjTHzHptqGk1UqFvxsyI6zIN+THsqZBsdSVj8LzsXyKyCIHRL
         0USaC0X5nlwytiSP2kYkwdGcBwd73zv3lfOCjv12guAZ3v/OBTP3oDgvutNdUS5L4K6J
         0qkHT1cN+JskUi2h+eLROZtGK4Cr4BxwokYvj2FD2q1566I6cyMJmiPLHO6BgLyvxFox
         IJkRT/G6wFPPC7XKT9TUQzPO6gRdtKQSeOVhIRwjy+FLmyG5B0MzDr31eEE9A+s15B+r
         v5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Tbdphi8CrHqxWHaUURv6oHYNP9deEDGvOFqbwoY/Y0A=;
        b=QxoNAHRipCM8V/h+1R329SW5XMOYbmYbLlxbORf+wexr9fN1l2hkbxSMZ3N7nbDBUm
         7DI0Se8x2buEQ1JCeWHMKqYRnJhNd7c/jyyCIS773Kklg0zRWB7zLERn4aJwMUL9qKuE
         uyZCc7WcgL16k95Mce182oEZFX/1ArQMl0twwX0u7GwOu1j8JSR+pSCtZXWpKUwWwXRD
         HuRJfau45Ucod9ujwOunNHj348xpdIeP8xxUf7eTnnb7uQHblihCYsCcZa0itz+j/dsU
         IeXn4xB6SwNsn/bXtPRz4LVcGBdvKF3lm4mrwiFoVZfuUUZSrz7XjPfJb30g5n83I/wQ
         QDYQ==
X-Gm-Message-State: APjAAAWePNpEraLYJvPH5mrmHTydT12hqX4GEQ/SCThNVI4DYxymVLiB
        TFD0uEkaQazMD6+4ULxJon2NYA==
X-Google-Smtp-Source: APXvYqzvbLr4vBoZPuts04IwgqzTfGI1ll4gN2+jq8yvFshv6/nee/WwlsDHKhSf/3Vy1rhbpwZ+ug==
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr46043389iod.139.1563463161307;
        Thu, 18 Jul 2019 08:19:21 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id n7sm20848114ioo.79.2019.07.18.08.19.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 08:19:20 -0700 (PDT)
Date:   Thu, 18 Jul 2019 08:19:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     cai@lca.pw, arnd@arndb.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] riscv: fix build break after macro-to-function conversion
 in generic cacheflush.h
Message-ID: <alpine.DEB.2.21.9999.1907180800440.18568@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit c296d4dc13ae ("asm-generic: fix a compilation warning")
converted the various flush_*cache_* macros in
asm-generic/cacheflush.h to static inline functions.  This breaks
RISC-V builds, since RISC-V's cacheflush.h includes the generic
cacheflush.h and then undefines the macros to be overridden.

Fix by copying the subset of the no-op functions that are reused from
the generic cacheflush.h into the RISC-V cacheflush.h, and dropping
the include of the generic cacheflush.h.

Fixes: c296d4dc13ae ("asm-generic: fix a compilation warning")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Queued with the other arch/riscv patches for the 5.3 merge window.

 arch/riscv/include/asm/cacheflush.h | 63 +++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index ad8678f1b54a..555b20b11dc3 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -6,11 +6,66 @@
 #ifndef _ASM_RISCV_CACHEFLUSH_H
 #define _ASM_RISCV_CACHEFLUSH_H
 
-#include <asm-generic/cacheflush.h>
+#include <linux/mm.h>
 
-#undef flush_icache_range
-#undef flush_icache_user_range
-#undef flush_dcache_page
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
+/*
+ * The cache doesn't need to be flushed when TLB entries change when
+ * the cache is mapped to physical memory, not virtual memory
+ */
+static inline void flush_cache_all(void)
+{
+}
+
+static inline void flush_cache_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_dup_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start,
+				     unsigned long end)
+{
+}
+
+static inline void flush_cache_page(struct vm_area_struct *vma,
+				    unsigned long vmaddr,
+				    unsigned long pfn)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
+{
+}
+
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
+{
+}
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+	do { \
+		memcpy(dst, src, len); \
+		flush_icache_user_range(vma, page, vaddr, len); \
+	} while (0)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy(dst, src, len)
 
 static inline void local_flush_icache_all(void)
 {
-- 
2.22.0

