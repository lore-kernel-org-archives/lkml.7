Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3348FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073A2243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un18xq5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfKTKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:36:46 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:57926 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfKTKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:36:45 -0500
Received: by mail-wm1-f74.google.com with SMTP id m68so4895437wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 02:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DuYnZAR8MB1c63ohOHf4MauzqJEQWPTDR3HCqzl6rd8=;
        b=un18xq5OrO44FjkPlzOLBsBRDMA4Eryc8koOg3c1qWBZEcD4JEgxwmjpG8A/IzRNxz
         ySVa+d9nZ5iCCGWQQcaNDJ4L768XcXLbz/h0dp2d6BGjdi3/Cfnp8uBLyN0cZKLtm89V
         06Z+phOMCS22Yl5SWoe5JTSMq7p7pxJKbDS0bkXdhOO9SyYAiBzgxGBfyJ4bquZX8xLc
         C8ETCK5FoXb1YpyZ9pV7K0+lWa6Fa4KoNpDbV5qEejfkwf+k9kajONciVc8M0vJnIm06
         oFVVuBf7RuY7PwVBJT+qS+0qIiF0iSaCUj+jpyf0Hlozg/X9+/hX2/sVBsOL54QrTj/R
         Cqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DuYnZAR8MB1c63ohOHf4MauzqJEQWPTDR3HCqzl6rd8=;
        b=mZesFvJZbOrC415scuBzWJD7dtrO5rF5o96Jdr13+M4Tj7J752kH2l4f/XHs0HDmzB
         zv3xzijskrDNYxhhsiQuYdffo056aj9n2qle+bpV+tsAhhnGOSnaRitk2cw1+Nv+hoaX
         uMzthJnfJqHOxXlvESgojPjDT/p8VcRKHxY2ddZhbc24j7sZpo2dz2s/zaUo1UOJYGXK
         vUHhctdf5H3kVRG8Q9wzH9jHON2TKGDe32PCTL8NLwve57Rltpf4ZL+4FQngxzn5dJxU
         io+XzgO6/VWPfZ/v/z6YiN8/XkocpyBNv1q7lLfoyvDw0CvcDt6qXDcEMJwcGgKR6/GB
         4Z4g==
X-Gm-Message-State: APjAAAXtAx72eVMDsk5xq9SHd3vQw6HOQqLNpQpF5CtjTMfm0dgF5Ke0
        RxFiPUzp9n7XzZMHOeJ+CwwbWCZjtg==
X-Google-Smtp-Source: APXvYqyUaAlaUMK3Qn58gOPyNbg3rmUyEkr0/ysvYzfqQz+UcXJ9p+26FlaeKB0Je59IzFOAK8wTXmNW6A==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr2529588wra.27.1574246201957;
 Wed, 20 Nov 2019 02:36:41 -0800 (PST)
Date:   Wed, 20 Nov 2019 11:36:11 +0100
In-Reply-To: <20191120103613.63563-1-jannh@google.com>
Message-Id: <20191120103613.63563-2-jannh@google.com>
Mime-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
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
hook it up to the #GP handler so that we can figure out whether the #GP
looks like it was caused by a non-canonical address, and if so, print
that address.

While it is already possible to compute the faulting address manually by
disassembling the opcode dump and evaluating the instruction against the
register dump, this should make it slightly easier to identify crashes
at a glance.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2:
     - print different message for segment-related GP (Borislav)
     - rewrite check for non-canonical address (Sean)
     - make it clear we don't know for sure why the GP happened (Andy)
    v3:
     - change message format to one line (Borislav)
    
    I have already sent a patch to syzkaller that relaxes their parsing of GPF
    messages (https://github.com/google/syzkaller/commit/432c7650) such that
    changes like the one in this patch don't break it.
    That patch has already made its way into syzbot's syzkaller instances
    according to <https://syzkaller.appspot.com/upstream>.

 arch/x86/kernel/traps.c | 56 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c90312146da0..19afedcd6f4e 100644
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
@@ -509,11 +511,45 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
+/*
+ * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
+ * address, return that address.
+ */
+static unsigned long get_kernel_gp_address(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	u8 insn_bytes[MAX_INSN_SIZE];
+	struct insn insn;
+	unsigned long addr_ref;
+
+	if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
+		return 0;
+
+	kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+	addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
+
+	/* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
+	if (addr_ref >= ~__VIRTUAL_MASK)
+		return 0;
+
+	/* Bail out if the entire operand is in the canonical user half. */
+	if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
+		return 0;
+
+	return addr_ref;
+#else
+	return 0;
+#endif
+}
+
+#define GPFSTR "general protection fault"
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
-	const char *desc = "general protection fault";
 	struct task_struct *tsk;
+	char desc[90] = GPFSTR;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
@@ -531,6 +567,8 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	tsk = current;
 	if (!user_mode(regs)) {
+		unsigned long non_canonical_addr = 0;
+
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
 
@@ -547,8 +585,20 @@ do_general_protection(struct pt_regs *regs, long error_code)
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
+			non_canonical_addr = get_kernel_gp_address(regs);
+
+		if (non_canonical_addr)
+			snprintf(desc, sizeof(desc),
+			    GPFSTR " probably for non-canonical address 0x%lx",
+			    non_canonical_addr);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.0.432.g9d3f5f5b63-goog

