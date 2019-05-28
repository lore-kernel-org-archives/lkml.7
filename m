Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45365C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F2820883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfE1Mpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:45:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56886 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727195AbfE1Mpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:45:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TStMl0v_1559047475;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TStMl0v_1559047475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 May 2019 20:44:42 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: thp: remove THP destructor
Date:   Tue, 28 May 2019 20:44:23 +0800
Message-Id: <1559047464-59838-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The THP destructor is used to delete THP from per node deferred split
queue, now the operation is moved out of it, so the destructor is not
used anymore, remove it.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/mm.h | 3 ---
 mm/huge_memory.c   | 6 ------
 mm/page_alloc.c    | 3 ---
 3 files changed, 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834a..e543984 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -740,9 +740,6 @@ enum compound_dtor_id {
 #ifdef CONFIG_HUGETLB_PAGE
 	HUGETLB_PAGE_DTOR,
 #endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	TRANSHUGE_PAGE_DTOR,
-#endif
 	NR_COMPOUND_DTORS,
 };
 extern compound_page_dtor * const compound_page_dtors[];
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0b9cfe1..91a709e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -503,7 +503,6 @@ void prep_transhuge_page(struct page *page)
 		INIT_LIST_HEAD(page_deferred_list(page));
 	else
 		INIT_LIST_HEAD(page_memcg_deferred_list(page));
-	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
 static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
@@ -2837,11 +2836,6 @@ void del_thp_from_deferred_split_queue(struct page *page)
 	}
 }
 
-void free_transhuge_page(struct page *page)
-{
-	free_compound_page(page);
-}
-
 void deferred_split_huge_page(struct page *page)
 {
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b13d39..7d39b91 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -261,9 +261,6 @@ bool pm_suspended_storage(void)
 #ifdef CONFIG_HUGETLB_PAGE
 	free_huge_page,
 #endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	free_transhuge_page,
-#endif
 };
 
 int min_free_kbytes = 1024;
-- 
1.8.3.1

