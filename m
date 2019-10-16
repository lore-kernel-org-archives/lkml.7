Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5787EFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE04207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264219;
	bh=Sa+6Pf0T69eMRUz9sXVo9A+EjgsvDu3rNexnocYZWFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z3aYnTUlY8rjys4UsI7keCEGsClPhgcFE1WA5yLk7OKbJxYkKgbKSdOHq51kwuaYy
	 RtnkFaHDPFFNP2IG/1wE3FNrUhy3KGWsgRN2jLP/VV+8dXKQ7CTK+wYG39GvMepPe/
	 LfDK5jk3JIokgGgNpW+/kHMB0P81dd1BDaJoTCY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395133AbfJPVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395090AbfJPVyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:54 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8464521925;
        Wed, 16 Oct 2019 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262893;
        bh=Sa+6Pf0T69eMRUz9sXVo9A+EjgsvDu3rNexnocYZWFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcADDCF7Uu/LVdhsodOEcs9btM9IKp/3fXIfZgjDe3nKlHdThIQz8zHUZ6VWkCnJV
         vZAWby1E9PPJHPNN1knKH8iQUwjeBqPMUjZ1XSQESZJZ1hB6WYoR3rG6qW4cEvpMPn
         tEUjkmVMEEPHuWPKo1Q8AelPF3Ti2fsaLivzmhys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.9 10/92] usercopy: Avoid HIGHMEM pfn warning
Date:   Wed, 16 Oct 2019 14:49:43 -0700
Message-Id: <20191016214806.748467068@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 314eed30ede02fa925990f535652254b5bad6b65 upstream.

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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/201909171056.7F2FFD17@keescook
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/usercopy.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <asm/sections.h>
 
@@ -217,7 +218,12 @@ static inline const char *check_heap_obj
 	if (!virt_addr_valid(ptr))
 		return NULL;
 
-	page = virt_to_head_page(ptr);
+	/*
+	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
+	 * highmem page or fallback to virt_to_page(). The following
+	 * is effectively a highmem-aware virt_to_head_page().
+	 */
+	page = compound_head(kmap_to_page((void *)ptr));
 
 	/* Check slab allocator for flags and size. */
 	if (PageSlab(page))


