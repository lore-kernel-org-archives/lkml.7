Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8330AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE7020727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PbmjpkhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKROVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:21:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfKROVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:21:49 -0500
Received: from zn.tnic (p200300EC2F27B50084A11D83797EBEC7.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:84a1:1d83:797e:bec7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 637F91EC027B;
        Mon, 18 Nov 2019 15:21:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574086908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Drk11FQiiBMEtrfW9/M48Q99qTus2Kx6p9Nmb9b9aEw=;
        b=PbmjpkhPOEFMbZr6Pzx3R4wyDJywmlAym8reaS86Kpx0UpuRIsg5vNjn7xYTJHbCJSpfnU
        h6En5/fAPDy4Rm9w+iPEInNkri8a1G11Fz+Abnyu8acE4JyTb+NRgScZqngxbyuxTb2CuT
        3a/pX8XCszp1p12Et0oH3jM7PHDji40=
Date:   Mon, 18 Nov 2019 15:21:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191118142144.GC6363@zn.tnic>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115191728.87338-2-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:17:27PM +0100, Jann Horn wrote:
>  dotraplinkage void
>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> @@ -547,8 +581,15 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  			return;
>  
>  		if (notify_die(DIE_GPF, desc, regs, error_code,
> -			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> -			die(desc, regs, error_code);
> +			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> +			return;
> +
> +		if (error_code)
> +			pr_alert("GPF is segment-related (see error code)\n");
> +		else
> +			print_kernel_gp_address(regs);
> +
> +		die(desc, regs, error_code);

Right, this way, those messages appear before the main "general
protection ..." message:

[    2.434372] traps: probably dereferencing non-canonical address 0xdfff000000000001
[    2.442492] general protection fault: 0000 [#1] PREEMPT SMP

Can we glue/merge them together? Or is this going to confuse tools too much:

[    2.542218] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP

(and that sentence could be shorter too:

 	"general protection fault for non-canonical address 0xdfff000000000001"

looks ok to me too.)

Here's a dirty diff together with a reproducer ontop of yours:

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bf796f8c9998..dab702ba28a6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -515,7 +515,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
  * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
  * address, print that address.
  */
-static void print_kernel_gp_address(struct pt_regs *regs)
+static unsigned long get_kernel_gp_address(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_64
 	u8 insn_bytes[MAX_INSN_SIZE];
@@ -523,7 +523,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
 	unsigned long addr_ref;
 
 	if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
-		return;
+		return 0;
 
 	kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
 	insn_get_modrm(&insn);
@@ -532,22 +532,22 @@ static void print_kernel_gp_address(struct pt_regs *regs)
 
 	/* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
 	if (addr_ref >= ~__VIRTUAL_MASK)
-		return;
+		return 0;
 
 	/* Bail out if the entire operand is in the canonical user half. */
 	if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
-		return;
+		return 0;
 
-	pr_alert("probably dereferencing non-canonical address 0x%016lx\n",
-		 addr_ref);
+	return addr_ref;
 #endif
 }
 
+#define GPFSTR "general protection fault"
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
-	const char *desc = "general protection fault";
 	struct task_struct *tsk;
+	char desc[90];
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
@@ -584,12 +584,18 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
 			return;
 
-		if (error_code)
-			pr_alert("GPF is segment-related (see error code)\n");
-		else
-			print_kernel_gp_address(regs);
+		if (error_code) {
+			snprintf(desc, 90, "segment-related " GPFSTR);
+		} else {
+			unsigned long addr_ref = get_kernel_gp_address(regs);
+
+			if (addr_ref)
+				snprintf(desc, 90, GPFSTR " while derefing a non-canonical address 0x%lx", addr_ref);
+			else
+				snprintf(desc, 90, GPFSTR);
+		}
 
-		die(desc, regs, error_code);
+		die((const char *)desc, regs, error_code);
 		return;
 	}
 
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..7acc7e660be9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1124,6 +1124,9 @@ static int __ref kernel_init(void *unused)
 
 	rcu_end_inkernel_boot();
 
+	asm volatile("mov $0xdfff000000000001, %rax\n\t"
+		     "jmpq *%rax\n\t");
+
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
