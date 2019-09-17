Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC73C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E012171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSTtPb7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfIQSA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:00:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45602 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQSA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:00:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so2389532pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sXjjsm5znrizNHN+S4tybEVFUykFG947oIL0vbwj7ww=;
        b=KSTtPb7yPp7+6bMWRzmFh9ybufPwqrqGo5klCO5bdikD8DaokAAoFZnFhW6pRiZjMA
         sZAeSQs7AQec3qfU1Own1LuDHbdO57fOkdt8Z9vtBF/5fmpfi9cztqUHovIQt936wqgK
         a0v8eNjwQd/Uu7iWon195bZDjNwd/5KK3LNFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sXjjsm5znrizNHN+S4tybEVFUykFG947oIL0vbwj7ww=;
        b=cS8ST/4oiRsOsaBzVk4DKMkfc/QhejHXybFgkrvWzIdU6fOPXWeJIu4V/dT/H1NuRA
         QYqEOv6zP8hq+X8MLL6nJP+bHUhcsgEsn6pVdfE0OMbhdzgzIAaFtvQirZjPcA6op1Nf
         d0IIF2XsApGeKRAG1VDTrX94AUi+vpC8Ul8RfIZI35fRe/Au5kt4Bu/9uBtCDurXXSWu
         4gkGU/5J7bC/UFNK0agUEAajjqIONDEMdQTYRsbsl+QPCCrLOCwozFOEB4zFDKMcimkP
         7Gkg2aHImdjyaTY2PxM/gYd3ohbXnpgnbu1qH/Juu+vp1usdYWuVA0mQQZuwkbUk6Mt7
         7GJA==
X-Gm-Message-State: APjAAAVzkHFp9QEh0//5ajtQA2DhuYoSQL1pJt3/2/GoVZH4VREDq6Kn
        8ZQsjWBoBNmVJgE17Y8BF5csNw==
X-Google-Smtp-Source: APXvYqx3aQLVz4R2dWCY8Vj4zkB5eq9Rt3t3PhK4/b8n3qg00toWu6wk8uJ8OztKZu+bAcl6Y/WJ2w==
X-Received: by 2002:a62:b416:: with SMTP id h22mr5425622pfn.180.1568743226918;
        Tue, 17 Sep 2019 11:00:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm5428016pfd.116.2019.09.17.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:00:26 -0700 (PDT)
Date:   Tue, 17 Sep 2019 11:00:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] usercopy: Avoid HIGHMEM pfn warning
Message-ID: <201909171056.7F2FFD17@keescook>
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

The check is from arch/x86/mm/physaddr.c:

	VIRTUAL_BUG_ON((phys_addr >> PAGE_SHIFT) > max_low_pfn);

Due to the kmap() in fs/exec.c:

		kaddr = kmap(kmapped_page);
	...
	if (copy_from_user(kaddr+offset, str, bytes_to_copy)) ...

Now we can fetch the correct page to avoid the pfn check. In both cases,
hardened usercopy will need to walk the page-span checker (if enabled)
to do sanity checking.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: move back to RFC solution using kmap_to_page()
v1: https://lore.kernel.org/lkml/201909161431.E69B29A0@keescook/
---
 mm/usercopy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 98e924864554..660717a1ea5c 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -227,7 +228,12 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
-	page = virt_to_head_page(ptr);
+	/*
+	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
+	 * highmem page or fallback to virt_to_page(). The following
+	 * is effectively a highmem-aware virt_to_head_page().
+	 */
+	page = compound_head(kmap_to_page((void *)ptr));
 
 	if (PageSlab(page)) {
 		/* Check slab allocator for flags and size. */
-- 
2.17.1


-- 
Kees Cook
