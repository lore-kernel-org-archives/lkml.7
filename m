Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E31CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAADA20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390722AbfJ2Q7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:59:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390643AbfJ2Q7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:59:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7969A4F5;
        Tue, 29 Oct 2019 09:59:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26C623F71F;
        Tue, 29 Oct 2019 09:59:05 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCHv2 4/8] arm64: module/ftrace: intialize PLT at load time
Date:   Tue, 29 Oct 2019 16:58:28 +0000
Message-Id: <20191029165832.33606-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we lazily-initialize a module's ftrace PLT at runtime when we
install the first ftrace call. To do so we have to apply a number of
sanity checks, transiently mark the module text as RW, and perform an
IPI as part of handling Neoverse-N1 erratum #1542419.

We only expect the ftrace trampoline to point at ftrace_caller() (AKA
FTRACE_ADDR), so let's simplify all of this by intializing the PLT at
module load time, before the module loader marks the module RO and
performs the intial I-cache maintenance for the module.

Thus we can rely on the module having been correctly intialized, and can
simplify the runtime work necessary to install an ftrace call in a
module. This will also allow for the removal of module_disable_ro().

Tested by forcing ftrace_make_call() to use the module PLT, and then
loading up a module after setting up ftrace with:

| echo ":mod:<module-name>" > set_ftrace_filter;
| echo function > current_tracer;
| modprobe <module-name>

Since FTRACE_ADDR is only defined when CONFIG_DYNAMIC_FTRACE is
selected, we wrap its use along with most of module_init_ftrace_plt()
with ifdeffery rather than using IS_ENABLED().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/ftrace.c | 55 ++++++++++++----------------------------------
 arch/arm64/kernel/module.c | 32 +++++++++++++++++----------
 2 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 06e56b470315..822718eafdb4 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -73,10 +73,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	if (offset < -SZ_128M || offset >= SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-		struct plt_entry trampoline, *dst;
 		struct module *mod;
 
 		/*
+		 * There is only one ftrace trampoline per module. For now,
+		 * this is not a problem since on arm64, all dynamic ftrace
+		 * invocations are routed via ftrace_caller(). This will need
+		 * to be revisited if support for multiple ftrace entry points
+		 * is added in the future, but for now, the pr_err() below
+		 * deals with a theoretical issue only.
+		 */
+		if (addr != FTRACE_ADDR) {
+			pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
+			return -EINVAL;
+		}
+
+		/*
 		 * On kernels that support module PLTs, the offset between the
 		 * branch instruction and its target may legally exceed the
 		 * range of an ordinary relative 'bl' opcode. In this case, we
@@ -93,46 +105,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		if (WARN_ON(!mod))
 			return -EINVAL;
 
-		/*
-		 * There is only one ftrace trampoline per module. For now,
-		 * this is not a problem since on arm64, all dynamic ftrace
-		 * invocations are routed via ftrace_caller(). This will need
-		 * to be revisited if support for multiple ftrace entry points
-		 * is added in the future, but for now, the pr_err() below
-		 * deals with a theoretical issue only.
-		 *
-		 * Note that PLTs are place relative, and plt_entries_equal()
-		 * checks whether they point to the same target. Here, we need
-		 * to check if the actual opcodes are in fact identical,
-		 * regardless of the offset in memory so use memcmp() instead.
-		 */
-		dst = mod->arch.ftrace_trampoline;
-		trampoline = get_plt_entry(addr, dst);
-		if (memcmp(dst, &trampoline, sizeof(trampoline))) {
-			if (plt_entry_is_initialized(dst)) {
-				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
-				return -EINVAL;
-			}
-
-			/* point the trampoline to our ftrace entry point */
-			module_disable_ro(mod);
-			*dst = trampoline;
-			module_enable_ro(mod, true);
-
-			/*
-			 * Ensure updated trampoline is visible to instruction
-			 * fetch before we patch in the branch. Although the
-			 * architecture doesn't require an IPI in this case,
-			 * Neoverse-N1 erratum #1542419 does require one
-			 * if the TLB maintenance in module_enable_ro() is
-			 * skipped due to rodata_enabled. It doesn't seem worth
-			 * it to make it conditional given that this is
-			 * certainly not a fast-path.
-			 */
-			flush_icache_range((unsigned long)&dst[0],
-					   (unsigned long)&dst[1]);
-		}
-		addr = (unsigned long)dst;
+		addr = (unsigned long)mod->arch.ftrace_trampoline;
 #else /* CONFIG_ARM64_MODULE_PLTS */
 		return -EINVAL;
 #endif /* CONFIG_ARM64_MODULE_PLTS */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 763a86d52fef..5f5bc3b94da7 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitops.h>
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/gfp.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -485,24 +486,33 @@ static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 	return NULL;
 }
 
+int module_init_ftrace_plt(const Elf_Ehdr *hdr,
+			   const Elf_Shdr *sechdrs,
+			   struct module *mod)
+{
+#if defined(CONFIG_ARM64_MODULE_PLTS) && defined(CONFIG_DYNAMIC_FTRACE)
+	const Elf_Shdr *s;
+	struct plt_entry *plt;
+
+	s = find_section(hdr, sechdrs, ".text.ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	plt = (void *)s->sh_addr;
+	*plt = get_plt_entry(FTRACE_ADDR, plt);
+	mod->arch.ftrace_trampoline = plt;
+#endif
+	return 0;
+}
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
 	const Elf_Shdr *s;
-
 	s = find_section(hdr, sechdrs, ".altinstructions");
 	if (s)
 		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
 
-#ifdef CONFIG_ARM64_MODULE_PLTS
-	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE)) {
-		s = find_section(hdr, sechdrs, ".text.ftrace_trampoline");
-		if (!s)
-			return -ENOEXEC;
-		me->arch.ftrace_trampoline = (void *)s->sh_addr;
-	}
-#endif
-
-	return 0;
+	return module_init_ftrace_plt(hdr, sechdrs, me);
 }
-- 
2.11.0

