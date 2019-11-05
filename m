Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADEDC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A452B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbfKERDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:03:47 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57651 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730894AbfKERDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:03:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ThHjBtv_1572973417;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThHjBtv_1572973417)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Nov 2019 01:03:45 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: rmap: use VM_BUG_ON() in __page_check_anon_rmap()
Date:   Wed,  6 Nov 2019 01:03:36 +0800
Message-Id: <1572973416-18532-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __page_check_anon_rmap() just calls two BUG_ON()s protected by
CONFIG_DEBUG_VM, the #ifdef could be eliminated by using VM_BUG_ON().

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/rmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index d17cbf3..39178eb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1055,7 +1055,6 @@ static void __page_set_anon_rmap(struct page *page,
 static void __page_check_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-#ifdef CONFIG_DEBUG_VM
 	/*
 	 * The page's anon-rmap details (mapping and index) are guaranteed to
 	 * be set up correctly at this point.
@@ -1068,9 +1067,8 @@ static void __page_check_anon_rmap(struct page *page,
 	 * are initially only visible via the pagetables, and the pte is locked
 	 * over the call to page_add_new_anon_rmap.
 	 */
-	BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
-	BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));
-#endif
+	VM_BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
+	VM_BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));
 }
 
 /**
-- 
1.8.3.1

