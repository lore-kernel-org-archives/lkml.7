Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A09AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C0620733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCPoUdJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKOTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:17:45 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56071 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:17:44 -0500
Received: by mail-vk1-f201.google.com with SMTP id n6so4556002vke.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z4eVXgHWWbGRrH9BipYQn3sMDOkKflzbIVEAmfiSHc4=;
        b=qCPoUdJ0wzt053R9VhJrlNxU9aqLDf1JU8N77nqnqs1UNRFbPCPE+Fkpv+Gqrpa5B1
         7YuLk1nFQJ2IseEsVFRDdBoiSYMjEqCcaJzu20t0EITie6omSxbzd98Yvp5yf1vagYEB
         jWh+LYL6GzFRM6TbQ2hmff2Oh15gBP8EdiN8c1x7FShABhxNvnFRtl7hlZvQAInMWq2B
         ha60eUT3ZgCZ7xO3JjJyJHTCHQTz3qP+wbmkn4w1bxnWE4FmDfcom1FhX/0RNA6fNpei
         AHubL4bsK+sVFtfmX/wTWyPTHOdRrH2YxKBeOm06Gxpb6cF5AZfTnBpCrDpDmKkuRE3h
         422Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z4eVXgHWWbGRrH9BipYQn3sMDOkKflzbIVEAmfiSHc4=;
        b=I3cHo80MypREBRt53nhOh/CxTR8g5L1vxgNLigt2YhRRHBFKhAqlUXkBqlCjCTWob0
         aWLC19QiQr7zzGMJ2mK6a8ZHkuWRDgcziKCzwX1zyh5Zgc0wwBmqJtKVuJA/sJg1tIPu
         XhUYQmKVVF5YGq1c3uWg3Qv3K/OHz7SHizp1moXcnBTDBlL4LKq8338CsrNa6vk3fMGn
         uURWPGLCFH6r1eBEM0XSz/7NEYU5k4iwieDq4dp9iuv2aBJBo7mqfkCLpsf1kBWuDXxW
         sWfqw55GpY3EU0mbQQeOWgizmp50YrDbYAnp7AODDC0qh0rxSGcwhvzG/fHrnPmANEHJ
         c0cw==
X-Gm-Message-State: APjAAAV/B6xwJ4fcFwfSW0LalXDko+QacmtRhv02NFaDKCP9YdI5joOD
        CxeME/JWEq0Rl3WTNz8xfJ8DPGxdAA==
X-Google-Smtp-Source: APXvYqyH7QRBMTX5ezESOd44VIolFqyVQWfQv0619idWwqWSlEjdQc5LJ5AzgMKVcRzlnFmljteSrUd9+g==
X-Received: by 2002:a1f:9705:: with SMTP id z5mr9652185vkd.46.1573845463473;
 Fri, 15 Nov 2019 11:17:43 -0800 (PST)
Date:   Fri, 15 Nov 2019 20:17:27 +0100
In-Reply-To: <20191115191728.87338-1-jannh@google.com>
Message-Id: <20191115191728.87338-2-jannh@google.com>
Mime-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
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

 arch/x86/kernel/traps.c | 45 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c90312146da0..12d42697a18e 100644
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
@@ -509,6 +511,38 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
+/*
+ * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
+ * address, print that address.
+ */
+static void print_kernel_gp_address(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	u8 insn_bytes[MAX_INSN_SIZE];
+	struct insn insn;
+	unsigned long addr_ref;
+
+	if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
+		return;
+
+	kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+	addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
+
+	/* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
+	if (addr_ref >= ~__VIRTUAL_MASK)
+		return;
+
+	/* Bail out if the entire operand is in the canonical user half. */
+	if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
+		return;
+
+	pr_alert("probably dereferencing non-canonical address 0x%016lx\n",
+		 addr_ref);
+#endif
+}
+
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
@@ -547,8 +581,15 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			return;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die(desc, regs, error_code);
+			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
+			return;
+
+		if (error_code)
+			pr_alert("GPF is segment-related (see error code)\n");
+		else
+			print_kernel_gp_address(regs);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.0.432.g9d3f5f5b63-goog

