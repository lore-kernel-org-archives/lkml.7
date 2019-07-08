Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DDCC606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ADE21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sIMNHEGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfGHOER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:04:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39019 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbfGHOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:04:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so9844026qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=sIMNHEGp0F8JWetNQVr0B/ZurO66AY4SY48xUOqEiY3Mr0gFu2HT/whDnZV9gpcE+l
         FIRC+JSa3ygobtRT2tARLeqpLK3FdG/8FVaqdfZldNBLqRYZknx2pFZT5Ngkw8ys4H2Z
         MoWnrIlRaGBXC+xw444UM2xHYkT8zPS58TFq0HnqKNV2wI36DOdApW5E/WLOv0vmq/7f
         Xw0IO95KZHDUhOA2Z1vTxRKfPNQPAaRTi/6OmBjEwPI2rEc0kAYPgp7W+3YV8EghqrXn
         qB5pJFTyOZ7i+futkA2tlnVlS6oF10YvrYgRRD5saB1DwNnpppy3FAVhVC4AyiJhr4h8
         gYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=tI2DHt+hYrd6fGVS21RnZmBl9BIFE/qdadQxhN6dO+DzOO7gpeujG0G4J+/FmnoLD5
         eliqDvTq9Zz4vmzyL5tSrEQb7rMHyffuygaxwoj30heUxaIyBCdpuCcacgsDF0SZSxgm
         UKHG0XP2Wcc+Wr2xwJ8oqBeT1TAkHgPZX9saC6QFyKFUvR6rKtSV/GrZQEgG9IhY5JTj
         cPi2Ayv62uNq5N7ZGDAgV/4weWagNA3DopfZX6aGhUqOfd0Kw4buJaP2s/Vpa0VTao+n
         wxpweBVF3BUw3bh0+pBKjhwWgR5r3ov1MOE2z1pedEmhBumviVrKPdl/ywIV+Dx7FIi5
         krKw==
X-Gm-Message-State: APjAAAUVcqku+ktw6mB9OP7f4gVNwOJcuibvSpzuYHi6pl+kz9uvRIAi
        OlInsrG/FIaiXd+/aBMeufTl2A==
X-Google-Smtp-Source: APXvYqyYQMNJjuJrYx3+8PsGGNhA2EyLCKUdg8G3q5avS9pE3nucMlQ8xf/yvGiKg533KkANUoLhpw==
X-Received: by 2002:aed:3c44:: with SMTP id u4mr14107988qte.73.1562594656451;
        Mon, 08 Jul 2019 07:04:16 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm7182473qkn.26.2019.07.08.07.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:04:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] asm-generic: fix a compilation warning
Date:   Mon,  8 Jul 2019 10:03:12 -0400
Message-Id: <1562594592-15228-1-git-send-email-cai@lca.pw>
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

