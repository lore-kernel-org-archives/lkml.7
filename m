Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105D204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811940;
	bh=oLrJ4LmSz7pDcdhOyRVpFHi65SBRmVoqaJ3TtCMVh28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/BaUiwmqWQjY9lXox8SU/lTldMbOm3TuIDjLRQoH+GfnouA1Rwop8VSd/MgVT90M
	 qKghgLjyGK16rT+kOgNWKKUOsIYFRwjM0V39CBfytfoQkV6aAK7i0/Hd8Xiu4IGHex
	 4spuJCx/sQMmlTbLYVzuAptPFUk4Y3aeDEYRWQ1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEBPpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfEBPZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:25:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41FA214DA;
        Thu,  2 May 2019 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810738;
        bh=oLrJ4LmSz7pDcdhOyRVpFHi65SBRmVoqaJ3TtCMVh28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Sn4QVa8lCPENn8qCkDUUSWxQvdV7rEh6PjVCduAiWngss3QismKG56pko5ZXiutm
         U5AJdES5fOIJmh15VbKqQDc6ontO6ecrd2Q5d06dEvH4jcasZCgHWj5D92I5NN753o
         XzuzVUYTC9zN6AqxteD2xOd1pWi3+zbqeWhY0QUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 03/72] mm: make page ref count overflow check tighter and more explicit
Date:   Thu,  2 May 2019 17:20:25 +0200
Message-Id: <20190502143333.783252966@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f958d7b528b1b40c44cfda5eabe2d82760d868c3 upstream.

We have a VM_BUG_ON() to check that the page reference count doesn't
underflow (or get close to overflow) by checking the sign of the count.

That's all fine, but we actually want to allow people to use a "get page
ref unless it's already very high" helper function, and we want that one
to use the sign of the page ref (without triggering this VM_BUG_ON).

Change the VM_BUG_ON to only check for small underflows (or _very_ close
to overflowing), and ignore overflows which have strayed into negative
territory.

Acked-by: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mm.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -915,6 +915,10 @@ static inline bool is_device_public_page
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+/* 127: arbitrary random number, small enough to assemble well */
+#define page_ref_zero_or_close_to_overflow(page) \
+	((unsigned int) page_ref_count(page) + 127u <= 127u)
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
@@ -922,7 +926,7 @@ static inline void get_page(struct page
 	 * Getting a normal page or the head of a compound page
 	 * requires to already have an elevated page->_refcount.
 	 */
-	VM_BUG_ON_PAGE(page_ref_count(page) <= 0, page);
+	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
 	page_ref_inc(page);
 }
 


