Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F85F2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMwJ5hLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLRXMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:12:15 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:46556 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:12:13 -0500
Received: by mail-ua1-f73.google.com with SMTP id z2so935293uar.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zwZD1xekAbBhcHcPHq3baE7/ncVh4IANCcYoRBC9tq4=;
        b=aMwJ5hLhQesAJQ98y+fazHRZb/hiklxCUoXcmguh5ksdNgyP/wAVnqabfJOc2UMSKg
         FWalG8K+KK/KjIYdFzVsyaZwYO5OU7BNsaBqSiKZ8mAEANrvKBzR4Cu2c7bGx97snzR0
         /xjZ4iXm4KXJp7YKqfUL3p053ic75FYXUVL8a+SWOjVlyKpNpw9PVhbLxKU9TbYiFjtP
         Zx2U8bBNdyd95KHb+YFYu62zi2NYKGfjNZXxpTpsou4o0Oa1Jbbp4evgWv93Riwf9E7b
         W/5pbHBdJKA1WY3DMr0DhndLiXMnEvKQJcDVVPdFjcJsNAbMZ+b/bUkN3HtyKzHKN0j0
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zwZD1xekAbBhcHcPHq3baE7/ncVh4IANCcYoRBC9tq4=;
        b=Xy0uXdrjKFWs896jxjLXukAJXTI5IMe2PyOawAeBtglnPCme59//AJzlyfB7PGaLof
         dawOVtqakvGK4aCJnbMCQAwK7VfsbqFrRwBqt4BRP2N4OaTlvk4oEQ91Bx2GOD0JlL4i
         g/UIsmLdn39IS12JimitT2uY0mJtLFqMvze3pHCCdQjPbngJI1i8HvgfHXmWZxe5QWiF
         7+t06nP9TLIb0VINbgzyXhdYBHaojYFG3ylDBmQoB886CwybJ8pkhHUroGadUMVEmeER
         izgQFdprHGLXStZZLm4ax9AeHFE4rTvc8htD+mJfnL3YwWBOCVBwOMrXFiFwBTNZj5Lk
         Kk2g==
X-Gm-Message-State: APjAAAV7qgahztDC1O+FkFvuLMYIFF7Qt8FYUqEe6KYlIccqJ/lsQXIU
        spjLfP5oJbGJvLvXfBkMoZhpFTtkBQ==
X-Google-Smtp-Source: APXvYqxdB6BkMtBf6f2QDcnpHImUPs4uzk3YSkV5vi2/rf+S94+NOwgAHuWBX2Z1A1LTmOHV/IDvjWOhuQ==
X-Received: by 2002:a1f:7d43:: with SMTP id y64mr3916801vkc.15.1576710730458;
 Wed, 18 Dec 2019 15:12:10 -0800 (PST)
Date:   Thu, 19 Dec 2019 00:11:48 +0100
In-Reply-To: <20191218231150.12139-1-jannh@google.com>
Message-Id: <20191218231150.12139-2-jannh@google.com>
Mime-Version: 1.0
References: <20191218231150.12139-1-jannh@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v7 2/4] x86/traps: Print address on #GP
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

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
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
    v6:
     - add comma after GPFSTR (Sean)
     - reorder variable declarations (Sean)
    v7:
      no changes
    
    I have already sent a patch to syzkaller that relaxes their parsing of GPF
    messages (https://github.com/google/syzkaller/commit/432c7650) such that
    changes like the one in this patch don't break it.
    That patch has already made its way into syzbot's syzkaller instances
    according to <https://syzkaller.appspot.com/upstream>.

 arch/x86/kernel/traps.c | 70 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f19de6f45d48..c8b4ae6aed5b 100644
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
@@ -518,10 +520,55 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
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
+	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	struct task_struct *tsk;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
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
+			snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
+				 (hint == GP_NON_CANONICAL) ?
+				 "probably for non-canonical address" :
+				 "maybe for address",
+				 gp_addr);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.1.735.g03f4e72817-goog

