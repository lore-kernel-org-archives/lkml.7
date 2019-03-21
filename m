Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E29EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7148A21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfCUWBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:53200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfCUWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357233"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1157830217F; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 02/17] x86, lto: Mark all top level asm statements as .text
Date:   Thu, 21 Mar 2019 14:59:54 -0700
Message-Id: <20190321220009.29334-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

With gcc 8 toplevel assembler statements that do not mark themselves
as .text may end up in other sections. I had boot crashes because
various assembler statements ended up in the middle of the initcall
section.

Always mark all the top level assembler statements as text
so that they switch to the right section.

For AMD "vide", which is only used on 32bit kernels, I also
marked it as 32bit only.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/paravirt_types.h | 2 +-
 arch/x86/kernel/cpu/amd.c             | 5 ++++-
 arch/x86/kernel/kprobes/core.c        | 1 +
 arch/x86/lib/error-inject.c           | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..e246577a643b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -372,7 +372,7 @@ extern struct paravirt_patch_template pv_ops;
 
 #define DEF_NATIVE(ops, name, code)					\
 	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
+	asm(".text\n\t" NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 01004bfb1a1b..fb6a64bd765f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -82,11 +82,14 @@ static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
  *	performance at the same time..
  */
 
+#ifdef CONFIG_X86_32
 extern __visible void vide(void);
-__asm__(".globl vide\n"
+__asm__(".text\n"
+	".globl vide\n"
 	".type vide, @function\n"
 	".align 4\n"
 	"vide: ret\n");
+#endif
 
 static void init_amd_k5(struct cpuinfo_x86 *c)
 {
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..31ab91c9c4e9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -715,6 +715,7 @@ NOKPROBE_SYMBOL(kprobe_int3_handler);
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
  */
 asm(
+	".text\n"
 	".global kretprobe_trampoline\n"
 	".type kretprobe_trampoline, @function\n"
 	"kretprobe_trampoline:\n"
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 3cdf06128d13..be5b5fb1598b 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -6,6 +6,7 @@
 asmlinkage void just_return_func(void);
 
 asm(
+	".text\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
-- 
2.20.1

