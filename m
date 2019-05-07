Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67168C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C27C204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDeta3RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfEGIxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:53:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35159 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfEGIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:53:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so7960354pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WhqwwbWOXvsKJ6z9SuOAeR6ZF8RIJZgSQ+Idl2SKYgI=;
        b=HDeta3RYt9siu6apP+8J+0MthXdJQMqS0w1+uOe+rVzGGXR5Njzu0D+d2SenLhpVWl
         vPHzzfU9f4/QXfdHGbEaZQit+OYA2GqQZhQqg74ZFJ/eVU+EZNA+jh9Ia28ElERP90xF
         1jkgVmTuYKRXzRSspr6oWWNGntW0Hs6zRy+7cL9lvBqj04bj6FgkTxA9Vh77oS77bp+1
         Q1GKaoSnqCOStmxrrNOvOqJCYFqrZOtXbrsVKiXuOmBoi93DXQGAE/oOZbcN7amKupit
         YEnW//T0HsLZ6o1ICJumLQAAAVWYno690KAvQSOsx5nyPfS9cPBJaET3qhI9gZE1iTLx
         GHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WhqwwbWOXvsKJ6z9SuOAeR6ZF8RIJZgSQ+Idl2SKYgI=;
        b=d+9OAv4D9CTmZyi5ZPWZbm4nxf9xFfoS9zw5iOhId7nr0e5UniD3Nu2pYam7qi2RJU
         emD0zwCSj4s951dGuq+eqhLsRFm+T2ftGHYSfOo7p04Xnu/29f5JumPySBeayRRCO6Hk
         +9w19SVJjNwsqC+L4ZRGktBykQOEXmXYOdJHhNX+I238Zw+qL/ppJlVn+3xTVBdceIUG
         9bQabZqQRnfblkVEl9hr3V0KZsq6glSXHUeVg/sPKK+2X9eHdFdpowtgnG3hPvmOF5DG
         OxoQ3b7DEcnDaU9jZZ/MyJ6GCl/oT6NoeDssKbLOfhk4TYUxnxxqKoSROPH5J+E88F90
         b3hw==
X-Gm-Message-State: APjAAAWH84BJot6mhj5FCO94+YVQs7TQizJOeEbU0pLwGe7Hh8gW+bFW
        b0/54uDOTA1j9X/+Dg9V7w==
X-Google-Smtp-Source: APXvYqzP/cJGFeO6xztzWYm/eEee1eGqn5H+4eiKnBJfjhWiB4BHMItI+zS1bRJGEggX2hIh+vsOuQ==
X-Received: by 2002:a63:3fc1:: with SMTP id m184mr37672243pga.222.1557219180301;
        Tue, 07 May 2019 01:53:00 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h127sm16502548pgc.31.2019.05.07.01.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 01:52:59 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Wei Huang <wei@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/boot: set up idt for very early boot stage
Date:   Tue,  7 May 2019 16:52:31 +0800
Message-Id: <1557219151-32212-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557219151-32212-1-git-send-email-kernelfans@gmail.com>
References: <1557219151-32212-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot code becomes a little complicated, and hits some bugs, e.g.
Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.

There is few hint when bug happens. Catching the exception and printing
message can give a immediate help, instead of adding more debug_putstr() to
narraw down the problem.

At present, page fault exception handler is added. And the printed out
message looks like:
  early boot page fault:
  ENTRY(startup_64) is at: 000000047f67d200
  nip: 000000047fdeedd3
  fault address: fffffffeef6fde30

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Wei Huang <wei@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/head_64.S | 11 +++++++
 arch/x86/boot/compressed/misc.c    | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e4a25f9..f589aa2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -527,6 +527,10 @@ relocated:
 	shrq	$3, %rcx
 	rep	stosq
 
+	pushq	%rsi			/* Save the real mode argument */
+	leaq	startup_64(%rip), %rdi
+	call	setup_early_boot_idt
+	popq	%rsi
 /*
  * Do the extraction, and jump to the new kernel..
  */
@@ -659,6 +663,13 @@ no_longmode:
 
 #include "../../kernel/verify_cpu.S"
 
+	.code64
+.align 8
+ENTRY(boot_page_fault)
+	mov	8(%rsp), %rdi
+	call	do_boot_page_fault
+	iretq
+
 	.data
 gdt64:
 	.word	gdt_end - gdt
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 475a3c6..8aaa582 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -76,6 +76,11 @@ static int lines, cols;
 #ifdef CONFIG_KERNEL_LZ4
 #include "../../../../lib/decompress_unlz4.c"
 #endif
+
+#include "../../include/asm/desc.h"
+#include "../../include/asm/idt.h"
+#include "../../include/asm/traps.h"
+
 /*
  * NOTE: When adding a new decompressor, please update the analysis in
  * ../header.S.
@@ -429,3 +434,59 @@ void fortify_panic(const char *name)
 {
 	error("detected buffer overflow");
 }
+
+static unsigned long rt_startup_64;
+
+void do_boot_page_fault(unsigned long retaddr)
+{
+	struct desc_ptr idt = { .address = 0, .size = 0 };
+	unsigned long fault_address = read_cr2();
+
+	debug_putstr("early boot page fault:\n");
+	debug_putstr("ENTRY(startup_64) is at: ");
+	debug_puthex(rt_startup_64);
+	debug_putstr("\n");
+	debug_putstr("nip: ");
+	debug_puthex(retaddr);
+	debug_putstr("\n");
+	debug_putstr("fault address: ");
+	debug_puthex(fault_address);
+	debug_putstr("\n");
+
+	load_idt(&idt);
+}
+
+asmlinkage void boot_page_fault(void);
+
+static struct idt_data boot_idts[] = {
+	INTG(X86_TRAP_PF, 0),
+};
+
+static gate_desc early_boot_idt_table[IDT_ENTRIES] __page_aligned_bss;
+
+static struct desc_ptr early_boot_idt_descr __ro_after_init = {
+	.size		= (IDT_ENTRIES * 2 * sizeof(unsigned long)) - 1,
+};
+
+static void
+idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size)
+{
+	gate_desc desc;
+
+	for (; size > 0; t++, size--) {
+		idt_init_desc(&desc, t);
+		write_idt_entry(idt, t->vector, &desc);
+	}
+}
+
+void setup_early_boot_idt(unsigned long rip)
+{
+	rt_startup_64 = rip;
+	/* fill it with runtime address */
+	boot_idts[0].addr = boot_page_fault;
+	early_boot_idt_descr.address = (unsigned long)early_boot_idt_table;
+
+	idt_setup_from_table(early_boot_idt_table, boot_idts,
+		ARRAY_SIZE(boot_idts));
+	load_idt(&early_boot_idt_descr);
+}
-- 
2.7.4

