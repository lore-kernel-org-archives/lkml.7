Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C742ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfJUQfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:35:05 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57580 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfJUQfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A7611B3;
        Mon, 21 Oct 2019 09:34:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF0613F71F;
        Mon, 21 Oct 2019 09:34:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 3/8] arm64: module: rework special section handling
Date:   Mon, 21 Oct 2019 17:34:21 +0100
Message-Id: <20191021163426.9408-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we load a module, we have to perform some special work for a couple
of named sections. To do this, we iterate over all of the module's
sections, and perform work for each section we recognize.

To make it easier to handle the unexpected absence of a section, and to
make the section-specific logic easer to read, let's factor the section
search into a helper. Similar is already done in the core module loader,
and other architectures (and ideally we'd unify these in future).

If we expect a module to have an ftrace trampoline section, but it
doesn't have one, we'll now reject loading the module. When
ARM64_MODULE_PLTS is selected, any correctly built module should have
one (and this is assumed by arm64's ftrace PLT code) and the absence of
such a section implies something has gone wrong at build time.

Subsequent patches will make use of the new helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Bieshsheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/module.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 03ff15bffbb6..763a86d52fef 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -470,22 +470,39 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	return -ENOEXEC;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
+				    const Elf_Shdr *sechdrs,
+				    const char *name)
 {
 	const Elf_Shdr *s, *se;
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
-		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0)
-			apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	const Elf_Shdr *s;
+
+	s = find_section(hdr, sechdrs, ".altinstructions");
+	if (s)
+		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+
 #ifdef CONFIG_ARM64_MODULE_PLTS
-		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
-		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
-			me->arch.ftrace_trampoline = (void *)s->sh_addr;
-#endif
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE)) {
+		s = find_section(hdr, sechdrs, ".text.ftrace_trampoline");
+		if (!s)
+			return -ENOEXEC;
+		me->arch.ftrace_trampoline = (void *)s->sh_addr;
 	}
+#endif
 
 	return 0;
 }
-- 
2.11.0

