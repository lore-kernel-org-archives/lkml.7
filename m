Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825DC20644
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGaD3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 23:29:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728444AbfGaD3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:29:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 712FA9259A5D6C9CF87A;
        Wed, 31 Jul 2019 11:29:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 31 Jul 2019 11:29:34 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] thp: update split_huge_page_pmd() commnet
Date:   Wed, 31 Jul 2019 11:34:06 +0800
Message-ID: <20190731033406.185285-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to 78ddc5347341 ("thp: rename split_huge_page_pmd() to
split_huge_pmd()"), update releated comment.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 2 +-
 include/asm-generic/pgtable.h         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b8ad14bb1170..cebd1acaddac 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1705,7 +1705,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 	/*
 	 * IF we try to do a HUGE PTE update after a withdraw is done.
 	 * we will find the below NULL. This happens when we do
-	 * split_huge_page_pmd
+	 * split_huge_pmd
 	 */
 	if (!hpte_slot_array)
 		return;
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..0e25f556a99b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1002,9 +1002,8 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
  * need this). If THP is not enabled, the pmd can't go away under the
  * code even if MADV_DONTNEED runs, but if THP is enabled we need to
  * run a pmd_trans_unstable before walking the ptes after
- * split_huge_page_pmd returns (because it may have run when the pmd
- * become null, but then a page fault can map in a THP and not a
- * regular page).
+ * split_huge_pmd returns (because it may have run when the pmd become
+ * null, but then a page fault can map in a THP and not a regular page).
  */
 static inline int pmd_trans_unstable(pmd_t *pmd)
 {
-- 
2.20.1

