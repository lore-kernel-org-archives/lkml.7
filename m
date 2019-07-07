Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877DC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE80A20665
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w6E5jmHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGGKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 06:07:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfGGKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 06:07:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x67A7BhJ878509
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 7 Jul 2019 03:07:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x67A7BhJ878509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562494031;
        bh=BTIoe6/LV/oUuKF3hdxw6Flrr+1DtN5ln30LTtJEJAw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=w6E5jmHS0X3rYW1M+yaQbjJVYkjCG4uW/+fjYugVhPCdhBomuSXGy3dFlzIB8+QJN
         IfdqirlTiD5L7cIw1KHuNeodCiEGywX2GqjISBv3mwSW52tIWjpW0/QsxrKOFqNv18
         MChmUKCjWm9R1fmN9gVdfV0Nvqn/Elg7g3cvBDpQlBl0v/OhlHN0ea78wNtn7xgBYa
         JArp2cTF7LHZ2X5I9uP7Gxc5ChvSXqYSrZiTPnfaDj1WFD6NNXz0Utmn6OOPceribQ
         fc/XUl/R6pISHya5NN1pLCUiaxKx6jmpdzdoEutQunqwj3rVcgEjoTOmWYgcTB1C4E
         pzz0psSdioJ0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x67A7Ax7878506;
        Sun, 7 Jul 2019 03:07:10 -0700
Date:   Sun, 7 Jul 2019 03:07:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-9838e3bff0f92f23fcd50fe1ff1d4b3e91b8a448@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        vegard.nossum@oracle.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          vegard.nossum@oracle.com, linux-kernel@vger.kernel.org,
          bigeasy@linutronix.de
In-Reply-To: <20190703083247.57kjrmlxkai3vpw3@linutronix.de>
References: <20190703083247.57kjrmlxkai3vpw3@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Make 'no387' and 'nofxsr' command line
 options useful
Git-Commit-ID: 9838e3bff0f92f23fcd50fe1ff1d4b3e91b8a448
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9838e3bff0f92f23fcd50fe1ff1d4b3e91b8a448
Gitweb:     https://git.kernel.org/tip/9838e3bff0f92f23fcd50fe1ff1d4b3e91b8a448
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Jul 2019 10:32:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 7 Jul 2019 12:01:46 +0200

x86/fpu: Make 'no387' and 'nofxsr' command line options useful

The command line option `no387' is designed to disable the FPU
entirely. This only 'works' with CONFIG_MATH_EMULATION enabled.

But on 64bit this cannot work because user space expects SSE to work which
required basic FPU support. MATH_EMULATION does not help because SSE is not
emulated.

The command line option `nofxsr' should also be limited to 32bit because
FXSR is part of the required flags on 64bit so turning it off is not
possible.

Clearing X86_FEATURE_FPU without emulation enabled will not work anyway and
hang in fpu__init_system_early_generic() before the console is enabled.

Setting additioal dependencies, ensures that the CPU still boots on a
modern CPU. Otherwise, dropping FPU will leave FXSR enabled causing the
kernel to crash early in fpu__init_system_mxcsr().

With XSAVE support it will crash in fpu__init_cpu_xstate(). The problem is
that xsetbv() with XMM set and SSE cleared is not allowed.  That means
XSAVE has to be disabled. The XSAVE support is disabled in
fpu__init_system_xstate_size_legacy() but it is too late. It can be
removed, it has been added in commit

  1f999ab5a1360 ("x86, xsave: Disable xsave in i387 emulation mode")

to use `no387' on a CPU with XSAVE support.

All this happens before console output.

After hat, the next possible crash is in RAID6 detect code because MMX
remained enabled. With a 3DNOW enabled config it will explode in memcpy()
for instance due to kernel_fpu_begin() but this is unconditionally enabled.

This is enough to boot a Debian Wheezy on a 32bit qemu "host" CPU which
supports everything up to XSAVES, AVX2 without 3DNOW. Later, Debian
increased the minimum requirements to i686 which means it does not boot
userland atleast due to CMOV.

After masking the additional features it still keeps SSE4A and 3DNOW*
enabled (if present on the host) but those are unused in the kernel.

Restrict `no387' and `nofxsr' otions to 32bit only. Add dependencies for
FPU, FXSR to additionaly mask CMOV, MMX, XSAVE if FXSR or FPU is cleared.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190703083247.57kjrmlxkai3vpw3@linutronix.de

---
 arch/x86/kernel/cpu/cpuid-deps.c |  5 +++++
 arch/x86/kernel/fpu/init.c       | 17 +++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..e794e3860fc8 100644
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
index ef0030e3fe6b..5baae74af4f9 100644
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
