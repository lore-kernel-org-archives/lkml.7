Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05195C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23CE20881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K22DOVI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfEJUnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 16:43:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33935 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:43:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so3824755pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=76iqXYIBsPCxt9x2ujTGlvZ4d7tv3+wnMgJVgNEYPRo=;
        b=K22DOVI+qHBY9YLZq944p4n2eWAJWXK4KnM/2zE2DppF2J53cb8/mkXpAC+y26rdYM
         sat3drmZu9hkhzqCptbaUuT+7vhLxKBCn6TH9Uj4d4NEJw3RFqV+XqSpLlPFLYgeuq5M
         m7Rjy60BpcB9Fo7Sgh4toLHJJ3KpUqR0sXLwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=76iqXYIBsPCxt9x2ujTGlvZ4d7tv3+wnMgJVgNEYPRo=;
        b=uAdM0WnYCPM+zVt/ooAATtUv8nsGxDpNDzTsoC1QIhHBmFSEj5KbGSf80PoU4WHpjW
         aKmDtYYky1v6uNVZ2PlpAk57fbxbcextoDuVghN0j4PikeKGh/BL2dQq4hlculkZcjTb
         oFPsJ4wZmqJuLKJzeuHa4/UuSCSCZ3B1Bi0I1yaMIhwZlz3IqNPUY5phBMpaJVGf5VJN
         p7BKOPo+7mcPy555MFjmBLtgOg7VET0xlw6z6c5j6H/uU021DQ2bQZmQACmSGQJk3zRg
         Iwc8WwUtdRR1D06jYgFVNNX51SlGdgJkRrBPE4Z9kr+qUZNBf1zt7/QL4e9etQ04t3Ia
         qGgQ==
X-Gm-Message-State: APjAAAWA3HDLKGCzavloWnDQuhgWn+7udagNiuLlE6sf7lO+LYJcRGDM
        YjKjoa1xOVZn8ETrR/uVyRvT4A==
X-Google-Smtp-Source: APXvYqxbxUCNjMAkjwXwSrZQ6SbP9eqYYwQjMHEbvIeAftGSgjz6x0onni8QudYKGxKKLfXsyk8vWA==
X-Received: by 2002:aa7:8f22:: with SMTP id y2mr4913414pfr.22.1557521019294;
        Fri, 10 May 2019 13:43:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm6787011pga.56.2019.05.10.13.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 13:43:38 -0700 (PDT)
Date:   Fri, 10 May 2019 13:43:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <201905101341.A17DDD7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature continues to cause more problems than it solves[1]. Its
intention was to check the bounds of page-allocator allocations by using
__GFP_COMP, for which we would need to find all missing __GFP_COMP
markings. This work has been on hold and there is an argument[2]
that such markings are not even the correct signal for checking for
same-allocation pages. Instead of depending on BROKEN, this just removes
it entirely. It can be trivially reverted if/when a better solution for
tracking page allocator sizes is found.

[1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
[2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c    | 67 ------------------------------------------------
 security/Kconfig | 11 --------
 2 files changed, 78 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 14faadcedd06..15dc1bf03303 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -159,70 +159,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 		usercopy_abort("null address", NULL, to_user, ptr, n);
 }
 
-/* Checks for allocs that are marked in some way as spanning multiple pages. */
-static inline void check_page_span(const void *ptr, unsigned long n,
-				   struct page *page, bool to_user)
-{
-#ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
-	const void *end = ptr + n - 1;
-	struct page *endpage;
-	bool is_reserved, is_cma;
-
-	/*
-	 * Sometimes the kernel data regions are not marked Reserved (see
-	 * check below). And sometimes [_sdata,_edata) does not cover
-	 * rodata and/or bss, so check each range explicitly.
-	 */
-
-	/* Allow reads of kernel rodata region (if not marked as Reserved). */
-	if (ptr >= (const void *)__start_rodata &&
-	    end <= (const void *)__end_rodata) {
-		if (!to_user)
-			usercopy_abort("rodata", NULL, to_user, 0, n);
-		return;
-	}
-
-	/* Allow kernel data region (if not marked as Reserved). */
-	if (ptr >= (const void *)_sdata && end <= (const void *)_edata)
-		return;
-
-	/* Allow kernel bss region (if not marked as Reserved). */
-	if (ptr >= (const void *)__bss_start &&
-	    end <= (const void *)__bss_stop)
-		return;
-
-	/* Is the object wholly within one base page? */
-	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
-		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
-		return;
-
-	/* Allow if fully inside the same compound (__GFP_COMP) page. */
-	endpage = virt_to_head_page(end);
-	if (likely(endpage == page))
-		return;
-
-	/*
-	 * Reject if range is entirely either Reserved (i.e. special or
-	 * device memory), or CMA. Otherwise, reject since the object spans
-	 * several independently allocated pages.
-	 */
-	is_reserved = PageReserved(page);
-	is_cma = is_migrate_cma_page(page);
-	if (!is_reserved && !is_cma)
-		usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
-
-	for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
-		page = virt_to_head_page(ptr);
-		if (is_reserved && !PageReserved(page))
-			usercopy_abort("spans Reserved and non-Reserved pages",
-				       NULL, to_user, 0, n);
-		if (is_cma && !is_migrate_cma_page(page))
-			usercopy_abort("spans CMA and non-CMA pages", NULL,
-				       to_user, 0, n);
-	}
-#endif
-}
-
 static inline void check_heap_object(const void *ptr, unsigned long n,
 				     bool to_user)
 {
@@ -236,9 +172,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (PageSlab(page)) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, page, to_user);
-	} else {
-		/* Verify object does not incorrectly span multiple pages. */
-		check_page_span(ptr, n, page, to_user);
 	}
 }
 
diff --git a/security/Kconfig b/security/Kconfig
index 353cfef71d4e..8392647f5a4c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -176,17 +176,6 @@ config HARDENED_USERCOPY_FALLBACK
 	  Booting with "slab_common.usercopy_fallback=Y/N" can change
 	  this setting.
 
-config HARDENED_USERCOPY_PAGESPAN
-	bool "Refuse to copy allocations that span multiple pages"
-	depends on HARDENED_USERCOPY
-	depends on EXPERT
-	help
-	  When a multi-page allocation is done without __GFP_COMP,
-	  hardened usercopy will reject attempts to copy it. There are,
-	  however, several cases of this in the kernel that have not all
-	  been removed. This config is intended to be used only while
-	  trying to find such users.
-
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-- 
2.17.1


-- 
Kees Cook
