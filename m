Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749602064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334706;
	bh=yi66KY97cAF0XSIlDC5TPtGaTMBs7kCAdK71Hz+5S+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=balnFAvSzx0aDLl39DuiSFYIGoZNia71Jm+sN6QrOaBryXWdyYEvRfzjZzJSka3HW
	 4uhCNn5uP2L0j3KyXzoSEriFHthcJtm9B2l0mN0eZfw24Uyd2KXO8ZnZVcfPYipEGZ
	 Ufx7Jt40TH5ZlZLIX2sYhRHKIxdoNpUnsR8C8GOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfCKUFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfCKT6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE9C214AF;
        Mon, 11 Mar 2019 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334294;
        bh=yi66KY97cAF0XSIlDC5TPtGaTMBs7kCAdK71Hz+5S+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLkLi8wpRxyaprOM6E5FwuyZ+oho7/efHWszerenOv34PPyrZcyIQU56SOms19GFn
         R9ZezUnuz/XfuMcpQCY6YCrh6PklgwOeIgWZ/5Y2ZVQawrYrXKgVndUPUIrhIZgfOg
         GTceR/rR1oVPUsYzXyktSb7AT71A7qM9TQYtGCJs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 39/44] mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
Date:   Mon, 11 Mar 2019 15:56:55 -0400
Message-Id: <20190311195700.138462-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 2c2ade81741c66082f8211f0b96cf509cc4c0218 ]

The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
number of references that we might need to create in the fastpath later,
the bump-allocation fastpath only has to modify the non-atomic bias value
that tracks the number of extra references we hold instead of the atomic
refcount. The maximum number of allocations we can serve (under the
assumption that no allocation is made with size 0) is nc->size, so that's
the bias used.

However, even when all memory in the allocation has been given away, a
reference to the page is still held; and in the `offset < 0` slowpath, the
page may be reused if everyone else has dropped their references.
This means that the necessary number of references is actually
`nc->size+1`.

Luckily, from a quick grep, it looks like the only path that can call
page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
requires CAP_NET_ADMIN in the init namespace and is only intended to be
used for kernel testing and fuzzing.

To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
`offset < 0` path, below the virt_to_page() call, and then repeatedly call
writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
with a vector consisting of 15 elements containing 1 byte each.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a9de1dbb9a6c..ef99971c13dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4532,11 +4532,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size - 1);
+		page_ref_add(page, size);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		nc->offset = size;
 	}
 
@@ -4552,10 +4552,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size);
+		set_page_count(page, size + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		offset = size - fragsz;
 	}
 
-- 
2.19.1

