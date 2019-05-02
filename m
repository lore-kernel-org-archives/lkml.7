Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F3208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810662;
	bh=9VusDEM0Dk+CvbhfFruOjQti9yM7gvFuK8A5wTVuoSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t20LSmngXfXEdAFKPL8A+8cka62zF51tl+nDJW45s7OjongWW6S5IgT632Lnqi722
	 WRC+H/Nog1SNAiAv76jlNtGfIM30wkaNJnOb2wdUslHfUxNiCL46GfVBfAGdZVqWbV
	 8p0L9lgV7taOTiQ9n1qlyLTWj0wO2v2nwV1aAepM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfEBPYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfEBPYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:24:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A26217D7;
        Thu,  2 May 2019 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810657;
        bh=9VusDEM0Dk+CvbhfFruOjQti9yM7gvFuK8A5wTVuoSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQBa2vpcyfeWTXFfuR9sOX7t1M3e/moZIEeZ748V0KHo+5E5qs4rzz7wFB+TTF1vs
         3LUOn3iIA8JYcIEyzMHU4Fc5hp6JSB4ZIuHSN5AmdOvo464G2QJDctHxFm43GQOjUV
         BXZ2YPjPTIWV4oK26jIBYkJxSMF2Uu6qnjxRYBP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 04/49] mm: make page ref count overflow check tighter and more explicit
Date:   Thu,  2 May 2019 17:20:41 +0200
Message-Id: <20190502143324.526640348@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
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
@@ -824,6 +824,10 @@ static inline bool is_device_public_page
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
 
 
+/* 127: arbitrary random number, small enough to assemble well */
+#define page_ref_zero_or_close_to_overflow(page) \
+	((unsigned int) page_ref_count(page) + 127u <= 127u)
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
@@ -831,7 +835,7 @@ static inline void get_page(struct page
 	 * Getting a normal page or the head of a compound page
 	 * requires to already have an elevated page->_refcount.
 	 */
-	VM_BUG_ON_PAGE(page_ref_count(page) <= 0, page);
+	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
 	page_ref_inc(page);
 }
 


