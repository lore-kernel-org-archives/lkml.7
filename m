Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB29C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C2920675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UgjqXsM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFVJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:58:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:58:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M9w46o2091252
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 02:58:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M9w46o2091252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197485;
        bh=Zb1aczCSwjeM4FnlWDbA0IIgq4qu93j8a+0qITByBbs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UgjqXsM/7giP8e/TwMucE7Qmt5pVw/4Jrbik+zwCKvseCJARmF3mc1pzKVp5SiP/X
         /WaC8UfbsbwSHz/jx1wMD3t0y4lQu7GEyIpOEPEhumEB0PlXWezDshQcLwX/L4603q
         kFoj5/qZw0oQ+wX2yFLh9y5T3N2MICk7fuB0ZDdiZ7wf3l8EWi6s3qsZPO2WcDxqR7
         EB/+dZOps3mHfdRcduPmRgbIFLiWALe5P6X0lZ0utqKg2zHPTdxESSmGuCoecV7Gdz
         2hM172kO4GhQ5n+WLxef+0lpJwVq1jIMT3zEr2RPCzRIgF5IO+MTrQJ+L1gCxsHqXk
         f6cRVWxr5X2rw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M9w3M72091249;
        Sat, 22 Jun 2019 02:58:03 -0700
Date:   Sat, 22 Jun 2019 02:58:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-873d50d58f67ef15d2777b5e7f7a5268bb1fbae2@git.kernel.org>
Cc:     keescook@chromium.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          dave.hansen@intel.com, linux-kernel@vger.kernel.org,
          keescook@chromium.org, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org
In-Reply-To: <20190618045503.39105-3-keescook@chromium.org>
References: <20190618045503.39105-3-keescook@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Pin sensitive CR4 bits
Git-Commit-ID: 873d50d58f67ef15d2777b5e7f7a5268bb1fbae2
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

Commit-ID:  873d50d58f67ef15d2777b5e7f7a5268bb1fbae2
Gitweb:     https://git.kernel.org/tip/873d50d58f67ef15d2777b5e7f7a5268bb1fbae2
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 17 Jun 2019 21:55:02 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:55:22 +0200

x86/asm: Pin sensitive CR4 bits

Several recent exploits have used direct calls to the native_write_cr4()
function to disable SMEP and SMAP before then continuing their exploits
using userspace memory access.

Direct calls of this form can be mitigate by pinning bits of CR4 so that
they cannot be changed through a common function. This is not intended to
be a general ROP protection (which would require CFI to defend against
properly), but rather a way to avoid trivial direct function calling (or
CFI bypasses via a matching function prototype) as seen in:

https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
(https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)

The goals of this change:

 - Pin specific bits (SMEP, SMAP, and UMIP) when writing CR4.

 - Avoid setting the bits too early (they must become pinned only after
   CPU feature detection and selection has finished).

 - Pinning mask needs to be read-only during normal runtime.

 - Pinning needs to be checked after write to validate the cr4 state

Using __ro_after_init on the mask is done so it can't be first disabled
with a malicious write.

Since these bits are global state (once established by the boot CPU and
kernel boot parameters), they are safe to write to secondary CPUs before
those CPUs have finished feature detection. As such, the bits are set at
the first cr4 write, so that cr4 write bugs can be detected (instead of
silently papered over). This uses a few bytes less storage of a location we
don't have: read-only per-CPU data.

A check is performed after the register write because an attack could just
skip directly to the register write. Such a direct jump is possible because
of how this function may be built by the compiler (especially due to the
removal of frame pointers) where it doesn't add a stack frame (function
exit may only be a retq without pops) which is sufficient for trivial
exploitation like in the timer overwrites mentioned above).

The asm argument constraints gain the "+" modifier to convince the compiler
that it shouldn't make ordering assumptions about the arguments or memory,
and treat them as changed.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: kernel-hardening@lists.openwall.com
Link: https://lkml.kernel.org/r/20190618045503.39105-3-keescook@chromium.org

---
 arch/x86/include/asm/special_insns.h | 22 +++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         | 20 ++++++++++++++++++++
 arch/x86/kernel/smpboot.c            |  8 +++++++-
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0a3c4cab39db..c8c8143ab27b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -6,6 +6,8 @@
 #ifdef __KERNEL__
 
 #include <asm/nops.h>
+#include <asm/processor-flags.h>
+#include <linux/jump_label.h>
 
 /*
  * Volatile isn't enough to prevent the compiler from reordering the
@@ -16,6 +18,10 @@
  */
 extern unsigned long __force_order;
 
+/* Starts false and gets enabled once CPU feature detection is done. */
+DECLARE_STATIC_KEY_FALSE(cr_pinning);
+extern unsigned long cr4_pinned_bits;
+
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
@@ -74,7 +80,21 @@ static inline unsigned long native_read_cr4(void)
 
 static inline void native_write_cr4(unsigned long val)
 {
-	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
+			bits_missing = ~val & cr4_pinned_bits;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
+			  bits_missing);
+	}
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..c578addfcf8a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,6 +366,25 @@ out:
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+EXPORT_SYMBOL(cr_pinning);
+unsigned long cr4_pinned_bits __ro_after_init;
+EXPORT_SYMBOL(cr4_pinned_bits);
+
+/*
+ * Once CPU feature detection is finished (and boot params have been
+ * parsed), record any of the sensitive CR bits that are set, and
+ * enable CR pinning.
+ */
+static void __init setup_cr_pinning(void)
+{
+	unsigned long mask;
+
+	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
+	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
+	static_key_enable(&cr_pinning.key);
+}
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1464,6 +1483,7 @@ void __init identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
+	setup_cr_pinning();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd8953f48..1af7a2d89419 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -205,13 +205,19 @@ static int enable_start_cpu0;
  */
 static void notrace start_secondary(void *unused)
 {
+	unsigned long cr4 = __read_cr4();
+
 	/*
 	 * Don't put *anything* except direct CPU state initialization
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
 	if (boot_cpu_has(X86_FEATURE_PCID))
-		__write_cr4(__read_cr4() | X86_CR4_PCIDE);
+		cr4 |= X86_CR4_PCIDE;
+	if (static_branch_likely(&cr_pinning))
+		cr4 |= cr4_pinned_bits;
+
+	__write_cr4(cr4);
 
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */
