Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F9720830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139485;
	bh=Mx83E+S8kse97ZBD7/wbKY3kcPTOOsPidXGWxlguo/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T0BPLaTACRbD3CxHan2yR4cOtpZlmE43TvFJfMiCck0Pn0vJsLuVqjTObNAw0Vx7o
	 GrHomEG0kVJVWv4NDfm1q4jHsEAKiM/ZPk4PAQs5JQ1ENui9m5QyR+xadeJBTgwUIX
	 7DIW8PfdIhkaT39KdDEu7fivyfAYwN+YvbhPELMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfDARYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731918AbfDARYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7114520856;
        Mon,  1 Apr 2019 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139476;
        bh=Mx83E+S8kse97ZBD7/wbKY3kcPTOOsPidXGWxlguo/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xi5jeUMqQD30OKb0XlvBoPc+e5HweaZGvns9/j1vmJowokVwpsxVTK/Sgagn1Tpmv
         DNsMCGDHf0zyk+WyQZfaYrlSS9F8pZL7jZX++nqfDEfNBhe54BixkYt7CaHWiSHiz2
         reouE+6H3/UOR39txtBq/cpllUnjWaWAPLlFX27k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 040/107] powerpc/64s: Add support for software count cache flush
Date:   Mon,  1 Apr 2019 19:01:55 +0200
Message-Id: <20190401170049.285212643@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit ee13cb249fabdff8b90aaff61add347749280087 upstream.

Some CPU revisions support a mode where the count cache needs to be
flushed by software on context switch. Additionally some revisions may
have a hardware accelerated flush, in which case the software flush
sequence can be shortened.

If we detect the appropriate flag from firmware we patch a branch
into _switch() which takes us to a count cache flush sequence.

That sequence in turn may be patched to return early if we detect that
the CPU supports accelerating the flush sequence in hardware.

Add debugfs support for reporting the state of the flush, as well as
runtime disabling it.

