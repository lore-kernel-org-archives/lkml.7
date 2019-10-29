Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F901208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403777AbfJ2Q72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:59:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390802AbfJ2Q72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:59:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8347AD;
        Tue, 29 Oct 2019 09:59:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B57C3F71F;
        Tue, 29 Oct 2019 09:59:24 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCHv2 8/8] arm64: ftrace: minimize ifdeffery
Date:   Tue, 29 Oct 2019 16:58:32 +0000
Message-Id: <20191029165832.33606-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we no longer refer to mod->arch.ftrace_trampolines in the body
of ftrace_make_call(), we can use IS_ENABLED() rather than ifdeffery,
and make the code easier to follow. Likewise in ftrace_make_nop().

Let's do so.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/ftrace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index aea652c33a38..8618faa82e6d 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -62,18 +62,18 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-#ifdef CONFIG_ARM64_MODULE_PLTS
 static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 {
+#ifdef CONFIG_ARM64_MODULE_PLTS
 	struct plt_entry *plt = mod->arch.ftrace_trampolines;
 
 	if (addr == FTRACE_ADDR)
 		return &plt[FTRACE_PLT_IDX];
 	if (addr == FTRACE_REGS_ADDR && IS_ENABLED(CONFIG_FTRACE_WITH_REGS))
 		return &plt[FTRACE_REGS_PLT_IDX];
+#endif
 	return NULL;
 }
-#endif
 
 /*
  * Turn on the call to ftrace_caller() in instrumented function
@@ -85,10 +85,12 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	long offset = (long)pc - (long)addr;
 
 	if (offset < -SZ_128M || offset >= SZ_128M) {
-#ifdef CONFIG_ARM64_MODULE_PLTS
 		struct module *mod;
 		struct plt_entry *plt;
 
+		if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
+			return -EINVAL;
+
 		/*
 		 * On kernels that support module PLTs, the offset between the
 		 * branch instruction and its target may legally exceed the
@@ -113,9 +115,6 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		}
 
 		addr = (unsigned long)plt;
-#else /* CONFIG_ARM64_MODULE_PLTS */
-		return -EINVAL;
-#endif /* CONFIG_ARM64_MODULE_PLTS */
 	}
 
 	old = aarch64_insn_gen_nop();
@@ -185,9 +184,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	long offset = (long)pc - (long)addr;
 
 	if (offset < -SZ_128M || offset >= SZ_128M) {
-#ifdef CONFIG_ARM64_MODULE_PLTS
 		u32 replaced;
 
+		if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
+			return -EINVAL;
+
 		/*
 		 * 'mod' is only set at module load time, but if we end up
 		 * dealing with an out-of-range condition, we can assume it
@@ -218,9 +219,6 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 			return -EINVAL;
 
 		validate = false;
-#else /* CONFIG_ARM64_MODULE_PLTS */
-		return -EINVAL;
-#endif /* CONFIG_ARM64_MODULE_PLTS */
 	} else {
 		old = aarch64_insn_gen_branch_imm(pc, addr,
 						  AARCH64_INSN_BRANCH_LINK);
-- 
2.11.0

