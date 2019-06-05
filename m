Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628ADC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A52086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WaZgcoce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfFENXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfFENX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6vcpd/Yrl9598aZ1kT1YSLwwTRxt5Xg91scKOkavI0E=; b=WaZgcoceQDoG8x4MRnr/wmaQ4w
        YW0NogyHLAJbcu+UwLiuKz6BwIn+2m9ehMf9zvY2nCO5X+eE7r3MunHDyRXTUhnZy9zkT0bq/JEsO
        o2ZkRkEIIS1zFz610iab/DzB6IaI2COfZ1Ha2wznL550TEIl0ZbgnAj+2G4vnf7d/KsjvVX9epvPy
        qmERb9gJ8yCHWd5IgZTkx6c+xwnbvNpvTBLCes8JvJmKCJJ487N3BChp6aIUro9W6Xg5y0jf7NM9k
        EElzkgVMuj5PYyKop76NE+SkA0Aug7/gkeLRqWttNU1/vktv0v5yDBEemCfZaprAKRLxRpb7NykVV
        th1MaCfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rQ-2J; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 88F672073F418; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.946978563@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 07/15] x86: Add int3_emulate_call() selftest
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that the entry_*.S changes for this functionality are somewhat
tricky, make sure the paths are tested every boot, instead of on the
rare occasion when we trip an INT3 while rewriting text.

Requested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   81 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -614,11 +614,83 @@ extern struct paravirt_patch_site __star
 	__stop_parainstructions[];
 #endif	/* CONFIG_PARAVIRT */
 
+/*
+ * Self-test for the INT3 based CALL emulation code.
+ *
+ * This exercises int3_emulate_call() to make sure INT3 pt_regs are set up
+ * properly and that there is a stack gap between the INT3 frame and the
+ * previous context. Without this gap doing a virtual PUSH on the interrupted
+ * stack would corrupt the INT3 IRET frame.
+ *
+ * See entry_{32,64}.S for more details.
+ */
+static void __init int3_magic(unsigned int *ptr)
+{
+	*ptr = 1;
+}
+
+extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
+
+static int __init
+int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
+{
+	struct die_args *args = data;
+	struct pt_regs *regs = args->regs;
+
+	if (!regs || user_mode(regs))
+		return NOTIFY_DONE;
+
+	if (val != DIE_INT3)
+		return NOTIFY_DONE;
+
+	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
+		return NOTIFY_DONE;
+
+	int3_emulate_call(regs, (unsigned long)&int3_magic);
+	return NOTIFY_STOP;
+}
+
+static void __init int3_selftest(void)
+{
+	static __initdata struct notifier_block int3_exception_nb = {
+		.notifier_call	= int3_exception_notify,
+		.priority	= INT_MAX-1, /* last */
+	};
+	unsigned int val = 0;
+
+	BUG_ON(register_die_notifier(&int3_exception_nb));
+
+	/*
+	 * Basically: int3_magic(&val); but really complicated :-)
+	 *
+	 * Stick the address of the INT3 instruction into int3_selftest_ip,
+	 * then trigger the INT3, padded with NOPs to match a CALL instruction
+	 * length.
+	 */
+	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
+		      ".pushsection .init.data,\"aw\"\n\t"
+		      ".align " __ASM_SEL(4, 8) "\n\t"
+		      ".type int3_selftest_ip, @object\n\t"
+		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
+		      "int3_selftest_ip:\n\t"
+		      __ASM_SEL(.long, .quad) " 1b\n\t"
+		      ".popsection\n\t"
+		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
+
+	BUG_ON(val != 1);
+
+	unregister_die_notifier(&int3_exception_nb);
+}
+
 void __init alternative_instructions(void)
 {
-	/* The patching is not fully atomic, so try to avoid local interruptions
-	   that might execute the to be patched code.
-	   Other CPUs are not running. */
+	int3_selftest();
+
+	/*
+	 * The patching is not fully atomic, so try to avoid local
+	 * interruptions that might execute the to be patched code.
+	 * Other CPUs are not running.
+	 */
 	stop_nmi();
 
 	/*
@@ -643,10 +715,11 @@ void __init alternative_instructions(voi
 					    _text, _etext);
 	}
 
-	if (!uniproc_patched || num_possible_cpus() == 1)
+	if (!uniproc_patched || num_possible_cpus() == 1) {
 		free_init_pages("SMP alternatives",
 				(unsigned long)__smp_locks,
 				(unsigned long)__smp_locks_end);
+	}
 #endif
 
 	apply_paravirt(__parainstructions, __parainstructions_end);


