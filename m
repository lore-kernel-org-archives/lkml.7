Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5752AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AF0218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfDVTAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:00:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:60350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfDVS6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 11:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="136417155"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.11])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2019 11:58:41 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v4 13/23] x86/alternative: Remove the return value of text_poke_*()
Date:   Mon, 22 Apr 2019 11:57:55 -0700
Message-Id: <20190422185805.1169-14-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The return value of text_poke_early() and text_poke_bp() is useless.
Remove it.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/text-patching.h |  4 ++--
 arch/x86/kernel/alternative.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index a75eed841eed..c90678fd391a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,7 +18,7 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
-extern void *text_poke_early(void *addr, const void *opcode, size_t len);
+extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
@@ -37,7 +37,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3d2b6b6fb20c..18f959975ea0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -265,7 +265,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
-void *text_poke_early(void *addr, const void *opcode, size_t len);
+void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Are we looking at a near JMP with a 1 or 4-byte displacement.
@@ -667,8 +667,8 @@ void __init alternative_instructions(void)
  * instructions. And on the local CPU you need to be protected again NMI or MCE
  * handlers seeing an inconsistent instruction while you patch.
  */
-void *__init_or_module text_poke_early(void *addr, const void *opcode,
-				       size_t len)
+void __init_or_module text_poke_early(void *addr, const void *opcode,
+				      size_t len)
 {
 	unsigned long flags;
 
@@ -691,7 +691,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 		 * that causes hangs on some VIA CPUs.
 		 */
 	}
-	return addr;
 }
 
 __ro_after_init struct mm_struct *poking_mm;
@@ -893,7 +892,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *	  replacing opcode
  *	- sync cores
  */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
 
@@ -935,7 +934,5 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 * the writing of the new instruction.
 	 */
 	bp_patching_in_progress = false;
-
-	return addr;
 }
 
-- 
2.17.1

