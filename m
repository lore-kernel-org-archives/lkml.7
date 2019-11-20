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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA65C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC932088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wG3Vrn8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfKTRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:02:28 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:48451 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfKTRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:02:27 -0500
Received: by mail-wr1-f73.google.com with SMTP id j12so1663638wrw.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N36gCc3j7uExBVgM58L/MEwlkhhJunSvGseUI9gnnGU=;
        b=wG3Vrn8j8BkwZJtf/61OoECdz7bT963v0NtZ3rBApr0/byc0YTXlMgjIeZwvSJIC1l
         MumUaupg8Gr8xxNZZEuN7m2hHR7617G5FKJtKjGOqLdSrqMNJzS4XpGCCgdr9xuwa2JB
         vW9Z1Bhzc9h4Kto6ema0XcshW5HTgpBYPNKDi0W8RRiPVk/Maq+mtZaQuU1qvebkbHG/
         KMVmLUi29iXqmMogrF/k/pITuoe6HV+NkADOIjmNNkNfg8582PNr2oLZNwMZ84c2lUJ2
         Tg2kR8Qc9JzfuxlLjQvO7Tj4FkMreW4ODbuqrd50cPGFJQiOKhwz6VS1gDNbhQwFdmJM
         Pc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N36gCc3j7uExBVgM58L/MEwlkhhJunSvGseUI9gnnGU=;
        b=hBbupmC1Y2PsLh/ifSUWZQyJ2yAG9ZfxGdZcfwCTTFiL6sSErl3AW6UQLUnHRUr91C
         wksPaI4/CdGSLZQr3B7MPOEC7gwU9Q4THRHB2xevfP2dx3+dYJE0L2LvWAqLqT3KbsWL
         z+J5Q0MmIxZok6nlCk38WdKvq1veaobWYRNFLQeyXjPF/Tt1JHTtiEDVzB6j780EpDby
         b6+U6dr0jgbDW1et4vicba4jDLYsyLhr9bRLwVRaKvJcIQOytYCMj5zZ8qXSSqbbcFJg
         yjnOKlndFtliuCWrc32zxgoGlm0dckqejIqhDykH5maLmyWwmy0QP2DzBrgJGX/wyb1V
         YOFQ==
X-Gm-Message-State: APjAAAU2p6pnHOnB1OwDN7Q/ZytDUxABx54ZDOWXCX1t+S+7PzEWO7LE
        8St6jF30OrqkvhOAbfpTxoFjvTJ3Aw==
X-Google-Smtp-Source: APXvYqyajeoSli404TUYwArpq9llItkXaS9eYhhY/W+OA/LkTQXF9yU31MSPE3TNJMFDjizx0jvtiy4jXA==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr4675039wrm.366.1574269342238;
 Wed, 20 Nov 2019 09:02:22 -0800 (PST)
Date:   Wed, 20 Nov 2019 18:02:06 +0100
In-Reply-To: <20191120170208.211997-1-jannh@google.com>
Message-Id: <20191120170208.211997-2-jannh@google.com>
Mime-Version: 1.0
References: <20191120170208.211997-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 2/4] x86/traps: Print non-canonical address on #GP
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
    v4:
     - rename insn_bytes to insn_buf (Ingo)
     - add space after GPFSTR (Ingo)
     - make sizeof(desc) clearer (Ingo, Borislav)
     - also print the address (with a different message) if it's canonical (Ingo)
    
    I have already sent a patch to syzkaller that relaxes their parsing of GPF
    messages (https://github.com/google/syzkaller/commit/432c7650) such that
    changes like the one in this patch don't break it.
    That patch has already made its way into syzbot's syzkaller instances
    according to <https://syzkaller.appspot.com/upstream>.

 arch/x86/kernel/traps.c | 64 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c90312146da0..b90635f29b9f 100644
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
@@ -509,11 +511,50 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
+/*
+ * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
+ * address, return that address.
+ */
+static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
+					   bool *non_canonical)
+{
+#ifdef CONFIG_X86_64
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+
+	if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return false;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
+
+	if (*addr == (unsigned long)-1L)
+		return false;
+
+	/*
+	 * Check that:
+	 *  - the address is not in the kernel half or -1 (which means the
+	 *    decoder failed to decode it)
+	 *  - the last byte of the address is not in the user canonical half
+	 */
+	*non_canonical = *addr < ~__VIRTUAL_MASK &&
+			 *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK;
+
+	return true;
+#else
+	return false;
+#endif
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
@@ -531,6 +572,10 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	tsk = current;
 	if (!user_mode(regs)) {
+		bool addr_resolved = false;
+		unsigned long gp_addr;
+		bool non_canonical;
+
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
 
@@ -547,8 +592,21 @@ do_general_protection(struct pt_regs *regs, long error_code)
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
+			addr_resolved = get_kernel_gp_address(regs, &gp_addr,
+							      &non_canonical);
+
+		if (addr_resolved)
+			snprintf(desc, sizeof(desc),
+			    GPFSTR " probably for %saddress 0x%lx",
+			    non_canonical ? "non-canonical " : "", gp_addr);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.0.432.g9d3f5f5b63-goog

