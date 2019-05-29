Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04983C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDE02081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfE2Me5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:34:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45074 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Me4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F10780D;
        Wed, 29 May 2019 05:34:55 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DF103F59C;
        Wed, 29 May 2019 05:34:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from __do_page_fault()
Date:   Wed, 29 May 2019 18:04:45 +0530
Message-Id: <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__do_page_fault() is over complicated with multiple goto statements. This
cleans up code flow and while there drops the vm_fault_t argument.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com> 
Cc: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 170c71f..a53a30e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -397,37 +397,31 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
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
-	 * Ok, we have a good vm_area for this memory access, so we can handle
-	 * it.
+	 * Check if the VMA has got the required permssion with respect
+	 * to the access fault here.
 	 */
-good_area:
+	if (!(vma->vm_flags & vm_flags))
+		return VM_FAULT_BADACCESS;
+
 	/*
-	 * Check that the permissions on the VMA allow for the fault which
-	 * occurred.
+	 * There is a valid VMA for this access. But before proceeding
+	 * make sure that it has required flags if there is an attempt
+	 * to expand the stack downwards.
 	 */
-	if (!(vma->vm_flags & vm_flags)) {
-		fault = VM_FAULT_BADACCESS;
-		goto out;
-	}
+	if (unlikely(vma->vm_start > addr)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			return VM_FAULT_BADMAP;
 
+		if (expand_stack(vma, addr))
+			return VM_FAULT_BADMAP;
+	}
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

