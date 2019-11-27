Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B289220870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AU/zJR+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfK0Xue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:50:34 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:58058 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfK0Xud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:50:33 -0500
Received: by mail-wm1-f73.google.com with SMTP id m68so3100799wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QATXnoiDKCWC3WWAdN6sdIHlK8jnCgnJfnHnydMklE8=;
        b=AU/zJR+yASACbOc0824F8srWYA1NDXRsoPMm0D8nGcdyUSKwENxvNMuYtcbqxxekF+
         Grm3CIoAz5coKLKYwPcjvFDrMJNB41C/86KKxcZ22no3y0mVg0Nx7Oki3KEhOOzCT8na
         BznGzRNqsP+Dz5vmYTCCUwKWk4CEjhXl0RC5NSzr4lmkVd+hj91zPmOZnT7uopP/K/WQ
         FVfQhoGjHmU7e0PvB/Zp9TrMsIf2reWHNuIF/V0MmvtfZTU02SGPqA2U5HWNMAWbBKCs
         Cb2ffAhcPxNrTGFAM5zBKS8+MJriblWSqFedhTM+nfAYLsgcBComa47gop0u6EKItquT
         XCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QATXnoiDKCWC3WWAdN6sdIHlK8jnCgnJfnHnydMklE8=;
        b=Ac/OXGjj1S++b3NMOSbhrz8fyXMrfp7iW2dX0pptXdBrwVssm+Q/oG98LMbL+GXyI+
         oNmjc9aj6JZJPyX+so0BpHf2bN3u6tiWXNqpInNHE2q1rEuVefEgkzqLuiTMbEiLohYb
         xQUHGpIU0WDQgW9Zi1hFegKQBvmSZhzP50Y1pgwTJrTj1IhA5HqIktKsA19TDVYyqig1
         iGqqjdbJgOYgdP3qXqcqzL8vOsRw+bbsNIhkvK1hdvrty8/CpmGvdK12VuWYGDt4xZvz
         DlKmigIsRo1Y/bWbkn+ZCohUlywNSb4urttrO9tMUfp61nxBh0fMeJTqGQIPX/dU44q5
         4x/A==
X-Gm-Message-State: APjAAAUcRKfjYnXF+uweiPriNCZyqPTuQ7Woa8KwOKpZvQPcoQCByX1e
        0OYJQU2cv4ciHt20KtFHquzG4aPMBg==
X-Google-Smtp-Source: APXvYqwPXpyQktxPUwEfAKwE0X277dXosVA4G0cKw8YTSXbOQ0iWEOxFQiNuPk3QVsbb24dUA+5BObL9nw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr1851016wru.353.1574898628777;
 Wed, 27 Nov 2019 15:50:28 -0800 (PST)
Date:   Thu, 28 Nov 2019 00:49:14 +0100
In-Reply-To: <20191127234916.31175-1-jannh@google.com>
Message-Id: <20191127234916.31175-2-jannh@google.com>
Mime-Version: 1.0
References: <20191127234916.31175-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v5 2/4] x86/traps: Print address on #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A frequent cause of #GP exceptions are memory accesses to non-canonical
addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
the kernel doesn't currently print the fault address for #GP.
Luckily, we already have the necessary infrastructure for decoding X86
instructions and computing the memory address that is being accessed;
hook it up to the #GP handler so that we can figure out the address
operand of the faulting instruction and print it.

Distinguish two cases:
  a) (Part of) the memory range being accessed lies in the non-canonical
     address range; in this case, is is likely that the address we
     decoded is actually the one that caused the #GP.
  b) The entire memory range of the operand we decoded lies in canonical
     address space; the #GP may or may not be related in some way to the
     address we computed. We'll still print it, but with hedging
     language in the message.

While it is already possible to compute the faulting address manually by
disassembling the opcode dump and evaluating the instruction against the
register dump, this should make it slightly easier to identify crashes
at a glance.

Note that the operand length, which we get from the instruction decoder
and use to determine whether the access straddles into non-canonical
address space, is currently somewhat unreliable; but it should be good
enough, considering that Linux on x86-64 never maps the page directly
before the start of the non-canonical range anyway, and therefore the
case where a memory range begins in that page and potentially straddles
into the non-canonical range should be fairly uncommon.
And if we do get this wrong, it only influences whether the error
message claims that the access is canonical.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2:
     - print different message for segment-related GP (Borislav)
     - rewrite check for non-canonical address (Sean)
     - make it clear we don't know for sure why the GP happened (Andy)
    v3:
     - change message format to one line (Borislav)
    v4:
     - rename insn_bytes to insn_buf (Ingo)
     - add space after GPFSTR (Ingo)
     - make sizeof(desc) clearer (Ingo, Borislav)
     - also print the address (with a different message) if it's canonical (Ingo)
    v5:
     - reword comment on get_kernel_gp_address() (Sean)
     - make get_kernel_gp_address() also work on 32-bit (Sean)
     - minor nits (Sean)
     - more hedging for canonical GP (Sean)
     - let get_kernel_gp_address() return an enum (Sean)
     - rewrite commit message
    
    I have already sent a patch to syzkaller that relaxes their parsing of GPF
    messages (https://github.com/google/syzkaller/commit/432c7650) such that
    changes like the one in this patch don't break it.
    That patch has already made its way into syzbot's syzkaller instances
    according to <https://syzkaller.appspot.com/upstream>.

 arch/x86/kernel/traps.c | 70 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f19de6f45d48..9b6e4d04112a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -56,6 +56,8 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -518,11 +520,56 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
+enum kernel_gp_hint {
+	GP_NO_HINT,
+	GP_NON_CANONICAL,
+	GP_CANONICAL
+};
+
+/*
+ * When an uncaught #GP occurs, try to determine a memory address accessed by
+ * the instruction and return that address to the caller.
+ * Also try to figure out whether any part of the access to that address was
+ * non-canonical.
+ */
+static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
+						 unsigned long *addr)
+{
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+
+	if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return GP_NO_HINT;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
+
+	if (*addr == -1UL)
+		return GP_NO_HINT;
+
+#ifdef CONFIG_X86_64
+	/*
+	 * Check that:
+	 *  - the operand is not in the kernel half
+	 *  - the last byte of the operand is not in the user canonical half
+	 */
+	if (*addr < ~__VIRTUAL_MASK &&
+	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
+		return GP_NON_CANONICAL;
+#endif
+
+	return GP_CANONICAL;
+}
+
+#define GPFSTR "general protection fault"
+
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
-	const char *desc = "general protection fault";
 	struct task_struct *tsk;
+	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
@@ -540,6 +587,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	tsk = current;
 	if (!user_mode(regs)) {
+		enum kernel_gp_hint hint = GP_NO_HINT;
+		unsigned long gp_addr;
+
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
 
@@ -556,8 +606,22 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			return;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die(desc, regs, error_code);
+			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
+			return;
+
+		if (error_code)
+			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
+		else
+			hint = get_kernel_gp_address(regs, &gp_addr);
+
+		if (hint != GP_NO_HINT)
+			snprintf(desc, sizeof(desc), GPFSTR " %s 0x%lx",
+				 (hint == GP_NON_CANONICAL) ?
+				 "probably for non-canonical address" :
+				 "maybe for address",
+				 gp_addr);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.0.432.g9d3f5f5b63-goog

