Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA45214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfISCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:09:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:43868 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfISCJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:09:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 19:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="212066086"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2019 19:09:13 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/2] x86/mm: consolidate bad_area handling to the end
Date:   Thu, 19 Sep 2019 10:08:43 +0800
Message-Id: <20190919020844.27461-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 7 bad_area[_nosemaphore] error branch in
do_user_addr_fault().

Consolidate all these handling to the end to make the code a little
neat.

BTW, after doing so, function bad_area is not used any more. Remove it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/fault.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9ceacd1156db..9d18b73b5f77 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -933,12 +933,6 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
 
-static noinline void
-bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
-{
-	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
-}
-
 static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 		struct vm_area_struct *vma)
 {
@@ -1313,19 +1307,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(hw_error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC)))
-	{
-		bad_area_nosemaphore(regs, hw_error_code, address);
-		return;
-	}
+		goto bad_area_nosem;
 
 	/*
 	 * If we're in an interrupt, have no user context or are running
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
-	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, hw_error_code, address);
-		return;
-	}
+	if (unlikely(faulthandler_disabled() || !mm))
+		goto bad_area_nosem;
 
 	/*
 	 * It's safe to allow irq's after cr2 has been saved and the
@@ -1385,8 +1374,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, hw_error_code, address);
-			return;
+			goto bad_area_nosem;
 		}
 retry:
 		down_read(&mm->mmap_sem);
@@ -1400,20 +1388,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	vma = find_vma(mm, address);
-	if (unlikely(!vma)) {
-		bad_area(regs, hw_error_code, address);
-		return;
-	}
+	if (unlikely(!vma))
+		goto bad_area;
 	if (likely(vma->vm_start <= address))
 		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, hw_error_code, address);
-		return;
-	}
-	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, hw_error_code, address);
-		return;
-	}
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		goto bad_area;
+	if (unlikely(expand_stack(vma, address)))
+		goto bad_area;
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
@@ -1483,6 +1465,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	check_v8086_mode(regs, address, tsk);
+	return;
+
+bad_area:
+	up_read(&mm->mmap_sem);
+bad_area_nosem:
+	bad_area_nosemaphore(regs, hw_error_code, address);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
-- 
2.17.1

