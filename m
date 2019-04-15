Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2AC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372C32087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354241;
	bh=RaaoAbYVzil8IN8UriHOHlJhFIGs22whPf88Ee7DUdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2rDKNlX3HIrhRCjdcMDen9nlMFPhXqwJr+87b+G493PVzUnfzoqj7W8eBxc4Vt/1
	 4uMOKkGMnfgD78XzseHyzuCaVrQTUeUUoWv2MTvdjoYQse5GVmDlCYoRz3wqre1e7r
	 M+sWM6Vy3OgYzu/CrDnr0f0jEnACMeV66kN6ubKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfDOSqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfDOSq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7E52087C;
        Mon, 15 Apr 2019 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353987;
        bh=RaaoAbYVzil8IN8UriHOHlJhFIGs22whPf88Ee7DUdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ld+nwubpsewK/oU+M9I7Qe4p4/zNVDh5zmN/0iOwluOtzpQap+4yaLF58DmaMJ50l
         uLz6+zINjibntfmLtLPuTLu9TO/3ExcGAY050CfE9Gev6ckQKhDFRpBCS8Kr9zWcMN
         Q4dPpPXzgu5yUnpL49DF4MCouezZLOtvcNpumb1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/76] powerpc/64s: Add support for software count cache flush
Date:   Mon, 15 Apr 2019 20:43:53 +0200
Message-Id: <20190415183715.314662549@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/asm-prototypes.h    |  6 ++
 arch/powerpc/include/asm/security_features.h |  1 +
 arch/powerpc/kernel/entry_64.S               | 54 +++++++++++
 arch/powerpc/kernel/security.c               | 98 +++++++++++++++++++-
 4 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index e0baba1535e6..f3daa175f86c 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -121,4 +121,10 @@ extern s64 __ashrdi3(s64, int);
 extern int __cmpdi2(s64, s64);
 extern int __ucmpdi2(u64, u64);
 
+/* Patch sites */
+extern s32 patch__call_flush_count_cache;
+extern s32 patch__flush_count_cache_return;
+
+extern long flush_count_cache;
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index a0d47bc18a5c..759597bf0fd8 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -22,6 +22,7 @@ enum stf_barrier_type {
 
 void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
+void setup_count_cache_flush(void);
 
 static inline void security_ftr_set(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 11e390662384..6625cec9e7c0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -26,6 +26,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/thread_info.h>
+#include <asm/code-patching-asm.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
@@ -483,6 +484,57 @@ _GLOBAL(ret_from_kernel_thread)
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
@@ -514,6 +566,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	FLUSH_COUNT_CACHE
+
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 2f30fc8ed0a8..fd4703b6ddc0 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -9,6 +9,8 @@
 #include <linux/device.h>
 #include <linux/seq_buf.h>
 
+#include <asm/asm-prototypes.h>
+#include <asm/code-patching.h>
 #include <asm/debug.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
@@ -16,6 +18,13 @@
 
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
 
@@ -160,17 +169,29 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
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
 
@@ -327,4 +348,71 @@ static __init int stf_barrier_debugfs_init(void)
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
-- 
2.19.1



