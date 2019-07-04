Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D47C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BEE218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGDGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:07:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:07:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiuuG-0003Il-27; Thu, 04 Jul 2019 08:07:44 +0200
Date:   Thu, 4 Jul 2019 08:07:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] x86/fpu: Inline fpu__xstate_clear_all_cpu_caps()
Message-ID: <20190704060743.rvew4yrjd6n33uzx@linutronix.de>
References: <20190702213958.33291-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
 <20190703083247.57kjrmlxkai3vpw3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703083247.57kjrmlxkai3vpw3@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All fpu__xstate_clear_all_cpu_caps() does is to invoke one simple
function since commit

  73e3a7d2a7c3b ("x86/fpu: Remove the explicit clearing of XSAVE dependent features")

so it will be better to simply invoke that function directly.

Inline fpu__xstate_clear_all_cpu_caps().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/fpu/init.c        |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 11 +----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7e42b285c8562..c6136d79f8c07 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,7 +47,6 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
-void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 5baae74af4f91..6ce7e0a23268f 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -259,7 +259,7 @@ static void __init fpu__init_parse_early_param(void)
 #endif
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		fpu__xstate_clear_all_cpu_caps();
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3c36dd1784db6..7b4c52aa929fb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -67,15 +67,6 @@ static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
  */
 unsigned int fpu_user_xstate_size;
 
-/*
- * Clear all of the X86_FEATURE_* bits that are unavailable
- * when the CPU has no XSAVE support.
- */
-void fpu__xstate_clear_all_cpu_caps(void)
-{
-	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-}
-
 /*
  * Return whether the system supports a given xfeature.
  *
@@ -709,7 +700,7 @@ static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
-	fpu__xstate_clear_all_cpu_caps();
+	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
 
 /*
-- 
2.20.1

