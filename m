Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0835C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C52183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368123;
	bh=4w0y1qw+Glwe8NECzBGrrnGe0swyFf61ADnwidXutZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pPZ3P5npH+Mq97J2T9YbB2xfxD7jtUWPihc0BK4Lg+eO1yntCEOHgYHJuL09aAq3v
	 Fqt1YjR8Us2iJXswvQb7hnrTPV5r5nesL2DgMs4PFQb4hXsQV21gcGsC/yYcnBkD6X
	 JqVYyHj7zL0Njlfg+PB2z8KrVdQwr7TskDWZ+MAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfDDIzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbfDDIzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B7C217D4;
        Thu,  4 Apr 2019 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368118;
        bh=4w0y1qw+Glwe8NECzBGrrnGe0swyFf61ADnwidXutZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7DN/Md/2kVHZ2XdwAx/rjqc1C73tTFVp6rz4cF0kP2Y1KqsKIvP/Zw6RT+bnNIPb
         iTs6xfcD39JroJleKRL0v3O6mc3DZiydVIlAovjauqBkGPxLNh8VClLqHpRwh4eaU3
         A3usCKZuQYsNKkmFCM3Q7R06w2liHZO/opwuLZTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/121] page_poison: play nicely with KASAN
Date:   Thu,  4 Apr 2019 10:46:56 +0200
Message-Id: <20190404084546.877285284@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 40075c1946b3..923deb33bf34 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1764,8 +1764,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
-	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
+	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
 }
 
diff --git a/mm/page_poison.c b/mm/page_poison.c
index e83fd44867de..a7ba9e315a12 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -6,6 +6,7 @@
 #include <linux/page_ext.h>
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
+#include <linux/kasan.h>
 
 static bool want_page_poisoning __read_mostly;
 
@@ -34,7 +35,10 @@ static void poison_page(struct page *page)
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



