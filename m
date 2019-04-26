Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA7C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2862084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDZHdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:33:41 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29121 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfDZHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:31:48 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 26 Apr 2019 00:31:44 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8042F412A4;
        Fri, 26 Apr 2019 00:31:45 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux_dti@icloud.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <akpm@linux-foundation.org>, <kernel-hardening@lists.openwall.com>,
        <linux-mm@kvack.org>, <will.deacon@arm.com>,
        <ard.biesheuvel@linaro.org>, <kristen@linux.intel.com>,
        <deneen.t.dock@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v5 04/23] x86/mm: Save debug registers when loading a temporary mm
Date:   Thu, 25 Apr 2019 17:11:24 -0700
Message-ID: <20190426001143.4983-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426001143.4983-1-namit@vmware.com>
References: <20190426001143.4983-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent user watchpoints from mistakenly firing while the temporary mm
is being used. As the addresses of the temporary mm might overlap those
of the user-process, this is necessary to prevent wrong signals or worse
things from happening.

Cc: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/mmu_context.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 24dc3b810970..93dff1963337 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+#include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -380,6 +381,21 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	lockdep_assert_irqs_disabled();
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
 	return temp_state;
 }
 
@@ -387,6 +403,13 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
 }
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
-- 
2.17.1

