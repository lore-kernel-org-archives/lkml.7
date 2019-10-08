Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A83ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CDC2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="CHMVWjyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfJHJPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:15:24 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:46120 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:15:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 79BE83F787;
        Tue,  8 Oct 2019 11:15:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="CHMVWjyy";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COAn5xUjmjkU; Tue,  8 Oct 2019 11:15:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1B41D3F59D;
        Tue,  8 Oct 2019 11:15:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A16BB3605DC;
        Tue,  8 Oct 2019 11:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570526117; bh=cWWLN8IyL/PIrg0tjEE8pDhLTEss1yQM1iEt6Room1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHMVWjyymcO57wjd2bv9bPjkIzsm7+YRzfsVkGqFCn3rOzHnWRNa1hy3ECnnK/S56
         fIEu8ZxmY4ivhNnsGEe+GL4Qi+WuSePxGOKG2Yl+v0a6LMcMBoMgbKzWpo+tnkrFwe
         ehwinB/VzkQvGI3zXl5wxaUvKKFPOa7iLymr7dfc=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a pmd_entry is present
Date:   Tue,  8 Oct 2019 11:15:02 +0200
Message-Id: <20191008091508.2682-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008091508.2682-1-thomas_os@shipmail.org>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The pagewalk code was unconditionally splitting transhuge pmds when a
pte_entry was present. However ideally we'd want to handle transhuge pmds
in the pmd_entry function and ptes in pte_entry function. So don't split
huge pmds when there is a pmd_entry function present, but let the callback
take care of it if necessary.

In order to make sure a virtual address range is handled by one and only
one callback, and since pmd entries may be unstable, we introduce a
pmd_entry return code that tells the walk code to continue processing this
pmd entry rather than to move on. Since caller-defined positive return
codes (up to 2) are used by current callers, use a high value that allows a
large range of positive caller-defined return codes for future users.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/pagewalk.h |  8 ++++++++
 mm/pagewalk.c            | 28 +++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index bddd9759bab9..c4a013eb445d 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -4,6 +4,11 @@
 
 #include <linux/mm.h>
 
+/* Highest positive pmd_entry caller-specific return value */
+#define PAGE_WALK_CALLER_MAX     (INT_MAX / 2)
+/* The handler did not handle the entry. Fall back to the next level */
+#define PAGE_WALK_FALLBACK       (PAGE_WALK_CALLER_MAX + 1)
+
 struct mm_walk;
 
 /**
@@ -16,6 +21,9 @@ struct mm_walk;
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
+ *                      If the handler did not handle the PMD, or split the
+ *                      PMD and wants it handled by the PTE handler, it
+ *                      should return PAGE_WALK_FALLBACK.
  * @pte_entry:		if set, called for each non-empty PTE (4th-level) entry
  * @pte_hole:		if set, called for each hole at all levels
  * @hugetlb_entry:	if set, called for each hugetlb entry
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 83c0b78363b4..f844c2a2aa60 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -50,10 +50,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 * This implies that each ->pmd_entry() handler
 		 * needs to know about pmd_trans_huge() pmds
 		 */
-		if (ops->pmd_entry)
+		if (ops->pmd_entry) {
 			err = ops->pmd_entry(pmd, addr, next, walk);
-		if (err)
-			break;
+			if (!err)
+				continue;
+			else if (err <= PAGE_WALK_CALLER_MAX)
+				break;
+			WARN_ON(err != PAGE_WALK_FALLBACK);
+			err = 0;
+			if (pmd_trans_unstable(pmd))
+				goto again;
+			/* Fall through */
+		}
 
 		/*
 		 * Check this here so we only break down trans_huge
@@ -61,8 +69,8 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 */
 		if (!ops->pte_entry)
 			continue;
-
-		split_huge_pmd(walk->vma, pmd, addr);
+		if (!ops->pmd_entry)
+			split_huge_pmd(walk->vma, pmd, addr);
 		if (pmd_trans_unstable(pmd))
 			goto again;
 		err = walk_pte_range(pmd, addr, next, walk);
@@ -281,11 +289,17 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  *
  *  - 0  : succeeded to handle the current entry, and if you don't reach the
  *         end address yet, continue to walk.
- *  - >0 : succeeded to handle the current entry, and return to the caller
- *         with caller specific value.
+ *  - >0, and <= PAGE_WALK_CALLER_MAX : succeeded to handle the current entry,
+ *         and return to the caller with caller specific value.
  *  - <0 : failed to handle the current entry, and return to the caller
  *         with error code.
  *
+ * For pmd_entry(), a value <= PAGE_WALK_CALLER_MAX indicates that the entry
+ * was handled by the callback. PAGE_WALK_FALLBACK indicates that the entry
+ * could not be handled by the callback and should be re-checked. If the
+ * callback needs the entry to be handled by the next level, it should
+ * split the entry and then return PAGE_WALK_FALLBACK.
+ *
  * Before starting to walk page table, some callers want to check whether
  * they really want to walk over the current vma, typically by checking
  * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
-- 
2.21.0

