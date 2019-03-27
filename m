Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6CF2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfC0M17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:27:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53812 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfC0M17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:27:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5C6374;
        Wed, 27 Mar 2019 05:27:58 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FD3C3F557;
        Wed, 27 Mar 2019 05:27:56 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hannes@cmpxchg.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        akpm@linux-foundation.org
Subject: [PATCH] mm/page-flags: Check enforce parameter in PF_ONLY_HEAD()
Date:   Wed, 27 Mar 2019 17:57:52 +0530
Message-Id: <1553689672-28343-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just check for enforce parameter in PF_ONLY_HEAD() wrapper before calling
VM_BUG_ON_PGFLAGS() for tail pages.

Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f8712a4b1a5..82539e287bc6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -229,7 +229,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 #define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)
 #define PF_HEAD(page, enforce)	PF_POISONED_CHECK(compound_head(page))
 #define PF_ONLY_HEAD(page, enforce) ({					\
-		VM_BUG_ON_PGFLAGS(PageTail(page), page);		\
+		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
 		PF_POISONED_CHECK(page); })
 #define PF_NO_TAIL(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
-- 
2.20.1