And modify the spectre_v2 sysfs file to report the state of the
software flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/asm-prototypes.h    |    6 +
 arch/powerpc/include/asm/security_features.h |    1 
 arch/powerpc/kernel/entry_64.S               |   54 ++++++++++++++
 arch/powerpc/kernel/security.c               |   98 +++++++++++++++++++++++++--
 4 files changed, 154 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -126,4 +126,10 @@ extern int __ucmpdi2(u64, u64);
 void _mcount(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
 
+/* Patch sites */
+extern s32 patch__call_flush_count_cache;
+extern s32 patch__flush_count_cache_return;
+
+extern long flush_count_cache;
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -22,6 +22,7 @@ enum stf_barrier_type {
 
 void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
+void setup_count_cache_flush(void);
 
 static inline void security_ftr_set(unsigned long feature)
 {
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -25,6 +25,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/thread_info.h>
+#include <asm/code-patching-asm.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
@@ -497,6 +498,57 @@ _GLOBAL(ret_from_kernel_thread)
 	li	r3,0
 	b	.Lsyscall_exit
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define FLUSH_COUNT_CACHE	\
+1:	nop;			\
+	patch_site 1b, patch__call_flush_count_cache
+
+
+#define BCCTR_FLUSH	.long 0x4c400420
+
+.macro nops number
+	.rept \number
+	nop
+	.endr
+.endm
+
+.balign 32
+.global flush_count_cache
+flush_count_cache:
+	/* Save LR into r9 */
+	mflr	r9
+
+	.rept 64
+	bl	.+4
+	.endr
+	b	1f
+	nops	6
+
+	.balign 32
+	/* Restore LR */
+1:	mtlr	r9
+	li	r9,0x7fff
+	mtctr	r9
+
+	BCCTR_FLUSH
+
+2:	nop
+	patch_site 2b patch__flush_count_cache_return
+
+	nops	3
+
+	.rept 278
+	.balign 32
+	BCCTR_FLUSH
+	nops	7
+	.endr
+
+	blr
+#else
+#define FLUSH_COUNT_CACHE
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
@@ -528,6 +580,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	FLUSH_COUNT_CACHE
+
 	/*
 	 * On SMP kernels, care must be taken because a task may be
 	 * scheduled off CPUx and on to CPUy. Memory ordering must be
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -9,12 +9,21 @@
 #include <linux/seq_buf.h>
 
 #include <asm/debugfs.h>
+#include <asm/asm-prototypes.h>
+#include <asm/code-patching.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
 
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+enum count_cache_flush_type {
+	COUNT_CACHE_FLUSH_NONE	= 0x1,
+	COUNT_CACHE_FLUSH_SW	= 0x2,
+	COUNT_CACHE_FLUSH_HW	= 0x4,
+};
+static enum count_cache_flush_type count_cache_flush_type;
+
 bool barrier_nospec_enabled;
 static bool no_nospec;
 
@@ -159,17 +168,29 @@ ssize_t cpu_show_spectre_v2(struct devic
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
-	if (bcs || ccd) {
+	if (bcs || ccd || count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		bool comma = false;
 		seq_buf_printf(&s, "Mitigation: ");
 
-		if (bcs)
+		if (bcs) {
 			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+			comma = true;
+		}
+
+		if (ccd) {
+			if (comma)
+				seq_buf_printf(&s, ", ");
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+			comma = true;
+		}
 
-		if (bcs && ccd)
+		if (comma)
 			seq_buf_printf(&s, ", ");
 
-		if (ccd)
-			seq_buf_printf(&s, "Indirect branch cache disabled");
+		seq_buf_printf(&s, "Software count cache flush");
+
+		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
+			seq_buf_printf(&s, "(hardware accelerated)");
 	} else
 		seq_buf_printf(&s, "Vulnerable");
 
@@ -326,4 +347,71 @@ static __init int stf_barrier_debugfs_in
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+
+static void toggle_count_cache_flush(bool enable)
+{
+	if (!enable || !security_ftr_enabled(SEC_FTR_FLUSH_COUNT_CACHE)) {
+		patch_instruction_site(&patch__call_flush_count_cache, PPC_INST_NOP);
+		count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
+		pr_info("count-cache-flush: software flush disabled.\n");
+		return;
+	}
+
+	patch_branch_site(&patch__call_flush_count_cache,
+			  (u64)&flush_count_cache, BRANCH_SET_LINK);
+
+	if (!security_ftr_enabled(SEC_FTR_BCCTR_FLUSH_ASSIST)) {
+		count_cache_flush_type = COUNT_CACHE_FLUSH_SW;
+		pr_info("count-cache-flush: full software flush sequence enabled.\n");
+		return;
+	}
+
+	patch_instruction_site(&patch__flush_count_cache_return, PPC_INST_BLR);
+	count_cache_flush_type = COUNT_CACHE_FLUSH_HW;
+	pr_info("count-cache-flush: hardware assisted flush sequence enabled\n");
+}
+
+void setup_count_cache_flush(void)
+{
+	toggle_count_cache_flush(true);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int count_cache_flush_set(void *data, u64 val)
+{
+	bool enable;
+
+	if (val == 1)
+		enable = true;
+	else if (val == 0)
+		enable = false;
+	else
+		return -EINVAL;
+
+	toggle_count_cache_flush(enable);
+
+	return 0;
+}
+
+static int count_cache_flush_get(void *data, u64 *val)
+{
+	if (count_cache_flush_type == COUNT_CACHE_FLUSH_NONE)
+		*val = 0;
+	else
+		*val = 1;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get,
+			count_cache_flush_set, "%llu\n");
+
+static __init int count_cache_flush_debugfs_init(void)
+{
+	debugfs_create_file("count_cache_flush", 0600, powerpc_debugfs_root,
+			    NULL, &fops_count_cache_flush);
+	return 0;
+}
+device_initcall(count_cache_flush_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
 #endif /* CONFIG_PPC_BOOK3S_64 */


