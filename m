Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440045AbfJXR2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:28:16 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:32805 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394016AbfJXR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:28:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tg58mS4_1571938066;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tg58mS4_1571938066)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 01:27:53 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map gone
Date:   Fri, 25 Oct 2019 01:27:46 +0800
Message-Id: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
the flag is never cleared until the THP is freed.  This result in
unbalanced state although it is not a big deal. 

Clear the flag when the last compound_mapcount is gone.  It should be
cleared when all the PTE maps are gone (become PMD mapped only) as well,
but this needs check all subpage's _mapcount every time any subpage's
rmap is removed, the overhead may be not worth.  The anonymous THP also
just clears PageDoubleMap flag when the last PMD map is gone.

Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
Hugh thought it is unnecessary to fix it completely due to the overhead
(https://lkml.org/lkml/2019/10/22/1011), but it sounds simple to achieve
the similar balance as anonymous THP.

 mm/rmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0c7b2a9..d17cbf3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1236,6 +1236,9 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+
+		/* The last PMD map is gone */
+		ClearPageDoubleMap(compound_head(page));
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			goto out;
-- 
1.8.3.1

