Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F9C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3443627C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFCGmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:42:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfFCGmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:42:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EED715A2;
        Sun,  2 Jun 2019 23:42:06 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A4533F5AF;
        Sun,  2 Jun 2019 23:42:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH V2 2/4] arm64/mm: Drop task_struct argument from __do_page_fault()
Date:   Mon,  3 Jun 2019 12:11:23 +0530
Message-Id: <1559544085-7502-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task_struct argument is not getting used in __do_page_fault(). Hence
just drop it and use current or cuurent->mm instead where ever required.
This does not change any functionality.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index dc1cf32..da02678 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -395,8 +395,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags,
-			   struct task_struct *tsk)
+			   unsigned int mm_flags, unsigned long vm_flags)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -440,8 +439,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
 	const struct fault_info *inf;
-	struct task_struct *tsk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
@@ -449,9 +447,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	if (notify_page_fault(regs, esr))
 		return 0;
 
-	tsk = current;
-	mm  = tsk->mm;
-
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
@@ -510,7 +505,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk);
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
 	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault & VM_FAULT_RETRY) {
@@ -550,11 +545,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * that point.
 		 */
 		if (major) {
-			tsk->maj_flt++;
+			current->maj_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
 				      addr);
 		} else {
-			tsk->min_flt++;
+			current->min_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
 				      addr);
 		}
-- 
2.7.4

