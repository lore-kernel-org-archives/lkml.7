Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8492070B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfC3Ary (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:47:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:49819 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbfC3Arw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="138481251"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2019 17:47:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D59E5301BE3; Fri, 29 Mar 2019 17:47:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/9] x86/asm: Mark all top level asm statements as .text
Date:   Fri, 29 Mar 2019 17:47:35 -0700
Message-Id: <20190330004743.29541-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

With gcc toplevel assembler statements that do not mark themselves
as .text may end up in other sections. I had LTO boot crashes because
various assembler statements ended up in the middle of the initcall
section. It's also a latent problem without LTO, although it's
currently not known to cause any real problems.

According to the gcc team it's expected behavior.

Always mark all the top level assembler statements as text
so that they switch to the right section.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/amd.c      | 3 ++-
 arch/x86/kernel/kprobes/core.c | 1 +
 arch/x86/lib/error-inject.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 01004bfb1a1b..1bcb489e07e7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -83,7 +83,8 @@ static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
  */
 
 extern __visible void vide(void);
-__asm__(".globl vide\n"
+__asm__(".text\n"
+	".globl vide\n"
 	".type vide, @function\n"
 	".align 4\n"
 	"vide: ret\n");
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

