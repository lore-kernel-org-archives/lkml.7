Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6155C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58102089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfGCBCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:02:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:26635 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGCBCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:02:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 14:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,444,1557212400"; 
   d="scan'208";a="157772176"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2019 14:40:03 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F34F3301004; Tue,  2 Jul 2019 14:40:02 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/fpu: Fix nofxsr regression
Date:   Tue,  2 Jul 2019 14:39:58 -0700
Message-Id: <20190702213958.33291-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Vegard Nossum reports:

The commit for this patch in mainline
(ccb18db2ab9d ("x86/fpu: Make XSAVE check ...")) causes the kernel to hang on
boot when passing the "nofxsr" option:

$ kvm -cpu host -kernel arch/x86/boot/bzImage -append "console=ttyS0 nofxsr
earlyprintk=ttyS0" -serial stdio -display none -smp 2
early console in extract_kernel
input_data: 0x0000000001dea276
input_len: 0x0000000000500704
output: 0x0000000001000000
output_len: 0x00000000012c79b4
kernel_total_size: 0x0000000000f24000
booted via startup_32()
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
[..hang..]

<<<

Sebastian Siewior did the following analysis:

as a result of nofxsr we do:
[0]     setup_clear_cpu_cap(X86_FEATURE_FXSR);
[1]     setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
[2]     setup_clear_cpu_cap(X86_FEATURE_XMM);

the commit in question removes then XFEATURE_MASK_SSE from
`xfeatures_mask'.
Boot stops in fpu__init_cpu_xstate() / xsetbv() due to #GP:
|If an attempt is made to set XCR0[2:1] to 10b.
(from Vol. 2C).

[1] is "harmless". Dropping [2] does not fix the issue because [0]
still clears all three flags due to
| static const struct cpuid_dep cpuid_deps[] = {
…
|      { X86_FEATURE_XMM,              X86_FEATURE_FXSR      },

Clearing additionally XMM2 (and adding the missing bits to
xsave_cpuid_features/xfeature_names) would boot further.
Later it crashes in raid6 while probing for AVX/2 code…

Disabling XMM+XMM2 in order get (and fixing it up for AVX+AVX2) would
give use XSAVE instead of FSAVE.
This won't work on 64bit userland because it expects SSE to be around
(and FXSR to save the SSE bits).
Even my 32bit Debian Wheezy doesn't work because it wants FXSR :)

So if it is unlikely to have XSAVE but no FXSR I would suggest to add
"fpu__xstate_clear_all_cpu_caps()" to nofxsr and behave like "nofxsr
noxsave".

<<<

Also nofxsr is useless on 64bit kernels because 64bit user space
always uses SSE2, and without FXSR there is no SSE support.

This patch:
- Makes nofxsr 32bit only
It was already documented to be 32bit only, but not implemented this
way.

- Implements Sebastian's suggestion of calling
fpu__xstate_clear_all_cpu_caps() for nofxsr to clear all depending
bits.

With this a 32bit kernel boots on qemu with nofxsr upto user space
crashing (I don't have a 32bit image that doesn't need SSE2),
and a 64bit kernel also fully boots with nofxsr (by ignoring
the option)

Fixes: ccb18db2ab9d ("x86/fpu: Make XSAVE check ...)
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/fpu/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ef0030e3fe6b..81c730af7454 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -255,7 +255,9 @@ static void __init fpu__init_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
 		setup_clear_cpu_cap(X86_FEATURE_FPU);
 
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
+	if (!IS_ENABLED(CONFIG_64BIT) &&
+		cmdline_find_option_bool(boot_command_line, "nofxsr")) {
+		fpu__xstate_clear_all_cpu_caps();
 		setup_clear_cpu_cap(X86_FEATURE_FXSR);
 		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
 		setup_clear_cpu_cap(X86_FEATURE_XMM);
-- 
2.20.1

