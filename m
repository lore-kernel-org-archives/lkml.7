Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4D820835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKZSoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:44:14 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45389 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfKZSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:44:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TjA8VpP_1574793844;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TjA8VpP_1574793844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Nov 2019 02:44:10 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     songliubraving@fb.com, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: khugepaged: add trace status description for SCAN_PAGE_HAS_PRIVATE
Date:   Wed, 27 Nov 2019 02:44:04 +0800
Message-Id: <1574793844-2914-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem)
FS") introduced a new khugepaged scan result: SCAN_PAGE_HAS_PRIVATE, but
the corresponding description for trace events were not added.

Cc: Song Liu <songliubraving@fb.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: *Adopted the comments from Anshuman Khandual

 include/trace/events/huge_memory.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index dd4db33..d82a0f4 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -31,7 +31,8 @@
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
-	EMe(SCAN_TRUNCATED,		"truncated")			\
+	EM( SCAN_TRUNCATED,		"truncated")			\
+	EMe(SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
 
 #undef EM
 #undef EMe
-- 
1.8.3.1

