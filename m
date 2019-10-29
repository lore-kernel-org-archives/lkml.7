Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F77CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6321734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfJ2VZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:25:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:8964 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2VZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:25:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 14:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="190074804"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 29 Oct 2019 14:25:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Oct 2019 23:25:13 +0200
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] mm/khugepaged: Fix might_sleep() warn with CONFIG_HIGHPTE=y
Date:   Tue, 29 Oct 2019 23:25:13 +0200
Message-Id: <20191029212513.23566-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029140209.e70385637d3617ad43869f31@linux-foundation.org>
References: <20191029140209.e70385637d3617ad43869f31@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

I got some khugepaged spew on a 32bit x86:

[  217.490026] BUG: sleeping function called from invalid context at include/linux/mmu_notifier.h:346
[  217.492826] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25, name: khugepaged
[  217.495589] INFO: lockdep is turned off.
[  217.498371] CPU: 1 PID: 25 Comm: khugepaged Not tainted 5.4.0-rc5-elk+ #206
[  217.501233] Hardware name: System manufacturer P5Q-EM/P5Q-EM, BIOS 2203    07/08/2009
[  217.501697] Call Trace:
[  217.501697]  dump_stack+0x66/0x8e
[  217.501697]  ___might_sleep.cold.96+0x95/0xa6
[  217.501697]  __might_sleep+0x2e/0x80
[  217.501697]  collapse_huge_page.isra.51+0x5ac/0x1360
[  217.501697]  ? __alloc_pages_nodemask+0xec/0xf80
[  217.501697]  ? __alloc_pages_nodemask+0x191/0xf80
[  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
[  217.501697]  khugepaged+0x9a9/0x20f0
[  217.501697]  ? _raw_spin_unlock+0x21/0x30
[  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
[  217.501697]  ? wait_woken+0xa0/0xa0
[  217.501697]  kthread+0xf5/0x110
[  217.501697]  ? collapse_pte_mapped_thp+0x3b0/0x3b0
[  217.501697]  ? kthread_create_worker_on_cpu+0x20/0x20
[  217.501697]  ret_from_fork+0x2e/0x38

Looks like it's due to CONFIG_HIGHPTE=y pte_offset_map()->kmap_atomic()
vs. mmu_notifier_invalidate_range_start(). Let's do the naive approach
and just reorder the two operations.

Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 mm/khugepaged.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..f05d27b7183d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1028,12 +1028,13 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	anon_vma_lock_write(vma->anon_vma);
 
-	pte = pte_offset_map(pmd, address);
-	pte_ptl = pte_lockptr(mm, pmd);
-
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
 				address, address + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
+
+	pte = pte_offset_map(pmd, address);
+	pte_ptl = pte_lockptr(mm, pmd);
+
 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
 	/*
 	 * After this gup_fast can't run anymore. This also removes
-- 
2.23.0

