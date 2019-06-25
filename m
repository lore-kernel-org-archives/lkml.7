Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E392C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73341208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jQEW/T2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfFYUQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:16:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44077 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfFYUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:16:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so13684944qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=jQEW/T2ioqSIqEH27/wZQTyrqpiEYcNggCDHviY4u9btaR8yZoYlXSWPrKMFn7apE8
         PBuyIreqmpc+Lf7NumD1HggoEi0F4hYdinjaGIhvBfDTYmQotHCEvoXkcceFfz8/7zBL
         u2A9hF+PYo+U+dtqOFkj4I5dvF2XBnfu6RGHfyXFysDfJ1nObukECX6GkskYYU8B+Fqz
         3Oq6PkIiN3SS2mapgeNeub+SvBZUFBRR7y7EnlDj3japM2CUxAl9ARftjB0jnv4iGmjW
         2Au7woSG5+Zu9ax6vjJTmKSryKe8dwOYoQTBV5kumsqeg6//0DKTG3FDwt3iQaxGmEqR
         w5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=tbjQsvUURUVBl96jurFGVMeiFNAb8CGLRUhrG4tcu8Ec82CVOnxGyrXAuAGytWyAUu
         psEKjGpSl2SFTIhh+8DplEW12EYns1iKrSVNtgV0oCqUP74cZ/6enf045+Rn7zp+f1ZE
         +lwSPBnCtQain/Hbu79ZcNVJfA0zQq91YXPf7vp/GajIhHYg50siw7CrDrNX23a7WFsx
         us0BNtxYENNH3jD9CFBMVZgiXBY1yEGzVc46ELKOPur/4DwpsjK6tFf45KMSOIlCpYB7
         BAGhc+MG0iZNyoWukqgFtuQF7lbQWtrfyq4CYLGKm2aTl+6tqDjleUmnNz6h/3JIcIFk
         hK7Q==
X-Gm-Message-State: APjAAAWcWbzNRtHXz5QwbNNLSEhPnKP2rDKfMurLozY/GJSDq7+MBU6I
        f+5ul49t6Jd3NyEYGsA25vf6TA==
X-Google-Smtp-Source: APXvYqx3MPsUMRt5L9qn0ZkLk78knyCrOQppj49qrRRC6+2rbLzmvuLW9r6dOWuSjAah5DvgrMzlrg==
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr558920qkm.168.1561493771373;
        Tue, 25 Jun 2019 13:16:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u1sm9600931qth.21.2019.06.25.13.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:16:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix a compilation warning
Date:   Tue, 25 Jun 2019 16:15:53 -0400
Message-Id: <1561493753-3860-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this compilation warning on x86 by making flush_cache_vmap() inline.

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:214:16: warning: variable 'start' set but not used
[-Wunused-but-set-variable]
  unsigned long start;
                ^~~~~

While at it, convert all other similar functions to inline for
consistency.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/cacheflush.h | 74 ++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 0dd47a6db2cf..a950a22c4890 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -5,24 +5,70 @@
 /* Keep includes the same across arches.  */
 #include <linux/mm.h>
 
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
  */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma,pg)		do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
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
+static inline void flush_dcache_page(struct page *page)
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
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
+{
+}
+
+static inline void flush_icache_user_range(struct vm_area_struct *vma,
+					   struct page *page,
+					   unsigned long addr, int len)
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
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do { \
-- 
1.8.3.1

