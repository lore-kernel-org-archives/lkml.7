Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A72C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1082171F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UPhuBkc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbfIPVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:33:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391822AbfIPVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:33:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so711767pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4KlpoUo9uj/9AIAoQh/K8lKs7NdZLDMBdMrkCQaFlms=;
        b=UPhuBkc9vW4zf5VfKtT0F79pMJmBcKsq8+jGCU3s3iehtMVblC2wGNLtda5np/N2rx
         JwCx1UVEmlyKt/w8diRPdMFVlOY2kH4/aif9Y9e4ndxuu8vACRodDzZmTVDFR/RwQzUK
         gwsHIZtCa4YhOdlSnxj0QcDiv5GzuoIR/l2YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4KlpoUo9uj/9AIAoQh/K8lKs7NdZLDMBdMrkCQaFlms=;
        b=F6cDDr+do8XQ5UkpXb/Fo7ctRG4PcBANOMbnvnDjPF/+EYkXKFLx9gVLNUmZq1reoo
         tc4UI5/c0zMIZJ2kzrBck3b5KWYUDgvG6WZYgklzFNOKEv5E0qZW9qGRvvn5Q6sxNB0w
         k8qQjy6RHXYFJTGbROlgTUIaY/G6gmVFVCA01D7NhpgBUPUzOVO3+XdtC08YKFKEShac
         bb16gEsfIMpin2wD4E7aAFWQxhnhEWSHknFpL3nzMKvTRN5EZFNmtSfjEgvVaSqhSOh4
         X+pwz88pIoBlOnWhPIf49G2uD9Kp7/FvoISbVlBvAf7uqKxRV/sOwksw6jQ9XPYEajB0
         6mfg==
X-Gm-Message-State: APjAAAUziEqFvoCvQMNp8ao7Cs9Rez109a3aPuR15puHSy/QjyfCPw35
        81Yu7PRrIboK392y4bDFh6nnGw==
X-Google-Smtp-Source: APXvYqzNWVMHgw9GuBVr/tP0lAfAHs1WoOMf3wfEvoO14+//reQ/ES3liAd9pVPgxkc0CERucot+Kg==
X-Received: by 2002:a62:83c8:: with SMTP id h191mr521538pfe.240.1568669578653;
        Mon, 16 Sep 2019 14:32:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b185sm42002pfg.14.2019.09.16.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:32:57 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:32:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] usercopy: Skip HIGHMEM page checking
Message-ID: <201909161431.E69B29A0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running on a system with >512MB RAM with a 32-bit kernel built with:

	CONFIG_DEBUG_VIRTUAL=y
	CONFIG_HIGHMEM=y
	CONFIG_HARDENED_USERCOPY=y

all execve()s will fail due to argv copying into kmap()ed pages, and on
usercopy checking the calls ultimately of virt_to_page() will be looking
for "bad" kmap (highmem) pointers due to CONFIG_DEBUG_VIRTUAL=y:

 ------------[ cut here ]------------
 kernel BUG at ../arch/x86/mm/physaddr.c:83!
 invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
 CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc8 #6
 Hardware name: Dell Inc. Inspiron 1318/0C236D, BIOS A04 01/15/2009
 EIP: __phys_addr+0xaf/0x100
 ...
 Call Trace:
  __check_object_size+0xaf/0x3c0
  ? __might_sleep+0x80/0xa0
  copy_strings+0x1c2/0x370
  copy_strings_kernel+0x2b/0x40
  __do_execve_file+0x4ca/0x810
  ? kmem_cache_alloc+0x1c7/0x370
  do_execve+0x1b/0x20
  ...

fs/exec.c:
		kaddr = kmap(kmapped_page);
	...
	if (copy_from_user(kaddr+offset, str, bytes_to_copy)) ...

Without CONFIG_DEBUG_VIRTUAL=y, these pages are effectively ignored,
so now we do the same explicitly: detect and ignore kmap pages, instead
of tripping over the check later.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Randy, I dropped your other Tested-by, since this is a different
approach. I would expect the results to be identical (i.e. my testing
shows it works), but I didn't want to assume. :)
---
 include/linux/highmem.h | 7 +++++++
 mm/highmem.c            | 2 +-
 mm/usercopy.c           | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..c881698b8023 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -64,12 +64,19 @@ static inline void totalhigh_pages_set(long val)
 
 void kmap_flush_unused(void);
 
+static inline bool is_kmap(unsigned long addr)
+{
+	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP));
+}
+
 struct page *kmap_to_page(void *addr);
 
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
 
+static inline bool is_kmap(unsigned long addr) { return false; }
+
 static inline struct page *kmap_to_page(void *addr)
 {
 	return virt_to_page(addr);
diff --git a/mm/highmem.c b/mm/highmem.c
index 107b10f9878e..e99eca4f63fa 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -151,7 +151,7 @@ struct page *kmap_to_page(void *vaddr)
 {
 	unsigned long addr = (unsigned long)vaddr;
 
-	if (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) {
+	if (is_kmap(addr)) {
 		int i = PKMAP_NR(addr);
 		return pte_page(pkmap_page_table[i]);
 	}
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 98e924864554..924e634cc95d 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -224,7 +225,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 {
 	struct page *page;
 
-	if (!virt_addr_valid(ptr))
+	if (!virt_addr_valid(ptr) || is_kmap((unsigned long)ptr))
 		return;
 
 	page = virt_to_head_page(ptr);
-- 
2.17.1


-- 
Kees Cook
