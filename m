Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC2C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909F020679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329341;
	bh=Q3urYcDEe66IuY8WV/UjTgw2Qy8LfG2AzF1wj1n+t0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EYvHgKrXu4r11GQbks3efI0axR3pKhbXVA6n5iRqy580dMU5BVqoL7+cEKbO9x7hl
	 ZSGIcAtyHBkCy6U25i2HPf1+6efId8PuUmhJnlOxq7G3+M6y3O7x7oIlrfbAt/ryl7
	 lq5SNhA0UeTsYi6XmozrVsKIoNNyOzt1dCGPz1iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfD0BmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfD0BmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0F1208CB;
        Sat, 27 Apr 2019 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329337;
        bh=Q3urYcDEe66IuY8WV/UjTgw2Qy8LfG2AzF1wj1n+t0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waqk+8ggI3L5mIr+UtL3h9NfTyBNP670LtQBT/SPaVLGPl6zLtkP3QR+LhQTgYHPO
         WMsi/5KHPR1Z+NTKdtdY39y0vG0M4upRuqQiq4bHMA1L9dXK2tHIEQJyloR9J9OaYd
         GrCKV0/tLTIO0faZc2KjC//VYTww5PSzwuzdMUlI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 51/53] mm: make page ref count overflow check tighter and more explicit
Date:   Fri, 26 Apr 2019 21:40:48 -0400
Message-Id: <20190427014051.7522-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit f958d7b528b1b40c44cfda5eabe2d82760d868c3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e899460f1bc5..9965704813dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -915,6 +915,10 @@ static inline bool is_device_public_page(const struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+/* 127: arbitrary random number, small enough to assemble well */
+#define page_ref_zero_or_close_to_overflow(page) \
+	((unsigned int) page_ref_count(page) + 127u <= 127u)
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
@@ -922,7 +926,7 @@ static inline void get_page(struct page *page)
 	 * Getting a normal page or the head of a compound page
 	 * requires to already have an elevated page->_refcount.
 	 */
-	VM_BUG_ON_PAGE(page_ref_count(page) <= 0, page);
+	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
 	page_ref_inc(page);
 }
 
-- 
2.19.1

