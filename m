Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA70214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfHTNSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:18:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729677AbfHTNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:18:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0C75ABD0;
        Tue, 20 Aug 2019 13:18:38 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/4] mm, page_owner: handle THP splits correctly
Date:   Tue, 20 Aug 2019 15:18:25 +0200
Message-Id: <20190820131828.22684-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820131828.22684-1-vbabka@suse.cz>
References: <20190820131828.22684-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THP splitting path is missing the split_page_owner() call that split_page()
has. As a result, split THP pages are wrongly reported in the page_owner file
as order-9 pages. Furthermore when the former head page is freed, the remaining
former tail pages are not listed in the page_owner file at all. This patch
fixes that by adding the split_page_owner() call into __split_huge_page().

Fixes: a9627bc5e34e ("mm/page_owner: introduce split_page_owner and replace manual handling")
Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Cc: stable@vger.kernel.org
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 738065f765ab..de1f15969e27 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -32,6 +32,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/page_owner.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2516,6 +2517,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
+
+	split_page_owner(head, HPAGE_PMD_ORDER);
+
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
 		/* Additional pin to swap cache */
-- 
2.22.0

