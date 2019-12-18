Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B21C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEF7227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLRQZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:25:05 -0500
Received: from foss.arm.com ([217.140.110.172]:52274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfLRQZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:25:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8BA31B;
        Wed, 18 Dec 2019 08:25:02 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C08C3F719;
        Wed, 18 Dec 2019 08:25:00 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v17 13/23] mm: pagewalk: Don't lock PTEs for walk_page_range_novma()
Date:   Wed, 18 Dec 2019 16:23:52 +0000
Message-Id: <20191218162402.45610-14-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218162402.45610-1-steven.price@arm.com>
References: <20191218162402.45610-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range_novma() can be used to walk page tables or the kernel or
for firmware. These page tables may contain entries that are not backed
by a struct page and so it isn't (in general) possible to take the PTE
lock for the pte_entry() callback. So update walk_pte_range() to only
take the lock when no_vma==false by splitting out the inner loop to a
separate function and add a comment explaining the difference to
walk_page_range_novma().

Signed-off-by: Steven Price <steven.price@arm.com>
---
 mm/pagewalk.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d5773465f6da..4b5ee92ba079 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -4,15 +4,12 @@
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
 
-static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
-			  struct mm_walk *walk)
+static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
 {
-	pte_t *pte;
-	int err = 0;
 	const struct mm_walk_ops *ops = walk->ops;
-	spinlock_t *ptl;
+	int err = 0;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (;;) {
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
@@ -22,8 +19,26 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			break;
 		pte++;
 	}
+	return err;
+}
+
+static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			  struct mm_walk *walk)
+{
+	pte_t *pte;
+	int err = 0;
+	spinlock_t *ptl;
+
+	if (walk->no_vma) {
+		pte = pte_offset_map(pmd, addr);
+		err = walk_pte_range_inner(pte, addr, end, walk);
+		pte_unmap(pte);
+	} else {
+		pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		err = walk_pte_range_inner(pte, addr, end, walk);
+		pte_unmap_unlock(pte, ptl);
+	}
 
-	pte_unmap_unlock(pte, ptl);
 	return err;
 }
 
@@ -394,6 +409,12 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
+/*
+ * Similar to walk_page_range() but can walk any page tables even if they are
+ * not backed by VMAs. Because 'unusual' entries may be walked this function
+ * will also not lock the PTEs for the pte_entry() callback. This is useful for
+ * walking the kernel pages tables or page tables for firmware.
+ */
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  void *private)
-- 
2.20.1

