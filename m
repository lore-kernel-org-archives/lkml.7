Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91782C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8622173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tiqcCWk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfD3LRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:17:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:17:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBHIMt1346785
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:17:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBHIMt1346785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623039;
        bh=U0dRxSN+YqY2hUrN8UV7cxDakgiQX/5QEsi+3wBp5Ac=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tiqcCWk5SIYF+VnGYPEiPHdNI39LtMv56xQyq5Y2X6UdgD1kg0BCZO4tcHoiIiTXA
         fWOSsenbHhzL4c5i5xtAZU2+MXs0A0ZuvEvoH3vazLs/6eKGPBLj0d7KW1ZCwaRrZd
         aNmk+RT6/gm54+hzu5io2W7oYxO05xcKWDw1ewxzz3XMeetEhaC+00QTddtVuU9F1C
         Ad6XbFEy4Y4SPhO3W2rH/O/jNPEgkfSLyw6oVjT/LSAt4qxIf/Q42mru3qWCEgkVm6
         6W2V9HNHs62WG7MGisd+ZIbG7c4wecW26+0KncG3ekN+7sQ2IXRlpEYOrY5dfZXpVs
         fE6ufzDIzGBDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBHILM1346780;
        Tue, 30 Apr 2019 04:17:18 -0700
Date:   Tue, 30 Apr 2019 04:17:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-d97080ebed7811a53c931032a284166ee46b9565@git.kernel.org>
Cc:     bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        rick.p.edgecombe@intel.com, peterz@infradead.org, mingo@kernel.org,
        akpm@linux-foundation.org, will.deacon@arm.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, deneen.t.dock@intel.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, riel@surriel.com,
        kristen@linux.intel.com, linux_dti@icloud.com,
        torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        kernel-hardening@lists.openwall.com
Reply-To: riel@surriel.com, kristen@linux.intel.com, linux_dti@icloud.com,
          namit@vmware.com, kernel-hardening@lists.openwall.com,
          dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
          mingo@kernel.org, akpm@linux-foundation.org,
          peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com, rick.p.edgecombe@intel.com,
          linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
          deneen.t.dock@intel.com, will.deacon@arm.com, luto@kernel.org
In-Reply-To: <20190426001143.4983-5-namit@vmware.com>
References: <20190426001143.4983-5-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Save debug registers when loading a temporary
 mm
Git-Commit-ID: d97080ebed7811a53c931032a284166ee46b9565
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d97080ebed7811a53c931032a284166ee46b9565
Gitweb:     https://git.kernel.org/tip/d97080ebed7811a53c931032a284166ee46b9565
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:24 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:50 +0200

x86/mm: Save debug registers when loading a temporary mm

Prevent user watchpoints from mistakenly firing while the temporary mm
is being used. As the addresses of the temporary mm might overlap those
of the user-process, this is necessary to prevent wrong signals or worse
things from happening.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-5-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
