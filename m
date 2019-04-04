Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C76C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAB220693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368955;
	bh=Y6q5uWmJqjzqEdywjipgNwO0vbLAPX/JdRS21f+zOYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yk2VFumHUrt1dihmLRYejFC6rvHRzKmHjVVitoATFpvvs2KxR52+UWm9SvOgQWmQ5
	 yOVrSzXkpojyrA9Ld7HnGrbbKBd/Qzs3YlnD9fHmXkUm6kE2pL0f8ebCPIteDmPjWQ
	 h8Q+UylhyvM0cHeesoSmjB0nM++ftshCMwfR1iyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfDDJJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfDDJJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B802054F;
        Thu,  4 Apr 2019 09:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368946;
        bh=Y6q5uWmJqjzqEdywjipgNwO0vbLAPX/JdRS21f+zOYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3luxSkK3uE8MXEQ/rjHM+js8NX+67XKsQSBZcdzUZWxSDkRMILeCLgjFC7KIyN1t
         3dpUMtJfwEhrrkWgMjGoDezyc5HOMi4L9vd2Xf2Uv/RTHcf9eQp6XBVtbooDw4LdoB
         2PUp71Madr1MTGn9O3+OXIxF0f20LaSyMi0thJPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 040/246] page_poison: play nicely with KASAN
Date:   Thu,  4 Apr 2019 10:45:40 +0200
Message-Id: <20190404084620.443265908@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4117992df66a26fa33908b4969e04801534baab1 ]

KASAN does not play well with the page poisoning (CONFIG_PAGE_POISONING).
It triggers false positives in the allocation path:

  BUG: KASAN: use-after-free in memchr_inv+0x2ea/0x330
  Read of size 8 at addr ffff88881f800000 by task swapper/0
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1+ #54
  Call Trace:
   dump_stack+0xe0/0x19a
   print_address_description.cold.2+0x9/0x28b
   kasan_report.cold.3+0x7a/0xb5
   __asan_report_load8_noabort+0x19/0x20
   memchr_inv+0x2ea/0x330
   kernel_poison_pages+0x103/0x3d5
   get_page_from_freelist+0x15e7/0x4d90

because KASAN has not yet unpoisoned the shadow page for allocation
before it checks memchr_inv() but only found a stale poison pattern.

Also, false positives in free path,

  BUG: KASAN: slab-out-of-bounds in kernel_poison_pages+0x29e/0x3d5
  Write of size 4096 at addr ffff8888112cc000 by task swapper/0/1
  CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1+ #55
  Call Trace:
   dump_stack+0xe0/0x19a
   print_address_description.cold.2+0x9/0x28b
   kasan_report.cold.3+0x7a/0xb5
   check_memory_region+0x22d/0x250
   memset+0x28/0x40
   kernel_poison_pages+0x29e/0x3d5
   __free_pages_ok+0x75f/0x13e0

due to KASAN adds poisoned redzones around slab objects, but the page
poisoning needs to poison the whole page.

Link: http://lkml.kernel.org/r/20190114233405.67843-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c  | 2 +-
 mm/page_poison.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 11dc3c0e8728..20dd3283bb1b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1945,8 +1945,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
-	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
+	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
 }
 
diff --git a/mm/page_poison.c b/mm/page_poison.c
index f0c15e9017c0..21d4f97cb49b 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -6,6 +6,7 @@
 #include <linux/page_ext.h>
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
+#include <linux/kasan.h>
 
 static bool want_page_poisoning __read_mostly;
 
@@ -40,7 +41,10 @@ static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
 
+	/* KASAN still think the page is in-use, so skip it. */
+	kasan_disable_current();
 	memset(addr, PAGE_POISON, PAGE_SIZE);
+	kasan_enable_current();
 	kunmap_atomic(addr);
 }
 
-- 
2.19.1



