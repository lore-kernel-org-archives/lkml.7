Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565822067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ2UP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:15:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:4073 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2UP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:15:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="283348320"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 29 Oct 2019 13:15:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Oct 2019 22:15:13 +0200
Date:   Tue, 29 Oct 2019 22:15:13 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org
Subject: khugepaged might_sleep() warn due to CONFIG_HIGHPTE=y
Message-ID: <20191029201513.GG1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Looks like it's due to CONFIG_HIGHPTE=y pte_offset_map()->kmap_atomic() vs.
mmu_notifier_invalidate_range_start().

My naive idea would be to just reorder those things, but not sure
if there's some magic ordering constraint here. At least the machine
still boots when I do it :)

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
Ville Syrjälä
Intel
