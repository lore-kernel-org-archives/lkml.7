Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D29C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9186D2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139176;
	bh=cu/+J9DGJzA2jYc9Cv3+n/UaEuOmuvjm61zSjwZiMnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GD87LhzEkDzbV9ydckKyNFJd9f5+gdDAyrYBf1WWn/OQyDzYGHIRAMoLbBGEcU2Xw
	 1UpV+EM6f+FI+7EFXhGP0vCLT0Y3eKmJOFpPvirqR8BokF68vHgynuJ80s8ZWQfE8R
	 ufz7Q4LyYzO3JyPic4W/ww83oY0v0PWxGlqa/biI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfDARTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbfDARTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DA2218FE;
        Mon,  1 Apr 2019 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139172;
        bh=cu/+J9DGJzA2jYc9Cv3+n/UaEuOmuvjm61zSjwZiMnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b84RQdEprIKgg8X4haFo0zqlfI6KpKG/dPoj22keLbPbtgw3GcuAGcYD9K/+ZxOkU
         DRxPB8PIPzeeP9npJ0EKUmeilL+BLNpSkVuc1izgyvTzfpM3GlwSFGFaCAgufLTC6l
         lwDfpv8fHj9TxSn+sie6n4P8MA89d+3GE628jdBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Shi <yang.shi@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rafael Aquini <aquini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 113/134] mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified
Date:   Mon,  1 Apr 2019 19:02:29 +0200
Message-Id: <20190401170054.785055116@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Shi <yang.shi@linux.alibaba.com>

commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 upstream.

When MPOL_MF_STRICT was specified and an existing page was already on a
node that does not follow the policy, mbind() should return -EIO.  But
commit 6f4576e3687b ("mempolicy: apply page table walker on
queue_pages_range()") broke the rule.

And commit c8633798497c ("mm: mempolicy: mbind and migrate_pages support
thp migration") didn't return the correct value for THP mbind() too.

If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it
reaches queue_pages_to_pte_range() or queue_pages_pmd() to check if an
existing page was already on a node that does not follow the policy.
And, non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
MPOL_MF_MOVE_ALL was specified.

Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c

[akpm@linux-foundation.org: tweak code comment]
Link: http://lkml.kernel.org/r/1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com
Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Acked-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mempolicy.c |   40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -428,6 +428,13 @@ static inline bool queue_pages_required(
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
+/*
+ * queue_pages_pmd() has three possible return values:
+ * 1 - pages are placed on the right node or queued successfully.
+ * 0 - THP was split.
+ * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
+ *        page was already on a node that does not follow the policy.
+ */
 static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
@@ -437,7 +444,7 @@ static int queue_pages_pmd(pmd_t *pmd, s
 	unsigned long flags;
 
 	if (unlikely(is_pmd_migration_entry(*pmd))) {
-		ret = 1;
+		ret = -EIO;
 		goto unlock;
 	}
 	page = pmd_page(*pmd);
@@ -454,8 +461,15 @@ static int queue_pages_pmd(pmd_t *pmd, s
 	ret = 1;
 	flags = qp->flags;
 	/* go to thp migration */
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		if (!vma_migratable(walk->vma)) {
+			ret = -EIO;
+			goto unlock;
+		}
+
 		migrate_page_add(page, qp->pagelist, flags);
+	} else
+		ret = -EIO;
 unlock:
 	spin_unlock(ptl);
 out:
@@ -480,8 +494,10 @@ static int queue_pages_pte_range(pmd_t *
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
-		if (ret)
+		if (ret > 0)
 			return 0;
+		else if (ret < 0)
+			return ret;
 	}
 
 	if (pmd_trans_unstable(pmd))
@@ -502,11 +518,16 @@ static int queue_pages_pte_range(pmd_t *
 			continue;
 		if (!queue_pages_required(page, qp))
 			continue;
-		migrate_page_add(page, qp->pagelist, flags);
+		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+			if (!vma_migratable(vma))
+				break;
+			migrate_page_add(page, qp->pagelist, flags);
+		} else
+			break;
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
-	return 0;
+	return addr != end ? -EIO : 0;
 }
 
 static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
@@ -576,7 +597,12 @@ static int queue_pages_test_walk(unsigne
 	unsigned long endvma = vma->vm_end;
 	unsigned long flags = qp->flags;
 
-	if (!vma_migratable(vma))
+	/*
+	 * Need check MPOL_MF_STRICT to return -EIO if possible
+	 * regardless of vma_migratable
+	 */
+	if (!vma_migratable(vma) &&
+	    !(flags & MPOL_MF_STRICT))
 		return 1;
 
 	if (endvma > end)
@@ -603,7 +629,7 @@ static int queue_pages_test_walk(unsigne
 	}
 
 	/* queue pages from current vma */
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	if (flags & MPOL_MF_VALID)
 		return 0;
 	return 1;
 }


