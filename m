Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4143FC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEE82189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGCIcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:32:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfGCIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:32:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiah5-0006oW-75; Wed, 03 Jul 2019 10:32:47 +0200
Date:   Wed, 3 Jul 2019 10:32:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] x86/fpu: Make no387 and nofxsr work a little better on
 modern CPUs
Message-ID: <20190703083247.57kjrmlxkai3vpw3@linutronix.de>
References: <20190702213958.33291-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command line option `no387' is designed to disable the FPU entirely.
The documentation says to disable the coprocessor and the Kconfig entry
for MATH_EMULATION says to set it in order to use emulation. It should
be restricted to 32bit only because 64bit expect SSE (which includes
basic FPU and there is not emulation for SSE).

The command line option `nofxsr' should also be limited to 32bit because
FXSR is part of the required flags on 64bit so turning it off is not
possible.

Clearing X86_FEATURE_FPU without emulation enabled will not work anyway
and hang in fpu__init_system_early_generic() before console is enabled.

Setting additioal dependencies, ensures that the CPU still boots on a
modern CPU. Otherwise, dropping FPU will leave FXSR enabled causing the
kernel to crash early in fpu__init_system_mxcsr().
With XSAVE support it will crash in fpu__init_cpu_xstate(). The problem
is that xsetbv() with YMM set and SSE cleared is not allowed.  That
means XSAVE has to be disabled. The XSAVE support is disabled in
fpu__init_system_xstate_size_legacy() but it is too late. It can be
removed, it has been added in commit

  1f999ab5a1360 ("x86, xsave: Disable xsave in i387 emulation mode")

to use `no387' on a CPU with XSAVE support.

All this happens before console output.
After hat, the next possible crash is in RAID6 detect code because MMX
remained enabled. With a 3DNOW enabled config it will explode in
memcpy() for instance due to kernel_fpu_begin() but this is
unconditionally enabled.

This is enough to boot a Debian Wheezy on a 32bit qemu "host" CPU which
supports everything up to XSAVES, AVX2 without 3DNOW. Later, Debian
increased the minimum requirements to i686 which means it does not boot
userland atleast due to CMOV.

After masking the additional features it still keeps SSE4A and 3DNOW*
enabled (if present on the host) but those are unused in the kernel.

Restrict `no387' and `nofxsr' otions to 32bit only. Add dependencies for
FPU, FXSR to additionaly mask CMOV, MMX, XSAVE if FXSR or FPU is cleared.

Link: https://lkml.kernel.org/r/20190701121710.vardxktdc63gtcj5@linutronix.de>
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/cpuid-deps.c |  5 +++++
 arch/x86/kernel/fpu/init.c       | 17 +++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab1..e794e3860fc83 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -20,6 +20,7 @@ struct cpuid_dep {
  * but it's difficult to tell that to the init reference checker.
  */
 static const struct cpuid_dep cpuid_deps[] = {
+	{ X86_FEATURE_FXSR,		X86_FEATURE_FPU	      },
 	{ X86_FEATURE_XSAVEOPT,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVEC,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVES,		X86_FEATURE_XSAVE     },
@@ -27,7 +28,11 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_PKU,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_MPX,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XGETBV1,		X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_CMOV,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMX,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMXEXT,		X86_FEATURE_MMX       },
 	{ X86_FEATURE_FXSR_OPT,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_XSAVE,		X86_FEATURE_FXSR      },
 	{ X86_FEATURE_XMM,		X86_FEATURE_FXSR      },
 	{ X86_FEATURE_XMM2,		X86_FEATURE_XMM       },
 	{ X86_FEATURE_XMM3,		X86_FEATURE_XMM2      },
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ef0030e3fe6b9..5baae74af4f91 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -204,12 +204,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 */
 
 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
-		/*
-		 * Disable xsave as we do not support it if i387
-		 * emulation is enabled.
-		 */
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
 		fpu_kernel_xstate_size = sizeof(struct swregs_state);
 	} else {
 		if (boot_cpu_has(X86_FEATURE_FXSR))
@@ -252,14 +246,17 @@ static void __init fpu__init_parse_early_param(void)
 	char *argptr = arg;
 	int bit;
 
+#ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
 		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
 
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
 		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
-		setup_clear_cpu_cap(X86_FEATURE_XMM);
-	}
+#endif
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
 		fpu__xstate_clear_all_cpu_caps();
-- 
2.20.1

