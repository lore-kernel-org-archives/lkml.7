Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD94420B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFGJNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFGJNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:13:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCB46346;
        Fri,  7 Jun 2019 02:13:16 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CDA23F96A;
        Fri,  7 Jun 2019 02:13:13 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 2/2] arm64/mm: Refactor __do_page_fault()
Date:   Fri,  7 Jun 2019 14:43:06 +0530
Message-Id: <1559898786-28530-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559898786-28530-1-git-send-email-anshuman.khandual@arm.com>
References: <1559898786-28530-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__do_page_fault() is over complicated with multiple goto statements. This
cleans up the code flow and while there drops local variable vm_fault_t.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/arm64/mm/fault.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 95cac4a..235b7c0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -397,37 +397,29 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags)
 {
-	struct vm_area_struct *vma;
-	vm_fault_t fault;
+	struct vm_area_struct *vma = find_vma(mm, addr);
 
-	vma = find_vma(mm, addr);
-	fault = VM_FAULT_BADMAP;
 	if (unlikely(!vma))
-		goto out;
-	if (unlikely(vma->vm_start > addr))
-		goto check_stack;
+		return VM_FAULT_BADMAP;
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so we can handle
 	 * it.
 	 */
-good_area:
+	if (unlikely(vma->vm_start > addr)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			return VM_FAULT_BADMAP;
+		if (expand_stack(vma, addr))
+			return VM_FAULT_BADMAP;
+	}
+
 	/*
 	 * Check that the permissions on the VMA allow for the fault which
 	 * occurred.
 	 */
-	if (!(vma->vm_flags & vm_flags)) {
-		fault = VM_FAULT_BADACCESS;
-		goto out;
-	}
-
+	if (!(vma->vm_flags & vm_flags))
+		return VM_FAULT_BADACCESS;
 	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
-
-check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
-		goto good_area;
-out:
-	return fault;
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
-- 
2.7.4

