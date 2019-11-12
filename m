Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F500C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3660F21D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh9kwelf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKLVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:10:19 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48530 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:10:17 -0500
Received: by mail-qt1-f202.google.com with SMTP id j18so1958090qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QkH07eQfCocHLYn4Bb98KVzxf8ymHQPYHARKfS1aqN8=;
        b=Kh9kwelfZfaslBGL96Q7uewxQCCX2WvJ+5LfmWKI/r5XEJfpdGsCpfWRk4r191Tjm4
         zZ8mXbg/O+E5PjGn5KJFOAH/7gLdAcfTJ/Befi8zPeu1CByMUspi7+TdtoPnxyzzFIXy
         riyOxaLeT8jyBPsPeco+ec2STPraqksAVU2noZ1zap++pC+oRj2PzLuzXUA2XypI4tAZ
         FwayyZupdixQryE9L6mPnK9li1HJFGOlbH257HU4Zpp46oGnDdw9fV8ocwKFQHiUb4sI
         htJ/reB9YQd5+r9JvKxwzpghqEbWvFcMnrjC9n7Sv10NmODjyr6cOhtPQIacxmiRLcWo
         kAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QkH07eQfCocHLYn4Bb98KVzxf8ymHQPYHARKfS1aqN8=;
        b=FJh/EW62sT8UybzpPyZHt8MG/rUOj8VIQtOHnbxGrnGoGLvTP3Y839DdrxgBJAns6g
         HD8FsJL+pTKFrOcxRw/ZAF9219PcAXPz0AFu0wri9N2+xNVWm5woVaSdwyOBlU3ZfOt5
         aIiEf2WrnMU9Q0ZaENRxDK6BBd2Kd46B2rZZAJCABQdbrN2ZrYxKfaY4z+e712YhhxAd
         jRvKqE/TXv8q6OAcjYKnmesRa/lm/g6SvD60fuvH1a+LxyFbCGR7EtdgE/a+L7HD7KIB
         6QSSx6mYvWoDKDOH+gLZNoceZRpetEaKKz1RgchZUAoxfBN+zaJDmTQEn5ieEoHT5SZs
         9Z3w==
X-Gm-Message-State: APjAAAVTmKVAr9coja1z+3mzvFDhXeWPwtzk2PlCONf9wBeGuAXxlAay
        W/pC+3H63pIJPf8BlPrTmxWD1LCODw==
X-Google-Smtp-Source: APXvYqy0gJHjmQ3pUlBDMazi5lzZQXYGs5qonH6xklL3AlqE3UI+jVR8o1Icj+ppsmJUkmFNcYaZxumAjQ==
X-Received: by 2002:ad4:57a7:: with SMTP id g7mr30793924qvx.30.1573593016932;
 Tue, 12 Nov 2019 13:10:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:10:01 +0100
In-Reply-To: <20191112211002.128278-1-jannh@google.com>
Message-Id: <20191112211002.128278-2-jannh@google.com>
Mime-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org
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
 arch/x86/kernel/traps.c | 45 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c90312146da0..479cfc6e9507 100644
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
@@ -509,6 +511,42 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
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
+	/*
+	 * If insn_get_addr_ref() failed or we got a canonical address in the
+	 * kernel half, bail out.
+	 */
+	if ((addr_ref | __VIRTUAL_MASK) == ~0UL)
+		return;
+	/*
+	 * For the user half, check against TASK_SIZE_MAX; this way, if the
+	 * access crosses the canonical address boundary, we don't miss it.
+	 */
+	if (addr_ref <= TASK_SIZE_MAX)
+		return;
+
+	pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
+#endif
+}
+
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
@@ -547,8 +585,11 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			return;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die(desc, regs, error_code);
+			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
+			return;
+
+		print_kernel_gp_address(regs);
+		die(desc, regs, error_code);
 		return;
 	}
 
-- 
2.24.0.432.g9d3f5f5b63-goog

