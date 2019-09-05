Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECBE2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfIECVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:21:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730447AbfIECVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:21:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C4D95E9A6A9F53753EB;
        Thu,  5 Sep 2019 10:21:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 10:21:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>, <vbabka@suse.cz>
CC:     <mhocko@kernel.org>, <zhongjiang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm: Unsigned 'nr_pages' always larger than zero
Date:   Thu, 5 Sep 2019 10:17:51 +0800
Message-ID: <1567649871-60594-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages'
compare with zero. And __gup_longterm_locked pass an long local variant
'rc' to check_and_migrate_cma_pages. Hence it is nicer to change the
parameter to long to fix the issue.

Fixes: 932f4a630a69 ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTERM")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 mm/gup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 23a9f9c..ee0b71f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1433,13 +1433,13 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					struct mm_struct *mm,
 					unsigned long start,
-					unsigned long nr_pages,
+					long nr_pages,
 					struct page **pages,
 					struct vm_area_struct **vmas,
 					unsigned int gup_flags)
 {
-	unsigned long i;
-	unsigned long step;
+	long i;
+	long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
@@ -1520,7 +1520,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					struct mm_struct *mm,
 					unsigned long start,
-					unsigned long nr_pages,
+					long nr_pages,
 					struct page **pages,
 					struct vm_area_struct **vmas,
 					unsigned int gup_flags)
-- 
1.7.12.4

