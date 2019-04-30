Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E676C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499242080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ki/yNoV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfD3LRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:17:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:17:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBGavh1346716
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:16:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBGavh1346716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556622997;
        bh=PWl7pxRpmZ4dL+XaeosBXcqK53avqKxDFfAff4vSNNI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ki/yNoV24eKhYZHoKpgzCL+Ekh0ThWTqnnPdDYkVkzNcAZEGSOffwZ6FpMxMHMExr
         iDHhGzzmqSNDAvGXHXWdKg+v8r/NzVe36W//0lCAGjEDmAV7pvZRNSIM1AG5lem67p
         cnCZYW1qTSL08g7gwwbQIqB4kaoyupiahRQjTFL9im2GysVUp4Ma5MFjD0PuS9CGvp
         ZuJFkasAShtfS698HsdbY0shsyMsBJ0uWuLJ+Kx+qxWy5VMcuPTXx9CNNKbPPVFz5Q
         ux9XmTVVLPC9doEEzoEb2RCWzay3XmCF6VsFiH+jz6a8trtvvGIZYwGMQIWTwg6RYq
         LSo9P6jYP+nHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBGaGV1346710;
        Tue, 30 Apr 2019 04:16:36 -0700
Date:   Tue, 30 Apr 2019 04:16:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-cefa929c034eb5d9c15c50088235a0093a219687@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mhiramat@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, kernel-hardening@lists.openwall.com,
        dave.hansen@intel.com, kristen@linux.intel.com, riel@surriel.com,
        linux_dti@icloud.com, namit@vmware.com, ard.biesheuvel@linaro.org,
        luto@kernel.org, keescook@chromium.org, rick.p.edgecombe@intel.com,
        bp@alien8.de, akpm@linux-foundation.org, deneen.t.dock@intel.com
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          mhiramat@kernel.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dave.hansen@intel.com, kernel-hardening@lists.openwall.com,
          mingo@kernel.org, peterz@infradead.org, luto@kernel.org,
          ard.biesheuvel@linaro.org, namit@vmware.com,
          linux_dti@icloud.com, riel@surriel.com, kristen@linux.intel.com,
          akpm@linux-foundation.org, deneen.t.dock@intel.com, bp@alien8.de,
          rick.p.edgecombe@intel.com, keescook@chromium.org
In-Reply-To: <20190426001143.4983-4-namit@vmware.com>
References: <20190426001143.4983-4-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Introduce temporary mm structs
Git-Commit-ID: cefa929c034eb5d9c15c50088235a0093a219687
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

Commit-ID:  cefa929c034eb5d9c15c50088235a0093a219687
Gitweb:     https://git.kernel.org/tip/cefa929c034eb5d9c15c50088235a0093a219687
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Thu, 25 Apr 2019 17:11:23 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:50 +0200

x86/mm: Introduce temporary mm structs

Using a dedicated page-table for temporary PTEs prevents other cores
from using - even speculatively - these PTEs, thereby providing two
benefits:

(1) Security hardening: an attacker that gains kernel memory writing
    abilities cannot easily overwrite sensitive data.

(2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
    remote page-tables.

To do so a temporary mm_struct can be used. Mappings which are private
for this mm can be set in the userspace part of the address-space.
During the whole time in which the temporary mm is loaded, interrupts
must be disabled.

The first use-case for temporary mm struct, which will follow, is for
poking the kernel text.

[ Commit message was written by Nadav Amit ]

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-4-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mmu_context.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 19d18fae6ec6..24dc3b810970 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -356,4 +356,37 @@ static inline unsigned long __get_current_cr3_fast(void)
 	return cr3;
 }
 
+typedef struct {
+	struct mm_struct *mm;
+} temp_mm_state_t;
+
+/*
+ * Using a temporary mm allows to set temporary mappings that are not accessible
+ * by other CPUs. Such mappings are needed to perform sensitive memory writes
+ * that override the kernel memory protections (e.g., W^X), without exposing the
+ * temporary page-table mappings that are required for these write operations to
+ * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
+ * mapping is torn down.
+ *
+ * Context: The temporary mm needs to be used exclusively by a single core. To
+ *          harden security IRQs must be disabled while the temporary mm is
+ *          loaded, thereby preventing interrupt handler bugs from overriding
+ *          the kernel memory protection.
+ */
+static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
+{
+	temp_mm_state_t temp_state;
+
+	lockdep_assert_irqs_disabled();
+	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, mm, current);
+	return temp_state;
+}
+
+static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
+{
+	lockdep_assert_irqs_disabled();
+	switch_mm_irqs_off(NULL, prev_state.mm, current);
+}
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
