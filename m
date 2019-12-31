Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BBC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43470206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aZh/zyjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLaQbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:31:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:31:18 -0500
Received: from zn.tnic (p200300EC2F00E7007CEDBF47C01C0A42.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:7ced:bf47:c01c:a42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 823371EC0273;
        Tue, 31 Dec 2019 17:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577809876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XLKvpbF/byz3Z6T7cOCCHGN1ZNPGh/rIhiwmf7WR9SA=;
        b=aZh/zyjUpkE7oqr4WKclNJ6Hjkima9b/OTjhub45rFI7P/lCOjAS24rd3915L8lBoel76q
        hSsCNMhJGYzkhFEU6zGOTXLka+L75QOvunZ2WbenwRuifOre1FlO8gmNEesbFnAxqkK2uC
        22trVeJGKL1draP8JmLvw1ROYNprE3o=
Date:   Tue, 31 Dec 2019 17:31:08 +0100
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
Subject: [PATCH] x86/traps: Cleanup do_general_protection()
Message-ID: <20191231163108.GC13549@zn.tnic>
References: <20191218231150.12139-1-jannh@google.com>
 <20191218231150.12139-3-jannh@google.com>
 <20191231121121.GA13549@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191231121121.GA13549@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and a cleanup ontop:

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 31 Dec 2019 17:15:35 +0100

Hoist the user_mode() case up because it is less code and can be dealt
with up-front like the other special cases UMIP and vm86.

This saves an indentation level for the kernel-mode #GP case and allows
to "unfold" the code more so that it is more readable.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/traps.c | 79 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2afd7d8d4007..ca395ad28b4e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -567,7 +567,10 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
+	enum kernel_gp_hint hint = GP_NO_HINT;
 	struct task_struct *tsk;
+	unsigned long gp_addr;
+	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
@@ -584,58 +587,56 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 	}
 
 	tsk = current;
-	if (!user_mode(regs)) {
-		enum kernel_gp_hint hint = GP_NO_HINT;
-		unsigned long gp_addr;
-
-		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
 
+	if (user_mode(regs)) {
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
-		/*
-		 * To be potentially processing a kprobe fault and to
-		 * trust the result from kprobe_running(), we have to
-		 * be non-preemptible.
-		 */
-		if (!preemptible() && kprobe_running() &&
-		    kprobe_fault_handler(regs, X86_TRAP_GP))
-			return;
+		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
+		force_sig(SIGSEGV);
 
-		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
-			return;
+		return;
+	}
 
-		if (error_code)
-			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
-		else
-			hint = get_kernel_gp_address(regs, &gp_addr);
+	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
+		return;
 
-		if (hint != GP_NO_HINT)
-			snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-				 (hint == GP_NON_CANONICAL) ?
-				 "probably for non-canonical address" :
-				 "maybe for address",
-				 gp_addr);
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_GP;
 
-		/*
-		 * KASAN is interested only in the non-canonical case, clear it
-		 * otherwise.
-		 */
-		if (hint != GP_NON_CANONICAL)
-			gp_addr = 0;
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() &&
+	    kprobe_running() &&
+	    kprobe_fault_handler(regs, X86_TRAP_GP))
+		return;
 
-		die_addr(desc, regs, error_code, gp_addr);
+	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
+	if (ret == NOTIFY_STOP)
 		return;
-	}
 
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = X86_TRAP_GP;
+	if (error_code)
+		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
+	else
+		hint = get_kernel_gp_address(regs, &gp_addr);
+
+	if (hint != GP_NO_HINT)
+		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
+			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
+						    : "maybe for address",
+			 gp_addr);
+
+	/*
+	 * KASAN is interested only in the non-canonical case, clear it
+	 * otherwise.
+	 */
+	if (hint != GP_NON_CANONICAL)
+		gp_addr = 0;
 
-	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
+	die_addr(desc, regs, error_code, gp_addr);
 
-	force_sig(SIGSEGV);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
